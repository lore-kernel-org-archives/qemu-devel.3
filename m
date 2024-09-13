Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364F5FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8Dk-0000kr-66; Fri, 13 Sep 2024 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sp8Dh-0000Yu-Pq
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:28:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sp8Df-00013m-RS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:28:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DAbC7R005083;
 Fri, 13 Sep 2024 15:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h3AKvJ4fweojs9ZhpT1uJAVT7iM2wjpRN7MguzmHvpU=; b=Q4C8yckWSlkm6chA
 fr5wyL+4er8mgwbvtlzOl2MnPzLTbh/sNJUXh/lfXFl5cm9Mxcvf1sCLdmJiJmxa
 TI6UxNh2NxH9EZvHrIcd9m5LJNyxlhqHzHmS16xQQtwnME455ieSZRty7tsg+9qg
 IgokNk/BM64ESsLk3pCIh50ZTbMr3VMLDivwOAB0I7fQfM1xlKMOyRt8zoycbqJQ
 dKmRwIgCMlZCclLmCEze2DhMC0SPqV+z24tafTRSq7y9mgQrUca/C9G4PQmoTT/Y
 rgIoX95kYSXiW9USVzQRWfZyVsqkgX3ZshPOTyTNM/C59Bwe5B531/31q3VuwCR2
 Lt+zug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41kvma4rgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 15:28:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DFSJfP015017
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 15:28:20 GMT
Received: from [10.110.80.232] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 08:28:19 -0700
Message-ID: <3b9c583b-3045-4d09-be9e-ca14fb1127f7@quicinc.com>
Date: Fri, 13 Sep 2024 10:28:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/fuzz: fix outdated mention to enable-sanitizers
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <thuth@redhat.com>, <bcain@quicinc.com>
References: <0ecf4e1ab26771009d74a2ce61e7c17ddc586ef7.1726226316.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <0ecf4e1ab26771009d74a2ce61e7c17ddc586ef7.1726226316.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ZTcRYFGG7j9vYA6NrI5sXet3Mvw0SsZe
X-Proofpoint-GUID: ZTcRYFGG7j9vYA6NrI5sXet3Mvw0SsZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=483 bulkscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
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


On 9/13/2024 6:19 AM, Matheus Tavares Bernardino wrote:
> This options has been removed at cb771ac1f5 (meson: Split
> --enable-sanitizers to --enable-{asan, ubsan}, 2024-08-13), so let's
> update its last standing mention in the docs.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
> In v2: fixed grammar typo and s/use-after-frees/uses-after-free/
> v1: https://lore.kernel.org/qemu-devel/a788215960b94d863baeffb736f06e3fb94275e7.1726145226.git.quic_mathbern@quicinc.com/


Reviewed-by: Brian Cain <bcain@quicinc.com>


>   docs/devel/testing/fuzzing.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
> index dfe1973cf8..c3ac084311 100644
> --- a/docs/devel/testing/fuzzing.rst
> +++ b/docs/devel/testing/fuzzing.rst
> @@ -21,8 +21,9 @@ Building the fuzzers
>   
>   To build the fuzzers, install a recent version of clang:
>   Configure with (substitute the clang binaries with the version you installed).
> -Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
> -such as out-of-bounds accesses, use-after-frees, double-frees etc.::
> +Here, enable-asan and enable-ubsan are optional but they allow us to reliably
> +detect bugs such as out-of-bounds accesses, uses-after-free, double-frees
> +etc.::
>   
>       CC=clang-8 CXX=clang++-8 /path/to/configure \
>           --enable-fuzzing --enable-asan --enable-ubsan

