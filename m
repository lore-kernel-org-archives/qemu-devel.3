Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D007FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 23:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4pkW-0002l7-M5; Tue, 15 Apr 2025 19:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4pkO-0002iz-AN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 19:31:22 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4pkM-0003nR-7N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 19:31:20 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so200780939f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744759876; x=1745364676; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nbizR/0Uj3YXLOYMLmIuUYwptwEysp9kEmNKohW+m98=;
 b=PIJS7i3Qm90Hayvd21NJxQ69iBy7caR2qQ11hwQa9Y+WPwrO/PKfMLLJ+ztvSEP/bT
 f1B4wDlp3V3CN+bvWc/FVNg8P2IXJZkB46cOkSSakasM7O82CdG2F8+nWS8nYTA4MinZ
 M+vImD/oaBAdqeFXHaM0yB2pz/c3+ayimmHxlW4WsvBl5Yp3oPuM0FbTiPReN2fVl++8
 PIYZxJb8VzUCI1dL19JMlV8gK/NzQFBsLJIhMhDwnPF5YdAqnKUF7k7RX3OzjoD/uU13
 Y/vCKQ44Ew+hb+BOP44E79TpEMjmw6vPpHi0bqw7zamK/jK49NqCi1U++0pM7FzGPiri
 Ya4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744759876; x=1745364676;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nbizR/0Uj3YXLOYMLmIuUYwptwEysp9kEmNKohW+m98=;
 b=n91HV8VYVjQDkPBeCjW+kqoOzzr86t0Sqjg9tocHj7cZFaVleygMqHaMGbQAYrUVQo
 mtCTQv4BTikoUri17YgLXCBT+cA0cXNpj3ufYMV5BSA775Q7ADs7yc27nuG3sZ9dNawA
 ZccecRBR2Oy0Nqf/HZI6k+dWOj9fumvjKvk7Er9u1kaCrynlvVGxbmV/1qp4/ALf2oUs
 bGJ5/1NEBvjUwS2z6E0XAjuVESXA8M0v/9oW7UN7jVSKStzDhFk9wHvW2l5Sz7uJLPOG
 KaazDWIRAOvB38XMdOo3Tg4kT6eoBoWMaiTlw1GfAvv8SZXajd9UUkSLY+p/CInKeLWY
 vIaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtFZAc1fqC5CD+Lo0j5gvrOmgi+eOPiAjJchFlxiMNCDZdv10iKUWeGvtRZaOe1IZa60JfA7KBhPCx@nongnu.org
X-Gm-Message-State: AOJu0YznD+KAW4600W3xgngTPm0WvapM6weImdj1mBLvTkMQLl/bOIdX
 BnF+vAuWhoDmZkZjJ6Y/mocKoOE3HZeqf0LGen4U9wYNid+NnVlr
X-Gm-Gg: ASbGncsLDYLoWT8nYNDQZO7gTeJSTC5I/1NtfRN4G4URPDA93GkY5pKbZCyb2iMytos
 rLzjpy/7WSj3EHnd0gTBXPUS6YQU7iNTpMYicC1zp8yYPXkkJcRnykqU/bHxBJFm01jt2Qvce9A
 ikaUHdKiIpzKR3UqDGpgAl4EctZxqSOhN44XKB7y7iluAu9L4YemuOVOHPCDouuo5SQB+ZAYAfD
 jAr3juqUpkBhQfYlUyT7S2NkNpKlR9/6ycbzwMGnTp5Jj3UNLLqwrQFEFvnpEbgHTMuX/DWq9gF
 urmLGwAC3gQiU0kg4oFIpi2pUZssX+lanCVt/2Oi3d9vKVJ+WHoxwy8ck8j5eyxnfos7cHRnltE
 =
X-Google-Smtp-Source: AGHT+IE6ijd2I1aCsLzHLV7T+wvEu/JGJbRXG2Ku/s3vVdd/eu6ExDkHIarXTaAIkx+YK0RtD+Wo2w==
X-Received: by 2002:a05:6602:3f0b:b0:861:1ba3:3e50 with SMTP id
 ca18e2360f4ac-861bf9f3947mr196625939f.0.1744759875777; 
 Tue, 15 Apr 2025 16:31:15 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-861656c8f8bsm266256739f.38.2025.04.15.16.31.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Apr 2025 16:31:14 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-4-brian.cain@oss.qualcomm.com>
 <058301dbad5f$467a2530$d36e6f90$@gmail.com>
 <12956419-d35e-46cb-985a-5ea06d2d4154@oss.qualcomm.com>
In-Reply-To: <12956419-d35e-46cb-985a-5ea06d2d4154@oss.qualcomm.com>
Subject: RE: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Tue, 15 Apr 2025 17:31:10 -0600
Message-ID: <06ee01dbae5e$7a761740$6f6245c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQHWEv9sAUmibjMB1usFMLRR8CFQ
Content-Language: en-us
X-Antivirus: Norton (VPS 250415-10, 4/15/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Tuesday, April 15, 2025 12:22 PM
> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> matheus.bernardino@oss.qualcomm.com; ale@rev.ng; anjo@rev.ng;
> marco.liebel@oss.qualcomm.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com
> Subject: Re: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr,
> hintjumpr to multi_cof
>=20
>=20
> On 4/14/2025 12:04 PM, ltaylorsimpson@gmail.com wrote:
> >
> >> -----Original Message-----
> >> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >> Sent: Monday, April 7, 2025 1:27 PM
> >> To: qemu-devel@nongnu.org
> >> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> >> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com;
> ale@rev.ng;
> >> anjo@rev.ng; marco.liebel@oss.qualcomm.com;
> ltaylorsimpson@gmail.com;
> >> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> >> Subject: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr,
> >> hintjumpr to multi_cof
> >>
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> ---
> >>   target/hexagon/hex_common.py | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/hexagon/hex_common.py
> >> b/target/hexagon/hex_common.py index 6803908718..a2dcb0aa2e
> 100755
> >> --- a/target/hexagon/hex_common.py
> >> +++ b/target/hexagon/hex_common.py
> >> @@ -247,8 +247,11 @@ def need_next_PC(tag):
> >>
> >>
> >>   def need_pkt_has_multi_cof(tag):
> >> -    return "A_COF" in attribdict[tag]
> >> -
> >> +    return (
> >> +        "A_JUMP" in attribdict[tag]
> >> +        or "A_CALL" in attribdict[tag]
> >> +        or "J2_rte" =3D=3D tag
> >> +    ) and tag !=3D "J2_hintjumpr"
> > It would be better to make this decision with instruction attributes =
only
> rather than a mix of attributes and specific tags.  If needed, add =
another
> add_qemu_macro_attrib call to hex_common.calculate_attribs.
> >
> > Having said that, the correct tag for hintjumpr is J*4*_hintjumpr.
>=20
>=20
> Good catch, thanks for finding it.  And I suppose we can change it to
> `"A_HINTJR" not in attribdict[tag]` instead.
>=20
>=20
> So, now more like this:
>=20
>       add_qemu_macro_attrib('fREAD_SP', 'A_IMPLICIT_READS_SP')
> +    add_qemu_macro_attrib('fCLEAR_RTE_EX', 'A_RTE')
>=20
>       # Recurse down macros, find attributes from sub-macros
>       macroValues =3D list(macros.values())
> @@ -291,8 +292,8 @@ def need_pkt_has_multi_cof(tag):
>       return (
>           "A_JUMP" in attribdict[tag]
>           or "A_CALL" in attribdict[tag]
> -        or "J2_rte" =3D=3D tag
> -    ) and tag !=3D "J2_hintjumpr"
> +        or "A_RTE" in attribdict[tag]
> +    ) and "A_HINTJR" not in attribdict[tag]

Let's take a step back here.  The goal is to eliminate the =
pkt_has_multi_cof parameter from helpers that don't need it, right?

So, the first step is to change a check for A_COF to a check for A_JUMP =
or A_CALL.  Here are the opcodes where this distinction matters
    J2_endloop*                     These have fGEN_TCG overrides so =
there is no helper function.
    J2_pause                            Ditto
    J2_rte                                  Ditto
    J4_hintjumpr                     This is a nop in QEMU, and there is =
an idef-parser emit_J4_hintjumpr function that doesn't generate any TCG.
                                                 When idef-parser is =
off, you get a helper call, but you could easily override this with an =
empty fGEN_TCG.
    J2_trap[01]                        These have helper functions, so =
we want to return false because the helpers don't need this argument.

So the bottom line is you can add an A_TRAP attribute attached to the =
fTRAP macro and then this function can be
    return "A_COF" in attribdict[tag] and "A_TRAP" not in =
attribdict[tag]

HTH,
Taylor




