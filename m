Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD507D44171
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 09:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDhN9-0002XI-J1; Wed, 20 Nov 2024 04:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDhN3-0002Wm-Kc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:51:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDhMy-0001I3-Fc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:51:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so38778945e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096289; x=1732701089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJYsRSWgcz4BwilxxNJFZt2MFA/o6kcs0RqiAFj92RU=;
 b=Yo+Rbjs+0Uy9uOpRK9h8OiQqOlwSz/pHQmcadJfxatE5V7JxpkOpYTs145iM7h+M5w
 CZsE/VegdJL1o16Jj0PmiNI3recG8K8/ZCLePw1FPUX2VBoSCd9xN7vbJmMZUfnJOqTx
 UE8SwtTpDf3ziaJr9ZD6rxWJ5Cr5kapv0sOzzzEe4X6eJRhN9jUbofNsOLG1y67z3X4i
 pORCPk6bFGxbh/gNIux+gyyIi7+8xTVSxDoWk75+XgXGaG9gDouEo/lrF7TMcBuuS6Cv
 s0YoTuA6U0AUSdn9W9wdByLmj4x4HV7YwlhCUXFlZpf73soBFIQrm3ca5RXNpKRwk6/h
 p+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096289; x=1732701089;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJYsRSWgcz4BwilxxNJFZt2MFA/o6kcs0RqiAFj92RU=;
 b=EVvFsWGw3hm/lKbtR2sC2IWdeSEkLcqly6If0L5S7g2BSJCRTU0+NK99BIu1rt5vQI
 D45JCNupmfiIfV1V9llp+HRWNHzkMNXwexlRVbPX+mLFzAy5FbIN3Mwjs2f6qH01c3fw
 SEXNv/O/HgITZ/vvScJgPo7Q1ceeNefHgTF56QDJMJcmYQWVghZU+mlmy5MMGbzQt6To
 Ai2oFz/VS3tK8hRi2v8sXNiLasJRH4+eSvh2ShqEoxz64sUzQWFO2DMOfduhfEwkW6im
 5cX5vFdZSPipytHxQF3vue+T10mfIKIwpGMF0UpM5CTvi7OJz2EZWbVTxw6K5Fvj9aA1
 d2Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCxx6ObPc5TBbwz/SJfdCkJdf1eq+3BwUMN7NDQuHpzHRGL+4pQ5A+WtEktVuMQ3KDksy5VpBjjt6@nongnu.org
X-Gm-Message-State: AOJu0YxdgcrbG/btT/oE7MqdRWgUvro4GMEv0Zw0Ghpz7soRdep6q/Nf
 YsCSo17m7w8R5HXjD4MGe0GcV0HWDAjTEyIup401YKjzU6EZtp8hsFrQhm+YGAI=
X-Google-Smtp-Source: AGHT+IEdNiv3ls/lWXB4P3KGIGsml6qA+EcGH+NguZ/OwWqb6xYRrYYDqkboN84EQomz33c+jQ0miQ==
X-Received: by 2002:a05:600c:4fcc:b0:431:542d:2592 with SMTP id
 5b1f17b1804b1-4334f02a963mr16608595e9.27.1732096289298; 
 Wed, 20 Nov 2024 01:51:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825493ee14sm1534556f8f.99.2024.11.20.01.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:51:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFD405F8C1;
 Wed, 20 Nov 2024 09:51:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Andrew Melnychenko
 <andrew@daynix.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org,  Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org,  qemu-block@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
In-Reply-To: <b9df48b7-c1a9-4a46-bd78-b7ecb8328b33@linaro.org> (Pierrick
 Bouvier's message of "Tue, 19 Nov 2024 22:25:37 -0800")
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
 <ce090d62-89a8-4f1a-a864-add24704dd11@linaro.org>
 <b9df48b7-c1a9-4a46-bd78-b7ecb8328b33@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 20 Nov 2024 09:51:27 +0000
Message-ID: <875xoinsgw.fsf@draig.linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

> On 11/19/24 00:41, Marcin Juszkiewicz wrote:
>> W dniu 18.11.2024 o=C2=A018:23, Pierrick Bouvier pisze:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-=
a-patch.rst
>>> index 349c32ee3a9..953682f20cb 100644
>>> --- a/docs/devel/submitting-a-patch.rst
>>> +++ b/docs/devel/submitting-a-patch.rst
>>> @@ -237,6 +237,20 @@ attachments can be used as a last resort on a firs=
t-time submission.
>>>       .. _if_you_cannot_send_patch_emails:
>>>    +Use git-publish
>>> +~~~~~~~~~~~~~~~
>>> +
>>> +If you already configured git send-email, you can simply use `git-publ=
ish
>>> +<https://github.com/stefanha/git-publish>`__ to send series.
>>> +
>>> +::
>>> +
>>> +    $ git checkout master -b my-feature
>>> +    $ # work on new commits, add your 'Signed-off-by' lines to each
>>> +    $ git publish
>>> +    $ ... more work, rebase on master, ...
>>> +    $ git publish # will send a v2
>> You recommend 'b4 shazam' in 3/7 patch so why not here? Both 'b4'
>> and
>> 'git-publish' seem to do same stuff - handle patch series and send them
>> upstream.
>>
>
> Are you using b4 for your QEMU contributions?
>
> When I started working on QEMU, I tried it before git-publish and had
> an error when trying to send my series. I don't remember exactly what
> it was, but something related to finding the reviewers for a given
> commit. When I asked, team members pointed me towards git-publish.

I tend to use b4 to apply patches because it works well with the
archives and collects together the tags for you. I have not used it to
publish patches to the list.

My sending workflow used done manually (rather via my carefully
customised Emacs org workflow) but now I just use git publish to send
series to the list. I still occasionally use git send-email directly for
sending individual patches with something like:

  git send-email --subject-prefix=3D"RFC PATCH" --to qemu HEAD^..

I still send pull requests by hand:

  git send-email --confirm=3Dnever --quiet ${mailto} ${series}.pull/*

but thats probably because I haven't figured out the steps for git
publish to do that.

Anyway tldr; b4 to apply *from* list, git publish to send *to* list.

>
>> b4 allows to keep To/Cc emails inside of cover letter which makes it
>> easy to not miss anyone needed.
>
> git-publish works pretty well for me, and does what you expect (keep
> your cover letter/cc and track your versions).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

