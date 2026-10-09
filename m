Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC59DCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSo-0006Zj-Tb; Fri, 09 Oct 2026 18:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSK-0006X8-Sk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSJ-0002dp-2X
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KiNsG1849864
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7oX7TVg0Rpn
 RFL+qetKSMYVFqsJHy/GthKLLVYhKmBg=; b=lxF0+rpq+iG42O8nmOXLMjBvOS+
 U+OvGoZtcOzvih1aahdlwISrO64nHGX7SynCOPPyFbj3U73HlxxvDW1u+G/+mLx9
 i+ZRzOFGEQ6PqXytVJnRr7OgRnfRj6g/CZPrwp8ZabKg05FMqV0pPZboGLVFfUcv
 oq+MLekofrS5q+6vteKqVXpsdvfcR7lkGACN16EIs9X7LZrjI7M2QOQDkkPr3pKs
 l8GRYAZTErR+wKs1WmyIMAQruiR3g47ttiKrUZM9kfJ9Kqlhb6G3nbn8GfLvycXK
 kxYT0Y3WxsRM5PZcbqeZVohAiZ05NVhFH72uRWrruwqn7xCncmsZURx5a7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74tbh1f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso7483042eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586365; x=1792191165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7oX7TVg0RpnRFL+qetKSMYVFqsJHy/GthKLLVYhKmBg=;
 b=JAzQPhnOcz8gle6QG6UtoCR299XW9SeE0V64xnWTjfFBicRloP4GUH3Uvyu7v/sXBi
 Pv8bVdtNckcZFdvUIzHqWRskx2Efdoj5JZy1q/YtdsW3+/Ps8H5+8pEzx8AJ44EJ570d
 Uq+rrZ36B3eqOnt8CZrmena0OA5r6gTPHEP0k5QyPiAL4OzdbQliqMbt7hSJ4As6r9FN
 0BoqHYU7A0voCMRNbLTNhp2E1mmzHhOARGn5rRR7PHyAhHw6SyOE20UQru8HfnMFE7Ah
 xSeHhVvnyyAROGN1TFuvI3LdqLq4nUnU7w9w0e2dJdnq9UA9sFsB497sP57EqRHrBZct
 quPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586365; x=1792191165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7oX7TVg0RpnRFL+qetKSMYVFqsJHy/GthKLLVYhKmBg=;
 b=xLUDsJ7Cin+lIUm9PYTl8AzSzkdgWXwENJZsqnLmYtJaeUwOwM1fUTHImjI0y9Leao
 MKAaGO4C3ef5d4Rs4ZnWGFWwjDVZ6NAfN3ox8a7vuu9wv71CKtKiWgh9Wjh8sqhXjoo5
 KXGwd9AvyhI60nofpBfBcWrwwYYcLWQ2L/U3ZMzWn6rG8D5MNHvepTb2pOWbPdXKjkKi
 QpVapyyab/u5/TJn37KYqndgHjE1yh9NsIEwIjHgkdEwqfxb3fs6+ZVZZgYUAfJUPUSS
 rhkyWywDcWawr8QDYwVUWuQ3xYOQIXrVKSYJ6jQsbcDoR3Q1TKQfpcNhW3hD2iaBPE5e
 bMIg==
X-Gm-Message-State: AFq9FYI+mpcyRKkIF7B2vBfQRaheKvmru+w9MD31IOsXbJUqjUOuCGMY
 GEeGn/eaOLww7LKU1ouYFAPj4MV1dM+CI5B19XZVSFaIAAf3a+lj9uL5YQYWdpzrcolABx9QrJC
 OV9FVjTutHIf1SeImf3wWa9u0czXMHVzhxGXYtTMKkhATQUiPxzS64R390diypQFiIA==
X-Gm-Gg: AYBFou1EwJcBaqzUTuWuriRTnb3mdnRUUfHy1s2yml73gHkVjLIlBDAEW/jpLjFfjLO
 pzuP7FtO1BkkJCus0n/mbOxixg0HEIVkIwtIU9L4Dk4Mxc6HxjhuzUdgPOQOFGLzLd7N5SbiMRS
 6aWng/ozXiX287G9e49H2iJo5xVYctv5K2yJZbnq3x6DoHd6/ZS4lHamKg+JHdt2Ogbm5QPLQ5N
 t/mZCVD3DxEDqZQIzeoRzyGNQsrKYrqI3hLxmhlmHiwZR9ntVoEY61mouEmLaYHhHUDcLgXHTp1
 a6baC30gmjLkS0Yw04ZzGbicPnypkUUvph+A57KVmF+t1PNdSbZRkCDk3ueTWgSeMVjIXo9AM0x
 mvgDF8g8872e0iC+YBTcXsm638XRgS+DwrwOpAhk8mFQmGHT0jYTIyrQuQnbe
X-Received: by 2002:a05:701a:ca82:b0:151:7831:e403 with SMTP id
 a92af1059eb24-16a5c6ec136mr4063339c88.13.1791586364798; 
 Fri, 09 Oct 2026 15:52:44 -0700 (PDT)
X-Received: by 2002:a05:701a:ca82:b0:151:7831:e403 with SMTP id
 a92af1059eb24-16a5c6ec136mr4063309c88.13.1791586364250; 
 Fri, 09 Oct 2026 15:52:44 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/11] semihosting: use new semihosting ops
Date: Fri,  9 Oct 2026 22:52:24 +0000
Message-ID: <20261009225226.10657-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RcEFmFtv c=1 sm=1 tr=0 ts=6ac9703e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ECcYt3gxA-2smbPpJpQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXwR8QjfyPRI80
 j74+5perCNsLSwG43Qvy/oGJcplFuHbc09KT7c7LB4nBGBdr0dIWxmkMdS+e6wMvCmnzm6Gtyw9
 mmQihCFIJyaxcxZkj9myglN4HLBxrATK/dp1KQWVg3BQ61LMQvWgO0v+Q6jXIdCV/0dwuQPdt+J
 hIURPFpRIQb/+aTpCMJPhAJhifHtExggHfq76btqixnS5NrInVoOBnxbKkBdrmcxHUiE6XPaKOb
 p+dFlFN8aVgS3Vt7Ig7+RuQyfZVHK28tLQHrb4+iMncef0N8xo+FeV10sOv6hB1MuD246j4YyMf
 6MMDQ+nZyaaqDORWPQaDJWEV9eUQK5i5DdR/w1wKtNYjzqzwSfd/N9fQrOLgofC++mG3CxqmiqI
 IoDghDFlfhGqslkeXhh0REeMzhyOGVFP/BjpHFFr+q3XDxnvTxTtMKGhwWDVGFCmYVny9AEoikn
 TkAs2w+ukiuiojaqlmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXwEtk8k81W0sD
 q29Y8u0aY2T5SMx2pXf3Wn3rzQvo6o7Asa34VwpkHmwsKwbqGskdJTjdaK0fffrJ/0n5f07Eulz
 uo5elhr+B/X77Yc3t7PenjMrP8Lpqco=
X-Proofpoint-GUID: qCUorIpOOKtqbe1h-JcEnYagyyEj6KBZ
X-Proofpoint-ORIG-GUID: qCUorIpOOKtqbe1h-JcEnYagyyEj6KBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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


