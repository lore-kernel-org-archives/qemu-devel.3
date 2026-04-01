Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E78D35154
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w821Z-0005AA-EF; Wed, 01 Apr 2026 16:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w821X-00051a-Fi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w821V-0001e3-Fe
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48374014a77so1239745e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775074723; x=1775679523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
 b=You8kHAOcQ2tZnC+A+1MEUSfpNgNpQoStsAZ5ZyJqJVScGOGTFd3eJ1msS8VXcHDYd
 OcAYpMtNoiVSXorkqgXIJIVWPQwEMDEBn9P1HTUXFlDF5b4zxv5CVJg/fLCemrQ2Wvql
 gKV7gTCDtUELAPrZt5wEvavwkxZw9EePcyoSNsDA6ECpaCoO5UJONRm3H6opOzDnA9CQ
 rn1QZd9WSH0lEgooRH0ZT/j2XHHVMsIGdYf54i6x8DG35xzWuLpGCbrRsN8YHNOaoTld
 mJLjiD31rM0iFw8WOedeXu2/Z5VA9oRXDvEL2pM2PXLPAmQ5UfFgr49ofr6LBR/GYLco
 yrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775074723; x=1775679523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FyOQuMfSmwVXZQAsXLr0uzFcWkRrczcFtO2oxCssQ7s=;
 b=FkC8R1GWm3aj/d+wrhDN1PKWEbS3vuBUYFhRuNT5XqsuaBFUeZo5gU6W0j7/8MtzHn
 sBfm3P/d036+yxAT8YWASbtxCetwXArzOmxDY6QH+vfzacsy5nJRHH5dI5iAN7T05EM+
 Ezq3cg9DflW2aP+PgeRqx1q4208uAcX4WGK0s/B4Cknzh3DNN2+gYNB4njy7BQqkcFsG
 aleqxux8rqaoi+gD7mWmg86pp6cNWwHiyX2+H9Xv7s2bHNKGJSQ1IlvZFcYfTUMeKumF
 ALfM3JJzPslNWXXZ6tVR08YE6ebvDEBj+YsCOmDUmcd4yscD/1RAgCN2SeC4eeTgPc8F
 KKVw==
X-Gm-Message-State: AOJu0YwUqvvcSpGmgdGVBHx6m9YDu7nhuhZeulOqn8yqA+va5G0K2cfF
 bY5kSYYYWu7L10bFPsk9PyymbPxj2xhlD/DghdU6NiIHXUqNolVjTL6AoXTByX+nfclL7VC/c3r
 U1QSlBg4=
X-Gm-Gg: ATEYQzww3b5cGveDye/TL7QVhI7/qH+KeSdy3zUdcbWQot+A+Z6bTivcVbgYJ8qFVvA
 QqzuJMcOgVqlPeNFWcYDo2HuY+jd9LT4uTcG/VJBrDwJ17ow2cDLu4+eKDc0D1Hm9l6lGZSJ60Y
 WdiV0kyPSNI+vbryJdadbgdNx49a83WUEpuOQomIYKFT/fzjW+vIKGCtI4S7952wDQHuNwOYm3y
 UvGKhtf3TpUskNH0T3sZ7nphMyF7iF3RXoS7tbgxE5nobByVeipqyGyuN59k1zYrDYxQNw9Mg3m
 TAEfVYLk/dUTkzozsh9PW45tcdh3BOebE0vH379IxQnuTm+CD8Ez6C6N/Lt/WDqUvH/P0ztumSM
 qBgwzihhWhMx5Ix1wKle3d0Osq3pa5ClWpO3Bbkc5fyIl8DLWD8tUkSmqDIQ0ZHE0mI/UybvkAA
 wUJnCCvRjVPEl3DkRCybSwQDDI1Jas7O6ziXu13q48a5o2OhfcY1JskSoAy67fUyTorRlGYCXH
X-Received: by 2002:a05:600c:a30a:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-4888b7a0601mr7873765e9.28.1775074722838; 
 Wed, 01 Apr 2026 13:18:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d58e5sm2930563f8f.23.2026.04.01.13.18.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 13:18:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 6/8] target/arm: Compile HVF as common object
Date: Wed,  1 Apr 2026 22:17:50 +0200
Message-ID: <20260401201753.92290-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Neither of hvf.c nor hyp_gdbstub.c use target-specific code.
Move them from arm_system_ss[] to arm_common_system_ss[] to
compile them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/meson.build | 2 +-
 target/arm/meson.build     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/meson.build b/target/arm/hvf/meson.build
index afc509a470e..ccb0d338af6 100644
--- a/target/arm/hvf/meson.build
+++ b/target/arm/hvf/meson.build
@@ -1,3 +1,3 @@
-arm_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+arm_common_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
 ))
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0e504a403..f14debc6a2f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -20,7 +20,6 @@ arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
-arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
@@ -41,6 +40,7 @@ arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+arm_common_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
-- 
2.53.0


