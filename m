Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1AEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi9hf-0006Rv-Kw; Fri, 10 Jul 2026 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wi9he-0006Rn-C1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:47:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wi9hc-0000cW-5G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:47:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so641659f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783684050; x=1784288850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d7vOHuy3sSHvPEUhr455FJA88p272dSau70X2IdOccc=;
 b=mN53IwKwoxFaoyyDoEAzxJGhHeF9njX3KGTTP+kkSM12DfgUdvzQ128U2ZdOPg3AMB
 S7To4K9YXD6UW4RdekqAbkRychaavzPBJuMJ1imji1NnCV5WSsHjI/OPstfc2KeN3xlY
 RceFlTSh2IKssApYq00WS0NUFqXBe6dxwI8EVLuHaYvjAPdtSC8bkN9HMv/U4pLXgIHy
 Ny+NR0NxsbT8MgXnLCy0Xk7u+0qd8NwJMU7KlyTMHjp1DvrGdewZQKnQQ2hatJr9icQp
 kSvj0psObhL4IS0p2vSJfhHPlUPwjtF+yvI/kThvadjZ2b5uV3rXWNoK1pKuERbUmvPA
 twyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783684050; x=1784288850;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d7vOHuy3sSHvPEUhr455FJA88p272dSau70X2IdOccc=;
 b=j0ro14/5s2SDGbpNI+qQmkjWNxSTv3SiWjsCzYpgPEFglV6Ak7SQ7uOfXtUfjQQfcR
 TtXleb6O/k2Gq4fvW8LaUNflxoQv5uPNfpjEg+SRSG9ZSI81RHsZZ6JiTGlmmCykgLYf
 zo6VNsFGviMxV5PQKpnwFjCOhvkhUCvgAivVVNe24HyVRfgwNswXQk6DxYp6Pbm62DbF
 EPQVTueCXkvpMvueCOzsPsEyKrpdqo4/YzceLKo6PRT8medZyEdY1RJa1twtUKqXahKa
 WCx+nCn1e292+N82Qv+N6NH3OQ7ni0O+eZi84SnVFCQ7Af80iBsMNJu8erreAGat5Fbv
 Nc/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQjEigJd06hyNUASvpzRl+pZwTyD23Gn8SNiXnrKxCocS+qqVVGfq6ExnPRIJe5bExn3B8d7mF9I67@nongnu.org
X-Gm-Message-State: AOJu0Yyvf1Tlgt7jB2AtA6xL6069h+7gTLLmdTmPBuEf9NmG5KteluY0
 RVg5i5AvOadWSbuEFcgKPIb0EOA/BbNyM9hJ6awmtpwE5gOxMBM5mtsJj4cdQSc2iuY=
X-Gm-Gg: AfdE7ckoZ1fnx7PsRAz91KMQxCD87j3gxf++HckXmaidsuIX03v4LnwqsZ5lLUoEE1m
 Rs6n6zKJ9NxYamvdMPLkJT0bZrTwlIaHaPZIE2E/L8x8XWAFw4JSZidi12bJ4jDCFYctexoFZY8
 94tcJYHifobhT1ceTTTpXxskn7EvRSIkmdo+/MMbm9b2DzQAZFAOIbgRoSew3O8a6ouV3988G0d
 Uta2mznGBe37GkYqa24HTCik8CXTNj3x27PUsGuc6/zJ0zJz8i3ytL9T0H3jG6v8IaEQjpPbmo1
 HNNbxs1Lm3XWQEPJimWubrpLZXRHewcjyUzWsODO9x2EWsHcaiyfoAN7SkDO3CYcWP+ncy0+Ngn
 AXb+Jv0BZq30TLoL5y+K8FilDOjZ5BBveTEAmLK29A40PElVp23XCRcfFwS6g/VCLwK2TgfBRLi
 Lc3xs37PiqBffyev6EoC8dTXk=
X-Received: by 2002:a5d:6f04:0:b0:46f:ca9:465a with SMTP id
 ffacd0b85a97d-47df075503amr11466520f8f.21.1783684050275; 
 Fri, 10 Jul 2026 04:47:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm59525891f8f.13.2026.07.10.04.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 04:47:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 280575F7C0;
 Fri, 10 Jul 2026 12:47:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Edgar E . Iglesias <edgar.iglesias@amd.com>
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
In-Reply-To: <alCoHiXzBAcwnOxJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 10 Jul 2026 09:06:54 +0100")
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_IsMGkkMY8wERc@redhat.com>
 <947a4843-34ae-43f7-8fbc-80109bc0c077@oss.qualcomm.com>
 <alCoHiXzBAcwnOxJ@redhat.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Fri, 10 Jul 2026 12:47:28 +0100
Message-ID: <87ldbjqd67.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

(added Edgar for Microblaze)

> On Thu, Jul 09, 2026 at 09:24:12AM -0700, Pierrick Bouvier wrote:
>> On 7/9/2026 9:13 AM, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
>> >> On 2/10/2026 8:35 AM, Daniel P. Berrang=C3=A9 wrote:
>> >>> When a developer's environment is already within a podman container =
it
>> >>> is not possible to use 'podman' again to create containers. It will
>> >>> usually result in wierd errors such as:
>> >>>
>> >>>   Error: fatal error, invalid internal status, unable to create a ne=
w pause process: cannot re-exec process to join the existing user namespace=
. Try running "podman system migrate" and if that doesn't work reboot to re=
cover
>> >>>
>> >>> Podman offers the ability to talk to a daemon outside the container,
>> >>> however, which could be leveraged by QEMU.
>> >>>
<snip>
>> >> Taking a look at why tcg tests are slow to compile, I reached this
>> >> commit. It seems like that calling 'podman info' is 5 to 10 times slo=
wer
>> >> than calling 'podman version'.
>> >> Thus, a container run now takes +1s when it was 0.2 before.
>> >=20
>> > Hmmm, but we call 'docker.py probe' in configure and cache the result,
>> > so that probe should only be done once.  0.2 vs 1s is just noise in
>> > the context of configure.
>> >=20
>> > That you're seeing any negative effects suggests that we've got
>> > something not using the cached probe result, which we should fix.
>> >
>>=20
>> Not really, docker.py --engine X still calls X info.
>>=20
>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.p=
y#L675
>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.p=
y#L78
>>=20
>> Maybe the fix is to remove the check if user specified an explicit
>> engine. But in this case, there is a problem with podman-remote not
>> being detected anymore.
>>=20
>> We can fix this by introducing engine=3Dpodman-remote, and skip the check
>> if engine is explicitly set.
>> What do you think?
>
> Urgh, so i see now we have two code paths / make variables
>
>   RUNC=3Dpodman --remote
>   CONTAINER_ENGINE=3Dauto
>
> Sometimes we'll invoke docker.py --engine $(CONTAINER_ENGINE)
> and sometimes we'll directly invoke $(RUNC).

Yeah that could do with cleaning up. I suspect the only places we
actually still need the script is where we are doing binfmt_misc enabled
containers unless there is a way to emulate the copying of qemu into the
container with a plain call? Maybe all the systems now have the
persistent flags which would skip this.

The toolchain case could be skipped if we could find hosted compilers
for microblaze. However I do see we have a patch in there.

>
> The result of "probe" cannot be fed back in to "--engine" which
> is a bit of a mess. I think the "engine" concept should not be
> exposed on the cli, and instead have a "--runc" arg which takes
> the full arg(s), since we need probe to report the runc args
> for other reasons.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

