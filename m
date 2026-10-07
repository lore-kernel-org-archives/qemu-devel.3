Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D4CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUCs-0005Fr-F0; Wed, 07 Oct 2026 12:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEUCq-0005Fb-Ru
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:09:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEUCo-0003dZ-HU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:09:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtawP436195
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 16:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Ijdeb45+lnAwHRacDdeDtryAWJROe7uuPBt8VGbm0Y=; b=IWk7Y8ZZPde6vSjU
 36+IdI18QastltMSZeL3bJKNLJi/tvSODxm9x4lQbw3bT5/le/jp5+nk5JLJ1S+y
 vOlvKVsFPVelIr4PjQhJ5DuOW7p2N/X+SCHCVegjyDVp3eYscD8TddYkSamZ9RJK
 F8Nswm0C2VLBlwlgdsgUEgKFaJqWn1CXIqDvQfQXgdN60CL4IkwrYudPQpQT70/J
 VfL6EBjJe41p0mZbU7G6SwG08vVDhDHEFW4dtnu0TLq46XogeP9HcTeaLGFB6XT3
 C05bguDObw0ZDK9D0wmM/9oMhSrsF1Zx58cHt6CRYsoLVc/jOYFWUDpvFP8pCiQr
 RmUFJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c60b2cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:09:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34e676375d9so4275021eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791389359; x=1791994159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Ijdeb45+lnAwHRacDdeDtryAWJROe7uuPBt8VGbm0Y=;
 b=dkhMsEgOq5UVQYDugIduCD5lKmYB6PrnWfVb62ddrAitJi6s+TpIxwr1B3GU7OBYVk
 AoRfaXCnkkm/dKCZGwViZYpikNiLUbAh2O/JXiL8JtZsBzzOxjimF3viBDmSc9mWPMZD
 7Slk5vNOTfA2tgKCKvDphsQw21w2GqjbZh+i9BbWor7SVlyLubZQKXs8EKfa455hM1fa
 DZIeHxSmwTc6rdTTi3U8Gshk87u4zbBakYLuCNs+5nxYDIhIf/6zYvyhfjGbPLCAvbUR
 KaPZu2V/ramGJUFhx4rRiWGpPyrPnG3SPltbgWMOrUo2lfTGOhx1EeTNsAsZWqCFtbIA
 1QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791389359; x=1791994159;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Ijdeb45+lnAwHRacDdeDtryAWJROe7uuPBt8VGbm0Y=;
 b=yaz/a6Qbn0R7P1qc9Ry9bS4ipftH1KucsgARHxyPuCTJy0DCDBkHCys8EIweQY8NZi
 o0g7xPL2lirN/FO6B89RfINISvWe0xNov8bSoTDj20N+0oLLq6+KSJIqYTNay5MIqV/v
 9FsVTSOWWe/fis9U49NvLeyDGhxBZLx30LhVB3fN1I6c3f0TIaKDLvODXvxubOgxuOu5
 /85vvHgi/tZ25XSXO20EmbPYfbZFT+ZzbelPRC2mrL+b6EENaEa8a2OfV7ZmxDwHyOQr
 zbFOBRstQal90/GhnEWkivN6xaW2qKDdoMIiN2cxF55xgaqMtcyqjOEIDHl5VBVZf1aw
 i1MQ==
X-Gm-Message-State: AFq9FYIrKeIpV/nH1JSgqj4YrCbOCiYfqHmvYtb81C4l8WzIXlulojZy
 0NZzV7fSDsBzIZawxQ0acWJ3WOcties83rWY+raPUYKxOUi70LXqE7N+66lwS2UfA2Er7FicGlV
 C59YQB67afTZSpd9Mr/hJt++8BV35C8OwYaagHjqEe1zOsUx2ro52baOv5Q==
X-Gm-Gg: AYBFou1PlAFFsPNG4q0ZwfYvufoEYKVO5h8/mQyO3DbH7sk0pE8MQMvW6DUd5SkVJmR
 NwvWQrVvearImuBWbsGTRKU2e7TGNEjuvdVhAbxhuWsCR0Q0Ov0kRFy5a3iGH3icZRbVC+AsJhD
 q4kybhHc4fgXvEG74ivocqmr7RtKe0tb1z47mbFYPuRpSWXM+bHxrVjbjo2SgqEWExP4OHVwWOL
 u2Y21epQuKcIdGRQVbbJ98cMHShGnBE3szuqQNN4456Su3Dby4u6KVZRPJ7MHa/Hc0fBt5N04Nh
 HKNSj5DQkRbKfghSKvyHYjIdKUmK3rizSdem9kEqZasHMevVwjo4HPaX7j9ESBWjuEkA/WSNQcR
 fh0/PQqOvgt2xl52I6dma1idlOjX1vXdtkWAFPQcCo2SmNTjXzAVpAVUpHrJ8DChvG2c0kw==
X-Received: by 2002:a05:693c:860a:20b0:34e:f911:1763 with SMTP id
 5a478bee46e88-3515df1fcb9mr2953632eec.13.1791389358739; 
 Wed, 07 Oct 2026 09:09:18 -0700 (PDT)
X-Received: by 2002:a05:693c:860a:20b0:34e:f911:1763 with SMTP id
 5a478bee46e88-3515df1fcb9mr2953581eec.13.1791389357824; 
 Wed, 07 Oct 2026 09:09:17 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351735e316fsm302149eec.11.2026.10.07.09.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 09:09:15 -0700 (PDT)
Message-ID: <d6217459-1e55-4da0-a49f-bde8215d8c0e@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 09:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
 <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
 <CAE2XoE820gUO6q8SE9-2rjaBdz_YwPjKkzPs9qV1e1AZ-5-t8Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE820gUO6q8SE9-2rjaBdz_YwPjKkzPs9qV1e1AZ-5-t8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uiRTeN6-V8PUllMCtv4mJg4IrakcEnHQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2NCBTYWx0ZWRfXzx2LdV58ppes
 ksY1wS2uwKS2NONfnR7SDZUOftw979lU/BqvvvABIU4JySZOmIkXycu/uQs9kbfh/E1pqdCfb2G
 Q6tOCtycrUw7BngmzMrBnmgcbNKiU/o=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac66eb0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jnyP4OZTsIrz9ktorz4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: uiRTeN6-V8PUllMCtv4mJg4IrakcEnHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2NCBTYWx0ZWRfX0q7fQtDzKXJd
 b5hAuyeEaqvVEazavmwBKHYS0crOwgTkUWVLJgYpdU/6fpO4DLB4GjEeoVJVdHb56UV+/L1ujYi
 J22ZnO7qg/mMoukntrsvJdEDRW9JMpVWvAdn8d4HG+zeEoMubVtMYtn3Kngc2d3nGIimyN/GmtG
 3u6L8hy+PDDBCLsq64yxwQRVlageI9EzETyeMjHAgpRJJwp5Tjs5uQ2EOelP/RnthinLZwdZmbo
 EBHtsQnWhpSY0mImfzBnt1fsHmeDRJ4ACncchJLlITq/E7YeuW7Is//shf31L8Qa9o45FY43Gfv
 LUHz2ftAPDBVtDxhxoaSfgfqpprxQYee8CWGhOlyR2D9AVrwfABtJlq4SPalY7YS8fzIEIgSpWA
 nWojbkWfA2WehLUAHJaJu5MpYma3mW+yURrIK9n4+fsN9QU367lNBRdSesDMvPrXh9/bNkbG4ol
 2LIHB1HsZGFjs/cg6qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070064
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

On 10/7/2026 7:47 AM, Yonggang Luo wrote:
> On Wed, Oct 7, 2026 at 10:29 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 12:48 AM, Yonggang Luo wrote:
>>> On Wed, Oct 7, 2026 at 12:03 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
>>>> based on endianness, are accessible through TARGET_NAME. However,
>>>> TARGET_NAME is a string, and thus can't be concatenated to generate code
>>>> and retrieve matching SYS_EMU_TARGET enum entry.
>>>> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
>>>> identifier.
>>>>
>>>> There is one more subtlety, user binaries have extra targets that are
>>>> not present in SYS_EMU_TARGET, like armeb.
>>>> Thus, for user binaries, simply export TARGET_ARCH.
>>>
>>>
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  meson.build | 11 +++++++++--
>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index cae1591cd28..9bcfe84daba 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
>>>>  actual_target_dirs = []
>>>>  fdt_required = []
>>>>  foreach target : target_dirs
>>>> -  config_target = { 'TARGET_NAME': target.split('-')[0] }
>>>> +  target_name = target.split('-')[0]
>>>> +  config_target = { 'TARGET_NAME': target_name }
>>>> +  if target.endswith('linux-user')
>>>> +    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
>>>
>>> If TARGET_ARCH_VARIANT or just called (TARGET_NAME_ENUM) is just a
>>> direct mapping of target_name regardless linux-user/bsd-user/softmmu,
>>> the logic would
>>> be simpler. That would need add more enum to SYS_EMU_TARGET, the
>>> current form is:
>>> ##
>>> # @SysEmuTarget:
>>> #     The comprehensive enumeration of QEMU system emulation
>>> #     ("softmmu") targets.  Run "./configure --help" in the project
>>> #     root directory, and look for the \*-softmmu targets near the
>>> #     "--target-list" option.  The individual target constants are not
>>> #     documented here, for the time being.
>>> #
>>> # @rx: since 5.0
>>> #
>>> # @avr: since 5.1
>>> #
>>> # @loongarch64: since 7.1
>>> #
>>> # @hexagon: since 11.0
>>> #
>>> # .. note:: The resulting QMP strings can be appended to the
>>> #    "qemu-system-" prefix to produce the corresponding QEMU
>>> #    executable name.  This is true even for "qemu-system-x86_64".
>>> #
>>> # Since: 3.0
>>> ##
>>> { 'enum' : 'SysEmuTarget',
>>>   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>>>              'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
>>>              'mips64el', 'mipsel', 'or1k', 'ppc',
>>>              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>>              'sh4eb', 'sparc', 'sparc64', 'tricore',
>>>              'x86_64', 'xtensa', 'xtensaeb' ] }
>>>
>>>
>>> The list target names that missing from SysEmuTarget:
>>>
>>> Comparing the target-name prefixes of `configs/targets/*.mak` with the
>>> `SysEmuTarget` enum in `qapi/machine.json`, the following seven names are
>>> missing. All are Linux-user-only targets.
>>>
>>> | Target name | Config |
>>> |---|---|
>>> | `aarch64_be` | `configs/targets/aarch64_be-linux-user.mak` |
>>> | `armeb` | `configs/targets/armeb-linux-user.mak` |
>>> | `microblazeel` | `configs/targets/microblazeel-linux-user.mak` |
>>> | `mipsn32` | `configs/targets/mipsn32-linux-user.mak` |
>>> | `mipsn32el` | `configs/targets/mipsn32el-linux-user.mak` |
>>> | `ppc64le` | `configs/targets/ppc64le-linux-user.mak` |
>>> | `sparc32plus` | `configs/targets/sparc32plus-linux-user.mak` |
>>>
>>> All `*-softmmu` and `*-bsd-user` target names match enum entries.
>>>
>>> This comparison uses names derived from config filenames, not the
>>> `TARGET_ARCH` values inside those configs.
>>>
>>> By doing this I think it would be more consistent.
>>> If these target names are removed in future, then just remove it from
>>> SysEmuTarget
>>> along with. So SysEmuTarget is just a direct mapping of TARGET_NAME. Though
>>> The comment of SysEmuTarget needs updated, it's not just about softmmu, but also
>>> for linux-user and bsd-user. But the fact is, with the current
>>> changes. *-user also
>>> used SysEmuTarget as an enum.
>>>
>>>
>>> And TARGET_ARCH should also be exported by TargetInfo for other usage.
>>> And it's enums is the subset
>>> of enum SysEmuTarget
>>>
>>
>> I tend to agree, but didn't find a real reason to do this change (yet).
>> Also, I would be in favor to rename SysEmuTarget since in EmuTarget,
>> since it would now be decoupled from system emulation only.
> 
> I think the current patch is enough at the current stage.
>

Agree, the rest is an additional refactoring that belongs to a different
series.

> A better bsd-user/linux-user support needs much more work.
> for example:
> 
> enum {
>     QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
>     QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
>                             (1UL << SYS_EMU_TARGET_AARCH64),
>     QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
>                             (1UL << SYS_EMU_TARGET_X86_64),
>     QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
>     QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE),
>     QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
>                             (1UL << SYS_EMU_TARGET_MIPSEL) |
>                             (1UL << SYS_EMU_TARGET_MIPS64) |
>                             (1UL << SYS_EMU_TARGET_MIPS64EL),
>     QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
>                             (1UL << SYS_EMU_TARGET_PPC64),
>     QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
>     QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
>                             (1UL << SYS_EMU_TARGET_SH4EB),
>     QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
>                             (1UL << SYS_EMU_TARGET_SPARC64),
>     QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
>                             (1UL << SYS_EMU_TARGET_XTENSAEB),
>     QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
>     QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
>     QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
>     QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
>                             (1UL << SYS_EMU_TARGET_RISCV64),
>     QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
>     QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
>     QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
>     QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
>     QEMU_ARCH_ALL =         UINT32_MAX,
> };
> 
> QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
> 
> /**
>  * qemu_arch_available:
>  * @arch_bitmask: bitmask of QEMU_ARCH_* constants
>  *
>  * Return whether the current target architecture is contained in @arch_bitmask
>  */
> bool qemu_arch_available(uint32_t arch_bitmask);
> 
> arch_bitmask also needs to be increased to 64bit, and currently
> SYS_EMU_TARGET__MAX is 29, very close to 32.
> 
>

I'll take a look to extend it and do the renaming.

>>
>> @Daniel: Would you be favor to see such a change? I know that
>> introspection/QAPI is related to system emulation, and I'm not
>> completely sure adding user targets is the right move at this moment.
>>
>>>
>>>
>>>> +  else
>>>> +    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
>>>> +  endif
>>>> +
>>>>    if target.endswith('linux-user')
>>>>      if host_os != 'linux'
>>>>        if default_targets
>>>> @@ -3372,7 +3379,7 @@ foreach target : target_dirs
>>>>        # do nothing
>>>>      elif ignored.contains(k)
>>>>        # do nothing
>>>> -    elif k == 'TARGET_ARCH'
>>>> +    elif k == 'TARGET_ARCH' or k == 'TARGET_ARCH_VARIANT'
>>>>        config_target_data.set(k, v.to_upper())
>>>>      elif k == 'TARGET_BASE_ARCH'
>>>>        # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>
>>>
>>> --
>>>          此致
>>> 礼
>>> 罗勇刚
>>> Yours
>>>     sincerely,
>>> Yonggang Luo
>>
> 
> 


