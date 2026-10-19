Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44308606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0mP0tLO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Esk3PqJf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunC-0001ce-Iw; Mon, 19 Oct 2026 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun7-0001aa-DX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun4-0005fk-IK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK6xY4106610
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F9n6VDdqaV1
 jQvRabIb+g3lpRWCe13ptMle2nBD2R8g=; b=B0mP0tLOqKI3f/60Dmf4+kGJYbN
 MCVQHc2//yZu2GtW6GG6riAYyNO2rUf1cNwqE02Y58lVQBuOZNQ4x9FWLi37VliS
 clUS+WDjBwmhqT7KDsMlcfQ+Gc8DY6oFEsZD9Folj7+XWHCCVgfOASmN91gvAHX6
 kftCBC3Fq+n+Pxro/QrXO8D564fvFgVeOKteWnV+RbxCqc3KVPwcyjJXRRkJuY3f
 TlygXR9nMOxf54ErTb4jkeFkBj+EgaIOXr8uUwpCFpCDJinX7O2RwLO2EuhauHq7
 PQMbGeTkDNeu36Ci+eYdy4wjoNgD6PrrlQQVeIGeQD7Dr2D44yrIQI0lxfg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780ntd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd65285537aso1098489a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444864; x=1793049664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F9n6VDdqaV1jQvRabIb+g3lpRWCe13ptMle2nBD2R8g=;
 b=Esk3PqJfWc89/gKOuiKFYKmOvMV5sSpaGHaaOFaqauBW7tnnHZE6hxcCMacXn4Ox1i
 pqcA7CBJc9R2VOjAyne+tApFmQUNz+8khT9NGn0ROoeVg511g1kMQPpqGzm5c+9mgA1Y
 EWW8iQofQt8H210W7QkrSZ8Z1jMNFEOI8f1lRGQVNXz8+sTAZmfmqyPFd0ZWrfsweYPV
 CumUlmkqQWXjCI+qlbsUxF9Wbvl+gtRxXOvI4nXYzJkKarZo2HqBXeOlAh2LPPbXoNzd
 JbhYegJe755WPF0DWZFj7f1rpu6H50hpmuiBuKxiNkuQvfBw8jGXXyXg+hJFE3PwF2jr
 zXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444864; x=1793049664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F9n6VDdqaV1jQvRabIb+g3lpRWCe13ptMle2nBD2R8g=;
 b=b/6W/N9IKvcoHzTP8PIJcLPJ5vTpd3oIIhABj8YYJU41ci+cvt7tTs3eQP5jUNe4Av
 lR/3zR2sznjJwKrtayf0nQShWITaKaKe+XjkDeqFRuS5snb+rSyDMWUK34F7KQpbWN6M
 ajNUDv5R2P/u1oykwE0TPpo1GgbtZCtB1KBASsPvqZBh3IvNKv5urNruPbDqaPJhzrG/
 JIVe5/krhvxhjMbP7wtmBhLQY4A5FHMS4uDRBDq7f/1d0HQ65oy1diR/MC8Iw3Rpnsyy
 m6cx4ZGzOLe8mOugAmeH7n6TZAo3g/t6F5UJydbpWvJoz2HDrSppzsKEbJIaG2/NtStr
 jAEA==
X-Gm-Message-State: AFq9FYKKqzPCH6WEPBsXOA6oPFksg531K92sMxuDaePeDBMov6OVc1oC
 ULMc+NbEAG4Mw+z+5pEPM4nmnvn+o4XBp7z12SO8hAymS0sOYiN1KHNunp3IDoAiQIoULypPVGA
 JJcSHEObMfjegSB3ubVAapkJbcO5GI94E7oahcHZ2oXRuomD8hcYZzc7oXad/i5BPbQ==
X-Gm-Gg: AYBFou2uHhYQ14mEitkaqveA1B6IfP2hRviE8yR+W/qs8eOLa2/ow0nEXcZ5DJlxT9u
 DdUg8a31DgkF/aZBBOuqgrEhegUV8WgtoB9/bDO1luR7X0dMBINPDhdsUOoGvcdRAFIZYuCgin0
 rfIwrOHb/oxRBp/kOzzUV9v+mKacH8X4+2xbayWpgruwNBECN0DZ8evshJxNhK5akpXTwv6967i
 hvG0/EfbXo0N1AKn/17LJo+rcbDB9HAjPLK5tOAFXVu3JT7pTukUtznimc+lmSY9/BFyH7675pk
 N4mrR4IEAa2uBRUpk98Edz0RVwcIWfXiPt99IUzKFDXVYscs+uZT+xwuoHLTwQTbmUVLTauIScC
 shmOBuvH5bZ53J1YJ1Vw24T0tIa8IzR/QiXzksxdtrFLbPYQf7g/7bvcCPKIFnKY=
X-Received: by 2002:a17:90b:582f:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3acef5f1d45mr7936303a91.55.1792444864263; 
 Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
X-Received: by 2002:a17:90b:582f:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3acef5f1d45mr7936287a91.55.1792444863765; 
 Mon, 19 Oct 2026 14:21:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/26] target/avr: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:22 +0000
Message-ID: <20261019212046.149572-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+E5+Sle9TanX
 dcNqiZQ2WuE/4Zrw4cYxOuzvXHB11JgUducUZwpQ2xLmh3kiWnLLiC0EgslcV/Bve9UHJCMaEYu
 uBHYaltlnah97/8CbugEBHoJ/55Novrc2F6gW2rJD6ZlFr9oDJt32XHrVrzDVM7cWIzIBRuMLv1
 tlJ73ow8+pQXc5FJ8EpgqXlH48ncxjJ26eB4OaaAa7BjP6MakOofe93cgoqi0hIdpqL51G6tqG3
 eeQtsXDAOHiQ6P9gRKW73kqW3ukjvNVDIteYD2ONQiUm3xSxz8c5o1APC3oL4A3PKkSwauKrWqp
 igqzZ7ciSi0iIJlyaTILlyEWbqXmxpx8XXb/cjb6rPQX40HgtRuQr4j0sh+7aVckONaXNc7+4po
 L0tet0e1DOjLnmr1NERU36mIV1YAYaSOtvOi/SDfb7ULy9hTvfYulDRQD6jU50XxQvd0iB7yWFS
 dDjcX5S6oymG06eVWNw==
X-Proofpoint-GUID: saWPUW3wolJevd33kwNbxNuOPLy095dq
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad689c1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Wv-XcSyDAywttTPMHZIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+TUjGPKoxoRK
 COZydq4bLHm0pbaYYGuKa18y5FHK5qPUVZmJR3Pjpc2P79ncS5TAuhx43fO7h7VObwIQggVtaoi
 JH0vVkZjkAINpD6j2px50/2WSMLzkY0=
X-Proofpoint-ORIG-GUID: saWPUW3wolJevd33kwNbxNuOPLy095dq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/avr/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..bd197638f19 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -152,7 +152,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
  *  helpers
  */
 
-void helper_sleep(CPUAVRState *env)
+void HELPER(sleep)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -160,7 +160,7 @@ void helper_sleep(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_unsupported(CPUAVRState *env)
+void HELPER(unsupported)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -176,7 +176,7 @@ void helper_unsupported(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUAVRState *env)
+void HELPER(debug)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -184,7 +184,7 @@ void helper_debug(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_break(CPUAVRState *env)
+void HELPER(break)(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -192,7 +192,7 @@ void helper_break(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_wdr(CPUAVRState *env)
+void HELPER(wdr)(CPUAVRState *env)
 {
     qemu_log_mask(LOG_UNIMP, "WDG reset (not implemented)\n");
 }
@@ -274,7 +274,7 @@ const MemoryRegionOps avr_cpu_reg2 = {
  *  this function implements ST instruction when there is a possibility to write
  *  into a CPU register
  */
-void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+void HELPER(fullwr)(CPUAVRState *env, uint32_t data, uint32_t addr)
 {
     env->fullacc = false;
 
-- 
2.43.0


