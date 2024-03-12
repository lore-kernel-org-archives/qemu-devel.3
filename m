Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D8CC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeK-0006aX-Am; Tue, 12 Mar 2024 18:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcX-0002v0-3G
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcL-0004dc-MK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rXUT31BNk1l3JXvgoTOKQhMWbk4Q8QKbLyl08Dff9k=;
 b=fSJjp1BoofDqCCRRbH1JYkhfJivwsKecF9arYMAsH61BAqU0PTGr3c68wr5mJZuM73AULQ
 7saq1tiMje5c3eUDubnf6SpTCip3vyX/ZHImhEbNK2VtImyvF9TY6NIMGa5gr+VZseqjwm
 eHQNn7EgWoCYyNWL3R2bR6zV23r1TwY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-YGNiLGBwNZ-zO9lm4FCM8w-1; Tue, 12 Mar 2024 18:29:03 -0400
X-MC-Unique: YGNiLGBwNZ-zO9lm4FCM8w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5686eca9cc8so939193a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282542; x=1710887342;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rXUT31BNk1l3JXvgoTOKQhMWbk4Q8QKbLyl08Dff9k=;
 b=VuF9D0OBH+UiTGlsnP0ijHzypdcE9QxFG1dJDNe4XPBUcPCiKlDQ2ed6uz+AdPtBra
 LcLeIzWBWUZSB6apJcInPO2ccrP5w0bhW7FrA8gyoikgIyBsrysImr8xYCB/l15i0gGw
 NHYUyR2Nidg40KWNYT7QQ7aCIh9X5/MDDhWzsqMmQbA/Nq5iVnJv295bMROJhkRZgU4O
 kYXsmbB6N06j0676Ly8lVuDdXiNF57HBS+mBfVbSZEANHZuCbSfoZZk72M4rMm/GCX4i
 0W391O9p6mDNMpiiX99ZLs1jPOaNlKLIC+6kZc7afxkKxj08gFknIGJ04OuW3blUmkVk
 fxzQ==
X-Gm-Message-State: AOJu0YzsBNvtwscLIYQfdA0Hlu9BdtSkgLEFBuMzkYEJwGM1qCwaxyH6
 PlCPYuoPlXhHNdYhrTLUiXrINKA3v5RGXCPo39qSYJOhM4GZ94CKIu02uFlV8LtIiRVbtxzoEfd
 h2JigUqA9ctCbyj3gtWJ/xx5y7PY+MH0C4pDXwG1rhLB5gnpcntb3It+Gy2UDO6GakeTn65RrCh
 owa9VLa1yzXwxTsbnDiCvNP0Ei8pDvtmi6
X-Received: by 2002:a50:cc04:0:b0:568:7abc:a845 with SMTP id
 m4-20020a50cc04000000b005687abca845mr1675359edi.13.1710282541801; 
 Tue, 12 Mar 2024 15:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdAWy+qi+pbX/8Fy8qKerPwcwDYbD97DiFpkkYH5I0v0KmizK9TnucqF97EtO2mVtIir+MZQ==
X-Received: by 2002:a50:cc04:0:b0:568:7abc:a845 with SMTP id
 m4-20020a50cc04000000b005687abca845mr1675346edi.13.1710282541462; 
 Tue, 12 Mar 2024 15:29:01 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 gy4-20020a0564025bc400b0056820311668sm4336104edb.57.2024.03.12.15.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:01 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 64/68] qemu-options.hx: Document the virtio-iommu-pci aw-bits
 option
Message-ID: <f7ada75b3f7dd1369b10bac7f8297831c3a80967.1710282274.git.mst@redhat.com>
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

Document the new aw-bits option.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240307134445.92296-10-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index c6f3d2e76d..7fd1713fa8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1180,6 +1180,9 @@ SRST
         This decides the default granule to be be exposed by the
         virtio-iommu. If host, the granule matches the host page size.
 
+    ``aw-bits=val`` (val between 32 and 64, default depends on machine)
+        This decides the address width of the IOVA address space.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
MST


