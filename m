Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B68D19523
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 23:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkWLl-0005zi-GG; Mon, 26 Jan 2026 18:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkWLk-0005zR-Da
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 18:50:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkWLi-0001vg-LB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 18:50:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso58069175e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769471425; x=1770076225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEaUomKudLQ6HYYJjv1cFbMaycCRyA2FLEh+cnzxyD4=;
 b=oatuoXOYuJrV16m8zG7cdcbXubT+5WbBs9Bc0QT41ppIirkU+G+8YM9Z7k5ZvYZq6e
 1D+kzgchBDKIxPbz6+3lQMT5V9W2FYVHMzCkTyKSuCGpEjlQmhuZM5pzg4C2tXK4310Z
 n1woxzmS5zG1Oo2px7jSXNuliQAP+K3wjjfllBCNf83DBw5TEeXZW0QnsyJnzB4LrAIK
 HBqwPBAKQGHaKn94+1k4uO/gV5aKRodp66aP0aDF6kvhVHn5XTd2/y+Xgw/OeVkfvm1s
 EFUTc3FyEymvjYFgPl4Xyw5Gjx/0oak/AxkvKrTph1stsIQtnHPL7cCz7uWAzccYT3Pa
 u34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769471425; x=1770076225;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CEaUomKudLQ6HYYJjv1cFbMaycCRyA2FLEh+cnzxyD4=;
 b=meeGMr4R5ZooIDtD+I3EIhrsHr9WmMSwEA0OvfgalF0aVhbKhnQ07MP3l9zOMOvaY0
 l8pKjR93lxJJVLBWGEVsxmKhRBAfFS74/8tXfa38J4DvE/MHV1OIMbCfLOcKxiV9LMHu
 Bu5O675z9Z4FZESLYzIqQL8iynzMcyaLmHpzYnrQI6JlY/VTFAknkG8l5WMFxUyYdfVS
 gDDChbRcGvEKcuyjY430OmaQd90LPoUJ1GYEIXt482v9uOXfdn/jiQ/xu6/IMbTNHvdO
 Gk9GL1yty3nXtua1XHPiV/YtOiVsTUX28bAVE6BWRl84N/Y0DvX5WCwkR/pQe1Rn6wk0
 qeIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNEUK3WZKigxmM+WJ7ySLLk3TFLXVi53e1Nqf3VdT/TR2Y9QXYxV10Ni9+DVbA5z+lQ8dwjOkUSC4x@nongnu.org
X-Gm-Message-State: AOJu0YzEguS35JYyT6IjvRumefDDraI5q/X7lJP1fDZ5BT9uHv4pdmMh
 IpeYxKc1U2cvWDLiiCUMB4yzsVLTtqKw6Sn5YE3Ds341JR2LRYw3yi/k1mwW8h4UY73lUm5v5Wp
 Q1XhstTs=
X-Gm-Gg: AZuq6aI3l8GQTtDzU472dyqxodCWWU2BQ1xjko7exl/rBhPJ9tNcE/SPOWQHywwaiLH
 1X3rpwrfcONjs6CQ9cVfSdM6WypniQbmMsG5vCd6yK9kb8IG5psRSEowfdJQuAy/5lz9sYF11Og
 kjxg+klhDPLdrjs6fc0AQ23BR2fqZp2z/J4y2Qyjn5O/ojVw58Ptsqn07QT8r5aJv6k2YGotgIM
 +Vh844GKN5Ce9ayHOmiq9DIobp07wwJf7pmPqUxQ0MvfG80w6eUK3cQGg4+zFT4WRtRiaQaYQbp
 UpFormb/eD5rOFHE3P8s37tZl8KhkPB5wag7HE74QgT01MBAnre0vHP3latLjkZOH/HDCtWdqEW
 CsdfvFXdN5dQKqqctQus1XZA+hT0YXnq1W1Z7hCalEotBS9VcU1mFSp+agG/ieSmYQZ06oJobtn
 oNoxMga8ow627U
X-Received: by 2002:a05:600c:3ba5:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-4805d06c7aemr90200815e9.34.1769471424799; 
 Mon, 26 Jan 2026 15:50:24 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bf93cesm19516195e9.9.2026.01.26.15.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:50:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A9DC5F80B;
 Mon, 26 Jan 2026 23:50:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab docker registries
In-Reply-To: <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Jan 2026 14:12:56 -0800")
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 23:50:23 +0000
Message-ID: <87ecncc4sg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> On 1/26/26 2:05 PM, Stefan Hajnoczi wrote:
>> On Mon, Jan 26, 2026 at 4:55=E2=80=AFPM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Hiya,
>>>
>>> I noticed this today, wondering why the daily scheduled builds are fail=
ing:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/12868286187
>>>
>>> time=3D"2026-01-26T17:34:06Z" level=3Dfatal msg=3D"Error parsing image =
name
>>> \"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\=
": reading manifest
>>> latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: =
manifest unknown"
>>> make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-c=
ross] Error 2
>>>
>>> I'm not really sure what the error message means. Do we need to push a =
built version of
>>> emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn'=
t make much sense,
>>> since the job is all about a weekly rebuild of the containers.
>>
>> I don't see that container image in the registry:
>> https://gitlab.com/qemu-project/qemu/container_registry?orderBy=3DUPDATE=
D&sort=3Ddesc&search[]=3Dwasm
>> Only the emsdk-wasm32-cross and emsdk-wasm64-cross images are there.
>> Stefan
>>=20
>
> I don't see where the job that is supposed to build containers weekly
> is building them, it is just calling skopeo inspect (???).
>
> It should depend on building and pushing associated image.

I think it was broken by 4203ea0247f (gitlab-ci: Add build tests for
wasm64) because we base the tests of the existence of dockerfiles and it
now generates multiple targets.

Do we actually use the wasm32 stuff anymore? Maybe we can just rename it?

>
> https://gitlab.com/qemu-project/qemu/-/commit/8bec7b9874235e60f1417261812=
1c60fdbd39302

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

