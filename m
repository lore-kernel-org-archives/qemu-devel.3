Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOLT-00061j-HV; Wed, 11 Dec 2024 10:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tLOLP-00061Q-1p
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:09:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1tLOLM-0006dk-OB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:09:42 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBF81Mg004033;
 Wed, 11 Dec 2024 15:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0TMsP5w/eT/8sxWDSHYoq5H8FPmdILkdvTBp/RxISuk=; b=C73GbFdHWpsw3vMa
 ITaDxzTZ+jd6On+z7PrN6bSAKVVeJthSy40fhvZQ7fm47jirSmVS1S2Z+So+pt+Q
 kWFKkcqZZL4j+pGV6WiSkl016sRodwtrzfJZSfPw00xt20tPOPOZfKIlcaP5gAr0
 AcNkLaAaWRTTLqMjdx03bJ+YOEtndOhIY+ED7XlryRhdkxRzvjSRKq52WGxmnj9I
 F/CylXPdcDo771sVWlVjQawRArSk6AfIxG9rJqp9LDSf5vl6Vm4Gn0oaun/IvqNl
 qT3GXEwr/kXx/UiepRSDnrz79Dy7+7pG/DNzmKyL8OH/Tn+baBtFl2SqI8CQiWm+
 Kbed1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40g06a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 15:09:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBF9Yju031090
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 15:09:34 GMT
Received: from [10.111.162.254] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 07:09:33 -0800
Message-ID: <3587c265-0d3a-422d-86b0-007789581ec9@quicinc.com>
Date: Wed, 11 Dec 2024 09:09:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Misc Hexagon QOL
To: Anton Johansson <anjo@rev.ng>, <qemu-devel@nongnu.org>
CC: <ale@rev.ng>, <ltaylorsimpson@gmail.com>, <brian.cain@oss.qualcomm.com>
References: <20241206160103.24988-1-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241206160103.24988-1-anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 5UH3S9aiEpPP8Ql7hYsrrOyvaHs-B4CU
X-Proofpoint-ORIG-GUID: 5UH3S9aiEpPP8Ql7hYsrrOyvaHs-B4CU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=966 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110109
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 12/6/2024 10:01 AM, Anton Johansson via wrote:
> Separate submission of patches 35 and 37 from the helper-to-tcg
> patchset:
>
>    https://lore.kernel.org/qemu-devel/20241121014947.18666-1-anjo@rev.ng/
>
> Anton Johansson (2):
>    target/hexagon: Use argparse in all python scripts
>    target/hexagon: Make HVX vector args. restrict *
>
>   target/hexagon/gen_analyze_funcs.py     |  6 +++--
>   target/hexagon/gen_decodetree.py        | 19 ++++++++++---
>   target/hexagon/gen_helper_funcs.py      |  7 ++---
>   target/hexagon/gen_helper_protos.py     |  7 ++---
>   target/hexagon/gen_idef_parser_funcs.py | 11 ++++++--
>   target/hexagon/gen_op_attribs.py        | 11 ++++++--
>   target/hexagon/gen_opcodes_def.py       | 11 ++++++--
>   target/hexagon/gen_printinsn.py         | 11 ++++++--
>   target/hexagon/gen_tcg_func_table.py    | 11 ++++++--
>   target/hexagon/gen_tcg_funcs.py         |  9 ++++---
>   target/hexagon/gen_trans_funcs.py       | 18 ++++++++++---
>   target/hexagon/hex_common.py            | 33 +++++++++++------------
>   target/hexagon/meson.build              |  2 +-
>   target/hexagon/mmvec/macros.h           | 36 ++++++++++++-------------
>   14 files changed, 127 insertions(+), 65 deletions(-)

Queued to hex-next, thanks.


