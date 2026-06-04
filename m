Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AA7CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV2K1-00058C-Kp; Thu, 04 Jun 2026 03:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV2K0-00057x-4k
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:16:56 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV2Jy-0002mu-C1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780554671; bh=FGQ+9wLfv/fe+fNlyG0Hd1+AUzlhQzADbpRIn9HoCyg=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=K0/weJuMULJ/6VzANEfRpWVNkJlE2AibgxBY9QRuYdVFXCQMk5pEg8femaKXgEcGB
 TClZnLHusL1bPwHAnyzs59qFChezxmYdvuKE/J0Hr2lpiQGrSIaNSGhSbayat8vtfT
 jyLXo3Mp23yugEkDswFhu6tBCfrEqN/P6kfAotx8=
Received: by be1-5.in.mailobj.net [192.168.91.15] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 08:30:47 +0200 (CEST)
X-EA-Auth: 1eRntmGuTuXUeGSUH/xu4UQmBdTMeZjghKh5V+pOrc46AtD+izPCj7KYl2TYh0PUeglvtWruob+YWF2CdBuwNFUMJlRpesPK
Message-ID: <1d2381a2-7101-4039-b41a-d4cccbade4aa@mailo.com>
Date: Thu, 4 Jun 2026 08:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Content-Language: en-US
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: qemu-devel@nongnu.org, gourry@gourry.net, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
 <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
 <20260603151443.612d0e61@imammedo>
 <c7c8e578-86eb-4b74-b63b-6b81a76c4329@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <c7c8e578-86eb-4b74-b63b-6b81a76c4329@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 4/6/26 05:35, Huang, FangSheng (Jerry) wrote:
> 
> 
> On 6/3/2026 9:14 PM, Igor Mammedov wrote:
>> On Wed, 3 Jun 2026 09:45:28 +0200
>> Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>
>>> On 2/6/26 14:21, David Hildenbrand (Arm) wrote:
>>>> On 6/2/26 12:02, Huang, FangSheng (Jerry) wrote:
>>>>>
>>>>>
>>>>> On 6/2/2026 5:36 PM, David Hildenbrand wrote:
>>>>>> On 6/2/26 10:44, fanhuang wrote:
>>>>>>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory`
>>>>>>
>>>>>> Very nitty: but spm already includes "memory". And I think most 
>>>>>> things on the
>>>>>> cmdline use "mem" as abbreviation.
>>>>>>
>>>>>> "sp-mem" ? or simply "spm" ? Thoughts?
>>>>> Good point — the duplication didn't quite register when I named it.
>>>>> I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym-only
>>>>> pattern.
>>>>
>>>> Best to wait for more feedback :)
>>>
>>> +1 for 'spm'
>>
>> I like spm as well, but it's a very short acronym  and /me/ uselessly
>> worrying about ambiguity and future name conflicts.
>>
>> perhaps: sp-mem would be better in that regards.
>> Confirmed — quick grep on master finds "SPM" used in four unrelated
> subsystems already (AVR SPM instruction, s390x spm instruction,
> m25p80 SPI flash Status Protection Mode, AHCI Staggered Power
> Management). Bare `spm` would land in noisy company.
> 
> Leaning toward `sp-mem` as you suggested. Concrete before/after:
> 
>    cmdline:
>      BEFORE: -device spm-memory,memdev=m0,node=1
>      AFTER:  -device sp-mem,memdev=m0,node=1
> 
>    file / TYPE / function (after also dropping the redundant _md_ infix
>    per Philippe's KISS suggestion):
>      BEFORE:
>        hw/mem/spm-memory.c  TYPE_SPM_MEMORY  spm_memory_md_get_addr()
>      AFTER:
>        hw/mem/sp-mem.c      TYPE_SP_MEM      sp_mem_get_addr()
> 
>    QAPI enum value:
>      BEFORE: 'spm-memory'
>      AFTER:  'sp-mem'
> 
>    Kconfig symbol:
>      BEFORE: CONFIG_SPM_MEMORY
>      AFTER:  CONFIG_SP_MEM
> 
>    struct + cast macro (using OBJECT_DECLARE_SIMPLE_TYPE per Philippe,
>    since the class struct is empty and can be dropped):
>      BEFORE:
>        OBJECT_DECLARE_TYPE(SpmMemoryDevice, SpmMemoryDeviceClass,
>                            SPM_MEMORY)
>      AFTER:
>        OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)

All these changes LGTM!

> David, Philippe — any preference between this and `spm`? If sp-mem
> works for everyone, I'll respin accordingly.
> 
> Best regards,
> FangSheng Huang (Jerry)
> 



