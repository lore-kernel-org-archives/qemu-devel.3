Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF42C5DF90
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8He-0007A7-OH; Thu, 20 Aug 2026 15:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8Hd-00079z-HX
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:18:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx8Hb-000488-Ru
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:18:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ5uS3259524
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 od0qSHE2yqPzMWteSnZBAO6hS2vY8gDnB/9e1egKM/I=; b=hFU2kRL9i5lXyEyW
 zfmhrKhUf7pffLXpa+hnpkpNXTLxsrDRfN1mvz03TmZwleefQIpaI8m+dxCNcjns
 0lBeHrVJzh394LGx86ZsWVDgV1La+XJhTiLQ+fM3yIg6virNKOSLk6gL0HszY3yM
 2QrshNYBBsP7i2M+A78kl0UcExs9off5Q7gDOSfvQ3WXw7eWWtUHS7pUnWUdpxPA
 PXxUyVZ7snXRaab+guYa0YNZ6XxyBfAxvOdTCEsRCrgEbH2UkGmuyOJl1N0vEhFZ
 Q+1GhHwSVZjoIQg9+x7OLSqC4k+s6OnIIxhhoXoMX2+5ncWNlvxNzggrsSd/Rq5J
 4yx6hg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcafd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 19:18:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso180203a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787253512; x=1787858312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=od0qSHE2yqPzMWteSnZBAO6hS2vY8gDnB/9e1egKM/I=;
 b=H2WZpB3/lI10EJ3wTRi4OhYTz8o56Uo17xxEvuVhwyhBckX+MJnAkGPOSCo+zE8eAx
 E8DoDpj8Ii10mVjwcZsOxnVrJj4Ht8uoXetwzxA3uG0anewuHlnX4LuJuzL9ByRCWyiq
 y4Tll00yxXGM+9N50Tag6J6mrjN8k1rqp5lJzNOD9KFnJxeHDhfGXjuKnZQf77CW5lOG
 PjVDmNpmnqFUCDj9Vx7HMEmU00/kLbrIOvQL2GCqlWGjRdDzCWowG3bPIEuHSblWrUQS
 Zg26JBT/rMjeQMUmeTgpPmgACgKWPlOVcoY86gXpKxQuM+YN4eqP+fz4tkZQ0GCHVK1x
 GhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253512; x=1787858312;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=od0qSHE2yqPzMWteSnZBAO6hS2vY8gDnB/9e1egKM/I=;
 b=s+txZ4jpWwMCuKISp/EGzbGMfNEgfDm6ESXYyjM/n8Ym+5MaBfN9jBUR04INzb6dA9
 0JBTaEJO98m5Hl0tykwAF2So3CWAtgSw3tqjF/qq7bvvNSiv+657yZwhx5/4Sb+uzqjM
 M/aXBAgeGPBBE48/7HZHilgSzR0vxavlFecwWd57ywFbbWSPj7E1o4iaAmA/ye4dyp3g
 e7pEOE+WWtjPqzeuc2KkrxKVtzcEXw1SM7uE0G9OCEwMLiSlaKYE4mJ8aOB3cv9HXKVU
 ZKA2Geuxv4Qoh2u0vc628svYk3jco4tGk2l5SncLY9z/9OoQKXdE9Rif3dk2v2GLwtMU
 TTbA==
X-Gm-Message-State: AOJu0Ywx3dSUS85TbMLvjPVtIcC8Ez9OTKob9h10G2psftGDsy0bD6DK
 xArlSki3yQSSYmZIh41cEMAGmR0z/+E5hnU/pgaptk3UNttrXfZCZWyxZQq6LAS8FFufpBp8dHe
 Gz9S7o7NTyL6gLQ3cbr2s7eatk0YG7ijsVLmLRXizPcj88aLoqUPmGdom8w==
X-Gm-Gg: AR+sD12QJD8adMI2T9GQpeI79NikXUMAGDMtPtAISC+XOscpfrixGRu/dSkJhMT6Ad9
 g/vLH4dr5ao7lRtTYeUtcouTEIZUnFnWDvAiriyUgB1CfXcYCSGh6J/mEEMq1u86Op9H/qNo97v
 JgxMppwLPcq4Iw1RwpdR2dapdgkTZPhLTPk0GO1HYdj+IzblCL8PQEavdt35Kd06WX2pK5Ua7JO
 nSk9D30wMCef4oNspOSLlTRelGRjWeLzPmkAzcUfXAXq3j5SOdUkupfRWGJrSADLl7MxRU33aE9
 H2e8XAXGtSNriMrRQ5HG1dcNkqIfPbaMye4eATW1O0ZSwlKKLAKYNVNuvWkBlqCO19etzzQIsK2
 KKGlXEjx8cjGCx0uOm8fbaYqMOHotMAgSHQGpBQc2w1G5XgX0SiEuccFdMC9gg7fBs1Qh
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3cd300f9e23mr1141690637.13.1787253511979; 
 Thu, 20 Aug 2026 12:18:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3cd300f9e23mr1141572637.13.1787253511358; 
 Thu, 20 Aug 2026 12:18:31 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cb5a9831sm12093805eec.21.2026.08.20.12.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 12:18:30 -0700 (PDT)
Message-ID: <a5860c50-9839-4b46-8b36-0e4f4ea3c130@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:18:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 <87y0e2p4hy.fsf@draig.linaro.org>
 <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com>
 <87ecfsppz4.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ecfsppz4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a875308 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=d_KQdfHxzRVXM6GcV8AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NSBTYWx0ZWRfX3PpY5NAteKSB
 Trluph0uM7kkN0XU6hMhWei8BXtZlrdV3gFSWhtutdSAcqfmosPl0QNpldwDRiEGi4/bFO5V0cK
 GO9Qw1mkkxIQs0wE528AlaroefrvoKVIobyS3jf7JA1vYJXA12bv1YQUDiCRCAOEZ6Z9VYINnVY
 8j94H6WCtJiDoXVgjUxihV+tCU6vo7njr16AF+h7OtCVwUwZCyFgZnLi7F/3pN1U3Y3bBYRkKVq
 FS4Nnf9C0OiB2YeO4IXIxxjuhsPWJD0W5V/5leI5E3o8oykIJIZvWlG3ud1/8vzu7p6NrMvAQ0y
 RCEdu5el/Yd1IoTi4of/YX2P0malS2npGD6mLT6esiyZN8LD3bTFaD8X27IcQCx9bqy92p84bBl
 S+SPPL8NGoZahBUYMEe9gLNAjIJLGueybIVgzvrZBsLplkguiI1R2Z/q53pRLFY9ptRccDCYQFX
 g/nuBnLtj34fnRCQ5eA==
X-Proofpoint-ORIG-GUID: NKDZYLsGYuFJLov9kKFHDD0oTThb2r3i
X-Proofpoint-GUID: NKDZYLsGYuFJLov9kKFHDD0oTThb2r3i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NSBTYWx0ZWRfX4mo48pi9HtgN
 m97WU+2v2DqzE4NJIBKe9MvtOTj5InzCPs/+5ACN51Zhs0RG9fLNhJgSp2YB7zc8e9QTBStIxye
 Rxt79ne7ItAtL3zCkqG17HWORspNUIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200145
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

On 8/20/2026 12:10 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 8/19/2026 7:30 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> In the next commits, we'll port each architecture from Makefile to
>>>> meson, and it's easier to review those changes if we remove Makefiles
>>>> step by step.
>>>>
>>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>
>>> Acked-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>
>> It seems like you are the official maintainer for
>> tests/tcg/Makefile.target, thus I'm not sure what is the Acked-by
>> semantic for a component you "own".
> 
> It means go ahead, I've acknowledged I've seen it although not looked
> too closely. Generally when a maintainer acks something they trust the
> poster taking it forward via their tree/pr.
>

That's why I'm confused. In this case, I expect you will be the one
sending PR for current series, as you maintain tcg tests in general. It
can't be me, the poster, as I don't have any authority on this subsystem.

This series will have to go at once, we can't delegate all architectures
bits to sub maintainers.

> Given its a temp patch for the migration I don't think you need worry
> about having more review on it.
>

In my mind, it was expected (ideally) to have a reviewed-by on all
patches before they can be taken to a PR.

>>
>> Do you expect another change to be able to send a reviewed-by?
>>
>> Regards,
>> Pierrick
> 


