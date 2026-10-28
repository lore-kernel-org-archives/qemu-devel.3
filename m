Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E2606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=FviHOkZA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxH5-0003MO-MK; Wed, 28 Oct 2026 02:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxGy-0003Lr-UH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:36:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLxGx-0005NQ-9a
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:36:32 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so840530a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793169389; x=1793774189; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c+hxXBbSiym1hmLWpsahHoG7iDEd+4O/rtaXuQe6iPI=;
 b=FviHOkZATZaELaMVXlW5QDXMD24cvbOeg/DYoTfB+l3dVz3cAiZ+LElMNmyzVPNXkV
 SXUnvlX9znajxb+vigwgmYC/n6GobTIzj7W6/+gRTDumWKpzLTS8KjgU0pdW92WmEZlG
 z3TdV/QjmzsxyT61ziNKHI5qVmcauS2PPfXsOvzZXrG4uK6ihT0tWXZXSDdrfaVrPOrY
 HUgLPIkSfr0SJDsvm+c08nPUnfWa6cEeQxUi+/xuifK2UpbkA3uk2ecMJq4IvJdlCXhZ
 xUU4vPcWsED4ztbX0TegUGnxArRwpoiMMUpOboxIJt+IL+MaDDqGfC/RF8QE9Tqsbub8
 QBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169389; x=1793774189;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c+hxXBbSiym1hmLWpsahHoG7iDEd+4O/rtaXuQe6iPI=;
 b=M0rRlB7GSNUsLHXZI4c2YY7CoQSIP1tSvQ+8yX3pwS8ZQQH2Jmk8K59I3DT3JHEF9A
 G3SdYTS8Ne7jfA7in/fbkWNA6AerLWrD66t8+LNGsypThdnmVRzbkAspVZVh0a4Rufma
 Cbj7u3VDcS1NXBPCetthYYT/AKoIV7+r0IcTLWJY6975K6Mr9qXc+W8EO9ohe9/9PmHn
 86/4Uy6SoFOwv6RVfxn7EMstnaNhRCavOyyJRLrU2i/NIMbsK14V50hhiSx939h8M+Be
 UPNl/GqsTh6g7pbVZaTdFtzQb2EisMOHm/0iKwMti4hgo9FmTe2wNJSd9ig05hpwmeLA
 4DCQ==
X-Gm-Message-State: AFq9FYJhXW5C2vX4ayUEAwfYnKRlr2csGfBgU0cazfrFGKxC4bgc+pIn
 X+mMmXhjpwA4ous3tpSA6Ca6AaSPo3pAHJCRsTU7KeaE0tK4TnxAYwf5WeEyfOqT8HwL9ZNBkzj
 DAnCdO3y3Hh/elL91ISJI6PJ0ooPV0TlSb6OBucuXuuAwl0wWJvQ5hw5tigW6DWAgNYQsNlh0o1
 Yp6mHXreIA1N+gKPdFaMhHLvjBFevKnJ+VOJHWw7ksdXw=
X-Gm-Gg: AYBFou3GuinfTzQqbA4Ie1biTI630WN7xJ7lWyYS4cZ0W7RYYpvD7uXsaX+ELKMe9ES
 +dDqhp8tLpUvXcspJTWrxAJDKIKafvpTIettWe9+kpcrHx4bbfVddGzqP1riQdv0Yl7ZhBbBY4g
 ImDZbcBnpcTYg4hVdkiXTA42g0tFFT6/4uZ4Q+Fac3KmM0pBzbeDJ3blDkR4FzIrGFa8CSsmULU
 LhAfG+qTSMpoBj5uq7SL4GIZaitg4uLzSnq6FNyWmRJnIrlbVL2W7x2FVRHWmf6oZ+82IOCWTIh
 5+T5mOrxhVjyUJwvMo62rJZqryUjZNNC/347U3N9uZDEhb4t+Xec9cDSkz4ESoYUquQmDoP5KZe
 sfLU0nkHYJSLKsDGtkfOciUnO9k+otCUg56ktWFFC6Pdy7CD1IqL1xjcnoku9WqJYHDP+DaYi4P
 YlYK4WPVYPpljFgwb7plZv2DDmz1h//Z7d+J05dLWE3JauoOys4BhU5Z89TpscB7DsmkLrgAczq
 zKSGqZm9ehFlLYwx0mzJNRqkl7YtUl6AYebtNIFvKSZka3OkxDkswvXGux05j6ufnoQrodlnN1G
 gBf5x4TMV0N81SaYw1sDB59lSGnIxuGw1gNvdOuOpa8PLMTYIHt0sFGhcYec7WDpRSE=
X-Received: by 2002:a05:6402:2b91:b0:6b4:16fb:b9be with SMTP id
 4fb4d7f45d1cf-6b49cb8e213mr677249a12.37.1793169388821; 
 Tue, 27 Oct 2026 23:36:28 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b49641f64csm1043817a12.21.2026.10.27.23.36.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 23:36:27 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so92911266b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:36:27 -0700 (PDT)
X-Received: by 2002:a17:907:2d25:b0:c33:923b:ad66 with SMTP id
 a640c23a62f3a-c49bdfdcf78mr100335966b.43.1793169386671; Tue, 27 Oct 2026
 23:36:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-15-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-15-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 14:36:14 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZmyLuHE+h1kMzFOSy2ywmqGHa2LF0Ez4HyayDH-TyQYA@mail.gmail.com>
X-Gm-Features: AclHuK-lhTIQ5AjulPAT5Y0i6U2SfIh1QB5nEWi8f2CqFlNO1ES8lxUOtYVaW7k
Message-ID: <CAMXXpfZmyLuHE+h1kMzFOSy2ywmqGHa2LF0Ez4HyayDH-TyQYA@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] hw/riscv, target/riscv: send resync updiscon
 trace packets
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000509534065ee0c898"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x532.google.com
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

--000000000000509534065ee0c898
Content-Type: text/plain; charset="UTF-8"

>
> +void helper_trace_updiscon(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
> +
> +    te->updiscon_pending = true;
> +    te->trace_next_insn = true;
>
Could we use trencoder_report_updiscon() here instead of setting
updiscon_pending and trace_next_insn directly?

Thanks
Jay Chang

--000000000000509534065ee0c898
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+void helper_trace_updiscon(CPURIS=
CVState *env)<br>
+{<br>
+=C2=A0 =C2=A0 RISCVCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 TraceEncoder *te =3D TRACE_ENCODER(cpu-&gt;trencoder);<br>
+<br>
+=C2=A0 =C2=A0 te-&gt;updiscon_pending =3D true;<br>
+=C2=A0 =C2=A0 te-&gt;trace_next_insn =3D true;<br></blockquote><div><p cla=
ss=3D"gmail-wnfdnt10 gmail-_1ibi0s3fd gmail-_1ibi0s3ce gmail-_1ibi0s3eg" di=
r=3D"auto">Could we use <code>trencoder_report_updiscon()</code> here inste=
ad of setting <code>updiscon_pending</code> and <code>trace_next_insn</code=
> directly?=C2=A0<br><br>Thanks<br>Jay Chang</p></div></div></div>

--000000000000509534065ee0c898--

