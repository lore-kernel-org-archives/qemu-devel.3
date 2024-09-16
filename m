Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A194AC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqB7Z-0005cx-24; Mon, 16 Sep 2024 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqB7H-0005bP-SK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:46:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqB6z-0003T3-Ta
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:46:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G0l7Qq019170;
 Mon, 16 Sep 2024 12:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 68eCyQlpEpx9wmw/th1OQWisqhT0fY3CcRp4BUJnKAw=; b=WYmDW8sPldqxdrVe
 pF5uZ5XMe7fTWtiS5lGzFxwhXUf7BJCHNamv8kUhfSeEMjFJgOfx1b7HFdRRreb/
 9Hjf7Rng2mBQsW+u6NeobBAULtCfncHnwUHfxBd5vH0yTXkEuu4ankzae8EORyfb
 o68A0d1BPHXA20LrnBnEsP5wwAGjckoMGOLceWgHODkKWkjERuiYucu2GvCrZkCH
 64UwJDT/yNbiwu3Wbu4k54273XinZ5Xqg4AGs+rFWMlVo0cCrJeW+acJe6Fnw9As
 1xzReCKSN3rCaBA4K5p461mi6pv9AeTFcrmIOG8Z/Q2zFcBEIymFZl0WcmVjpcqP
 1sCaKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdkyvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 12:45:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GCjdgP027867
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 12:45:39 GMT
Received: from [10.110.8.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 05:45:39 -0700
Message-ID: <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com>
Date: Mon, 16 Sep 2024 07:45:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
To: Brian Cain <bcain@quicinc.com>, <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240907023924.1394728-1-bcain@quicinc.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240907023924.1394728-1-bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: FdnbORWwE746S4o1ef7OUhtXFljXLqCU
X-Proofpoint-GUID: FdnbORWwE746S4o1ef7OUhtXFljXLqCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 9/6/2024 9:39 PM, Brian Cain wrote:
> With newer clang builds (19.x), there's a warning for implicit function
> declarations and it rejects linux-test.c.
>
> glibc/musl's readdir64() declaration in dirent is guarded by
> _LARGEFILE64_SOURCE, so we'll define it to fix the warning.
>
>        BUILD   hexagon-linux-user guest-tests
>      /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/tcg/multiarch/linux/linux-test.c:189:14: error: call to undeclared function 'readdir64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>        189 |         de = readdir64(dir);
>            |              ^
>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   tests/tcg/multiarch/linux/linux-test.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
> index 64f57cb287..4e0e862ad9 100644
> --- a/tests/tcg/multiarch/linux/linux-test.c
> +++ b/tests/tcg/multiarch/linux/linux-test.c
> @@ -17,6 +17,7 @@
>    *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #define _GNU_SOURCE
> +#define _LARGEFILE64_SOURCE
>   #include <stdarg.h>
>   #include <stdlib.h>
>   #include <stdio.h>


Alex -- what do you think about this one?


