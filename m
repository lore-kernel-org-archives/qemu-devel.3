Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98477C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgka-0006b9-5Q; Sun, 21 Jul 2024 20:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkX-0006LW-Ty
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkW-0005ov-Hb
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDyrc4b0PIQEqc1nWX9kZEf6YpDLGOOzQo+gBLAOsk4=;
 b=B2xFPQgdleBrJAEOw4tEZeu1urQDmTbaiwmTTnOF+TV42oaqhMAGbUsqXqDN8QjF84MJ1M
 l+USvArZ1s25oJIEeyTx88U64Ot+1JjZoNrkzav57SG6z3g3maKDbyPXApEvMPImrI6Opa
 egNs+yu2lURc416XpY2JM1jxCec0mqE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Bt3Re3quOYeNdzGycGvwvg-1; Sun, 21 Jul 2024 20:17:54 -0400
X-MC-Unique: Bt3Re3quOYeNdzGycGvwvg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso25991745e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607473; x=1722212273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDyrc4b0PIQEqc1nWX9kZEf6YpDLGOOzQo+gBLAOsk4=;
 b=TbIiZ09nmrdw/xIMvcrMLp7zeb3fCZI3VRKmQaz4qOUBqH5uwpykQUjtubjTW+k+HH
 xbuHD092sxSp9dEIAiRwLFh3pQ7iGkMIV8EIYWacxR2TjJtqmuPR2HiV9epdP1vA0Qkq
 C9momPu+2AnqaCmD2FSxDDwVNmJGrr3fQkg8DayreebTuCzGmrsxZLhT3XiiG0zpSjBM
 450dboaMZlxoWtDRJhYCCdx27/yjt+mp3GfJlnQpE9fF+Ly6lY4vLlStjf6nxZg9opXp
 Rwk7XU1GB8jnXIeJQO9NyyRpNguVtiRCNnMf4W1g8YmrSY8Q1P+fEdey3Fdlci91aPbE
 QRJA==
X-Gm-Message-State: AOJu0YxJPKyyhqBaQHurcR3+SJLm2VMqHWX30JePQ9sv5MqUrc08AfAl
 ruVVlBsMhxccmzHfPlggA27heDx0g+VSgQX1uWocApQ0FZmn6wkDNtmMpukUPuwwxh1WmDVGqYm
 DOdMUcPCIMgAogGw1KJYmsUxj6d6Xd8z6zApgKVfB49tlwm7yjDDcH1a/68hacuUb/pEYqcp3uJ
 /fdDZH6Um8q5oSyJ56Glitxsik3V76og==
X-Received: by 2002:a05:600c:3592:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-427dc564cc3mr29068005e9.25.1721607473015; 
 Sun, 21 Jul 2024 17:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsSEqgOYjfl9TwHoHeW1baixVS5O2dlX15A1Ba+C3DUAo4DtfREdIpP3z/OVbieWhnH7C7Vg==
X-Received: by 2002:a05:600c:3592:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-427dc564cc3mr29067875e9.25.1721607472310; 
 Sun, 21 Jul 2024 17:17:52 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c356sm133089805e9.18.2024.07.21.17.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:51 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 29/63] hw/pci: Do not add ROM BAR for SR-IOV VF
Message-ID: <54f3a29f08900bef796953971d2482d64ddf9969.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-1-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..bd956637bc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar == ON_OFF_AUTO_ON) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {
-- 
MST


