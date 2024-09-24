Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B2CCF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 09:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st1oD-0006XY-VT; Tue, 24 Sep 2024 05:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1st1oB-0006X4-O2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 05:26:11 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1st1o9-0007aa-KD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 05:26:11 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so439561966b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727169967; x=1727774767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Edh4ELRTxjeBHWkCcQqzyXmOlL3xCL4a+YNzqR6DTI=;
 b=R+GlJT5LVRtzNnm5LxX7Em1QgntetmUkfpS8V59Ezn1x14KDwreQU4HeRSby6ukB26
 QJmJFf48KFHWGabcXQ0VM7WpiqThgFihUM0lgIk6rY/x31nPkQ0HJtHPGMOJOYBn1wTA
 uy+zc3F+YDv0hBcIoB5gARsKP1UFevgyMwpiy8+uY08/1169aAcxiF57+hsYYdYLpLH4
 OVYS9hDMW40aIljSTyDA3CXQDMnktpaLWQ8WiODuiedDVAXzHjgOpiffvqwIEMkZwQ5c
 if7CWURcFCtPzmlEkAkXgQ7syyY/T5Z98fhVcW9awbUR9+6s6E1bMaei985aWzQShAh7
 oPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727169967; x=1727774767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Edh4ELRTxjeBHWkCcQqzyXmOlL3xCL4a+YNzqR6DTI=;
 b=dgtjw/KyeneEg9/YW5x6nnkvH606vRLMKNIHZgb67Aos978mih7UDYswleJxqa5hE9
 wHbUoNUFbfcdkNLFziqUkt0Pj28JlKse3YvPnp9obdYzlF28+rr3ua4/5LWUrM8iwfSr
 bF2frkrKyVjKcoCbzdaN4UYO/GoFDhAuVu1bFN1E7ekcvrwt+wQYEQqGqfNfrPytguSK
 Au+U+go4S95CS/IUySvKpOFdpvJIOk8fT/4FrwHNtJ7LZdb36XiNcC3wWMAPikdQYBMX
 I54ZsywfTsgJleCG7a+V8mK4Dxg1JJrjbL3UGLU2Qp/43Q+SvXyabyl2TINZ48q7LqZ2
 zHdw==
X-Gm-Message-State: AOJu0YxsqDMqT3MCL56WaSbGTBANfpellL1eyiOCiRKWV+rRe7GhNe0X
 agukyvZMyLdrtjbqmtdmaJJSSdB7DCKNn6CU7WhAi0XmWu73MKahDZPO5ksFQZrHtH9CY4sibxl
 9DrQO/63ZxAFSYny7AeFdrwPeLGR+mfEb798tmg==
X-Google-Smtp-Source: AGHT+IGzxuEP4boLmZHFk7MjL1j+VBuB912W3sr5nhT3uHDIj87Js+1Mv+HYKcU+gpgIKOY0o5YWp6e2kRlZJkjj/6M=
X-Received: by 2002:a17:907:e6a1:b0:a77:cf9d:f495 with SMTP id
 a640c23a62f3a-a90d5813b2fmr1583738666b.40.1727169966696; Tue, 24 Sep 2024
 02:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
 <ZvGbRWSPPLJDx7BX@redhat.com> <ka5ia.wqlrej2ef9q@linaro.org>
 <ZvJ8JblXVH-kJGi1@redhat.com>
In-Reply-To: <ZvJ8JblXVH-kJGi1@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 24 Sep 2024 12:25:50 +0300
Message-ID: <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

Hello Daniel,

On Tue, 24 Sept 2024 at 11:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Mon, Sep 23, 2024 at 10:09:32PM +0300, Manos Pitsidianakis wrote:
> > Hello Daniel,
> >
> > On Mon, 23 Sep 2024 19:45, "Daniel P. Berrang=C3=A9" <berrange@redhat.c=
om> wrote:
> > > On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pitsidianakis wrote:
> > > > Add -build-info and -build-info-json CLI arguments for human and ma=
chine
> > > > readable output of build/compile-time configuration data. The sourc=
e for
> > > > this data is the meson generated config-host.h.
> > > >
> > > > This information is mainly of interest to developers and other folk=
 who
> > > > deal with many different builds of QEMU and need a way to properly
> > > > differentiate them.
> > > >
> > > > Because there's always the chance someone will want to consume an
> > > > interface programmatically, also add a -json option that does the s=
ame
> > > > but outputs a machine-readable JSON object.
> > >
> > > This turns our build system configuration information into a
> > > defacto public API, and while its using JSON, it isn't yusing
> > > QAPI.
> > >
> > > To some degree we leak our build system config names externally
> > > because the "if" stanzas in the QAPI schema get copied into the
> > > docs.
> > >
> > > Overall though I don't think we should be exposing this build
> > > config infomation externally. We've had many times, particularly
> > > with testing, where people have wanted to access CONFIG_XXX info
> > > about a QEMU binary, but IIRC we've always steered people towards
> > > querying for the actual feature they want, rather than looking
> > > at CONFIG_XXX settings.
> > >
> > > ie, look a query-audiodevs to discover what audio baxckends are
> > > built-in, don't look for CONFIG_XXX settings related to audio.
> > > If there are gaps in information we can query from QMP, we should
> > > aim to close those gaps.
> > >
> > > IOW, I don't think we should expose this build info info in either
> > > human readable or machine readable format.
> >
> > QAPI/QMP is not the perspective of this patch, this is for people who u=
se
> > custom-built (i.e. not from a distro) binaries and want to be able to
> > identify how it was built. Launching a binary to query stuff is
> > unnecessarily complex for this task, and the info is not generally
> > interesting to the API consumers as you said.
>
> Launching QEMU to talk QMP is our defined public API for querying
> anything about the capabilities of QEMU. We're worked hard to get
> away from providing ad-hoc ways to query QEMU from the command
> line and going back to that is not desirable. It may be slightly
> more complicated, but not by very much.

Again, this is not a "capabilities discovery" API. It lists the
build-time configuration of the binary. Perhaps we can expose it in a
different way so that people don't end up confused?

Manos

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

