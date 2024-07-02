Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0FDC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCD-0006Ie-2l; Tue, 02 Jul 2024 10:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC1-0005mz-LY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBp-0008GL-ND
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=L2QZwgdckfuL4YiVA+uHMpDnu5sjoNXgHtcGe8rR/a2Hj14jCHCPcgCMzxHjv1Bl8ZR/sA
 huuYhK8fXpxBw5yu+9oiyLsif1DPjlcTFVN2VczmbvugJ+qyelBuzYkPsZGMcvxskQn8mZ
 d2SkZW9qARsrc9ZyM66G/Oggct3WeJA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Z3lPNtdkNJSmjaRw-mX6vg-1; Tue, 02 Jul 2024 10:08:54 -0400
X-MC-Unique: Z3lPNtdkNJSmjaRw-mX6vg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52cdaae5b3dso4121925e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929332; x=1720534132;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4UiaVaJHqFRMzcgj8Lsoa2O3CKB9KU5Hs0p0vn09PA=;
 b=KbEzMeOXUyO0vw7iUSRk1wUnv1fS068oHbpLpfD+aHBIXVjjIAtOB9zn34xtkSMN7H
 qOVBCFY/SnaKxXrkcOk0TaJXtCU6/R7rqiX25rumdCmkHj0uFnLYgHDVeKF4Hd1+Jbhj
 z2qzaebGMyt5hS5ZH/7BLHfOXRrjgnzV94zbQqsQ/vYHXEcc4qAEzDi+//Yiv3n4d0ip
 CMtXE6y0oC4a6NADjyide/CBKzAbGGEYtbbomcKAno9maWTc3y5wyO/e2t7KJ/jrW3Lq
 ASV/XMQuI09mdd8aS9qWQUeE+5irbbODePOAz/Kxejb93hsRPNOB9lk69B/gB1GhnVw2
 JrOA==
X-Gm-Message-State: AOJu0YxKLulPqVbpN0GeTGlwZlWKHBDaS1IQxApPAzSDOFPdO966MAD6
 Cez0ONcuqjZ7tBrk6rdj07lhoVxra5oUg90QiAW+SUFLusRrcb1EB4dv7p0btGtMREAEYnuHEyJ
 9ELDjEQNo6ULT0q2nZH3Av5ArX/EcjBZap7b34v7n8egPk4iUS6GErx/R72PKrQfhp6k6a7zktl
 jSnMJncjgmV71OGLVYdZfJwJ1nzMnkZw==
X-Received: by 2002:a05:6512:acc:b0:52c:e180:4eac with SMTP id
 2adb3069b0e04-52e8264bbd4mr6138112e87.9.1719929331771; 
 Tue, 02 Jul 2024 07:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuX90VK8ksXbSxePclulwPa6zXZIh2on3nP5rDXVK+qd4OEkkGV/CINRLPnRVfcg2VU7SIFw==
X-Received: by 2002:a05:6512:acc:b0:52c:e180:4eac with SMTP id
 2adb3069b0e04-52e8264bbd4mr6138087e87.9.1719929331216; 
 Tue, 02 Jul 2024 07:08:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af59732sm200523615e9.11.2024.07.02.07.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:50 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/91] Revert "docs/specs/pvpanic: mark shutdown event as not
 implemented"
Message-ID: <0c0cc13d319cf7b876f327fa1c5cc1866ad868cc.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

The missing functionality has been implemented now.

This reverts commit e739d1935c461d0668057e9dbba9d06f728d29ec.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-8-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pvpanic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index b0f27860ec..61a80480ed 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,7 +29,7 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
-bit 2 (to be implemented)
+bit 2
   a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
-- 
MST


