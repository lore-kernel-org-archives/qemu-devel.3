Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6176CD2FEFD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 23:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkspy-0000Uk-4e; Tue, 27 Jan 2026 18:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkspw-0000US-Ae
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 18:51:08 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkspu-0007Y8-CK
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 18:51:08 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43246af170aso222458f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 15:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769557864; x=1770162664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tzvf+JC46AVmQMcqvVrXMY2wwN0IyvSBHdRsns2W3Vc=;
 b=GdlezwSvdBpZCA83dfOrjhzX6tX6cpZdxoYR6TaJVxeOnYm6olZhr1jJEksh+PQvsJ
 s19mYw5VeSBfx8tXdFzqsQuPHtF5Yu0Jq6652ZTMyE8VsyG4a1cqouKOqiTP6h3/6RhC
 7LPJ1MHJjP76Zo3y5OYVQqbhW0Nrhu16L3FXxdkMejH+mVwVhOhSn7YUKfCwdtHuYeW+
 U9zGrYlFLl7vwEV/UuFgr8Tg4TWFoo/+9nJXbSdsKkQvOz/Xhe6iRJnV3LOJTM3RP8k1
 r8t24t5xhYHbvHic6t+W29VNwaOm6Z3zcItLvTkXw7vagU4Ac3UnQ5LGgKpsAywecPJV
 IxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769557864; x=1770162664;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tzvf+JC46AVmQMcqvVrXMY2wwN0IyvSBHdRsns2W3Vc=;
 b=IzytDGRn2P3GyuAOBGsSv8+/ZwR03XfRjMzhVsI6Lg8MTnNYddHA9fS+zBGmJPxmyZ
 IvcHc7b7TR6mYSV2bmfLveCZuOHJjlpI04e87sbxeI50+YoDZ+BCAuJuKc7LLwNK2I55
 5UcAd5LNsVKPkAM+HuTi2j8n/joRo5HtAnhHBhx2bUzHtrQAU7WNpINyqScpuDm1ESK4
 /zWIN5/ykomFT1/3VZ82I08V2e6CRy0kOikK9uIPcek4b+uevMXJlrj4QaYBhsecoWir
 FsX+HSKrEugGoBEWaBGubzOcRgBY7bwNREyqvmNSz0c2V6dEI1kDzNgHs4fPAf+P9YFF
 qKPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/LIOjzoEGUWbU6AIuYWZ54Nr2RHoelGgY/ptIjYXTGv4lvncZnq3oIZS4shvZeQz6QcEfQiT8+OCK@nongnu.org
X-Gm-Message-State: AOJu0YxOIIUQ/gKDqURw62eZIJCeL1Y0vbmhRLeJqEQ/aLkCl2289yl0
 GFC0pqflhLnRDyLhcW3MNz15kHP6q/byEM0cxXfspxaqfTV/FG2+zESSoCDj9T+Br2HaxCpvsNC
 4mVTBtaI=
X-Gm-Gg: AZuq6aJl8H8mQZlcpWPh4ZWDyzziHT8ngmpQcg2E/8KZDTAzk6H6yVE9fmsjdSYfDRj
 daCBa+hXAP6VquZw071dr3tMwPjvYDSGmQmXiroJCgI9m9dlb8IOQ//uJAMW9boIU82ljWFH+bz
 Tl7lDwJopg7wwmVMOHtY3IUTEE1L2O+T3DWfba0gnczRqTlUB5B8hlekkvXnPhJqqI0Nb0pCY10
 WqdE4sWiAvBPUcFGgE6VaRXhpkgDOd5BbRh6NIhYj30ObMARWDT8NNjb4faGlUyc6v3Ge6D34Oh
 ImlBQJ1NIq98FT986dbTvS4vBJtvTup85X3T2CHUMMs6LewKzJ2oZ5QZ5iTev4RaMUjSm4wBuy5
 NnUx6JmdglOxrfs8uRpHNuv02MYaAFASnZrQAV1GdZ1PsmywS1wRmnu42cHltNXiKjEzr7sVSjf
 3qgMACHtufom/U1cJcPQ0QAw==
X-Received: by 2002:a05:6000:1ac6:b0:435:9144:13fe with SMTP id
 ffacd0b85a97d-435dd21d8f5mr4650380f8f.26.1769557863891; 
 Tue, 27 Jan 2026 15:51:03 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm2428020f8f.27.2026.01.27.15.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 15:51:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57D505F7DC;
 Tue, 27 Jan 2026 23:51:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Stefan Hajnoczi
 <stefanha@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab docker registries
In-Reply-To: <4be05e70-323d-42c9-84fb-b66e5579a1ed@linaro.org> (Pierrick
 Bouvier's message of "Tue, 27 Jan 2026 10:28:26 -0800")
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
 <87ecncc4sg.fsf@draig.linaro.org>
 <90520ad2-8256-4bc7-94e3-010455659394@linaro.org>
 <878qdjcslb.fsf@draig.linaro.org>
 <7574812c-c200-49bf-8367-927c3cc7295b@linaro.org>
 <87qzrac46p.fsf@draig.linaro.org>
 <4be05e70-323d-42c9-84fb-b66e5579a1ed@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 27 Jan 2026 23:51:01 +0000
Message-ID: <87ikcmbonu.fsf@draig.linaro.org>
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/27/26 10:15 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 1/27/26 1:28 AM, Alex Benn=C3=A9e wrote:
>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>
>>>>> On 1/27/26 10:50, Alex Benn=C3=A9e wrote:
>>>>>> I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
>>>>>> wasm64) because we base the tests of the existence of dockerfiles an=
d it
>>>>>> now generates multiple targets.
>>>>>> Do we actually use the wasm32 stuff anymore? Maybe we can just
>>>>>> rename it?
>>>>>
>>>>> All of the wasm32 stuff is supposed to be gone.
>>>> I think 20260127092745.2978371-1-alex.bennee@linaro.org should fix
>>>> it,
>>>> but I need to re-read how to trigger the weekly build on my test branch
>>>> to test it.
>>>>
>>>>>
>>>>> r~
>>>>
>>>
>>> What if docker-verify was depending on building the container locally
>>> instead? It would allow to have a self-contained command, that works
>>> the same in local, or in CI, without any yaml dependencies.
>>>
>>> With current approach, it's tricky to reproduce locally as it depends
>>> on global gitlab registry, while we are just trying to see if images
>>> is buildable from scratch or not.
>> No - the point of verify was to check we where building in the
>> registry.
>>
>
> Hum, I'm not sure what "building in the registry" means. Containers
> are always built locally then (optionally) pushed to a given registry.

Yes - and this checks that the registry is up to date. We don't want to
re-build every time if it can cache. This benefits the CI and the
downstream users that pull the images.

> If you want to test something useful, it has to be a build from
> scratch (docker build --no-cache ...).
>
>> A lot of the Makefile.include stuff is legacy now (although its a useful
>> wrapper for building tests locally) because gitlab invokes the
>> containers directly. We used to do all sorts of dependency handling as
>> well but the lcitool approach is a lot cleaner even if we don't get
>> layered containers.
>>
>
> The commit message for 8bec7b9874 is:
> ```
> gitlab: add a weekly container building job
> This will hopefully catch containers that break because of upstream
> changes as well as keep the container cache fresh.
> ```
>
> IMHO, a simple weekly job doing what we want is:
> docker build --no-cache - < $dockerfile

The containers are built by the dependencies:

  needs:
    # core
    - amd64-centos9-container
    - amd64-fedora-container
    # cross
    - amd64-debian-cross-container
    - amd64-debian-user-cross-container
    - amd64-debian-legacy-cross-container
    - arm64-debian-cross-container
    - hexagon-cross-container
    - loongarch-debian-cross-container
    - mips64el-debian-cross-container
    - ppc64el-debian-cross-container
    - riscv64-debian-cross-container
    - s390x-debian-cross-container
    - tricore-debian-cross-container
    - xtensa-debian-cross-container
    - win64-fedora-cross-container
    - wasm64-emsdk-cross-container
    # containers
    - amd64-alpine-container
    - amd64-debian-container
    - amd64-ubuntu2204-container
    - amd64-opensuse-leap-container
    - python-container
    - amd64-fedora-rust-nightly-container

> I don't see what is the relation with gitlab, lcitool or Makefile.
>
> Maybe I miss some extra insights or goals that were not documented in
> original commit, but it seems like the current implementation is not
> aware of what it's supposed to do.

We occasionally see failures due to upstream distro changes. By having a
separate job we can see if it happens independent of testing staging
trees.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

