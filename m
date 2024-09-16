Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C38C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCdW-0000db-P8; Mon, 16 Sep 2024 10:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqCdU-0000cT-U6
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:23:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sqCdS-0006yh-Qa
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:23:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCkdWb019170;
 Mon, 16 Sep 2024 14:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 60V6IG6sLGECfeGBer7DhvV3HjPKTgvkgqBshhOhCEk=; b=cUOKgfwmA2e1GkyW
 853UJkbZPh6YlJEIiK2swYC8OxsLglGZfqNYgNaMMR9TJCzYuK661g6qjk50QfrX
 Yf3Kv+m/XJ6E5kz1AeNAJHyjFS6tW+p8/UDMwNlKWZfYNuTj3l9VOI8AsWIQUDNw
 Tfz+zzfaCc50TLFLnm/OISC8JO1XL0zZ4hghmmDavNK0ub+LzQiNVC2jXyk6sJ78
 +hh0A0CtAMqIkNOtTRsvr963MOw14HbmjvCH0V0U5GSHJWaxVBpP2+MZtFS2B1a/
 +tUT3gh8vZdNeK3rQc4ic430X2Bh0oTEXVdbAgmF7wWuUCcW3alRIuQQxrhMZoXF
 idZrdA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdm6qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 14:23:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GENNnh026844
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 14:23:23 GMT
Received: from [10.222.168.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 07:23:22 -0700
Message-ID: <b6ef0a81-1153-4aca-9e27-570c2f0a6853@quicinc.com>
Date: Mon, 16 Sep 2024 09:23:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
CC: Brian Cain <bcain@quicinc.com>, <qemu-devel@nongnu.org>
References: <20240907023924.1394728-1-bcain@quicinc.com>
 <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com>
 <87wmjbg2th.fsf@draig.linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <87wmjbg2th.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: W5azYGo-1CJGzBgsvHB7xfwVzvLt0LVf
X-Proofpoint-GUID: W5azYGo-1CJGzBgsvHB7xfwVzvLt0LVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
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


On 9/16/2024 8:12 AM, Alex Bennée wrote:
> Brian Cain <quic_bcain@quicinc.com> writes:
>
>> On 9/6/2024 9:39 PM, Brian Cain wrote:
>>> With newer clang builds (19.x), there's a warning for implicit function
>>> declarations and it rejects linux-test.c.
>>>
>>> glibc/musl's readdir64() declaration in dirent is guarded by
>>> _LARGEFILE64_SOURCE, so we'll define it to fix the warning.
>>>
>>>         BUILD   hexagon-linux-user guest-tests
>>>       /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/tcg/multiarch/linux/linux-test.c:189:14: error: call to undeclared function 'readdir64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>>         189 |         de = readdir64(dir);
>>>             |              ^
>>>
>>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>>> ---
>>>    tests/tcg/multiarch/linux/linux-test.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
>>> index 64f57cb287..4e0e862ad9 100644
>>> --- a/tests/tcg/multiarch/linux/linux-test.c
>>> +++ b/tests/tcg/multiarch/linux/linux-test.c
>>> @@ -17,6 +17,7 @@
>>>     *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>>>     */
>>>    #define _GNU_SOURCE
>>> +#define _LARGEFILE64_SOURCE
>>>    #include <stdarg.h>
>>>    #include <stdlib.h>
>>>    #include <stdio.h>
>>
>> Alex -- what do you think about this one?
> Actually scratch that, this is a 32 compat hack:
>
>    1f442da51e (tests/tcg/multiarch: fix 32bit linux-test on 64bit host)
>
> Is the __USE_LARGEFILE64 symbol in the hexagon headers?
>
musl does not define/use __USE_LARGEFILE64, no.  If it's well defined I 
could examine whether it makes sense to add this feature to musl, 
though.  How does __USE_LARGEFILE64 differ from _LARGEFILE64_SOURCE?  Is 
it more appropriate to define that here?

-Brian


