Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4A0C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KU-0004oN-Fc; Sun, 12 Jan 2025 17:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KS-0004l0-1u
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6KQ-0006tB-EK
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:07 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1949396f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720464; x=1737325264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STm3h0ab+xe29Vo/LMzsJN1pZufVzApUsosxR88Bje0=;
 b=Xb5neO9ZGEJj5ujgvitJk32BDQDKoStpuuKnqyNq1KLKBABAJV1cqh3o+JW0t43Sao
 6jFDZHxO5Cr0ulCedo2AgD4PQuvYZnPNQSPtm2TSw6Ckyf6exBDjqvxV4LfsmyAb/xFE
 bUYiDSWsr/bKwo/YsncsK0cf/rTdqMudOTBMjbhOOYuZyO32Cr0cCIwZ0XH79K72WDT0
 PX5G4q+IoHYscalu/DgF7utFR2utkNOJrJ7Khsl0SsPQrsVaulHZrFtdkjo0F863UXC3
 p0JIxQFeidVyNDVC2oUUjGUZfL3941KajOT8AR6fwofnT5CaF4Sdiwx34qDDg3tI5+2D
 CIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720464; x=1737325264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STm3h0ab+xe29Vo/LMzsJN1pZufVzApUsosxR88Bje0=;
 b=M7DnXwRbHC5DAfo3hhPNFI7KOXRlKpbfpK8ebJLA8aZN/vHCLgev6tP/t9R9RK3lBf
 DjP5HTAIk9F2FX3isQuhvE+FUyOiNHAhOGeYzYI5vR/XibrSFNLZI7UthUU9QwsWFa6T
 CtJhBfiHSkB0DLSxMArMBIvUBl6mPHsF0hwpd3CcHF3wb7vuU4/9CVL4HmP1dbV4rvID
 k1NWEekNEv2HuKCql/0u488o9CSm5v6MwNbCm11qx0RPI9jQdtDLljN8FF6RIlj2zIyY
 paekRY6koWz7vDr0tPUbvaRWBKDyscmlP6Ge3cfm+ctLlEAZSGN77sYsYyGEsLZBu7WI
 ecyg==
X-Gm-Message-State: AOJu0YyT8IXaKJqcdTd8N7fiWBQMv6E63dAOISVFZXNYwfDAskQ4zVUY
 /m/g+Wjwu/W24crsRyFjHU/k+Z9I9RcOoa6em5sDjrUTKANGCufIKi+++0nYUKTejWb6HH3lcn5
 gw34=
X-Gm-Gg: ASbGnct9dk99273eUuW2R3oaxbtFCHptO2pb9goYXpg82r06nTwMi/YmbGg/vGHH2zv
 7WWCkr/zOwUMMLfl6R/mRFHLH4h2UqmQOi1kSjfBDqXswCsN61utuRhSiMQ2xSs2vsFZGx6UUPx
 9ZRGjtuVfzqRI/iC89ullZVas6A4jAAUhYSZN2A+otWMf/qroRMsFBUCIoGeweVzauQbPVFZlbU
 AwUkvH+SoQWaVl1u1wvXKqyVfwtfMp9OUXQ8oBZnCAe811tZtwNb+RTQ0vRJUeMwX+NACw9xYzY
 X3DeWunZ09zVrNFuAC5h31fBLCp53qk=
X-Google-Smtp-Source: AGHT+IF8XYM4SzBmCysIH4B2CZW4++Dfknd/+AQVrKLOi15emPsoLuZY/fK8d8yAT6qOn58hOYt+9g==
X-Received: by 2002:adf:8b5b:0:b0:38a:88bc:aea4 with SMTP id
 ffacd0b85a97d-38a88bcaebfmr10831027f8f.30.1736720464504; 
 Sun, 12 Jan 2025 14:21:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1d13sm10686761f8f.91.2025.01.12.14.21.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/49] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported
Date: Sun, 12 Jan 2025 23:17:20 +0100
Message-ID: <20250112221726.30206-45-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The XHCI specification, section 4.17.1 specifies that "If the
Number of Interrupters (MaxIntrs) field is greater than 1, then
Interrupter Mapping shall be supported." and "If Interrupter
Mapping is not supported, the Interrupter Target field shall be
ignored by the xHC and all Events targeted at Interrupter 0."

QEMU's XHCI device has so far not specially addressed this case,
so we add a check to xhci_event() to redirect to event ring and
interrupt 0 if mapping is disabled.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241227121336.25838-4-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 7dc0994c89c..00d5bc37792 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,6 +644,10 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
+    if (xhci->numintrs == 1) {
+        v = 0;
+    }
+
     if (v >= xhci->numintrs) {
         DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
         return;
-- 
2.47.1


