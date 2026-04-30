Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46365FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGP-00042b-SF; Thu, 30 Apr 2026 10:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIRJV-0001a1-B7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:20:21 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIRJT-0007TP-9p
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:20:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so150624466b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777555217; x=1778160017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fnYBBYy2EYk15bHVbZ9tfKZ146WA5IDA1keM9Clsyg=;
 b=Rw5v9QMmI/qTyaCDs2P8aODChA7iRGKfeCZmDefxenUGY8AaFGfWiG9Mm+ncNQB0ce
 S9J7pQF9TNNZNXYeh3shi1eJfhb2Tzj+O6MWuDS0CsYMpAe0rnWB0VtVzV5sh9w85pXh
 CcDPjkrWr4CLnJ0GAn43KwWOToJpWlsaQ3MWmRHuEu6sWyKajRsK3bgQ4sAWEs3LBRis
 gCj30hyKmfj+lopUpi4RYRXyYlr66AHUTxGzjhsAOuf4nU+e2PBcbMXJ28NygbqUsc9e
 yGIa8cS5h6Nrgloa9/SVLDrJShYdsp8pfafBh23qcotU+W3bMKlnxTkrzgZ5eugrX35R
 KYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555217; x=1778160017;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fnYBBYy2EYk15bHVbZ9tfKZ146WA5IDA1keM9Clsyg=;
 b=GJB8AVFwuQG8+PKyq2wr7B8g18KAMcaOMPlpAlJj7RXpITNR59fCtiBazeiJWtSQME
 A0qpEqJG5XE3uWtnEau1whZKXuYzu4NCswjAaYNbnT8EMzqzFGycW0cWDwd/lMrvI/a0
 1/bw+2rl+QpA8R078cre0TVEnzdXNfaUn8KazCVVOGi9dfiXPhqqlZiVfaoHkx/dJzVU
 BwDQKsHpioxuTMObDUk9H4fVKNAQhVPEva2fL6pmkK/Mc0lllruC8GPzVArEBaeypKJo
 oLbU4Wn2k5UIAukCEURdzvfqg+lofW3OxXVSgtPQZrTp75qeQVwH6TF/xPUaX6HfJ5BB
 93xA==
X-Gm-Message-State: AOJu0YzQN6P3SWVzfIx2hzu0h8jFAHdI7biUDWfblKWS13kPcozd55Fb
 G/R+OUD1zMmGaYoFF2BRPorW6eyzvl3fgQSPf8tbg7VliiCssvATYnZOjL+5RzoNIJp9SkHBH0b
 ee8im1NJYRfp3
X-Gm-Gg: AeBDieuUe3paBYXkGLBGkASTVWjFM/RN4aI6hOKKmUmhmRXohq26Wkjdyx47w0U3Gz4
 3ghZAutXv6CrAXjMDMIA8XvNv4DCw0B2m4/A59RSJrq4Sew2vBrJQUajBKRtt/On4i/OUmA/usz
 vd2RpM2iM8Z/RLVXrWroA70qVrS44F86udhwfHM0Ny5C+y/52E0dq30cAsyfysMzvlfrfi5EKLO
 7GztRZc6I754MRgZXCBPt2r+7hNSubuEwRVAmLNg50arbHlXLWdBqnoYkPHeOzhuD6UgY9LvbEo
 yBFX3Vga7BBTMcxegwNVYMpsIWdeon26csv5pAoeJAhsFjqLz9qj9iW7j/ZebcHjpr1x5ke77GP
 ehP/VKRNf+tzZooK5bfXSfwML1QoeMb/Dz+barQbFye3Qpl1ekDgkOZUIJWh0AYoUVI1wV5GMVm
 MfF7VjucJ/GSwyVgzSu1tgySODEOe2iqhbOQ==
X-Received: by 2002:a05:6000:22c5:b0:43f:e42d:ece with SMTP id
 ffacd0b85a97d-4493d7fac8cmr4657151f8f.1.1777554605279; 
 Thu, 30 Apr 2026 06:10:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm2646452f8f.31.2026.04.30.06.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 06:10:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57CCA5F856;
 Thu, 30 Apr 2026 14:10:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs/devel/decodetree: Fix formatting in "field
 examples" table
In-Reply-To: <CAFEAcA-JEtwT_AkKHQCOgvRjkAwcO3rAZjv7_4rdpkyQHEQGVw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 9 Mar 2026 16:45:14 +0000")
References: <20260309152617.1611566-1-peter.maydell@linaro.org>
 <87fr69ge53.fsf@draig.linaro.org>
 <CAFEAcA-JEtwT_AkKHQCOgvRjkAwcO3rAZjv7_4rdpkyQHEQGVw@mail.gmail.com>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Thu, 30 Apr 2026 14:10:03 +0100
Message-ID: <87bjf0egr8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 9 Mar 2026 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The rST syntax for a table uses ASCII art to draw the cell
>> > boundaries; then inside each cell the text is treated as a body
>> > element, so it is rendered the same way as text at the top level of a
>> > document.
>> >
>> > The "field examples" table was assuming a "literal document" format
>> > for its cell bodies; this meant that the single line cells were being
>> > rendered in plain text, not a fixed width font, and the multi line
>> > cells were rendered as definition-lists because of their "second and
>> > subsequent lines are indented" layout.
>> >
>> > Fix this by consistently using inline-code markup for the left column
>> > and literal blocks for the right column.  (We want to be consistent
>> > within each column because a literal block renders differently to
>> > inline-code, with a green background.)
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> > You can see the mis-rendered version at
>> > https://www.qemu.org/docs/master/devel/decodetree.html
>> > ---
>> >  docs/devel/decodetree.rst | 44 ++++++++++++++++++++++++---------------
>> >  1 file changed, 27 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
>> > index 98ad33a487..33cd6fe583 100644
>> > --- a/docs/devel/decodetree.rst
>> > +++ b/docs/devel/decodetree.rst
>> > @@ -64,23 +64,33 @@ A field with no ``fields`` and no ``!function`` is=
 in error.
>> >
>> >  Field examples:
>> >
>> > -+---------------------------+----------------------------------------=
-----+
>> > -| Input                     | Generated code                         =
     |
>> > -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
>> > -| %disp   0:s16             | sextract(i, 0, 16)                     =
     |
>> > -+---------------------------+----------------------------------------=
-----+
>> > -| %imm9   16:6 10:3         | extract(i, 16, 6) << 3 | extract(i, 10,=
 3)  |
>> > -+---------------------------+----------------------------------------=
-----+
>> > -| %disp12 0:s1 1:1 2:10     | sextract(i, 0, 1) << 11 |              =
     |
>> > -|                           |    extract(i, 1, 1) << 10 |            =
     |
>> > -|                           |    extract(i, 2, 10)                   =
     |
>> > -+---------------------------+----------------------------------------=
-----+
>> > -| %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 | =
     |
>> > -|   !function=3Dexpand_shimm8 |               extract(i, 13, 1))     =
       |
>> > -+---------------------------+----------------------------------------=
-----+
>> > -| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 | =
     |
>> > -|   !function=3Dexpand_sz_imm |               extract(a->sz, 0, 3))  =
       |
>> > -+---------------------------+----------------------------------------=
-----+
>> > ++-----------------------------+--------------------------------------=
--------+
>> > +| Input                       | Generated code                       =
        |
>> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> > +| ``%disp   0:s16``           | ::                                   =
        |
>> > +|                             |                                      =
        |
>> > +|                             |   sextract(i, 0, 16)                 =
        |
>> > ++-----------------------------+--------------------------------------=
--------+
>> > +| ``%imm9   16:6 10:3``       | ::                                   =
        |
>> > +|                             |                                      =
        |
>> > +|                             |   extract(i, 16, 6) << 3 | extract(i,=
 10, 3) |
>> > ++-----------------------------+--------------------------------------=
--------+
>> > +| ``%disp12 0:s1 1:1 2:10``   | ::                                   =
        |
>> > +|                             |                                      =
        |
>> > +|                             |   sextract(i, 0, 1) << 11 |          =
        |
>> > +|                             |       extract(i, 1, 1) << 10 |       =
        |
>> > +|                             |       extract(i, 2, 10)              =
        |
>> > ++-----------------------------+--------------------------------------=
--------+
>> > +| ``%shimm8 5:s8 13:1         | ::                                   =
        |
>> > +| !function=3Dexpand_shimm8``   |                                    =
          |
>> > +|                             |   expand_shimm8(sextract(i, 5, 8) << =
1 |     |
>> > +|                             |                 extract(i, 13, 1))   =
        |
>> > ++-----------------------------+--------------------------------------=
--------+
>> > +| ``%sz_imm 10:2 sz:3         | ::                                   =
        |
>> > +| !function=3Dexpand_sz_imm``   |                                    =
          |
>> > +|                             |   expand_sz_imm(extract(i, 10, 2) << =
3 |     |
>> > +|                             |                 extract(a->sz, 0, 3))=
        |
>> > ++-----------------------------+--------------------------------------=
--------+
>>
>> Shouldn't we just use the proper markup
>>
>> .. list-table:: Field Examples
>>   :widths: 30 70
>>   :header-rows: 1
>>
>>   * - Input
>>     - Generated Code
>>   * - %disp   0:s16
>>     - sextract(i, 0, 16)
>>   ...
>>
>> ?
>
> What "proper markup"? This is using the "grid tables" syntax from
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#t=
ables
> You're suggesting "list table" syntax, which requires that the data can
> be represented by a uniform two level bullet list. I don't think either
> is more "proper" than the other. (Can you even put literal-block markup
> inside a bullet list item?)
>
> thanks
> -- PMM

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

