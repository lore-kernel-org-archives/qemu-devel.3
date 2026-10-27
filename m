Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=fvluU8Zt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLbBw-0008M2-3S; Tue, 27 Oct 2026 03:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLbBu-0008Lp-VI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:01:50 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLbBt-0002s3-8G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 03:01:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so4920820a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793084507; x=1793689307; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VT6hOBkedohLNvvLn5T4101un/pKxQMYOKhYaFkUv4=;
 b=fvluU8ZtNyQ5wi4xlHt881hjkcjjGuNRwcBfYw3ujIcQ91G5/733gHincas/9QLZDc
 p/WEb0ORl/GZ+ms0ztH775+kJ8zwUojkFXgyALYMcYHTTt+BMiaSAb0x1iX6hysZYpp8
 dSL3lTxSWRD5a1iXw8J808kwqAZP8SBkCNEEEqEn/DqDMr4EjTJQ1TWvx+szHfvPkWvn
 zKVoTIhzVhf3+dYJ6sGX3XspzY+AL/lmi8fB6wJXS+iB66Q3KtGFO7jYJ9msJYA/2lwQ
 G1ZIQMxdKg7ejn2cmNb05Fj4p3ermL0huTVkiVGd68wjPntXrIvRpJZRW/ClMPOK+ZKP
 /Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084507; x=1793689307;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3VT6hOBkedohLNvvLn5T4101un/pKxQMYOKhYaFkUv4=;
 b=haHIe7i1ZE7azytRdybW6iDEkpGIuYy2NhKTcDhRRCgRc95Lr1JTJgxaDUaSz8QCKG
 W6rTzqoWZxh8ENNeSDMMPDk04//9RnWNMxSDzXxJNBECCGVV+MeeScMOEBfWHjorblr/
 TN0z6+cgDF40mR7Q5BLQaWSBiYu80s2nRX4/ZKE9uyEyW3XLJK0YD2xJWRBSCF2Y5svF
 2kme9kIpQbxIcHelH+WotBCL1odDUgmG4Ya7T95PNFJMJnLHouRLpPRg4BfDIKq1JsGv
 xDTutfqGH+xmwP1s5WqN1gb15VsFXgoPZVHG9kKPQ4QJmCvp3ig08lwcmsm9wgj1KNZG
 YPcQ==
X-Gm-Message-State: AFq9FYKo/In2/ylFoUQtw6rmpYJWHsdvJGzCOTUEwdvEh4laQJiG4WJk
 +ScJmgsdJH+BPy59baOwxe0WIn9O8HITY+A9txulUhQuVrMHxsQzzNFRnUt6cLKaFpDWrQBt0ND
 U+iBjAmwY7LFRJgeeTA93M+aixp/ZyVhfyqt2pXzD6pVDv3QXCbm9dPUjhrevnaYZp5xbCJaxAX
 jkSGAka0nrxTmxS5RAdpPbN6ROclYE8OjtarLOObDGIok=
X-Gm-Gg: AYBFou2FBkdmlJykNOG7z6OEg+5G68WsSxeq/ma++nUz1jo9sje3TB/+JFuc/fOacx2
 mymL9FfSMRh1eqpIIAM/+6tGcsXhYifFmswQVU9NnIHNjOT0r9il9RuAC55q5nMchGiSaJP2UKJ
 VnenBlD3vRwOhR1C77E/28WKOg95SLvhiY5PSk3oNRUboWtAI/3fEC6YOBZ8KH2OdTh+HNOnuJu
 eCepuB/ltXmfVYnWe9UF9WC3q1kaBXxSPivWJBxObHt4sew9p1svyapSY9NvAZhBmoO7L8EecYF
 R4F50oi/7iOnjAhPjan0QLxgh5qJ1NYt/WiTWE3O95UawzhCau1bTvYIQf0cwQhVdno93qsVAX6
 k1l6m5blk/5TwkQVX8aHYFSjKOgAKvYqYJ4Zl+uuIx/LDZk4EdTQLLRM5ouR8xxfHFnK3I6TAdP
 z40Cn/PAxTbvpxnn22McxUS1e0V9tMmNB0LqSIKMcqGkidw2nuMKLvw+MHzGVsUdK8re0kJDtc7
 lLislXBc2dj+tz0uKJJIDBlhn1aFQE7zxU/4nMspTku9+n1eERekcScMOg8WYby5YXScu/nZASp
 eEkXtMl3fzPY98GpZQ==
X-Received: by 2002:a17:907:60cb:b0:c41:835b:8f24 with SMTP id
 a640c23a62f3a-c46bdfdd1abmr866073266b.49.1793084507215; 
 Tue, 27 Oct 2026 00:01:47 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8b6sm398614566b.48.2026.10.27.00.01.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 00:01:46 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so4920745a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 00:01:46 -0700 (PDT)
X-Received: by 2002:a05:6402:4401:b0:6b1:b5ea:2580 with SMTP id
 4fb4d7f45d1cf-6b4431163f4mr9830763a12.44.1793084505754; Tue, 27 Oct 2026
 00:01:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-11-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-11-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 27 Oct 2026 15:01:34 +0800
X-Gmail-Original-Message-ID: <CAMXXpfaX=qx6+YBY14xmCFN9zHpDiCmZEDjK1PSw-HaN4nCQHA@mail.gmail.com>
X-Gm-Features: AclHuK9JgeXVgSefLsjo1LZENULMXqmkNHH9GY8FlNiqBk_OmL7LDmVbbv5GBqY
Message-ID: <CAMXXpfaX=qx6+YBY14xmCFN9zHpDiCmZEDjK1PSw-HaN4nCQHA@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] hw/riscv/rv-trace-messages.c: add encoded trap
 message
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000000494fd065ecd05a1"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000494fd065ecd05a1
Content-Type: text/plain; charset="UTF-8"

> +    payload.tvalLow = extract64(trap_addr, 0, 32);
> +    payload.tvalHigh = extract64(trap_addr, 32, 32)
>
For synchronous exceptions, these fields should contain the trap value (tval),
but both are currently extracted from trap_addr

Thanks
Jay Chang

--0000000000000494fd065ecd05a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0=
 =C2=A0 payload.tvalLow =3D extract64(trap_addr, 0, 32);<br>
+=C2=A0 =C2=A0 payload.tvalHigh =3D extract64(trap_addr, 32, 32)<br></block=
quote><div><p class=3D"gmail-wnfdnt10 gmail-_1ibi0s3fd gmail-_1ibi0s3ce gma=
il-_1ibi0s3eg" dir=3D"auto">For synchronous exceptions, these fields should=
 contain the trap value (<code>tval</code>), but both are currently extract=
ed from <code>trap_addr</code></p><p class=3D"gmail-wnfdnt10 gmail-_1ibi0s3=
fd gmail-_1ibi0s3ce gmail-_1ibi0s3eg">Thanks<br>Jay Chang</p></div><div>=C2=
=A0</div></div></div>

--0000000000000494fd065ecd05a1--

