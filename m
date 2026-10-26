Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31960A381C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ONqGoYuV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNJ5-0005Qi-2p; Mon, 26 Oct 2026 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLNJ0-0005Pj-Td
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:12:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLNIz-00080L-31
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:12:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1574760f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793031131; x=1793635931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ycmooINHiCUBXKcsH9mP6G/KjVcguXUhbnVJK6FzmhA=;
 b=ONqGoYuVe/0rhjnyF/2z8gub73w9oVaggkX869BRwvaTytzzk6rFbXbj/qsp1N9DPL
 IAVud/OGBh7xq4bOTF6LDYFUxzAp16z39pHmec9TM73itmzoRE581apKVR8heQ8ZCJ5N
 80tbY0A0Gpb+VajypcvEPI3YCQIVw5QiSo+nxjJJGqblVxzv695UBAjuR5yXrg+h2qzt
 EcxW+Fj8HPW8eX+8y4D2ICtY86cx0swTSQ/dHJu+2gTtFUJx7oYeGWFoUqrz880Pngqd
 L/D4a1aDBAWUh4DQ0cKqNNGIZPdYneMdwZ/DRzcwFdg3zdcxRBbY7jBnmgBF3n2Vt0iL
 O/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031131; x=1793635931;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ycmooINHiCUBXKcsH9mP6G/KjVcguXUhbnVJK6FzmhA=;
 b=1WYJ0TTNJTx1d3ObuGnAIyHka2df5algsm+n0H8w4xAA35iuNRVfeiRhv72C4F6+Dp
 WpEpng/khMWNuO9REvxcaIxyBlB++lIoD0vZ6HCPB1C7Qv5tNpQsdluMwTIEIs1Zr6bz
 GRZ45v8NRUHVM8APA1JCaAFSPUL121GZPi2ATkgj8PTJ2MxvsZiUShSlYgQKf0sPw9Ad
 ketER9CiH7MwxkCfifEjGVhG0W5FD951YxXHQFWDuqqCcMpjwgkuJ6nuD61l/M4YFm3p
 txlqZpVxLl+TNxt9fpeDadcg76qaGGMsBoIONuzoiN78Ue6JP0YLFf3MGcX4C7g+V5hM
 K3Ug==
X-Gm-Message-State: AFq9FYLsVzcXXcwfx1x+cBLPybejgg5UQf+1vsW/3PyjRnv2Gbhv333U
 Ua6gaTciTcwfTv+bw6WZIdoWieNPrt0WMh8zqK5Vyd4yhDkHM9MkA3oovvqrcz87I68=
X-Gm-Gg: AYBFou3kBQGeBOCgfmeWU01XLVvO7VtQKMFj1c60EMykF7GYCMhjf7XHAsBssfip7bf
 FrieuSVhuElu9GRHoY3craSrh2+YIuf8lzEnZfPUdzmrFLOpVNOJX042yX+A6G1De9tz18aILj0
 x9Nh9AdneSZydlv2s45bNBdzXY8Z+vfSLeGLG4KYc4bpHlQEXK7XIXgGrLxBOObtN2cosArFV2y
 xbNaW8nf7leGg81eCLvRk6Jy8HaO0XOrpvGLfL2h6QQbNmTU7OmPW3L0jEVmRwSbogWaS5J1/aF
 j15ULgH/xupTBb5sCYecgwyQ4Ocd5lRFYxjuq0Ww4TShjyzJgAn2R8qw7PFp6JxTQd6bvuFaKly
 h5PxDrD9yJNEG8qGYoRJJ1Uyci1fKVq0g4ZS9KZKn/kfcc9h2EwXibaCigL0GHI0BbtH9STA1SZ
 tAVX4H3evZfszQaHj20IgfyVOLDg5br/8Wmbq8HF+/4gccD1Pxxz6LoCznhEVeQKG+BVVFShuUN
 xPrPsqtz6MEtXn4IlReFxYxbOxcJ/oNYDZgNQeSBfszsiRq/VUde9ePrWVFaO15zx41cyx/Ah9l
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id
 ffacd0b85a97d-48e3eb971ccmr15551944f8f.31.1793031131222; 
 Mon, 26 Oct 2026 09:12:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm17884944f8f.38.2026.10.26.09.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:12:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 631EF5F7FF;
 Mon, 26 Oct 2026 16:12:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Troy Lee <leetroy@gmail.com>,  Hao Wu
 <wuhaotsh@google.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Mohamed
 Mediouni <mohamed@unpredictable.fr>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Joel Stanley <joel@jms.id.au>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,  qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
In-Reply-To: <ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com> (Thomas Huth's
 message of "Mon, 26 Oct 2026 16:53:43 +0100")
References: <20260624103049.884930-1-alex.bennee@linaro.org>
 <20260624103049.884930-7-alex.bennee@linaro.org>
 <ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Mon, 26 Oct 2026 16:12:09 +0000
Message-ID: <87se1s4f1i.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thomas Huth <thuth@redhat.com> writes:

> On 24/06/2026 12.30, Alex Benn=C3=A9e wrote:
>> To enable full architectural behaviour for A-profile we need to do a
>> number of things:
>>    - add support for the event stream to wake things up
>>    - add support for potential trap on sleep
>>    - handle the global monitor's interactions with WFE
>>    - remove the M-profile specific gates
>  Hi Alex,
>
> this patch broke the test_arm_quanta_gsj test in
> tests/functional/arm/test_quanta_gsj.py. The test is not run by
> default, so nobody noticed. But if you run it like this:
>
>  QEMU_TEST_ALLOW_SLOW=3D1 QEMU_TEST_QEMU_BINARY=3D./qemu-system-arm ./run=
 \
>   ~/devel/qemu/tests/functional/arm/test_quanta_gsj.py
>
> you'll notice that the test never finishes on the current master
> branch. When switching back to the commit before the "enable WFE"
> patch, the test works fine again and finishes within a minute or two
> here.
>
> Could you please have a look when you've got some spare time?

It works on my current dev tree, probably because I have:

  Message-ID: <20261012134840.1051969-1-alex.bennee@linaro.org>
  Date: Mon, 12 Oct 2026 14:48:40 +0100
  Subject: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

which needs a light re-spin when I have some spare time (sorry it's
review season so I'm trying to get them all done by EoTM).

>
>  Thanks,
>   Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

