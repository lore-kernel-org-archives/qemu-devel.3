Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6E4C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFO-0005bo-2B; Wed, 14 Feb 2024 06:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEc-00049d-Dh
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEZ-0007E9-Dt
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bo/qBucH+tKMVpBd3eDGN9ZyJTB3hA1wV1N4MxHrb0U=;
 b=Uaf8CzI3fx63uQnVtxGzRPqqsYFrgtx2CLMcAqVyf3y3A4w8VfTWwLLp93F9Ajqsf00LH0
 tX5J2K3UrpnN4Qf8To/yIfkkbclM4iKpuQSgt4pkJDFRHOFnYkW7sxUoe7UghlLjLzx9lf
 UxoOQg+42Vkahw3t3FEapmCE7cwDKBk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-1WJnv3OeOauyXkflv8LEVA-1; Wed, 14 Feb 2024 06:15:21 -0500
X-MC-Unique: 1WJnv3OeOauyXkflv8LEVA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a27eddc1c27so115480366b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909320; x=1708514120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo/qBucH+tKMVpBd3eDGN9ZyJTB3hA1wV1N4MxHrb0U=;
 b=LbCMcVg32PSEO39tT4KRSmmu76AFUvXLcIOzIVstypgveVHmuMhbt5+nGZqV/hIyz4
 Wfs/dasQcs0TW+jZHAOss4lX7nl29WLVUXYVlGo7y5SLnCE8QGVjmDORYbLeQOs/N7sx
 V5wkgIXGdViwgFv5nyNkUtT8+1p7iDS5y1CcwOWYxQAivRhzit0GYv/O/wLs3D5ie0De
 aKusPKIIf88WpZp61Z282SGHb9mu0iHwEDUq4n5Fi4QOzy4pCNUnc81A/DJXI4fT8/BC
 bwPzrqfCiCG7GouOP459bzu0cS7r/LaWQXKDQwI8SE2gDWwlptt7/rIqF2FSjzNphmty
 x28g==
X-Gm-Message-State: AOJu0Yx7VxNskBiXff05AYw7nHFj07c0oyHxFUxoKz2jbHV9DRXOOevD
 bkMwlvZznP5c958TCGs4CabJSrhig2lWLTztHJ91kdyg6Rf3fpEuglsHsgSclcUzo/nUOk3TpiX
 nWJCdS9dUS2bj6uxYX1MD6yTJ8Ovnl/UNfkbpzdIG7+JtCs9m4N+c2Ph4Or2aJfaixlYvIM3dz3
 LbdTSkjsEzPyyxQ4Jnot1k80WgbxCThw==
X-Received: by 2002:a17:906:af10:b0:a3c:9470:219a with SMTP id
 lx16-20020a170906af1000b00a3c9470219amr1421956ejb.4.1707909320086; 
 Wed, 14 Feb 2024 03:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIItT0vSBnI/VNaQMQ8THnGTciax+ed9AyIyfD/+yMHA+42lf955ymmlXXo/xOZsZvkmNgZQ==
X-Received: by 2002:a17:906:af10:b0:a3c:9470:219a with SMTP id
 lx16-20020a170906af1000b00a3c9470219amr1421942ejb.4.1707909319759; 
 Wed, 14 Feb 2024 03:15:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWlgJGayyRIh7l1OIdr3ZYPw/U7Jgsn0yX1d9gT9AzGiAUDWG2UZUTlMxKsB4tXDtxwoYIRPSYqRBrxKLAGn0rv58StVet5zmaPEptnnUR8xTj4RQab26uVS3sQfcGfxxmsdOzDmBQv
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vx1-20020a170907a78100b00a3d014fa12esm1546223ejc.196.2024.02.14.03.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:19 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 39/60] hw/pci-bridge/cxl_upstream: Drop g_malloc() failure
 handling
Message-ID: <99747b71baf278068b5938ccdc66d6c906ed437e.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As a failure of g_malloc() will result in QEMU exiting, it
won't return a NULL to check.  As such, drop the incorrect handling
of such NULL returns in the cdat table building code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/cxl_upstream.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 36737189c6..d5341b530f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -228,9 +228,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     sslbis_size = sizeof(CDATSslbis) + sizeof(*sslbis_latency->sslbe) * count;
     sslbis_latency = g_malloc(sslbis_size);
-    if (!sslbis_latency) {
-        return -ENOMEM;
-    }
     *sslbis_latency = (CDATSslbis) {
         .sslbis_header = {
             .header = {
@@ -251,9 +248,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     sslbis_bandwidth = g_malloc(sslbis_size);
-    if (!sslbis_bandwidth) {
-        return 0;
-    }
     *sslbis_bandwidth = (CDATSslbis) {
         .sslbis_header = {
             .header = {
-- 
MST


