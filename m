Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29603C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UqP-00024e-Nh; Tue, 15 Sep 2026 11:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6UqM-0001tT-Mf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:13:11 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6UqC-0000MM-Jo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:13:10 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so16141505e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789485178; x=1790089978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MSJjEey9b9V8T1zXiOeWEwoN4KHSvINNd7WN/Om4SLU=;
 b=iz/fWRB3/ZPQCYvylT5R3njhGi4Lmwy9ioMMyTCBibvm+opepmxrZwxJwgkPCyHBJf
 2r1hYa/xsesgfpO624knPr0Cy86BfyCLaBuqWFjRaswV04zedAAZeRpELG8ZBItqsAVe
 69Kn65tHAjxwiMC5cWxUQMkaAWwbHrGIZtlEZwACRnT0Tg/ohvaxMRl22whQTnexu/Cg
 3Tp0qg37QtzNcUhkI2CHV7O6aEGwr7iahqhIsELxmiE3/lChnAidnvhVd1xSemUeqhnJ
 dOXRIk+un7wse45A0ECUEcA0lt+ZbxeVXu+g+zjW1TT6YNHIMOQRzOqmkuXe0DIzKoPQ
 8nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485178; x=1790089978;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MSJjEey9b9V8T1zXiOeWEwoN4KHSvINNd7WN/Om4SLU=;
 b=Jek7K8e7eXmmeVyTfU28STd0DZF5RO89uuzJFXMuj4JrFmU+xdMVdSrVqTvvaIw0g3
 gO8r4sYheSOg/WBNTxjuSpn3JBYwnCihqhxqgyRX6MIvbe0vqRxbZ6lkHCanEbsG241z
 IvTQ/b0TPBM+27JYinZTXKVAmW8nZGf13/RfvEsoigz9O31/64khrKvEhvLwtg1JEZ2T
 e3A+y9f7xTqFmNHptAd6gc2rGXxltQup57yZF6unfDcskg/SOhYSAEDs1JXufBblHETE
 blNSMybws2EHLPYU4+IxjX7LEGpYaGegveB3UG85eAv8/gjKOypE+cPnVrIbhVZkar0a
 F5gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC2Qqa6LqZPMJGzXADyPQGX1UqCpjwKIw0uZbUlnfcX/KyTBQcymLlP/9Jiyh8Altxe2ByHV8pukKX@nongnu.org
X-Gm-Message-State: AFuF++mc2emsy7GM8LRYPaMuTxiQcag9Jn5wCE1CYP3qB3j+KoGgyE+7
 wV2ENw6/8OA6M54LFKnm9RHc6fszGXAP9pSzaV7P0Ny2c3gys21w22UGXgwvrVrAzz4=
X-Gm-Gg: AYBFou151okZNYwYKSHIKplE0rMu615oTNdYzN+TDHpQQF06zc3a7snsuWV0Te8YieX
 lCUBD4+AF+Zx1yldNuzcRBD2tKTiA+81yj2fMBqu5kteVyMdn6PLFkXPkYTdp/5Y+cduOm2Ujiq
 AxDjJBCGp7ansOvas2QWtR/qyIrGM9arHnqEJDGjC7H3WEp0YhWya4l8SaSifDVQfxwCojG5W5L
 KKIe/LPkgRjP5ZfrI65I9BQMAvwp5LHZI0BC8AibO5lcnzyIJzXEaSNl9J/PBdT6rHBwfRJbN2p
 hjzNDPD6PI9kSM2rRjYAZTcu/ya0DrhCxPrHaubQzvZBg9ZTuIwdN2ipubW9EgF9cSksJl/SJRk
 gFt2nDuxL/zqrhBvyPU9j+2lhBBqmbQ2DueFT1rQKI0nNBZqgItvbC0KiWfscNFJB6DFBL3aUPY
 35MorHdy7nGVKbNUN2aGE+XXYoHXD9eJdUNRRGMFDlAYJoCiU/YNG6/aPwq3C6D3za2YHktow=
X-Received: by 2002:a05:600c:c8f:b0:49e:715e:ec1f with SMTP id
 5b1f17b1804b1-49e7a692430mr93573935e9.30.1789485177813; 
 Tue, 15 Sep 2026 08:12:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d27315csm67157425e9.2.2026.09.15.08.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:12:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D46395F825;
 Tue, 15 Sep 2026 16:12:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,  Aniket Sahu
 <asahu1x@linux.ibm.com>,  Jared Rossi <jrossi@linux.ibm.com>,  Zhuoying
 Cai <zycai@linux.ibm.com>,  Joshua Daley <jdaley@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
In-Reply-To: <c203cdd8-9549-4929-86bc-596ae33c58b6@linux.ibm.com> (Eric
 Farman's message of "Tue, 15 Sep 2026 08:30:30 -0400")
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <c203cdd8-9549-4929-86bc-596ae33c58b6@linux.ibm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Tue, 15 Sep 2026 16:12:55 +0100
Message-ID: <875x06blag.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Eric Farman <farman@linux.ibm.com> writes:

> On 9/14/26 1:48 PM, Alex Benn=C3=A9e wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On Mon, Sep 14, 2026 at 6:13=E2=80=AFPM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>> There might be some confusion with what the series introduced. To make
>>>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>>>
>>>> Each tests/tcg/arch declares which container it depends on, and we have
>>>> tests/tcg/meson.build that automatically builds it if needed for tests.
>>>> Reverting that will not be very easy to be honest, as it's a core part
>>>> of the new logic.
>>>
>>> If it is core, why is it patches 102...105?
>>>
>>>>   > IMHO it would be nice to replace tests/docker/Makefile.include with
>>>>> a meson.build too. Yes, that would make it rely on a configured
>>>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>>>> stuff into meson natively.
>>>>
>>>> That's easy, and would allow us to get rid of
>>>> tests/docker/Makefile.include completely, by adding matching targets
>>>> make container-image-debian-*. Also, we can have a top target
>>>> 'container-images'. With this, people can build them with ninja or mak=
e.
>>>>
>>>> As Daniel mentioned, the trade off is to run configure first, and I fe=
el
>>>> it's quite acceptable. What do you think Paolo?
>>>
>>> The problem is that right now firmware builds are broken, because all
>>> the supporting code in configure was removed. I'll review anything
>>> that fixes it, even moving firmware builds to meson custom_targets
>>> even though it seems quite intrusive.
>> I've reverted those three patches - so leaving the TCG tests still
>> to
>> run using meson but still generating tests/tcg/$TARGET/config-target.mak
>> for the benefit of the firmware builds (and also vdso build which uses
>> the same stuff).
>> However I need to test the firmware builds and its not quite clear
>> how
>> to kick that off. I did try:
>>    cd pc-bios/s390-ccw
>>    make
>> but that works even with the current state of the tree.
>> Where is the firmware build documented so I can test the patches
>> before
>> I post v2 to the list?
>
> Are there some artifacts left behind from the before times, that let
> things work as they used to? I don't think the steps I'm using are
> particularly weird. If I check out v11.1.0, I get...
>
> [qemu]# rm -rf build/
> [qemu]# mkdir build
> [qemu]# cd build/
> [build]# ../configure
> ...snip...
> [build]# cd pc-bios/s390-ccw/
> [s390-ccw]# make
> -Wno-stringop-overflow detected
> -fno-stack-protector detected
> -Wno-array-bounds detected
> -Wno-gnu detected
> -march=3Dz900 detected
> Assembling start.o
> Compiling main.o
> ...etc...
>
> Compared to the error I'd mentioned earlier.
>
> The best I can do to reproduce your behavior is to do the above on
> v11.1.0, checkout master, re-configure, touch
> /path/to/qemu/build/pc-bios/s390-ccw/Makefile, and then redo the make.
> But if I do a make clean, or throw away my build directory and re-do
> everything, I end up failing again.
>
> Having said all that, I'll happily test what you have.

I should have something posted soon. I just need to work out why the ppc
vof build is failing.

>
> Thanks,
> Eric

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

