Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A7CA9ECA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 22:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFfx9-0006Ix-7v; Sat, 10 Oct 2026 18:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFfx5-0006Ig-K2
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 18:54:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFfx3-0001lH-Lk
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 18:54:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMAcsB2794008
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 22:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4Do4FFxT9H1f1z51+apEjERGnZz9r6O9ucT
 CGazzRgw=; b=hs/mjFnLfolJFYhKYRlRxq6sAvTjGx5fRywDWRrZ2377Sgsj49N
 FSBlVYwTi2fmId+MlqQZgRBWQKco3KLLmQCeeMCDZPBiio6Cn72ADav7hJdrTkxL
 2mQUa/cQTXo8gYSjtYcsNg950+urKAjisKp7ywZHo2YLj9IGgrkl31oGKV9Pf5xi
 tdW4H3fFWmhyuj4t0XM8Bd2rdqV0z5QqKWmkxfljJQfXFPGpppBj1Ji/WaOrG3mC
 5nWPw7gXhYhjL1J1frYRtdE//ufVOV5ZIJljxY6VW5wBNNRxf/9wbQkc1GC/Sq1B
 uM7RrEXpTllwOVnKY2qnaQrBB3X87VLrZHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7casa3h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 22:53:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35158d674e1so3904425eec.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791672836; x=1792277636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Do4FFxT9H1f1z51+apEjERGnZz9r6O9ucTCGazzRgw=;
 b=SVXhV5mayBZEED8O1LM0jieaVp4spJzMVrRjVVOQy8vnQ0grRGfHXWKOVKtXWw8LlB
 8z3T+xtw3NPVLDvfPtLsAGkcKCt9pvcuCp07J3zIFRKrRHknGEDk1yfKgxa7CQlR33IC
 nSkPjaBYtiHeGownAV3lYC58lBEGGEPS14QLO0m/xiRDSQdiK8KVwfh4vki0BKQtwv1b
 hBsRz91ViG+Tix2wtRTHo8rC2BjdGAPmS5JVpIWozYiq4iGX1gavkJ6GRsrZMgLMjxDV
 FonRvTcqS8MCdC3Iar2/5ffqhtQQbCrrUE+AZMqBqGdlMt0B3Kxk7d/u6n77ccyqtsSe
 pHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791672836; x=1792277636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Do4FFxT9H1f1z51+apEjERGnZz9r6O9ucTCGazzRgw=;
 b=WTaNmop6BqzSjvfm8cOKEWkq7yK3xsC99GBAoCM9LnaWkQ5aILaUFxlSVNpxMD2SOm
 5rTQpyRVYB2yle3NDs+ba90FDyp2wezSVd61d4/zW1pa2LcEZpsN6b+OPvWDt1obNT8F
 SyGTQ0S9CIBhR0MMKQ8AdvM62rb15TVQXj1rKtxXj2lcwk76GKX8Njhse4lu7ND0p/R+
 Mdt3+cgBRrA+SsywcgiFY7LsppXh38459shfwElxwhIcPk8PdpUsr+ofzSwHb4Baqw41
 TTxE3QLl1PWoJBuSLWVq/VldOb+z0D1BvNhNMFjUzX7JxtbxZxRyJbOw6Q9mFbQ8knBu
 Dwrg==
X-Gm-Message-State: AFq9FYJ9yhxB599aSaTOaF8tc9Y1xNjxtuXKZU+TaAJKHFajlEFd4lix
 hYhOlujJcSI70Hdbp/SlPXpOs+o86MS0u/QzMFjCnEC1JXHmgCQQDnUG3tFJgfB9NzwwRpcUvac
 DzKMuHcrcaojjg8oZ8o9W//vLDkAewhEJ4NVajqPY2t7y4Jsdlm50mDIWihiRnP4swA==
X-Gm-Gg: AYBFou3/r0UhzR/Z52xRPXqNT01Au/tf7ZHThA/qLJwlbEbSMzY0cUt78vulpqwWUqi
 uozRNS5Dgg5FFJ+DUGeNnUSlxPOUP6w4SmRwWjEl6IP6TRFgCbW06T9CXEiC9zqACYJpQ78g17R
 BudCFm/yRArz94GH2TlQP+XcpryaCOQdcN0SPPwKPGHWLysHD3XZMdKRJT3Fz+EjGwlguQfpUfP
 G11oHI9WM7hsd/TIEiqjxvUXiRcdckuhMGIRSWmdG9pbWuSDxaiqsq1sU3a9ZC3NyQUi1yjK8FT
 bscEOD09pRuea0ygQF2VqN8glt1F5DV6TMj8ZRj7cb0K9wDSJqH+mEx2+AtLbhiB8Ng8oxuZv7n
 ASG4sZMkn9ZogVTu//SBDt0CrhAGgGJhNq21/CO2S0LaFYjGN20l3VRquDycJ
X-Received: by 2002:a05:7301:c016:b0:351:1cc6:995e with SMTP id
 5a478bee46e88-3537dde3aeemr7618142eec.5.1791672835777; 
 Sat, 10 Oct 2026 15:53:55 -0700 (PDT)
X-Received: by 2002:a05:7301:c016:b0:351:1cc6:995e with SMTP id
 5a478bee46e88-3537dde3aeemr7618103eec.5.1791672834869; 
 Sat, 10 Oct 2026 15:53:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm6004435eec.31.2026.10.10.15.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 15:53:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] tests/tcg/riscv64: remove forgotten Makefile.softmmu-target
Date: Sat, 10 Oct 2026 22:53:51 +0000
Message-ID: <20261010225351.79098-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MSBTYWx0ZWRfX0y5I2bM1uqFn
 ivvbc636/8PzgqaI4YqbTWNjuJGm2os0d9kwi7jB8MMET74iUH3UH6kG1F8i+Dl7moEba687J39
 bNaH9XdmljLxvV/SpWF1d3AP7mjNAnk=
X-Proofpoint-ORIG-GUID: E29LGZV7PXqUiPu0iU7lTF274n3AC7m_
X-Proofpoint-GUID: E29LGZV7PXqUiPu0iU7lTF274n3AC7m_
X-Authority-Analysis: v=2.4 cv=eMWGH3p1 c=1 sm=1 tr=0 ts=6acac204 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=zzQR_8oM-p7h9UWrr-IA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MSBTYWx0ZWRfX6xWLJZs6n4jS
 UZfeBBK3BeWA+j1Uril6d4YYbkKiXO7lIYGE+A/4h/zagkpXKlZXmbzHQE6/Lb+RvCeEwqt+qio
 tRET+nPg6337lXat9T3uSp4BS3bjusjaIW9PVh1vtdLbn5fztuCw0vV5LlcVremIL1fjj4N6MjN
 ouQSjpYD6GyN6rnK2tSbZEJUVb32OYPdySq4TT2UBlaQvjiZUgSq89t8LV3cVsFEK6fS3cYs5v5
 Dr8w9uYf6nLEDORJmLJiqkUsGMAdhAEnV7LFniG8pdh/JCMiREdYl01OR160KB7huYoMebXU1lY
 EtEQRTnVYO7Dm+8MT2R7WfQd2JHPvmI41nBL89doS7zU2pORnORFDZ3QsF7c7ZFQsK46I3QlQMv
 intPjn/TngyVwYPNn+8btE31e+0mc2wlFQ+MuGEWh9rMKalf8gv9BeXbwpM30q+IRQmnSuwyyrF
 y24MVaxLZBQF9yzLoZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100091
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

During meson transition, this makefile was left. Its content has been
correctly ported to tests/tcg/riscv64/system/meson.build, but file was
left.

Fixes: 57ad9fe2596 "tests/tcg/riscv64: system tests"
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target | 89 -----------------------
 1 file changed, 89 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
deleted file mode 100644
index f2c75abd57a..00000000000
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ /dev/null
@@ -1,89 +0,0 @@
-#
-# RISC-V system tests
-#
-
-TEST_SRC = $(SRC_PATH)/tests/tcg/riscv64
-VPATH += $(TEST_SRC)
-
-LINK_SCRIPT = $(TEST_SRC)/semihost.ld
-LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
-
-%.o: %.S
-	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
-%: %.o $(LINK_SCRIPT)
-	$(LD) $(LDFLAGS) $< -o $@
-
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
-
-EXTRA_RUNS += run-issue1060
-run-issue1060: issue1060
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-mepc-masking
-run-test-mepc-masking: test-mepc-masking
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-minstret-ecall
-run-test-minstret-ecall: test-minstret-ecall
-	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-doubletrap
-run-plugin-doubletrap: doubletrap
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-interruptedmemory
-run-plugin-interruptedmemory: interruptedmemory
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-crc32
-comma:= ,
-run-test-crc32: test-crc32
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
-
-# Zicclsm: misaligned load/store support. Assemble one source twice: the
-# default build expects every misaligned access to succeed (zicclsm=true),
-# the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
-ZICCLSM_MARCH = -march=rv64gcv_zfh
-CLEANFILES += test-zicclsm test-zicclsm-off
-
-test-zicclsm: test-zicclsm.S $(LINK_SCRIPT)
-	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) $< -Wa,--noexecstack -c -o test-zicclsm.o
-	$(LD) $(LDFLAGS) test-zicclsm.o -o $@
-
-test-zicclsm-off: test-zicclsm.S $(LINK_SCRIPT)
-	$(CC) $(CFLAGS) $(ZICCLSM_MARCH) -DZICCLSM_DISABLED $< -Wa,--noexecstack -c -o test-zicclsm-off.o
-	$(LD) $(LDFLAGS) test-zicclsm-off.o -o $@
-
-EXTRA_RUNS += run-test-zicclsm
-run-test-zicclsm: test-zicclsm
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=true $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-zicclsm-off
-run-test-zicclsm-off: test-zicclsm-off
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)zfh=true$(comma)zicclsm=false $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-misa-w
-run-test-misa-w: test-misa-w
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
-
-# Test for rv128
-EXTRA_RUNS += run-test-rv128-mstatus
-run-test-rv128-mstatus: test-rv128-mstatus
-	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-rv128-sstatus
-run-test-rv128-sstatus: test-rv128-sstatus
-	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-vle32ff
-run-test-vle32ff: test-vle32ff
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
-test-vle32ff: CFLAGS += -march=rv64gcv
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
-- 
2.43.0


