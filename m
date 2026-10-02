Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70050CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfO4-0006Aw-3r; Fri, 02 Oct 2026 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCfNg-000683-6a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:41:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCfNd-0000su-Vu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:41:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FH1sV2751430
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 15:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gJujdyxy4/sbcQR1hKkpIC+WtQwZwyqE/WfWwa2EfAQ=; b=TbH7plamaRKF5X9I
 BzKfOH1fOUT0OHDY7Gm/hjDFMnvgw5XX13nd+FGdJHWV9gKfw1gkrSPYKP0TE7mN
 Fv/birZcIE8tASLDaA1VjdW2dyHSmL2eY+uozKjAZjeil9oSSVSermmxLjxEwrnL
 EKESgjgnl5pYg7igqOwA8V0u+nNKZSRjFXseiUcrK9KN42ZTyOp0J1iMFXS7E1JE
 BwMafFI1LNcOu9AaNtgZYsejtZTnCS8/Nve92mo+th5MaNimCodzdItK7yrfENTd
 1jCx18wmWz+qnSyXyRGBx6VKQfWiowibY8bS14eeSkRu/GnGvhxAz3C0fEdV7pKx
 +wv0VQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mt6ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 15:40:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so9278140eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790955659; x=1791560459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJujdyxy4/sbcQR1hKkpIC+WtQwZwyqE/WfWwa2EfAQ=;
 b=V5qBAKm6Tj7VixxARIuVnp9bKSzgWxBPbAHxekdioo7d2GwfKCk0YKMIp2OqF3nGJL
 CmIpSBk1lR4m3P/yg3O0pO/Oc8eJYTEFSNrdsNYEGWm+56Ygiir581k7c3QiISZ9kgAe
 pSio1yiMxbtpgrBymaDHHTpqGpZuSGcJT099f2nopGaE34rdXJvAqo7IlArl+ElvjHU0
 HnRONFR6sXJ5BuV01vb5bDGeUlRywic79lzOdVr6/2XrEfhUPX/NiF4ffYD13DqdNG93
 3aVFiEs0dCMg1tfAC2h5adcyI6tH6/W/21ySdytM7Y59pxN9vcapjGh0FMfe4NiTcRLR
 yekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955659; x=1791560459;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJujdyxy4/sbcQR1hKkpIC+WtQwZwyqE/WfWwa2EfAQ=;
 b=geGetIjg75o7kTyOV2jW5aF0Z4jAxAJy9JKhvwUGBNdySQ51Bdj0KuhLpJs4HyK5Ss
 Qg7TJPK5kB4hFck+ITfcMCLU8iceJkhoS6wIYk6XICCvf/qPslW3yTmtJPaT//bCwR3K
 G6xvZ7jsz4voJTSWKue2s94ZD1q0yBUgq2wnXpIdFr604228OiXc1BuFUeDZ3NiJ2W+T
 7+2Hw3hx5GJrOzpwHW6z68QRE4R5nUJj6RTmetWs8hedwEx64G4WsP19YlsxmdPEtdz0
 U23HnSIRL/yUnOgdaGV9rUnSX4/X2u/6jd/QLF5B1HoJVXf7hhsdpsgbqRwCcEgAnIKX
 rioA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgHux5glWeUJCAj6rnahu0JqecO+lsmcAl3OIW/jooIb294qmb5VBkVV1Kcg7UH003MxpfD4uCDT9g@nongnu.org
X-Gm-Message-State: AFq9FYIUgNLjpyDRorfZjtER26MSXyvF68GYXfBtzVEnXn/kTe3s1++R
 HFm8u+awcrOTINu+NSzY7sLuS0OKomwJ1mPv75MhQFOu2/1Qvj7W5i2nJIWD6zLJCKTWFylfNPG
 /ApFSQ0w5nVAvHUgY4pGmcUXNaczz0+t85OT4Emkutzw6cfsMRuYjvvv86A==
X-Gm-Gg: AYBFou3/QUIHXouec9Nj5JCWH6Ck9BzBMnz/D9m2xnnO49JBp/UE7Xa/Z94UoEtbJU+
 hYGOEuL2TZoG4arKLh1u0XxE43PRrfOZLw4PJPKZiKDfEbda3ho3yrnv5RU1HSHsEl4CBaDRMmX
 Jl0miqO6tvBYj713Vcc1J5MrGFJwMjIlA188KZe6fDVcvpXi4/+IGN25hzqVnNLt0n6BLxeuWTp
 NVC/W5MLfW43cRgGh4QtwlQYFjijfKAaX2u128RgjnCFZa8LkbzrjJ859o08klbnMeuOx9WzKPV
 x38U3r2WonmMF/YUEVoaOVNvoRDxRHe9dKxlOnlMRxeCbDRoVoC5LFryO2aLHHIqKpGPLHEKNpV
 0sDrDf+3JrB3dBTreyl8iY2+pm5pDzoMnDvNd1P4oVv9mJagI/a6RzgAndvwrLRPQQRG4ow==
X-Received: by 2002:a05:7300:72d0:b0:34f:364c:a9de with SMTP id
 5a478bee46e88-34f364caa85mr4700771eec.38.1790955658791; 
 Fri, 02 Oct 2026 08:40:58 -0700 (PDT)
X-Received: by 2002:a05:7300:72d0:b0:34f:364c:a9de with SMTP id
 5a478bee46e88-34f364caa85mr4700701eec.38.1790955657526; 
 Fri, 02 Oct 2026 08:40:57 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd9698sm7783723eec.23.2026.10.02.08.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:40:57 -0700 (PDT)
Message-ID: <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 08:40:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfX2Bo8/Y6k6Nqv
 BcO3UVo6lL2cVYX1g0c/LwNeoKogBHqeDkCE2UMiTG0pDQXeulfclOJRQ0PiXEm5iKHUkFYemPo
 ZzLza/yNyTN/YdjaVQjvAlGH49De1WY=
X-Proofpoint-ORIG-GUID: hdd5SLsVWDi86wUp6NbzZYVWywOIQfK5
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfd08b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=J7_dPglG0S95CWUX_rEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: hdd5SLsVWDi86wUp6NbzZYVWywOIQfK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfXw2bbHIqVo2YO
 9RSFLUAZfdnejSBazCvkhDWSdLqFkieHqCV6JpXHYdZOyNiEHNh68I9n+wsnso9K9VoP1uyiZUZ
 4yiSTFyTG/jb6n03b9lWwXwTeDIRLb7/4eJQs+jEJ/GDbZZKLpT9xSu7rM7QZfgEu7zppDqh0cv
 /ZuhqgHdowCgwnErolyYqP9EkYpRlhcOF7GHD7qcoXzQ3pHoOwianyaWl2bfvz6dNm4L0E0TFB4
 RNm3hHuCpP4HtwyQjkZq6Qo7kEJrfPu3Lrj4fREAUDkjqC4Mr4hNFqavkZdTo84VZpKX3GDLHIh
 0Jci+U0NEGyJQZcxnVGDPJGJlMWUAIqlmixVhHCNrh5Q/GK5SR+v3HDwz1ruoOJAifKkRFkpCH1
 dLf6vqQ0nKPPJomv6Q7QHQ3a1xrvJDvxKtKsye6z1VwKhimSRpou81llieYLBJl0Y0u8Y1TZ4t5
 K/wNMww37zwX2qTkKLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020062
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

On 10/1/2026 7:00 PM, Yonggang Luo wrote:
> On Fri, Oct 2, 2026 at 2:56 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/1/2026 11:26 AM, Daniel P. Berrangé wrote:
>>> On Thu, Oct 01, 2026 at 11:08:17AM -0700, Pierrick Bouvier wrote:
>>>> On 10/1/2026 10:40 AM, Daniel P. Berrangé wrote:
>>>>> Even with the current per-target binaries there are countless
>>>>> devices linked in which are incompatible / not usable with
>>>>> certain machine types. A new multi-target binary with a union
>>>>> of all devices will just be a bigger example of a scenario that
>>>>> already has to be dealt with for today's binaries.
>>>>>
>>>>> So if we have that assumption that we don't need to do device
>>>>> filtering, at that point, a --target option doesn't have as
>>>>> big of a role to play. The machine type code knows what target(s)
>>>>> it wants (1 or 2 targets depending on if there are 32 + 64 bit
>>>>> varaints. The CPU model the user requests (if the CPU is not
>>>>> hardcoded by the machine), determines 32 bit vs 64 bit.
>>>>>
>>>>
>>>> How can we deduce this information (bitness or target for existing
>>>> machines/cpus)?
>>>
>>> It would require that we introduce a new field in MachineClass
>>> that returned that information about what target a machine is
>>> associated with.
>>>
>>> I note the SysEmuTarget covers both 32-bit and 64-bit variants.
>>>
>>> It might be better use QEMU_ARCH which correlates directly to
>>> the TCG targets, rather than the traditional binary target
>>> names ?
>>>
>>> Likely the CPU class would also want to declare its list of
>>> supported targets.
>>>
>>
>> QEMU_ARCH only represents base architectures, and not variant, so
>> SysEmuTarget is the right choice.
>>
>> So, we would need a list of SysEmuTarget for every cpu/machine that is
>> target specific, since one could be available for variants of base arch?
> 
> For this, adding TargetInfo parameter to is_avaible callback will let us get the
> list of SysEmuTarget for every cpu/machine. As we can iterate on all TargetInfo
> then check if that TargetInfo is present for every cpu/machine.
> And indeed for devices if you want. That's what my patches are already done.
>

@Daniel: would that work for you? I feel like it limits the way to
introspect qom objects, but maybe not if we export the right thing on
QAPI side based on that.

> And also I have an idea about the set is_avaiable in an easy way. As
> QOM basically
> is a TREE, so for example x86_32 and x86_64 can share a same "i386"
> base, all children's
> is_avaiable inherent from parents is_avaiable, we can ensure every QOM
> object have a
> is_avaiable by update children is_avaiable from parents one.
> 
>>
>> @Yonggang: can you try to provide a RFC based on this, to see what it
>> could look like? No need to cover all machines/cpus, just select one of
>> machine+cpu, ideally with multiple SysEmuTarget (like virt and max cpu
>> for aarch64), and let's iterate from this.
>>
>> @Daniel: how do we deal with machines available for all targets like
>> null? We would need a way to ensure all machines/cpus are tagged
>> correctly, in an independent way from "available for all", without
>> having to repeat all existing SysEmuTarget.
>>
>>>> Also, how to deal with devices that are only available for some targets,
>>>> but not others, depending on various Kconfig knobs?
>>>
>>> IMHO just leave devices to raise an error when passed to '-device'
>>> if not compatible with the requested machine.
>>>
>>> eg this example from x86 world:
>>>
>>>   $ qemu-system-x86_64 -M microvm -device xen-disk
>>>   qemu-system-x86_64: -device xen-disk: No 'xen-bus' bus found for device 'xen-disk'
>>>
>>>   $ qemu-system-x86_64 -M isapc -device virtio-net-pci
>>>   qemu-system-x86_64: -device virtio-net-pci: No 'PCI' bus found for device 'virtio-net-pci'
>>>
>>> Hopefully most devices have sane error reporting when they
>>> find a dependancy they have is not satisfied by the machine,
>>> but if some end up asserting with crashes that's not a
>>> blocker. Those asserts can be turned into pretty error
>>> messages at our leisure by whomever cares about improving
>>> error diagnosis.
>>>
>>
>> Fine for me. I am a bit skeptical this will be possible to catch all
>> issues, but let's try!
>>
>> So, for existing binary: -M virt works as before.
>>
>> For new multi binary:
>> $ qemu-system -M virt:
>> Multiple machines were found, select one among:
>> - aarch64-virt
>> - riscv64-virt
> 
> This would be very hard, that means QOM must be initialized. but we need
> ensure the target is selected before the QOM init. it's the current
> qemu_init workflow
> A possible solution with add TargetInfo parameter on is_avaible is
> that we can listing
> all machines that named with virt, and listing which targets support
> "virt". For example
> 
> $qemu-system -M virt:
> Multiple machines were found, select one among:
> -target aarch64 -M virt
> -target riscv64 -M virt
> 
> As for qemu-system -M virt:, default to none target. That means all
> machines are registered
> into QOM, so we can list all machines. to help us identify which
> targets that those
> machines belongs to
> 
>>
>> Does it matches what you would expect?
>>
>> Also, for compatibility with existing binaries, should we accept -M
>> $arch-virt also? I feel like it does not hurt and would make thing
>> simpler to switch between existing and new binary.
> 
> Same reason -M $arch-virt, indeed like -M $arch:virt,  but $arch-virt
> would be even harder.
> Because "-" is a valid separator in machine names, ":" is not a valid
> machine name.
> So without init QOM, we can not reliably identify "$arch-virt" belongs
> to which target.
>

From the conversation above, Daniel and I are not in favor to have any
kind of parsing based on this string. So either we'll pick virt, or the
real qom name, but not anything else.

>>
>> Regards,
>> Pierrick
> 
> 
> 


