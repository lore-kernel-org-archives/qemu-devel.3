Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F74CD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7w-00056X-AC; Mon, 15 Jun 2026 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6K-0002Vp-3g
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6F-0001Sn-NP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ2IUI1245700
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lkguRjHGDUi
 BKma7C+rauY7bLb8ci0bl17hvuEjiXq4=; b=fWQzNcR5pVPHw5yfQdhuUeg1EFJ
 PYE6g4tH5HN6XQgeVJ15gbR5T5cSor0h+fG9GWSiY9CdXZigRz1qL76IDUEF4D8K
 G1tcHaAKBctQnA0Iyt/jmg724gQ/wk0JI7BTVIy712zFIPLksge9GbHoKz4WaPT6
 kwJkBlRPznFZgw/XYGlBv+6arUuH+VuyW8wRoGnhmB2GtcSQS7QBQSlgThLQR0k/
 LW6mlubIjV/Xsoq62dIZSbJRu6RkD2cPCU3TbRLCprt1hoM66JoqgH+xuMIKcT29
 2seJ+UpmXi09tm81dnayPQE+pZm1nuy9fYzI7iu0SveeLdbYgPYNKi720dg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetf2jcu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1382674ba2eso3369179c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552148; x=1782156948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkguRjHGDUiBKma7C+rauY7bLb8ci0bl17hvuEjiXq4=;
 b=V6qQz4Eq4LWrV32mbnv3xKWPv0ymOYbxAxP/Ri9DlcXUvoAqFvwfML8EldBoEp5BXb
 fdwrZhsRo8h1Neb3TqBwoJJFDzrXWRfsC5E0UUaGneekJVoEx2Q7ERXkW+ZnwqFcxy9U
 +kwuMh0BkdHOu6IthR7Nt/uiDQvndxiJ2rHRcyYlcfypuQmaTqbgpJAN2+dcc+E2t8xB
 7qTyF1wCWYfwNxFvKmrxcX01vBU0nE2T2BCb3hqjutK/tcX4IAgzn/SxlOpI2P91NHdC
 x5Kin5aoLJIM85HADflA+Dq64fiDsE+HLZAPJZ/SfgwRswjRHlSFj+B5PY6Fa+Adn46t
 eBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552148; x=1782156948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lkguRjHGDUiBKma7C+rauY7bLb8ci0bl17hvuEjiXq4=;
 b=cwi9DGM6x4KuREK+1WpygxOurS9ujEsRMSCGPjbBmQAInWiDwcrLji3ZVlcPYvBwR3
 Z/Kx4sXoCJPKWUFFrNHvNSJCXMBPOSGPDMaKl8MCXuOJtfqGHitHtzVrxvCqRJYjYiOX
 CibSh3fGWoh8CzMiXCArOeR43GYJS++rWwjRV5ScITcVdhIe6yhHXGOINzA7Xhjyh+mM
 PyFvTVSpCFZJ3+T/MTrtJkeYcOiPtpZPD7RYq3mKu5MI2cSpSfrL2LLrzVGpnDkDroY0
 yudWZMvw4bcX60C1HjoWzmDgfsJR0iApkIWOhC6zXGVd27wwxjratNZsUxmwZI0uodLo
 qAbQ==
X-Gm-Message-State: AOJu0Yx1w4dnXRQ1zuXmGndfumKjkG2qwrkGc7f9cXhcEadIVrvMeBMC
 kceIo6j4ZzNSif+4YLggE70kD/NQdyLIDpHmx4wmymWCXfOUqbFh0N2kHl6u6zOAKaP634RdfIT
 PCPiQ/zm5baVNZLUjfDTtCVJCaEuUIoAtYjuRjADwEWctEWbMiTEsABQWCwLTaFKV54kc
X-Gm-Gg: Acq92OHz5zcdGnZ/rsKv0rqvIk+Vep4XwqUhfuHdDZSgV8sg0Apgn1d2Y1cZqDSYJrS
 8tQeG2EIBoj9AnYs4P0NdY34iK5U0md04mr1O37ZKI58pjpXzNqyVAHRdnu4luAWoncdGu2+1zQ
 Kw3zaiJnAZ+vgNJm6tlcnnisCsYXC6yRq5OJh8Abfu4GsgAWadke11KLKcLWLZwSr8iUYoAFAdl
 oZshiwZcsXb0hEuo/syCqLpcLIMcED+JraFx1LpyjUkEnPHt+jEwEKP7VAiTqHXAZtiJiu6Zx1d
 9/zKgINkXsPlW645W6ZCHQuGJRdPFxZSwKthO+Fs2HjsfZixXqAi7Hz6pVWNtOdzNWzpUMLFXNi
 zt9hywHVU/FZrd0FlsZrThPO3K56CmKerr+0ZnxbusBGXGaIqEJ5l61UV8nuOTsyuYTkMhT6IiM
 ZObB/bOA==
X-Received: by 2002:a05:7022:4399:b0:137:eac4:82ae with SMTP id
 a92af1059eb24-1384bba55e7mr7369019c88.37.1781552147455; 
 Mon, 15 Jun 2026 12:35:47 -0700 (PDT)
X-Received: by 2002:a05:7022:4399:b0:137:eac4:82ae with SMTP id
 a92af1059eb24-1384bba55e7mr7368996c88.37.1781552146811; 
 Mon, 15 Jun 2026 12:35:46 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:45 -0700 (PDT)
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
Subject: [PATCH v2 15/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_tb_trans_cb_t
Date: Mon, 15 Jun 2026 12:35:14 -0700
Message-ID: <20260615193526.2883349-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=adxRWxot c=1 sm=1 tr=0 ts=6a305414 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=deo0yMGDrNm56YX46o0A:9 a=O8hF6Hzn-FEA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5tbOUccwGdKUT-HptFAfjKDwkQps2i_P
X-Proofpoint-ORIG-GUID: 5tbOUccwGdKUT-HptFAfjKDwkQps2i_P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX9mqT5R6GX39J
 s7sX9HmjoRlC3y+oFr3xFXym0BaK19cJRI+DD+XwZXzSzbst4Sdo7Oo1iRmlVm7I0dRo5fTdkIH
 rRZHmC/9YippMKtMrRUfh9PRes9HG6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX1BKBJ237tLi/
 zvrh/bx2/Ikqx6GQVUHDMtWBiBIjBa7ulCJGezDeTDUD0WJRkZ4N2JWb1J+8H3CXSTa0unj4Ndt
 sh+8Oo8lMj6g8ILrmvwiGDlNPix2e6hJOd/DHRVoK26XvsCYIQ7QgZiKrzRPUP/UiFgprsZ7Ey4
 7Zr36hJKKTyjhkApr7FCBudUhmiAxzIJpc9c/kJxuNTrwT6x1ZUqt6kRglNZKZ1Wpf0H/jRWDTh
 wBEt3UzkVKq+I32H4tnE8Beaikw2F7C4EKo9d9rhu+ckvDG/tkKbefKnmcjojQHK4UEUTwil3zl
 CqnNMM/7zmx06bNqvqEXWGwpC9zudookaVXckrZBEbMs67e/BnbelOgH5ObemnNBlwUP+Ffz2n2
 vCDA5vuaOIQCVb/YQNsd4RgZ2H4EqurVDWH3rGWZAtmKddEL6R0DjoMpOeYfQ7gFZoNgNsAJxxB
 yXGihTJUXrpakFqKbOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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
index 7e4ccd37b73..0ae0dc49aec 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -488,7 +488,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
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


