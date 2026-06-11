Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662A8CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXecD-0000so-N1; Thu, 11 Jun 2026 08:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXecC-0000rN-Ff
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXecA-0003FD-4m
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCSnWT617049
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=x3+hg7CD2aE
 +8MtDu9XIz3W62m6/gYV7CTzdEVS2dvo=; b=n5QvYrQKy+X8rKOUc3s06HCtmkx
 Nug8kENqlnXK7M2yzZVpv3I3hbwiG/M73VmXwJykZ4RceoDCKYNI0LmKnNAtIpkv
 U7AS7S8fRIuNapcEZBUKhf0hc5zgM6Qxh3IX3j5DI7xqtrbw+5U59n7YqvVr9eLb
 o2pk6w9RLkD1Kn11zkVaLiIyoQ6NMb2tNT4ZDlsD7z83FEY1xlRBxMAlAegVDNag
 eBLskxRV3SInFBcubvR/RXaHaLeEGq7cp6g8Kkc93EvinsPUUUjyXgkoQnDbg+bf
 KnjzEWjFBqqA16YPtlfiwZ8hqmS8gO595NUEBKdn1iWK7WJd28OomHtpceA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkdpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915767b341eso880112485a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181267; x=1781786067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3+hg7CD2aE+8MtDu9XIz3W62m6/gYV7CTzdEVS2dvo=;
 b=GYdpsVT1eUbfIx494egxS77lB4v2pkwNN111ZkGbCY9mvgLgdZpp+hroeo2oImc04n
 NguGFaWZ8s2fCwaXTR4OJTWqWWqRjNQnTnjJ4jZbZRcNn33UkZIR8/+CNTO5xOUWXVoN
 3XPyobaXocAurloSuK84VSTXOZ6rN66391T9HmIDcCJQYgYVOtrv2UjsPyAW8pkY2MrZ
 gqqOy455NjB2o9yW+owNHM+CNWpO8ehN1MnbANzvFh2yv3+p9BR4dknDOwvuW/ZeqMlN
 SqTNet4r+QHnTcClmrNHqS5hlH7hrrKJpp3HoftJlXJIydQ3A4n8WKKKLS4m5pIm+Jnv
 1U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181267; x=1781786067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3+hg7CD2aE+8MtDu9XIz3W62m6/gYV7CTzdEVS2dvo=;
 b=YjB18+vwNUUYmowzrZr2eR+M/9A27PJltSHAuwcHVLcENbykwLyPFHECfaJRw3WncE
 VWAAxXFZzNTvQ1w0Tor0M9WFLbivUQbYV7FCawF0j/kXmF7mPvhiUvsGOAv1a7mkGceH
 TI2rIyogjPmalF7qTaZ+3sYh+i7QCMwQ+3/D6SJ1aGNqw3yPmd2aToCmXqI4QybD9lVb
 YoVclDfMQ2PnL05meoOUt3UbTj0Mhdan8m8SVTjhBa2tIAwvpVzPSZrqQOBJ9c0EZve6
 rIHoF+1vBAjYO53la343KolrbMwTWJ0C2iHg0dRMq6kiyYcHznJAqerQcWz6tzXtjYOS
 473A==
X-Gm-Message-State: AOJu0YwZV3E73i6qBDjgDrbPCq7XD529w1eEQP4emJ0dKARqQJuZMr/Z
 SPrxRDwAWhROV65kqZ969A2eb1A93/NKEnpLONYQPtV6mRzNIom89dgiM03IotXF+D1O1aXMxzv
 80emsVISuJmaG0rwREI5eqK/7Dd90lclc9t4fKn0Kek5lzIUqYPnqqrH2KJ1eHuPHgg==
X-Gm-Gg: Acq92OGxuy0q41aDr/uGxWYAi+YV48WqPGLm3pf4TplYuu//HlTztkN58/UaPn6UqFS
 EhoLi8dH4gObQ8vSgAOgwbqVgGPMbZ7dmCKY+ND3LtCDtymUxfiFzlCeuQhmdhxlHR+How3z6kF
 GQdqw5ug6X2WM1spasl7ChzwXYshzlHrvDHeOiAWlc71fqV+VkPKRhatddi36oEoH5fN4ZSFbQY
 8yQz0c15rjrp1pNJ+I434IVJLBaQWU8bPc+Ox1i0844UAuNmmosMRX7OIpaUjRVbHH0EjaCK21e
 9Uvdnmx+J/XK63Uu9ZPJ1XPanRPj2ZdjT6GVmp8gHDNhXifGc99MNhg2emEHOAAwd/nSEIOzHBv
 WFeFa3+OtGIGTobTX3BOh0Gcbl3695EGU9ZwYYO8Pwb2Ge7kaACWZArJw6oyh1gMFxwQ/5h74Z1
 fZ+wZKgSs/P1jCeSTK4g==
X-Received: by 2002:a05:620a:6486:b0:915:fce2:5225 with SMTP id
 af79cd13be357-9160ad48a9amr306069485a.45.1781181266834; 
 Thu, 11 Jun 2026 05:34:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6486:b0:915:fce2:5225 with SMTP id
 af79cd13be357-9160ad48a9amr306063585a.45.1781181266252; 
 Thu, 11 Jun 2026 05:34:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (201-26-7-9.dsl.telesp.net.br.
 [201.26.7.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160acd7904sm181042185a.21.2026.06.11.05.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:34:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 2/3] target/riscv: dynamic alloc of debug trigger arrays
Date: Thu, 11 Jun 2026 09:34:11 -0300
Message-ID: <20260611123412.2135600-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXy/57QNLSaqpA
 QJPMgKJ8xjm+a54B2sMkFDLbyyyLpkTW6jjSAVwdoYiiediAHKSkjiPy6z74CSDsikjYxaMNjYM
 O81pAEEWYeb2oWMKct13xea2ALki1JRj+wyuZD2V7gYqxLiZ0DskR4y+nyFOZ4GUjA33Sy55nRc
 joqpbcu3HGfZmEKNXz9Rv/yKkhu0FIox6SfsoW9nkbYUD0AKjziC+RRY8WNIF4GdOY9cBBoBkCt
 SMqZu5Bi7pQVOrSNSkzKuw0APPbH/rBtIyUqQcr4fpPdXjGvQ9P82itG3DXLeqRlPzuYlBxauKG
 +rw17FSNeUcynYKbsdOLu2QJq8fa9ucrC5VEikBhSyR7d26uIAZRCqAuPJdD25tEDIORI+3hpil
 SaAwNbsaTw1B8whCVfFmyMkN8bFjCeIhNKKQCbwhGuJrOBR0t7zo/KDmTDPxjSm2zlDRuwrV7rB
 lnzu+1+84217a9H2r7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXy7Eko48YQG20
 SPnvxJuP9yLb+OeuaUU120054YCDYaiQDNt9Qnq3ESxG+lq4KrGnxJ1Ox+Z8zrFV9JedWCkQ1/6
 5I+0kwtcBU6GVvk4L4QCwkgoDgzR9V8=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aab54 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MITIYaLR+oYcSln1dApPwg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3hYV-RIbpzt_YiHVFz4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: SMitxfwfrvfM5AK6vOaWu5v7wgY5nXRz
X-Proofpoint-GUID: SMitxfwfrvfM5AK6vOaWu5v7wgY5nXRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The debug trigger facility consists of a set of arrays: tdata1-3,
cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
cpus will have 2 triggers per hart.

The RISC-V Server Ref demands at least 11 triggers per hart, and several
CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
we need to parametrize the amount of triggers and make it configurable.

Before doing that we need to handle a situation faced in a previous
attempt [1].  We were unable to set the tdataN array length in
vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
regardless of the actual amount of triggers in play. To fix that we need
to change the tdata arrays from static to dynamic, allowing us to use
VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
have the opportunity to turn all trigger arrays into dynamic allocation
and reduce the amount of stuff being carried by CPURISCVState, or in
other words, we can carry just what we're using instead of a static max
value.

All the forementioned trigger facility arrays are now dynamic.  They are
allocated and freed during realize/unrealize, and their size is
expressed by env->num_triggers.  All relevant code is changed to use
env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
array.

This will make it easier for the next patch to parametrize
env->num_triggers.

[1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c     |  6 ++++++
 target/riscv/cpu.h     | 18 +++++++++++------
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
 target/riscv/debug.h   |  1 +
 target/riscv/machine.c | 16 ++++++++++-----
 6 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5b2133d811..b20271a220 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1015,7 +1015,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_unrealize(DeviceState *dev)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *cpu = RISCV_CPU(dev);
 
+    if (cpu->cfg.debug) {
+        riscv_trigger_unrealize(&cpu->env);
+    }
+#endif
     mcc->parent_unrealize(dev);
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11cd710990..ea92e2c68c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -467,12 +467,18 @@ struct CPUArchState {
     /* trigger module */
     uint16_t mcontext;
     uint8_t trigger_cur;
-    uint64_t tdata1[RV_MAX_TRIGGERS];
-    uint64_t tdata2[RV_MAX_TRIGGERS];
-    uint64_t tdata3[RV_MAX_TRIGGERS];
-    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
-    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
+    /*
+     * num_triggers is the length of tdata1, tdata2, tdata3,
+     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
+     * arrays.
+     */
+    uint32_t num_triggers;
+    uint64_t *tdata1;
+    uint64_t *tdata2;
+    uint64_t *tdata3;
+    struct CPUBreakpoint **cpu_breakpoint;
+    struct CPUWatchpoint **cpu_watchpoint;
+    QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ec931a8c3d..82afad82db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5436,7 +5436,7 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
-    if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
+    if (env->trigger_cur >= env->num_triggers && csrno == CSR_TDATA1) {
         *val = 0;
         return RISCV_EXCP_NONE;
     }
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 30d39ee5cd..9a4910c431 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -172,7 +172,7 @@ target_ulong tselect_csr_read(CPURISCVState *env)
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_MAX_TRIGGERS) {
+    if (val < env->num_triggers) {
         env->trigger_cur = val;
     }
 }
@@ -701,7 +701,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -721,7 +721,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -750,7 +750,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -950,7 +950,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     int i;
 
     QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        for (i = 0; i < env->num_triggers; i++) {
             trigger_type = get_trigger_type(env, i);
 
             if (!trigger_common_match(env, trigger_type, i)) {
@@ -996,7 +996,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     int flags;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         trigger_type = get_trigger_type(env, i);
 
         if (!trigger_common_match(env, trigger_type, i)) {
@@ -1049,19 +1049,49 @@ void riscv_trigger_realize(CPURISCVState *env)
 {
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    /*
+     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
+     * itrigger_timer dynamically.  This is overkill now
+     * given that they could be static arrays with RV_MAX_TRIGGERS
+     * but we'll parametrize the trigger number later, i.e. the
+     * array length won't be static.
+     */
+    env->num_triggers = RV_MAX_TRIGGERS;
+    env->tdata1 = g_new0(uint64_t, env->num_triggers);
+    env->tdata2 = g_new0(uint64_t, env->num_triggers);
+    env->tdata3 = g_new0(uint64_t, env->num_triggers);
+    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
+    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
+    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
+
+    for (i = 0; i < env->num_triggers; i++) {
         env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               riscv_itrigger_timer_cb, env);
     }
 }
 
+void riscv_trigger_unrealize(CPURISCVState *env)
+{
+    g_free(env->tdata1);
+    g_free(env->tdata2);
+    g_free(env->tdata3);
+
+    g_free(env->cpu_breakpoint);
+    g_free(env->cpu_watchpoint);
+
+    for (int i = 0; i < env->num_triggers; i++) {
+        timer_del(env->itrigger_timer[i]);
+    }
+    g_free(env->itrigger_timer);
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
     int i;
 
     /* init to type 2 triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 55a3ac72e6..a25d099b37 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -148,6 +148,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
+void riscv_trigger_unrealize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6e70b145a5..ba96ceceef 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -240,16 +240,22 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(env.mcontext, RISCVCPU),
         VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


