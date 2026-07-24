Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50830C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOMG-0007x4-0a; Fri, 24 Jul 2026 18:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnOME-0007wr-QP
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:27:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnOMC-0000dj-L5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:27:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OKwDgM102710
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 22:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0D/Er6rfPpVF1f020LjV06DR8jWdcTpmH/thZoHYXw8=; b=Le0RPQaleO5Uedn4
 HUTCDegi1d6lUlKHeybdzHNMrgLNKasHhrBjtI2Yz4Jg+XFQH9uXqUI/54Z8Jfbh
 IiThRF9jN0qlNySpn4/PyYeiiw5mEbwwzh9dtBfKCia+37kghQn1F13padX0tjNR
 54AlXwwZX5/G/oJSGj3BCCpkuqAff3l9I038SjqE0wEH+RsmlcjeqNgNSPUMaVf4
 t3R+V5zGk8pbN4TSou1OqNs5XyH3/VIrV8FV4StgLLgIG/1sO+bQ1SPuRKz3REJq
 WoRUUfVcffay+fZBNmOGLtZ/FAn2hNVe9A3y6ZMMEUXw8sYpRqzBXknrGmMAJu3W
 Kln1tQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmb9nsfe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 22:27:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso1318222a91.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784932021; x=1785536821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0D/Er6rfPpVF1f020LjV06DR8jWdcTpmH/thZoHYXw8=;
 b=L3nBYpWCruhd2EbizLMUIDV0VuhOZAeahFDwx/5lWapDyGyiEEycW+zObpbzYJZ/zR
 uhxCmhPk7wv7Pa1fwoSsHtBxGrpuE6y5H7z2Rr6OvQZS1BOqYLBUWBKajJTNcYen2QB/
 FxQm/TH2rXHDZHlukUW0FHZgOzqBMOOAPcdN7o4AuTAM44374ylHnHOuDm5Fa3CaDqiO
 0wDkQY52/of0T5mjl3DDq8KApfqNk2ZrXL3j3BIIot2y/GhUj4hBYIoc6QvepRHTTNdc
 Ug1hUm6BV/zihDcFzTYHXEFqnPaCasB4RyU+CrRLHlEWUHnLzcuVnWM6GXH8wgDbtmtK
 66Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784932021; x=1785536821;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0D/Er6rfPpVF1f020LjV06DR8jWdcTpmH/thZoHYXw8=;
 b=Vzjy+KaXpl24SqyzYXA1d73CZPnzSyocf8kNgZQ3JKXCsoimG9syro6v2R3lJGt51u
 9wgj5p41fNU0Fk0r9jiTYtfMmguJXr6+ScGmhzx8WfOEVxGAFx8q1YzDv+4q+g7t0lrZ
 ZXf+tB68ADTpWI+DZeLU52xhcomyjG1iW5E/GiVViGiwgLgPrRwmL2uOL1dLtUsr7hZg
 6cfEwPZL77mtM2mES/xB8WwYJAmvQweLBmFwxACQyJQn9LzIKlq67ax8CcVArKMgD6TR
 D/r/0egX2ijvnh5agw3dyJDFWdjbPpM/Ccnp5V9upTH3+8rSUlXEPUzJ+yVN65o1nOC2
 lnBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwutoU3+fbMRPbWzph60TTzEMgk2DXXlkHm+Nf9OxKweWEMZZOH0i8l91rOpVzBR6D5LiDabiSg8iP@nongnu.org
X-Gm-Message-State: AOJu0YwncIy+PcGMjT2TGXja/A3KtGFZ4tOcHXoWJ0TWh3IDet5O6+xI
 B8C7se9qRxGYX6Q7TOGlslrW5cgI9jd19/0jnLmQhdTuTTbzXZc4e7rLPMQvOAX3QjPEEVWf3jU
 iBmmSOfhWGc5ZYqUmD4JbCQ0vabTJ2QcTqZK4Ymq7k4a0j0L+B3LPr4Hnjw==
X-Gm-Gg: AR+sD11OlqfXWw59hIftXAo4tBNg/mwNdDwStd3R5fIvtLbbVCwc9W6k9bwqM8alIst
 tCFyjlLsrmb1rD1sQR85//V92MRvo/+U/eDZNxwSfhvmLyb6X6R9+CZBdtdhsEpXQMTykSLHkub
 knqp/8EyzV9eqUF4e1f/9F8XtYIZETglrDjauJtC7edV4E5CLfugRaYQQoc+6Vuns4UIh07sFvU
 +Wd+XQzywbjKYIIJRmHaq4uLwRbxwO6YOn/RdXmrzjuaG+ZIIp8EWrc9opv6BuZYhoaRqAeN4ej
 jD4h9DLlOE7Z/ZM7EK/pLOTgyP9zTX9wY+7MjP+rh8HlnXCZBtRfWf2I2UzTH7rguanxonkjYeo
 ecONT1/Wz/J63ARfVx8ygw96PArXmACPg10Q+ljdiRIhVvvITSPdxKMWPnDquBwiqFOgy
X-Received: by 2002:a17:90b:4a51:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-38f295145c9mr288741a91.16.1784932021636; 
 Fri, 24 Jul 2026 15:27:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4a51:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-38f295145c9mr288720a91.16.1784932021152; 
 Fri, 24 Jul 2026 15:27:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130a8421sm26659176c88.10.2026.07.24.15.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 15:27:00 -0700 (PDT)
Message-ID: <0207e5f3-3029-4f14-81ed-fb469a02e6fe@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 15:26:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: Helge Deller <deller@gmx.de>, no92 <leo@managarm.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
 <a0adc88a-4405-46cc-b46c-6981f310db8f@gmx.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a0adc88a-4405-46cc-b46c-6981f310db8f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XeS5Co55 c=1 sm=1 tr=0 ts=6a63e6b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QqsuZDsxAAAA:8 a=zASSHvuyDF9LSEAwRFkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=L0GjJRv8sWY0dH8UTALY:22
X-Proofpoint-GUID: E62WomXd0hGOjm2fE2Z1piQ7IQvfCzlo
X-Proofpoint-ORIG-GUID: E62WomXd0hGOjm2fE2Z1piQ7IQvfCzlo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX78qdzJJlYLh3
 6zffeTPSQfiYV9DSq0dtR6IEtSP31t9vAUMVBKbFfglrsa3Ua7VGpNKd8xZkLepLOmM6xD6UXwe
 YLRDRnGFAu14TzfSVWHZcbXbQ6M8wdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfXwf8TvKuhv5HM
 7w+zn4OusgwMgTimdNmUtwurJR1rcgS563jAaW7Aj9+x78+ys2gWGJKFA6Kt+yfMu1s54qXycj/
 SnDi6+CP/FFGInNGWUVjj9BcILXwN1IrbDSCCwZ5h5NA3gybm0SLDGpI+TSM68bQx5VdwAd3S2D
 3XaNHw4cEiT5lV29eQRUdBNdwncT4EScE+WFeSzXL7AqXGKWOUZCYx2l0kKIE7xZGw+DWYPk9X9
 C4yg7VKLdjElSFDHlCsm9c7qSLhxCKtf7cfRq+N+l2LE/i03f1zLNi3QNDoicxycqkWCwavqvDf
 DtZUJCeXeh59Ns9NGYGssTGlvZhc2sJtJFX+TCJpKtCqO8T+JomszTAktnWk/keXr8tR/lUfa9v
 KyaMPW4EmX7wvK108PS18GvXqQjgr62f2GhDSFrDQ/JdvR32hf3O0AW9jpWO8ZCAwTGtZ4mi5rf
 5ft8VNQj1gMpjoQGxCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240202
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/24/2026 2:42 PM, Helge Deller wrote:
> On 7/24/26 18:48, Pierrick Bouvier wrote:
>> On 7/24/2026 9:01 AM, no92 via qemu development wrote:
>>> The members are declared as __kernel_pid_t in Linux UAPI headers.
>>> Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
>>> declared as abi_int.
>>>
>>> Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc
>>> calls handling")
>>> Signed-off-by: no92 <leo@managarm.org>
>>> ---
>>>   linux-user/syscall.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 3da5530d42..616d543c7f 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -4234,8 +4234,8 @@ struct target_msqid_ds
>>>       abi_ulong __msg_cbytes;
>>>       abi_ulong msg_qnum;
>>>       abi_ulong msg_qbytes;
>>> -    abi_ulong msg_lspid;
>>> -    abi_ulong msg_lrpid;
>>> +    abi_int msg_lspid;
>>> +    abi_int msg_lrpid;
>> ...
>>
>> The change looks correct in itself.
> 
> No.
> abi_ulong is wrong, but abi_int isn't much better either if you look at
> the kernel sources:
>

I wrongly assumed the definition we had on bsd-user side was correct,
but didn't really think about checking it in linux sources, sorry.

> grep -r __kernel_ipc_pid_t arch/
> 
> arch/sparc/include/uapi/asm/posix_types.h:typedef unsigned short        
> __kernel_ipc_pid_t;
> arch/sparc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/m68k/include/uapi/asm/posix_types.h:typedef unsigned short
> __kernel_ipc_pid_t;
> arch/m68k/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/parisc/include/uapi/asm/posix_types.h:typedef unsigned
> short               __kernel_ipc_pid_t;
> arch/parisc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/arm/include/uapi/asm/posix_types.h:typedef unsigned short         
> __kernel_ipc_pid_t;
> arch/arm/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/s390/include/uapi/asm/posix_types.h:typedef int            
> __kernel_ipc_pid_t;
> arch/s390/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/xtensa/include/uapi/asm/posix_types.h:typedef unsigned short      
> __kernel_ipc_pid_t;
> arch/xtensa/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/x86/include/uapi/asm/posix_types_32.h:typedef unsigned short      
> __kernel_ipc_pid_t;
> arch/x86/include/uapi/asm/posix_types_32.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/sh/include/uapi/asm/posix_types_32.h:typedef unsigned short       
> __kernel_ipc_pid_t;
> arch/sh/include/uapi/asm/posix_types_32.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> arch/powerpc/include/uapi/asm/posix_types.h:typedef short              
> __kernel_ipc_pid_t;
> arch/powerpc/include/uapi/asm/posix_types.h:#define __kernel_ipc_pid_t
> __kernel_ipc_pid_t
> 
> So, we probably need to differntiate between platforms and use either
> abi_int or abi_short.
> 
> Helge


