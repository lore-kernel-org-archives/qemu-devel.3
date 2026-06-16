Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F9CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkx-00058R-2r; Tue, 16 Jun 2026 14:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkg-0004eX-Bg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkb-0000SD-Dr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOTaN302775
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WBXY0uuy3S/
 j/y9EZ6C2T9m4jVJbREIcIk1N4sTn3u0=; b=KU1FpYx8l7LJ5vLc4Zh4J+m4TtR
 rbOsQod4tqg17EmmFqCRt376mXlAwoRPxjA7+iTy8qFGCBlkyBzSW3HwpY7rDfu/
 z88w0yaRBKvqyZM/Yt8njFrgmjd1G8Hv5OgC/bYuSh0q64IJo77EpXnXaFVrYiMn
 PwlUHod1w6NJ5fZbCFlb7CRi7fDvGDMClClyf2sWjoQ5yjceCqZUeItd5PF8YjEL
 CKlkByuyUx/KQexX3BxpzHpwA5wgTrL3kqsOWby3/eDK/oqxGkDrhh75bpDvB0vp
 uKouQ4Irmjywxu9KWH6TW0cb5SlMbuHpMPtBPMA6WiSggbHtGKH+jwqJjkg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7d7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842278a630dso6201962b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635373; x=1782240173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBXY0uuy3S/j/y9EZ6C2T9m4jVJbREIcIk1N4sTn3u0=;
 b=gQlesPzQpu47aoijJuGSLzCUCZvdgdJN/dZHFODxG69neP1QC70vemrtLT2kgEzbV8
 UkaGQjgme/cmhxQM1rxZZn4I88zpt6/6J/j9vLi2vf01d0KSuxjgb0ICXbAj3BjypIFI
 PwedHld/nAo48gDv0oDGTKZWHzvd5CLpU+FPtulj8/9oAQBurtqiAmkGaV4cK3a6oiJ9
 wFJDLFdbwzNilXYnxdseRgpq6wUOa88fjVQsYt+BSpYTAvPC869kHWXoZcmQVkeIG176
 QpC2NEn0ZRbY2npKjURBwzRnBDfvbpN3G0LDJ2DayurN11zB4oXwELtLgH8ectqYtRBa
 p1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635373; x=1782240173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBXY0uuy3S/j/y9EZ6C2T9m4jVJbREIcIk1N4sTn3u0=;
 b=eKM9ckMR0xHtUaVjRZk8gNsveGvKXNIDFQZfje8x6N5R3/YtqMOptRJ/X0E9ie8rTD
 dG0igl97G/V+tutN5xXtHd5n1aGQzHEruKAvosya77kimgqXZL24jVGh7LL892L6COP8
 MODLy/mnnjE7Evp3mLbOKnS0n25EiTylYzd/WO36+V1UurMnzsNTOTOQ848JqS8euzB7
 DdiO2NSQ5j0bR3WbxRNaCpU1eLHXln2vWlSdQK97Zdh7XcdpY9vyEk5xA8hhLaqC304c
 3dSoBY2IH5RT18WsZNITWSn84k1RxhNav3Mcmgm4wMpmvM6VGQidlpioXC37MI4A4aXW
 Z9sg==
X-Gm-Message-State: AOJu0YytBxJ9nLsxLcHVLDM/iWmyyqiE2eH2PYIwWAoXFB1Y0eNUyugr
 RlX3A+u64SQJGoDRuMKEMheAE99Unzvn8acKkAwg+Rf5HVMR676UUCpo5oFMw1OsYOtfp6iHAcM
 q4ymr6jTyq25pBK/KoDL59IzmPLXlLjSihPp2//6ZpxnqcD2SKHEtyU/ZRBj/fgN2sS7A
X-Gm-Gg: Acq92OFRuyodvmdBUlvkMzl41SXCYJDFB+5AMHmrPxqMFt8GE16jfgds3ivrgnfeCq6
 G6OpmX2CzXZKSmrNElqBwk702yKVjb9mH8NHaGIwtM5b1gFQebFYgRn3tu6gtXZbnoPugfh3zA6
 ZYv0eR29kBargEgjDkf+kRIJ2mGMhwBpnvvQDZM9Q2Gxeero8rqs2k5JPK/mSoM88PKhm+5RgQT
 6DFoLg1zI1Jkd45hzj4Xho1tH80hHwenV/4w5FFMNSpz+BUcRqrfzvsmH0IfmsALlKJl1z+Yfpw
 KC4KyjpSnZZi7VDUlcnkQczwgaGvXixVXbdo04/bizAvBIDPxpoccSDIJFTMXmHSMnd/UgberSN
 Yn3Lj/CX3viFokYbqEFi7DCRSOU0HO9b9t0GMfE1z78x5aD8mUIk1VU7Vdqj13yD5Ial1pbdRwP
 K0unRDXcw=
X-Received: by 2002:a05:6a00:228f:b0:827:2a07:231d with SMTP id
 d2e1a72fcca58-84524480d7bmr371772b3a.17.1781635372414; 
 Tue, 16 Jun 2026 11:42:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:228f:b0:827:2a07:231d with SMTP id
 d2e1a72fcca58-84524480d7bmr371742b3a.17.1781635371818; 
 Tue, 16 Jun 2026 11:42:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_tb_trans_cb_t
Date: Tue, 16 Jun 2026 11:42:19 -0700
Message-ID: <20260616184230.303038-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31992d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=deo0yMGDrNm56YX46o0A:9 a=O8hF6Hzn-FEA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX9ahtqm8T0c0Z
 yfkGORJQRbHyURCDyrzwd8gx9p21HvWBcw4hpT8dznqe25zYX+QpogyXQet3v73l8I8hVwG1bul
 7UaIcfm8bB/EBlLphhu9QH2f9u6UhW0=
X-Proofpoint-ORIG-GUID: k1ovqoRcCUnXsEKZyXrJ3BAbvgmy54uq
X-Proofpoint-GUID: k1ovqoRcCUnXsEKZyXrJ3BAbvgmy54uq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX6Qq1WWMt0HGl
 dwlA8x68o0gRUgvoPMpF9ZDg77jIv8f3sum8p48Ni7FosAumlacisSxTvmM/emX0ySCSx/C/9PE
 xPBeyLPlgKzHVItDz/3fLxU4S+AC7SojCG1uYXh56ZLbzFxA4bI5fdg1uYpIuFMQbDrrDY3V4sB
 uMQM9L42zemUe2fGiyUyiATASzVxi29pO8wwnkIXuYf4kwyqS1MH3HMT1VPAWE2fe4GREAN897t
 8vHxmLWZsKUudEZ9MPa+H69BIRpDrpz4bZw/2qR9/ysqyozzeqRaNp5GGC0Wy7LtdUKN66Lgrtr
 JjpFMtRqPok7ypWZWa27U5myoi86/+GUNj34BHYkwliNaPK3yYuyRa026csSy4tSTJFUlm2Ardl
 3z++k7F7xgkQWjPiBMYMT8tnxwMPjS0fX0xvOAmxg8YZeS8dn1TA3B3UqX4E1E9Iv0OR4QcYKMH
 VdZIMEU+eKYGtERyLhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-16-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


