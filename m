Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D4DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g7-0003yH-NX; Wed, 14 Oct 2026 14:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3g0-0003wc-Qe
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fy-00020b-N3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4Iob4167121
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5sNZgtMPHxw
 WtwY5H8fdwEN8lH52eYtZEEq+xWps9GQ=; b=Jjo3jmkDxALtpqr7AxonoHwOnTh
 FokurEM81blq60lhuM9rfIO39iqCR/k+A54/HWHKR3+C4r0uIXC/P4U/NJzbqdds
 3dH+nhdBxMQzukcBKFFCQuLQpSBPvAzBPTr35mGAZ6+3hjwtSFwSXwkh9d8GZTDU
 0qzfnVdp9hqd75JayTVNb9gnd1T/c01sG4zW3oxXwS3hEzzvAVG+vrle3i+pT3r8
 2wfLrmlFbIiTaqjv56HhSwwyTAApYjCJAarp0MOBLUVNo4DWVbcjCGeLDpOJyO9S
 W/++ABsDtsEzyv8+roHMfOWv/A//W7jpIZWQ2Th0BpVGucZ4gaI0PwKtBjA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230tjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso8236845eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002365; x=1792607165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sNZgtMPHxwWtwY5H8fdwEN8lH52eYtZEEq+xWps9GQ=;
 b=T1R6aNRxwS9QkrNUiTY6MAaEOIoSbsZX/YN1+MX52a5YWZchpXemjK0PQdSzhObmpT
 l42968vlNmwOVR1VQ1H+UNoZwIqMgqjQYR2SRcQKvCetHw0m8zLTTTT2ocxOwXHAS4Iy
 wk9K6ZZZRRNHyTQPdKbCVjW7vLwxTc8ifrN9Nc0Q9eHvRsKiGUVH7CC0jTZzEoH+hz33
 pyK34X06dF+PCi6hNtlLUeyGL2J9th4k0CzczkpWXo7qFBcm98WRh67/wa6tHK5RLtTp
 DF+KovvYnDWWXXZ14jwvNizsRkjoEeNI563IEAwBj3wudkKlSjY5pu4zQctg7CJQgnYc
 J3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002365; x=1792607165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5sNZgtMPHxwWtwY5H8fdwEN8lH52eYtZEEq+xWps9GQ=;
 b=r3qqI/hpoyS+gZJUcZCO9PCegVH9roHkB2Adc4LTrp44++Re8mgN65r9rKZkznAwsG
 WLbCCj+RAM4rXHo/mOJNOPQ4QIP2Sk9uyaRrz8z36osJ32KM1LUc7j6/d6f3CwUD7IXx
 jueVLizZsMX93usy/nvl+O2halU6zLsDCZTv/RS3Xnv9KGekUZ/N9KSqf/0wHt2RZFEZ
 6yf/XDJcTBtgDf6STkVC772db4+ubLnmzHfRY3YRU/1hw3hjA0fGnUxI3qml7Qxm53FB
 sJgiLXXTF8S+E93OzxviaDfiuQTE0E0NciZs5x6ZP/PHBaBDbOvEaLSAJW9+HWJ698bs
 RLfA==
X-Gm-Message-State: AFq9FYLlHpgAilOV2DtF7uUd+gCNbwKGzeZwv+hLSSKBA4V/5Z5A3ckJ
 X2T9VTVoqZdCl6tR5fNS9a/BXwQwYZS0xfdpm4jZ27MOH7la9gjxyJnaNhLOC9Nn/rLbEW7syVv
 iW59JPA0zWnYZ6u43LPakHEswEZtqueiMw9rMERx/XbLGs79mbAw3E6a39OtfDx4Raw==
X-Gm-Gg: AYBFou2n6YVT/12bHqlkXf8di7EdIdz1tycHwNJynQG5R/z7ni8DKmJfK6nlJUOI1N9
 UWcqfUhXYjFs3Vxoc94LqB9RdFV702clRqX94+rLmlrLm18JXswNi/+vmnGqREeHZd0XGJxVMxi
 VTHK6Ek3SfQw7xvMSLNtVnTYjjk49XdNYa+iE1AFTCFKFqYESTGWOkigZXMfJdHWyzRt0KKJWGR
 2VEDnoMSVc+x1CUU6HXj9z9z3FMtq79HJhMV8IwpRr7vYBd3sYLk/JG8tH0rhuuKAcOTQF2eZOO
 xELNFM7Fjuqqsxz1ZSjUddjGh3hVqbHwMYm+hiezcPNoXFbltNzmuRfdMITRDHJUAC+DyVwNIFP
 gOzF8JTkOzEdWRU3Ha/D+mUDPP5prAkw2TbOTAV44olDvzpaG40WTnD3tOFJH
X-Received: by 2002:a05:701b:458e:10b0:14a:9dc3:dd11 with SMTP id
 a92af1059eb24-16a5d642d8bmr23240880c88.18.1792002364446; 
 Wed, 14 Oct 2026 11:26:04 -0700 (PDT)
X-Received: by 2002:a05:701b:458e:10b0:14a:9dc3:dd11 with SMTP id
 a92af1059eb24-16a5d642d8bmr23240846c88.18.1792002363854; 
 Wed, 14 Oct 2026 11:26:03 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 09/11] semihosting: use new semihosting ops
Date: Wed, 14 Oct 2026 18:25:41 +0000
Message-ID: <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfc93d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ECcYt3gxA-2smbPpJpQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX2ttCLXNXFJe+
 Nf09sZTuktB8MqX7mM9VsRjlu91pj1vLGsui5FqPSqFMTV00d0EB0rwhufRRf1w9qUBnHfsTO/4
 SKKixqDkl5lil7mLFwpu5h5p7DaOfbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX1vGtz001yOu/
 +ksbW7RnYKdwx/f5jRC3vXO84PWWeCutILPag76VeZo5Y3oPL6hUEdKmHBiHkc9es5RYZ6A3jqE
 zsaiiGJMZNvxNJ8byREfWNPzbUyf3JweHZO/fuDY6XRHOuruQR8lHU3ECv/fdMNOx4/WWNqenUZ
 W/hYh9ZWirhZ++78A5XaAvj/asdRT1svPo46sVoRb8B5CB1rX14AIXyO1bu9WeKy5I7mkNo7q3v
 cu8BPPEkFTLdfrXRn5ajc0v2J/EPQ6/u0jSiVqJvhA+dKOmdH3Q2Np/GeoRN7AXjrkrzGFbqRZX
 2KDEjx5GlPDIv66TO0Ygtv3dvkx2aKOQ8PkI8lyI5CYoZIQbSx/U0zodBAvkflHmiuIOa8tyRxn
 HrNOX7gkDZ4FzCfTRiP5XBJBFiLn1DyJkrYmiMAcwHnE29B9TC9l/Cwn82mXxXJweAneTMucKv/
 ZWb4JhTFULKBCSZOWzg==
X-Proofpoint-GUID: F2SugwwRQLnRDR_dNF5a3Dqk7qC1XRE9
X-Proofpoint-ORIG-GUID: F2SugwwRQLnRDR_dNF5a3Dqk7qC1XRE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
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


