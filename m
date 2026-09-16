Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B2FC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6roR-00043x-Gb; Wed, 16 Sep 2026 11:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6roL-00043T-91
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:44:37 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6roI-00054c-M7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:44:36 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so9618365e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789573471; x=1790178271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6E1IgLN9n3r8pp9xw0Db4A6fn4PtgPmqcWc5JTN+VB0=;
 b=kzXE03t4813wv2r/cXBe2EykKQlRkcAJTDycZhW5VN1WYUUzk0J4DWxQ9sJ67Mkzl+
 BcjmSsbTPChJXJOJCh3e44bPduPRbO8tTjcpXBgQciS/mlagaSQxewk8MU1EEanyXyNg
 +uuQYJYXxRPYPYrssJkbgd38L40rMtUe5Q0dm5ukTMwMInMxoZAq24a7vdS94JJXouRa
 qfQMIUSMh000GJ4v869QDctOxLyMeGitGqfSMJevt+gHYi6XRhuKbEzkPdgXfADM4h4/
 mhKmiUGXkhPdjQHcXT2ZyLAj6oW4vjeFPJZPeQg5kKq5a50v2JRs8CtP7T+h2f0oI4jd
 j8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573471; x=1790178271;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6E1IgLN9n3r8pp9xw0Db4A6fn4PtgPmqcWc5JTN+VB0=;
 b=wmBTpjNuTMMQl7vM1USAhbcgL0KHNbPc828yQLjMqyS6xi0AyLjg+nS34bWQJcIE9G
 urjOWiMGw48xFgaUrsJN7ovrnF3AWHaObpwOVfToky5FU8+1nVzWpNTb6egZDDKsjoIz
 cHGm0lkEbqabBt78ougMBi316VhfOTcme7oQKpMuM5gpMOoUH8VdusONwbRF+0ziQEr0
 eOdoW8psXVVkL5S1mYRFFeS+JO5jTNSZpm/9xtyD0k8bDeCdkRyes3GgCp9qPbvw8D1C
 BuumKya6KlJoKjwK0ZhL78JxP7rPJZ1W1x5ZmqYGgax6bjmpL4BlikYfxNJH/e21Tk34
 uhUg==
X-Gm-Message-State: AFuF++mElVF0QpwMKXOMq8OAX7KcNeOx+1eg4FRrKll0CfmMBmxChmhe
 l3nFs/qbT0M0aBvHXh7dlZZhuVkqziwd7gRTNmgy51P9R6XJ6wM8oYzS4x4FEq1WioFAnwT1im7
 fUFFWqvc=
X-Gm-Gg: AYBFou38JdsRciSs9UVK+G5b/r+rGUI8GiMV5xC6MotfmQKuOZcWE/JCbjFA5i6vDbJ
 2qOF4pSOBcCqlnIcmZIlGcKLEvt9UNNO8kuoeeJ5rWhjUg+cA9rbHjG25VG3702NAOZ4HEwEA6p
 3/tRMdPa2Crp8lsNyh2jlmgj0UFmHIsvmwKBmdtxs4FJkrylSFjPri/4B11LmFhon3pfWD9ehe9
 NxMaplLzZOH1U7CLe0n5HGp3AUXVsPmPXFaez0YGkRX6oWfNL/XGbpb3sw039R0chVIU6yCtnuS
 zZpSt+5MPH+J6SfRQuoW9ASXnCro88fYBmo1hIFEuI8/0u0a20hBzf+fU7MjZempVXk0Mg9E1qQ
 8SOGlHrGrmtXQfLXNf4FVdkRlM0qbRDApyvga7Gecua7JJUKtnSsmFM3NPeDYDv3cWJWb9yGzom
 JJbXpRyi76631n34jh6mUy/R8R9JGKzfXSImA+rtQsM9JWpsZlK6mzQKgz/LiWEzbAQYMin3Ps
X-Received: by 2002:a05:600c:1986:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49ea528e2f5mr40098775e9.0.1789573471202; 
 Wed, 16 Sep 2026 08:44:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf4161fsm7242858f8f.34.2026.09.16.08.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:44:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0A58618BA;
 Wed, 16 Sep 2026 16:44:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v3 00/17] testing: various docker clean-ups post meson
 tcg conversion
In-Reply-To: <63ab8536-5e31-4101-94f4-005bbc6eda27@linaro.org> (Richard
 Henderson's message of "Wed, 16 Sep 2026 00:47:31 -1000")
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
 <63ab8536-5e31-4101-94f4-005bbc6eda27@linaro.org>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 16:44:28 +0100
Message-ID: <871pat9p5v.fsf@draig.linaro.org>
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/15/26 22:53, Alex Benn=C3=A9e wrote:
>> This cleans up a few bits and pieces although doesn't totally solve
>> the issue of an apparent stall while meson builds the docker image.
>> However with these changes there should be no difference between the
>> meson build and the equivalent "make docker-image-foo" invocation.
>> We also finally get rid of the ill-advised magic caching support in
>> docker.py.
>> v3
>>   - Update make2test to trigger docker build from Makefile.include.
>>   - add Daniels's suggested console: true patch
>>   - fixed up some unref vars from the reverts
>> v2
>> I've restored the configure based compiler checks for so we can
>> build
>> roms and the vdso blobs again. It looks like we could never build roms
>> with container based images so I've left it for now. Unlike the vdso
>> build we can't trigger a container build through Makefile.prereqs.
>> TODO
>> ----
>> I've still got Ilya's s390 test image patches to look at but I'm
>> sending v2 because enough people are hitting issues.
>> I also need to look at the timestamp stuff that Pierrick has
>> suggested
>> to see if that improves the caching from the registry.
>> The following still need review:
>>    tests/tcg: add console property to docker image custom target
>>    scripts/make2mtest: add docker dependencies for check-tcg-% targets
>>    tests/docker: fix brown bag typo for docker-ccache
>>    tests/docker: swap --quiet for --verbose
>>    tests/docker: add container registry to configure and use
>>    tests/tcg: use --add-current-user when building containers
>>    configure: re-purpose the tcg test compiler configs for vdso building
>>    Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* opti=
ons"
>
> Still missing 20260915110855.491985-1-iii@linux.ibm.com
> ("[PATCH] tests/tcg: Fix building outside of the source tree")
>
> which is second behind --disable-containers in my current pain points.

Both those and the SKIP issue are addressed in v4.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

