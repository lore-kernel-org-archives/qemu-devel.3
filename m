Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9E2CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB887-0002QC-4m; Mon, 28 Sep 2026 05:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB885-0002PN-Ev
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB884-0000Hm-09
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MAoC246128
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=; b=j0mMgYDwinSFPv1w
 8UfOOijTv61vBwYiAQ8Hng+2CPwmf4UASxTZ7hIeap4vPgbAM1K06FMrHSDWaDt4
 PrisP+XWu9iN2qp8skGE6oflCg21MqlV0SQq8Tlj8d5fjrMaM1MA1xA/sNBUMGHH
 jT79Un9ypiy6ti31nVtkhhjMXL6pAi5ZBB0ISvah7Toz4HsvLIfAsPQFBqQiWz92
 cLX6c6bkx0QZhZCue5a3angPViO7cxakWM0dWoUA0RoudC0LIco9HKUQdL+t+WVS
 qhY0AHIqjN/zoDUj9DewNsiB8HrIRNnjINrnWhDklF8I5r2zhb5Orj0oPx1R+Qpz
 t8Dz1g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt10u88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c7d1c402dso87910985a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589514; x=1791194314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=;
 b=U+1JDBciFJ7PmMzVhmwd0yES41+XQdBuPCs/3/DGcAi3aNo8yT9ko3wkpsxaIj6Vrd
 I911BpHhsC0jPpZYHB3BNN4BjIJby6TZjiNxeOEYn45yevo55sHxThjd8FWWN7DxMIyQ
 GVbFzXnMbF1NGXS+FuvNR0es82QAI+W4wPqDxPhDqRd0YhUHwRPXO84NTanbSh/PgN2h
 C3r8BxCpvzCn9JqsgTB/cISueOe92lejOOvb9YigkOjTDQiKX9QEOkiNpAcV/2M+HsLM
 2SYzqQ1xV6Nqr+s61J35KyYhOWesNADscSz+xKMipm3BGVxmJCEHHLs+UYrPc/4fiPYJ
 Ma7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589514; x=1791194314;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=;
 b=roTsElhL5YIgAlfbk5qHJ2zxzfaSn+0hOM2sqq1xcZYRmjogVkTx9t1SdGmENqGwxW
 mEfw4BMjXHqi1dB1B4zq6j5sMlrbTsM6ddfPmt0E54mLKkhqpdkbsT9geIuYfxqks4tz
 kSkKHPJijngJMJXZ72/eDtnb4Js00iCHIjFTzQcYV3OVVqbwLKjt6aPETEnjCbKQCBDa
 7tkJ2UVIg8kPupf7HO8rXEeSB0idjghGGFUdAjpqMSEGWEI1ffxUruAEfcwFet+IQOTT
 F4dmFWm212vPpmNb9gbn+IdxEc5rWnOFa4zPmInlI+2vUdFWRkr0Q9Bx5SxwGwq8dM/F
 DpDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqAZAmOM+Mdnn/gR161E/klEykVIbwCJrwQskKL6WGL+esj6uwVNCXnROGtRLCkrNPXnJJMnLckhym@nongnu.org
X-Gm-Message-State: AFuF++kje6HTeg2qyjhCV2VdCTCxy1K6v3KBPkMzrhdvN8kDX0xE3MVX
 P1ofDEMXrHEmyf9sSLaWt9KrhzyFnYoJ3VsDSGWoZY+HdMySGaTFmq7OQ8lmhaovh+gRV+ZRdPW
 iNwfhYCqQPr9BwKDpbv8WE9dZQC8IAvrBCvkcSjT4x9iecJOd9Nc6DaZKsg==
X-Gm-Gg: AYBFou08ou3FdcBHxYKCjHfEoXyaxXIP2kxFGbEaYuVURUfP57Zy5HsMYDI7OfCQv34
 qlJqgTK02TUIGajFo7AZw0ZlxZS4jL6XwA9F/EA0OZr6sFt4MEvxrw/rwwvS38pIBh0tkLgek3S
 jmWImK7FhK+YY+qmQBEUWe/xBEW8GrgWg0hWS8SL1oIiQaz3/y2ooaOY99qemUvN9ZGPWK9t9p3
 B930IpJexbZbVBzQzaVxvgci8CMGGgepRiqQra7u4y0oegFZLLEDJKX46KV166HCB740PD2jxhP
 wXEVUvIre5B3gufKZzQ72+Lm6Tnl58ja0XGiQcWVukQ5mAdikWZBU2dOXqBMP3zcKa0jZsAS0br
 d6uQUp11j2OC33GzCONQCp5YP6yEory9/sA==
X-Received: by 2002:a05:620a:4512:b0:939:f513:cc3b with SMTP id
 af79cd13be357-93c43c9dd61mr1934036185a.42.1790589514127; 
 Mon, 28 Sep 2026 02:58:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4512:b0:939:f513:cc3b with SMTP id
 af79cd13be357-93c43c9dd61mr1934033685a.42.1790589513475; 
 Mon, 28 Sep 2026 02:58:33 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a744fb5sm24106645f8f.33.2026.09.28.02.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:58:32 -0700 (PDT)
Message-ID: <3028a892-17b9-4f9a-9909-82684d3dc533@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 091/101] tcg: Generic expansion of tcg_gen_ld16s_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-92-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-92-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXx7sjQx1H9ZW6
 h7PNFcuVX0mpUmO50PD103GwJoM4QXGcneLem9b6ZM/2t37beBuWlBftmA0I02HyZWH+nt4tpPD
 GNabVmXfMcwpxcnfsgexLXSGVIWstMW0KB1hS5Gb+U0fl1Q2IqmUJbHss9Y5Mo2C6Zilnvxayo8
 p3MC1MRqqx2RCTezPNzH4pY+1HI2t/X3IsNelF71RTBVjpY6W6NCIeU6TyjoNjTxLH+6LVDHPO3
 4rONJBi1rsr5zTsut2mgxZmkBN3dGQa9NSTlGO4YAlxOnqe7mZ6/ub12UiDOxbbOhR8gDgNJKXc
 xO92ylr86waoBRFfb+Y15h/fngouqnTER30vgaNT9M6UAqZDpxKQ0kczji14c2PzZ2e3eBwiqXu
 qtpRN9OrhgGV5qlus3alv4E/sZIw0LFL3JPYJD0/n4KK2Iu1hqQGZHYxE2pd7/GvepWS+Qp0qgq
 HrDR5+X7d4elu7QOPaw==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba3a4a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wY2OP2Cy_CYasKOW1sRcWFYziY4O5eJs
X-Proofpoint-GUID: wY2OP2Cy_CYasKOW1sRcWFYziY4O5eJs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX8sh8JVfav06o
 HJGvf8RvXG4x/aUNI6vx8E1t9bCh8Au+GRk87/lCtH+INkqbsCd5fDYdsqDx+14bsEUAEat3KWD
 QYC54HYZ7RwQtwOohZXKMLJfXdk4FYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 16 ++++++----------
>   3 files changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

