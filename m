Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6400CDB47F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyut-0007M9-Eh; Tue, 23 Jun 2026 07:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbyu1-0006oc-WA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbytv-00069x-US
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:02:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NAsd0L3664083
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iH/zQRgQ5VQcthLR36rPR/2Y88jfz5AKDFzZwmWwNX8=; b=NNRV13Co8rs7WB+A
 P0VIg0/YEzbgNdedvJ0AceTIiOfGBIpZYzO8P0TKXU8O+yVDuCnlTjwZTYNA8Ahe
 XHPUSXxkN2bTCubO+iNFpa5OOFLMWS1UtL5wQrBWzIr5XHmar/Y2IuCF/cDNgLDL
 mKu6QqBTclRKNOuqYVBVJaFNlom++NC/QprviR6ZBJknixNVUDJ9zoGRDDEXhak6
 mc0oIgGJvO+xRgXrjaUf97JVADrVXA2KEADQK536fGyHNC5QEkM9aGzEw5WZqys9
 YK8l2TJpQBZmovA+3eWdjWgEJ/Fj2XvjWybz8jzbMUPV0ESDRVdXQhuLe79XujEE
 wvI1JQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gt71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:02:41 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e93b1cc222so7272343a34.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782212561; x=1782817361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH/zQRgQ5VQcthLR36rPR/2Y88jfz5AKDFzZwmWwNX8=;
 b=RxP2o0AYxltwaC8WafBGoogsnaSkWnRbnICuB5FgnJ3zF1F+jhxfwYWPda1Er05e17
 GwJJKsCf278M4I1d+1AnR9DmtYJ+GyocC+5dQJq3R07dY4qhg+XY2HwluPpMvBVhS60c
 rJwfWY+dlJSdj7TsFxmErJiMWUq90H5QaTcq4uiIB2MXkO2v2JSYph10Dgw1BxQ21zQx
 G8Mgp2E9dEgdqat1jadnvQV8eBwukgxA2WYXuRX2vZ27PDWdyInbIUz/JL9sx0aLf1co
 S4vLELr/+Ptid/49yhaGA8mcXipBo8dOS6dWc6UkNunH7p0XIrBZ8LecMA36cOFBifWn
 bbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782212561; x=1782817361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iH/zQRgQ5VQcthLR36rPR/2Y88jfz5AKDFzZwmWwNX8=;
 b=njTu7v7gdJc8vlCrtvQZ5vIctVdYJm1TpSihPvYADn8NM8ZF+h5NJH2kdWeLHSQwob
 MbCSknsqunxKGWlS9s0DO0zyQtUKs4gGKHzZ3Elm+toq6oSdL/yoip3aYQcxy9GAMxPi
 qq5CJKrFKNiyNSCtY9dlTgj4kZRxpHxDBG+RF/yBflK9EFvIGo/6l0evR+ykzbkFugQ1
 /KCh+Kus9UHxluI1IVXmipFMrfoRTmLcSEVEAm5beIDH/ATP5Mm+NLdEI7zCcOle8Io0
 qZXHLkaGsOJLpEFiM8ZMX9Z31tVtb0xyq0Zb8S3MJzI1ABtGd4wu/WJp3lMwFGvN6VQR
 h5Nw==
X-Gm-Message-State: AOJu0YyRvja1PJ31z+nLmGEO6bHSYvrzgBrh+YI7pdFQh9PqrFlR/YOG
 7cLW0R6KhhTeE3PuAl0CP3zATt7BqUOq3Ao50SiHdBRuvHrrGbQqMltFR402aMJgyG3GSsYCApJ
 p6aC1s0Vy1taBoXPfjoBwOo1ixYwiNOvX98Bn8mqt0Oy1YLD949bpQCcAT0o+tpynr781
X-Gm-Gg: AfdE7cmsk/Wzw+hOINnQQQq8EUkc9jqmZLP4Fo3Cok9vPXW2P6ySfS6vsKrJ+Iq1gVG
 X2INyVsvXTb+nq2Pg06I3CXNSlXde3GSo94H5xoT6jCQdPsLXKfUf821fKpABAtSmAFtAYNEyMQ
 lbDWFVLvNQEDfuOzEieMoXS29icvtiaCyJ3TWs6dFK5fqnvvVvrAms34/jMLUaoXs+45HjXOpQs
 woQ8ARfYzpYgUl6DrGO2npsChVVOPXm0FKg+E7pfTGHFm7W5onfBLnd6BO9T7dZFSKB6jMx5fc9
 19QVV6T5j81Hc9kKwwxEASP0WFI75U0r5NhMFDM865y8d29XNdcTtSsyGVeFEmvXCHKFiLrTc/Z
 9SlIVxTnXAsS6bemu047lncNPjr2z6GqWEmesdERYDvGaYYn68fD6PdDS+PAge9Uj7rnn
X-Received: by 2002:a05:6830:6388:b0:7e6:dc7a:f459 with SMTP id
 46e09a7af769-7e92d97798amr14812052a34.11.1782212560739; 
 Tue, 23 Jun 2026 04:02:40 -0700 (PDT)
X-Received: by 2002:a05:6830:6388:b0:7e6:dc7a:f459 with SMTP id
 46e09a7af769-7e92d97798amr14811975a34.11.1782212560233; 
 Tue, 23 Jun 2026 04:02:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4ee6sm33497167f8f.5.2026.06.23.04.02.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jun 2026 04:02:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v2 3/4] target/tcg: Rename raise_exception() helpers
Date: Tue, 23 Jun 2026 13:02:07 +0200
Message-ID: <20260623110209.26861-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623110209.26861-1-philmd@oss.qualcomm.com>
References: <20260623110209.26861-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a67d1 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OkN9J5DZ8G-Ze5HU9b4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GmScvfF11d-Vh756WpNSTirfnhZyUMJH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfX0mbDr/ziGR6w
 MPJ2nDM61S/JACpQWRzG/MsrFR/SFP8JO0dQ/cRUMcqodTZ06LVdy4Ei2oFTHb8mjQTeVtfhiqk
 dJwP1Du0xGggmqnMoqNZCJnEVb1pCl0=
X-Proofpoint-ORIG-GUID: GmScvfF11d-Vh756WpNSTirfnhZyUMJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OSBTYWx0ZWRfX/Nsd7o7os70q
 hlAhZFuiC1W5FwtVxeBKsVX+iN2kAG86ScyivdGdRwN8de7qxEendifFocPa9cJJ6kyUcVSLk9H
 GGHCLMLbGBep9Sc78rGd5Ynn3ZBhvdUxwPkxEDa6QK72kJVcvKedUv6M4VuObzwib5FC2IH16vw
 +Nx8f6OycMrKfK2ubQQYeVQxikRPmZFMtKXf3ZCQEQiM/YU0Y/TMig5SxqGVMTncKhT3Gfp0pmW
 QMWRAsT+bkC2YfN5LYMgGZ6AtaXQKxcXZheDRskiA/m/Nf9RVCqX3KGM0iWAuesn7CuRJUaC9SF
 e0euVFWMpGjFeQKOG5dIPraEfWMMtJYldnuFNQZtACrbM7U7gy1jhQ4VmxIHdkfyDaCzhJMcrRX
 Uw14QjC3phSLzU+izQcc3xUk7sgrmA8mHik8JUPYh58i1H4yIFa/6a3xRqgWp++FLjnxqqKtgCR
 5GqS8PJriGr5Ldonqtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h      | 2 +-
 target/hexagon/helper.h       | 2 +-
 target/i386/helper.h          | 2 +-
 target/m68k/helper.h          | 2 +-
 target/microblaze/helper.h    | 2 +-
 target/ppc/helper.h           | 2 +-
 target/sparc/helper.h         | 2 +-
 target/hexagon/op_helper.c    | 2 +-
 target/hexagon/translate.c    | 2 +-
 target/i386/tcg/excp_helper.c | 2 +-
 target/i386/tcg/translate.c   | 2 +-
 target/m68k/op_helper.c       | 2 +-
 target/m68k/translate.c       | 2 +-
 target/microblaze/op_helper.c | 2 +-
 target/microblaze/translate.c | 2 +-
 target/ppc/tcg-excp_helper.c  | 2 +-
 target/ppc/translate.c        | 6 +++---
 target/sparc/helper.c         | 2 +-
 target/sparc/translate.c      | 6 +++---
 19 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 0159e5c2d5f..e9d3aece85d 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1345,7 +1345,7 @@
         uiV = uiV; \
         tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt.pc); \
         TCGv excp = tcg_constant_tl(HEX_EVENT_TRAP0); \
-        gen_helper_raise_exception(tcg_env, excp); \
+        gen_helper_hexagon_raise_exception(tcg_env, excp); \
     } while (0)
 #endif
 
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 64456822bc1..021f9364ad8 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3f67098f11f..8099c40cc90 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -56,7 +56,7 @@ DEF_HELPER_2(syscall, void, env, int)
 DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_2(x86_raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 0bda8f8152d..a76d455cde1 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -111,7 +111,7 @@ DEF_HELPER_3(set_mac_extu, void, env, i32, i32)
 DEF_HELPER_2(flush_flags, void, env, i32)
 DEF_HELPER_2(set_ccr, void, env, i32)
 DEF_HELPER_FLAGS_1(get_ccr, TCG_CALL_NO_WG_SE, i32, env)
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
+DEF_HELPER_2(m68k_raise_exception, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(bfffo_reg, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..e589a8422f0 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e99c8c824b4..3548af5f1c0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,5 +1,5 @@
 DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, noreturn, env, i32, i32)
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(ppc_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(TW, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_4(TD, TCG_CALL_NO_WG, void, env, tl, tl, i32)
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 3a7f7dc1296..6de773445fe 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -53,7 +53,7 @@ DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, i32, env, i128, i128)
 DEF_HELPER_FLAGS_3(flcmps, TCG_CALL_NO_RWG_SE, i32, env, f32, f32)
 DEF_HELPER_FLAGS_3(flcmpd, TCG_CALL_NO_RWG_SE, i32, env, f64, f64)
-DEF_HELPER_2(raise_exception, noreturn, env, int)
+DEF_HELPER_2(sparc_raise_exception, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0a946433644..12656259cc4 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -47,7 +47,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp)
 {
     hexagon_raise_exception_err(env, excp, 0);
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 0b9337d9120..5f584accb05 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -119,7 +119,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 
 static void gen_exception_raw(int excp)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_exec_counters(DisasContext *ctx)
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 1eaa602c91d..a603770084a 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -32,7 +32,7 @@ G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
     raise_interrupt(env, intno, next_eip_addend);
 }
 
-G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
+G_NORETURN void helper_x86_raise_exception(CPUX86State *env, int exception_index)
 {
     raise_exception(env, exception_index);
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2115c5cd24b..e15a284ab60 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1515,7 +1515,7 @@ static void gen_exception(DisasContext *s, int trapno)
 {
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(trapno));
+    gen_helper_x86_raise_exception(tcg_env, tcg_constant_i32(trapno));
     s->base.is_jmp = DISAS_NORETURN;
 }
 
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a689814..7e36aed0cb6 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -553,7 +553,7 @@ G_NORETURN static void raise_exception(CPUM68KState *env, int tt)
     raise_exception_ra(env, tt, 0);
 }
 
-void HELPER(raise_exception)(CPUM68KState *env, uint32_t tt)
+void HELPER(m68k_raise_exception)(CPUM68KState *env, uint32_t tt)
 {
     raise_exception(env, tt);
 }
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 138c89d3e53..67946c2c20b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -252,7 +252,7 @@ static void gen_jmp(DisasContext *s, TCGv dest)
 
 static void gen_raise_exception(int nr)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(nr));
+    gen_helper_m68k_raise_exception(tcg_env, tcg_constant_i32(nr));
 }
 
 static void gen_raise_exception_format2(DisasContext *s, int nr,
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..488f95de468 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
+void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a93f14d6e09..d767217a869 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index b04f07a6377..d71132f0a1f 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -50,7 +50,7 @@ void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
     raise_exception_err_ra(env, exception, error_code, 0);
 }
 
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
+void helper_ppc_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3f6d326cef3..d302112840d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -334,7 +334,7 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
 
     gen_update_nip(ctx, nip);
     t0 = tcg_constant_i32(excp);
-    gen_helper_raise_exception(tcg_env, t0);
+    gen_helper_ppc_raise_exception(tcg_env, t0);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -377,8 +377,8 @@ static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
         gen_load_spr(t0, SPR_BOOKE_DBSR);
         tcg_gen_ori_tl(t0, t0, dbsr);
         gen_store_spr(SPR_BOOKE_DBSR, t0);
-        gen_helper_raise_exception(tcg_env,
-                                   tcg_constant_i32(POWERPC_EXCP_DEBUG));
+        gen_helper_ppc_raise_exception(tcg_env,
+                                       tcg_constant_i32(POWERPC_EXCP_DEBUG));
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         if (!rfi_type) { /* BookS does not single step rfi type instructions */
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 8de261b0e30..8667f97a63d 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -33,7 +33,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void helper_raise_exception(CPUSPARCState *env, int tt)
+void helper_sparc_raise_exception(CPUSPARCState *env, int tt)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3156be6a94c..b47c79e8894 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1048,7 +1048,7 @@ static void gen_exception(DisasContext *dc, int which)
 {
     finishing_insn(dc);
     save_state(dc);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(which));
+    gen_helper_sparc_raise_exception(tcg_env, tcg_constant_i32(which));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -2811,7 +2811,7 @@ static bool do_tcc(DisasContext *dc, int cond, int cc,
     /* Trap always.  */
     if (cond == 8) {
         save_state(dc);
-        gen_helper_raise_exception(tcg_env, trap);
+        gen_helper_sparc_raise_exception(tcg_env, trap);
         dc->base.is_jmp = DISAS_NORETURN;
         return true;
     }
@@ -5833,7 +5833,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (e->npc % 4 == 0) {
             tcg_gen_movi_tl(cpu_npc, e->npc);
         }
-        gen_helper_raise_exception(tcg_env, e->excp);
+        gen_helper_sparc_raise_exception(tcg_env, e->excp);
 
         e_next = e->next;
         g_free(e);
-- 
2.53.0


