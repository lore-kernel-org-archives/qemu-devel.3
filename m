Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9EFCA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDph6-0000pI-BD; Mon, 05 Oct 2026 16:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xDph3-0000ox-MC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:53:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xDph1-0007Ar-Fo
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:53:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 11EAA5832C9;
 Mon, 05 Oct 2026 22:53:46 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ut01Cyq7Vdv4; Mon,  5 Oct 2026 22:53:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3C2D583229; Mon, 05 Oct 2026 22:53:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D16AD5831F0;
 Mon, 05 Oct 2026 22:53:43 +0200 (CEST)
Date: Mon, 5 Oct 2026 22:53:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yonggang Luo <luoyonggang@gmail.com>
cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
In-Reply-To: <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
Message-ID: <c71b5f00-3808-9037-cee3-2c5df5007550@eik.bme.hu>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-887397917-1791232605=:85234"
Content-ID: <cb0576f7-a2ec-391d-a98f-ffc653f58f12@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-887397917-1791232605=:85234
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <d3175bee-5fa4-85be-c175-f2ed0573fdd0@eik.bme.hu>

On Tue, 6 Oct 2026, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 2:52 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
>>> On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
>>>>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> Ok, but I'm not sure it answers the why.
>>>>>>>> Could you explain the benefits?
>>>>>>>
>>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
>>>>>>> The following original code would return -1 for some user-binary
>>>>>>> +    SysEmuTarget arch = target_info()->target_arch;
>>>>>>> +
>>>>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>>>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>>>>>> +                               &error_abort);
>>>>>>> +    }
>>>>>>> +    return arch;
>>>>>>> So basically assigning any value for the user binary is valid.
>>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
>>>>>>> -1 is another option but easy to confuse.
>>>>>>>
>>>>>>>
>>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>>>>>> "target-info: Statically initialize target_arch"
>>>>>>> doing that, I am not sure.
>>>>>>>
>>>>>>
>>>>>> I guess there is a (good or bad) reason for which sub variants of
>>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
>>>>>> that before doing any change, as it might have other consequences.
>>>>>
>>>>>
>>>>> You’re right to ask, and I need to correct my earlier suggestion:
>>>>> leaving user-mode target_arch
>>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
>>>>> code shared with user-mode builds,
>>>>> including cpu-max-v8.c, where its result indexes a two-entry array.
>>>>> For aarch64-linux-user, the sentinel could therefore cause an
>>>>> out-of-bounds access during type registration.
>>>>>
>>>>> I checked the distinction: softmmu needs the full system-target
>>>>> identity, including variants such as mipsel;
>>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
>>>>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
>>>>> than leave the field at SYS_EMU_TARGET__MAX.
>>>>>
>>>>
>>>> That's technical details, but not an answer to the initial question of
>>>> why we need to change anything for user binaries, compared to what exists.
>>>
>>> The first two patches revert the current static initialization so the
>>> token can be replaced. They are not a user-mode behavior change.
>>>
>>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
>>> qemu-mipsel already reports mips, and it still will. Names such as
>>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
>>> full target name for this field; keeping TARGET_ARCH preserves today's
>>> value and avoids the runtime parse.
>>>
>>
>> Why should we need to expose this precise information?
>> So far, if those targets were not exposed (and aliased to 32/64 bit
>> variant), it's probably we didn't need it.
>
> because for different SysEmuTarget, the machine list is different.
> return a wrong SysEmuTarget would cause a mismatch between SysEmuTarget
> and the machine list. for example:
>
> static const char * const mips_machines[] = {
>    "malta",
>    "none",
> };
>
> static const char * const mips64_machines[] = {
>    "magnum",
>    "malta",
>    "none",
>    "pica61",
> };
>
> static const char * const mips64el_machines[] = {
>    "boston",
>    "fuloong2e",
>    "loongson3-virt",
>    "magnum",
>    "malta",
>    "none",
>    "pica61",
> };
>
> static const char * const mipsel_machines[] = {
>    "malta",
>    "none",
> };

I don't know anything about this but for bi-endian architectures the CPU 
still has a default endianness it starts in, or a way to strap it to some 
endianness by a CPU pin or similar, or the board firmware sets the 
endianness (which in QEMU may be implemented in board code where we 
emulate the firmware instead of running a real firmware image, so while on 
real hardware the machine starts in BE then firmware sets LE we only start 
emulating from that point and the board code sets up the CPU to LE in 
QEMU).

In any case, this means that endianness should be a machine property and 
the list for an arch could contain all boards, then if the target arch 
defines an endianness, you compare that to the machine endianness and 
filter out those that don't match.

But from the above list BE machines also seem to appear in LE the list and 
malta appears everywhere so first we should understand how these lists are 
defined. It's not filtering out non-matching machines but maybe "el" just 
adds default LE machines in addition to the mips64 list and magnum and 
pica61 are added due to having 64 bit CPU which is another property to 
watch. So the lists seem to depend on CPU and board properties, in 
particular 64bit and LE.

I don't know if this can be implemented easily or at all with how these 
are currently, but I think going that way could arrive to a cleaner 
implementation. I'm sharing the above in case it helps this topic, I don't 
mind how this is implemented so you can also disregard this, just thinking 
aloud.

Regards,
BALATON Zoltan
--3866299591-887397917-1791232605=:85234--

