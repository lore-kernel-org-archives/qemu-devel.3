Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF95606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IGzEnYj9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBhQN02n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IJ-0001Bj-Jx; Wed, 28 Oct 2026 15:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hz-0000vY-Cv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hw-0006DB-81
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIcLb41918602
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VdjVnyP/Xl7ebgrAByuaYUpcaFeJdfsiXa0uVyWNDww=; b=IGzEnYj9Pb09Dq3W
 iDkyXmgi36mgZAvOo0ECOIzTRHwXbSXvKZaw+IgQBnvwXFXbA4UsLCIR0r5vXzT8
 XxcAd9YizpAdlz6+0TPCaz23IR3lGsFI6WQE0nYTGsFVOAsp+g9105GJpn+p8Huu
 QUr+442i1tZGABuj8OkAWQneP4Jt9B6ZIEFkpH7nt2Wq17HcPK/dXym1Re/21tkW
 jDC0FmizAk9zp0TDWGT6hhAeh0QWvZtYtjFGIghhFQGcETjsK06VjlrRiaxRvYxc
 fxMpmE6qiWwVzVZltxkuYMjAq/yt/DlwDCPwxK07NkPEfZ2LpFDxwHbA00c11Ewm
 0XQv2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpr614-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f568dee56so169668785a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215578; x=1793820378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VdjVnyP/Xl7ebgrAByuaYUpcaFeJdfsiXa0uVyWNDww=;
 b=jBhQN02n8x14/h1Ow72bmgaG0QzwQJZX907lkflZpwapnoEJ6DhQQIcqCfeWXSjSQ4
 7pZd8UXOSgf0kDFHOJHmZas0QWllaYrVxgmkBV3OeHmDv/KMGHvvOxZdcAd1ERQRjdZ9
 2PGE9z4ZnGQ0iuKlSl6kk5OJaR+EUWKBAxcE9hOsMOH7kNIR+1aDC40JYKfyF+EcGvTk
 tacB2AplRRBAaHnDiyXHBgP/inCv/lCtSMRPqSCwgA3atCrhnvpMXI15DNUTHKHbhmVc
 E1sLFGxBhk7UmCLBtv4XPMfNsuZ3j2LMP3dhEFgPjnFknIkQzjKpqK1TuDe7Krw5j/pd
 2Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215578; x=1793820378;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VdjVnyP/Xl7ebgrAByuaYUpcaFeJdfsiXa0uVyWNDww=;
 b=CAtuTwQ36+ufliubbY80Xf6pKAufsZY+rP94FcNgx1TN/iCvjwjp0FXfiB/jvl9pdU
 splOOOWP8nYtTffBZ6S95wTj8R4QxzUoGTTX9k41z8wGflxkTcMphaERIG+TTS7xWIf5
 liG9xaU8vgNQYAIi6uu3XyUnUuJADwnB6yMNbGWujojWgWsKpl/MHOPtyQHdD/X1WpHc
 t1MTDFwOabu+4KIT2AkA5QOHEQ2sXmcM+eTh6CF/8oQ/hzg+qbyKkLmVJjbPPHNCnW5O
 7/6wWikn5vsKKWKLLx5cbv8LbrBXFpvyK+GEWjhYMRkGALFG1UwlRoza59Ay9IIrj1fS
 Rx7Q==
X-Gm-Message-State: AFq9FYKtgDE2IrnVzOlb0ze7U+bRGIHGXckSs4oXFWM8gubeEt5YkFQv
 M93mkLkSAEWsHcA1U36gBDHKepQWD46z7juWdYUPyQWErOYYUB95X0LKCciRPRejZfd3NiMjLbh
 WKEgfHdXgnsRiIScGdK2bBnrZ+gn3hoV0iTNJPsyZqtNo/b/9VMyBa2jwNZRYAHn+STOE
X-Gm-Gg: AYBFou1Rd6MaCqZvSpLRiANQ67EdxhAE2v/bO7TYu3Cj64+zFXAVIRjCHuYSoqXBVks
 OgH50q2/mV4Zwf5t/NLmX3P+h9F0S7j1uxs7NQx46EamV+paDFt83xewXf2w82ilxZ8S5B9qLoJ
 zpuI2vKLnrCpXmNDZxzKRIOkKGygdOpCGi13Y3jcC6ZIa1Csm+gZLIWjicJE81UBRXw17RSS/WQ
 8DsPuurjAv3qx26ckKaBnz8gKeK/e5tOW+6WKUDwqBu9As3A5g9zyHvLyiEnamkfDY25wp87BBN
 iXUt7ErKkCgFRr0k7r34mf0Gp4nXZhtfHElftizPoo5sCsEtD1HIdW+A9di27P0kawBcdF7zdF1
 fwx5sYd2bAMdV8cKhQXclsyp3aN5WBGfSi4aB4Q4RVK+O1wGWwDNzYRXexU1Vdtp8jR7rmRRabl
 hiG4RUSo4Hl5wKL483FhaeR+N1nOqPmQ==
X-Received: by 2002:a05:620a:2806:b0:93e:d5c1:da49 with SMTP id
 af79cd13be357-94408d929a8mr500564285a.82.1793215578192; 
 Wed, 28 Oct 2026 12:26:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:93e:d5c1:da49 with SMTP id
 af79cd13be357-94408d929a8mr500559885a.82.1793215577708; 
 Wed, 28 Oct 2026 12:26:17 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c1302f6sm15361525e9.0.2026.10.28.12.26.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 5/9] tests/tcg/mips64el: Move R5900 tests to system mode
 and build with meson
Date: Wed, 28 Oct 2026 20:25:33 +0100
Message-ID: <20261028192538.31600-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX3CypPfGE7bZr
 gOXxsPeMity9r393U0isJMM80ZCgY2P9S5XWw3Oy3UIeES8lTQr2CBl1DKJme1ug7q9A2Hd5exG
 4GxTtX0sqBgUpSkTJgz/4Y4wdX8S80LOrjW8MbuJM0KnTUiaANCuq1rakNryPfHQ767bUoSTPru
 qIaajA/kNOWn+p66d/KT0AXjyiU60Db7t1aMeEUVl1HEqNhi1HqlAEkOFZHwokwpiryzGk/66vQ
 paB5XEb59ZshOn0yceB1WtAuDtstmgxm9SdvtOv69Mmu346eEp71QCg2F/mgyyQPh/Bqz6p9/Dg
 lCN6UoTqt/G4bcsSTaOLeqzebvEpyupo0gTN6z9DJO9usrvsSg6tZ73/Q9BQ86/ipoTHWtOpYYi
 C3q2c2ALIHfxTqx8ufQMbPZBD6tsIMDp/8oURpNcFvlK1ht10uo3ghdPfogVNok/iRMXCZ3WmI3
 r8MuavEcaQcYPHNDlfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX3HZJAyDRC7t8
 VA3XdGaO1NIX4EU+zMR2p8fXI4+pheIcPhkgb6uFajPI7oB8CMOJRsBxep6uYGpUU1/8TMus93A
 ZVykCuRm5Qy8N86xjXOgtWUmoGnh5wE=
X-Proofpoint-ORIG-GUID: AP2LMOdw22mSpfy5TOxvaz6yL8xsH3o9
X-Proofpoint-GUID: AP2LMOdw22mSpfy5TOxvaz6yL8xsH3o9
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae24c5b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=47JgC6xVqMb-1aZxQesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

The Makefile needs a toolchain we do not have and qemu-mipsel,
which no longer provides the R5900 CPU. Move the tests next to
the bare-metal harness, register them in meson.build, and remove
the Makefile and the obsolete README.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 .../system}/test_r5900_div1.c                 |  0
 .../system}/test_r5900_divu1.c                |  0
 .../system}/test_r5900_madd.c                 |  0
 .../system}/test_r5900_maddu.c                |  0
 .../system}/test_r5900_mflohi1.c              |  0
 .../system}/test_r5900_mtlohi1.c              |  0
 .../system}/test_r5900_mult.c                 |  0
 .../system}/test_r5900_multu.c                |  0
 tests/tcg/mips/user/isa/r5900/Makefile        | 32 -------------------
 tests/tcg/mips/user/isa/r5900/README          |  6 ----
 tests/tcg/mips64el/system/meson.build         | 20 ++++++++++++
 11 files changed, 20 insertions(+), 38 deletions(-)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
 rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
 delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/r5900/README

diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_div1.c b/tests/tcg/mips64el/system/test_r5900_div1.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_div1.c
rename to tests/tcg/mips64el/system/test_r5900_div1.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c b/tests/tcg/mips64el/system/test_r5900_divu1.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_divu1.c
rename to tests/tcg/mips64el/system/test_r5900_divu1.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_madd.c b/tests/tcg/mips64el/system/test_r5900_madd.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_madd.c
rename to tests/tcg/mips64el/system/test_r5900_madd.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c b/tests/tcg/mips64el/system/test_r5900_maddu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_maddu.c
rename to tests/tcg/mips64el/system/test_r5900_maddu.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c b/tests/tcg/mips64el/system/test_r5900_mflohi1.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_mflohi1.c
rename to tests/tcg/mips64el/system/test_r5900_mflohi1.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c b/tests/tcg/mips64el/system/test_r5900_mtlohi1.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_mtlohi1.c
rename to tests/tcg/mips64el/system/test_r5900_mtlohi1.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_mult.c b/tests/tcg/mips64el/system/test_r5900_mult.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_mult.c
rename to tests/tcg/mips64el/system/test_r5900_mult.c
diff --git a/tests/tcg/mips/user/isa/r5900/test_r5900_multu.c b/tests/tcg/mips64el/system/test_r5900_multu.c
similarity index 100%
rename from tests/tcg/mips/user/isa/r5900/test_r5900_multu.c
rename to tests/tcg/mips64el/system/test_r5900_multu.c
diff --git a/tests/tcg/mips/user/isa/r5900/Makefile b/tests/tcg/mips/user/isa/r5900/Makefile
deleted file mode 100644
index bff360df6c97..000000000000
--- a/tests/tcg/mips/user/isa/r5900/Makefile
+++ /dev/null
@@ -1,32 +0,0 @@
--include ../../../../config-host.mak
-
-CROSS=mipsr5900el-unknown-linux-gnu-
-
-SIM=qemu-mipsel
-SIM_FLAGS=-cpu R5900
-
-CC      = $(CROSS)gcc
-CFLAGS  = -Wall -mabi=32 -march=r5900 -static
-
-TESTCASES  = test_r5900_div1.tst
-TESTCASES += test_r5900_divu1.tst
-TESTCASES += test_r5900_madd.tst
-TESTCASES += test_r5900_maddu.tst
-TESTCASES += test_r5900_mflohi1.tst
-TESTCASES += test_r5900_mtlohi1.tst
-TESTCASES += test_r5900_mult.tst
-TESTCASES += test_r5900_multu.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) $(CFLAGS) $< -o $@
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do \
-        echo $(SIM) $(SIM_FLAGS) ./$$case;\
-        $(SIM) $(SIM_FLAGS) ./$$case; \
-	done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
deleted file mode 100644
index 18ecfc3bd0a5..000000000000
--- a/tests/tcg/mips/user/isa/r5900/README
+++ /dev/null
@@ -1,6 +0,0 @@
-This test suite can't be run at the moment. We don't have a qemu target for this
-architecture, which has single-float arithmetic, and custom 128-bit registers.
-Also, a specific toolchain has to be compiled for it.
-
-We keep the tests here in case someone is interested one day to resurrect this
-architecture.
diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
index 265a2eca4ff1..fd5a759c20fa 100644
--- a/tests/tcg/mips64el/system/meson.build
+++ b/tests/tcg/mips64el/system/meson.build
@@ -19,6 +19,26 @@ qemu_args = ['-M', 'none', '-cpu', 'R5900', '-m', '16M',
 gdb_test = ['--gdb-args=-ex "set remoteaddresssize 64"',
             '--test', files('test-r5900.py')]
 
+# o32: 32-bit pointers, 32-bit GPRs are enough
+foreach t: [
+  'div1',
+  'divu1',
+  'madd',
+  'maddu',
+  'mflohi1',
+  'mtlohi1',
+  'mult',
+  'multu',
+]
+  tests += {
+    'test_r5900_' + t + '.c': {
+      'cflags': cflags + ['-mabi=32'],
+      'qemu_args': qemu_args,
+      'gdb_test': gdb_test,
+    }
+  }
+endforeach
+
 if 'qemu-system-mips64el' in emulators
   tcg_tests += {
     'mips64el-softmmu': {
-- 
2.55.0


