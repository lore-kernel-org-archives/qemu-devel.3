Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F17C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3bM-0008Tl-6n; Wed, 05 Jun 2024 23:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sF3bK-0008TO-Sc
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:15:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sF3bG-0001or-JA
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:15:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455MPxjB031268;
 Thu, 6 Jun 2024 03:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /VTvRvQyoDYu2BEVxqtPXVvoDdhcGRg3qVSpjA2xtLU=; b=Q6GYXWUnJEeGrawd
 qAOgZWa4FlccAVV7l4F46Xu3eUyeioE+YQOtjUI3gzOyavd05OiCR3k6MCxSdPV3
 OZO+uD3MALfPFCmD/SqDfnwBju0P41rHBVTJN9XUMQjGg0dJX9o52U/BBu1rmBrZ
 OWAyrDlpmgw7fCqiRpBveSIETnsKRRr+ViJxvinsBuH1BJbO2pQfMhCLYLNlQzh5
 firi8rWBQDyV3gZWb4f4jLOUNLor16LBa0GvIIatfYSfL8bj9gVCMaHYTqDMSjTa
 fJgdCuiqB/WrcdKhHG2PZemBVXErro2ujflnCZKnG48dX4eSqcnyqVmw99hI3Lzu
 7gnc3Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rkq8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 03:15:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4563FWiq031969
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 6 Jun 2024 03:15:32 GMT
Received: from [10.110.55.133] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 20:15:31 -0700
Message-ID: <1c86b103-76ea-4e4b-9351-20f118212f10@quicinc.com>
Date: Wed, 5 Jun 2024 22:14:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/hexagon: idef-parser remove unused defines
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <bcain@quicinc.com>
References: <20240523125901.27797-1-anjo@rev.ng>
 <20240523125901.27797-2-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240523125901.27797-2-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: aD3BQr0peNjWnNYEcmB2IQ4onF3COlVz
X-Proofpoint-ORIG-GUID: aD3BQr0peNjWnNYEcmB2IQ4onF3COlVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 mlxlogscore=933 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 5/23/2024 7:58 AM, Anton Johansson via wrote:
> Before switching to GArray/g_string_printf we used fixed size arrays for
> output buffers and instructions arguments among other things.
>
> Macros defining the sizes of these buffers were left behind, remove
> them.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Reviewed-by: Brian Cain <bcain@quicinc.com>
> ---

Queued -- at https://github.com/quic/qemu/tree/hex.next


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

