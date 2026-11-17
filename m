Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF9606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=HOlHbbuP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFCL-0006Sl-Mx; Tue, 17 Nov 2026 04:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFCI-0006SH-GE
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:09:50 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFCF-0000oX-Au
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:09:48 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso5990030a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794906585; x=1795511385; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HaDc8I7Sj2QN4PF0OJdn+37ksGbDX+3NQt15e0saoKI=;
 b=HOlHbbuPkigqn/lmXHUY/PXJmI1+dMZxXqD1rzDB5t8u2zov1Oi7gJdpBtLah+b3Lc
 bLNXcU1LPHm+PaZbKRg3kWjHRrwbeqL7j/+O56y2/XNLOVPI9ViEh3hjnnxoZE4iqL0a
 vKfBaZaG1UCh0mTRMT60WhMjVSsQ6/3fVEzP+aLtReUdwJoFVPH3KFnXkDc2xIlGuomG
 5/QVN90xM313veHTbDUMQR6/VVyYcMXBk1PIlRcy24pmxUy1rq82o7oSNh8sTHlVu8q6
 IkvmUINXWOSMB5mk/Y7PaDu5Ooa51Bn0PzMOo02iUdmuMAeoODK7rcRKg5/scHnwmwNM
 Iw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794906585; x=1795511385;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HaDc8I7Sj2QN4PF0OJdn+37ksGbDX+3NQt15e0saoKI=;
 b=eFRe+PbXRpowyzuVmEpSoaMrJ2YsMF8GHXzwdaIvVR8O4tymrYZvkAA9FGGSFFy3YD
 /7UjKEKpjMY333dfzbbyzkpMGKaPWttMGaroN17OD5EDVC+3jgD2OFO8bLslaO20HfmS
 4tbL9fEznayjbQcRS5gllFla8tYXU33iTGRGGnl0Fad3BvwdKRDADdt0NPaScIRRwSAk
 DtzpL3JjKTHW3d8yo6AYpVvmPdizlKuU+oF2jMLWxseHPrPZzcljI8YexOLmw4SW5xRM
 VDABbzKJNLulUQAXj0ZR2pxrqJMRtLBnTWBjZJfQ3wViIEeEnFvIVnQJ5ibKihtzemII
 7WTw==
X-Gm-Message-State: APuU4Z/Lo8BQsEDvizMZKDRPzNRQ3bSjTNMx8asZ0zzoF8SUWEpv+NfR
 zn8hMgV23YpwL0abp9ev4z9E04ozdSIW67QuV22+7I+al/dlem7lerOHA7H9FHiStVDJrrNhm2R
 BoFOlZFwbacbmbpJP/eZJrwPHxSqg92NbTv6y5PEUBLd6nFeVJlo1LTLt/U8RBuyrFTgFTsZJJJ
 7BsgCxr53L18yw2h07Zwj3xjDk8hvMuNczMfmEutqxydY=
X-Gm-Gg: AYBFou0hj3v4YWzwQrjlXYUHr9V17mFVpTXi3sK40EHhyyKAo6K4tspFsdPSL2z8VVw
 UtcbGruBSgvaJn56pDFNDmf+dQi6GqmD1X5ALomsME7pSEFVYRy9fmeNYbYTcPstKXSnUh8+2Js
 Nnt7VuajeTdO1nlNx2bZm3g8duwLhqZbrDVbHc3g1Gm9mKI13X4W3/eBzjtyMeIuFf7DYyZMGOz
 nhXKjBAfSEt71CG+e7vAzi6rjuBh60yRRXHyq2tmovTMQV1+BtTkcR26yTJ5Nnrb60TghdDcd1L
 fCOGU25UICGqB83CaI4LL8rCrHlvbBcvQ3hs6ywlxuWxFOLrnfxA6MWWblWkci+aQ+A6stHEALM
 6TbEkzwaV4jGDOYEu3c0hn45Puz7KgR/JrC9+qK5eIuhGFPnkswPiCZfHGiU57rZzYLnKHKwyAG
 V2XFHp46j0zQY9vQimKBuEAoODCsnprR95UHfgS96YTEJUsRkZLwUjmGWhLOoAWSvdLfmMPEp3A
 J71ZNcVI1/xU/KOOxsyZMqEFM/N8thmR4M0UggP6qvfpAoVCROKTHTaDCprKB0syxM/owp4IC4k
 jjwQnltEQOF+0D0fCZuNU/XRX5qb+x7UWB0hNEp3RrJ30yCypIL+D6sbBEuImTrDut/p
X-Received: by 2002:a05:6402:4504:b0:6b5:7de8:87cd with SMTP id
 4fb4d7f45d1cf-6b7c0d06f9amr9936159a12.42.1794906585183; 
 Tue, 17 Nov 2026 01:09:45 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c2361280sm5734331a12.10.2026.11.17.01.09.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:09:43 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b785ca42ebso6750926a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:09:43 -0800 (PST)
X-Received: by 2002:a05:6402:a508:10b0:6b7:a5a4:7205 with SMTP id
 4fb4d7f45d1cf-6b7c0953abcmr7108117a12.12.1794906582850; Tue, 17 Nov 2026
 01:09:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-3-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-3-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:09:31 +0800
X-Gmail-Original-Message-ID: <CAMXXpfb2ivefcvD8ev-Q4Zu=UqrptCihGzmUFiptpnb4b=PnNQ@mail.gmail.com>
X-Gm-Features: AclHuK9StGEbF6ZBjtfboL-7rJmqyD8zQI9bR-_XVm7q_LANkqNqJiPO3Vg966g
Message-ID: <CAMXXpfb2ivefcvD8ev-Q4Zu=UqrptCihGzmUFiptpnb4b=PnNQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] hw/riscv: add n-trace encoder with ProgTraceSync
 message
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="00000000000046a285066075413d"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000046a285066075413d
Content-Type: text/plain; charset="UTF-8"

> +    if (packed_bit != 0) {
> +        /* last chunk was not finished, so finish it now */
> +        buf[buf_byte++] = packed_cur;
> +    }
>

Although current payloads end with a FIELD_VAR, so this path is normally
bypassed, a message ending with a partial fixed field would reach it.
packed_cur must be shifted into the MDO bits before setting MSEO; otherwise
the MSEO update overwrites its lower data bits.
buf[buf_byte++] = packed_cur << MSEO_BITS_NUM;

Thanks
Jay Chang

--00000000000046a285066075413d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0=
 =C2=A0 if (packed_bit !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* last chunk was not finished, so finish it n=
ow */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[buf_byte++] =3D packed_cur;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br>Although current payloads end wit=
h a FIELD_VAR, so this path is normally bypassed, a message ending with a p=
artial fixed field would reach it. packed_cur must be shifted into the MDO =
bits before setting MSEO; otherwise the MSEO update overwrites its lower da=
ta bits.<br>buf[buf_byte++] =3D packed_cur &lt;&lt; MSEO_BITS_NUM;<br><br>T=
hanks<br>Jay Chang</div></div></div>

--00000000000046a285066075413d--

