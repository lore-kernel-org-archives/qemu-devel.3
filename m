Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B67C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2K-0001G4-UR; Tue, 27 Feb 2024 03:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2C-0000GT-59
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:57 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret29-0008FV-7t
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:55 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-512e39226efso5409682e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023310; x=1709628110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdunaCtONvoL0LEtBUlp2r4jkZ1zPWdyiyr1Q1lshPs=;
 b=MZr0XQSFLNea0P2LPFz3HWQQ94aTf3KUR9r64rDzOmMEMjmyf9kTaCWugbwl70HWAZ
 Tm8PSRn4dYIkOY2X+nHDbyOwSiWA2os6laPiIDAWPFnYGLJYZ+Qk7ohfKrMF5TLTAPSJ
 2FNiq2ld2Ze2jSjUhTh5ErEw1lG4cREC/qj8V1HEKdlraTaeLhUIC3WOjtvmXwdxNYwF
 It/KjDpRGS9A5jViThuXmesHtwoDqIgYVmTQ4+54dH2Dcu9cTMd9PRFfyG8UWP++ypod
 PNm6JvdrNlYi+rtt4+1WHurBM0fXdHT1X5jTT81eYerjvx5KGsw0b+CxUhxUrUmmQfF4
 SJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023310; x=1709628110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdunaCtONvoL0LEtBUlp2r4jkZ1zPWdyiyr1Q1lshPs=;
 b=YxYH/mBfjrOKQ+qq3boMYj6cK7Rysmp/DTuYkB4/lHCeVwGP5oP8ah1c5FALM2y1TL
 YGUwrBCYHEZiba/xEW4H0EdRBkYERrfo0VOXxb86MM+s3qlALb2EouHIrCQUtfhTXHXX
 rMnvTww+6wpVhlXEJz5c5Kc34ZBl1yQH6kjJEqdvXTGAVydwj40dsGTheTL+nd9cHY+i
 VrfHO9/HODU1yfg5f4WcggxuNOpK+vef/0WhAuBMs0IxpuwS3H8/HupG0gLRF0zqka0U
 LgA9V2Tyd7GhLHkyw5ag0d5YF2kPUtxQfstkrmeT04iqV+ewIKHzSpV1zueSSiWRdeTT
 RvHg==
X-Gm-Message-State: AOJu0Yya+porP6pDgxO8mL0KQVwj0YKwZu1dsbAnst8CzqdNtdsAc0j9
 0FnwcgbQu0zuBCLBfDNz6qCzHm2bISqcvNm00WxcuBqMp5BySx69DnxSidhs80uAJddn8E522ck
 d
X-Google-Smtp-Source: AGHT+IGUh98kJH5o+ZtvmSqzuA5FPzqfYFg7iwjZ+nvpa60/ZtPKkAyaLFEtEcxbewc8UCQg4Z9pgA==
X-Received: by 2002:a05:6512:3e24:b0:512:fdc7:9200 with SMTP id
 i36-20020a0565123e2400b00512fdc79200mr3728406lfv.11.1709023310633; 
 Tue, 27 Feb 2024 00:41:50 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 x26-20020a056512079a00b0051298559337sm1108107lfr.3.2024.02.27.00.41.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 19/30] hw/usb: remove duplicate file in system_ss
Date: Tue, 27 Feb 2024 09:39:35 +0100
Message-ID: <20240227083948.5427-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Because USB_EHCI_SYSBUS selects USB_EHCI, there is no need to include
hcd-ehci.c explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-11-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 94f0e3b034..aac3bb35f2 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -18,7 +18,7 @@ system_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_OHCI_SYSBUS', if_true: files('hcd-ohci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
 system_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
-system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
+system_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci-sysbus.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pci.c'))
 system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'))
-- 
2.41.0


