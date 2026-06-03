Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2413DCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsb5-0002VL-EM; Wed, 03 Jun 2026 16:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZm-00088z-GS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZd-0004Gx-2S
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HABwg2651480
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lXNzoOVFeil
 bT4v9yfKYd/8IIuIQM92poyM3BhyK2e4=; b=R6E5onNV1bQ1GqYoEVlcC+EtyRF
 JwmldGKc3BBe84GoPctQl3F/bYLyrIseO3KuXhsal9MyQBCOCQ9RbJqfx54ZBlPo
 hsSkxPicMq3EVk/qKfxsa5ay83v2ZwqGjl963LbmUUlcniB3U3gJ326LIUi4Ofb+
 z6iszolI+rhOKGVuxXPQ9HF01FFhndC7y0yF4ySCMlIhO1PG6bjeB7LqFl4jegsT
 oGwPbus/K7DmTtXD9M/vQi8AuktWzI/cOWSIj/xBH9LPi+wjGGdWSqmU4shyo90H
 xoxyfxGPP8syzvoLii7HOfSlqImg1VTECE0pfd3lNL0PQvY/FI/pT/x2kSQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejre9gvh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30762d67a64so444225eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519940; x=1781124740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXNzoOVFeilbT4v9yfKYd/8IIuIQM92poyM3BhyK2e4=;
 b=TLs5m1JeOTh10cctPtrXgZCoJheSkf/w+hBd5vAH6TPiwPwU4vJylRT2+MaA3uOD1B
 mIcTHbkIPbXDTeLFabyz9jT72Pm98PQwNchi//98lCKnkoY1Z9jY9hUXLKkAhKNFPSc6
 M+pBSusOPOGqQPUPG31CaHXEZHh6cs9tZrLg2EF0d0eJhkhFgcRU55/AOJ2XQ9P8qTtT
 JnbA1ti1b3wuvAKtjYZ+PArDCmrntDvO76vyBzPuzm2hllAOJVShD46zRqeKVQIF8Szi
 wpemhXK3gHpwc11EEFhzzr4crfTTSf5dX75OiGB7taGr09KX2hkgpa+ywNmKah6mCR/Y
 qsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519940; x=1781124740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXNzoOVFeilbT4v9yfKYd/8IIuIQM92poyM3BhyK2e4=;
 b=LTdQK9MmQaBymMM/nt7fwNg4qyj1HCHr+JoSK4BEJ41WOBZ7QZTfjrvzmzqqSgC3mL
 Rd+J2q3ZwMI4UuiKGova28ih93rM2uqvvS0mlOKJAmZnkigGuhYFs71U66yoewSUVC04
 5dkq0WROaRK5j1xkodm5RjNXBu11EXAgmS8/ZOh9qjWUIRYnYNEikv2n2LjWr5Qmr06K
 Zm0yQI+FbQUQ6e3tpfxvsB3EMSAlEhN98Lib+Ftn/HTp767A4Qqz/3Kp8rsg7tpYKy9O
 YHp5s1wKm+md+lK1O43b/fWeIAHqf3bZEhlwVOzmboxsBScuio9apizn92goZIBXyhnZ
 P6kg==
X-Gm-Message-State: AOJu0YyIa1MOi2xrGy4rNL0JAyYyHRJSjBIKR0gmnN64Elf/p22vyy2L
 Hu/Sxc6E7Upum2Gobjmum4Qj6e5eG2uTyeWEDMEj31vAwE8BjBnPP0tTwNRcVqxoF3/Ma/3p+LE
 Zti5ASHIQM8wklD8P1Sznyn/4eIHeI5LY/W+AsooJImpYuiqN1dY5rRh7GT2o90rKoZS0
X-Gm-Gg: Acq92OEMuD682Z2Zy0biMrUTVhBXmLSFjEVKhhdNJ5CF+LrIlx1Je4r3dGkQUwqPoQX
 3BgNrbKZdSoA1pf/ExuAsNPOX3sE2EsaRYMmI1Rdv8VLiSWolVahckBZ1mYToz3sv8LjtFgfz01
 dwYFs9BBOsC4BYcP8G2Ka/fDSSWrAu5IXt/E3M8hqYbSCUWJfUKKXMmTuTN5YpOTLYHr6EL9aQa
 K17FQ8nZBhyaDs7QGmw4XsxvDlu493InGaqYCd2KX3Vi9Utdh4FuqFvW2BGl2g9r/PPNMcnMKid
 uJflY2nVGd6pLKdYz1olK0W6qDwYlBp2jCiXzDd060LeMiS+bW3Q0+Pi0+KWhLMXVsUZQgEVwtn
 WF1PqIdkdE+mw/n07CksnO95oJAo34oXyokLdz2v6UktriBR17+hkBz14Vz/M5fZ7ORJZxltjS0
 X5VCwUgcEE0gdjjuWw
X-Received: by 2002:a05:693c:37c2:b0:304:c520:4e14 with SMTP id
 5a478bee46e88-3074fabd8d6mr2453625eec.11.1780519939961; 
 Wed, 03 Jun 2026 13:52:19 -0700 (PDT)
X-Received: by 2002:a05:693c:37c2:b0:304:c520:4e14 with SMTP id
 5a478bee46e88-3074fabd8d6mr2453608eec.11.1780519939285; 
 Wed, 03 Jun 2026 13:52:19 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 16/25] plugins: add userdata to qemu_plugin_vcpu_tb_trans_cb_t
Date: Wed,  3 Jun 2026 13:51:43 -0700
Message-ID: <20260603205152.1440291-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qABYCB2lJy-0Onvg0vMeZzPbXaDqC_B4
X-Proofpoint-GUID: qABYCB2lJy-0Onvg0vMeZzPbXaDqC_B4
X-Authority-Analysis: v=2.4 cv=KoF9H2WN c=1 sm=1 tr=0 ts=6a209405 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=t56wdHKumdETyko2czkA:9 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX/ftKr+EANNPR
 DmAxL/khtn+hGZehPXb/HkYWj/mnYS/qWpFZij1qEjhs/UKwUa/FhdwJ/0wTAmLtdLSRA9fwwtB
 KBFRLfaazx/QhBDeVf1gRiSK/GgQBKJ6l9mZpouWgrQ5ihJ5onnYBM8EBJxbhCylWqP86XwAO5O
 lHHkFV12AmUheI6BJ9hhX4FBBKRNcoii1Q6D2RAfdAhQF56ur8pTs9C3SV6IoQ/6XPOO85MovQZ
 0sU6r5hP00eHztonc8bP7uEFYYVvqnUQr0KRPw2b0kSzAlYfIWlgzswYiQSh3HODUMClOMIqC7Y
 aMM3AO2xajXpxB7pLsULV/DYDJ+nmZHO9zcZAuM+7iAqQJMNbtPN1dj/4KMfT8d/YwTfEq1+E+V
 shhh0PnUGJWis/cYh55hmurBvv1tvnv29DxcfcYEtWKdmsVwPBk9U/6Ac6r6C8zq76LwZML/U0S
 F2gWi6+XuP3mTwd3mUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         | 4 ++--
 contrib/plugins/cache.c       | 4 ++--
 contrib/plugins/cflow.c       | 4 ++--
 contrib/plugins/cpp.cpp       | 4 ++--
 contrib/plugins/drcov.c       | 4 ++--
 contrib/plugins/execlog.c     | 4 ++--
 contrib/plugins/hotblocks.c   | 4 ++--
 contrib/plugins/hotpages.c    | 4 ++--
 contrib/plugins/howvec.c      | 4 ++--
 contrib/plugins/hwprofile.c   | 4 ++--
 contrib/plugins/ips.c         | 4 ++--
 contrib/plugins/lockstep.c    | 4 ++--
 contrib/plugins/stoptrigger.c | 4 ++--
 contrib/plugins/uftrace.c     | 4 ++--
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/bb.c        | 4 ++--
 tests/tcg/plugins/discons.c   | 4 ++--
 tests/tcg/plugins/empty.c     | 4 ++--
 tests/tcg/plugins/inline.c    | 4 ++--
 tests/tcg/plugins/insn.c      | 4 ++--
 tests/tcg/plugins/mem.c       | 4 ++--
 tests/tcg/plugins/patch.c     | 4 ++--
 tests/tcg/plugins/reset.c     | 8 ++++----
 tests/tcg/plugins/setpc.c     | 4 ++--
 26 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index 7e9e72477d7..0e6ec673d97 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -102,7 +102,7 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
     fputc('\n', vcpu->file);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
     uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
@@ -157,7 +157,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
 }
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index c9d61de26c9..0a5349f131e 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -462,7 +462,7 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n_insns;
     size_t i;
@@ -844,7 +844,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     l1_icache_locks = g_new0(GMutex, cores);
     l2_ucache_locks = use_l2 ? g_new0(GMutex, cores) : NULL;
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 9a850c8c0cc..319a7a7fc07 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -297,7 +297,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
  * instructions for their execution.
  *
  */
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
@@ -387,7 +387,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
index 34243cc922f..a0bb261fbe8 100644
--- a/contrib/plugins/cpp.cpp
+++ b/contrib/plugins/cpp.cpp
@@ -363,7 +363,7 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
 }
 
@@ -371,6 +371,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     return 0;
 }
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 2dc08512d44..5a18a8f48b4 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -119,7 +119,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     g_mutex_unlock(&lock);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t n = qemu_plugin_tb_n_insns(tb);
@@ -156,7 +156,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 8329112305c..74325495cce 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -177,7 +177,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
  * QEMU convert code by translation block (TB). By hooking here we can then hook
  * a callback on each instruction and memory access.
  */
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     struct qemu_plugin_insn *insn;
     bool skip = (imatches || amatches);
@@ -482,7 +482,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 682b160019a..ea746b513a1 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -121,7 +121,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
  * Otherwise a helper is inserted which calls the vcpu_tb_exec
  * callback.
  */
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
@@ -186,7 +186,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index d8321a73303..56e5698ce1d 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -148,7 +148,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     g_mutex_unlock(&lock);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
@@ -197,7 +197,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index feabc10bf44..55db9ff8028 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -310,7 +310,7 @@ static struct qemu_plugin_scoreboard *find_counter(
     return NULL;
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index fcc993015d7..87b0267ffe3 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -242,7 +242,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     }
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
@@ -319,7 +319,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index a1fcba7c5d6..6f7ac1587ec 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -110,7 +110,7 @@ static void every_quantum_insn(unsigned int cpu_index, void *udata)
     update_system_time(vcpu);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     qemu_plugin_u64 quantum_insn =
@@ -206,7 +206,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     time_handle = qemu_plugin_request_time_control();
     g_assert(time_handle);
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index dc527ad56e2..ed9d18460fe 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -249,7 +249,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     log = g_slist_prepend(log, exec);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     BlockInfo *bi = g_new0(BlockInfo, 1);
     bi->pc = qemu_plugin_tb_vaddr(tb);
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     our_id = id;
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, (void *)id);
     return 0;
 }
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index 222a3f92ae0..3babd014171 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -64,7 +64,7 @@ static void exit_address_reached(unsigned int cpu_index, void *udata)
     exit_emulation(ei->exit_code, msg);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t tb_n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < tb_n; i++) {
@@ -150,7 +150,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     /* Register translation block and exit callbacks */
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a1b10f9cf59..9b0a4963aee 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -838,7 +838,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     trace_enter_stack(t, cs, timestamp);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
@@ -987,7 +987,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
     qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
 }
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 8242e054054..53daa09fc72 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -418,13 +418,16 @@ enum qemu_plugin_cond {
 /**
  * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
  * @tb: opaque handle used for querying and instrumenting a block.
+ * @userdata: any plugin data to pass to the @cb
  */
-typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb,
+                                               void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a translation occurs. The @cb
  * function is passed an opaque qemu_plugin_type which it can query
@@ -435,7 +438,8 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
-                                           qemu_plugin_vcpu_tb_trans_cb_t cb);
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb,
+                                           void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_tb_exec_cb() - register execution callback
diff --git a/plugins/api.c b/plugins/api.c
index 849790fe13b..774b1b80214 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -195,9 +195,10 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
-                                           qemu_plugin_vcpu_tb_trans_cb_t cb)
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb,
+                                           void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index c77da4d36fd..d891da93040 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -487,7 +487,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-        func(tb);
+        func(tb, cb->udata);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index 713063f4945..90adb3ebd97 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -77,7 +77,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     count->bb_count++;
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
@@ -127,7 +127,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
     }
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index d2a163a5714..45f24397047 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -147,7 +147,7 @@ static void insn_exec(unsigned int vcpu_index, void *userdata)
     }
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < n_insns; i++) {
@@ -215,7 +215,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
                                         vcpu_discon, NULL);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
 }
diff --git a/tests/tcg/plugins/empty.c b/tests/tcg/plugins/empty.c
index 5927507c18e..286b3035e61 100644
--- a/tests/tcg/plugins/empty.c
+++ b/tests/tcg/plugins/empty.c
@@ -20,13 +20,13 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  * This allows us to measure the overhead of injecting and then
  * removing empty instrumentation.
  */
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 { }
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
index 3f5c49f5ede..436223db0e6 100644
--- a/tests/tcg/plugins/inline.c
+++ b/tests/tcg/plugins/inline.c
@@ -223,7 +223,7 @@ static void vcpu_mem_access(unsigned int cpu_index,
     g_mutex_unlock(&mem_lock);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     void *tb_store = tb;
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
@@ -303,7 +303,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
     data_mem = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_mem);
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
     return 0;
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index a303275ea1b..4ab30d6df8c 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -138,7 +138,7 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
     }
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
@@ -297,7 +297,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     /* Register init, translation block and exit callbacks */
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 24a3bce0bfd..e56d10574bd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -266,7 +266,7 @@ static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     qemu_plugin_outs(out->str);
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
@@ -374,7 +374,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
     io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
index 8fcf0bd409b..59215f8546e 100644
--- a/tests/tcg/plugins/patch.c
+++ b/tests/tcg/plugins/patch.c
@@ -130,7 +130,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
 /*
  * Callback on translation of a translation block.
  */
-static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb, void *userdata)
 {
     g_autoptr(GByteArray) insn_data = g_byte_array_new();
     uintptr_t addr = 0;
@@ -245,7 +245,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         return -1;
     }
 
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb, NULL);
 
     return 0;
 }
diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
index 1fdf114e5e0..949f2d6160a 100644
--- a/tests/tcg/plugins/reset.c
+++ b/tests/tcg/plugins/reset.c
@@ -27,7 +27,7 @@ static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
     qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
 }
 
-static void tb_trans_after_reset(struct qemu_plugin_tb *tb)
+static void tb_trans_after_reset(struct qemu_plugin_tb *tb, void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_after_reset,
@@ -40,7 +40,7 @@ static void after_reset(void *userdata)
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_outs("reset done\n");
     was_reset = true;
-    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_after_reset);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_after_reset, NULL);
 }
 
 static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
@@ -49,7 +49,7 @@ static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
     qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
 }
 
-static void tb_trans_before_reset(struct qemu_plugin_tb *tb)
+static void tb_trans_before_reset(struct qemu_plugin_tb *tb, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_before_reset,
@@ -61,7 +61,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            int argc, char **argv)
 {
     plugin_id = id;
-    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_before_reset);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_before_reset, NULL);
     return 0;
 }
 
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 44cea064783..595571cdfd9 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -73,7 +73,7 @@ static void vcpu_mem_access(unsigned int vcpu_index,
     }
 }
 
-static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
 {
     size_t insns = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < insns; i++) {
@@ -100,6 +100,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 {
 
     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
-    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
     return 0;
 }
-- 
2.43.0


