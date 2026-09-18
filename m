Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A235EC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XDf-0006CI-Mz; Fri, 18 Sep 2026 07:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7XDb-0006C3-LW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:57:27 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7XDZ-0003tz-TS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:57:27 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso3454835e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789732644; x=1790337444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IUwAX9bleEAKJ0c2PYl3tD8d1S8g4JpqwvSQWkT4XEU=;
 b=VsQbAVAfRarUaZ446olCUDD31MP+djvle57H0B8S6rFmwurye7dulNAgUhjjVC3Qen
 y0YMuMHXM139JaMOM2IiWlUESX7j+ISrg/Z+248cPEKrz7U7TZYoJLFudyck9ArJR2HB
 v5l2r5EgTskw+80rXqvvJKp8wxQTbm+iZyj5m7CBSzpTvAxmU5TCs9uj/J/NtHoqG6Rr
 k1lrdPEMhe09BpDRQqR5DICP5oxey8sA5yIwpoVbmn1S380OhiRXQmVIldbCGSIEmpqR
 hDly0S3NyLKUxOqOAp0aO0BvAArFfzYTSPwxT5pYkHmx3uYKZYMoLXgusLjkKhR16zel
 huiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789732644; x=1790337444;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUwAX9bleEAKJ0c2PYl3tD8d1S8g4JpqwvSQWkT4XEU=;
 b=ZGQKl6dRt4L1/4F8d2n0uqYit0lHwFQFahD2Fx5i1VKIIeL7oJW9ff6b/KlHPbau7a
 EOzg4Ih1EhbOyEIqZnXJAS+l/nWYIbYion4GVGr37Eu+b9kSvnuT3sU5BRiZ2AtqMloS
 U/BcUHuIvO7hm8QS76usEoxhJY8elhvG54nodVUE//hJeiQ68TxKSML1qsJ3OuwoF1J4
 NQiePVtwNqF5oWZUec8bxatkINzYV9/WH5SY3yZPOk9lZKkP5+71/7JZCj0yNFbF3RYv
 SYDsPt6ZckT5cLt86x4RUy8JtGulII0bGY86j0/H100fZK/fiPoJG56l4xoy8eFhbb4+
 zSCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXyoDdrPFytL3tIqqOn9nJMiDaLhtC6uk4VtzTNU0vyqOK07BWZiajYqq0hi9QZWfl7CTHrhgZk1wS@nongnu.org
X-Gm-Message-State: AFuF++l2WpZzmm2aQA5SpIbOk2wEA4KCFt01Ag3RuJ04i32wpkpCWogC
 v5m3M0p6kbLK2BHk4uDoT5Zon6nuq9stkzek3VtwYCZAwqLuICPoDSXJG27xZXBDFYk=
X-Gm-Gg: AYBFou1z94G2PYV8177AaOrWX5DNzm9oKb6TT4Jsnrv/Q4/kT0ZQobD5k7JtIpuTAYo
 iVAgsbdbB1OnJ8MtoLdpNZKbv/k0rAG1uDr4eXjqjx1yhvjyXocrjrijehoTJP8aXfY1fEMnSQO
 iG8Pi7LmO+A++oNufLpceH6mIB78nSQ1qSVhDpKYvJBewM+q16dMlRtr125t1drca0vJmx/LkJa
 06ZPClc0lji9hfoNo9qQqepnglNfxsUO1GIpMTqCPEorgyu/dVBWgmip4922QhE2y/yKZ+taQ7S
 O6CCqIAzxy+Jll7q3+JM2I9taYtFrLtEh1nLcE27Grn/oIqa0pQoPz0WukrcSMMg5ZLsHIy63Z4
 IueOAuZWpsqkcvMq7ofPMY70NRRuj7Q60LitZkqAg29sIrtNDHbeDoQeJIbDTxedl7LSp/QUUNt
 N9xO1lVt6h3LtyZjgGgn1lagsF5aVZuRMXdeQlZXUL+ax+JU1ysu61W50fkhTJJuPpUquidaE=
X-Received: by 2002:a05:600c:5250:b0:49f:bd0d:59f5 with SMTP id
 5b1f17b1804b1-49fc5746338mr29243525e9.18.1789732643747; 
 Fri, 18 Sep 2026 04:57:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48720072501sm3498882f8f.22.2026.09.18.04.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:57:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAF785F8B4;
 Fri, 18 Sep 2026 12:57:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic
 from docker.py
In-Reply-To: <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 18 Sep 2026 01:05:01 -0700")
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Fri, 18 Sep 2026 12:57:21 +0100
Message-ID: <87y0cy6ace.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

> On 9/18/2026 12:30 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 9/17/2026 3:18 PM, Richard Henderson wrote:
>>>> On 9/17/26 12:00, Pierrick Bouvier wrote:
>>>>> On 9/17/2026 2:49 PM, Alex Benn=C3=A9e wrote:
>>>>>> how much time? it flies past when I run a rebuild.
>>>>>>
>>>>>
>>>>> For a no-op tcg-tests build (i.e. with tests already built):
>>>>>
>>>>> - With current patch:
>>>>> time ninja -C tcg-tests
>>>>> ...
>>>>> verbose pull and build
>>>>> 320 lines of output
>>>>> ...
>>>>> real=C2=A0=C2=A0=C2=A0 0m15.817s
>>>>> user=C2=A0=C2=A0=C2=A0 0m1.342s
>>>>> sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.840s
>>=20
>>   =E2=9C=97  time ninja
>>   [1/114] Generating qemu-version.h with a custom command (wrapped by me=
son to capture output)
>>=20
>>   ________________________________________________________
>>   Executed in  515.16 millis    fish           external
>>      usr time  433.82 millis  968.00 micros  432.85 millis
>>      sys time   86.05 millis  253.00 micros   85.80 millis
>>=20
>> Not sure whats going on there then. The whole tcg suite completes in
>> under a minute (and would be shorter if i386-linux-user-test-i386-fprem
>> and riscv64-softmmu-plugin-discons-with-interruptedmemory where in the
>> thorough test suite).
>>
>
> You need to run "ninja tcg-tests" explicitly, as tests (and images) are
> not built by default.

What is that target trying to do? Because when I run:

  ./run meson test --suite tcg

it still ends up rebuilding the test binaries.=20

>
>>>>
>>>> The variance from the middle of the pacific ocean, and associated
>>>> network latency, is between 20 and 27 seconds.
>>>>
>>>> Amusingly, with the network actively disconnected (airplane mode), the
>>>> no-op build completes in 1 to 2 seconds.
>>>>
>>>
>>> Funny, on my side if hangs a long time (timeout 30s), then retry 3 times
>>> per image. I tried it on WSL on my windows laptop.
>>>
>>>>
>>>> r~
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

