Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F842C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVXO-0003Wa-OD; Tue, 18 Jun 2024 05:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJVXM-0003VX-Uc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:54:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJVXK-0007dX-Pu
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:54:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42121d27861so41680865e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718704437; x=1719309237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gXF1PJ4Uha8/rBYPYkTY+qderDnntrtGPsFK0GwQRRc=;
 b=V6KgReMwjke9+DjRLlmLXgHgfUAPPUuZUS3eIlgxf534oJ98I1iT7Nbu7LvF/gRkcc
 v33o16FJZJHJSQ0JMtSylfZsTWNjiGDmrTv/t35ngMePeou5UL9RO9B/XchYi12iL2yF
 isHx7pvhsxn1COq+I8hXLbzO+1GknZM+kSykX+BOJdqc/Q5/SqN/mjH7nsMic/Z78qlU
 utodDbzjGVwkqHmqzFXgyzQaY5I/q7UguzMKlAkOkiUrJNMAcY/AiD16+ivx9Qw6EtnZ
 IuEWUK2Unn7FW+dqny/pgkEbAOUn1QgrXOIPthkbDclGB/15msvLHX5phtrmkYOSRn1j
 cJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704437; x=1719309237;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXF1PJ4Uha8/rBYPYkTY+qderDnntrtGPsFK0GwQRRc=;
 b=wEttmDUNosYcHw1alUFYIr0oD0X9XFVPYSNo/LHTfElz8kRNshB0rzQ86feOGQlVGx
 awXLFYLGCS/0EVNZNarFjYQX4sx1V5WNcQdiyl7y1xpmYIASdHQuJcJEeWk1XwmnBu7G
 2pHhzCgESEQSrQxODBDhs7PMy3fvC/rxxUJCnTMe5tOBolVJ78kO2S0pJd3kFJ1xLkjg
 gtQxq3jELBMJE9hN1mLjGC7nHcrrYlnZCwR7+3T+buUaO6PBXw80NPj3sJKctcmgnXRm
 lJ4j7EcpOqQICqf8PqN/Dj/K/ouTY4rbrStnsDFaHwLvSSTYaCduqQrSTiMdCjvd8/eu
 Vv1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq+w9Y7px26ln+xiGP0bOuD5nzmeBnB8DLHJ8P4ehMuGdNXpOPfPb7EgdmoEDRn/4qUeQHLVovn0q2Ij7oQs6qYqN4vXI=
X-Gm-Message-State: AOJu0YwNkdfvpNmFBWlVct4tB2bgRCL5serQmJJ6Kr6PjV1ElYjULtCp
 Y158e+9yHTDav62ml9Ag05CzjoEZ6ReiUCuGc4qbcChgrS0vqghQCTpzhhatg4A=
X-Google-Smtp-Source: AGHT+IFhlF3hgJqwNC1kT5uuSbB14ovBJTJLMfQeME31lq2xN12DFaRayAEeSgz/ORSGrVl6+zvRkA==
X-Received: by 2002:a05:600c:4448:b0:421:819c:5d6b with SMTP id
 5b1f17b1804b1-423048262c3mr89662145e9.23.1718704436656; 
 Tue, 18 Jun 2024 02:53:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b74sm13696342f8f.107.2024.06.18.02.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 02:53:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87BFA5F8AC;
 Tue, 18 Jun 2024 10:53:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mark
 Burton <mburton@qti.qualcomm.com>,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  kvm@vger.kernel.org,  Laurent Vivier
 <lvivier@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  qemu-arm@nongnu.org,  Alexander Graf
 <agraf@csgraf.de>,  Nicholas Piggin <npiggin@gmail.com>,  Marco Liebel
 <mliebel@qti.qualcomm.com>,  Thomas Huth <thuth@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  qemu-ppc@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Cameron Esfahani <dirty@apple.com>,  Jamie Iles
 <quic_jiles@quicinc.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 9/9] contrib/plugins: add ips plugin example for cost
 modeling
In-Reply-To: <4e5fded0-d1a9-4494-a66d-6488ce1bcb33@linaro.org> (Pierrick
 Bouvier's message of "Mon, 17 Jun 2024 15:29:56 -0700")
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-10-alex.bennee@linaro.org>
 <ZmoM2Sac97PdXWcC@gallifrey>
 <777e1b13-9a4f-4c32-9ff7-9cedf7417695@linaro.org>
 <Zmy9g1U1uP1Vhx9N@gallifrey>
 <616df287-a167-4a05-8f08-70a78a544929@linaro.org>
 <ZnCi4hcyR8wMMnK4@gallifrey>
 <4e5fded0-d1a9-4494-a66d-6488ce1bcb33@linaro.org>
Date: Tue, 18 Jun 2024 10:53:55 +0100
Message-ID: <874j9qefv0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 6/17/24 13:56, Dr. David Alan Gilbert wrote:
>> * Pierrick Bouvier (pierrick.bouvier@linaro.org) wrote:
>>> On 6/14/24 15:00, Dr. David Alan Gilbert wrote:
>>>> * Pierrick Bouvier (pierrick.bouvier@linaro.org) wrote:
>>>>> Hi Dave,
>>>>>
>>>>> On 6/12/24 14:02, Dr. David Alan Gilbert wrote:
>>>>>> * Alex Benn=C3=A9e (alex.bennee@linaro.org) wrote:
>>>>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>>
>>>>>>> This plugin uses the new time control interface to make decisions
>>>>>>> about the state of time during the emulation. The algorithm is
>>>>>>> currently very simple. The user specifies an ips rate which applies
>>>>>>> per core. If the core runs ahead of its allocated execution time the
>>>>>>> plugin sleeps for a bit to let real time catch up. Either way time =
is
>>>>>>> updated for the emulation as a function of total executed instructi=
ons
>>>>>>> with some adjustments for cores that idle.
>>>>>>
>>>>>> A few random thoughts:
>>>>>>      a) Are there any definitions of what a plugin that controls time
>>>>>>         should do with a live migration?
>>>>>
>>>>> It's not something that was considered as part of this work.
>>>>
>>>> That's OK, the only thing is we need to stop anyone from hitting probl=
ems
>>>> when they don't realise it's not been addressed.
>>>> One way might be to add a migration blocker; see include/migration/blo=
cker.h
>>>> then you might print something like 'Migration not available due to pl=
ugin ....'
>>>>
>>>
>>> So basically, we could make a call to migrate_add_blocker(), when someo=
ne
>>> request time_control through plugin API?
>>>
>>> IMHO, it's something that should be part of plugin API (if any plugin c=
alls
>>> qemu_plugin_request_time_control()), instead of the plugin code itself.=
 This
>>> way, any plugin getting time control automatically blocks any potential
>>> migration.
>> Note my question asked for a 'any definitions of what a plugin ..' -
>> so
>> you could define it that way, another one is to think that in the future
>> you may allow it and the plugin somehow interacts with migration not to
>> change time at certain migration phases.
>>=20
>
> I would be in favor to forbid usage for now in this context. I'm not
> sure why people would play with migration and plugins generally at
> this time (there might be experiments or use cases I'm not aware of),
> so a simple barrier preventing that seems ok.
>
> This plugin is part of an experiment where we implement a qemu feature
> (icount=3Dauto in this case) by using plugins. If it turns into a
> successful usage and this plugin becomes popular, we can always lift
> the limitation later.
>
> @Alex, would you like to add this now (icount=3Dauto is still not
> removed from qemu), or wait for integration, and add this as another
> patch?

I think we follow the deprecation process so once integrated we post a
deprecation notice in:

  https://qemu.readthedocs.io/en/master/about/deprecated.html

and then remove it after a couple of releases.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

