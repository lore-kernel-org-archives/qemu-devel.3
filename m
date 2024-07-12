Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B01C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHDJ-0000PP-J6; Fri, 12 Jul 2024 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHDE-00006F-Lv
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:25:28 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHDC-00065g-Ve
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:25:28 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eea7e2b073so26280101fa.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720794325; x=1721399125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iRIOD4928MYtQ0KgIudiYcrWuwr8gipml48UbyiWBTs=;
 b=G0Z1JQUW+rRoNCL1ZB4GR6/LkGyE7cxGiEdV8y4qjcyyim4kJACv7v+g/tmvMUZ9Hx
 ykjngYSSMtWbjofVsd2qZmgBjiUCtrhhjid915KxycFkb/SFAmq06NYgiAJpl7wRxnlk
 IXttz5eyCy4OtwynHNKAdKvGMBevZHdf4gYZgDPBjqJ4ZwXfyVwNXUxXmGed6nz62L8x
 4c/THlXW056/u5TvE8jwCpoGC5WFxzK3nP2FZ/x7Ll/qv/VdqywLAHPysT7JjH3sMqwP
 hQ+4gcNGcnO7F0IyCntXgGPzitYjYHklBgsT2cZKkNv6fyB4+O8DJbLCl2umg3GrW9yc
 GTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720794325; x=1721399125;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRIOD4928MYtQ0KgIudiYcrWuwr8gipml48UbyiWBTs=;
 b=Kqa9H5Wa5tHvn62+JLi4Eqcl+APfaT7yJ/XvA5wQdhLRqiuYdLMiUUL6m8ELU4iZ6f
 d8DN+o437BfQfcn+3oXkxs/4Q5iDNs1y//JU8Jg5TidBTleXxASdt4zV2CCKENQn0YnS
 YxyTmiU1EONJubIDAT9lyQFpwhN5UWRhYMG786QjTRNeC14RrE7Fhdn2uuUFznEo41vo
 iqhmHSju1CPzAH18HKvkiN6criAQE+g3y3YTfvwkE2XsZM9NxaVJhqdn8m1xWgN6DI5H
 cX9c/t2IR2F80pIKBu/sonKblI2Gs8LXvQTH+K0+W0SlgWWV1pFWQfX63yvtFqyfE92O
 8NDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bGQDBwSiVhfxrXYyap7isNG1sMuEUpuRpYv+4MBDUATCh+wAEru6SfcmWQ9C5YINy1TxLH/qqlCJrhWFnfTg/xmPfxg=
X-Gm-Message-State: AOJu0YxfqToMweefATSIzJWUFC57TaaBCLeYgDtIL5uUUuUEP1GLtlYX
 4RzTFnKYcg/yw84KCEG5o+/Z1hST0uOCLOU26NT57Off+hUZyXZPhUN13wgmRPk=
X-Google-Smtp-Source: AGHT+IH83CoWZlluY6N1czNsmhDDT7Hhy20yFFs+VZSd4vRQLuN/p+W6YNiFzX7OnQpTiPPBpNS3UA==
X-Received: by 2002:a05:6512:1284:b0:52c:e192:5f5f with SMTP id
 2adb3069b0e04-52eb9995397mr8202030e87.19.1720794324324; 
 Fri, 12 Jul 2024 07:25:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6e0633sm345512466b.81.2024.07.12.07.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 07:25:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BFBB5F713;
 Fri, 12 Jul 2024 15:25:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
In-Reply-To: <ZpDV-ghgrxb0hvUd@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Jul 2024 08:07:01 +0100")
References: <20240711115546.40859-1-thuth@redhat.com> <87jzhsdmd7.fsf@suse.de>
 <68c45f7b-4503-41b5-a858-e93f9dd9f99e@redhat.com>
 <ZpDV-ghgrxb0hvUd@redhat.com>
Date: Fri, 12 Jul 2024 15:25:23 +0100
Message-ID: <87y166pu0c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 11, 2024 at 07:44:39PM +0200, Thomas Huth wrote:
>> On 11/07/2024 16.39, Fabiano Rosas wrote:
>> > Thomas Huth <thuth@redhat.com> writes:
>> ...
>> > > Things that need further attention though:
>> > >=20
>> > > - All tests that use the LinuxTest / LinuxDistro classes (e.g. based
>> > >    on cloud-init images) really depend on the Avocado framework,
>> > >    thus we'd need a solution for those if we want to continue with
>> > >    this approach
>> > >=20
>> > > - Same for all tests that require the LinuxSSHMixIn class - we'd
>> > >    need to provide a solution for ssh-based tests, too.
>> >=20
>> > These two seem to be dependent mostly avocado/utils only. Those could
>> > still be used without the whole framework, no? Say we keep importing
>> > avocado.utils, but run everything from meson, would that make sense?
>>=20
>> Yes ... maybe ... I can give it a try to see whether that works.
>
> We only import about 8 modules from avocado.utils. There are probably a
> few more indirectly used, but worst case we just clone the bits we need
> into the QEMU tree.

Is Avocado still actively developed? I thought you guys used it quite
widely within RedHat?


>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

