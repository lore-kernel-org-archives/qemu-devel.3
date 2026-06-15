Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8F9CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7k-0003vw-Jm; Mon, 15 Jun 2026 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6S-0002Xa-4f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6O-0001Uk-JC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1UnJ1367692
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q/g0VA/nvop
 yuhaZO+vKTTK0989+QcrBaXIhhOl+s20=; b=lwiwIlfOtkYtj4NLWnBr+nuyAnk
 xf+SRQlm3kQfpfTgS1uAkxyb+F3T02mbyA5BxZyAsKEQT9InTdIbxR/dBQEYHuZx
 0xexy9C4pVsrg75me4b4/xYvVMlz0fylzKzWviStw8D3Rojpue/ye6ui+6+c4ttd
 eQ7+hqlcyyvUIKFTR2w8LgyfmXgSTfP/RRalhat8Upn/MYR/p4DRRjqursdwU/Ns
 2EwxfBPBkdQ5RurjBh01RQ7sBS7OAeJU3iY3J0/ATjVJlBowgVqrI3MRZy+AyAwl
 UPr3+wiwCghHGFPdw+gIUGgzxpDaZiLZEKfmeBVPDppQgQY0cJfEbiUMouA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etegutnhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so4233742eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552156; x=1782156956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/g0VA/nvopyuhaZO+vKTTK0989+QcrBaXIhhOl+s20=;
 b=UXshrxoF+nSCz31unKzAf9FFpN+9Ok3PCt4/E2a5R8uYfmttCd+5jnWNNVWertnK4o
 UtUFb+JkmiT8q2zUVviJddewD4QpTJQRtSZD87kb3pLIAWZnSCMCN9eS4LobOjKFAxX9
 MSz1LT0kC1mCrDiJJ11FsWeu8/u+mi7ymRh3ok3SKA5CHQ01i+fPv6wmwppOY25ujF6d
 M1AoHTjWtpx2z59f5hbYtX1tPAUE7G9vHZzjX1U9kmql3IfqMvvP+3TUD5nNIHEn1qK8
 Rh1nWeTsf0V7jlzTH9Upv9XyBt3KAK7WCrTCUo+Ue34XaT2U6HETmAVqsQMnLlzKXlbq
 PUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552156; x=1782156956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/g0VA/nvopyuhaZO+vKTTK0989+QcrBaXIhhOl+s20=;
 b=dHbvxVHtYykRAW9WD9DuRaShuGb41tfiMVTvFQNmW5mDzv7IAtAWa8+8NHY7uEkp4g
 9WRupna1k5oSUvPLMkNh4xQrPon6gpS54hffWw2l2by5bSnhjBRgXQsBQh37acwHDCKR
 WNlmiC4TIRrofGltG2kQWb7fADc/W/BnMDcymzxBrd29u9UZ5WSYMaGwnFvIQCxS/1B2
 tXWYlxtAOcQEp/CBKdGT2H983lC5xB7IOS37mcyh1Z6/NJyTYZ6DyrcqBaXNNerJuQsS
 hyYm9Z7zGn1BrWcGyM0ZVQ+4HmsmHSOwKIF0MuI3wlL/1w5p3GOf2/yMkr5oUn4Wv7aT
 A51w==
X-Gm-Message-State: AOJu0Ywz9/NmgJYLA8bzZ7M81Lh0cOgmvexx2T9dykY8rYfuTYYQyXHF
 kxbkdJudlRWq9PnX49m/hOJdNlo/NiAR5rQVfRahWlun/CBs7NqgpewrauTjz5RY6abEP9VDpKO
 oAEbYoeMDsVhPxM2HACUNoJwhUM487zpZAm3AV2leiYsATyaDfyY5lKl1X4eOQGuFjpPp
X-Gm-Gg: Acq92OE3kDWO0s8Jn2iDqVY6+614Sjkvs0GOKgV261ls6nJYpYzP8ak1gC7fp2KNJoH
 eF4ILgx7kXng/cLdb11M3C9lgwpZ+711lTSPOv5vbio9ROG6bioDDOAwHpUpih9UkvgAsFCpqWN
 67H6j3CigtRz7kwL2m9DZ91UIz+f7ACpznXjpcL+rW3+Gi5BbNSuaVPQ34h31WP4JjZhc9LR/3S
 c6y3uE2gvcY1VFJxtX0Bcde15VjLiYZ1syUS2dKZxBE7InHiXFrdXP36zkApZHQEH4yH599leZE
 DFK9BT36hNSe/06xSSYvf36adkTGJYY08nWB9E2GgBC/+wjpWm8pwb4mfAovEvMpjCZAAnOcsLG
 p8a2NNKSEkX5buTq4Q+4rsfcOEP2Ye7Yrfs9EugRrScjaCIbAVTAyQh7cxgxoxGSwTwtDNWqAJJ
 f3M8MINg==
X-Received: by 2002:a05:7022:305:b0:136:b370:64de with SMTP id
 a92af1059eb24-1387901e454mr4694764c88.32.1781552156351; 
 Mon, 15 Jun 2026 12:35:56 -0700 (PDT)
X-Received: by 2002:a05:7022:305:b0:136:b370:64de with SMTP id
 a92af1059eb24-1387901e454mr4694741c88.32.1781552155736; 
 Mon, 15 Jun 2026 12:35:55 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 20/26] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_filter_cb
Date: Mon, 15 Jun 2026 12:35:19 -0700
Message-ID: <20260615193526.2883349-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX48jyzpONnNgz
 T5Avjzg7NUhIrkAMUzaVb7umqlsv3jB+DK13epujs+e+7UILQqZGlfCyMXKZo4bDbJN8nfgx8EZ
 OruuUVKx3WF7tfJ1PBC7R/7thMjzmYYOgzPW5DHA9CdJYcNifOJ4w25Z0USKHbKgx/xeCdEFHU5
 aqgRTx6Td0dJnUEBGytm6oSNSTE0lzCMMqsd1NepauYvjF/YvHkRp3unEgiHYR37uN7jzIypwJR
 SRsancCF67zyywPO1ZrwfXzF0Vlzte/Az7jyiFphiiaHImus00HlV5dS0WGiSOSCAYOV2no0qT8
 0wF9l2b38TcEnYupgByDMosg1yoRc7iMdSe9gwBxokD12NWgd7pHMgIhOS7pC44Jnv/Cw9YxoXI
 dhnr7kQC8ROoafQuxkq/h1P2+hUcGrCd94o3VrDP7QlEUzJJeHWY2dazp+wD5VsY69N58CTFZFi
 dYeEI/TwZb7ol094Tdg==
X-Proofpoint-ORIG-GUID: 24sHYl4nKn-5SP-NQmNuF_6zQR6NoQJv
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30541d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=Rmn1aRlouh7kj9PRvo8A:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX80w0IThKxSIO
 ovrmKlR4vh07h6bRvIYo1iEU8bWEtP2agud/v/ZYeTm7vmLbttJJMEo6ohMhk6wAEZ+YmpJltdR
 C0ZUpGzx7lKKFm/pUyY1mfPYta6dZWQ=
X-Proofpoint-GUID: 24sHYl4nKn-5SP-NQmNuF_6zQR6NoQJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 4 ++--
 tests/tcg/plugins/syscall.c   | 4 ++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index c38ae7db1b3..33d6f8e0b7d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -863,6 +863,7 @@ typedef void
  * @a7: the 7th syscall argument
  * @a8: the 8th syscall argument
  * @sysret: reference of the syscall return value, must set this if filtered
+ * @userdata: user data for callback
  *
  * Returns true if you want to filter this syscall (i.e. stop it being
  * handled further), otherwise returns false.
@@ -872,7 +873,8 @@ typedef bool
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
-                                        uint64_t *sysret);
+                                        uint64_t *sysret,
+                                        void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
@@ -906,6 +908,7 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
  * callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed before a syscall is handled by the host. If the
@@ -916,7 +919,8 @@ void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
 QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb);
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
+                                            void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
diff --git a/plugins/api.c b/plugins/api.c
index a72cec541dc..f2176be5304 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -217,9 +217,10 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
 
 void
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
-                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb,
+                                            void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb, userdata);
 }
 
 /*
diff --git a/plugins/core.c b/plugins/core.c
index 223a30cb944..49fe1b582b5 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -591,7 +591,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
 
         if (func(cpu->cpu_index, num, a1, a2, a3, a4,
-                 a5, a6, a7, a8, sysret)) {
+                 a5, a6, a7, a8, sysret, cb->udata)) {
             filtered = true;
             break;
         }
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 9bb5bf0f5f7..7c78f182f01 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                uint64_t *sysret, void *userdata)
 {
     if (num == MAGIC_SYSCALL) {
         if (a1 == SETPC) {
@@ -99,7 +99,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
 
-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 2afd71895e3..410fe617804 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -175,7 +175,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret)
+                                uint64_t *sysret, void *userdata)
 {
     /* Special syscall to test the filter functionality. */
     if (num == 4096 && a1 == 0x66CCFF) {
@@ -274,7 +274,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
-    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
-- 
2.43.0


