Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E17C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRuv-00037w-D1; Mon, 24 Aug 2026 06:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRua-00033C-QE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuY-0001pX-Aj
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so21806115e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567288; x=1788172088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dr/IjVo/gSKq6gEnuFGTi1QwN0pd8rwWarA0Q34qZc8=;
 b=ZEFe+RElCtGPL89E1/1L40kzKqAdqCDQI4KGxIbni2vT3+dWU1VMP6T5pVBBZSpCUv
 ZflQIhadb5NhaYFAsvRe5EO4aXXfI1JzR2dBwPpYhR2tGFlN2rQ40r2CE8ZyCX4aTSpS
 FnCa1N33mq6Y6Hv+fiTNCXTe8gmrPpvmyVQIRmyFd86kVxN9O9Gra6jiIerlXoDXzaWa
 y/ZnW3WXQWHBqcpx6jT2Fx1E9TsaunyrRGKeWye9m2hn7NJtyYqa2hCIgK/rvmeHJKOK
 FjsLhyWzBEllsdbGrDXL2KonZWWqUPa4bFrh4CS2/m1HKOsc9v7vf3PVu0jYJJiJfJ4z
 D6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567288; x=1788172088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dr/IjVo/gSKq6gEnuFGTi1QwN0pd8rwWarA0Q34qZc8=;
 b=fTM8biU8k44SR8ev/wAJ1gyrP/IWhdq/cie+359W6LGB8Lml0goCoMlq1vXVSigWfY
 03go+TjG3h19PjQNG0VtifyOMIG0luEV8EUzfNKkXGG4UUWhEl4aHIDfNhBd2QcSSH7+
 P2Qxunpv7s//38p2yNRLZvgVVEIBLtsw/HkDKDpu1jiSc93zI3w6usThrgelHLd0YaxJ
 BHOu8jgoYsHXxtNOu1eltx8wz/yLXtQbUVwpf5x5/khLxDZtQ7Z22hMtV/mf/oZ7JJA1
 VE23NAZ4fFQA05uqDU691wHkKynp9q2dKEP2AXlV/aGI0PqWfQ8bw8NwJlBXpdAv3Syp
 LJLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq31MxD6a0zsSRCSbRFdWkYq02QKXJqsVJV3Gm4bimx1p0h3clbJBlFbhrR2dC/MV+MmX1S5qJPOgtE@nongnu.org
X-Gm-Message-State: AFuF++kn95OkENBeqeDWOe90EUbV2z+T+6VfZe/0m25XSPZMZ7t/QrkQ
 jjpKmoomz6Ea4cr1aOEYwI8DmNpO3sr0nl493RLsmF20zElze+DyTrG77X0AnFO7tSg=
X-Gm-Gg: AR+sD108xhUUytz3Kjcs92r0CK45/DZw49gGgYE6iI+ZZDdCzRyvlzxoqOqjXchI/Ny
 lHbsoOuC5TLolItHyPxHRCbx7/tVRooD+2+NRrFcG491xi38vgPe7sQvg39hx7xxO+oT/kh4+iX
 3MD8MepCxo29S0HHrPjCgdBrSR771/XM6dymAefNJRJ1/g179IhiNrkYSK03ouV7l62uMpOPjkB
 nfeV050065M6EgOCz/5ETwNg78nadzc9+MN05/I8DUhC09iA1VImOSR90v5sUAAZtaUQ5ryGDj0
 s51KnIrJ6zxkHVo4heZefxvnSQlDjuxw6D/eynG/aZ0b4tixjsY2rvhJyy0mjBdKIVvxUJCD6+Y
 sjlnESUpGzCDoXTT8n5w1j6mmSdyPRVumgL6BjU+XfR+iLDtL5eJRLxj5td2iDO7woaEqEiJcll
 kesvRtWlI6u1N4GMSKgQZDaFijyR5TgjiclWtmIMKCF+WSCz4NNEUt4Kw9wxXqimxLJOuHOXbIQ
 7hrRxpRZE512YhAM+WF3hc3kZYiZ6FsQ6NdS8ZeTvn8vnRMPOowx3NbFedKqwcdeyWCJw==
X-Received: by 2002:a05:600c:c113:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-499bf0e9606mr211342485e9.1.1787567287996; 
 Mon, 24 Aug 2026 03:28:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] hw/intc/arm_gicv5: Minor fixes and cleanups
Date: Mon, 24 Aug 2026 11:27:59 +0100
Message-ID: <20260824102805.639072-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset is a compilation of minor fixes and cleanups to the
GICv5 code that I found in the course of implementing virtualization
support:

 * Various in-memory data structures are defined to be aligned to
   their size, even if the guest provides a base address that is less
   aligned
 * We had some extra blank lines that didn't match the style in the
   rest of the file
 * We were unnecessarily extracting a bit from a raw register value
   when we already had it cached as a boolean in a struct
 * We weren't tidying up our allocated memory on finalize
 * We can re-use arm_cpu_set_irq() rather than implementing the
   set/clear IRQ/FIQ/NMI locally. (This doesn't matter much for these,
   but VIRQ/VFIQ/VINMI have more complex logic in arm_cpu_set_irq()
   that we don't want to have to duplicate.)

thanks
-- PMM

Peter Maydell (6):
  hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
  hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
  hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
  hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
  hw/intc/arm_gicv5: Free memory in finalize
  target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status

 hw/intc/arm_gicv5.c          | 67 ++++++++++++++++++++++++++----------
 hw/intc/arm_gicv5_common.c   |  3 ++
 include/hw/intc/arm_gicv5.h  |  1 +
 target/arm/cpu.c             | 14 ++++++--
 target/arm/internals.h       | 14 ++++++++
 target/arm/tcg/gicv5-cpuif.c | 35 +++----------------
 6 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.43.0


