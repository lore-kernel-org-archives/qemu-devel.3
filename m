Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WhXJpTKM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLag8-0001tq-IO; Tue, 27 Oct 2026 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafu-0001qy-BT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:47 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafs-00089c-HF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:46 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so397160a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082523; x=1793687323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cL0Ce3hdwcL5gyM8WIUc7e0fpWl3i4amOYu4mo0KcaQ=;
 b=WhXJpTKMybn1564dPGo2oZt95KFGhgbSlacpsAoX3ctrFlx8505lmyPpbPABzWwfed
 S8j3/joKdMyJxNMOvsLujan6gBYF6+9nv4/1hTksMBZ75di/kY3jAQrbgOceUMl5a20k
 2r8c8vcSTXuIDx+iM72KJKux+MPcJzfX0RAmYs+5LS3J8723NXcC+/opb1192GKjqYaW
 APWRjUWYMG6hII0meX+zbhifrbcMYy+DUAvaUOItcwtZkG2ytdsPbR7BId+3ralfXB9m
 OIMg1TVyGWBW5d3rtw/CHdfDKMC4gPoXpAqmZcxRyQ9hdRm0JVdlVDPIwuxLaNJ0zQMZ
 AcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082523; x=1793687323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cL0Ce3hdwcL5gyM8WIUc7e0fpWl3i4amOYu4mo0KcaQ=;
 b=LvMvorUelhV3XtjVgaRIy/HE9jbMu80oj/16CBGeknNDPIspDiUlj5zW5mVa+TALNL
 ZDqHpD0bCBUAUaSfFJ5h99RMSfPTCx6u5MZP0+zDU02gFZkJB69AbpZhimuASTOxv62Y
 ooxVZitKmPy2v/8hctQ80kBhQW3GmYM6d56zyv5L2BpLW/q4LWeGmuEUiywOoy0TbvXA
 fir3bLs4RsbjGf4XaswPdn6jb2YXLcogILPN7I0j/oOu/jrLRTA0Of8nKEPrEKTAsWQ4
 Osb7ejpUNSVKZDTzMGWHYLW/fBuAMYbUhEro/8AdH6wrPWXNC2YTsknBQmbuqicNVPcG
 hwuw==
X-Gm-Message-State: AFq9FYLXNJbZAkn+QI6ql/BkPX19QShAoc+UkOxhQqkWeBWkc6a0Ib7h
 JNcIIuVzbi4mg4q0ggp5GyJoJ6YjW6ks2OEpTPqcXv5vjU+V8NR8RtGxZpqhlA==
X-Gm-Gg: AYBFou3Yx3cXfbodabHM6j7UZH1Aa9Cym7mruapUpSPnFwZcb6RzRE18njdjooep+MU
 /JiJzj+bHtO1Rt32kSYgNSFtWqIff2YZiDgWMzts+ZHIk+zG2i39o+TDVAP8n/5CH9034M9+nsU
 SjyqJl6Tsex5+PEdAJP7CsCzw8iz/vIEjHXI363LLYMfcLt52T/EdFWw8a4vMjyKHqJPV4+fFbV
 44HFBO5SZUf5lY3hcgTVdoOvqO6SVLLXkQ5OqsBV3vzDPANUm3y1jSltRykjP36kf9VClqW+tVv
 RQb6btyE1ZM9K5w1GRDFHtRIN30FD3UTA+QKCsRTip6JDA1tUumT7EThe8olhRRoZEgF2GQIAVf
 l3tBcLKKrRsW1+qN+fwUH9B7AOF1mQu+mesXH4ZrFpk6hODvaDXBeLn6ZtFVnVnPG8Qdw5iFSxo
 xTKk179Mm6t/bPr0iYeGocOpeCKtLpcJT49EYdhzLbkPT092Uxqze3UFWWF2dLhbWehnYnzyZAa
 hiqk7y8YAIu5/9oXiVbrEyKM7Sjh90D00r6658pvzrF+nxfYzUMm8cZAUAirMQdkKwL/rsRBQ==
X-Received: by 2002:a17:90a:d603:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae4029a8f9mr836623a91.26.1793082523168; 
 Mon, 26 Oct 2026 23:28:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Wang Yechao <wang.yechao255@zte.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/29] target/riscv/kvm: Reset vCPU on VM reset via
 MP_STATE_INIT_RECEIVED
Date: Tue, 27 Oct 2026 16:27:44 +1000
Message-ID: <20261027062808.1995205-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wang Yechao <wang.yechao255@zte.com.cn>

When a VM reset is requested, KVM needs to reset the register state of
the vCPUs. Without this, stale KVM-internal vCPU state (such as the SBI
STA shared memory address) is preserved across the reset, which can
cause KVM to keep writing steal-time data to an address that now belongs
to firmware code, corrupting it.

Add support for the KVM_CAP_RISCV_MP_STATE_RESET capability. When
enabled, QEMU resets the vCPU by setting MP_STATE_INIT_RECEIVED through
the KVM_SET_MP_STATE ioctl during the KVM_PUT_RESET_STATE phase of
kvm_arch_put_registers(). KVM performs the register reset while
preserving the original MP_STATE, so no state restoration is needed on
the QEMU side.

This reset path is reached both when the guest initiates an SBI system
reset and when userspace (e.g. the QEMU monitor) requests a VM reset,
covering both reboot scenarios.

The capability is optional and only activated if the host kernel
advertises KVM_CAP_RISCV_MP_STATE_RESET, ensuring backward compatibility
with older kernels.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525a8..c085b22b23e9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -57,6 +57,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 }
 
 static bool cap_has_mp_state;
+static bool mp_state_reset;
 
 #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
                                          type | idx)
@@ -1443,10 +1444,31 @@ static int kvm_riscv_put_mp_state(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
 }
 
+static int kvm_riscv_mp_state_init_received(CPUState *cs)
+{
+    struct kvm_mp_state mp_state = {
+        .mp_state = KVM_MP_STATE_INIT_RECEIVED,
+    };
+
+    if (!cap_has_mp_state || !mp_state_reset) {
+        return 0;
+    }
+
+    /* Let KVM resets the VCPU, The original MP_STATE is preserved*/
+    return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
+}
+
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret = 0;
 
+    if (KVM_PUT_RESET_STATE == level) {
+        ret = kvm_riscv_mp_state_init_received(cs);
+        if (ret) {
+            return ret;
+        }
+    }
+
     ret = kvm_riscv_put_regs_core(cs);
     if (ret) {
         return ret;
@@ -1623,6 +1645,11 @@ int kvm_arch_get_default_type(MachineState *ms)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
+
+    if (cap_has_mp_state) {
+        mp_state_reset = !kvm_vm_enable_cap(s, KVM_CAP_RISCV_MP_STATE_RESET, 0);
+    }
+
     return 0;
 }
 
-- 
2.55.0


