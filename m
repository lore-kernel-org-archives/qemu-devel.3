Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF5BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 12:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNZG-0004WJ-Hd; Wed, 13 Mar 2024 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkNZE-0004W5-Ac
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:18:44 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkNZC-0002JR-NV
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:18:44 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3663a681015so5433715ab.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710332321; x=1710937121; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmJJB8k05AGEwFFEARTAgnJ867F5XbpwpXhq+Wba6i0=;
 b=JWmA1wuNE9+WPYhBlMMb+GFDVteLqmYPnKoc5HyRVqvt8Zrp1rd2W7j6mcwK1a6s8H
 sUUyTi9Lh3vmrr7AKAsBP6GEUAXhU5nGAtwCJdTJfE+jxJObb8rCMyGDcHP3nDNijVZb
 rSvSBDbQW0H/x+nJMwe8EZClrs5ecQx25koIbQuLCP7MzZCmWiwjk66O6nIhUszEHbb6
 Nk6ekNXCKocPSpunJkYZFH6ugHj8EAkIxltW9eaUqklyUalE0svygCMTRKp7Wx9lGmqw
 tILBLUEcQmpBajtS625O/xhyae+wW1f1h9jlz4AofMiyeYAwsmERozhDoadZfhOEavgs
 y/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710332321; x=1710937121;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmJJB8k05AGEwFFEARTAgnJ867F5XbpwpXhq+Wba6i0=;
 b=m2QLLkBanJL/m8oJe6vUwvL4VG2J17hpryUlOwKk5Wacbb26cYdbETi/oCIt4mX8E1
 DJQxJENTZpbnGDQssdYIYHvoZnwDuQ4Sw3frm7REpZKbHbNIVbFEEMXFMgXZsnQr/sfa
 W5uQsOctK6TMwy98F41WiAiJp7f7FABZTIg/rmSu9wJwcKQFmqVJFBLH9HtsvCNcyFr5
 s0lCxrhb54fYMgJfUt1jDdUVtag824eFSAQ/edKKpJ72DpynS9pfxZE5vUxJOdMWdiSs
 KM7SbloDqtmv+PUg9rD30xVmC+wHUmHPsP4GYC/DtJD6X7uodXEgXYY/ujBWVCWan+yc
 WEjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXji0TY2yX95bfflqMdidnTekPh03S2iF9cRjG8oI4q8slWdyp9FzN9VgLSw6d5whx5/VF6vjeu13dG7RMohZfuAvDinBQ=
X-Gm-Message-State: AOJu0YyL3b1H3uZCQH69wW0vJQ4rH9xkstxAxggM/5Ai0wMNHHsQiqer
 OAAtYW9WooztUt4bLxEDwV+vpBbxiFgjHpKnRCuTHvkHVnRnq85W3mTNWEHSuns=
X-Google-Smtp-Source: AGHT+IHHE4ntoCcfLcy6czha063yiHoeekCG48NRssUEay8RAdB7s6KtjceFewSEw6E8NdeqsddiZA==
X-Received: by 2002:a5d:970e:0:b0:7c8:9e3c:783 with SMTP id
 h14-20020a5d970e000000b007c89e3c0783mr12293874iol.0.1710332320695; 
 Wed, 13 Mar 2024 05:18:40 -0700 (PDT)
Received: from smtpclient.apple ([2405:201:d019:c0ce:c896:a4a1:1203:4a34])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a63e00b000000b005dc48e56191sm7601156pgh.11.2024.03.13.05.18.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Mar 2024 05:18:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
In-Reply-To: <20240313-8164061a70dafa62c8bb755b@orel>
Date: Wed, 13 Mar 2024 17:48:16 +0530
Cc: qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7898E43D-AF22-4170-BEC9-BC172304F483@ventanamicro.com>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
 <20240313-0ac597594e930a42685aeba5@orel>
 <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
 <20240313-8164061a70dafa62c8bb755b@orel>
To: Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 13-Mar-2024, at 4:28=E2=80=AFPM, Andrew Jones =
<ajones@ventanamicro.com> wrote:
>=20
> On Wed, Mar 13, 2024 at 03:50:16PM +0530, Himanshu Chauhan wrote:
>> On Wed, Mar 13, 2024 at 3:24=E2=80=AFPM Andrew Jones =
<ajones@ventanamicro.com>
>> wrote:
>>=20
>>> On Wed, Mar 13, 2024 at 11:39:30AM +0530, Himanshu Chauhan wrote:
>>>> This patch adds "sdtrig" in the ISA string when sdtrig extension is
>>> enabled.
>>>> The sdtrig extension may or may not be implemented in a system.
>>> Therefore, the
>>>>           -cpu rv64,sdtrig=3D<true/false>
>>>> option can be used to dynamically turn sdtrig extension on or off.
>>>>=20
>>>> Since, the sdtrig ISA extension is a superset of debug =
specification,
>>> disable
>>>> the debug property when sdtrig is enabled. A warning is printed =
when
>>> this is
>>>> done.
>>>>=20
>>>> By default, the sdtrig extension is disabled and debug property =
enabled
>>> as usual.
>>>>=20
>>>> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
>>>> ---
>>>> target/riscv/cpu.c | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>=20
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 2602aae9f5..ab057a0926 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>>>>     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>>>>     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>>>>     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, =
ext_zhinxmin),
>>>> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>>>>     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>>>>     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>>>     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, =
ext_smstateen),
>>>> @@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object =
*obj)
>>>>     set_default_nan_mode(1, &env->fp_status);
>>>>=20
>>>> #ifndef CONFIG_USER_ONLY
>>>> +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
>>>> +         warn_report("Disabling debug property since sdtrig ISA
>>> extension "
>>>> +                     "is enabled");
>>>> +         cpu->cfg.debug =3D 0;
>>>=20
>>> If sdtrig is a superset of debug, then why do we need to disable =
debug?
>>>=20
>>=20
>> "debug" is not disabled. The flag is turned off. This is for =
unambiguity
>> between which spec is in force currently.
>> May come handy (not now but later) in if conditions.
>=20
> I know sdtrig/debug functionality remains enabled, but why state that =
the
> 'debug' functionality is no longer enabled?

Got it. The warning can be removed.

> If sdtrig is a superset, then,
> when it's enabled, both the debug functionality and the sdtrig
> functionality are enabled. Actually, sdtrig should do the opposite, it
> should ensure debug=3Dtrue. The warning would look odd to users that =
know

I would disagree to set debug=3Dtrue when sdtrig is selected. These are =
two different specifications and should be treated so. Sdtrig is a =
superset now but may have another revision not backward compatible. For =
two different specifications and flags should mirror the same. On the =
same lines, this patch (as it does) should keep (cfg->debug || =
cfg->sdtrig) which shows that you are dealing with two different =
specifications. They behave same for some triggers but are still =
different. Deprecation isn=E2=80=99t a problem now or later.

> this and the debug=3Doff would also look odd in the results of cpu =
model
> expansion. Keeping debug=3Dtrue would also avoid needing to change all =
the
> if cpu->cfg.debug conditions to if cpu->cfg.debug || =
cpu->cfg.ext_sdtrig.
>=20
> If we deprecate 'debug' someday, then we'll add a warning for when
> there is 'debug' explicitly enabled by a user and also for 'debug'
> configs which lack 'sdtrig', but we don't need to worry about that =
now.
>=20
> Thanks,
> drew



