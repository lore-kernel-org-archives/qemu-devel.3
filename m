Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3543DC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Y4p-0003N1-O4; Tue, 21 May 2024 18:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y4o-0003Mk-E1
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1s9Y4m-0007TG-Jy
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:35:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LBP2EU008895;
 Tue, 21 May 2024 22:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=xkOuxE2xyPw64t582Wbomo4fl0O4oF52uOKsogFabkc=; b=Xl
 m33tepGXMXhsLreD+69hiQjMA9hFTk7qnZdchWYrvwwFPpWM+2vQXfPSGRxMrIym
 SDrCoeD615XC4M5S6DyQm41QOsQStedsYZymHq7i9bcBvCtk4yA1bG3gZNTDmhjZ
 7035jSJycRUsYUsPjmSDuIU6w0mH0nXgv/H4shfzYh5qRFDRiMlLorC+rbzEChi3
 VJCePBu2yRdgegkI7bCs6SpdiRdld1bIaaRJxVEjWjf3bn05BkJESG5dcYt7oncL
 +6GeSPBf6RE83S9JnazWMD0YcirGWCK9xGyBgai3z3yqb2a4ZVl47V5HVZKdtFkB
 9ug5fYju5RxfSR+oxT3w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqc7dsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:35:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44LMZHhi019010
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 22:35:17 GMT
Received: from [10.110.25.190] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 May
 2024 15:35:16 -0700
Message-ID: <7e8fb128-edfb-4dda-b71a-15ebba86153f@quicinc.com>
Date: Tue, 21 May 2024 17:35:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] target/hexagon: idef-parser remove unused defines
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>
References: <20240521201654.25851-1-anjo@rev.ng>
 <20240521201654.25851-2-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240521201654.25851-2-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: C14X_dCp4CNkrUrI0kZRgd21Kc772Noz
X-Proofpoint-GUID: C14X_dCp4CNkrUrI0kZRgd21Kc772Noz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_13,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=905 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
> Before switching to GArray/g_string_printf we used fixed size arrays for
> output buffers and instructions arguments among other things.
>
> Macros defining the sizes of these buffers were left behind, remove
> them.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>


>   target/hexagon/idef-parser/idef-parser.h | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/idef-parser/idef-parser.h
> index 3faa1deecd..8594cbe3a2 100644
> --- a/target/hexagon/idef-parser/idef-parser.h
> +++ b/target/hexagon/idef-parser/idef-parser.h
> @@ -23,16 +23,6 @@
>   #include <stdbool.h>
>   #include <glib.h>
>   
> -#define TCGV_NAME_SIZE 7
> -#define MAX_WRITTEN_REGS 32
> -#define OFFSET_STR_LEN 32
> -#define ALLOC_LIST_LEN 32
> -#define ALLOC_NAME_SIZE 32
> -#define INIT_LIST_LEN 32
> -#define OUT_BUF_LEN (1024 * 1024)
> -#define SIGNATURE_BUF_LEN (128 * 1024)
> -#define HEADER_BUF_LEN (128 * 1024)
> -
>   /* Variadic macros to wrap the buffer printing functions */
>   #define EMIT(c, ...)                                                           \
>       do {                                                                       \

