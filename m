Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D3C44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvp-0008TT-8c; Fri, 03 Jul 2026 12:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvW-0007w3-S9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvP-0008Dx-1n
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIQTb446196
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=; b=W6GzltneyaqutTSF
 i+UcKHj/6/qspt5vFTQDS0Xn80nNuVxNFj0LrcptVuGDDoOby1GAqqzMM7JMr2LV
 o0/D4RwhLOyRjQ+8rHazNbJRSvb4T94K7QeB4MXJLQPV7QSKcwWCfmHRdTHLFY+E
 JRUNGbMguvuNGlqsp8TXnzQZBjVVPEcimC3dH+ObS/bZyFInGYa8j1R8nWwubG4Y
 Rh/yC23nEg1Bs5wiGk8TkO5JTQ8+appeTgrqQ0f46QhD16L5vBAemXCsH6Hz552D
 8CE4e7250jjHMqid1hrjaAhS/357UDNh75puXL98ghORjjswB9OIzexRI3L4P2qB
 zryP6Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b039ej3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so8600585a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096762; x=1783701562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=;
 b=aH8jrxy5FwY0hVpl2w/cFbIPf5RY3gKiZbRUOgi9DVydFpvxkC2icYfg8yb0U5AulS
 7Yt0M0jfijvxzdJgcMwDpGEjHi9n8CbitkqWnM3yB4aEwdFjJIbbVogZS9jt/MBPAnaY
 WVR4iCPRM508pG0oqeTP9hVrZ6p+7jufGVRRQ1bkJ5r3U8k13w/rfuSlvnAs1zC/KWtv
 MjmQrE8xfWDl7mJUCoEogbspJANgKn99l8GHq3Yy91hnx1UU0to6vnqoM4UgHhyY9AAL
 H0SEdytR2XX5ivWdtIYvI5jNYlmt/pTwbk2qfM/xo5mJjSisHQBWgGY5AVxuJ0MP9Z7J
 mReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096762; x=1783701562;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=;
 b=QYTmSC6yAIqs9u9zG7ckuVxBA2kfwQea/xNgu4MgvG/L++lIPtC+JXi2GOVgb94gMJ
 4Y2AJwvIFXr22gILxAQaor6Ywm2k/9BdmtulmwN72wzaicTgaOce5dmvb+kv0lMoZ3gR
 lm+0m1aytYmq7EUBriqsbL63DrxCABUHwu7g6nJnzGhfUkIlWccq7Ik+iVxkkke6FOF2
 jFK303hJ5aFMVXZLhgxbbz/sgjiA8w8pPah/Nz0E4bJw70JGHLwtWit6c7DPV9q/+fre
 BZiwhON0z4uonjwjY+DIo0LNBp5msFnPzLvERmkea2NsKzoa5zc4NEMvucATVDqwTeXS
 ZZXA==
X-Gm-Message-State: AOJu0Yzd6y+opdv5ARdyxf8ft0GSMszWdeICOglje942mkHvrBZsUro0
 2eXaeZplLwwqPUF6kdV/vnrS1yoPgHoR5xJZK35VG3uYu27EThE3MC9svGP0fyghqm0GYcBsSIj
 ZbXtiUuGJ929pMCCTW5TQEwMp106HJw33GRAgd2cWJrwQbhtQah/ux/5G+/E6ThW1Lw==
X-Gm-Gg: AfdE7clPysD3eayyXYJi2imih9atoMrOTqpIxAfC1jNldYLxU4f9HjBlFPMZpgwYEdE
 vCn14XuQymUSO20Xqg4lskA3pqXXeYeu4jeyL6bA1V5Op8CXk1K1BCf769vGtK11wIsAv5bPOfa
 qFLO3rnZ0zlmdQNHJ39YeQDB7e6LC8TITnifid6LcyiHBUbloXspMP208JrpRYv9i3wdIw67UTH
 /9elrP1hUyzgZtCJYgG1bgFcmu2I04POWyV6Cc28aFz3WDn4q+whusPWNjtrv3HWUTbmBFGE3MY
 s0mUpFR/4JBGiMHqtg+Lma7GiLpWI4WcwNgJtnulYqi5+d7VMWAxxvGz5M2m5BxAN4NMdgh+ByE
 M4YFGg+8AO0pBS0qtz6uchybxmY41Y1sW9FsCH9mYPAQjuBjL8XIvLQbkrtOrfvPmDg2D
X-Received: by 2002:a05:620a:29c1:b0:914:afc1:c66d with SMTP id
 af79cd13be357-92e9a2f76e3mr32468985a.11.1783096762419; 
 Fri, 03 Jul 2026 09:39:22 -0700 (PDT)
X-Received: by 2002:a05:620a:29c1:b0:914:afc1:c66d with SMTP id
 af79cd13be357-92e9a2f76e3mr32463585a.11.1783096761900; 
 Fri, 03 Jul 2026 09:39:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm122240605e9.1.2026.07.03.09.39.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 11/33] accel/kvm: Hold have_guest_debug in KVMState
Date: Fri,  3 Jul 2026 18:37:34 +0200
Message-ID: <20260703163757.55500-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX1R4E1AHUNVwz
 PoVqiNCH/9BVOc95XNmk1ujedW8uuOtNh6R16enwBjI78lDqmqFO7m9Rk+OYim3NFKswnRZ0Gom
 WTumI/zPCKZVbLzeJwtGXYXbhcd1CN8=
X-Proofpoint-GUID: lYnXfhJTWOlhSBSJvoMLzjVDpiWl43h1
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47e5bb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=O5kNlQXW-qQlE3Y8R88A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX92TUmg+a3xFk
 jFAFwddmpJT5bo4Q7zlXrOZP02ehYDi1fJGDuSMw6aU+DmtatMT9g8bfAxSmgICYHs2RNKNZfCc
 1WsDO64NNcEEEOInBuzDUb0SpH+5mUh6Zs3F0lVkXLBa/6R1EQNk5whxFhrvjt/R2h5Jx3IAkW8
 FAyOevB9mlAXMtD3DYX5CfKvmVQJP8FrbkGL4B7XNFNJdeaISddxq6TyAJy8dt8vwId4GZx+/Xb
 hL5B3gVUE9at5vdTLAKtKmz9VrW9oUfsCljrf+3wLwY8iRuh05mbq1NYsHDitTyJUrsRty6A/8k
 RvWyYOE1xtyHqBzcywJI8tTwsAg1q+yQXv56NnXiKxP0TPc5Vl5GPTrZU3XyM1yPq9S8MCwvmzH
 mkW8loZ9oU6zGKCMkAP3eWF6XUTBUISrg2pMFh9tycOZFpKUd/oLuFiPvCeTmmbB77yl0CBve3n
 e2uabMuLIKWQUEOn64Q==
X-Proofpoint-ORIG-GUID: lYnXfhJTWOlhSBSJvoMLzjVDpiWl43h1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Prefer to store per-accelerator variables in the per-accelerator
state, rather than as static variables. This is a good practice
to allow concurrent accelerators in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/kvm_int.h | 1 +
 accel/kvm/kvm-all.c      | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..53bb0fcf180 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -118,6 +118,7 @@ struct KVMState
 #endif
     int max_nested_state_len;
     int kvm_shadow_mem;
+    bool have_guest_debug;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 304467704ee..b6125125f82 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
-static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
@@ -3038,10 +3037,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-    kvm_has_guest_debug =
+    s->have_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 
-    if (kvm_has_guest_debug) {
+    if (s->have_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
@@ -3833,8 +3832,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 
 bool kvm_supports_guest_debug(void)
 {
+    KVMState *s = KVM_STATE(as);
+
     /* probed during kvm_init() */
-    return kvm_has_guest_debug;
+    return s->have_guest_debug;
 }
 
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
-- 
2.53.0


