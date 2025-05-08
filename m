Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2334C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyhs-0004EH-IP; Thu, 08 May 2025 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyhr-0004E6-7H
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:42:23 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCyhp-00074m-L1
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:42:22 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e7569ccf04cso845852276.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746700940; x=1747305740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dl5pV5vcVm1dasoPUhfXujACXbPasmjxei6f60Du0Ug=;
 b=oViuryUr/gruYvPgTgU0fOrnrQVIBcITu5gndjR+ktOMa5DSD6QwZn1dORRIgwjOcE
 RIHNFW19A4frtNuKohX4Nk5bt4clCVE4+cR5clTH1ZUfgpVsV34BvKUsYv/Xvn7JbXLz
 CL8GDwO9ipzbVNeZNQ6kecaUl3EDieW/xBOCMTPGRDUq3QMc0LpC7bfZuDQkPRhAFfWm
 /wUHWoEaSk/Ofnn01LEvNGLjOMhnLlsIIUwI3It/1f0YJC0plWLouXfMpNoT6br99TER
 SE3L4FWIz2xI4tKD4UPIliCujAITjOF+iVV7EIckhdgOMqHgjoe+2GyuZwHTGNReACKN
 gNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746700940; x=1747305740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dl5pV5vcVm1dasoPUhfXujACXbPasmjxei6f60Du0Ug=;
 b=lKa01hzqsk9O6f8B0JjCvl0JCqmhcB/e5xBCsQzr6ko/jpxwni5yNAz9HO8GVm/jzx
 BiHqJHKR/wl7fupY2Y6mla8bim+hyNzbAGgIjStkRhQVILqyOnMUNgvSKGca+TaAE/Ug
 D3739HjaPQnyyxC2It7PA1NYrmbZXC9Iq5o2iJGPMV0F5xY8XVn5neJ9Jr80+ebFiMnA
 V5mtXexzDFHP5+Ww5mWLZUgWS1BDPlMcyNpvyGVnQZA7CUu+5y+F0sfWoS8maKG/UVik
 UL7u7hfKO4rNsCGxdQ53JxDD+keWvc1e37zNTVpYyTI8i+M+bqGVx6CYhMMwlF27S1Xg
 md9g==
X-Gm-Message-State: AOJu0YyBXdqAK2OhPq5e+xhhvcTB4y4s4A3h7QpeIOInj5LmeWG+b3WS
 2d/GfNjy9FFPZYmlM7E00qLaw5nTwBC+BbB+9bfo1etS+B08s7CO9sDbr7vNpYjfQee1ngJIF59
 oH2iAcFujoK0fg/44r1kqLPh/ASgTFjBsPxOVAw==
X-Gm-Gg: ASbGncs7/n/iEsW+mSKQYMQgebL9XCxV0vHXhNllHq3qM6XvuwXMibIfgSk/0p9QfSG
 ahdDpCWtAIMVfc4iVHT/ea4sp2TjaRjTqLT9AckTDaGF8NbEf+OIexf+D6UoZLMO/X6gKKXwrhZ
 YSwvZmLjaduNHETfHV+eeVirUsNFZbAqn7/Q==
X-Google-Smtp-Source: AGHT+IErpQfVma+urjA4dPTnBF7h68qN1UXWXcDx98dGQR1ao3YcuwxStnA1GUccQPfzeAR7ZTu47BkGuxnYFvbBSl0=
X-Received: by 2002:a05:6902:1027:b0:e73:2ec1:1e83 with SMTP id
 3f1490d57ef6-e78ef661430mr3505467276.23.1746700940580; Thu, 08 May 2025
 03:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250228154450.3185564-1-berrange@redhat.com>
 <20250228154450.3185564-2-berrange@redhat.com>
In-Reply-To: <20250228154450.3185564-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 11:42:08 +0100
X-Gm-Features: ATxdqUENdgiuwhPRj3kCk84fEvcSIu8VqE_z1ovq-7Mc3UKS-XLeuTz7MJq8peU
Message-ID: <CAFEAcA-vd0z_yi3O8EBqaxw2xSZFKmvDj3_npCJ8qjnycLJrcA@mail.gmail.com>
Subject: Re: [PULL 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Fri, 28 Feb 2025 at 15:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Going forward we want all newly created source files to have an
> SPDX-License-Identifier tag present.
>
> Initially mandate this for C, Python, Perl, Shell source files,
> as well as JSON (QAPI) and Makefiles, while encouraging users
> to consider it for other file types.

I noticed recently that this check doesn't actually catch
all cases of new files without an SPDX tag. It looks to
me like the logic is wrong, unless I'm misreading it:



> +# All new files should have a SPDX-License-Identifier tag
> +               if ($line =3D~ /^new file mode\s*\d+\s*$/) {
> +                   if ($expect_spdx) {
> +                       if ($expect_spdx_file =3D~
> +                           /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
> +                           # source code files MUST have SPDX license de=
clared
> +                           ERROR("New file '$expect_spdx_file' requires =
" .
> +                                 "'SPDX-License-Identifer'");
> +                       } else {
> +                           # Other files MAY have SPDX license if approp=
riate
> +                           WARNING("Does new file '$expect_spdx_file' ne=
ed " .
> +                                   "'SPDX-License-Identifer'?");
> +                       }
> +                   }
> +                   $expect_spdx =3D 1;
> +                   $expect_spdx_file =3D undef;
> +               } elsif ($expect_spdx) {
> +                   $expect_spdx_file =3D $realfile unless
> +                       defined $expect_spdx_file;
> +
> +                   # SPDX tags may occurr in comments which were
> +                   # stripped from '$line', so use '$rawline'
> +                   if ($rawline =3D~ /SPDX-License-Identifier/) {
> +                       $expect_spdx =3D 0;
> +                       $expect_spdx_file =3D undef;
> +                   }
> +               }
> +

The logic goes:
 * when we see a "new file" line, we set expect_spdx to 1
 * when we see an SPDX tag we set expect_spdx to 0
 * at a later point, if we still have expect_spdx 1 we complain

The problem is that the "later point" here is "we saw another
'new file' line", not "we got to the end of all the parts of
the patch that touch this file". So if the patch adds two
new files then we'll warn for the first one (when we see the
"new file" line for the secand new file), but we won't warn
for a patch which adds only one new file (there's never a second
"new file" line) or for the last new file added in a patch
that adds multiple files.

I'm not sure where the "complain if expect_spdx is 1" check
should go, but I don't think it should be here...

thanks
-- PMM

