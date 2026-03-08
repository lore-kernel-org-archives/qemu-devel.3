Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3A3EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMmS-0006Uy-Nb; Sun, 08 Mar 2026 18:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmR-0006Ka-Cq
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmL-0003jz-OU
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so10361815e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009556; x=1773614356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CvxEuWUffZVii1EhCg4BQJVn8lfA31fdZwToBj4p//M=;
 b=ZkF9o8Ts5QGa3POOYVTDVrakek8/VDZn8zO33hNbOXEihsVcEVnty7dp9g1trTBfRd
 i7hLKZ4TD5WldAi7Jd9F3M3fmDxGcGoS9rdSUc/fKuIRzgzcH+obzLHyE+2aKIHa0+eF
 23aT1WMvB6MkJyedLYGR6csg8HjRtSZnmmtLRW545sPDlDiFWnzDvXrQucthc9EUUNGK
 FRAzi1w/gKeiU+6VLJdfGCalS4wyAWowEETzHaOmCppuIQZPjYSF+BWNKjKWlNVukCCA
 fnG2dH/D10l5MNpmzeUQGW8pMJgkZXdPE6RdZ+wZkWb+us/SUeOQg9ItmRwxS3vRUBUE
 63og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009556; x=1773614356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CvxEuWUffZVii1EhCg4BQJVn8lfA31fdZwToBj4p//M=;
 b=i31BB6GbI9hLb5XOMSmYETxDHrY31OBxxUXbrEq80ABjKc1b1vnyxSBb/481J6xEFY
 j6PBebN8clz1AmZoF3Cnr3rCdNQ0FhAgx4bw/UFB7jAbNb1fLiUDOV3Dofc09WC6ORjs
 AkugKPxYLsnTpyuZ4VjKyHwkp0wIYE0247EP3uTKL5jHGLahDhGCEzKy4EwO6K5s+DTd
 azzKFrcngNc56YpTGpXWz+VCmKaSSZZT5800mtReiX8xqDHCDV8UTI9kMjpSpbCY05EF
 4lO75RAIxdHokKW7p0fj4lk5XoU8ww5j/dYjt196VKD8uzeIYaZQLaKzxL/hD3CfnxS2
 fYyw==
X-Gm-Message-State: AOJu0YyOuKjcE0I9SM1tEx9mQ0RcHvfv7XBYNpxrGSdsObtOuP/4YvPz
 QkXiYEh2O6uafv9WUIQFgSO/pCKkuHXWrDHEndAp+XX+MK0EHkjKpMVcTGhLGMImNYGGCEEvDGZ
 QO3BVxpc=
X-Gm-Gg: ATEYQzxqXrq6QdAT1t766XInvtool/Sd3Nf8GYsVe8ALXJ3RmIZ/dWLmN9a3LhbeWHz
 0FAlVtuKlB5LC8aQJ4coRPAg/ZxAp7HTT9iitpsPnVHMDRw/LVWeIuWlcLelw6jIXQejnWaE3ha
 tiogpaBwmPAsbfe/n5f45mZ7hL3Nyu/+M2FcrMn4qc6LlBHU+F0C6WAnpjfWaSMc+s+HLt/ae8B
 HdlrAYPEQUIt9LaO0GzS6vUj4hGK+2RZ+yzpXiU9c6F2qfDFBJli0gzYuezSPSvAmA/y4sgxYFn
 LDD+u9AHECuw6jU0R6i2GizAJRH1AA9bK39KHoSzBzFtWcN+h6RT3d4jXAgfpz95qtVamFcspRe
 vwFm/etp8Mq5OQOc/mqVOAHBCaHjOs8iSoTJmLb4gSGAx9kTAbtilIQ7WtwmNZCx3XrYJvS2rkn
 jatIu2JqUnIxGN1USJv/N2keuXVxIvSe+wwiNnQ1iQHhfsYAoHJT6S6fnz0/97tdnr4eIiMPhRZ
 NtAOw==
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-485381238b3mr50660405e9.9.1773009555759; 
 Sun, 08 Mar 2026 15:39:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e3fsm200398305e9.6.2026.03.08.15.39.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/49] hw/char/serial: Avoid implicit conversion when tracing
Date: Sun,  8 Mar 2026 23:34:25 +0100
Message-ID: <20260308223433.25503-42-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

On 64 bit targets, the MemoryRegion API passes an address and a value as
uint64_t, so use that for tracing. Keep the uint8_t for reading since
this is what the device model produces. On targets with less than 64
bits, uint64_t is wide enough to avoid narrowing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260305220911.131508-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 9e74be2c14f..a3fcc772877 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,8 +5,8 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_read(uint64_t addr, uint8_t value) "[0x%02" PRIx64 "] -> 0x%02" PRIx8
+serial_write(uint64_t addr, uint64_t value) "[0x%02" PRIx64 "] <- 0x%02" PRIx64
 serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
-- 
2.53.0


