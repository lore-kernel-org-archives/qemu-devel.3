Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A804CC6B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Al-0001QB-Fq; Wed, 14 Oct 2026 17:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Aj-0001PW-IA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ah-0000il-Fy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMii91682646
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WGnEJ78Boc7LXNm6t4FBYciEvL3cwRlOovNZLHHmiLc=; b=nBhJvfVm/P7XjVSW
 hQQsp9FT7lYtsQrtMNfS37BqH5eXQCtxzYcaGNUViRoatDk41ax7M2ggYHIcs1PI
 rv5svDEd5n+ges070Xd8YADT/uG6Ni4Ewv1RvF+gu+7qpQ4syZk0G7ViKhDR8vua
 fW0BlTG/60iYyoshYOGrnq/rks9k4+M99f6Ad+2OrdnImQiF5kjgWphRFp1WHJIb
 2WMgdplM/YQLP642HsvJEayzQEaZNPxy/pXkCF5Dnyv39th6AF5SrFltOsjOEA4t
 FIlUFwEB7eGLWOxjF+pWB/FgUlncCYR5b89Uu3Pv+6woC2KbTobG+Q1D1cdUJBOy
 6IRVvQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb018w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6753131eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011957; x=1792616757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WGnEJ78Boc7LXNm6t4FBYciEvL3cwRlOovNZLHHmiLc=;
 b=i7SRCcQIz3vKpsh3jrnQijAOkCBeBl6Uag7e56lXl5w6ba7U1mj90bUOyll3/J/BUw
 wfB7f+Q5VAkvTCV9SaeRgw9njSzWFbP+L1nAW0Qx+9xl1lkqkKcOKTuP4RY68cA2JkiH
 JIoz8299iiC0T59XbRBVcHF9jNMIFbhPzzC7vQRxJixoXvqS4y/PZhFzNPHW0FD+VJqu
 RskyaKgV4Ble3RaoyVcq9QY2q5ZATGtLv5qguW1k7gimNZBuhdvuOBkzIEaq7sAAKJNf
 iJYPkVK5hYpHSp4MSSHNbhRp5KO5nWDJCCfxUJUCkquFUTZzSUzoKy5sWSgwy3CGkWkL
 BICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011957; x=1792616757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WGnEJ78Boc7LXNm6t4FBYciEvL3cwRlOovNZLHHmiLc=;
 b=oh0D2ja0ga1zRW48REFtO3cjgPGeYcu9P3p1YsTdP6BEYPG1TqyHO7O22iv2eipBYj
 nvQRa5XoagjXpyGs0LWan7EmeDtl61B7qfXmW+Qk+GAEcb1GdnRX5Nmqj5oBXhOWpB85
 JxJUA4SAetDuwbk+70JPl7/09lrp6HubeIi7OZW+AmyWCK+2bgZup0sP99uVq8tTcfLz
 0yI1sMDMjF8fa28kHXEp8ndB74Xim/pFSnBv3ls/qZ1OwrBniyXSGntpDE5QYPyEEGx/
 FNCgT/L80fEaHSjio6PqTiAqWcPyWu5IAMk6Un/x8OeLpgO8D5uZZxlebbHZsdo8BXfk
 AA9A==
X-Gm-Message-State: AFq9FYI9nlUVrMMfLSDuqhkqtW++48CXKN5Yx4LAXoESSz2YMN4Tknzn
 a3tR6utaiQRt/VC1R0jzJ5jn55+4pxu10kdrnfeRDN8tH4It7uJ4+fU255NdhWeYLAkO5w48vLb
 g/HcHERQNF8ZdLNwe/LuVdeshzdb8iPPUdKQ3M4Ov+gCWVIIzvOld4AF4pMe1gwxeow==
X-Gm-Gg: AYBFou0pYa0D2M8gH0fT6a3tylec6VwI0HngdoEJ0cCCQ/oo5DCUy7LhNqMTR+szCRx
 oUG62rD6PA5HhDJG+4ym9shDnOYRNcQUlepBFyvRSPYwvuNe7LHRRwSXPDpULevVoBsLvfKPwsZ
 yeRnIFpuntIvIcgm2pg3Un1kpeotID/aZgfLVi4itUVV6Kb8V457fW+s3tZaF2YOXsy04A53Nvs
 GJhxLN0IvWuBrKeVonimkvpsbShOAO2862O50cXXdQ67yfDddLWyAcg4Y+C4dRZ2wmFG4ZLprHX
 KhffxJ9Gk7Nhlw2uW+zC6L7P0Vy3CFfEC+rU8WjnBrI14xcmbQYqXB/SQqRzMnmcFoTCzJLiihF
 sd6/yio6aMEz6w+OSka9ZprcYkS2slAeb37LRg/Tp0R3Ut2Cqvi/lRKsyiMhw
X-Received: by 2002:a05:693c:8951:20b0:35b:782c:aa31 with SMTP id
 5a478bee46e88-35b783bf575mr11387527eec.28.1792011957236; 
 Wed, 14 Oct 2026 14:05:57 -0700 (PDT)
X-Received: by 2002:a05:693c:8951:20b0:35b:782c:aa31 with SMTP id
 5a478bee46e88-35b783bf575mr11387472eec.28.1792011955736; 
 Wed, 14 Oct 2026 14:05:55 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 10/12] semihosting: use new semihosting ops
Date: Wed, 14 Oct 2026 21:05:24 +0000
Message-ID: <20261014210526.104215-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfeeb6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=e19n-G9kEiEojgAQi20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX2OuFmZdYX6J2
 mtPXnKIb3Vy5WqcIThS3DKgj7p9IK4bqgMPnQatQXho1bWMt9A3lFztXLT7TbH3PIdYrJ6moXZP
 bzGBIFkToG7s+Dw9Ax1BtXawIV7LEDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX8CgQqSvjvdyB
 8duOK/yIiLhZSmy+YgHaEfORQszVTLaRBf9/myJIFHKb9z0NN8iOz/MSqBVsprn8+dUozR8MgUh
 P7qr24EvlmY+dZaqx99VGboYVnBd07Z9puK7Dfn0BWwuJ8fBiZgcG/YwGUMR2G/bRb3v3aMrY4D
 aGdpr2i/3iw3TCka4cX6X3MvQf6AFWJ/fvOL+4CuY/xJYxi365zDpWA8KvWvKA0eYO1kRKIrQup
 qc53WdB2bxIOWx9LFjlhuFiZ6fD0qu34GZoucH0aAqWuWD5JFL+DHKPcmxZcfv7PN3f+3ZpFOSG
 QNNvwsi1Ihq57ZG+04AITzn1BnRiDGFV+M1zA4uQvRNI3PVKtHMY+dorAGvOslwzErfnNy2YBWL
 oqZMbxXaSxP5JxmHHnk936MDLSjII8r44x1YeKibjON3H0sCKamb+eklG4nlCXeReSSmrorEaZ7
 sGwcb6Um6QTJnJN19gQ==
X-Proofpoint-ORIG-GUID: mc1pkxsUqB_IL-qVUou-RrudUBxsD53_
X-Proofpoint-GUID: mc1pkxsUqB_IL-qVUou-RrudUBxsD53_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140084
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

We assume semihosting ops are set on this code path, and do not perform
a NULL check.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


