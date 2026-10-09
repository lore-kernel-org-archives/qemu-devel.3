Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18DCA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCGr-0007QX-MY; Fri, 09 Oct 2026 11:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xFCE3-0006x1-PN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:09:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xFCDx-0005xa-PZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:09:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso40979085e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791558565; x=1792163365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F2KW6dznVqnEht1y+F7rtwx2UD/9slOEMe+Zxd3r+rE=;
 b=DhXFbOCaKzmP6t+ICbPx8R5MmsxOKaZBptF58KkJfy+856yftC1CXnD+VmJalE8ely
 DB2aVBboZgOKG56yqoliKy2f+6PSPM4zj03lo9fcCiptmvu6wB9ruy1f/6g8qxXSG9uQ
 amZ4lTrAjhO9Kzn7Rhc203szyDhQ2gYtBPtUpUz0pu6sndD0v9xxNFKfTQnm7n6bpIfS
 6LQ/+tJ35hVWwjsr2OfgU3XpOLqXq/j6eVcVTOx3MlAkOgNRG1J2NezuICUV6idjfd4P
 hmQyjYirmJjAEBJv2esSbFgXyuMg/k5N504mxFabcNjduX5C6eGHKpKIBsfsaKdfKX+4
 Xs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791558565; x=1792163365;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F2KW6dznVqnEht1y+F7rtwx2UD/9slOEMe+Zxd3r+rE=;
 b=Gf7KgJWEX3V2UgmtWuPXvzKJ3FjuAaOwk7RZ5k7dDD7tIL54bjvZcTPb2uFWVP0Lyb
 FTlaVxCaQa67tZihKS8OOotGYFPg53iOEH45VR61P4DJoHPvEUWcSPR4EsR9dlnX/m4L
 vrGXusKFzljC7U6CgVyRmIfD4EYZwITbDKOD64cqzFVYpRwo41BRAozdQm2u+zvNrZJ6
 ap/jJn5sFqws1NrE5yNJ92p1XATwZhMx7yOIWQdVdULaCh7LUAw0CUNyKiSS5dE6lC2B
 8hL0qKnI6IwvneMRox1OoTgx9QH/GKM7/fWfYHw5EnFMg9ugNRAwLK9bv0uLjslf+D/w
 foNA==
X-Forwarded-Encrypted: i=1;
 AKwUvByX3oiHyQC4uHjL+EpvADHGOVTb4jnUnGXz3N2PHAk25CTEUG3jxcD7hcSd6XEYGsOx6emY7S3q6e97@nongnu.org
X-Gm-Message-State: AFuF++ntcPBw2+3L04daDh1tAHHPqnp6lldPj+9BQH1GO6fZFDuUBxPD
 X0HW7JsCUiuBudDQn2Xv0KpQ0gqLagRHXQ3hMU978Zx/53zjazZjxp9a2IGMKd+O8udvhLTsPTH
 93EZic9A=
X-Gm-Gg: AYBFou1cCgOD+fJJkOmwzXGEkLhF3arfqqawl9Oq2jVm6IXG7Qy/KOyubYi0ah6EW5c
 HV8iEG+/6WhzjuIlxBplde/jNY6uoW63UVBw/FGBXliajPcVtTcBrQhkCxzpwhMfrewUO9tIA6t
 W/jRUmQ4T7VvS/BY61DAc8DDnyUxzyXJdd6jGUFwOkAqwkJVM5kEyRSeVp5ZNb43Sj3fGPno6Sr
 r0bA8G+jWTSi5FOxGdifGnouj9alUdHpPPH84k+7ogivdTKwUSIrJL1LL82txSFNKn2qPcEJBhh
 Z5Q8dgIoISyuhvS9EN6kfnZo44KxcILsGgdYtLqqAP7lBV/6u+1pYTWmHhb71aVtsCHXLDIBRMq
 fKyWdEnxg8PTHd+nLrMhiCcK75FybC9ltwFPB6qtcoRBRa9GK7dXvPwRQO5dMvezzAepQ77+l6J
 dNZ7DitVEI0WtHduJEyXBpTWq/Bvmj2jxB2jH/Cz1Vb1z6+GurOzLhJB/yW+jk9zMVrnmnhQSYQ
 M0JikYOOQ==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a18e446db6mr42510975e9.1.1791558565148; 
 Fri, 09 Oct 2026 08:09:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm70316235e9.10.2026.10.09.08.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 08:09:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 05F105F8BB;
 Fri, 09 Oct 2026 16:09:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  qemu-devel@nongnu.org, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
In-Reply-To: <87tsmv6ne9.fsf@suse.de> (Fabiano Rosas's message of "Fri, 09 Oct
 2026 09:58:54 -0300")
References: <8733vbtmge.fsf@suse.de>
 <asgp6ld6Loz1xmJg@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87tsmv6ne9.fsf@suse.de>
User-Agent: mu4e 1.14.4-pre5; emacs 30.1
Date: Fri, 09 Oct 2026 16:09:21 +0100
Message-ID: <878q463o7y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
>>> Hi, I just wanted to share and ask for feedback on some container images
>>> I've been building as part of my testing of migration pull-requests.
>>>=20
>>> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>>> following:
>>>=20
>>> $ docker images
>>> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
>>> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
>>> qemu:11.0.0                                   018a3f0f4dcc          2GB
>>>=20
>>> This last image is stripped (for size) of everything but a few libs and
>>> binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:
>>>=20
>>>  CMD ["qemu-system-x86_64"]
>>>=20
>>> The point is that I can wrap it in a script called qemu-system-x86_64
>>> and run it interchangeably with any other qemu binary during
>>> migration-test:
>>>=20
>>>  QTEST_QEMU_BINARY_SRC=3D./build-11.0.0/qemu-system-x86_64 \
>>>  QTEST_QEMU_BINARY=3D./build-master/qemu-system-x86_64 \
>>>  ./tests/qtest/migration-test
>>>=20
>>> (note that migration-test spawns the qemu binaries itself)
>>>=20
>>> I run tests against the previous 3 QEMU releases. At every release I
>>> build the container for the new release and at every PR I build the
>>> container for that git hash using the latest tag as a base.
>>
>> I'm not a container person,
>
> Me neither, lol. Last container work I did was back when multiarch
> manifests were being added to docker. Maybe 2016? I (clearly) haven't
> kept up with the progress in the area.
>
>> e.g. I did test my recent channel fix on
>> qemu-7.2 by simply building it with build-7.2/.. but after learning it t=
he
>> idea using a link to kickoff the container is very interesting on its own
>> already.
>>
>
> Yeah, the issue is that `git checkout <old version>` and try to build it
> is pretty hit or miss.
>
>>>=20
>>> The reasons that lead me to this solution are:
>>>=20
>>> 1) Migration compat testing is special, the two migration peers can run
>>> in different OS versions, so their QEMU builds can be quite different. I
>>> cannot test using *just* my dev machine, neither using *just* a
>>> container. I need two hosts. Or two containers running different OSes
>>> that can both be reachable by the migration-test binary running in
>>> either of the OSes.
>>
>> True..  One thing I want to make us on the same page is, this is about
>> distro, not OS?  Say, the kernel is still the same.
>>
>
> Yes, it's about what it takes to get a working QEMU binary. I'm not
> trying to cover a realistic migration scenario, I'm simply trying to
> test across QEMU versions *somehow*.

You could just consider using the system qemu if installed and then we
get the variance between versions from which OS's we build on. That
would work outside the container and we could include qemu-system in the
containers as well.

It would cover the migrations from the various LTS qemu's to current
master which should be the majority of common use cases.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

