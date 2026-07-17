Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2776BC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkoCS-0004Lu-EF; Fri, 17 Jul 2026 15:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkoCP-0004LI-W6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:26:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkoCO-0001DB-3t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:26:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HHL5rZ2535227
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rY6TKZR8lh/rgEjXn01l2BquQmzchfLPFRCRBfdFIdM=; b=OAa7RUQ0dGLHHb8y
 qxcsFZjP88OmuuCK3SPNTaf/KONHeyV2WpQX/iZtVZvzfP03Bc9DEvTxXctJZeD4
 adl4zPqVZallf1NQNqgTQWlvYtZFrZhMXfy+ytnWGzkNYpuSaEaxnvQizRr5phBT
 QIn2cZ2SqB15C1aVGp6DaunfVD0w0Nhv5QMB02ob0zcA9gNjFFkXYORV4CpXxjrR
 EcvSZyeuUWw783T4LcIIVO1ruurvekmnjoqbwTgpp9aRiJvnlnldP42YwzSGJbnx
 jYKiVQbwqMylpUBJymRK4RWVoxIeum750aIlZvB/Anxpfy/bxnGSeUMHeJ1nrbGL
 HA9vUA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrqd8g7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:26:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381abcccbf4so4686766a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784316372; x=1784921172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rY6TKZR8lh/rgEjXn01l2BquQmzchfLPFRCRBfdFIdM=;
 b=GZPW0g56BN1IjMWgGb9DzX+WunDXW0rWE7HvKFF9YRATIwC/F/MmSJUpm4Xcr2ZgSv
 rf3qaDqB/BHtcwltu8H/YQ/X4u555aVweFl+4m98dNTKHpUGwKerDIsMWbUch5y4u21I
 Y6CHNIqJSuOv8hp3CWc6zBXkdSSZZN7vOJUZ7jjaxEPreXYRw4ETfh/cm1gkuMBb0GhM
 LcZNsWdSlpHEaQgh7KCoXtYrJ4oP9RYljY2FRPVzWZ8hT44haFwaGnnnVbM0vhcTtvj0
 mH5LAqntbc+lqqBS18w3xMYS0tW0rqmaJ79LNHRJFsvwPOncg0WHPPeIz0hpnqrJJ7J0
 Ekxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784316372; x=1784921172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rY6TKZR8lh/rgEjXn01l2BquQmzchfLPFRCRBfdFIdM=;
 b=egPc4c/6C0yQIEFldLtOLhzYMs0A89MA69guXAcUwOtThzF3sMSQtEXUZkC5IWBMnn
 yF3t9jsHdOEJCh414lmmh8UFx5Xgg6/9eHmv/ECxo8Em2TxbyZjkhhF4oDnyhDPet0tL
 uscFj/jZG3sVZWudxoYyGctpqGgAy/pxIfMw865sJzGwbnhK7YvxT0dpk56oAKAQJ/+h
 ATNkH2vRI+TPjLoQGxR/4JRa1iemiZSBuYEkas3tZ0ptdXYnSQxCgRPfD0LHFQ/+YbBL
 m6WwdgVaKP4bOQ1p9Cd5ygajPzx98kaDvvFPV/fLbC2kMuoyUupgIXC4bolAtRVg7PI9
 VkxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAqBRlnKqgRTkEDM7MsTOXDAEDl473bWgLBHIt47VCNin2Q+uj5yCy8xDigbOo0jYtfibxBZGSl4+D@nongnu.org
X-Gm-Message-State: AOJu0YxVYzmYaHiXv5kx4TuWfygnrR8SEJt2mV4YUHMnBESEuz8NSwdo
 yCvM5OFt+ikIIO2VMZK6br6JXtDoi5IzODcu98ofyEm0H+XyynaSTA90TPv27u3cxvMt4YvebVA
 c7IbdwYDFb0Z3TZuBsFZmv25+pSXe1aoXraVW+9FOX0U97SHORwp3yx4MFg==
X-Gm-Gg: AfdE7cljWAhBRYipmqTKO1sEdHLR3vuRR8+/vInn4g4AY686mkKN3SYkb6nbBFmjKEV
 6j2SaLZhaiYJnIOO3I67UME/H2Hs39DY8qAsih4A0ZLLF31gzS6yFTpUvFqOvBdjRSB1rGhYdSa
 rHdO0WZnc50Di3XCLSiOqOWDFH1Z6A1qFJsd55rv59cWxbq871CiiN+F6TFiHhKDreQry7d74U1
 NAXoe6kXbXEop1NGMfSexCWtdS7icocTqw71nlyg4qwkxKaxdGc9JJIffDqaKmKe3swSFTDeUQe
 ykX+yi3YmIfa2MXJok5d0hvu5E8KAJS5hGLgFa549cjPvHEHjnyU5XGzAJKn8vaAyp6CVaLZrZD
 Ixf1KSIkOwujR4xJAABjRpn0ChLuM3Q5b3bXUlb1lkTLo9g60qdd4YFTk3e8rr4VDX7R3
X-Received: by 2002:a17:90b:4a0e:b0:387:e0db:bc25 with SMTP id
 98e67ed59e1d1-38e4b55c8cemr4402672a91.37.1784316371842; 
 Fri, 17 Jul 2026 12:26:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0e:b0:387:e0db:bc25 with SMTP id
 98e67ed59e1d1-38e4b55c8cemr4402637a91.37.1784316371367; 
 Fri, 17 Jul 2026 12:26:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe1014sm9880701eec.7.2026.07.17.12.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 12:26:10 -0700 (PDT)
Message-ID: <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ka9_NPMxYPxJpYhPUKdulcA5kTQgakKh
X-Authority-Analysis: v=2.4 cv=DbYnbPtW c=1 sm=1 tr=0 ts=6a5a81d4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=lg9zkZ5tSWXC1UPTsHYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ka9_NPMxYPxJpYhPUKdulcA5kTQgakKh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5OSBTYWx0ZWRfX+EeTdQ1r+QV4
 /Gu8VfFc+/KeHQJcUz3sjuDa8dq+bGTl5IjMoxbI/z5+H/0CkIqsJsaRe1Fjt+c++0MGDcgXv7U
 0fyhnWcCTbaUEzkDFZY3FomoVDO7dtg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5OSBTYWx0ZWRfX0DXmptvrZdxP
 Kir9rpmQvg4pbpqUJgvh2SbLRQB+5et9G/rvvbDLjAQNQLd1zoLtXUA51n1md4ModdEKRuU4BWy
 sm2E+tYZJnhDSkZRiGY6nmfXAnSChLzSvJN9XsA+XSm+wdJRgclliVPpGEAe2YoVKpZBteCYd86
 xJCKHlXuPTWCcZ1djC2RqcP1W61JN+mKvLX/vCtc3MGwa9qXEVf9hpu4dCov7XkTQlfSY1HLniE
 DTpCy56zcsb68T+U45X3YWHV1fW8IPhm+LwhADybOGsgyUnrRQTN7e3Z+b/MD8xQxqH6lV+kT0L
 QkkULJoqZ8TFSMdZvIglt0PWYVkLA/WMc8voHYL0O5mfBY87bEddSW3Jz2JMd899ISZKm8lsYW8
 KGs/AgAot8kl+bTg6VdVxPZE20JiVzDt+S0nDcBhG+6sr09YS4+Io6tgURTzuiJp16LBk9DaRaN
 ezM+N327C1wfBGXkuoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170199
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

On 7/17/2026 11:51 AM, Michael Tokarev wrote:
> On 3/13/26 01:44, Pierrick Bouvier wrote:
>> Code concerned is under a kvm_enabled() guard.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/vfio/listener.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 960da9e0a93..31c3113f8fb 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -20,9 +20,7 @@
>>     #include "qemu/osdep.h"
>>   #include <sys/ioctl.h>
>> -#ifdef CONFIG_KVM
>>   #include <linux/kvm.h>
>> -#endif
>>   #include <linux/vfio.h>
> 
> This now fails to build on sparc64:
> 
> In file included from ../../hw/vfio/listener.c:23:
> /build/reproducible-path/qemu-11.1.0~rc0+ds/linux-headers/linux/
> kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>    16 | #include <asm/kvm.h>
>       |          ^~~~~~~~~~~
>

It seems like it was unnoticed because we don't test cross builds for
this platform. We can't guess something not tested is broken.
Seems like it should be added to CI if we want to keep it working on
these hosts in the future.

> I wonder if this is a sparc problem or qemu problem.
>

QEMU issue.

> I don't think kvm has been enabled on sparc, ever.>

Right.
If I'm correct, it should imply that vfio is not supported as well,
which means that hw/vfio should not be built at all on this host.
meson.build correctly adds files only when CONFIG_VFIO is set.

So you can a look at why CONFIG_VFIO is set on sparc64 host first. By
fixing this, and it will fix the build compilation by not including
those files.

For more safety in the future, feel free to add a sparc64 cross
container (debian-sparc64-cross.docker) + a CI build job using it.

If you're stuck, feel free to ping for help :).

> Thanks,
> 
> /mjt
> 

Regards,
Pierrick

