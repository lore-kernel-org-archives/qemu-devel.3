Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E2CCA466
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBV-0008Oq-5b; Thu, 15 Oct 2026 15:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0008Lg-NU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBC-0000Xm-Fl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3PjF406119
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z/p/bFCIDuQppJTciTHpAsYjU+prZa67GiAt6palezs=; b=N3R3wjhIFZVqk7+O
 EOuFGYEXRWGHZJIln0ZhljDMXxclVnVFVlFl40r4WrtTM06cLHaBFovPH1ACH864
 5rNfj3PicIbjGvQBzAk0furWMz4UQLUYc0BzmDf6EmNnJTJ6qCBp7Eec8wJbu1/9
 hhnyE6k3I+VkmBTpwdxmyHDW0itflo6TXAVR3EzKnaeFasrk2ZpbLqCrWhdQ68ty
 VfRmGI5C+egt4Wys1mba2yylW9X6iT06+QofsbuEZp+Y19HGf5h/+D/DwKJjlgMP
 pWai7O2lWzd4Y/ibAWDaK8hG/VeqXiA1y3AouVIv9UiTPIeZ1Qk7yhqxHv73bIRB
 cq6ydg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09rx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so12229938eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092712; x=1792697512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z/p/bFCIDuQppJTciTHpAsYjU+prZa67GiAt6palezs=;
 b=RjlFOUIYqjArmfRcRd5EJW4nqINa1QhjW/hgGTtfK9xsSXvO4m5/5Rk+psGvejsDU3
 rl4PMA1OULirCM0Y/E1o4ye8E0Jz6vhPgc1Hqfno+/bNoeJEEjPcKHlipbPZn/YLP5Er
 K9bCLt4XQ1kZAC5D/T3Ouw+BHNLUGGhixyIrz5fvysyyVXMIpdhTJRJtYjzIIK93rIPz
 a2MI5B8/RQfRuY27wdxLNiksMrPMw6pYiooXDz9V8BdAbsmgDof1/t0CvJU+Dqp7UK1I
 /AtVMgkD0KEhPPYGcgDSWufl9kQzKuo6BhHQlAmPxW3KiZanlNAsDF2/rkxM2W0sHJxQ
 dsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092712; x=1792697512;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/p/bFCIDuQppJTciTHpAsYjU+prZa67GiAt6palezs=;
 b=EgOT919RABkeqaVvT1mc2E1X3QdoEfxMwSX4dc8RKXUuOWOgTShwFe+dwIPD7TprVs
 Vg2wmbGQxCcEIMWUC5lf+gz11reFigVlAVxJsZ2d2XiU52AnUlF4aWWpl3IZDZMnbxSF
 yNE6XWVbCKhQqdLAIQ/VNA+5l92YYYtKkrG+/GMOaTyAgysBcWyTZV6Awltkr/kJKIle
 Rw5JUSfog1+J/I8f/+h6Mp45LdUtlwxOld+I8s6kH79umWOG2jYbNQR4iQFkrRi0XwI4
 Z0hYtRD2kwg8N89WOC4Av1pl/7yNWI3a4A9S8ZuJFy6BzOT+XLMpbs3weImYV5GaDFxr
 /oRg==
X-Gm-Message-State: AFq9FYLjAxD00fGHcaOfoAoWUxseoTp2xgoZmyyYyIngdxZXNSc4/WkB
 seBnprx/BzTK8Bh/pet0C6g/eq1Qd29TmAtSmAisdLfm5ZcfXxMXNuFzrlYYfgaI4vPuOsMWQVt
 k6LeLWhNsou/lVFP/N1sz3+sztct+yQ9mqqMIjWl02AadpIhfp1tTjI3eeYgVVSdcSg==
X-Gm-Gg: AYBFou142JGsFogictr0AglznDs+gMImsU0k6fHEa1AFox/K1DB+W6Ld3TfbpcE4vto
 K0WfZp5UihdpJU86+hprJzMWCOeyP7NizCHktwDtfqOO68g/niLDjj7gTdNeuNyfrO0nbgyRpqO
 LtksExR6oHC8MPzyt/diiHKXNsu7Z+hyxt9Ry3LXj88m7bqQ6Zpd25Ybs4BOf2seQeONqtXo7iz
 O0TigRJq08ek7MzYjZ5+q3we8dNfCfZV6MHma1vrnhRY13MUtc9xC7MOU/TwNL6oe6Fy9Dt05hf
 cdjj/TRzeX5wTenjm+BaJ3i9sqzmDWriNpfBNu+xZOdz1tuPH4CnAlzArp6cMkytYKkAu/l+4kr
 osZObUQFWrVpLuFn8x/HeDh8xpVCba1DSN0I7yqrTdyRj9qBrvabnAeyVhR6n
X-Received: by 2002:a05:7301:9f0e:b0:353:417e:aad3 with SMTP id
 5a478bee46e88-3537e069fa1mr36429330eec.33.1792092712007; 
 Thu, 15 Oct 2026 12:31:52 -0700 (PDT)
X-Received: by 2002:a05:7301:9f0e:b0:353:417e:aad3 with SMTP id
 5a478bee46e88-3537e069fa1mr36429255eec.33.1792092711213; 
 Thu, 15 Oct 2026 12:31:51 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/20] semihosting: use new semihosting ops
Date: Thu, 15 Oct 2026 19:31:02 +0000
Message-ID: <20261015193112.145326-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXwaXNP8SdLGw5
 qFaO0rWB6QgFr53L4E2McsBqr6/pWVx1JikWHh+XkX1XDB81M9TELxTZALxsM4RpjjFi0tzKlKe
 hwpLsJZucXMDbyH9KEDMi0G5WML0Dk4=
X-Proofpoint-ORIG-GUID: T046DG7wUYVVtO1g-bn0tHUX0GfiYOZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXwOj27zz1Y1Ml
 tLm5pTjY9wUm6+BUh63UjvR2SJ9S0itHqMocbl3Pi5+iUvfWGXJlwrprAmJ38B7icS6lyj3hVPy
 S8DdBrBn2EeBYdF72PevwSeZ+GJJirEZAkGGneDf+QP84c4xEkDXlbOu/mSCBzNnDRUubuDrpQh
 ykr5t0fKAhoT9oFY8bV+3rfLea3e+GmcGyOlluwF3omr4lYtSEfufnoqxd5lbltgaVEAzNHgDTu
 HBM5XAsPA1dORrgAYqI7G7uuETLIRf4yH6uq5hl3ko+ZKWUJnV8fG9cMOXJCT8Mqn8X5lmFITdv
 drlkpRnsTFkMrjZxfQ26Jg53PodTe7pherQ41OTsY7UkUK+soPpNbxjZObAPxgen1ZKWBu+ef+i
 iUF5GWEOoI/cOb8Ln8ySNwAtZQEEta9xKVpNsu7iPx/LbeS+gK8n2lYN4df08u6lpn1h8flGEQi
 4mmR7lttxYnTBjYuSKg==
X-Proofpoint-GUID: T046DG7wUYVVtO1g-bn0tHUX0GfiYOZp
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a29 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e19n-G9kEiEojgAQi20A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Now that all targets implement this interface, we can replace function
calls with the new interface.

We assume semihosting ops are set on this code path, and do not perform
a NULL check.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 semihosting/arm-compat-semi.c | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index b930a028649..3117eadb3b7 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -188,7 +188,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
  */
 
 #define GET_ARG(n) do {                                 \
-    if (is_64bit_semihosting(env)) {                    \
+    if (cs->cc->semi_ops->is_64bit(cs)) {               \
         if (get_user_u64(arg ## n, args + (n) * 8)) {   \
             goto do_fault;                              \
         }                                               \
@@ -200,7 +200,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 } while (0)
 
 #define SET_ARG(n, val)                                 \
-    (is_64bit_semihosting(env) ?                        \
+    (cs->cc->semi_ops->is_64bit(cs) ?                   \
      put_user_u64(val, args + (n) * 8) :                \
      put_user_u32(val, args + (n) * 4))
 
@@ -237,10 +237,10 @@ void common_semi_cb(CPUState *cs, uint64_t ret, int err)
         ts->swi_errno = err;
 #else
         syscall_err = err;
-        common_semi_set_err(cs, err);
+        cs->cc->semi_ops->set_err(cs, err);
 #endif
     }
-    common_semi_set_ret(cs, ret);
+    cs->cc->semi_ops->set_ret(cs, ret);
 }
 
 /*
@@ -249,7 +249,7 @@ void common_semi_cb(CPUState *cs, uint64_t ret, int err)
  */
 static void common_semi_dead_cb(CPUState *cs, uint64_t ret, int err)
 {
-    common_semi_set_ret(cs, 0xdeadbeef);
+    cs->cc->semi_ops->set_ret(cs, 0xdeadbeef);
 }
 
 /*
@@ -260,7 +260,7 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
 {
     /* Recover the original length from the third argument. */
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
-    uint64_t args = common_semi_arg(cs, 1);
+    uint64_t args = cs->cc->semi_ops->arg(cs, 1);
     uint64_t arg2;
     GET_ARG(2);
 
@@ -268,7 +268,7 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
  do_fault:
         ret = 0; /* error: no bytes transmitted */
     }
-    common_semi_set_ret(cs, arg2 - ret);
+    cs->cc->semi_ops->set_ret(cs, arg2 - ret);
 }
 
 /*
@@ -302,7 +302,7 @@ static void common_semi_seek_cb(CPUState *cs, uint64_t ret, int err)
  */
 static uint64_t common_semi_flen_buf(CPUState *cs)
 {
-    vaddr sp = common_semi_stack_bottom(cs);
+    vaddr sp = cs->cc->semi_ops->stack_bottom(cs);
     return sp - 64;
 }
 
@@ -330,7 +330,7 @@ common_semi_readc_cb(CPUState *cs, uint64_t ret, int err)
         CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
         uint8_t ch;
 
-        if (get_user_u8(ch, common_semi_stack_bottom(cs) - 1)) {
+        if (get_user_u8(ch, cs->cc->semi_ops->stack_bottom(cs) - 1)) {
             ret = -1, err = EFAULT;
         } else {
             ret = ch;
@@ -385,7 +385,7 @@ void semihosting_arm_compatible_init(void)
  */
 void do_common_semihosting(CPUState *cs)
 {
-    CPUArchState *env = cpu_env(cs);
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     uint64_t args;
     uint64_t arg0, arg1, arg2, arg3;
     uint64_t ul_ret;
@@ -393,8 +393,8 @@ void do_common_semihosting(CPUState *cs)
     int nr;
     int64_t elapsed;
 
-    nr = common_semi_arg(cs, 0) & 0xffffffffU;
-    args = common_semi_arg(cs, 1);
+    nr = cs->cc->semi_ops->arg(cs, 0) & 0xffffffffU;
+    args = cs->cc->semi_ops->arg(cs, 1);
 
     switch (nr) {
     case TARGET_SYS_OPEN:
@@ -494,15 +494,15 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_READC:
         semihost_sys_read_gf(cs, common_semi_readc_cb, &console_in_gf,
-                             common_semi_stack_bottom(cs) - 1, 1);
+                             cs->cc->semi_ops->stack_bottom(cs) - 1, 1);
         break;
 
     case TARGET_SYS_ISERROR:
     {
         GET_ARG(0);
-        bool ret = is_64bit_semihosting(env) ?
+        bool ret = cs->cc->semi_ops->is_64bit(cs) ?
                    (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
-        common_semi_set_ret(cs, ret);
+        cs->cc->semi_ops->set_ret(cs, ret);
         break;
     }
     case TARGET_SYS_ISTTY:
@@ -533,7 +533,7 @@ void do_common_semihosting(CPUState *cs)
         len = asprintf(&s, "%s/qemu-%x%02x", g_get_tmp_dir(),
                        getpid(), (int)arg1 & 0xff);
         if (len < 0) {
-            common_semi_set_ret(cs, -1);
+            cs->cc->semi_ops->set_ret(cs, -1);
             break;
         }
 
@@ -542,7 +542,7 @@ void do_common_semihosting(CPUState *cs)
         /* Make sure there's enough space in the buffer */
         if (len > arg2) {
             free(s);
-            common_semi_set_ret(cs, -1);
+            cs->cc->semi_ops->set_ret(cs, -1);
             break;
         }
         p = lock_user(VERIFY_WRITE, arg0, len, 0);
@@ -553,7 +553,7 @@ void do_common_semihosting(CPUState *cs)
         memcpy(p, s, len);
         unlock_user(p, arg0, len);
         free(s);
-        common_semi_set_ret(cs, 0);
+        cs->cc->semi_ops->set_ret(cs, 0);
         break;
     }
 
@@ -572,7 +572,7 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_CLOCK:
-        common_semi_set_ret(cs, clock() / (CLOCKS_PER_SEC / 100));
+        cs->cc->semi_ops->set_ret(cs, clock() / (CLOCKS_PER_SEC / 100));
         break;
 
     case TARGET_SYS_TIME:
@@ -587,7 +587,7 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_ERRNO:
-        common_semi_set_ret(cs, get_swi_errno(cs));
+        cs->cc->semi_ops->set_ret(cs, get_swi_errno(cs));
         break;
 
     case TARGET_SYS_GET_CMDLINE:
@@ -734,7 +734,7 @@ void do_common_semihosting(CPUState *cs)
             for (i = 0; i < ARRAY_SIZE(retvals); i++) {
                 bool fail;
 
-                if (is_64bit_semihosting(env)) {
+                if (cs->cc->semi_ops->is_64bit(cs)) {
                     fail = put_user_u64(retvals[i], arg0 + i * 8);
                 } else {
                     fail = put_user_u32(retvals[i], arg0 + i * 4);
@@ -745,7 +745,7 @@ void do_common_semihosting(CPUState *cs)
                     goto do_fault;
                 }
             }
-            common_semi_set_ret(cs, 0);
+            cs->cc->semi_ops->set_ret(cs, 0);
         }
         break;
 
@@ -755,7 +755,7 @@ void do_common_semihosting(CPUState *cs)
         uint32_t ret;
 
         if (nr == TARGET_SYS_EXIT_EXTENDED ||
-            common_semi_sys_exit_is_extended(cs)) {
+            cs->cc->semi_ops->sys_exit_is_extended(cs)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
@@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (is_64bit_semihosting(env)) {
+        if (cs->cc->semi_ops->is_64bit(cs)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
@@ -796,12 +796,12 @@ void do_common_semihosting(CPUState *cs)
                 goto do_fault;
             }
         }
-        common_semi_set_ret(cs, 0);
+        cs->cc->semi_ops->set_ret(cs, 0);
         break;
 
     case TARGET_SYS_TICKFREQ:
         /* qemu always uses nsec */
-        common_semi_set_ret(cs, 1000000000);
+        cs->cc->semi_ops->set_ret(cs, 1000000000);
         break;
 
     case TARGET_SYS_SYNCCACHE:
@@ -810,8 +810,8 @@ void do_common_semihosting(CPUState *cs)
          * virtual address range. This is a nop for us since we don't
          * implement caches. This is only present on A64.
          */
-        if (common_semi_has_synccache(env)) {
-            common_semi_set_ret(cs, 0);
+        if (cs->cc->semi_ops->has_synccache(cs)) {
+            cs->cc->semi_ops->set_ret(cs, 0);
             break;
         }
         /* fall through */
-- 
2.43.0


