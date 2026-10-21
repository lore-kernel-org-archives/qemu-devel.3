Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AC606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LwffojDg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JCaxgGjF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpz-0006m6-AW; Tue, 20 Oct 2026 23:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoZ-0004T6-4Q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMoW-0002t7-Pq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2Uwx13457250
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3G8nt6Kxp+1K+nUkKwFyrDB7DqQ1S0+arugjesbD5Eo=; b=LwffojDgRNAD1Iru
 Tg36DQys9EktgcqQEYQFoyacmC1SH6okYbN1ljUFD0Gjg4P5msqGevcn8MBxjrX/
 2iwdTZEM9Q6J4pYqB//3s/vuZvk+fKKLX4Q2MChXxtnQuHocgPiKaktg8TySEXhF
 JzKkLLPOraUlx1N4Uqu3c1Z3yv/kO48ZZOvnP+spzc72cHBB89edyhEJMeMPjjF+
 160W88rSkHbgPSoOT7aESerOv7FuELqt4egVYLZyrt/KwGyqLDkiP3aD0xlx0uVI
 Fmjupciv62/n/HJiV0NZ4sbPW/Z2IqnNn40Dg3QV1CCvBXOWXG8mf7PD3cTb4U2P
 0HhhzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r0uah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so69202785a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552576; x=1793157376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3G8nt6Kxp+1K+nUkKwFyrDB7DqQ1S0+arugjesbD5Eo=;
 b=JCaxgGjFZYDfDycLYL7ngfAFdwmIh6QxV+Sh7kvNSTQ0ujicg7Kmhfiumkq2AM+xb5
 pr5PtftMrdjIxR9PCjeAKu217+LSupeyw3nLmgfrOOHFkJqqX97dQ9I4U1SM87mjVYxA
 r7G9MxpNzWqMyr46UAVAYC+KP/zSkrPYogsn+7Dd6M1X83uAjrkwyQIM9TqibavaNMOD
 eLhusY46wXGQndNOyjAV7LrATo+wrrGM0NjOZejoeYuKoMd/5P8x58GFW5mAWD2j2eMw
 G/A/4DDfHtv2XjpDUCmD6SrzP4IbtA1XdxZbda9qOKtaCD03krOZ6ZMBQayh8RuyL9Mz
 hsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552576; x=1793157376;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3G8nt6Kxp+1K+nUkKwFyrDB7DqQ1S0+arugjesbD5Eo=;
 b=2DZbv5vm3J+rBKJDe30G2miVXFq53/2DvAcCubQJ0Xuk4qJoze96GUWccHsZR1SQ+i
 z/1alqwJmE73SMEeE261eX7V6K3pT9/kPL2jTC3mZqOuVpTJAyO8EaLXtsWBlzT/D847
 jwKGrQRbWDDJfBFGXEhMZYCGzoOKy0VKgm+LVpscYMq+t2SUXFa9nMkFWOmJRyRKf400
 c/9Q5dVHa/Snn3QSadAOviA3rX0Sh4eQW8CMs6xjABjRgHItRttLC/t/Uj41USdt1d4X
 mhvzODnbg5+vZH8MQMHGvc1UkCsS2iRjYPIz8Nq6nQK17ecIblA6+CZyEiGEz7NnZWS8
 R76Q==
X-Gm-Message-State: AFq9FYK9Pr/vISXr+tFMbbPmULZxYHri5YPbp/0auDr0DwOknXvuhJmp
 aIWfv9IE9qwLv+el76TZ2lH1i5w6JZj0aSX/ZA60d6XXMIG/+tXFqQSr++jVwdEn4i8RSH3rpkE
 AOV64fH3tUcFUOR1Ta/l1VzYw47GOjEHLXDRnIqF07jGxoO+za2DXOWy4zEeIYcm4p6C1
X-Gm-Gg: AYBFou14II4IYdK3GYCEylNX8/TNncoRz7pmOLFVjNxA5ouXftUN+FJFvqrJoujwbqo
 8HYZU9I37CNLDOyU26ZLZsJZrkpwdnY0bTP17splRJP1xlCGfFCA9TN9TDUBRWSV2NNURdqJRoN
 EZaMgjjo73Xu6/ayns20JnvxNvz+52wsJBtqFB/Wtcc9gKeMHCeex9y1tyIMZuopppmdM4ShZVe
 Ji4lNJLe4DPNXq4ErrVumtUI4aL7ZFn875zGswAcshmbRNRQlj60xmMcdBpMczuiUVEHhtRxVPq
 FhrWl5mML+0C+VrPNIg4cMZD1ID/IMwj0/grCZqGBEULwIijJn1NqJHT36PzrJu1NcqhpDenm6X
 fYjifT3NTL69Qp+Tdz0qlugMXZWwtr7KI6rNz2yr5
X-Received: by 2002:a05:620a:4508:b0:93e:920c:c00e with SMTP id
 af79cd13be357-93f57fa0e84mr223641285a.21.1792552576359; 
 Tue, 20 Oct 2026 20:16:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4508:b0:93e:920c:c00e with SMTP id
 af79cd13be357-93f57fa0e84mr223637585a.21.1792552575919; 
 Tue, 20 Oct 2026 20:16:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb698ce0sm45223085e9.2.2026.10.20.20.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:16:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 16/33] target/mips: Remove unuseful EXCP_LAST definition
Date: Wed, 21 Oct 2026 05:13:49 +0200
Message-ID: <20261021031407.24862-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad82e81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6PapexcjMrqzk0dJnxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: uwUdxTcCClwyae4VCtlygrUwyEjPTfO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX3JgR4AA64sYD
 MqAGczcaCAzPxKm0xjNaIbTgPKXVOkrGJ36VwAxM9FfoMBFbJlceZ2So94OKjtcaJBiUryW+QET
 AGMHMMj8rHjrRExQ1H7x+PcXezgsYmNqUMXTVFOSMCW3Ned4WkJaz9bZoT4fJQAjSPKs//Qh1JA
 zp64FJUU1R1X8W2v4luRFCBWPwizm8g5EsT72YuVE396kISoiXyqTv0JHaBpB8KyLmXbKLnMh8j
 D+fPxqYfsocwAugDh4H4BZdnkifw1M1AQhDGpNvrTPK7HmjkPLAKiTTq4+j8a255omditc3VVTb
 CSnaaXWPwHe8wRhPK2bMQAaVfs6xuPJxOjHKcoOUF3Pt67xcQjUI/PFOVZiRKpT2H2UMcgK1oZJ
 ClKtW3IrX+Xl8SSGwiqMgLFF5rkM1/b481QpOUiFBSbOrkDuwFgR8uLLI2B6pqFKjeeT8/98xpE
 a1Yuf9OrM54z6cu5FXg==
X-Proofpoint-GUID: uwUdxTcCClwyae4VCtlygrUwyEjPTfO5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwqJKFSt4B8ZA
 Br6FzIG3GReUNn8S2YES6Pf7ECPwotHweUnyUQKdeUzNbnCecW3/UQQ0l3QoK2HsxTjU4k1OYXJ
 YF4IpbWRw089u5+bENhNj3AIqlEuObE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check array boundary with ARRAY_SIZE() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/cpu.h           | 2 --
 target/mips/tcg/exception.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..5d8b78a70b8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1347,8 +1347,6 @@ enum {
     EXCP_TLBXI,
     EXCP_TLBRI,
     EXCP_SEMIHOST,
-
-    EXCP_LAST = EXCP_SEMIHOST,
 };
 
 /*
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..2f02f9be877 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -88,7 +88,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
 }
 
-static const char * const excp_names[EXCP_LAST + 1] = {
+static const char * const excp_names[] = {
     [EXCP_RESET] = "reset",
     [EXCP_SRESET] = "soft reset",
     [EXCP_DSS] = "debug single step",
@@ -131,7 +131,7 @@ static const char * const excp_names[EXCP_LAST + 1] = {
 
 const char *mips_exception_name(int32_t exception)
 {
-    if (exception < 0 || exception > EXCP_LAST) {
+    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
         return "unknown";
     }
     return excp_names[exception];
-- 
2.55.0


