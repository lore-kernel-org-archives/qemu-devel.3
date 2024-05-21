Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33364C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Y4d-0003I2-T5; Tue, 21 May 2024 18:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y4b-0003Hl-Ld
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y4Z-0007On-BP
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LKDMs6029212;
 Tue, 21 May 2024 22:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=UZ9Uhj6LCpX0xOtXb/b0UZyMu7Zzc0MJneI0FTTHERY=; b=mL
 uqevmdDJZNZh1qvviZOESezH985Z1CGVyIv2sKUv7R/5pZZoir88zj4Ao9Z3x9+P
 yeR1GjmCihp66CRx0dLAwNzqLFcVxGqpLyVTEGL0fUJOt9UeSalNFe/cI3nZgRqe
 Yh5crbf/kEw5IYStJkYOtXtaIWkZcCDNz0+awBQHLKtQJa6v4vR66ckeucXptAMz
 /0ftYa6Ul8sviJwPRhsrIBXY1Z34/Co1LX1CEMM/hfPJ87A1AHSrfzhjv9pBO3tK
 8aud6UyDxL/Xr/3rlqbB8thMB/ER7NUzEuoMFZI91UCaLpK/kwtxDiQL+3fS/Uzg
 CuyD7RS5N/YRHVqrlVRg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq5f5aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:35:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LMYvTi002171
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:34:57 GMT
Received: from [10.110.25.190] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 15:34:56 -0700
Message-ID: <9a8d8079-0bd8-4c11-b5bc-a7a1e11565f2@quicinc.com>
Date: Tue, 21 May 2024 17:34:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/hexagon: idef-parser remove undefined
 functions
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>
References: <20240521201654.25851-1-anjo@rev.ng>
 <20240521201654.25851-3-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240521201654.25851-3-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: YxqPECcRQ_db6nDevLbTLBlbUH9gUW6A
X-Proofpoint-ORIG-GUID: YxqPECcRQ_db6nDevLbTLBlbUH9gUW6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=987 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/21/2024 3:16 PM, Anton Johansson via wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>


>   target/hexagon/idef-parser/parser-helpers.h | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/target/hexagon/idef-parser/parser-helpers.h b/target/hexagon/idef-parser/parser-helpers.h
> index 7c58087169..2087d534a9 100644
> --- a/target/hexagon/idef-parser/parser-helpers.h
> +++ b/target/hexagon/idef-parser/parser-helpers.h
> @@ -143,8 +143,6 @@ void commit(Context *c);
>   
>   #define OUT(c, locp, ...) FOR_EACH((c), (locp), OUT_IMPL, __VA_ARGS__)
>   
> -const char *cmp_swap(Context *c, YYLTYPE *locp, const char *type);
> -
>   /**
>    * Temporary values creation
>    */
> @@ -236,8 +234,6 @@ HexValue gen_extract_op(Context *c,
>                           HexValue *index,
>                           HexExtract *extract);
>   
> -HexValue gen_read_reg(Context *c, YYLTYPE *locp, HexValue *reg);
> -
>   void gen_write_reg(Context *c, YYLTYPE *locp, HexValue *reg, HexValue *value);
>   
>   void gen_assign(Context *c,
> @@ -274,13 +270,6 @@ HexValue gen_ctpop_op(Context *c, YYLTYPE *locp, HexValue *src);
>   
>   HexValue gen_rotl(Context *c, YYLTYPE *locp, HexValue *src, HexValue *n);
>   
> -HexValue gen_deinterleave(Context *c, YYLTYPE *locp, HexValue *mixed);
> -
> -HexValue gen_interleave(Context *c,
> -                        YYLTYPE *locp,
> -                        HexValue *odd,
> -                        HexValue *even);
> -
>   HexValue gen_carry_from_add(Context *c,
>                               YYLTYPE *locp,
>                               HexValue *op1,
> @@ -349,8 +338,6 @@ HexValue gen_rvalue_ternary(Context *c, YYLTYPE *locp, HexValue *cond,
>   
>   const char *cond_to_str(TCGCond cond);
>   
> -void emit_header(Context *c);
> -
>   void emit_arg(Context *c, YYLTYPE *locp, HexValue *arg);
>   
>   void emit_footer(Context *c);

