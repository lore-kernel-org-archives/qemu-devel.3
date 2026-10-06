Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEIbv-0005Mi-Ot; Tue, 06 Oct 2026 23:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEFcp-0004Az-Pu
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:36:26 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xEFcM-0004hY-0h
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:34:52 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5bcc6094d7fso1007735e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791333029; x=1791937829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gtmTHfvmgOUorpAagKLp/wNbtPT5GvKexHXQCZ1vHio=;
 b=sjv52yq04bICaNx0K/9du25dQVGP58bfU75QXnjrXtR4YWWt/EMZvBQO7PlbRV3bXz
 wiRzc2Cv64ZrKlWUrhT8U9QkmAzE3QWsZgbRVq4k18HzesIYL2tAWKVZ8bbAOeDvH/hC
 CWDGMzDVlaqO9loq6weUS8p/obUk8eqMe4RhRY14t68vQA01a72DnCa5oCrWR3KbR4EG
 sWvG0q17rCuzqjhTO+EKoEKv2Z/py7iA8qA/Gj3ZqrNfIREtDblMf774kgnSVQOz1CZp
 fGFikxSVeVg6jH0uZH4ghTgDMkmjzvNEMDIUMUq18iMBZDovEa2fojYKpnCf0iB6n77G
 pxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791333029; x=1791937829;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gtmTHfvmgOUorpAagKLp/wNbtPT5GvKexHXQCZ1vHio=;
 b=aSzSnplhRbQm6dpnTe2J3txMKGSYG/DTw4FCPQ8MXkPv7spy14lMaP0y+Tx1uDo7EA
 kSRbCiVoFTPr6V06+XcXuFN/L5CkAqm2JG5ifgMwvz0jpzhZ0qfL+8ocyjC9pca+VCJg
 WzNnXMGgjcmH97e0EDGln0AyYih7XXlxFABw1Ecz5je1Zi9T2Ro5EEoBT33i8vsvILIE
 2U/rPTfjSS5+I3dqI5PJlEtQOgWGGj2G42vKT6VC3UYAQwhVHNByG6kKnB6bbFSQuJ5K
 FFSaxFSBzmh6Rv7m/utVbdWywNfwMbQFsX4B4rTLbD+TZr3WxkwBJ/hjuKDHFXjUHWC3
 Ox/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvQmxWx8/+rNqktun8v+LfnRHXwBfV76dNROBD63IH3P2A57tMsTAbie/ZBSLDcjgpt6Od6uxvsoHV@nongnu.org
X-Gm-Message-State: AFq9FYJpI35lTF5h6CZ0zDwvuAxRsxY3WaW1TqydkoA3yo3NSQeQs7Jj
 0W87tYEhcKbDZdfimKMX91imjk/tRduc8yYgaacMTpNlJvUE4RyktK1QO4wgTQtcBcxPAKCM3L9
 49wImQOA=
X-Gm-Gg: AYBFou2xRm09QcsrCG+3I2NKMlpHGrfsZGKdTNVQjeFdmxoM6g/cwAfo9S//zS2wYxs
 n4YPTH4LPnYBveFGqoIgLfRUaq30E+vpLfIbOyZzvFyAT1tfn560uqqVzoiFVIOkVxvvu9jpHGg
 LIV9NNFUipQYeC7DwZZXfXwVNgIGL/uJ9U9WCwI01Q3yq9w6fCfFa9Jq/+05fk11rHwjhHMgWau
 qvwqgNmT5YOQ6QruTAj6k2SXrXXvF16PfQZi5YANJxQ/KGXLzql7O3tFpgqZGEWkxx7bxBiDW8v
 du1SmdvmPs3L7TRTvN6mHF1TL7yrsqD0vFOO0cWIeZHQvsNfNoSvDxwTBrxoTWlYnj/9BreaxR7
 wXn3/3K6L3PDLXBV3NdQ3ginj29d7VXdxLH3ZCmIbEmm1yaPGzBf7u7BDAmKOjb6d0E6TzADiqZ
 /MtbpRitcDP6GgFMpgxKAqmbsZJAxHcK9IUaRvbzQZQCmykW1+VzvSVM3+RopZvf4XdNuqJBAzY
 X3qnWKX
X-Received: by 2002:a05:6000:2912:b0:48b:f9e2:4abb with SMTP id
 ffacd0b85a97d-48c6d1ec69amr2230647f8f.57.1791292437740; 
 Tue, 06 Oct 2026 06:13:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cd7c326sm3125794f8f.53.2026.10.06.06.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:13:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB5FF5F861;
 Tue, 06 Oct 2026 14:13:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,  Fabiano
 Rosas <farosas@suse.de>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <asTF0za8c5njDtrK@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 6 Oct 2026 10:56:35 +0100")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <69164823-7271-4d59-9684-637bec454a1d@redhat.com>
 <293cb972-35e1-1922-0834-601e2491a7a6@eik.bme.hu>
 <asS0HLYRmZhB3Ban@redhat.com> <87mrsrjh8a.fsf@draig.linaro.org>
 <asTF0za8c5njDtrK@redhat.com>
User-Agent: mu4e 1.14.4-pre5; emacs 30.1
Date: Tue, 06 Oct 2026 14:13:55 +0100
Message-ID: <87ld8b6kfg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

> On Tue, Oct 06, 2026 at 10:44:37AM +0100, Alex Benn=C3=A9e wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 05.10.2026 um 23:09 hat BALATON Zoltan geschrieben:
>> >> On Fri, 2 Oct 2026, Paolo Bonzini wrote:
>> >> > I agree completely with how you phrased the first and third.  I agr=
ee
>> >> > that the second bullet is a risk too, but it's mitigated by "LLM-cr=
eated
>> >> > contributions will be held to a higher standard than human-created =
ones,
>> >> > because LLMs make it easier to write tests" (and by maintainers bei=
ng
>> >> > able to
>> >>=20
>> >> Tests need to be reviewed too to be able to trust them so that does n=
ot help
>> >> against overloading reviewers with generated patches but burdens them=
 even
>> >> more: they will also have to review the tests before the code.
>> >
>> > The required level of trust for tests is comparatively low, so it's mu=
ch
>> > easier to review tests to a sufficient level than say device emulation
>> > code.
>> >
>> > If a new test looks plausible, fails before the fix and passes
>> > afterwards, it's more useful that what we had before, even if it's
>> > technically buggy in some corner case.
>>=20
>> And also easier to rip out in the unlikely event it infringes anything.
>>=20
>> But broadly having a test* is better than having no test.
>>=20
>> * modulo the effects on our coverage.
>
> The maintability of test code is really important too, just as much
> as the code being tested. Every test potentially constrains how we
> can change code in future as tests themselves are never perfect or
> exhaustive and often take short-cuts in their design to suit the
> current testing needs. As we enhance the code under test, the test
> suite needs to evolve with it and that requires that we understand
> the test code and why it is doing what it is doing.

I don't disagree - and in an ideal world every core feature would have
an exhaustive test suite which exercised all the limits and exceptions
of the sub-system. Writing those good test suites is hard and certainly
not something I would be comfortable yolo'ing into the code base with an
LLM.

> A test spat out by AI which is a string of 20 undocumented qtest
> commands may fail before the fix and pass afterwards, but that
> test is not automatically a win if we don't understand why the test
> is doing what it is doing - it becomes a burden for long term maint.

However generally the qtest sequences we see are exercising an
individual device and are not dissimilar to the sequences we see come
out of the fuzzers. It would be nice if we had clear documentation for
how hardware was meant to behave but for some of our older device models
they are more or less written to handle what the guest expects in normal
operation.

And I'd certainly prefer a simple patch to a devices qtest test than an
elaborate test harness to boot qemu and send qtest commands by hand.

So in short - short tests exercising one device are fine to come out of
an LLM if the alternative is nothing. Testing frameworks to exercise
core sub-systems should remain the prerogative of the thinking engineer
unless the maintainer is particularly keen to review a models attempt to
fix it.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

