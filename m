Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA828606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WKcOdlBq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QDbI81Pt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunJ-0001f2-F6; Mon, 19 Oct 2026 17:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunH-0001eX-Om
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunF-0005hX-RU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKCT82782166
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zcPy8nPCHNS
 OuIFPUTrCFZo64VLr9orahzz1ImMqeiE=; b=WKcOdlBq0EAYE5T3uOt09kg95ay
 f5dfmr0fA1ZyUMezRUuPZZPqKa8pdd8Ygexd3r0TD0gajGHKHaq5ZJPhkRPS6oQH
 Q3eq35vxTUW1eUGRxby73SC+uTuVZH4Y3vRyVFnTDchZrOjhvQnrbRr1rWukvxXJ
 FayLxP74pwExZbmrp9zlQuAwlK3ozHxCFOdUPfJ4i0Kum1mc/R1r4GKK/x9Xn+Ww
 lWYOTZeNkV4bP87ExbQQaxXIgrgr10COkCLM0RylOwCSfLYJMePKHXqm3mpp6VCt
 uT++MRzPNoAH+9UXsmt6dAQC3VqN7j3X2w3krMWA6ef8/pD3Bq7ji2Ii0lA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0qrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so1976514a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444876; x=1793049676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcPy8nPCHNSOuIFPUTrCFZo64VLr9orahzz1ImMqeiE=;
 b=QDbI81PttBk/2XW3HscMpE5R6vvQuysGEdY4p2HPKuWcoYF98oLWtFpWvChjkZkoiy
 gEV5LAXZ+kRqHvY5wx2dwyzO4wnAypTYQ0jhIpSrRcDUJRvoaeHhl7Jkr9qV9VImdSFf
 4TbQrbTf6ItyLNidOvFwgXPKsUOsMYLIUP0g7exMfZlmEKfRJiXAEA7TRzyYDyAgWZ0H
 q98j6AXu096f6ex2MuSjBH2EIqz1/CrtFXit77Oj/q4psQ1UGvOqcv+ILGVRO/logBB7
 SEYipv8vSzhBqjy53iq6SOCn0PCTCm7WmfaI5Olbfk64ClwyKH4sRger8CnsVbsky2I5
 IkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444876; x=1793049676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zcPy8nPCHNSOuIFPUTrCFZo64VLr9orahzz1ImMqeiE=;
 b=SL7vJgv9gU1ytDatfKK2q1j/OmHiSJ5giV6nTrEnDwxD2tAbM0alxdrpkKGYRlfmft
 GaGHuOcmXj2CcBDPO0qVft54z0gqQeMKFWr0C9y0lbzrZFB6rfOaYPXJ2lHdzG06rFT+
 vmKK8YSs+KsU2OEQLLE+XEQ+zEn8UYOZCeaINn3dURoDRQ8D6hq9b77i2YkCvhBsHR8s
 VXpRqjlYWVVlm+EFJgMxB5/DYzRdggHHwcEWxqmlNFDCIIxrt2j0wCdsFda3O/nztXjo
 xG/OWYpg/riyGhWzzX6E0a8G5SHQxWPnFA20/rrJPmx1fSeKxruJAXY7i0oY/1CaOmv9
 MW7A==
X-Gm-Message-State: AFq9FYIg01SVN0j9UrpPKsLtJNtUoWdpEwWy3mAoaXZtX90xk2UgYDWm
 SeDbiU7CYDEnyD/fGZA+LaMR12QYbMsgIYCJd/7pUFFftcuAvMK5okn2/kZtGrpeXGT+6JrzFMl
 AoqankEdZyudvABKd2daCYZTqLZs/6Jhr8p3W8cuJwnKxCh4irqS6Bj5309Q4NUTQ6g==
X-Gm-Gg: AYBFou0Oc2xMxEWMSiZDLQL7IAsiYUWxoMwA7qQFoKnRwH1djBnlsvyVTv6zC8+KTs6
 5JaTtF0d3sZQh8NDyphNW48Z0CDMxjSehto0+52qi6ZkFR8st03XsgoAv7uPGp4fo+3yY7M/t08
 UoV2b+BGBFRD8wC5Y4JW2khFTDKh0D0fqJqpR48zWUzANmu+OkNjAd58y3N66+CZBVoWMJgyKs1
 SyRb5Xue0D3MSRfaVzPwmUJHXq5VCwDFoIT9MQZOly37vJcW8Wc/aQB1Cw2kVOFIf2+D0obiELU
 VUXFYs7DcriSsRAjqFKrviHTru302WUNYv63KNJKIVGG6/7hF1U5Xc7vADCYnL5EVi3Se/36dx3
 sHM0PmfBYa+Enc6j/A8SFRc4QBRq/pbyKjC7gnGFTh3xJLd1zIz5FpnOPAfCjGfM=
X-Received: by 2002:a17:90b:3889:b0:3ac:b6eb:e0dd with SMTP id
 98e67ed59e1d1-3acef5961c5mr7041188a91.50.1792444875704; 
 Mon, 19 Oct 2026 14:21:15 -0700 (PDT)
X-Received: by 2002:a17:90b:3889:b0:3ac:b6eb:e0dd with SMTP id
 98e67ed59e1d1-3acef5961c5mr7041171a91.50.1792444875255; 
 Mon, 19 Oct 2026 14:21:15 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 14/26] target/s390x: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:33 +0000
Message-ID: <20261019212046.149572-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QlnoR9MKcfuYHRm1b9Y_NxfelS63wqB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX8Q52WNcJ0x1c
 ObMzma3dzoO2X7t25LlvE99YByvoLW9OijmQ49mnG4d2OBWF70KFvsQJzdqTGmB+LK4tUZIft8O
 wPlhrol5kAFnF3gLXsNpteCEW3VJxB8lu1MsSjO6VXRt+6DAXJQlPA/yt3bf5dMjTOgFNy/Lm6p
 rTf9RU39urNDrZbc/Ew651X/Uigk4gWzzVY15xwndbdtcbziJmYG//UroSX5in7llmEK2ZJB3FC
 kcIBaGr3OxYqHokSFzRvMzmkJ6jN79H/ccCP1fxiVZN+98+byE5lTJ7P+76SQcQuv9Hm9KCykvw
 6gJ3EVLTkf0MErKgWD/1A4DzeO/ekRk1SIJYmzbCb5WbbL9ZrJEuzS/bxetcQhEuOGAxdBVaBXh
 2mf0EQa9LQ3l/J6sf383v5dUbHbXaaswj2lxzmb8Gw+cUh+k/q3N2aRlkOpE4eEXJWVZQh/UkQg
 kbVFZhFE/FsTAgxr/pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5YOwUJdod8B1
 6X1LjObmQzJh2n73TDNJLXw6a6VUviHSQG6MwcTi9GLq6O7d1LpgKA1pzFYpHAQFfXHtFlO6jxX
 xHW1Fgh3rFRdTAYPmOLqi6vSjEGdFkU=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad689cc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VZheFmm8EoinJ6di3KEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: QlnoR9MKcfuYHRm1b9Y_NxfelS63wqB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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
 target/s390x/tcg/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 414e6838c87..baf074240fa 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2488,7 +2488,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     } else if (opc == 0x0a) {
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
+        HELPER(exception)(env, EXCP_SVC);
         g_assert_not_reached();
     }
 
-- 
2.43.0


