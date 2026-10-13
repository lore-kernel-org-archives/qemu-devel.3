Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD1BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGi2z-0008AI-PG; Tue, 13 Oct 2026 15:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGi2v-00089o-8v
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:20:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGi2t-0007SI-CO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:20:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DEq0j71402997
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 19:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hM2ZedeE3ytq7G/xH2Fv1cUe3AvcZ0ZjvytwAJ6Hos=; b=hoJj3AiT4BWTs7NV
 YUJYygLLWW575uhEVtg9WkE6J3KkCBphuIJ8o/RL/B0e4K7ByLNBw7JD9QMbXZHZ
 6GaBBxwwGtB+anfb0jfrn1UxNjkGG0BjCaO42L4JoQVx3MhZN0h3CdRMxUWkWD72
 o46Msemrb8uQLczYa2jOI3y4Yv6tSvsfFUFBoc4KIMeCkcNXuqLBK0DOjmlv72S6
 djLmofk2xn2bxABC+hAGgFUNVIjL6ck+0CveDXIEO2LHRmZxY/yIoI9FUHfCKo0H
 giLvfBrQEGFxLzNOca3sA5O0nTKCwi/qEjF+ExOINuhNnTiE1DNuBura816etdW7
 d11jZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk18q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 19:20:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso8528041eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791919216; x=1792524016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4hM2ZedeE3ytq7G/xH2Fv1cUe3AvcZ0ZjvytwAJ6Hos=;
 b=CF+6jNrhEp47CvpyKNvEleIJwJCgebINOBNFNaCyEXUCU/e46fKzA4fti3uRBzfc+K
 gdKJJDqzjkJt1o+kL/ciTwAr9lG+efLLERvIW7zPSJDjNXa9ONiyqqu2SOn2cdJmTToC
 Cja1xzICeurMMEs/70UT28BZk5DYGvmg4qrj0WyQuOdh4cpo8rP/Uo99P0lDQYC2eWPv
 zwGYk2w8C8b+sGoFcgEE3zAyWxWX+eebci/xFsh3vbZwH7yJ2Hi3cHLS/TO9IaISSpgt
 DEYBIisdfh4sLpkhpQxhdnQmpsa/p4lbwQ+gLju/UL7vubrC07GFCRJDz8J+B+uCzUEM
 U3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791919216; x=1792524016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4hM2ZedeE3ytq7G/xH2Fv1cUe3AvcZ0ZjvytwAJ6Hos=;
 b=23TXWR4XJVUYKhmyhuOS59h5Qbor/Qm4PNoH6tVD/PC/zbF5EMYoD7aLDt4siEelOW
 n+n8hU6uhy2PWN/7ZpUp3Fj507XblHkGNx3xN9A853DU5Hyxmn+U8AGZ4idSOYA2EAgp
 IxpEBo77NtGN8OTnyqeepVwPqPi/Cy7tFagPzc/nlWU3hunD3dg1BuQK8Vv3k6G7Lduy
 NA1ajrNbUyHqZ2KmyCRr6CI3DHL7xCBi09xCVfvBe//pes9va+kz36rYYpYueV6RAx2h
 lfKow2PCmh1KfsLmb+/Ru/JOOmJlzm5LG6/EN+8l+kJmqiUQnWOFUvbg6jwD3CT/s1pk
 o37g==
X-Gm-Message-State: AFq9FYJ+dZk8zVsV2+aygEt2dK+8jSN4WPN7h08DhwraKITo6bGbptRP
 KJR/j+J38T+nrOdMJzbSfpbGim3QUMlex+idi+rlOQnrpTGs9l2RHNeyx/JsgEmPfGX/ntebCin
 M5YCcWGwTbDM5NHC8PUGNgGpaU63hTZoHsjVjqyH/JvMur8w3uKhA0d0xj1UzR1guaA==
X-Gm-Gg: AYBFou3ritNEca6VlAdYtJZrb6sBIXiCznn8dRYoR/kGXYePQm7Z+nIyHQ1cuhGTcjU
 v7yAstDnp80xAcN+Bu+i2Wy0wGLk+k8lEFGGblAcuEYQy/yD2PZ30hOQcKZXxoN/41kbpRzVHpT
 lyTx97pX/Cv/YuB05EAzFr5lRXH+cUjYHKTym81n1XdB22kF0FNgd+sZ4socpYJF3mz3Bk0Etot
 DG0sqcB0CYjGXINBXOl2oMDTNPrGqVX/LG+CQ3hm8c30u5Q+h84LBlh0+EpUMIE/OOPAdyhHCEB
 PfF60sS4ThRdP4OB/jzzx/CXwA0Os9Vsc37ipE98iD6ARcE8PMoUceOxQUNDpUT0Sa/gWA7OICf
 GnxqHqFwRXWdOaSSFt3TvNTIGtvzbH7J31N0B6D+kU9F8PPCg+PLozLjyWM1T
X-Received: by 2002:a05:7300:b293:b0:351:207d:bff4 with SMTP id
 5a478bee46e88-3537deccb0fmr18834556eec.4.1791919216336; 
 Tue, 13 Oct 2026 12:20:16 -0700 (PDT)
X-Received: by 2002:a05:7300:b293:b0:351:207d:bff4 with SMTP id
 5a478bee46e88-3537deccb0fmr18834519eec.4.1791919215499; 
 Tue, 13 Oct 2026 12:20:15 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b690af3easm16100075eec.1.2026.10.13.12.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 12:20:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] tests/tcg/riscv64: remove forgotten Makefile.softmmu-target
Date: Tue, 13 Oct 2026 19:19:48 +0000
Message-ID: <20261013191948.3546-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013191948.3546-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261013191948.3546-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OL7zRdj_Vz0qNs7W2O-MacWuGEU5G1Nk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfX7Lcs1ck+9l8O
 fCIn/zkrwVlyvuuTCUUg+7n/gPH8v8YqQj035mi4B5QoWOiQq89/qlxeTxMfDtied+BS7dYP4Lj
 l1XPP8qVNXtypNBf6AFudvq9PbKIBn0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NyBTYWx0ZWRfX/jRB1daJUtMZ
 VKYh9hMXHlMK2lZDycxzaAfFDylKEGlS25ecIcGp82LWVYAHBdyJ5XLLFRMdjaHVlx7xDG9K6UX
 eHIc9vcPN9h2dN4UIvSEeZmWG8PkPCqdRLZICiSst4w7ViCZgdl8vzNRRuPeyGe4dHwRAnoF32q
 zt4eLBqkRVrD5m/WDMW8J6yV68Up2nTueVsrMjq8WzEAAHtVmliKxkk24aA1xbiGZrLzSIq+oBb
 i0uc2ibwfaO2bRZgzXnL49jV76GfwagjSFiNB6WOZfR6wUmAgEuaKzpVqM3Cu5KqM34Ii0jFTbV
 MXWnVtHn/5KlOf36IRmuTcSVijDhhSYioZ+vG1dzG6VqgE7Jb6vcNAuC19jDn07Szn+9kZAFtVl
 KaOUtj2E6bzQWLTYUdPc2mTLuONytcPfyrPKZZAdaOE1vZA/jwLwGK8UFY1yqla4B6Qw8iVuxg2
 5WKPA8zKWOeiB4SIw8A==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6ace8471 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zzQR_8oM-p7h9UWrr-IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: OL7zRdj_Vz0qNs7W2O-MacWuGEU5G1Nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130077
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

During meson transition, this makefile was left. Its content has been
correctly ported to tests/tcg/riscv64/system/meson.build, but file was
left.

Fixes: 57ad9fe2596 "tests/tcg/riscv64: system tests"
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261010225351.79098-1-pierrick.bouvier@oss.qualcomm.com
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


