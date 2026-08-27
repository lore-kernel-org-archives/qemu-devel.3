Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F90C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVx-0004gx-3C; Thu, 27 Aug 2026 18:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVv-0004bY-Je
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVt-0000Gf-Mb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:24:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLlSM125024
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=; b=SxdADM7wa0IitYwy
 YSgFiZMUrlbVfXE3SmVNhD7Hv9n6eaIFb6+kRNxX409b8E1TXlhwTvIiLJjrQgP6
 phWf2bUShzagXSf1Y6/nCZn58crh1kxB6Vkp08Rrid5XiVaFUSeJOoZAi1n0Y3TZ
 tqYCs0fF3VAhAgUEo3ohaMEKufG6Sp9BFXvfzbVJQFsFPjVnh5GzTe5YWo0zv3Nl
 h42bjHA+ERoj79Z5dxp8RH3Ij3GlOifq1qrjvyAzniJ+nqF9h/pPpjWt6bdModEH
 +O8yURPgkGO+AvKfFqxGmPbnaRbxHERHrcDIxs5g/s++mbKvbyr+YE4hAGzb8ioN
 zA1kYw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7twmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so3253635ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869428; x=1788474228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=;
 b=kDFODWOBqe6Fs8Sgc+53Iq40Wygi/MrRF1Lq241GWgqjjxEWgc5z8b4ZCmExKv2ylB
 NdRlDiHM/cQZPwMTjaF4W4kXm7OlYScs2Pd1QGGarGMMdpzF9yyUdHKq1XQxNR6B7af5
 MkNTJ55x7ViiQV4GpI8Ap+NcxPR4JOIHNfoEaRdwO+CnFLdlzd3lZECcTVSi7YWIhen+
 x1aTbTrpYo+xQJLamrmiQk5at1VsEUB/+pC9Tx8Bz6uwWaIHlKKDdIbmXbjmk+oZsVct
 LXtTZ3CkzIkDMU5Jx5ic/MPC5FBkn8dLjomnevCJ3qCntCwYMj/1p8JJ3lPqwUNRqWh/
 HOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869428; x=1788474228;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QvpG5TtOVv7/sfZiS/1BzH9v1VLAL1opPEUMfJcOgos=;
 b=NqsJ0i6q/7K3lgiEbzRqIZDV84EF1yhR3xP7+Nb4yNTQsVU4yS4o1rC3WE6f2xp6oG
 ZzzkBbeA9H7xegDVuerP8rKBo6wjWOzf40L5RxGKIKm6WlFaNGcUk2yJvj7mWF7jLQY4
 pmF6FQC3PECtmaDR8Fed9Ia2FYFay5/FrJx4iNjGXdrswNVfFAV6tQKI04+ojnuTaBS4
 siXGMtGwgDd1dGEBHxqI8OKT7Tl6w6aBGcRwkCrhSfPxBV4dKquc5kiPNEU7IiLkY3+r
 tO7Q0qnLRnFd2fJ5Y4EVHmMFwD5/112tWkEyMzqMKanEM8uaACNq4W5WZyP0L5jU+R+G
 Vijw==
X-Gm-Message-State: AFuF++mCrECLOH1GVuhF0zau7HKU03ktzyEScy6KqthrSUfKBONVLZXe
 2iYZU7nP61VX3q3rUF3+EYgBLeIkrX9R62PwBWUwjbIrOvWZodUSmg4Q4PKULaroZxYt4Vwz7+6
 6yi9WxM/YHWHHC/xU6ax+sg/KsL3JNztKbSwo84/he+i+eGzbvafwBlwZt3OSDg1c+A==
X-Gm-Gg: AR+sD11LjvckZ9Hp9RnA91MWS+buW8CGqHEYnYo3YjoxXtClyQzBVQ4p1DptNtDFoK4
 YG9JNCQYk1iWNHhbo+9n+LrtEExP+PgXguPhKn8p4chXy/aHhUWkC56ICMz0Y86NJIMGT+yTdUt
 xAjuTqhUyezWiBoFCB6Rc6A8XOCCdUlrLjzKMJa/2BbYH/+AlGStsbK4+C3fUWYs7B/xqS/aSoo
 vmy43Lf+ZGvXSVQn9QyxUEe96VjYqBpRCtK7WnGxCUlOEt4/X8nG0L73jsuKhurjPn1utkc/p45
 eiiFPSgFgi4YlzMSzolVfNJ5GWwppyhz8jTHT2BQyTD23H9bGSd6+DI0hAQUylvTtlkEfvN408D
 /G9z0mSGg1jRcWSrnvYYUoX0AILC9LEXDW9zc3zn5yKzPgEklc6QI0uQBv0o=
X-Received: by 2002:a17:902:e544:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2d74dbfd1f1mr30236325ad.2.1787869427867; 
 Thu, 27 Aug 2026 15:23:47 -0700 (PDT)
X-Received: by 2002:a17:902:e544:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2d74dbfd1f1mr30235695ad.2.1787869427423; 
 Thu, 27 Aug 2026 15:23:47 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 097/105] tests: remove tcg tests machinery
Date: Thu, 27 Aug 2026 22:14:58 +0000
Message-ID: <20260827221506.91574-98-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX5tltJw9PErZh
 FhdEP9p8gr5Bx2iaEcDy7jrNjcAGHhhtA1QO9JEDvcIsyGPxEGgKz2iGThihKki0vOFsKvARVUX
 QHMSrfm8gkqOB/D3w+nX27XfppzvE0AdVS2AtCBpKzXMLLXPkSlKCou4cMH5qJZCJu3TucAnEix
 1mSHHPX/51Jn4PKEMzkqjXP4PhTQ/fTWXuVzYnNEAlVfm9AzT1bn8Mf11U8dkwt4lIo2FpNKAy5
 wM652XVYbRouiaC3lQLL4GMHu9BalRsBwW7a3G+5gmYfDYAyxYT9xN51zwiaJqYB4qud69C6NSS
 35BdArFExjg/dpgwDqtMcKhLnkpvzvfZkgkAxyhJ6pkWD2llYthv+VHW//5xMo2wODNd+dBbnyG
 +YvXNs8t1CHR91sRLGZkLLfhGwlmiW7Ggn72Z3V6AZ4K3Iru/T5w/hRAQRvinVxX7jU923Tk4Xo
 61xzIVXKMXlnx1OHhFA==
X-Proofpoint-GUID: o-PpPq37lxDj-RfvUlv2i95vJRsiRkYd
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b8f5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=45U3grDSXPH4n2F9VpgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: o-PpPq37lxDj-RfvUlv2i95vJRsiRkYd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX615/vyFufDdy
 sAW513rEs9eDASqHcUsoQZeQOiA8ZWdmwhQmGwitLir6T+l4EJQfFa/clllfovBxAgnJc1w5DsM
 oTWARscwx9y6wlSrw1shlDIp41yQnGs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

It's now built-in meson, which offers targets check-tcg and check-tcg-*.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/Makefile.include | 68 ++----------------------------------------
 1 file changed, 2 insertions(+), 66 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 494d0109f26..9f82552ab54 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -19,9 +19,7 @@ check-help:
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
 	@echo " $(MAKE) check-tcg                     Run TCG tests"
-	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
-	@echo
-	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
+	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a given target"
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
@@ -40,67 +38,6 @@ export SRC_PATH
 
 SPEED = quick
 
-
-# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
-# support for, CONFIGURED_TCG_TARGETS it what meson has finally
-# configured having rejected stuff we can't build.
-CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
-
-# This is the intersection of what tests we can build and is configured
-TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
-
-# Per guest TCG tests
-BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
-CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-DISTCLEAN_TCG_TARGET_RULES=$(patsubst %,distclean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
-
-$(foreach TARGET,$(TCG_TESTS_TARGETS), \
-        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
-
-# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
-get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
-
-$(foreach TARGET,$(TCG_TESTS_TARGETS), \
-        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
-
-.PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
-	$(call quiet-command, \
-            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
-        "BUILD","$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
-        "RUN", "$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=clean-tcg-tests-%): clean-tcg-tests-%:
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
-        "CLEAN", "$* guest-tests")
-
-.PHONY: $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
-	$(call quiet-command, \
-           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
-        "CLEAN", "$* guest-tests")
-
-.PHONY: build-tcg
-build-tcg: $(BUILD_TCG_TARGET_RULES)
-
-.PHONY: check-tcg
-.ninja-goals.check-tcg = all test-plugins
-check-tcg: $(RUN_TCG_TARGET_RULES)
-
-.PHONY: clean-tcg
-clean-tcg: $(CLEAN_TCG_TARGET_RULES)
-
-.PHONY: distclean-tcg
-distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
-
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
@@ -128,7 +65,6 @@ check-build: run-ninja
 check-clean:
 	rm -rf $(BUILD_DIR)/tests/functional
 
-clean: check-clean clean-tcg
-distclean: distclean-tcg
+clean: check-clean
 
 endif
-- 
2.43.0


