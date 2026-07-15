Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2567C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2PC-0003zl-E0; Wed, 15 Jul 2026 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk2P7-0003zE-NT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:24:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk2P6-0001Ul-1w
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 12:24:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so1825247f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784132650; x=1784737450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rXcFovKhBZkGu5sLV06dZIsy6dWh7Ruxk3bF6oViZms=;
 b=rFYO4cWbVbk2WjJa9g2vaBNNOuyuYWhrziw0ja2hcbI/Y9KsSG7zOpUeVaz5s8NzO1
 t3sZ1YFYmKjlC/UNQz/URQw2YuIEb+aGGcd/9P75OBdSLy1xqXaCHeMCYZKw0HW9SIp3
 OiAj4FcZSBPvq9pjaRxJL5c84G0rvq8VUdK+8WQAn3Pu7eJswoyTwJfgnB9Oi231vaJD
 vLmxYrpUKVR5s+WrlMJYX+HH5FC3omYqGu4/3eRvRiFRiJRxtW+FS8PC1nSFm+JAxs2E
 lCFbb7WL6GpAmKPoEbsr3Idoy2o9/Li0891AbCwsvZdVS95+ipgGKPJ+S93yzbrK4nQ3
 HIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784132650; x=1784737450;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rXcFovKhBZkGu5sLV06dZIsy6dWh7Ruxk3bF6oViZms=;
 b=n+TdN7TnrsLBsIaJy2HTjrKxdEfEhBPsmOtIW+cs1yj7FTbGHTfoDG1Vb/wUU88TIm
 VkhjO8K9+fjnE7sl10YL9AsRVxtkIXP1lbLog86f4lVIhKdrMlJtyTJPqQcGG9lqjUTA
 3pQeZ7Fast+uaDh7YKLiXpclVeZxHrwBk1yy0+n1QAx6xhbvQsPjoJN422Cp5wFkpAmf
 KxOah/26ZLCvaLzxFuIKvJz476204eQSaoh5s8jwjfAek6rHJmvcVJ4Gk64qZvR7imNl
 WNaW3tJ2e2nnwbNxrydEuLi3e0d/fi8/yS48fUJoVVCmXAexjVpNyQ20VaV6rNX+VA25
 /G7g==
X-Gm-Message-State: AOJu0YyeFGKE0CuYgr2N+JT3I5csKbQRwyy1tJ9ej08SiTqe5MFt8ai5
 6vnscGMiVqI75JTjNGAM3cvITDCe6UJdHx6rQKyD+X0wNBZBlubo+ud//RnE4Ac3Xac=
X-Gm-Gg: AfdE7ck3xsdw30Jt+nDBdQMLL0acQ/GtzOvab2MIduLghZD3O2JzXiOSeoSFtsJB4Uq
 xMJKtZ+tcZubJCGwbhGDLZiPkZPBfyKyFDIwG+suTd9LCsRaNio0r7roRHsXuIK8i9HfWqmB5cc
 7oR/mjBGXTr680b3gcbh90t6jAcTQxZQIIpT5SOH3UFv1jdCW9Zse+71iv3xRasVUCfYLz6eOvG
 EjBfHh5QDrh93woxSC5xpTIIZYtJji1Ar7IAMo9+ukPtwc+NqPt2X+WTUQOceoDABT3LNf0f77T
 nyzG1IF+ljX4IE+/yy/5Z8uULRxwIkNg/eRoVtagSfo2CkaZtJL0W+pzLO/aEd3P+Rpr7NA/IKo
 rPS+Frp2PrIOoMC0yCWc685qN/ZBQAD2aCBSA1r86lmkz7cLYxvfwrv5s9qZtf24XdyoS9uI8DX
 6OoYsiteUwcC+OL1sf73/8hGk=
X-Received: by 2002:a05:600c:1d16:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-493f87e72b3mr187027205e9.13.1784132650227; 
 Wed, 15 Jul 2026 09:24:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c59b810sm72037615e9.0.2026.07.15.09.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 09:24:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7CF325F892;
 Wed, 15 Jul 2026 17:24:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
In-Reply-To: <8cf29764-387d-4465-b630-db1742a58eda@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Tue, 14 Jul 2026 08:53:27 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <87cxwpj3rj.fsf@draig.linaro.org>
 <8cf29764-387d-4465-b630-db1742a58eda@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Wed, 15 Jul 2026 17:24:08 +0100
Message-ID: <87v7aggr13.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> On 7/14/2026 2:53 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> This series replaces TCG tests makefiles with meson, with the
>>> goal of having something more readable and maintainable in the long ter=
m.
>>> Also it closes the gap that tcg tests had with the rest of tests, by in=
tegrating
>>> them with meson directly.
>>>
>>> It covers all existing tests for all architectures, including
>>> user/system/multiarch-user/multiarch-system. It implements all requirem=
ents
>>> listed on original thread [1].
>>>
>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>
>>> We also have for free:
>>> - correct and complete dependencies for any test, including:
>>>   scripts, c.inc, headers, reference files and binaries/plugins.
>>> - catch test declaration issues at configure time vs test time.
>>> - proper data types for variables instead of string expansion with make.
>>>
>>> Series first introduce the meson machinery needed in tests/tcg/meson.bu=
ild, step
>>> by step. Then it adds support for all existing archs. Finally, we remove
>>> Makefiles and configure bits, and add documentation.
>>>
>>> Usage:
>>>
>>> ```
>>> make check-tcg
>>> make check-tcg-aarch64-linux-user
>>> make check-tcg-aarch64-softmmu
>>> make tcg-tests
>>>
>>> ninja tcg-tests
>>=20
>> This does work but I couldn't see tcg-tests (or individual tests) when
>> running:
>>=20
>>   ninja -C . -t query all
>>=20
>> (which is what my Emacs's helper uses to query potential targets from
>> ninja).
>>=20
>> The plugins, unit and qtest tests all appear in the list.
>>
>
> This is because tcg tests are not built by default (so not included in
> all), but they are under target tcg-tests.
> Good news is that updating emacs config won't be too hard:
> ninja -C build/ . -t query all tcg-tests

Thanks.

The helper is intending to be a generic introspection helper for
multiple projects. Do you know if its possible to query for the list of
groups(?) with ninja?

I guess something like:

  ninja -t targets | grep phony

would work but I wonder if there is a better way?

>
> I enabled default build in v2, but removed it in v3 since it was really
> weird to build half of the tests (with native cc available), and leave
> the rest (based on containers) out of it. Now seeing your emacs
> configuration, I'm even more convinced it would be very confusing to
> only show part of them by default.
>
> There is no way to make all tcg-tests appear in all target, since it
> would imply we trigger container builds by default, which is a very
> counterintuitive default IMHO.
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

