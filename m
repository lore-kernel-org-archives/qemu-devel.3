Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA5EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxSY-0007Nj-Ot; Thu, 12 Sep 2024 23:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1soxSN-0006iC-5t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:58:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1soxSJ-0000rN-Nu
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:58:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMCDEI026534;
 Fri, 13 Sep 2024 03:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTIVI+ZoQS3KBpBMOcDja0tfqPQNsTC0XTmy0fYA2FE=; b=lg5g02nuj9velaCw
 BrfP3XcU6MVzuphndm/2apXrvvYQEhqYLw8y9ATU2UJ9/C7w6FsrWCA6ik8rJIkA
 pVYxM4z63Ofxc2nIo+zItk4bwlGW19sSsHtOyIzsiipwp1g5ZMfxLidhNdN4z81C
 QEiiuZE2AWMyhfIGc45CmLR9TUpLzKZCWD7FzYwZJWiWf5ex9GdEoNHSaW+WhQsS
 XIgEsuTvhRrnxZRU6SYbmR8bxiV6nwRP6k335ZSAi75axH4RhjiylTqKTMQ4BF8Q
 Z0mvV0jZ2RX3D3dhDKFERCEvSGoPpGlsnDc7xVyMdnvhxGY0WxH8DNm+k+WeDdT9
 /KZ8Dw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p7gcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 03:58:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48D3wfBZ003830
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 03:58:41 GMT
Received: from [10.110.80.232] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 20:58:40 -0700
Message-ID: <df077d1a-7718-4564-8857-06c7520b41b1@quicinc.com>
Date: Thu, 12 Sep 2024 22:58:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/fuzz: fix outdated mention to enable-sanitizers
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <thuth@redhat.com>, <bcain@quicinc.com>
References: <a788215960b94d863baeffb736f06e3fb94275e7.1726145226.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <a788215960b94d863baeffb736f06e3fb94275e7.1726145226.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 3pn4tEgvhTcp_LolJ3u0IKRXm2j2Mk3m
X-Proofpoint-ORIG-GUID: 3pn4tEgvhTcp_LolJ3u0IKRXm2j2Mk3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=570 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 9/12/2024 7:47 AM, Matheus Tavares Bernardino wrote:
> This options has been removed at cb771ac1f5 (meson: Split
> --enable-sanitizers to --enable-{asan, ubsan}, 2024-08-13), so let's
> update its last standing mention in the docs.
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>   docs/devel/testing/fuzzing.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
> index dfe1973cf8..e42d64d6ec 100644
> --- a/docs/devel/testing/fuzzing.rst
> +++ b/docs/devel/testing/fuzzing.rst
> @@ -21,8 +21,9 @@ Building the fuzzers
>   
>   To build the fuzzers, install a recent version of clang:
>   Configure with (substitute the clang binaries with the version you installed).
> -Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
> -such as out-of-bounds accesses, use-after-frees, double-frees etc.::
> +Here, enable-asan and enable-ubsan are optional but they allows us to reliably

s/they allows/they allow/

> +detect bugs such as out-of-bounds accesses, use-after-frees, double-frees

IMO it should be "uses-after-free" but it's probably pretty subtle.  
This was the original text, so feel free to leave it as-is.

> +etc.::
>   
>       CC=clang-8 CXX=clang++-8 /path/to/configure \
>           --enable-fuzzing --enable-asan --enable-ubsan

