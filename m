Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB71C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x958u-0004yz-SV; Tue, 22 Sep 2026 14:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x958m-0004xJ-Vg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:22:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x958j-0004YA-Sp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:22:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI79i81024453
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fCrfQz4hWwqytU6nqTs/jP06zcEpapYrO+arjSgJNnU=; b=gCB+o6lxrQvR/gx3
 w5qORpGIfLkUTPH8vGnwxIloSUaBw5B1rFTlt1hwMkodxRVp7ynP8QvwNwOEReS0
 grH1k1Y5QVpHVKFvHcrYq2ZaF4M39f2x4EcwtyJAgJUpZvhtijYU8HARQEhddZ50
 r5TrzGO3ueiRD1ZHeTPBBGyZzwfeLKe1wwsqplomK5dqN0c23Ra+FR4fZzspBB3v
 tYtlmkSHk0Z9LgRwnW8Vf1yvIBvEJVTXYKEJadzJc6LN1/4YfjLGg7/gIaxQBB/Y
 TaLJbuI9I4vKP5CgwMOGDE0iiYVNM+MQQ3X3NjyOb1LE1dCq5+2wFz8A1nxBZLdZ
 uvGgnw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkjbr3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:22:47 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso146081c88.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790101367; x=1790706167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fCrfQz4hWwqytU6nqTs/jP06zcEpapYrO+arjSgJNnU=;
 b=dTcSw1pZCdodxbexWIAiGdo88K1lV0G5FOUu61fBhIxHfif1gZ7OhfCOy7BDjiH1Yg
 GZ8atwwS9Lra+delO/83jNkwyqijjsDTYHzuf2NrFSTyp0ZHWkQkcjzLNcPr5g/uK+ll
 zGBzbZeUK4nVSWYzxgjl8RiUUuWgPXvx31jp1f7X6wBNUwsCzUPAoPFn4aEGKodAKzsb
 ZZLWzTz3WUvodIHuQT5eWnwUZljqrHI/ORJ80+W7K+Sn+TBpmnL7PhwcoIYWNLtmRrlt
 z2LvEFNOM6sXdOt30mXEVYgpMXaLLibXc86chS7IFPQ2f/0CIFA5jAa4EXMdabzupaI4
 dBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790101367; x=1790706167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fCrfQz4hWwqytU6nqTs/jP06zcEpapYrO+arjSgJNnU=;
 b=BNMckuAVvaEQc1WLS0thIa7w+XQlBE3C9BaMirJpKQY2/oRBDpDKaG74p50kbhbiHn
 QYkL068YA5ixL7ikiPQ5zpjfPNj6fyj61KU1WBZQ9pkpye0x1TpiBDdUYkuGM/Nat871
 OKdA3mn02IguPgCuVV0FLK3la9hebZ4aHtwmvZmF6RA+ZL5aj2lkwZeUG1tXvFCMkpyP
 DYBbMS8D+GcX19ZMMBCmyd2UfD+GidBGPRTnH/oyAWdQWcif82N/3c23i7kg3DEKby7M
 HVbBBP+L+3g2DVzUDfyRyHKB80u2+5Tynzpxyu6vXyT8eZ6P4Itti6ljwHmwFXSHlbfM
 P59g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFDuK+w74mxVVuXbP4R05g4/Km/Tz+s8weUbJwJ4/bTRJMkQBrgcY5/di0xA2Ne/hcgdA+MEND8O/w@nongnu.org
X-Gm-Message-State: AFuF++ltrEqOW2nUguZ4jC0YiDcjIThtRf8TybRVGrwwhQvBYSy8b6ic
 +oGNdEkCazvqVqbtwTvWzOb/a8cC2Jix3+cySLxllpF6FW0wTO22itNaGtuzK6iEwUuHoeYjE3N
 XmqWC10w9HhZ52XaUuTKFutsY0BfO8sjGkOfcWXcvZyB9lGf50qrOSoEVlQ==
X-Gm-Gg: AYBFou2K05aY/uudZZR0MfCl05QTyQzmaDqJY2MNsVkf6XC7GwME98T4KbjV7MvmR/C
 KCLbTH3yo49zxBFHo7Okz4SHcESIal5zZh2Mp7FMDURUMa3Pnk7amvZ4tu0o5/zyzSWrHM1BL6z
 5NrccT1FLhaC3gsSOmyf/6GzgzYzryTPyRhxkybqx/3DVcOywLWGAWfryyeyTo4v/YUPVLSZKYt
 VXuoHp0jP3dAmPkHYMuWxVAgwlBE/pmB6mmSJq8MrFPdVjd2/jzqFKAbvQgu526unmBjQFuLanE
 UIOD+78wJQYqnT25Ul2eHlsu/T0hygwx1BhaoYFeQVu322yaVVRgU4U6ouM783SFl00dxQF9Syz
 EHDcva18NUg0eBgFdjMmooCXUSLTQVMXDzsNAMJp7l8MFyT2qCraen0rf8pe7uisl704=
X-Received: by 2002:a05:701b:4243:10b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-144f90a6921mr237564c88.13.1790101366438; 
 Tue, 22 Sep 2026 11:22:46 -0700 (PDT)
X-Received: by 2002:a05:701b:4243:10b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-144f90a6921mr237522c88.13.1790101365674; 
 Tue, 22 Sep 2026 11:22:45 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96e48e3esm50310eec.26.2026.09.22.11.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:22:45 -0700 (PDT)
Message-ID: <e97e1bb5-80c6-473d-b890-02f3cf9d0661@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:22:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/lci/refresh: add parameter to override
 container registry
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
 <arLBBjS_T40wBa3X@redhat.com> <arLDQHOSRX-xcJum@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arLDQHOSRX-xcJum@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lcaURUnUQ9y4-gHjhS7aFL_mIv4Yiioj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2OSBTYWx0ZWRfX0k2TLTw/Aetw
 PHhpwQWczO3YgxbW8ZXLynqeEIvTgm5aYimFHVczSWL98ipDqlhjw2zro1WSbuTmojA29gkuH1M
 NxKjgXkxh9UsuAXk1bDW9AiK14yV6s88IQNaguqPlMwuoqU/WqE3PoEv3AqhxpPEf09csqlT5C0
 jVgCpd1jyEHItRsqWn0osTAuZztPmjdWjp5X2H5VcqU9aMnjCXtdxEtQNAH3pCNGa3EbUDkorHA
 hYusXfHvBqNVW27+ygdfFeY7R37OcWI3kUaxW6w8sB/eF4ieeJZ4f5WDOLaUK/HivNixcag3bK6
 d8DB+mIAn8DlaS1kNpMCaVVrWgH+vj6+QLwoj4Ga+EeHIL2MDssFSKl1bpNOxSymga3T64XdZ0V
 yjxIrDlvJd3MmCIyGwrIp2SWEY3Vwjcq0aih5MYR4Sj71HS82/FNQLKHpNCTP6aeub/oeXj55km
 GQSI8G4lgVLjof9VRNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2OSBTYWx0ZWRfX90gwYzbE3qM3
 DvX9Ny4oGpd9itUflsUrJ0u7zKYRbZpjysY0l4QmCJYdO0VaDZqwYC0BOg3dFwQfs/p7hJ5RwRR
 dczKMxeDPXRlJzxANqxDPUtLZWldGhw=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab2c777 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=sjTsM2-9bFLMVsgo9ToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: lcaURUnUQ9y4-gHjhS7aFL_mIv4Yiioj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220269
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

On 9/22/2026 11:04 AM, Daniel P. Berrangé wrote:
> On Tue, Sep 22, 2026 at 06:55:18PM +0100, Daniel P. Berrangé wrote:
>> On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
>>> We'll use this in next patch to switch FROM docker.io/library to
>>> docker.io/amd64. It would not make sense to add a new target to
>>> libvirt-ci for this, since it's just a variant of an existing target.
>>> Simply replace container registry with arch specific one.
>>
>> We shouldn't need to add new targets to lcitool for this,
>> rather it would be enhanced to include a list of arch
>> specific container images.
>>
>> eg in
>>
>> https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads
>>
>> We would extend:
>>
>>   containers:
>>     base: docker.io/library/debian:13-slim
>>
>> to allow for
>>
>>   containers:
>>     base: docker.io/library/debian:13-slim
>>     aarch64:  docker.io/amd64/debian:13-slim
>>     ...more...
>>
>> such that we default to the 'base' image name, unless
>> there is an arch specific name defined. That would be
>> a fairly quick extension to impl in lcitool.
> 
> Quicker than I thought.... take a look at this, which
> I think will enable you to drop this patch and the
> next one and get the same end result:
> 
>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/588
> 

Very quick indeed, good job :)

IIUC, when no host-arch is given, we keep on using base, but in case
user specifies -host-arch, in this case we use one of specialized image
(if available)?

> 
> With regards,
> Daniel


