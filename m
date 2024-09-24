Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E95CF9C77
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4FX-0004lO-Jc; Tue, 24 Sep 2024 08:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st4FU-0004jk-W4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:02:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1st4FS-0000q1-Rq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:02:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso840850866b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727179348; x=1727784148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuuvURNEDrn7DdCUH9sba2r2p+y/5CSIHv9Ue4dmD8k=;
 b=L3OeUYyEF8IM2lL/BzV4WfG82v6omBmn+QWnX/a76FO+TOymIU/hk9EumjJv+Nbc0z
 r1FhuPHE2wnrmscWrHTks8Xmih0goXKZqaK2lvWydXUMzZTzZ86iShj5y0aDc8tTnVmj
 CMM0K1RTnwN6DndJ21pntY3/1Qd5lbAB3wWwPUlomW3jxLT0Zs/MMZKB8aQ9lTcO1Kke
 oggjjuqG0eUwFVPJ3tj6JG8vMnRxGBFVefJ4ecT5v5JS0cSdB/eBbs/J5EwL65mnVYWz
 bEHCbqDPqY96BNIT8pEwil9Qa//jQTZfNYx1tc0LcP3IYF5wlCJ+LaFTinZQDdjxOisW
 Uk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727179348; x=1727784148;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuuvURNEDrn7DdCUH9sba2r2p+y/5CSIHv9Ue4dmD8k=;
 b=EEL4AvlA9bdWKttUD1xRxBAvwZBsW6+G84vaeNvrordArsGU37wDJmLq9/5WHC4Drt
 J19XofrEWQemFl3GMGeDGlHO20bu05dC/H3GDC7DUNxq8i3k726d0/omu9cp/RuNsq4K
 VKvSImCCLdttxXEqzZ/XmNNvS6MRf6RR0iXQLvmVe1LH3i3C4NlA+0jcaqpJJGVZhSor
 Ys9QXQAIsOG6aUUhVOjIBVW0Mp8JaNV3gL0y1Qt5Mk3z/dypkdcoFibryKeGc8lfRf8S
 rT1GIrWpxwhV8IZL0tXsNNYg8arQUQkcxO0NsHiI+WoXXnLtGT/6GGQUiDNcJIyDjy8p
 iHkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKz2/1XL2yxQxzLl5qYv5ipU42Q+sAT7Fg1zl1K8vO/3lSfTpgwQuh5qE6FtMJ9/FaE0mB5408D4Fa@nongnu.org
X-Gm-Message-State: AOJu0YzNzGqS9ufh7A92fKekXZXQzgonRv08PtWvDOdKjDZjoEDxtZrw
 OjNuZmTMjzPYrgE2+adt28JvrXUnGmJ6Xvis/oUk/Ul4yOGMz2qUF/JTDq6VQTw=
X-Google-Smtp-Source: AGHT+IFcdicU5SIrsvSBEfNYHGJVgbHjDDJh4o4Notn7yy6ZiPIftuCqV3AArnxU/ME+0vopkGBrmw==
X-Received: by 2002:a17:907:f1d6:b0:a8d:2671:4999 with SMTP id
 a640c23a62f3a-a90d5012dc2mr1263558766b.39.1727179348293; 
 Tue, 24 Sep 2024 05:02:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f3490csm76303066b.21.2024.09.24.05.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 05:02:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E16FB5F77C;
 Tue, 24 Sep 2024 13:02:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,  John Snow <jsnow@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini
 <pbonzini@redhat.com>,  Gustavo Romero <gustavo.romero@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
In-Reply-To: <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
 (Manos Pitsidianakis's message of "Tue, 24 Sep 2024 12:25:50 +0300")
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
 <ZvGbRWSPPLJDx7BX@redhat.com> <ka5ia.wqlrej2ef9q@linaro.org>
 <ZvJ8JblXVH-kJGi1@redhat.com>
 <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 24 Sep 2024 13:02:26 +0100
Message-ID: <87setpcl9p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello Daniel,
>
> On Tue, 24 Sept 2024 at 11:45, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>
>> On Mon, Sep 23, 2024 at 10:09:32PM +0300, Manos Pitsidianakis wrote:
>> > Hello Daniel,
>> >
>> > On Mon, 23 Sep 2024 19:45, "Daniel P. Berrang=C3=A9" <berrange@redhat.=
com> wrote:
>> > > On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pitsidianakis wrote:
<snip>
>> > > ie, look a query-audiodevs to discover what audio baxckends are
>> > > built-in, don't look for CONFIG_XXX settings related to audio.
>> > > If there are gaps in information we can query from QMP, we should
>> > > aim to close those gaps.
>> > >
>> > > IOW, I don't think we should expose this build info info in either
>> > > human readable or machine readable format.
>> >
>> > QAPI/QMP is not the perspective of this patch, this is for people who =
use
>> > custom-built (i.e. not from a distro) binaries and want to be able to
>> > identify how it was built. Launching a binary to query stuff is
>> > unnecessarily complex for this task, and the info is not generally
>> > interesting to the API consumers as you said.
>>
>> Launching QEMU to talk QMP is our defined public API for querying
>> anything about the capabilities of QEMU. We're worked hard to get
>> away from providing ad-hoc ways to query QEMU from the command
>> line and going back to that is not desirable. It may be slightly
>> more complicated, but not by very much.
>
> Again, this is not a "capabilities discovery" API. It lists the
> build-time configuration of the binary. Perhaps we can expose it in a
> different way so that people don't end up confused?

I think the problem is however much we might say it's not a capabilities
discovery API it's very existence encourages users to use it as one.

What about a script:

  qemu-get-build-info </path/to/qemu>

which would launch the binary and query it over QMP? Would that work?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

