Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA141C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKS-0003Pn-F1; Thu, 16 Jul 2026 08:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKQ-0003Ni-PA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKP-00079f-7J
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBioVF2355507
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=okbMDKMeqAP
 EFxDbR29tMvQwjGlM6BhP1NQoNvRrf8M=; b=iGU+LY2SyjOaa4wUCiiNrVsgr7J
 dErb6HkIo0JRfIb6uBQNIjN6xz46Tq6XNAOkTUF5AU4C3BJVQARAPplOiFBX0mEd
 vyNVNggmvesqB8WQXaHbaYZ+g7evw9HZ2YrWN0dRK/Y5A5U8zleJobRdF/nKneoh
 NpulgBG129bnS58zF7Dd8rdLIw03Vq0P4GYEsdLagviDi/DSxvaKm6AgLaL548t8
 dzpSUjvWaUvW2Uw02CQ1DwWgkDK14cpQNE0CmDTF8DB2ZSozFmQWKiPCDTnHw8/9
 4RObPlSsyGj8r7fa85QNJaUtCY1mM/LFfQ7o8W61D38RmXgIXb8vHzdf1qg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed064c8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso57429376d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205385; x=1784810185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=okbMDKMeqAPEFxDbR29tMvQwjGlM6BhP1NQoNvRrf8M=;
 b=agR0hNp2iFVZYkO+i8Mxn0/pcUaVHvyYazhHyxAMnbJv9Mat2J6qmP59FD6GWNJH6p
 y9f/u+p6zKvnNlEizAZAr8O7KHu4khoO14QOYv3aT59unog8GNQDDP0ijltZ6PMuVcPf
 4Dq+j8HPkQt3PS+ArtKjELTtTJjBm6wjvQMKktrv/ZIhuSxWdvF83GRE4EBkleX288a7
 zmTj954cp2pHX2SX7qJyIM55ne7XqSQy1VAMLgoX7HUqPRhUIvzS4sfYOPy/q6UkKlT7
 Y2CNZQaMBgOKWYQHAAhrhkoDGl49q4qExIDRglHVfHDuLiAi/HQuv1uspcNyT+//gxUs
 BNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205385; x=1784810185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=okbMDKMeqAPEFxDbR29tMvQwjGlM6BhP1NQoNvRrf8M=;
 b=T/MTDzBfIsYL5Iap8dL1xd7pafeZCPm5kblOE0oRHIj7fc/E0zwGXdrwAWsB+429c5
 99QPSFIX0JfwEDiASw9kHT5bqH/d2yC4deqKsaX5VxiWtD33AH2BggMn/eMIMatuONJa
 8GhjR9Ghyi8/w8i60KYr8wnfSoh8l6n0HZHIFTJz+2mA2/366+u1IMNVRx7dd0fhFDbo
 wKHQFhwNurgDfTAnv9DTlDdkQ/Lk2yGk+5THL5q+X4FFZyDSWR5jfFhYfqG9en5KU5XQ
 2ZzVfnfkJ+p35d4pId58qCSlpTARTj9/4ZdLf0ENdEj1GpVgWfEe0qtJzYcCPaPPZZiF
 ROZg==
X-Gm-Message-State: AOJu0Yx47N2wJF1gplZ6PkV/9qHnRZrJlLDXdTXyC0tgDarAMAoZrE4a
 rToP/7M6dDYoTitErRUW1VtG17/vVMUpx3gTfleSZ/uWsgsHQdBY4jeu86KPku+Q3nEe63CQ3A0
 GQrKLDO4iD+SJgPcDNyrSsyfi0UeFHKnxYLiiGQi7l30VojGm+5Wcy2BqrDscri9ciQ==
X-Gm-Gg: AfdE7cm7KwwR7OG4js7BaI0e76iAsI3zld7IH9+zOJgf+bJBwmxOJFYUW0eoqapBDin
 7sW0zBukYk7tmNYDjyKDWh2nuNdHTXeMq2XaoyFcjEo3GRkHHEaDTz+9C5yohTFK6WUdgoSzdr3
 oGBbAlRhLIVRN8LlZT0bi28AtYaMjSjCgjFJTR0CqfEGegPHeH9Y2Uz29jlIBfsXOWgRZd6Y5Cy
 /16dP520UOrOqqXq40fdJ/dhxdbEIRmyxZShOcslvjcON1NfbTa2Yjh5rb1nwwdZhIcLvF6BGq5
 omX60LYRPikJJ0KBh9BK3HAsjjmimHCU6iSrQzYT0WIGuNhBE/K86K5PQlwwbbsB3UstYkXp5oN
 OMz52JthCM8W6cLbw+VCmt2RZ19ehauPP2Pw=
X-Received: by 2002:a05:6214:4005:b0:8f0:b50f:dcf with SMTP id
 6a1803df08f44-90400b8b7cfmr257176226d6.7.1784205384694; 
 Thu, 16 Jul 2026 05:36:24 -0700 (PDT)
X-Received: by 2002:a05:6214:4005:b0:8f0:b50f:dcf with SMTP id
 6a1803df08f44-90400b8b7cfmr257175666d6.7.1784205384189; 
 Thu, 16 Jul 2026 05:36:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:23 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 16/17] target/riscv/debug: Reset trigger type to
 unavailable
Date: Thu, 16 Jul 2026 09:35:33 -0300
Message-ID: <20260716123535.3709148-17-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXymqIaJBvPmdn
 5EzlpM8fQf3oTIOib50XpLnaEJ60xGqD0RLzQpXBewtoREkbEzRJy5h2GRSAXO0EpVy6roFH7XA
 rQtYKiz4Jp6G+8Cvd75aPR7vdjKQoCk=
X-Proofpoint-GUID: XOEI2Ce3aw-aRNNtBIUEVNTUWLt9hpQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXxUEOYXRKSYXq
 y6WLF9K5e8xxotpFgoJGIyHFZqv4HtzfGp8gAO1g8x8DcVuFRxY+FR32G2BtrZ4R4TNzfl/deLG
 8s5vjFGU5+ZGzoCYJoKC8JMkd4vrkpGtPPXw0ARxX9D2eNWy0IQxsjC5M2/b23+H3lw9aG5W+nA
 kfrk54VYUsvnGz/1No84RCzBZWiXGGsFrQBm+zsnM+le0HaxCGPx4H5uAj/ClAuYUDKIXmU0A4t
 XKQX7XjlJzO6OtFrpif09afkL++TeJJDM78PTJ1i4mV4N4F8n93YCWm7SlmpjfE4CZqkeK9DE37
 BPzJ3SXxvqHK5zRpUnpDUX4U7xnHv2yRDjnmnI+Lkxnsd2VV01ZuW9j6+pZoaBkGz4pK71YCQCU
 UJcRGTifpvw+1sYTkLW1LF7XowbWawkVV7h5lRRxaT4WoGsjSEMtLDFFroZDpghnynS7u4PJF/R
 4kDjMGBf4j/uxHFiz0A==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a58d049 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=YoUxN3H5ZC8bLvEMz08A:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: XOEI2Ce3aw-aRNNtBIUEVNTUWLt9hpQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Reset triggers to type 15 (unavailable). The reset value for tdata1 type
field is implementation specific, legal values are permitted.
Unavailable is a legal value, and some implementations may not support
type2 triggers so use that instead.

Fixes: b6092544fc ("target/riscv: csr: Hook debug CSR read/write")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 9089d2ab78..50e5a85caf 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1183,10 +1183,10 @@ void riscv_cpu_debug_post_load(CPURISCVState *env)
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
-    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
+    target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
     int i;
 
-    /* init to type 2 triggers */
+    /* Init to type 15 (unavailable) triggers */
     for (i = 0; i < env->num_triggers; i++) {
         int trigger_type = get_trigger_type(env, i);
 
@@ -1201,19 +1201,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
             break;
         }
 
-        /*
-         * type = TRIGGER_TYPE_AD_MATCH
-         * dmode = 0 (both debug and M-mode can write tdata)
-         * maskmax = 0 (unimplemented, always 0)
-         * sizehi = 0 (match against any size, RV64 only)
-         * hit = 0 (unimplemented, always 0)
-         * select = 0 (always 0, perform match on address)
-         * timing = 0 (always 0, trigger before instruction)
-         * sizelo = 0 (match against any size)
-         * action = 0 (always 0, raise a breakpoint exception)
-         * chain = 0 (unimplemented, always 0)
-         * match = 0 (always 0, when any compare value equals tdata2)
-         */
         env->tdata1[i] = tdata1;
         env->tdata2[i] = 0;
         env->tdata3[i] = 0;
-- 
2.43.0


