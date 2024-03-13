Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C041C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 13:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkOi1-0000Xl-73; Wed, 13 Mar 2024 09:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkOhx-0000T5-6e
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:31:50 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkOhv-0005Ek-78
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:31:48 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-220ce420472so2000144fac.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710336706; x=1710941506; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nceI7oUy7H1If+uxGr/utYMTaUqHGc9BcgE3B0bTib8=;
 b=FFqMmiGxLUQUFzEE0PmDtlJeKz8I42hlrmfx9AhihtVwn8Xx2OUf2+X3ueYNgdTvCB
 QNEl6ejdxCQJi4x25mOgXZVNNYuSNqlWZYBnr5Hipowb/yZjsUi0aWzrULA0HN7AYWUX
 7a//xYuVcyzpUoZHto6HdcsFlSRPYnt25XpiyjvBsBXys52gFsECfBUEzs3JhoqGEnJG
 rU/uNtPC8PLX5ZsQeG4rlIf9FV+ZHpt6uRi7poNYcl+ouWODHt26h00eaqUT6q+KxDCp
 NyPUqYqyAfgAxTuohwD7TcLCQ5vCfV+nJVlrMKbnNWP0nNjNEQbPpxa4twMPZ76jCttW
 vW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710336706; x=1710941506;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nceI7oUy7H1If+uxGr/utYMTaUqHGc9BcgE3B0bTib8=;
 b=ASdcCrze3iQIcGC47VWdU+O/HdUmULtc5EK/kfwA8RyTwKbzVUo0PMXZyypV63u6c2
 /sJwKF8ijganiY7wkIQgo3o4oK5Gwl/Gc5hits3hOHJvUe+CXCT1DHYdcZXhw7nQnahK
 yRePmC1CWu0SYlQmzHIkyqX3ZIo4rp2BU8hL7Yc8GPnZyr+ulbhTg64LczH5udIO3rOS
 DGDjJqSk/O5C5KqyZKm/s7EtLpeBXWUHDADCp+9Ut8U/BpmPE3Bax5UtqA5sAVMrApXg
 fm7O0DY6+JRIwoWnAngR/tYKqUAZpKuLGnTMDiMd8TlHEAlkJIlAdDG71+BPcUnKc/gQ
 6yfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhocN8MYhMFL3Q+Ah//RAJoOcinOJUvcGJGRQjFPkiqnjdqqO+grOZ3Xo9gKYn9+wXFEse2++HhgDVAwqegRjn3zgVU4c=
X-Gm-Message-State: AOJu0YxFJyKcRqnVK+g5qf3VhDySPxCIyt+76Lnrk3wQYwcNCpqVeKhi
 YBxHcYXOVdY+vmdI+7lC5uuLo3aOY4poqyPDaf5oI+2C1ppu3fOgL0AUQUhB4wc=
X-Google-Smtp-Source: AGHT+IEPSdTTloZIfXActvcTdersRhGhdFA2Aer7Kr0ERu25CYAFUH+uCSHoKivCDZUDske2xDn5zw==
X-Received: by 2002:a05:6358:b256:b0:17b:61ad:1585 with SMTP id
 lo22-20020a056358b25600b0017b61ad1585mr1754061rwc.3.1710336705463; 
 Wed, 13 Mar 2024 06:31:45 -0700 (PDT)
Received: from smtpclient.apple ([2405:201:d019:c0ce:90da:559f:95a1:e85b])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a656881000000b005dc4fc80b21sm6840434pgt.70.2024.03.13.06.31.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Mar 2024 06:31:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
In-Reply-To: <20240313-31131fe87882ea953d5aa6d4@orel>
Date: Wed, 13 Mar 2024 19:01:22 +0530
Cc: qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9487F33B-8519-4D4F-A129-94E943B5999A@ventanamicro.com>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
 <20240313060931.242161-3-hchauhan@ventanamicro.com>
 <20240313-0ac597594e930a42685aeba5@orel>
 <CAPd4WezTTcYA5grMBrGYx5LUwF2jPT8gbL6CQWMZtsd1AJNuZQ@mail.gmail.com>
 <20240313-8164061a70dafa62c8bb755b@orel>
 <7898E43D-AF22-4170-BEC9-BC172304F483@ventanamicro.com>
 <20240313-31131fe87882ea953d5aa6d4@orel>
To: Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 13-Mar-2024, at 6:19=E2=80=AFPM, Andrew Jones =
<ajones@ventanamicro.com> wrote:
>=20
> On Wed, Mar 13, 2024 at 05:48:16PM +0530, Himanshu Chauhan wrote:
> ...
>>>>>> #ifndef CONFIG_USER_ONLY
>>>>>> +    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
>>>>>> +         warn_report("Disabling debug property since sdtrig ISA
>>>>> extension "
>>>>>> +                     "is enabled");
>>>>>> +         cpu->cfg.debug =3D 0;
>>>>>=20
>>>>> If sdtrig is a superset of debug, then why do we need to disable =
debug?
>>>>>=20
>>>>=20
>>>> "debug" is not disabled. The flag is turned off. This is for =
unambiguity
>>>> between which spec is in force currently.
>>>> May come handy (not now but later) in if conditions.
>>>=20
>>> I know sdtrig/debug functionality remains enabled, but why state =
that the
>>> 'debug' functionality is no longer enabled?
>>=20
>> Got it. The warning can be removed.
>>=20
>>> If sdtrig is a superset, then,
>>> when it's enabled, both the debug functionality and the sdtrig
>>> functionality are enabled. Actually, sdtrig should do the opposite, =
it
>>> should ensure debug=3Dtrue. The warning would look odd to users that =
know
>>=20
>> I would disagree to set debug=3Dtrue when sdtrig is selected. These =
are two different specifications and should be treated so. Sdtrig is a =
superset now but may have another revision not backward compatible. For =
two different specifications and flags should mirror the same. On the =
same lines, this patch (as it does) should keep (cfg->debug || =
cfg->sdtrig) which shows that you are dealing with two different =
specifications. They behave same for some triggers but are still =
different. Deprecation isn=E2=80=99t a problem now or later.
>=20
> sdtrig is frozen, otherwise it would require the 'x-' prefix, so it =
can
> no longer change in a substantial way and therefore if it's a superset =
of
> debug now then it always will be. If a change is made to "debug
> functionality" then it will get a new extension name which may not be
> compatible with either 'debug' or 'sdtrig', however that's not the =
case
> here. If a platform supports 'sdtrig', then it supports 'debug', as
> 'sdtrig' is a superset of 'debug'. Pretending like they're mutually
> exclusive doesn't make sense when they completely overlap. Indeed
> platform's will likely *want* to advertise that they are compatible =
with
> both because software that is only compatible with 'debug' will need =
to
> know if it will work or not. A platform that says it's not compatible
> with 'debug', when it is, because it supports sdtrig, is limiting the
> software that will run on it for no reason.

Got it. I will make the necessary changes.

>=20
> Thanks,
> drew
>=20
>>=20
>>> this and the debug=3Doff would also look odd in the results of cpu =
model
>>> expansion. Keeping debug=3Dtrue would also avoid needing to change =
all the
>>> if cpu->cfg.debug conditions to if cpu->cfg.debug || =
cpu->cfg.ext_sdtrig.
>>>=20
>>> If we deprecate 'debug' someday, then we'll add a warning for when
>>> there is 'debug' explicitly enabled by a user and also for 'debug'
>>> configs which lack 'sdtrig', but we don't need to worry about that =
now.
>>>=20
>>> Thanks,
>>> drew



