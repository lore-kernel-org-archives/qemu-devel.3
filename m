Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B7CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Uc-0006m9-Oa; Wed, 14 Oct 2026 16:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Ua-0006lw-DJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:22:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5UY-0005Vo-Pg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:22:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbRgE3813086
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OZPU8ldFPgIOkl0Xdq5EeL+eARK3GiMFiNzAkcu4hP8=; b=WIACKnRVkAmkBMwt
 oOeAem8sqbJcHJO2vK1o87u5wFvkDJv0XHJN7MEslqPC25DbmP4K0NwuMNQ34gn4
 KYChiZ10SGBphYByGVeW6gnOWA0/hBTjE3FMTJSD9hiL54/SbWwlHG/d0qG8t2jf
 gZfgHSSgQ9+xgB1+tPt1QcjtyzpUlhCQ17iAgwGsev+yJnE9G5ZG0SOK3z7QG1l4
 LxB07x0CJKkPq9SuZ1YbRwdGT5+6JqjH7VAgi8+KBy5sC4dLo0IZdaAerjk4dXCk
 cD3vFUAM5jq/prUFqUVJx7J3VeiAyhGijDELOEN+N5lXkchhOmpHthmc/+P9Ce1c
 zMvBrw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3d98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:22:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3580c07911eso11876480eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009345; x=1792614145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OZPU8ldFPgIOkl0Xdq5EeL+eARK3GiMFiNzAkcu4hP8=;
 b=ZWLglcgRVSrDyA9QSOOY0NRAgiyPriT/cLcYveShE2EaL08TXsAUvEWDhJNJplrNRX
 EtjBCZtbLmZUVVEIAYlx047zj/MaUh+x3D3xPtbwe2S9vAZZB9TeONlonxMlXWWuuWKa
 xzJM+6hLxD0IxFnhHF5yVfiWPwXFQQrhsxZHnbtp17iHJOz/QnEcLL6k6R3n4/V03/yP
 x2EaS1qA0VVGlO1lqxIl+kR+aR43n88OfkUXfJID/tFz85Lfo+nGOrMPsKUjlxOgpwLx
 6zPXd2fW3XB97fCF38l4c6gthGRSN4cUpsjDLCDyhgtq3rLVLhjJE1FgDgzakjuN+AN+
 atQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009345; x=1792614145;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OZPU8ldFPgIOkl0Xdq5EeL+eARK3GiMFiNzAkcu4hP8=;
 b=WOfgnxLHIHYuJMyAPeGcQ8Mn+RBDuwEbskg9lO9kS3itmzu7T0EoLkLzqN4Em+ipEV
 gVURKWBBxXrTmw5ARsliZJOKegGvftCU9M+ivb+Bzk3R/3eHhJQWk5Hcyoy+YzQLpxn/
 Zo5gK0Zj8kKCVyxz28UTjGUuDUrNWp301Ohbq5HfUNTsV6KAMxvoTixahCbhhNsXPanj
 zZogEGHQpw59eMf6Psx+E+47I2B3/iKetD30lLCJjyPKGsLq7YiU+Q1zfGLbufV45lYf
 bqLUsmsFRTYxGEaLuZ1YD49H6wyUvgmZDIrEC4Yy3DV8fB6lHZoRZvggu7QLzzJbR/Gk
 jgFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfVqFyX8IcNV3/VFvUM7jvJH64VhztzA2MawX8YNnFF8cOB25wPLD9wjuCKVkPDj5xJiXnG/oeeYsJ@nongnu.org
X-Gm-Message-State: AFq9FYIlID3h9mY0aOS90vaNucB0ZICaSYTm2fVN6+6fNZ0s9OiVfrGU
 uAN/DigNa/AIVc+wzqqUcWN0vdS0MivPASYWuYQJkBGQaQShArPPY0gfOdv0kiS8H5PgSwrUttJ
 NzSTwUi/je2BUgZVl96SP9sRdDGgWDV4kOJdn4v7AYa8yhkF9EHeQle5Nlg==
X-Gm-Gg: AYBFou07gxsAd59zRRL2Dv4xL3ijNluk07Okva747giLqp/OI+Wrsz9XpkHTLm9SeJH
 LwWKEwxYkQxsv3Km8rvvavCCSKzL0++r6QETZe86UpeZZxBoQHvNHIPCLJLYzBPbFE+HJZLWjiY
 Cfkkw0IkHyEwVgNwCl26iG/AvBohU9Xf/EhGOOt5V5qSrjFD+Rn7c8/1IiJy2iJz6ITGhDaAQ10
 me8iuxoLmGUJe7kIsn13EPEspPsJDyKSDS1AszhQk/4SdM55S7kKUu8qAwEnleZZ097iFA6buVE
 TvueiEEVaCw/CIhsAUoPAFCACqKZAENk/yelbGYAns3Imf7f8PtmP8qw+0AlvnDABASgo2yv2vx
 0C1g0mGBEgkI1Rkx2PJ3w8NjgUcL5f++WygyPbSlT59Zn+qR48T99CFLp0KEwAWi4cbROfg==
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id
 5a478bee46e88-35a29b6c486mr13401122eec.30.1792009344655; 
 Wed, 14 Oct 2026 13:22:24 -0700 (PDT)
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id
 5a478bee46e88-35a29b6c486mr13401093eec.30.1792009344109; 
 Wed, 14 Oct 2026 13:22:24 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm50923272eec.29.2026.10.14.13.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:22:23 -0700 (PDT)
Message-ID: <842e3e08-27cd-4418-a3f1-c869e5757e5a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:22:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] semihosting: use new semihosting ops
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
 <108e9660-5d09-4e92-9d36-1a64dfb1f918@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <108e9660-5d09-4e92-9d36-1a64dfb1f918@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX2nTeDbOucw3D
 5aEQx8xTWDPMR9lJRD269hCWYPEnOKkkoTSTC3HOVL/CY6bfRi3qWzplqrvwSziCqPf/8xweUkW
 OdRazBS/nnb/7aGK86VqrDlBPQT0+hw=
X-Proofpoint-GUID: 9YdK22iOetcV9zLQXodn_I1-oXYLwZ02
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfe481 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ILYREr7nSgKIVxhnKMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX3xRRKHz0x6EF
 5USGObrMYcsjyJk0/10CNhZFMozszSgrPW0rItLTbx9+2+KfVoWmQZnjhrUNXOfcK+bYr3yRwK1
 fZWeSZG7edscF+GZkSW9Mu0QdzU5Q1AAweqAXgL7s7pTswVXXeLYRBPz8ds80HZbgJ/jipviWVx
 znLEL0xxFNwj/wYUdmQQl6ui9yLrLLpt1LhKAbtF76QOsewHxzFFhT9aMnviz3sfhh/DoQ3HU2h
 q/9uCjLZcKqMeRsWVq/v+HEQm1KTCOfZYL8FRG0SwH/4Oirskagkh3BmGgRZPJRfSf7q2l+l6wg
 uxzdup/4n/bmo17vBO1bLtn+0bFcA1I9/PddfwzK6YLsAQ7ts6+zMZjfC3/pyC20TpSQGbwS4J9
 ZowsOaYY6SCGwsCrd7v9pRZ2LZiQsv4jwm5wTz9ACbbM3PBQTeiWiQVgUfWRoCntQGlXvp4NC1d
 nJLfHtKhOUv4Onnq2tQ==
X-Proofpoint-ORIG-GUID: 9YdK22iOetcV9zLQXodn_I1-oXYLwZ02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/14/2026 12:48 PM, Philippe Mathieu-Daudé wrote:
> On 14/10/26 20:25, Pierrick Bouvier wrote:
>> Now that all targets implement this interface, we can replace function
>> calls with the new interface.
>>
>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   semihosting/arm-compat-semi.c | 56 +++++++++++++++++------------------
>>   1 file changed, 28 insertions(+), 28 deletions(-)
>>
>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-
>> semi.c
>> index b930a028649..3117eadb3b7 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -188,7 +188,7 @@ static LayoutInfo common_semi_find_bases(CPUState
>> *cs)
>>    */
>>     #define GET_ARG(n) do {                                 \
>> -    if (is_64bit_semihosting(env)) {                    \
>> +    if (cs->cc->semi_ops->is_64bit(cs)) {               \
> 
> No semi_ops / handler NULL deref checks, SEGV as implementation error
> sounds OK but might deserve a comment in the commit description.

I'll add it.

