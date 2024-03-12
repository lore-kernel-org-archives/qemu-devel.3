Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E626C54E69
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeG-0006Ul-EV; Tue, 12 Mar 2024 18:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcG-0002rc-Pg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAc6-0004bn-Gf
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+KmS4ZjhMpglK5yf3m23Viq3SpbBkSkvKu7CqYvcy0=;
 b=PSirbAlGDkovQUQDNlLEzJPL6q+oUzOcEizgccJXzZTT1prjg7fImExjl53EO8oIEPJpqy
 FMwulPDQCniEv8dJumBM+2wSZJc0I4LGWCSoke4Z4FLk3GWXAr4bIoTjjJ40UjtGh/e+Pt
 Esy4wBccP0htKRtEjt1+jrUBy/lmqwQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Dr4quDAbOkC9A4Ca48DfrQ-1; Tue, 12 Mar 2024 18:28:47 -0400
X-MC-Unique: Dr4quDAbOkC9A4Ca48DfrQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513332823cfso6021450e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282526; x=1710887326;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+KmS4ZjhMpglK5yf3m23Viq3SpbBkSkvKu7CqYvcy0=;
 b=Nm4Yte1qCcLZ9jujALwaQVq9berGs1edpur1fgIvapk+b8Xky7VOIKYaTkoR//dEp+
 xZAMqrNXBiKti/wwB/qDn9hNIn7glmPqbf9TtZcGluhhWtCgPv0ohOT89TnYg6rCpmso
 +DA379YzHB95fbbJ3MvKd7hHg69HMTlza+ED8hQ+bPcbTQF+r2hT1sOImgmn71r7Dz/V
 Qv+Dehh+4x4S2X55QJ82PcoatZDYNyvfTj9ox1s29v5tPNNnIulPSHKVIxGBTdeDj3vc
 3TGGVvmGvB9Z3HSb63r0dUOTWhvdce/SCumShdVMIHaabFNhbzmj4NBtSfMyOANs6a+x
 F3RQ==
X-Gm-Message-State: AOJu0YzXseb+K9hTfG5gBxBfLAUCbwn0ZhBskUGwkYfL+po0l7zD3occ
 8BnDsxENoxsy2VzNOUeILuK4FvXU9paBAPILH5Nb96Kd2fokrfTlB01Ge65bd0YUPk4SNEuyThZ
 bACGdy4IJ2YahXitrvRMOnPNgQ8qk1Cz8LAnqSV4aVuj8DbCkuolPAUsFM9IWvFovfEC+LSfl8e
 NonaTbxEdKUnyk5B6f1xHcEJu85TsQmm9P
X-Received: by 2002:a19:f706:0:b0:513:9e39:e8b7 with SMTP id
 z6-20020a19f706000000b005139e39e8b7mr2232214lfe.16.1710282525913; 
 Tue, 12 Mar 2024 15:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo3qlAKiLGgeTkL9KtX7dBkt5NvQ6u03phXTDQ8n4klSi8/G06Mw7YCVgp5Fpf9JdaR+4MKg==
X-Received: by 2002:a19:f706:0:b0:513:9e39:e8b7 with SMTP id
 z6-20020a19f706000000b005139e39e8b7mr2232195lfe.16.1710282525378; 
 Tue, 12 Mar 2024 15:28:45 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 p26-20020a170906b21a00b00a4655a71a27sm73803ejz.163.2024.03.12.15.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:45 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 59/68] qemu-options.hx: Document the virtio-iommu-pci granule
 option
Message-ID: <695012903f99d42c03a5bc87fe24f591b6bf7153.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

We are missing an entry for the virtio-iommu-pci device. Add the
information on which machine it is currently supported and document
the new granule option.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20240307134445.92296-5-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 937fd7ed84..c6f3d2e76d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1172,6 +1172,14 @@ SRST
     Please also refer to the wiki page for general scenarios of VT-d
     emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
 
+``-device virtio-iommu-pci[,option=...]``
+    This is only supported by ``-machine q35`` (x86_64) and ``-machine virt`` (ARM).
+    It supports below options:
+
+    ``granule=val`` (possible values are 4k, 8k, 16k, 64k and host; default: host)
+        This decides the default granule to be be exposed by the
+        virtio-iommu. If host, the granule matches the host page size.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
MST


