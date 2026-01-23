Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA71D74EEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJrO-0006MA-TO; Fri, 23 Jan 2026 11:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJrM-0006L0-St
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:18:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJrL-0001K2-3V
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:18:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so17634035e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769185085; x=1769789885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsFNPBIC82pPzUE5zwRKpQZDQ8bjdKNzb5p6ZiAYcII=;
 b=j0GpSj/4qPWB5JpCF9zcO5jAiAcsr/Y9UlhJ+28yW3xmzTbJHhQH7qnt1QqBq+sUaj
 PhhIvWHaVQoA6/hvoAEK/0WduO5h20Fw+sverAsgmM20j51T9pu2KaX54FIxw4JRawBD
 l1gGJc2WRYne1P9KLTLj4p7s3lXqt6Zq9CgHZwoRCgKWtsBalyiM9WGsBSSMHqmwfD/W
 cz8DzuWGphThWzhMEK1F+/SaOs+uPK0WFgVUaezZcpyP+9hMGtg+FUeDy8dxVE4+p3oY
 2d47veiNgbEoZJjpmryHejHZr15qE6aSudbFk9Mr4kRBBmegH4AJ1l7MClP4NJjuF0Oh
 ryqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185085; x=1769789885;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EsFNPBIC82pPzUE5zwRKpQZDQ8bjdKNzb5p6ZiAYcII=;
 b=tq+nSxsn69b+Xx7ovH2LTPilMPwiDBVchx1X0A+st9OYZep4SOQwaa1K7wPF5uCZA2
 rZQVecQBYqPednupeByO73G3NRpNNGBWt766Nv3a9vsspT/TUd0Y2q5Vt7KZlNEo1VW0
 OBM4qNBw6bLBbBeD5Q5TpJ7MG89OF4J19MMPiAflkTvLD2gRAiyrhW7HRFtiYH1c5oVu
 6EsBYpbJ33ocshhXv7DyZ1uzuqFlf7xcSbWhe15l5pMK14zuZBucZWRsXWgbCO1wEoVz
 iqdKrbbAAe8xGdPTLoiodhrQdLk2xeFjWFHuivqgzRSdsKoar9u3inbmiAJHVAs+hxTS
 RFSA==
X-Gm-Message-State: AOJu0YzJAD4v9QvMGaB+zmUnV84EFNR+wi5tX/aR84P+GBHEwWlb8/C9
 WK95Qmm86CRbte/0vKHHdjyRTJbQc4HgnLVB46Dwsg7pcQ1XuHLswCJ3ECFVWmK5SNi25OF/xBH
 DyyByoDmJUw==
X-Gm-Gg: AZuq6aIOth2e7qlbAWdHb7FqH1Nokzz9A2SFmbRpahEYW5gC+2K3KYNV6BZMON1cHj2
 dR0/9rSiFRif8wAn1Bx0+sE59ynnGVuG7K9mUopkQSOIJ0C3bYecmMLYEHAZwjazjM5JdQ3URYa
 dwPMooDMsLdmLMXcTcZc7dtVsMgX3RmUuk/UfQ+tvx7rmu5/Lbi0WhNrBQxc0/Xuvdw1s3D2KTJ
 DVXGuFhQtDYtle2Nr/2VXNrNsBw9iilKGX8xR1BLCWGuQptrLbALViX/Ce7x3Hub5cAJEngb0Ex
 vHrwjHJKS1KPVWbFAvnp0P8L9lJZRoJv/tkSQovrqUGvtFGsPaFsX56aZ+2nUlj1mPfa2ZCasEW
 qCVhIyPnBLkXdVS9FykcI7dpQdyb489wBpTNDpVB0jAcyvnLI3ppE0es8bt3lR4Ecug+N5oEb8w
 8bxQyhGKwELTAul1vgJckdZ20=
X-Received: by 2002:a05:600c:3e19:b0:47f:1a8d:4f30 with SMTP id
 5b1f17b1804b1-4804c9b8e6fmr56757225e9.26.1769185085406; 
 Fri, 23 Jan 2026 08:18:05 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cc278sm140296995e9.12.2026.01.23.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:18:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF50D5F7B3;
 Fri, 23 Jan 2026 16:18:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Joe Perches
 <joe@perches.com>,  John Snow <jsnow@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2 00/16] MAINTAINER updates plus conversion of
 get_maintainers.pl to python
In-Reply-To: <7b42bd50-937d-4a67-8438-777be9ce3764@linaro.org> (Pierrick
 Bouvier's message of "Fri, 23 Jan 2026 07:42:59 -0800")
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <7b42bd50-937d-4a67-8438-777be9ce3764@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Fri, 23 Jan 2026 16:18:02 +0000
Message-ID: <87qzrgl2v9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

> On 1/23/26 6:57 AM, Alex Benn=C3=A9e wrote:
>> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
>> slightly at figuring out what I would need to change in the perl
>> script to cleanly handle it.
>> While we imported the perl script from the kernel I'm fairly sure we
>> don't use half the features it has and as us grey beards age out less
>> people will be willing to tweak it. Consider this a proof-of-concept
>> for discussion about if it is worth perusing this path.
>> For v2:
>>    - added the missing K: keyword support
>>    - added basic --git fallback support
>>    - picked up a few more MAINTAINER updates from list
>>    - updated entries for Arm and *-user
>> I've CC'd the kernel maintainers for the script to see if they are
>> interested in this work.
>> While the python script is still cooking I will send a PR on Monday
>> with just the MAINTAINER updates which are reviewed/acked.
>> Alex.
>> Alex Benn=C3=A9e (13):
>>    MAINTAINERS: fix missing names
>>    MAINTAINERS: fix libvirt entry
>>    MAINTAINERS: regularise the status fields
>>    MAINTAINERS: update Arm to Supported status
>>    MAINTAINERS: be realistic about *-user
>>    scripts/get_maintainer.py: minimal argument parsing
>>    scripts/get_maintainer.py: resolve the source path
>>    scripts/get_maintainer.py: initial parsing of MAINTAINERS
>>    scripts/get_maintainer.py: add support for -f
>>    scripts/get_maintainer.py: add support reading patch files
>>    scripts/get_maintainer.py: add keyword (K:) support
>>    scripts/get_maintainer.py: implement basic git fallback support
>>    gitlab: add a check-maintainers task
>> Mads Ynddal (1):
>>    MAINTAINERS: remove myself as reviewer
>> Pierrick Bouvier (2):
>>    MAINTAINERS: add maintainer for docs/
>>    MAINTAINERS: add reviewer for linux-user
>>   MAINTAINERS                    |  31 +-
>>   .gitlab-ci.d/static_checks.yml |   9 +
>>   scripts/get_maintainer.py      | 499 +++++++++++++++++++++++++++++++++
>>   3 files changed, 525 insertions(+), 14 deletions(-)
>>   create mode 100755 scripts/get_maintainer.py
>>=20
>
> Hi Alex,
>
> it seems like you forgot to pull this patch also:
> https://lore.kernel.org/qemu-devel/20260115202511.2709767-1-pierrick.bouv=
ier@linaro.org/
>
> Could you please include it in the current series to avoid an
> additional month of round trip?

Hmm I did so a sweep and I didn't catch it, pulled now.
>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

