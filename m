Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD6C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14Sb-0001CS-AN; Sat, 05 Apr 2025 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14SS-0001Bl-1v
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:25:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14SQ-0005sm-5r
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:25:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so10432985e9.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743863112; x=1744467912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vzAfVR7YEMxPPsaaR3nO6P12SfKZUtlyNeBjddC2ds=;
 b=Xsv7FC+Q0pAqAWQg0gAC0usir4vXQcjySkweP/jAeDNQgTnTGVXdyWBx57ampd3PN1
 yJl0a0SzKhF1EC7VDcbxy5G6ZcbhNlq/7rYlD7DrzJvDRPkFOQHk20EWNmfQR2QYsuzL
 F6ZkBMAHJX6TY2Mr7IbgP+U+pdoyw+ivedN3wo0O5H2/vaYwWURIcb+ZrbwJX2uieFGh
 FZ1AgifOIgJ1fF/xZ6wIFNUYL5ZCCa+x0EDTbsDJwlVG0uFCS7kLPDZHKbEi2H2apDSz
 WYLKUQl3yhXI4z8bjBa+QTbUWLx+oyF2pJijx9286XQJWdyCLDwO1u44EEAz3tzktNxp
 qTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863112; x=1744467912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vzAfVR7YEMxPPsaaR3nO6P12SfKZUtlyNeBjddC2ds=;
 b=w9zxwIvfbJpSMM/U3wGC9VXSQF8YC6LeQBznSYKgdLuNAFYr8leF0YFAm6gFrH7Ac8
 zMo70jH3xnKLfcQg7YSSoj/7Ai5ptJQus8ayAgD1wFMHwMvmCSUU11qSkI9A3IOol5VA
 15/qf+ukXDGMQjfX3SZGwvEsQp4U/HTFPUz6C2fb1Z6stitbAxR1r7ZIx4B4WgbGAZT2
 2OtIaimz3BOXgCSfdU0mt2oO1WASfq36SAGsm38/uMZSrjJ2OZue5aUrwkPAqfbOVaU6
 NnIPMkhdcZIoS9yzrLWSc/3iaMRYs5+Cii7ADl/kq4eGnHUL4lKm/oVIllXoGI90pY5E
 clZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFtOJG3AByJdGIsV7vfqH5SY3/ACCa7r88WlbiU64Vi8NwP8M+R9HS8Jp5c4OXSbsDC/9EAr2dpgMG@nongnu.org
X-Gm-Message-State: AOJu0YyVFhhJN2WustkpYrFZKQpzj1ecOfgsq4H3/1S1/r1qDjf/JJ9D
 pECB3SrwQY/fK65s/t5aX/tuxbCgxw+qm+z+RTzS3tg1CpMqGV7P1MXjCZ0fykE=
X-Gm-Gg: ASbGncuJnE3R3zIaS8D6ZCNzDD3VNCuHdqNYYple1nZyJfhEphBtYvYGE1qalmZjmbS
 xDby0KI8rOEAxVRDUgTimMGsxRX0X6AJoggkLyvzsXB67S+PKMjb5l/ra4EEUaIQhOXgaEWVogC
 cALAUpjrPAY84eL2tyWleBgdCSLHP8QowQuqx6/j86VWBTaxUqxa4j/bNshH+RXSRfCZwBXOES3
 B7xIHw8FHWMhDK/1AmktzDexUUXJBYdSizraDNGHW+nNEvDZQxIub630wB0ZYk2yRXVYwsxPs7M
 1/FE5Bw94GXFjkI050MweL+L+HI/GJxzq0WoIlvy/HM3I6SmGJJlABpKJ8Hx3t6DWlkR1YiTtEC
 D2/cd3+St7XB0+GW4UQ==
X-Google-Smtp-Source: AGHT+IFBktuH7MkMGfrcA+wPodhCHRWiRSEFCtWlbh6RtK+t25gvvliIZvMFqzDe/41tTXXRPVyq+w==
X-Received: by 2002:a5d:5c84:0:b0:391:2eb9:bdc5 with SMTP id
 ffacd0b85a97d-39cb35be53emr5646985f8f.23.1743863111724; 
 Sat, 05 Apr 2025 07:25:11 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b8161sm7138216f8f.50.2025.04.05.07.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 07:25:11 -0700 (PDT)
Message-ID: <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
Date: Sat, 5 Apr 2025 16:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250405140002.3537411-1-linux@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250405140002.3537411-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Guenter,

On 5/4/25 16:00, Guenter Roeck wrote:
> This series is needed to support the USB interface on imx8mp-evk when
> booting the Linux kernel.
> 
> According to the XHCI specification, ERSTBA should be written in Low-High
> order. The Linux kernel writes the high word first. This results in an
> initialization failure.
> 
> The following information is found in the Linux kernel commit log.
> 
> [Synopsys]- The host controller was design to support ERST setting
> during the RUN state. But since there is a limitation in controller
> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> It is supported when the ERSTBA is programmed in 64bit,
> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> 
> [Synopsys]- The internal initialization of event ring fetches
> the "Event Ring Segment Table Entry" based on the indication of
> ERSTBA_LO written.
> 
> Add property to support writing the high word first. Enable it
> for dwc3.
> 
> ----------------------------------------------------------------
> Guenter Roeck (2):
>        hw: usb: xhci: Add property to support writing ERSTBA in high-low order
>        hw/usb/hcd-dwc3: Set erstba-hi-lo property

What about using .impl.min_access_size = 8 instead?

Could you try this patch, or provide me with a reproducer?

-- >8 --
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 64c3a23b9b7..bce61a287bf 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3043,7 +3043,4 @@ static uint64_t xhci_runtime_read(void *ptr, 
hwaddr reg,
          switch (reg & 0x1f) {
-        case 0x00: /* IMAN */
-            ret = intr->iman;
-            break;
-        case 0x04: /* IMOD */
-            ret = intr->imod;
+        case 0x00: /* IMAN & IMOD */
+            ret = deposit64(intr->iman, 32, 32, intr->imod);
              break;
@@ -3052,13 +3049,7 @@ static uint64_t xhci_runtime_read(void *ptr, 
hwaddr reg,
              break;
-        case 0x10: /* ERSTBA low */
-            ret = intr->erstba_low;
+        case 0x10: /* ERSTBA */
+            ret = deposit64(intr->erstba_low, 32, 32, intr->erstba_high);
              break;
-        case 0x14: /* ERSTBA high */
-            ret = intr->erstba_high;
-            break;
-        case 0x18: /* ERDP low */
-            ret = intr->erdp_low;
-            break;
-        case 0x1c: /* ERDP high */
-            ret = intr->erdp_high;
+        case 0x18: /* ERDP */
+            ret = deposit64(intr->erdp_low, 32, 32, intr->erdp_high);
              break;
@@ -3088,3 +3079,3 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
      switch (reg & 0x1f) {
-    case 0x00: /* IMAN */
+    case 0x00: /* IMAN & IMOD */
          if (val & IMAN_IP) {
@@ -3094,23 +3085,19 @@ static void xhci_runtime_write(void *ptr, hwaddr 
reg,
          intr->iman |= val & IMAN_IE;
+        intr->imod = extract64(val, 32, 32);
          xhci_intr_update(xhci, v);
          break;
-    case 0x04: /* IMOD */
-        intr->imod = val;
-        break;
      case 0x08: /* ERSTSZ */
-        intr->erstsz = val & 0xffff;
+        intr->erstsz = extract64(val, 0, 16);
          break;
-    case 0x10: /* ERSTBA low */
+    case 0x10: /* ERSTBA */
          if (xhci->nec_quirks) {
              /* NEC driver bug: it doesn't align this to 64 bytes */
-            intr->erstba_low = val & 0xfffffff0;
+            intr->erstba_low = extract64(val, 4, 28);
          } else {
-            intr->erstba_low = val & 0xffffffc0;
+            intr->erstba_low = extract64(val, 6, 26);
          }
-        break;
-    case 0x14: /* ERSTBA high */
-        intr->erstba_high = val;
+        intr->erstba_high = extract64(val, 32, 32);
          xhci_er_reset(xhci, v);
          break;
-    case 0x18: /* ERDP low */
+    case 0x18: /* ERDP */
          if (val & ERDP_EHB) {
@@ -3128,5 +3115,3 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
          }
-        break;
-    case 0x1c: /* ERDP high */
-        intr->erdp_high = val;
+        intr->erdp_high = extract64(val, 32, 32);
          break;
@@ -3216,2 +3201,3 @@ static const MemoryRegionOps xhci_runtime_ops = {
      .write = xhci_runtime_write,
+    .impl.min_access_size = 8,
      .valid.min_access_size = 4,
---

Regards,

Phil.

