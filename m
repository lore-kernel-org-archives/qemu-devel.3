Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D59DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2ax-0003fQ-R2; Tue, 07 Jul 2026 06:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2aw-0003fF-Sb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:00:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2au-0005jp-VD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:00:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E2dx3070557
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e9Xuxgnc/hkdvHIGalVyYnGExe+E5b/Ksy4NChP01Cg=; b=NcUMeRatK6OD/+jy
 kfNASlBf6XlT0gwVCX0KllAKN1f4oPRpq73l48ouSnHT489XTnNxxkGfqMYwsNfn
 51DqV9olVRe7kduChgh91oyD2tMCFe+0koXVC0tzA9lbG21omaBMqmo/3Itf0wAw
 c6u7vcEQcyF+tSINdIuVSxqMiOqjLt/h7qHsTyP0BfQeI9kT0dkiDlUlFmONhUQz
 sYR9BI2JsOR1OtH02n/1QobXWEPmJ2RklBe701mbLyShr+EBc5tEth9i2i9mAUdJ
 UB0GMYzYGqhoNwDk3WSg5pGWieNT+XYsnMhK1pmkXsVzVx0hp596+JqiJ0OYcqYX
 e9prQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8hdhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:59:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so36919061cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783418398; x=1784023198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e9Xuxgnc/hkdvHIGalVyYnGExe+E5b/Ksy4NChP01Cg=;
 b=cT3iUalt91hRnNlIKUYlMCAX4cr0eDI+eye62gKenpScd5dah9WiB3L3YizhF/Megx
 hCga3Q5K75ySyiDxsYPC/5UbsU8sKvPRyxTlMDIM5wTw7XOjKjPwgzxzD6gpS1Dy3+zu
 mlnD8Udi1gaMyrstN3MohtcVd8itnmys6WGh0R3II3lnJ2z4zU0HjqZA72I1H747c7L/
 3JKcTxSoue+UMtabjUNM87+pBcDXP0Sdq2l5kuOOqZOGFxx5ctRcIRa4adVHjwpZt99Y
 odTZSasRVmvW+AOwGCI765+xYrD9Grskosb492vm1aSeTHDhsDwVfIzN8U5DMugxJ5zF
 vIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418398; x=1784023198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e9Xuxgnc/hkdvHIGalVyYnGExe+E5b/Ksy4NChP01Cg=;
 b=Xmzc9/KiWXHnij5VkpQLrAfPKwmF5nmNBp7wsjPMm0MgDwGlOEzdssMjNcMiSsDI5P
 fNabGPzhrNGIzCI9qbbTeOw3NhgSmicmlh9bG1yZ6ZT2+7dM+hV4rVhj9dv3LeW/YDav
 HjwZ1/YE2TqgebH8ShTOu9jSJ6Ji7LsiKQNDrpW1cbKKfUpyXKlhHtDtTyZLrKNjTgv5
 kidR0VN361Iz0qJInCW6x1VoatPI47SxRvmMDPXqx57Qu/4uM32VTggmh9yo2Er25WkI
 Rhi4aKvtihBDY8t/jyx6y1ZoFYDBjw2ND1aNwVcDr1kmRBAgoS6rLBkyNe/md6kdTnKh
 9vag==
X-Gm-Message-State: AOJu0YzBejiyYKfLfCWb5aukhEVFE9EXuxkfhmYACwbSYV5hUSVCYKi+
 tkKOI+b4gx/aI5QDVsTttN2x6l6McoIxaPrEOl8diRy5QJWQ1kaEFip8XOcvVkHZZdYLFanuLjN
 wxK7vCeT55jUz9/2kAieBxSe4u6HLBA7bAWfjGExtplXM+jHP5Ikxg5ZBJQ==
X-Gm-Gg: AfdE7clyGjO5GXKC2WvJyiCqn60BXQCysqRvxSWTDN5xQXRolrehVzWR1h1zcjJQDTg
 aNww28ijqXhoVWZIos1OJkWsqikl/Suc5cUg8qWRS2SoLZ5aD/TftZCyXDsoHJMjCJFCNy0klLO
 ruSnnI48LvpX10Gvt/RYq7Wdr4pJyMYq5UJfgqVq2UkKdaqyTeQmSanU8FbJmgru+W31t7aEuo9
 JEogxMOacgdZfOs27pDolXcz5VpxPIfXuVzr+NTgaq6RMm9Zb35isGNizMS/9Uz2i34NpE5D7Dd
 D2Yjl8nhqTcZwSTckcfcxf0behIWCgKlHrnZ7AbhYX+OOWrxCS7+lde7tyFP5UGFf/mSVR/hLtI
 SNjap1InY6lTb2Ihhd324tdgftCa242xBQ7EFNTP/VdBgWh1T5XqaNt0ln6RhvA==
X-Received: by 2002:a05:622a:1108:b0:51c:10aa:9cd with SMTP id
 d75a77b69052e-51c748b7fccmr46205371cf.38.1783418397665; 
 Tue, 07 Jul 2026 02:59:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1108:b0:51c:10aa:9cd with SMTP id
 d75a77b69052e-51c748b7fccmr46205231cf.38.1783418397213; 
 Tue, 07 Jul 2026 02:59:57 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cd8971sm5412738a12.5.2026.07.07.02.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:59:56 -0700 (PDT)
Message-ID: <c7828107-d2c8-4cbd-9208-dcc637161597@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
Content-Language: en-US
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
 <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
 <B737D5FB-43B3-478D-BD78-E5A2A8296B6A@gmail.com>
 <693c31c8-a3f9-4cd2-8374-e4638ff34d92@oss.qualcomm.com>
 <7580A0A6-4937-470F-99F8-0B94163D7B54@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7580A0A6-4937-470F-99F8-0B94163D7B54@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX/nN3VnVzimmb
 nJld86F/uoSmZ5f1yYzujEWliAZDEafva28KMw46nSy11y0d0xKy5uLhpKkEfSKrNyS3gzDAtO9
 KZJBpNa2oCzbKGM8FGyOt09dDemsmFj5AZqBdSW+RK6fn2N3iBIGVYa/qb2h4iaYdjM/+3vqKhV
 FlNuZWWpP0Yjgltliz1kRDn/6ziTIn8gAOu2ev+hEz3kINzRyuk9fg8JAYGC0LZQ8Mmj/2GGc5W
 qN9Zs6sKJ7r80opAxD2ez2FIZUoMOfMjOzqn/3X/8xOgvfzppvu1/2mw6MYtR9vJ8Tm07SIbU4R
 ww9egxl4+j2iY0WHBh7RxNgO1fnI8F14rIJKmtHo5N0rInrU0DzhylaeYl+cltmZ8acXLWPzXmZ
 p9Txa3Ou1Bw+yUwgA7wNwDoAC6gM3iO90xdfj/4p6HQ+hT20dcViwdZYV3bducIw3qtn7ccpN+r
 2eBXivBylLgWPXXNlYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX0uqSgzu6M+2j
 qYshBS0A4Z3uWhQcAxF8V3n2jE64O5SvF6A39I1IfqtHZUqEIKawE9Jl5oufqjPnW+kCPU3F3Ls
 YE1PRV8bCK+HHxWw0IKkqOoT4fwJyJQ=
X-Proofpoint-GUID: jhJYbIeItopeFkyakDpGXPJ2sV76YVT0
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cce1e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=iBIrPYHYYzr7e6Et5HcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: jhJYbIeItopeFkyakDpGXPJ2sV76YVT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/7/26 11:54, Miao Wang wrote:
> Hi,
> 
>> 2026年7月7日 17:50，Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> 写道：
>>
>> On 7/7/26 11:01, Miao Wang wrote:
>>> Hi,
>>>> 2026年7月7日 16:57，Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> 写道：
>>>>
>>>> Hi,
>>>>
>>>> On 4/7/26 21:50, Miao Wang via B4 Relay wrote:
>>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>>> ---
>>>>>   qemu-options.hx | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>>> index e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d18795dde9a7 100644
>>>>> --- a/qemu-options.hx
>>>>> +++ b/qemu-options.hx
>>>>> @@ -5164,7 +5164,7 @@ ERST
>>>>>   DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>>>>>       "-enable-kvm     enable KVM full virtualization support\n",
>>>>>       QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
>>>>> -    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
>>>>> +    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
>>>>>   SRST
>>>>>   ``-enable-kvm``
>>>>>       Enable KVM full virtualization support. This option is only
>>>>
>>>> Isn't the legacy option for "-accel kvm"? (Apparently since commit
>>>> 303d4e865b7 which is from September 2010). Maybe we should get rid
>>>> of the '-enable-kvm' use in examples / scripts...
>>> Yes, but I noticed that there are still users of it. I believe that
>>> either we can fully remove this option or we should enable this
>>> option for every architecture for which kvm is actually supported.
>>
>> Why do you want to add this legacy option to an architecture which is
>> newer than the new CLI option and don't even need it listed at all in
>> the help message?
> 
> That's because utilities and scripts may expect that there should be
> an unified option to enable kvm acceleration. "-enable-kvm" might be
> their choice. However, if "-enable-kvm" is considered legacy and new
> users should switch to "-accel kvm", I can accept it, not moving
> this patch forward.

When qemu-system-loongarch64 was introduced, "-enable-kvm" was already
legacy and "-accel kvm" was already available, and "-enable-kvm" has
never been listed for this binary, so I expect the users to use the
correct up-to-date syntax. No need to confuse them.

Thanks,

Phil.

