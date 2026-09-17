Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D81C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JzH-0000XG-6h; Thu, 17 Sep 2026 17:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7Jz2-0000Wl-I1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:49:32 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7Jyx-0002C9-Uf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:49:32 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351832so11913f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681766; x=1790286566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D4MMz/goLiadpU4Et634dJgG7s3Iih8vlGTULjp/ZnI=;
 b=ph1m2/FDNcidts4GK2yXm2i3WS7USLSaJg01Ec0l037G/riFxCw7WMFqdz1AtSQiNx
 y/hUW0kQMIRKyW5JQif/Yks3PZpz8bBFuX0u3PUa63spvHQY+sgZMhEWjzmut7wgGHDg
 TdnVowAgaxEqF+imX2kE7l80D8vTn84y3szB0d7nnqqFp4nQfffWypR4HnO42AwdZHcH
 CSFZrCyqTSlKY8ah6ktIHPP8TsRDPIx0rjK4T2ZXGVLcHI4EQWPtgYaS5SDptbj9gkFA
 ta5cleB2D2RXtt0zas96wgHcisCDKOsfNbbwtvVMn+2ZjNq1XpLuNMk5783Jys3/OQXA
 jKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681766; x=1790286566;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D4MMz/goLiadpU4Et634dJgG7s3Iih8vlGTULjp/ZnI=;
 b=BPnqgrcERXbG/oXGhcKG2Mll5mk3ADgdEh7icyI90+uRkmXAUFRDe4YGfODoJRRGXD
 7KjNRqpRch4WfTFg0guHzMYrVOfNPwUFJgidT2uU9aiqLMHtBaePZH2of6rswpKbaOmO
 K6PyqaMoVDlNP/O4AviI4FvELTF9Xo5d/VgiWRavf2vppnAwwV7WK5cVkLIH5vJiIFec
 7c0ZO5GYKANQu7ZuoJ2D5n5jIt0spY5FcFsVPoWCr+IShNniFdPgisgaKDEMxmM6B5V3
 k0rNSMvYcAfeKRgee05B9XH0/a4UZhUQf7adl8MLgJ14Z2UmCl6eROAI6QBtnQqeI//l
 T8Zg==
X-Gm-Message-State: AFuF++nNOP60iAVN5nB93aNBRFXGs22RQ9n10QjRW/nEYpSlc0ss5XbX
 RpoOJx2QC/7FkaUgW31VgXFx6ApF06LHPW0fp1ryIzvH1rEC0rKOY+Qr4N16StSDof0=
X-Gm-Gg: AYBFou28H+Q4zD5lfzKw+B2CNY/8zPktasDnacVphXw6Q1ItrXhRvbm3NplA1PoF7kp
 DFxFzTVfy/dsx2W1PQDCSLrG3zjTsAEP0U0G0nBBmwo0aNvRNS60kpoTAAwJJtJga6w1fp2HLnD
 r72H0A1r7W7EpwqmlLrdauZsoeBCrjx22Dl4i1ay6hCv9NNwvZMJkFIgoUmpYdOU34mO93DsG2y
 MEZGGzzsmqLDxQ1rGA2sbjGF/AwsyOm5pUfTW6AeZ16w+gIwnPcGKhYAeDaUKZj3Odbz4zT0vNn
 UgW3URp9puZ/bPZQ94uWsZxS1psjtYXNh31sZtNnMwGdfF+Sz8JYT3SsIimueHeWImLaYerO+AC
 obaIBE0FiTXXU3Z+id9JnoyTifMNFiIaZcpq/moSuZEfCJEca+ax0vWNwBBmLpRvhSqhMDIT9Kw
 Oo20M182Z++XXg0ge8XVyHXp90kmiagejk9/uzhRzmfp6IK6qmLZpVFzWPW+vkzmjt5D+gvUg=
X-Received: by 2002:a05:6000:2003:b0:487:57d:18c9 with SMTP id
 ffacd0b85a97d-4871e37d1e0mr253772f8f.55.1789681766311; 
 Thu, 17 Sep 2026 14:49:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27df9sm19201332f8f.19.2026.09.17.14.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:49:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D13B5F872;
 Thu, 17 Sep 2026 22:49:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Helge Deller
 <deller@gmx.de>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-arm@nongnu.org,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  David Hildenbrand
 <david@kernel.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Song Gao
 <gaosong@loongson.cn>,  Warner Losh <imp@bsdimp.com>,  John Snow
 <jsnow@redhat.com>,  Eric Farman <farman@linux.ibm.com>,  Cornelia Huck
 <cohuck@redhat.com>,  qemu-s390x@nongnu.org,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,  Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic
 from docker.py
In-Reply-To: <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 17 Sep 2026 14:19:32 -0700")
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 22:49:24 +0100
Message-ID: <87fqz77dln.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 9/17/2026 9:55 AM, Alex Benn=C3=A9e wrote:
>> The caching logic was a remnant of an older time when we had multiple
>> shared layers building that went into the final image. It was arguable
>> that it worked back then but it is definitely not needed now so into
>> the bin it goes.
>>=20
>> Tested-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/docker.py | 148 ++++++++++++++---------------------------
>>  1 file changed, 49 insertions(+), 99 deletions(-)
>>
>
> After testing this series, it's not a good idea to include this patch.
>
> It forces a systematic rebuild, even when image is already. This has
> three consequences:
> - verbosity: we see build log systematically

You asked me to drop the verbose/quiet switch patch which addresses this.

> - slower: running a noop rebuild takes time

how much time? it flies past when I run a rebuild.

> - network dependency: docker.py --registry triggers a pull, which fails
> if there is no network. It breaks offline make check.
> Also, it slows down things too.

we should be able to gate the registry on network access.

>
> So, let's drop this patch and keep the caching mechanism for now, it's
> still useful/needed.
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

