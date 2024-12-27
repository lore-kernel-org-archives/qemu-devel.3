Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B458DE7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9EP-0002wt-PN; Fri, 27 Dec 2024 07:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v4-As
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9Dz-0005Fi-P4
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:55 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so12823979a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301627; x=1735906427;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvyTgK6t3B/LAOc7k9FPUxri4XHAiPyQyzliFGxQfm4=;
 b=04RyiATREN7rSFdXDxLc9Ova0iUNMV5MM8+8mhH7MF+3+YQ8/1AmD7Ivzwf121hSiz
 yJ9Lq8qxDT9vc1rCEHnI0ZjpBFWZvveiWZ0q6PBlbeDeTfFEVKWMC0EAt8rmB59DZgQA
 wp4f/vKAXPWcBzXun2oe5jxvvvqzB/QOM1/gFpc9DttzJKUyVn6G033U4QTwSkd1QlC7
 MNaYkxt8pgPosYzB/gQD7okySyJ8BcyZ9tQqZ0Ys91d9EN2yiCgCQ/j+pAOro3G0OgmK
 wJR9+Qm8VDwmxoM7ZpCs0Td1BEZwnSDPxBYKfDiubs14H1Gp+5pyU+6b+f+u3IzEyrUM
 E3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301627; x=1735906427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvyTgK6t3B/LAOc7k9FPUxri4XHAiPyQyzliFGxQfm4=;
 b=UmeAFhjU+/AuGNKhiBPPOA9K/DiiupMy2rvPF3Ri2EqUHz6I7kYtS0b828pVSGV3Xg
 85JSlFh4KEFtXCR8k+5u5YpqPDFpfuihcRLW734DLCEe8xmNSyBC3yHrwxh81t3EC/Rx
 ZTncL7zrsiEDDKfXYaIEype7hddARrWV0LdO0vo3YcFCuefvKGIBZx5fuGLvPI0eEIbu
 enqW2TTe6r2oH5baBcTS9+7FN5uoCV9zEfxHmAI6ZtQC/x65e8GuYNhqhWLyk1UobcEb
 VJQ6YT20iNXrV+otCyQ0jf3jOrZuj4q1DNCW6CjihSrhOqOWmmEkU13rQpSUx60eRPS1
 1Dtw==
X-Gm-Message-State: AOJu0Yy+CnrK0FTRpORMfAG5Vf62MEztpVNEaUwBhnR5H+VTjYv6S6Jq
 i2GNe4fgEHh2/jx/jriSYni0gEHjjruacaGsmhnPTB8uAKAVLnuNZUwT2DrXNRPrYV4wVT8vtf8
 =
X-Gm-Gg: ASbGncuZOqlKkK706nWAk2EO96hnthIlTp4Vc2lCA/0htupQ60acCfA6AiQV+rs+Txr
 x0+PzA1yNLBmNjbSwMoUMDju3YPzKHmwyuB2PROxaBXTvpycnP8tDrbrGVC/b5QD4OkV0ZBIzYP
 g8z9SrsrTdx8147FuiObQApsdW/RNZ/yu3vAqCGX69YlGB9GtLICjFtjjCioQb5xTUSHignwe36
 rND1AUSZyNYIb9zTt77e2jAC6PlNsGCmw/CpWWByQDdLowLZWQoyDej+o4BND+LzBc191BUUFkp
 Mx7o2xVNy7LNNSIdLIp7FN13T5QpbbHR
X-Google-Smtp-Source: AGHT+IECabCWXX5coRCLilR7ADB0xMkJJxQRD3mKaU6vQp/E1ZL62ADfF5ytdkPMoyvmQZvTLRZdzA==
X-Received: by 2002:a05:6402:5255:b0:5d3:cfd0:8d4b with SMTP id
 4fb4d7f45d1cf-5d81de38c45mr23117436a12.33.1735301627022; 
 Fri, 27 Dec 2024 04:13:47 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:46 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 3/6] hw/usb/hcd-xhci-pci: Use event ring 0 if mapping
 unsupported
Date: Fri, 27 Dec 2024 13:13:33 +0100
Message-Id: <20241227121336.25838-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241227121336.25838-1-phil@philjordan.eu>
References: <20241227121336.25838-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52f;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The XHCI specification, section 4.17.1 specifies that "If the
Number of Interrupters (MaxIntrs) field is greater than 1, then
Interrupter Mapping shall be supported." and "If Interrupter
Mapping is not supported, the Interrupter Target field shall be
ignored by the xHC and all Events targeted at Interrupter 0."

QEMU's XHCI device has so far not specially addressed this case,
so we add a check to xhci_event() to redirect to event ring and
interrupt 0 if mapping is disabled.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 3719c0f190..011c445443 100644
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
2.39.5 (Apple Git-154)


