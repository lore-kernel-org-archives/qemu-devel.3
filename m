Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AA606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IRfELSqC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cRu/dgyx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHts-0003oJ-DF; Fri, 23 Oct 2026 12:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHtq-0003nq-Lw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHtp-00024G-3N
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:46 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6Cqf2215811
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BtNk5J68yc+OQqfv2wRsl+/eO1+Dbsy+IlAZdqdOsuM=; b=IRfELSqCS5tKFEIo
 n13vs60Us4rQSK+EQhn0yCBOUtEZ/pSNzY/ACoSksSN9u6xtmjsw3hsmc7donQ0j
 gJNXhCnZQkZ43pvsYp6Kd3oahcp2PoVC1YLYV4rFVtXrmbgSg5+ci9rZcfHs/dRU
 ZjOajwJ9XrNQYg7w+pDcbzTpfH81z/V/iK527MJEfZzSUfw99cEXeAuoJa9FWVpC
 6I+QjoygRp5VvsKBRK+EsatOl+16lD5JDzq6Xf/1lE/hS99RiJGHAo3E2OtT1JAh
 K1qpBO6jW+nSv6Dpq4RWiccf1gJDX/imK/hQB+3K1Ou9WXbScwmIqvSSCf0CkydV
 p2z7BA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc810e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so112803585a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772023; x=1793376823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BtNk5J68yc+OQqfv2wRsl+/eO1+Dbsy+IlAZdqdOsuM=;
 b=cRu/dgyxRITLz1soLA/uaB5IliKJYWD41XzQkECeYF2j/0bRJEUsCwVKUeps/oSp+W
 cOULJP5cGVFP6KLvs29xn4y5hxXuFj3e0OnbYO86rUUeSdYn82UAgCLpAwO0lHNNqo06
 HsDEYs8vLa+KiWNYUvr9MTEtNdJIlJuI02ChTTZPnQIdRXbCOVsw6CxDt05X5gznbG9H
 410jlVBNSe1IvyfNIKiD9VR9zJ40CYCw1UgwU5rxP22zYXKbYHms+iF8dpr0lXcVsZq+
 6XosSwZoi8e3eoIt8P3OM6DqDH22r1Vsu1B+c1HK7ABoTRuq3Li2lFAwty+yfgemvaSr
 yf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772023; x=1793376823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BtNk5J68yc+OQqfv2wRsl+/eO1+Dbsy+IlAZdqdOsuM=;
 b=B2kP4ByzeuCBApdP1RWtFGjlyR9zE2613wrvLTCYm6IKujiFK75GEHSvQgD6Qa9kIF
 jN1EWHvN73GXm76BmsA0kPOr/IGWeSjeJCVPz7vPMwa4yGKW2lu8ukpQB6XNx9IIsLe+
 EB7fvA23f8caaqa+oWTSFMgYqSUgOkhWlHrc5hLVc3LXp8Ix6AhpFXDruClqLaV9v1wK
 jhidDSVEizzH5A8ADh7b1/9oy1dZUrDw8uZ/KBJGppwEvO5Gq3F4IfUYk3mTUP/oZzgT
 dgMenSxG154Qh72ASqD/NZ9O60M+KbZPUyUFgpPvK10ZcWARlt3IS1A+Hl6ty/pz0YQt
 ilAQ==
X-Gm-Message-State: AFq9FYLkNHjg1RsFhftmexvUQ8GgQw+PXio25smMoRyTYYvWFZq4gmPH
 3HD2SXUPERfaaqefqH5aXybfAPGEruXBMhiKBSeGVEzmpl2otc1HYOXm0r1JaKRuQKN7qwYKAwg
 wL9sCgr4ZxUtLfBygA4qnlZG/0PCnnTBgTS7CAgCkL3b4loOmMxLIAQ7FSKRq4oAXQhrG
X-Gm-Gg: AYBFou2nDou1zLbEZ1aks6z3XcZjKk1ukj0NLtgs754LAt0xJKVDd/LPwgRWV7q1BpP
 oy9M9PnnM4viyXks6nHXw7X9YlUabS/AR+iEoWjCtLa54kTuuVjcuudcuyy3wQ+YQeElgSqMDCs
 yKOJHwGuu0CXyrBTAWDBJrOS6ogb2RB6TAgZ80Jq/0juOcvhK9Gngal33zdeJ28r1pty36jTfcz
 CGioIsnoW9nxfok2j2Aag8Ccp1XqIbAtmuwNMIYIShMHUvtayHdcVE/YknSS338g9yIAY14rzjH
 Z9wy3ccP4SmXq8/0YXUvBHSvcpt8mNe8H/87++ILCIGeEASKaVpB/V9fMJXTsEzlljy2pidFtwi
 0g+3tGLewbIbVdMGA2CZ6mCGQ34x7Cdbvr6mBVb/m
X-Received: by 2002:a05:620a:2795:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-93f6fa1fb08mr447258385a.82.1792772022714; 
 Fri, 23 Oct 2026 09:13:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2795:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-93f6fa1fb08mr447255085a.82.1792772022066; 
 Fri, 23 Oct 2026 09:13:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a30764e9e7sm12438955e9.2.2026.10.23.09.13.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:13:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/83] accel/tcg: Refactor poll-while-halted flow in cpu_exec()
Date: Fri, 23 Oct 2026 18:12:09 +0200
Message-ID: <20261023161332.60153-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/Mwo2BD4L9q0
 YL6LRuVfuwWZ3TPzSyFIe7xK08ze2XJ7ai6412vTSeYfpDBFfK5B7UG5GZoPeMpIiZpuVm+qTmC
 57QOrJYZJKnfBWh45CowytCbvxWcYSq9rcmVT3Hzfu2yqc96KUumYjARrK51jxb3dvE0kyAuY26
 y2FYEkhvpAyUuVkP0WKaTWPoGGy5fXyrhqeCokkMK/VvC+6AR2tprbxzkBTxkEluqU4dxZHxgpq
 LIN3VNNbhv+fmra3nLvAgJxk0fO+BnOlE8e0K1jdcZXeYq0cqMGMd+dKSoJWFhb3EH7uVAyKVzn
 cGPs/u2t0o1mrWrI5kOQyfds5LFXNOTjp4PDsIsrlpkXtNjZYzXT9zKyJVxKuQQssLu0gsGwOAB
 KDGIF+cycRv2xZ2zoVKnBuqrxd1TYh1AViELv518q5CInu0Orz6abh98sSjBjq+uKoo5kktu0gC
 uCs0jOOQbCXNkZ0r51Q==
X-Proofpoint-GUID: qkd0Tav5K5QDp9LxB1XeXl5o14mCl-ge
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb87b7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xF3Xt6V14tk6trZ56bgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qkd0Tav5K5QDp9LxB1XeXl5o14mCl-ge
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX9wr02+xHmdJp
 j4mqFrSzWZ73m9rob5hAZ6V6WSYGCMbiHkb2DFnBmGbAloWtCm3RS2kL6EhryOCbTJGw+SWEDXc
 /5bjn6IlHHAkZXZC65zWsR82FlY9sYI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Invert cpu_handle_halt()'s logic to read in cpu_exec()
as "if halted, poll for async events and find work; if
no work, return". Rename as cpu_poll_while_halted().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-2-philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5b4bca5084f..853c4b2f67a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -656,18 +656,18 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline bool cpu_handle_halt(CPUState *cpu)
+static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
     if (!leave_halt) {
-        return true;
+        return false;
     }
 
     cpu->halted = 0; /* allow execution */
 
-    return false;
+    return true;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -1029,7 +1029,7 @@ int cpu_exec(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
-        if (cpu_handle_halt(cpu)) {
+        if (!cpu_poll_while_halted(cpu)) {
             return EXCP_HALTED;
         }
         assert(!cpu->halted);
-- 
2.55.0


