Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C212ECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsa6-0008Jp-Ra; Wed, 03 Jun 2026 16:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZk-00085k-Ci
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZb-0004GN-0P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653JTQQ71740936
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NXf1+G+lhb1
 N0s/zQtDborcjjPfHIczMbuPZOdktX2U=; b=VtNG8yApuXGsIIFMJLO9RffL9Wi
 lD5mZZvlEM9BYuQL9gVXOfa9AM8OHhsOHvDHqtVekM7+hfq0+AUccnSn7I0lV/zK
 BmxHxZR8bDNhlr0o4f6CzTzKwQCArsYR4pnzVsQu5UqPojjsh9MWUCHuH5oZxkm9
 vkcJrXcqHz9R4gyKRnMgmhLcSVhHPdayQ2Yn3rC4UYzBYXpG+/MwNiyqbVyBBmWr
 cFAX3nO9nGFddQYjmBIRhqTqoxgMmPQk6hypKiGjyqMyunDcn0w1DmS48rIIweI7
 SfBqlEzXYPXRSayVqWxnKGZG7VcxzuJwrF4uf+z79CPW6an3lRKvHAClMhA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7uyck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304dd917645so6276782eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519939; x=1781124739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXf1+G+lhb1N0s/zQtDborcjjPfHIczMbuPZOdktX2U=;
 b=j5ewyk7wCR6RV0KOqnbwrh2OHQY9BNrthzYQSy99L8dB3cH9Qj+K+M0l72+vOZ3utH
 eeAHHj/1K77I7VxKygPuzJONSN2u7jbDkj9el8y7NN6JLnMzbeBcM5p3DOHkvVAmOK5n
 F31XkRKKy6vodAR3P5UqEXXuxjn/GgdSnQIy+l4C4hNugYqsJoagORPtaFPtoN073eAb
 Z6SikJh6CxrmsUARIHToKRHd+AsdIX9Ruv8BEBwmTIhYhmsvyr01Pjzfx0NwUQg6IQxf
 xK7nzp9lMuiORfRj201p3dA3UIRomFXaKhmAxEBL8jkVoJU/KGUAPlYof7AsYNHbPo8w
 amKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519939; x=1781124739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXf1+G+lhb1N0s/zQtDborcjjPfHIczMbuPZOdktX2U=;
 b=BkN3wui694nRVuoZHLWi84C4rjLK0aQD3qDsAOda5bj7Jm6vGyVpKBHgFXXDwEhx2U
 5plJndegrLDNEaZkwUe3WnCipolgPi2nnVAQ0ihE53nSrnNPxqF6fUPwNDE4ZhE+ZBMP
 2uwpk7yDEpmcMFDIUXsCea5x6NnSUmxK8zTv3VQ5hfv4zP5VAQCBmPjsCWlkw2sAh5Hj
 LsrcxaHM3kBu3X4N3sF4tmOUZpuDti1243fA644P1Dyq3ZliiyYuVwNBNJ62BxNM9Hkb
 5j6we2Nt3W6WXWql0ELSO2VN2hn98udjC0v3OmrpzLVmYTunX+i+uuhqDseyMzOOBLva
 sbzw==
X-Gm-Message-State: AOJu0YyVtR71E+EGnfxSRIo99LHAkXdGjqeqyWfXPX/9EaJzHhGYO2Nu
 nUdhx31n2ISthj7nhVgfjVgKYQcebQkcmFtA8CB1/rWDq03n7eaDID/N/EsuH3Ytovfx4j1Va4N
 8h92ST+HjQn5aZmGlF4ZWxHTuwuJcs2l88l8F/ns6n7RDWDm3fyikQ1YluqtLUqLIOIXj
X-Gm-Gg: Acq92OG0wYmpUJC4U2oqn824rdFtmCl1vnpunVBdRswAjXmKdfcMzw37ou4vTJogR5V
 mnj7G2f+BCa0icCe4IqsKVhsPEs7r9S7OGkE6kvVO7JfLU5KIRh/LSZ1G5TVb1vaphs+owo8uuF
 Hts/Q1g45Ks67BeFQznqR7vIBfnjXyXNbgAbm5sJTcURpWFTrRwqv+ciTrBku+cbXaVu4c58rD/
 5OYGh4yswD55y1lA004l6o1o5eYcpTw8IcKTMCDgd7f56beduL4f1cPMR33x9hTgHrI97nJ2/+W
 EtcpEH+DUtOdUCYYuNZNzA3VHFB4PVlqlIb65DuUwJ63P99SPmoZq3v7fvYb9jOY16TfgdASDDQ
 LLOhwajPdldRm14SYOFnZj0DpoPmv3juy2sHJ+8QZS/vZKwGZy5hQj8hca7PCGgy4AYR+7aq9nc
 6PG6m3+KX5o1JydEM2
X-Received: by 2002:a05:7300:fd09:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-3074fa7f75bmr2806908eec.8.1780519938998; 
 Wed, 03 Jun 2026 13:52:18 -0700 (PDT)
X-Received: by 2002:a05:7300:fd09:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-3074fa7f75bmr2806883eec.8.1780519938382; 
 Wed, 03 Jun 2026 13:52:18 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 15/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_tb_trans_cb_t
Date: Wed,  3 Jun 2026 13:51:42 -0700
Message-ID: <20260603205152.1440291-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX+g6riWE8eOVO
 /qSX6WCQYAQrtm6nxmvrQa8hT+tQPUKcRTFtXvZ9TyaYUHKyRpplbT0hvyaQbvrQad4qiX275ep
 hPrMqoXN4SOxWjhfst9Nor2rbzGgQXh2oKZB5lJUawVnLZ6GG9PdUqFL277BKlA81XfWeCxxyFw
 z0wAf2cBxSmsSmYIF2IOktXKj22FYu2qrYAc1QMve1wRT4FtRs8142X8k/m0OB/2LdBIO7gtkvQ
 51W6FNebsrBEAUIR9NpQyYw1vdVKyx1lWDf5xWfKEBS16M8JS2XS5zVjYSGe+WaeHK9ozikF4Zo
 OyXBhq/pai0wKT2hKf5jn98XYptplADquH6XjCztyX6iJqJqAsrKgQy5K3gh9NkgSRlHpYWes+8
 YriQH2zg+Q+2Fu3rz4MAHX9Jj6mKI7tzfd+A7JnTir6ossDVC61rtmLb9weRMTRWdQs8zQAKGTU
 ZNDhBb55Iy3HyT11pkA==
X-Proofpoint-ORIG-GUID: s7XtXet5oK5bznD1YDFgoC65FdrhGRpx
X-Proofpoint-GUID: s7XtXet5oK5bznD1YDFgoC65FdrhGRpx
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a209403 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=deo0yMGDrNm56YX46o0A:9 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         | 2 +-
 contrib/plugins/cache.c       | 2 +-
 contrib/plugins/cflow.c       | 2 +-
 contrib/plugins/cpp.cpp       | 2 +-
 contrib/plugins/drcov.c       | 2 +-
 contrib/plugins/execlog.c     | 2 +-
 contrib/plugins/hotblocks.c   | 2 +-
 contrib/plugins/hotpages.c    | 2 +-
 contrib/plugins/howvec.c      | 2 +-
 contrib/plugins/hwprofile.c   | 2 +-
 contrib/plugins/ips.c         | 2 +-
 contrib/plugins/lockstep.c    | 2 +-
 contrib/plugins/stoptrigger.c | 2 +-
 contrib/plugins/uftrace.c     | 2 +-
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/bb.c        | 2 +-
 tests/tcg/plugins/discons.c   | 2 +-
 tests/tcg/plugins/empty.c     | 2 +-
 tests/tcg/plugins/inline.c    | 2 +-
 tests/tcg/plugins/insn.c      | 2 +-
 tests/tcg/plugins/mem.c       | 2 +-
 tests/tcg/plugins/patch.c     | 2 +-
 tests/tcg/plugins/reset.c     | 4 ++--
 tests/tcg/plugins/setpc.c     | 2 +-
 25 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index 0ad1301a1de..7e9e72477d7 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -102,7 +102,7 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
     fputc('\n', vcpu->file);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
     uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index f41ddb0aa43..c9d61de26c9 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -462,7 +462,7 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n_insns;
     size_t i;
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 4d00879ccad..9a850c8c0cc 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -297,7 +297,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
  * instructions for their execution.
  *
  */
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
index 0673c4f074d..34243cc922f 100644
--- a/contrib/plugins/cpp.cpp
+++ b/contrib/plugins/cpp.cpp
@@ -363,7 +363,7 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
 }
 
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 458c0d2084d..2dc08512d44 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -119,7 +119,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     g_mutex_unlock(&lock);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t n = qemu_plugin_tb_n_insns(tb);
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 2d02816a184..8329112305c 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -177,7 +177,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
  * QEMU convert code by translation block (TB). By hooking here we can then hook
  * a callback on each instruction and memory access.
  */
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     struct qemu_plugin_insn *insn;
     bool skip = (imatches || amatches);
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 92859872ac9..682b160019a 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -121,7 +121,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
  * Otherwise a helper is inserted which calls the vcpu_tb_exec
  * callback.
  */
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index a6d83b06c75..d8321a73303 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -148,7 +148,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     g_mutex_unlock(&lock);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 75728896198..feabc10bf44 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -310,7 +310,7 @@ static struct qemu_plugin_scoreboard *find_counter(
     return NULL;
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index b7f96117e94..fcc993015d7 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -242,7 +242,7 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     }
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index 2c110906731..a1fcba7c5d6 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -110,7 +110,7 @@ static void every_quantum_insn(unsigned int cpu_index, void *udata)
     update_system_time(vcpu);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     qemu_plugin_u64 quantum_insn =
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index c1c2b0aca8e..dc527ad56e2 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -249,7 +249,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     log = g_slist_prepend(log, exec);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     BlockInfo *bi = g_new0(BlockInfo, 1);
     bi->pc = qemu_plugin_tb_vaddr(tb);
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index 40f8fd313d7..222a3f92ae0 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -64,7 +64,7 @@ static void exit_address_reached(unsigned int cpu_index, void *udata)
     exit_emulation(ei->exit_code, msg);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t tb_n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < tb_n; i++) {
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 8be8409dce2..a1b10f9cf59 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -838,7 +838,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     trace_enter_stack(t, cs, timestamp);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 60d27d8d9c1..8242e054054 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -417,11 +417,9 @@ enum qemu_plugin_cond {
 
 /**
  * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
- * @id: unique plugin id
  * @tb: opaque handle used for querying and instrumenting a block.
  */
-typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
-                                               struct qemu_plugin_tb *tb);
+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(struct qemu_plugin_tb *tb);
 
 /**
  * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
diff --git a/plugins/core.c b/plugins/core.c
index 3c3212aedda..c77da4d36fd 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -487,7 +487,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
-        func(cb->ctx->id, tb);
+        func(tb);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index ba605246eb0..713063f4945 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -77,7 +77,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     count->bb_count++;
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 5ab645705e3..d2a163a5714 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -147,7 +147,7 @@ static void insn_exec(unsigned int vcpu_index, void *userdata)
     }
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < n_insns; i++) {
diff --git a/tests/tcg/plugins/empty.c b/tests/tcg/plugins/empty.c
index 8fa6bacd93d..5927507c18e 100644
--- a/tests/tcg/plugins/empty.c
+++ b/tests/tcg/plugins/empty.c
@@ -20,7 +20,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
  * This allows us to measure the overhead of injecting and then
  * removing empty instrumentation.
  */
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 { }
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
index 1d17884b40b..3f5c49f5ede 100644
--- a/tests/tcg/plugins/inline.c
+++ b/tests/tcg/plugins/inline.c
@@ -223,7 +223,7 @@ static void vcpu_mem_access(unsigned int cpu_index,
     g_mutex_unlock(&mem_lock);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     void *tb_store = tb;
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index d9f94888d6f..a303275ea1b 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -138,7 +138,7 @@ static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
     }
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 5cdf71c7e49..24a3bce0bfd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -266,7 +266,7 @@ static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     qemu_plugin_outs(out->str);
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
index eba2f8b8d6c..8fcf0bd409b 100644
--- a/tests/tcg/plugins/patch.c
+++ b/tests/tcg/plugins/patch.c
@@ -130,7 +130,7 @@ static void patch_vaddr(unsigned int vcpu_index, void *userdata)
 /*
  * Callback on translation of a translation block.
  */
-static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans_cb(struct qemu_plugin_tb *tb)
 {
     g_autoptr(GByteArray) insn_data = g_byte_array_new();
     uintptr_t addr = 0;
diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
index ef5a32781b2..1fdf114e5e0 100644
--- a/tests/tcg/plugins/reset.c
+++ b/tests/tcg/plugins/reset.c
@@ -27,7 +27,7 @@ static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
     qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
 }
 
-static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void tb_trans_after_reset(struct qemu_plugin_tb *tb)
 {
     g_assert(was_reset && !was_uninstalled);
     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_after_reset,
@@ -49,7 +49,7 @@ static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
     qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
 }
 
-static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void tb_trans_before_reset(struct qemu_plugin_tb *tb)
 {
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_before_reset,
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 8f2d025e245..44cea064783 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -73,7 +73,7 @@ static void vcpu_mem_access(unsigned int vcpu_index,
     }
 }
 
-static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+static void vcpu_tb_trans(struct qemu_plugin_tb *tb)
 {
     size_t insns = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < insns; i++) {
-- 
2.43.0


