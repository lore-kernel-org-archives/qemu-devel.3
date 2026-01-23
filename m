Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAACD74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIpD-0001SZ-W7; Fri, 23 Jan 2026 10:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInT-000781-7f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInR-00036i-4z
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1509609f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180999; x=1769785799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VYPv2joWEy7NQbj1wDZIlmJyo9qqTDgvEnE16RTvAgs=;
 b=w620DCyzyR6e0krcDkUKmOg5jNCsoszq6Vep0ZM06tWPzdLteeZpi+upLmoBYYd3n6
 GlQ4IGBrluozhl7wDrYnizNgtJjyIoG/OHPGHuFAxWDNP3YsBDxBXbhAhbdvTWJC3yqk
 tEecHwXotBPh0bS0VrgiCEQ5YYXh0UBUdpdG0PsuFcxZR1R+uNtKo6nH/GX4sCjyYVvL
 L8Yneio+yIbvQxthDAYUSYFTMibKdni6dzNg1D9TiHyDGm6fgcAv+eMqEIJPI0L+KiBb
 5d/Iknw4LgQGy4OTxNOHbSzcFNPX9gAOy/iGS2Vl0N/w4iQyzAsyz7oPnYbZX/krrR91
 FSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181000; x=1769785800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VYPv2joWEy7NQbj1wDZIlmJyo9qqTDgvEnE16RTvAgs=;
 b=ZiTjIX51ggErosIEHRbY6PAkXUxZQZkyQHfCERIFcf/hZ4TSdmmw1tPx/mU1XQ4tsg
 M9dMvbvKexrhFZIXiVzsiyMpRN41mHwFPqb8t1c7isBUZM+RHyTIr9aOqrofPoFkugWq
 rRRdk9xv4G4tGtg7bMPPoWJynRXV7VY5SRgIipaClXyhbfm72nY2SP0cwPzNf3F1nzCa
 R8BzlVaqtneKg1MIrsER2MvTejLWA7jOe1b2k+Q1dJ9BxG93AdcAm05RD79tM/XoIU4J
 cgJpEhGSjiSlSoVqfIG4aqYsTXUai8AT4CEjKFHpPfy0bRuuqFWu/1RB0OB43NTupeRa
 JI8A==
X-Gm-Message-State: AOJu0YyB0YR3XYNegSsKZNjS8BeoUQf/T+QzqTk7x0H87v4rbk10oD5n
 K77/XSQwr43KOrE8hGJzU0Qzm9gm1XCj82vqW37xJSBWWqv70FQFwdxt/LBm4sKTLtU3LVPHvN7
 UyMOkS5g=
X-Gm-Gg: AZuq6aJCaWD2OQTJe5Zug4BB6lmlDxyqoWcA5Qr16RSGXvE9CmkwWkB+OdNxv1tFIPG
 MrESrBc+TkJJGoJStoKjJ8+hYnCBdBScKUH4I3QxYxZ221APb6basDPkTftNd7htpEeIWjgBQ4t
 +gGHGJI1qGKKohbyvSbjLJN/wPErLZIct917ceK4i44piBLFrSIo78rQK7nenYo2DT5CqtfVE35
 dlGp49Kjp7Lj218MnWlArTuV4UBJ2ltJQA3LPvU7hFk0AoZPJsJGSCzSALF9BnqZwcJfjoKZYjK
 huzxcQo80wAcbXJhIxxbF0VN6rfYP0dTnLFJJiOo7B12cJ0EqJwjVLOJoKAiekaz9+aST7fTG+c
 W9PSTSDypI/0pOXEkaXVhOL9PbmaJKM2MHQq8+IuqsCkAq04Dm21rwp++bmP+Blmr5vm8g35xlw
 V7q2sgPuBgDDP3v+CXBLMF4zUk6gQEtce2MMjirY8i1K0qtYQYQDy9hFbpnJuv4Ls=
X-Received: by 2002:a5d:5d0d:0:b0:435:a2f8:150d with SMTP id
 ffacd0b85a97d-435b1750380mr4795804f8f.59.1769180999399; 
 Fri, 23 Jan 2026 07:09:59 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/22] hw/intc: avoid byte swap fiddling in gicv3 its path
Date: Fri, 23 Jan 2026 15:09:36 +0000
Message-ID: <20260123150941.1877768-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This allows us to keep the MSI data in plain host order all the way
from the MemoryRegionOps write method to the final KVM_SIGNAL_MSI
ioctl. This fixes a theoretical bug on big-endian hosts because we
were using different size byte swaps which would have truncated the data.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260121105932.135676-5-alex.bennee@linaro.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its_common.c | 2 +-
 hw/intc/arm_gicv3_its_kvm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 9fc51ad1e0..60a5abd8d3 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -81,7 +81,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
     if (offset == 0x0040 && ((size == 2) || (size == 4))) {
         GICv3ITSState *s = ARM_GICV3_ITS_COMMON(opaque);
         GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
-        int ret = c->send_msi(s, le64_to_cpu(value), attrs.requester_id);
+        int ret = c->send_msi(s, value, attrs.requester_id);
 
         if (ret <= 0) {
             qemu_log_mask(LOG_GUEST_ERROR,
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index ae12d41eee..a8d6d4fb54 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -58,7 +58,7 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
 
     msi.address_lo = extract64(s->gits_translater_gpa, 0, 32);
     msi.address_hi = extract64(s->gits_translater_gpa, 32, 32);
-    msi.data = le32_to_cpu(value);
+    msi.data = value;
     msi.flags = KVM_MSI_VALID_DEVID;
     msi.devid = devid;
     memset(msi.pad, 0, sizeof(msi.pad));
-- 
2.47.3


