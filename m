Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A2x/RyII;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ErCaWyip
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0R-0000eH-P9; Fri, 23 Oct 2026 12:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0K-00007h-AR
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0G-0002wC-DB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wHw4063428
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lSBam1xv9u6QOI6xwmBpMgg5DLxdjBbzJf8D3Ui4yac=; b=A2x/RyIIDrxONmk9
 vHIWhNg4vZo6ZioLOHef8D8rAfWgnURCn4XO9noGONbvN0Fk+v8w92rfCT0TiODo
 +e3mQ5Z2C1Fyt3kPDQDly30umjAgn7+/ADTw3mlTZCDay+8JCi2l71hTtFC5LJA0
 zHRoJs8SWvh/VizPgojJnjQy6btXbrQNRuEZnb1MextNhMSs7Uj9/oTTAAK4eTXt
 46Ghf+tJ0dwcXEFD3JKCfXWq4PHcUjllw9Jfp/acFWFYjuNMMIvGBUIe1RY50sMx
 SJn1GnwQ7RJ0MCj1qm1ipK8cY0GRxGP72fLxsjF8OMkIXieg6A9tLWvfDOQ1cIS4
 Bje5Pw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrch5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so192732185a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772420; x=1793377220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSBam1xv9u6QOI6xwmBpMgg5DLxdjBbzJf8D3Ui4yac=;
 b=ErCaWyip7Kee5ADNBNR6b3+QhkkGhF8mn7tBtrFui6Ga/tDunpcF6L8YdFpQhROc5L
 5ApAOii9h80LU3r1tmkfNbHudm3gJvm0gzBwNDXtjWvnGdLDJRF9XqpMeacg+i7aYcie
 5mXlbUv674pE2n0Qy2LhCMrAcqsyXnLQuj/Rs3fTRLmF/nbBNuEDJ3m2NrzBUMyV+Jvh
 kwbbGUik1fncPvt0YtoyCBfr6fDiVJe6qJLWOhbjaNnuYpEkkjKcS2blUtl2CBLfhPfz
 GzV0LlW721b3fvo71X2DSQL363fcqWLTA1/zEglTxo8BP8sFH79rG0bvTWwJBWQOxVeT
 jxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772420; x=1793377220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lSBam1xv9u6QOI6xwmBpMgg5DLxdjBbzJf8D3Ui4yac=;
 b=F4MQEKbZXTyTLcnX+Mzm/GF0cSi+rVqLeDKaFWesxNsyoqlYSfS4t37Me5IBeqN7tc
 vkhX2HnpNgw0M64BtM7E+jVxhf7gFSM9r/xEmFG4croNtsTgGBa+X598N9xi+f+LDU4q
 6zsoavlGZBml/oPOdzUZaKqsL2cgfYUJYdFSQOo7Vr2CaT4+0GEJq8MoegK1jk5/NOmX
 vXZ332DViK1IBy2OAbjOH+Or4fFBsgnJ/kzKbD8e7+gtjM3HRp7InUNR63ziuRh1bHmB
 iz+bOBBXQMRdbNnFz8IR+m9uNYejxO3TcqVEXVJK6wZl2vPuDAhE5a7E2Xv3qnDHurfi
 p4wA==
X-Gm-Message-State: AFq9FYJoY7vxQ0Y7FbkAPV2MuNWVGZk2LdDJ4BkL0LHT+IyCcoXM1BGk
 9EjPa0f3ufJgWuC1v3hIeaB3Uy/NNTJfPNCVnio9gSSD4TSMfUS2FCLxENmp7efzr/b2wH2C8pL
 Ihfq5AEj1YWoEE7r8ZrGwFFPr0fYI+VzIgeYlbSemzm8B9Y8cgpyQgtCh1kUcrqbF87QG
X-Gm-Gg: AYBFou2/O3ddVElTdj+yvAxELrSOnCtku7B5hRPQ7nIUlVIHqIAbSQ9DRvYAHnq68CO
 8Xu3b27KmbING3Absveqotgthr1UL6u3cZcabpE4Njy9guHg/15AGluatfs7uJ+qDWxYunl9CYK
 vCCYnrsNAnpB+iT9SkdLhQQoK6N+pzBIy/6SOkfm5gNuQDhsjSKI6sHslkaMjBk0jpEgdg3Z1zj
 zoEVPVr9MWudVtbBqsUs5gl5x2yfALL+kYGborg/2NpljIfByFxeXbDD1wwJs+hZtR3bd/118cF
 DpAVRJ4WCjh3eTN9/Hh4idzqvpR0ApeDzw73wJ+7UxMVNSK7ZcB51CPrHo7GBxLXYeWVzxwPMgn
 zbG1hwOA9SbTMjcLoPegogCArkCxFIuoMX+9pzibX
X-Received: by 2002:a05:620a:839b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-93f6f591f31mr482012285a.3.1792772419472; 
 Fri, 23 Oct 2026 09:20:19 -0700 (PDT)
X-Received: by 2002:a05:620a:839b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-93f6f591f31mr482007385a.3.1792772418890; 
 Fri, 23 Oct 2026 09:20:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d413f16sm745221f8f.42.2026.10.23.09.20.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/83] target/rx: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:04 +0200
Message-ID: <20261023161332.60153-57-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YhdUtd6fBlhwwAWBJHTVM3cvWV749ifn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX7GgPzZ3cOltP
 nznGHYvehjqIaZOvtERXe+YApHmH+TLPEYwETJF0M43Ljrib8LfmYZ7XTA2dFKaoJgHb9o+5Del
 xbPhXd6Rv/Bxq1achTBLBQOEc9btSwc=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb8944 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Qx0XU4k73VZMi5TUh0cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX0o6U4obZSv+k
 3kdEoLZQUm2026dOJbkeeOQZ6mLv51sBCS7UQJcgxXR0shXzOyU/ISW2Psl2R57Xz14n2Jexa5/
 GgWrdCu+wcAUjQ6qEzMhTHu0KfPvS9K/PuUCo25Ez2KfEiNplvSvtrrt9Hfkx0s+sv1go83MxF/
 CyPL+CroqMHn6djAIe53VnRSvH+d19va1Tk25MzUuYZ3CwaPcvCGCSoxn/E6tgkscRdZgNOsxxV
 16jOVqvO26KCnjMV5XH1P0rS0Udhdh8NdNtrT9YNw4ueHNco8ZRMfPz5+S4sGZ89lbD6M5hSkTT
 Bg2Cn1h8DgfrcQOpbm5TQvzNAGZDXFviEkJTficOtZIOQdx/c+psjQMZx3yYgXK11eYLLbmT360
 VyOvGA/hXn9eYb+gVK+nFtPK/4X49ZbZb5A4m6+/w56HmWUAbO14154d4ZuqhCIXUGfXNePTe6n
 V86eBJ67w5RcQUNLOiA==
X-Proofpoint-ORIG-GUID: YhdUtd6fBlhwwAWBJHTVM3cvWV749ifn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

Convert rx to providing the translate_for_debug method rather than
the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261020122752.3651914-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/rx/cpu.h    |  3 ++-
 target/rx/cpu.c    |  2 +-
 target/rx/helper.c | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 06208380621..0c749fc58d4 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -150,7 +150,8 @@ const char *rx_crname(uint8_t cr);
 const char *rx_exception_name(int excp);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr rx_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool rx_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                TranslateForDebugResult *result);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 44ec3c3d62f..c35a98f7cef 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -209,7 +209,7 @@ static void rx_cpu_init(Object *obj)
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .has_work = rx_cpu_has_work,
-    .get_phys_addr_debug = rx_cpu_get_phys_addr_debug,
+    .translate_for_debug = rx_cpu_translate_for_debug,
 };
 
 static const TCGCPUOps rx_tcg_ops = {
diff --git a/target/rx/helper.c b/target/rx/helper.c
index ed9cadc0bd4..f170a14721e 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -159,7 +159,13 @@ bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-hwaddr rx_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool rx_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result)
 {
-    return addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.55.0


