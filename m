Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC3CCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD67-0002R8-Dg; Mon, 15 Jun 2026 15:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0002NO-MA
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD5u-00019O-IH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ17tf1454047
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Be902IJp2ix
 q0DdSWpqxRkw2vyU1Rw7SS3KxMwU9nVE=; b=UuTvG7idtrBZ5iGQX5utKuVa0Vh
 oJRj6CWE1sEon04MPJizgzYiAPLopdnU/5uLCAtlYg4j9YTdVZiWQV+QERbX6AmO
 voD1S/qqNUMjLQ91oy7CK5abTKtZFFExESJG1SPQvZctQbQGFNUZcCwHDavvPR3P
 CdZ0HMwqjLWgSmAMiyGM+6muOtkc2+RUiEW+4M+cAREhzZd235+r3jLQfmyfNp3c
 TtxJDZ1/wjzFBFdd1kX28f03Kb7+qOFMezXKK5pEIVUKAzyrNt5BcFTujFPaEWyb
 433kvYbHngMOJMGw6PL7lnOdF6M7vcRzxfV4GLlJyRYYzYdGOsusjjMjN7g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2cb4bp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304dd917645so7795158eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552136; x=1782156936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Be902IJp2ixq0DdSWpqxRkw2vyU1Rw7SS3KxMwU9nVE=;
 b=GRR6qCBaR/Lrc+C22rPmhLF+NvGn16Uzq1jA+hb8LFS0rTZUKLmAF54iGBm083/t6H
 wql2zkzt5/A/TkB/R9whxeaL0lwmCFY1WqeQqi8zW4t+1Fm3+pvPxO7Qpfi5tBFo7mBz
 eyk1eO7bTdvpcjCPeMuTOFnjEu2EOwvdxH6QMqoulDsNI1Ym0j5nSnTQYqcBVfqiMQ93
 1gJhZFwT/HIhgqONV7vtBBsOlIChfzJtm7gWzXTMMi/bjqYlnBjOabBYb2zUEZC2Y9wN
 Ilv94t+SDBp5sCSheJYwWwtfhLrS4E3smb+ZF5P60gBX+MHvbpXY99FeXJxasOau2D5q
 H8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552136; x=1782156936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Be902IJp2ixq0DdSWpqxRkw2vyU1Rw7SS3KxMwU9nVE=;
 b=h9CDZBSjcFAOYS3+zUnjJWl8Ozw5dP79kq0G4DVVWkx2YzJbn8JggoBEI20e3ZBApj
 r5aWnSP6Ny2Seu7hTZ+EbF5Xi3pd1vSwRAWkbXc49XCWdJZ3E9kCx8xfZkf40k4PtrMI
 4rLDZAycKOSmEwINrB2IyWzyLLBcPxIN/b63VZbDzGlXZGAysh1EtCZUFlDdwtcgiHpE
 ceILjf99S7QZ0fc1IjwbM8QjitSUHaUtytby8Q+wYppRJGZ66IKH8EEawDESkXUBwrNA
 VzBx9uPLPIdz4m46kLGZQ6ps1jRoHtmnlKGHUcW8V4T8aKOz7u6uxWxjUAV6e020TkNX
 Tzvg==
X-Gm-Message-State: AOJu0YweZ+ASm51Um3K19oNbWWbKfYFULwmGROfNA3f9oIt2lI8AZNXH
 vaE1F8FnnvThfUl5EaW8BjrVqKB1YCC14UG1YH3Bd3YVZ2aN86I2IzIMTo26schJOwcQCwmRG63
 fROQ7WOHilvHZ0poNw6sEJpWiFY6EWtnAxTGHhkSeES8DkIYhnoI7KTSmjXBtipuntqB6
X-Gm-Gg: Acq92OF9rpts6BePd7Vg63lmmGrNJpASo4mnJphoBC+UB2AVsrotan9X7Zp5IneJYn8
 lkvPFnhPOmZnBAtCJxMJQXsv1sXayPpLBI8G+yS/+GTVlnYoigB7gENEkPZQucqtFyu2WQ8lNZj
 ARI+ZIEaHTCGsMTqLBevU6EbtcYrjeO/+DkOek9ZzE+NqQb9Foq6iy5pJ6xrQgO5sOInky006bW
 mKVd7cv+KST77GNk810OQqSMNa9Yh4SWRsEQQ2276cnYftAdLdHdStjLHgwcttwZebgnZPwtBuO
 B872Auittez8KpsQS3J08dfF9pXEEQV3iXfpur8tHB5OHpKlifWDEsvoEqi60a+MzPMne7ba3pW
 CuBuvh5sU3zwFewYr+Gr/gYKlSJGncnDmC/Fwb3EJPvppShLLy3Siy0G/lKuA1xPNnVkx/I7afo
 1ZvIUhcQ==
X-Received: by 2002:a05:7022:43a9:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1384bb84114mr6954305c88.32.1781552135550; 
 Mon, 15 Jun 2026 12:35:35 -0700 (PDT)
X-Received: by 2002:a05:7022:43a9:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1384bb84114mr6954290c88.32.1781552134955; 
 Mon, 15 Jun 2026 12:35:34 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:34 -0700 (PDT)
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
Subject: [PATCH v2 05/26] plugins: remove qemu_plugin_id_t from
 qemu_plugin_udata_cb_t
Date: Mon, 15 Jun 2026 12:35:04 -0700
Message-ID: <20260615193526.2883349-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX5RBDKwoysyNY
 B+NpsWcHzxdJZDfbIFrU2ezS+9OB3QqpeeenL5O65nsvchEIGlwbZF3xrtGUjQnBHYnsljJffHM
 PFvKNYtMuKcn8OEwDv86UvCxYuyxOvnJ7fWqMayhWTbzvigvUpP77WR8wZ4HFcrPX8oGmcfuBXE
 IiadlXT1r67DYlasf7OAeJFfcy+mQ4DeF0TzdpX3pbg3LhmwlrqRW1h+Z3i3+Y8na5XlqC5FpI8
 3zv0MU/G037OdsswDsWFpFrblKKvnGio4Wt5gU3cazMRUZLpj+YtEj0Zs62vGHHW1fu5V0erueO
 QqbOiFs0aQcTI/x9n2u46OVqNXFG7lTkWpGulYIq15RfyNj2AZ5t/nast5YjfWWg/++mDHGY/vZ
 2BQzg+GY8aQla/HN7Kzq2IzSw+T4bq2cGTXJRPfiRpQtwTXTILRmMCYOJgBPeVPZy4x4yiE72wL
 fENMqnc+k65zMafZUtw==
X-Proofpoint-ORIG-GUID: bQ9UHSmDPN7gTamMhyceIevwe-QjFXcM
X-Proofpoint-GUID: bQ9UHSmDPN7gTamMhyceIevwe-QjFXcM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXya7WwIcRJjvB
 AXPR43arcGTrOozDpDghOrVCDhHdAoKYeUpegTjrYz/7CfZi3BuHyW8OhuNKVNwdT74xPP61Qs+
 yKh4WQvKkb5XvhrKIqBmFrICg2aWQbY=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a305408 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=fy20bCZK_bgFVnb4qsoA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
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

We can now rely on userdata being always available to pass down this id
if needed.

In our plugins, only tests/tcg/plugins/reset.c was using it.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/bbv.c         | 2 +-
 contrib/plugins/cache.c       | 2 +-
 contrib/plugins/cflow.c       | 2 +-
 contrib/plugins/drcov.c       | 2 +-
 contrib/plugins/execlog.c     | 2 +-
 contrib/plugins/hotblocks.c   | 2 +-
 contrib/plugins/hotpages.c    | 2 +-
 contrib/plugins/howvec.c      | 2 +-
 contrib/plugins/hwprofile.c   | 2 +-
 contrib/plugins/ips.c         | 2 +-
 contrib/plugins/lockstep.c    | 8 ++++----
 contrib/plugins/stoptrigger.c | 2 +-
 contrib/plugins/traps.c       | 2 +-
 contrib/plugins/uftrace.c     | 2 +-
 include/plugins/qemu-plugin.h | 3 +--
 plugins/core.c                | 2 +-
 plugins/loader.c              | 4 ++--
 tests/tcg/plugins/bb.c        | 2 +-
 tests/tcg/plugins/inline.c    | 2 +-
 tests/tcg/plugins/insn.c      | 2 +-
 tests/tcg/plugins/mem.c       | 2 +-
 tests/tcg/plugins/reset.c     | 7 ++++---
 tests/tcg/plugins/syscall.c   | 2 +-
 23 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index 5913cc6c637..f2b1b258a90 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -28,7 +28,7 @@ static char *filename;
 static struct qemu_plugin_scoreboard *vcpus;
 static uint64_t interval = 100000000;
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     Vcpu *vcpu;
 
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 56508587d3a..f41ddb0aa43 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -694,7 +694,7 @@ finish:
     g_list_free(miss_insns);
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     log_stats();
     log_top_insns();
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b5e33f25f9b..4d00879ccad 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -134,7 +134,7 @@ static gboolean filter_non_branches(gpointer key, gpointer value,
     return node->dest_count == 0;
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) result = g_string_new("collected ");
     GList *data;
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 5edc94dcaf6..458c0d2084d 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -86,7 +86,7 @@ static void count_block(gpointer data, gpointer user_data)
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     unsigned long count = 0;
     g_mutex_lock(&lock);
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d00d9c4ff39..d347ac25b6f 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -400,7 +400,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 /**
  * On plugin exit, print last instruction in cache
  */
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     guint i;
     g_rw_lock_reader_lock(&expand_array_lock);
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 8ecf0339974..92859872ac9 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -70,7 +70,7 @@ static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
     qemu_plugin_scoreboard_free(cnt->exec_count);
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report = g_string_new("collected ");
     GList *counts, *sorted_counts, *it;
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 9d48ac969eb..a6d83b06c75 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -73,7 +73,7 @@ static gint cmp_access_count(gconstpointer a, gconstpointer b, gpointer d)
 }
 
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
     int i;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 42bddb6566d..75728896198 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -172,7 +172,7 @@ static void free_record(gpointer data)
     g_free(rec);
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report = g_string_new("Instruction Classes:\n");
     int i;
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index a9838ccc879..b7f96117e94 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -106,7 +106,7 @@ static void fmt_dev_record(GString *s, DeviceCounts *rec)
     g_string_append_c(s, '\n');
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report = g_string_new("");
     GList *counts;
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index f110c565bc4..7614ae1eafd 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -124,7 +124,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         quantum_insn, max_insn_per_quantum, NULL);
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *udata)
+static void plugin_exit(void *udata)
 {
     qemu_plugin_scoreboard_free(vcpus);
 }
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 36b003ead2d..c1c2b0aca8e 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -77,7 +77,7 @@ static char *path_to_unlink;
 
 static bool verbose;
 
-static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
+static void plugin_cleanup(void *userdata)
 {
     /* Free our block data */
     g_slist_free_full(blocks, &g_free);
@@ -90,7 +90,7 @@ static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) out = g_string_new("No divergence :-)\n");
     g_string_append_printf(out, "Executed %ld/%d blocks\n",
@@ -98,7 +98,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
     qemu_plugin_outs(out->str);
 
-    plugin_cleanup(id, NULL);
+    plugin_cleanup(NULL);
 }
 
 /*
@@ -393,6 +393,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     our_id = id;
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, (void *)id);
     return 0;
 }
diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
index b3a6ed66a7b..40f8fd313d7 100644
--- a/contrib/plugins/stoptrigger.c
+++ b/contrib/plugins/stoptrigger.c
@@ -93,7 +93,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_hash_table_destroy(addrs_ht);
     qemu_plugin_scoreboard_free(insn_count_sb);
diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index a741580fbf8..4b879a8212a 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -44,7 +44,7 @@ static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report;
     report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index f974090e23e..a071a34ea75 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -928,7 +928,7 @@ static void vcpu_end(unsigned int vcpu_index)
     memset(cpu, 0, sizeof(Cpu));
 }
 
-static void at_exit(qemu_plugin_id_t id, void *data)
+static void at_exit(void *data)
 {
     bool system_emulation = (bool) data;
     g_autoptr(GArray) traces = g_array_new(0, 0, sizeof(Trace *));
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 3c6f32bacfe..d7d972103cb 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -142,11 +142,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
 /**
  * typedef qemu_plugin_udata_cb_t - callback with user data
- * @id: the unique qemu_plugin_id_t
  * @userdata: a pointer to some user data supplied when the callback
  * was registered.
  */
-typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userdata);
+typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
diff --git a/plugins/core.c b/plugins/core.c
index 21a3c5b15cf..b0532e8d0de 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -147,7 +147,7 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_udata_cb_t func = cb->f.udata;
 
-            func(cb->ctx->id, cb->udata);
+            func(cb->udata);
         }
         break;
     default:
diff --git a/plugins/loader.c b/plugins/loader.c
index 0d587c344c4..b10ebe8cc05 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -339,7 +339,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     if (data->reset) {
         g_assert(ctx->resetting);
         if (data->cb) {
-            data->cb(ctx->id, data->userdata);
+            data->cb(data->userdata);
         }
         ctx->resetting = false;
         g_free(data);
@@ -358,7 +358,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     g_assert(success);
     QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
     if (data->cb) {
-        data->cb(ctx->id, data->userdata);
+        data->cb(data->userdata);
     }
     if (!g_module_close(ctx->handle)) {
         warn_report("%s: %s", __func__, g_module_error());
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index 36776dee1e1..8a854408aaa 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -40,7 +40,7 @@ static void gen_one_cpu_report(CPUCount *count, GString *report,
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) report = g_string_new("");
 
diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
index 73dde995781..1d17884b40b 100644
--- a/tests/tcg/plugins/inline.c
+++ b/tests/tcg/plugins/inline.c
@@ -121,7 +121,7 @@ static void stats_mem(void)
     g_assert(inl_per_vcpu == expected);
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *udata)
+static void plugin_exit(void *udata)
 {
     const unsigned int num_cpus = qemu_plugin_num_vcpus();
     g_autoptr(GString) stats = g_string_new("");
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index e6c5207cd69..12421054f67 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -190,7 +190,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     }
 }
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) out = g_string_new(NULL);
     int i;
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 6b0732dc0fd..5cdf71c7e49 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -68,7 +68,7 @@ static gint addr_order(gconstpointer a, gconstpointer b, gpointer d)
 }
 
 
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
index 6ea675b8095..ef5a32781b2 100644
--- a/tests/tcg/plugins/reset.c
+++ b/tests/tcg/plugins/reset.c
@@ -14,7 +14,7 @@ static qemu_plugin_id_t plugin_id;
 static bool was_reset;
 static bool was_uninstalled;
 
-static void after_uninstall(qemu_plugin_id_t id, void *userdata)
+static void after_uninstall(void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
     qemu_plugin_outs("uninstall done\n");
@@ -34,8 +34,9 @@ static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                          QEMU_PLUGIN_CB_NO_REGS, NULL);
 }
 
-static void after_reset(qemu_plugin_id_t id, void *userdata)
+static void after_reset(void *userdata)
 {
+    qemu_plugin_id_t id = (qemu_plugin_id_t) userdata;
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_outs("reset done\n");
     was_reset = true;
@@ -45,7 +46,7 @@ static void after_reset(qemu_plugin_id_t id, void *userdata)
 static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
-    qemu_plugin_reset(plugin_id, after_reset, NULL);
+    qemu_plugin_reset(plugin_id, after_reset, (void *) plugin_id);
 }
 
 static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 5658f830879..938646f9359 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -207,7 +207,7 @@ static gint comp_func(gconstpointer ea, gconstpointer eb, gpointer d)
 }
 
 /* ************************************************************************* */
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_exit(void *p)
 {
     if (!statistics) {
         return;
-- 
2.43.0


