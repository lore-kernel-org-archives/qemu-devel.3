Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43653CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 18:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st9rm-0002GT-QN; Tue, 24 Sep 2024 14:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st9rk-0002Fr-Dc
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 14:02:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st9rh-0005iv-Cp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 14:02:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9bf9d8bso2303592a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727200939; x=1727805739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL3+jEyy/NcOyFiRt1IcJpPLJeV7VzRsMfPpwY+drRI=;
 b=UHGij0fMyxGGBjngnZIE16DsYWMTpLDYO7R72wxkLpNZwC/pjsV9gGsRE5/Yh4OBlA
 4vsSx9yiON7DpPr7uFivgxPEt1+1tQYGAeNn9spHkdvqcSM579EgfqLznBfH5AMZRL/E
 x66T0+t5FYE+fwFEKEVPSepAtrs4/Qkbv98x6JDiyGX/mXcQDbLOqCT4tFdtaMRRoiCp
 nh5pVJAao+TdNaEoCMJ01HbHCD1PLQzJw+RGuNQ9tBMl3329j5NqUlbSNYV0Apf5I9Ib
 51NWk7+1/nJPlQoJLGCRzqNoHoa7puDPoqu2VkD7vSFQyb0RXGid+fV0ljQm3yMk4fIP
 97oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727200939; x=1727805739;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gL3+jEyy/NcOyFiRt1IcJpPLJeV7VzRsMfPpwY+drRI=;
 b=GfaV+JayE6nWeinvkqhAtb5ofM2+e6eIYEkUmO7PKMuSY0rAYlyLcTWyb6wjEwApF3
 E3NJ4wAWJMqMcfj4wNrx0ahfq6DAKqdgfVezRJsNpeKEx84ID5MOf/J65YgfF6VtKKFE
 5szIMjVBFEYTfYfPnGVuP/0OYvr0lpGD5y+iCArbaaJK7cHF7wxH1aki5J9kma2kyYjb
 L8nMDqwut+TcdcYz9XvrvgX1981HbZoW3bRt7NcRfOYoZEjKxoXZzhZGawm/Q3gZ8BbF
 Y/R3JvdmRWxoxZ0TU4lASHYuv2GGyV0cluGG/6HPOEAtS7ezD2BpAc95qnPEv7/DtuCr
 At9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjdc9qCfj4UE6+F6JNDm0J+GsOwxksrqXhsIOg1UJeMMzo5Lk/mkg72/GFSYKWrpWcUr3FtDcP8QWZ@nongnu.org
X-Gm-Message-State: AOJu0YyoQ0TZtyWIecfzipPDFadMjWMqKTPS5w/GnB0S8/51/dtdFKXh
 fUguotWfYFwlGM/I8ncxyUry4LHz07SJVdoxBaK67fZZEGJNHtqUE1oVZDJAL8k=
X-Google-Smtp-Source: AGHT+IEmQj9SNGtCs/BBHDw3aWLugpUsMz7saeOICmN0vrqxwEoF1n6NlAXGtHtUKLxO1UXH4TNl8Q==
X-Received: by 2002:a05:6402:2812:b0:5c5:b9bb:c341 with SMTP id
 4fb4d7f45d1cf-5c72074d13fmr128941a12.26.1727200939148; 
 Tue, 24 Sep 2024 11:02:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf48c10esm996955a12.13.2024.09.24.11.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 11:02:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48BDB5F790;
 Tue, 24 Sep 2024 19:02:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Mahesh Bodapati <mbodapat@xilinx.com>
Subject: Re: [PATCH] tests/docker: Fix microblaze atomics
In-Reply-To: <c0d81e09bd1ce5ee49dcb48715102efe2a1dbcb8.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Tue, 24 Sep 2024 14:22:57 +0200")
References: <20240919152308.10440-1-iii@linux.ibm.com>
 <87wmj1clmh.fsf@draig.linaro.org>
 <c0d81e09bd1ce5ee49dcb48715102efe2a1dbcb8.camel@linux.ibm.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 24 Sep 2024 19:02:17 +0100
Message-ID: <87o74dc4ly.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Tue, 2024-09-24 at 12:54 +0100, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> (add Mahesh to CC)
>>=20
>> > GCC produces invalid code for microblaze atomics.
>> >=20
>> > The fix is unfortunately not upstream, so fetch it from an external
>> > location and apply it locally.
>>=20
>> Queued to testing/next, thanks.
>>=20
>> However I didn't see any tests failing so I'm curious where you saw
>> the
>> problem? Would it be worth adding an atomics test (microblaze or
>> generic) to catch this?
>
> It's very reliably caught by the new test that I'm proposing as a part
> of this series:
>
> https://lore.kernel.org/qemu-devel/20240923162208.90745-19-iii@linux.ibm.=
com/T/#u

Awesome. I saw you had posted a big gdbstub series. I shall try and get
to it once I've finished travelling.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

