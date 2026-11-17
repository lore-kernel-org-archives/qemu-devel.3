Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEF606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=isO/e+vK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFbm-0004BR-No; Tue, 17 Nov 2026 04:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFbl-0004B4-6B
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:36:09 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFbj-0007Oa-6u
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:36:08 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b7a488a0a4so4916561a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794908164; x=1795512964; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CQvfj4kC8vQo0POu6cYh6RIpfb4zrs4hh0THgRagOFw=;
 b=isO/e+vKKBmOSdmS+XDnVWULApmNvNh2G3iBHBYwxzmMQbCbTzJRy5Vq3goD6NlxRp
 LsNhkLikNMygaig+5xBTi5yua8r+7yGmqJEFZhUDgzxiGI9hOLVJ8BMt8x4foDAuWu4X
 NKqpfM7/CzrEYDH6ImU6yEkprt/Jz1Nix+aimn+YHMX0e5MYOyFPUO7tiXvUttcnvPKm
 KSSSaqALRca/wlVM+dZh9MRr/GmYjpiRtJCVDt8cTvwjyPVQvKbvX/WhJtB/zwX+uajO
 eFAavKToFNdXS31p6rHpBRPSDbgYp8uwZwrPq6UYg//YN16k6ay6QtDbtvR1iCIQ28Qm
 7JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908164; x=1795512964;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CQvfj4kC8vQo0POu6cYh6RIpfb4zrs4hh0THgRagOFw=;
 b=VmMCv1vBFfWKKlaUBXLGwRtxjMWokY0jPX1KiHrVgN34z/YIbpwXCKSlUE7kXik6KC
 fuIx/uE3u8+BqgNnAR1y6FW4WPAq6Q9vlDrl5Cu/HxFn8Yb0oXrrfz/X4VcIvBYsxPff
 M1svve4hxZD1h0WGKZGw8RpQBK6gWHX+oXdB9e6O0vyQid7NNVyVdxl+f9/S0tlNdce2
 Y9LxYXTeygLItS49Ep6RkWBeVddAqZ+L4x/FQxscKv+rHeszRnhLgOOk9HI7Zlbx7e34
 Z8UJncQUZdjO8cedZjy+yNEH0BtZRTXDFrJMF0Yt1JqaMzorza6E/Qog8XzvRL3kfo1q
 Hryw==
X-Gm-Message-State: APuU4Z8evZTZnbQggUyf2K+gCqWrRpaCib4HrsCiO7WVj1wygr5te0Vo
 gxJ4yVK8bameVnhjtMuz1TuZbIWFluosbdYJWyHJhoc/ISqcCriMD1YAEOB5yWvi761qWMFbRh+
 3RVXV3BeDgcHdACDqccEtTVIB2t+obWNuqGNRDOx2Ib/gNvvN1d2Q/2ujgdUbEBxouvxpV5lXYx
 teO/RhqEAYNAdfBIVsKmWhnSVpEM/Hvt/1rK7SL35itDc=
X-Gm-Gg: AYBFou0J16paZBmuH/tP2B/WC/uZRcVqxxlFb33D5wyu11VkNrEKlsfFF8OKCZjsexf
 f2Pz+23a8sCN/MENb8X5HLUoXsIR54ZBFqtui1HLTxZwf44wT8/KLqfvkcnzDeYti6wRbBRYwGD
 R1VOpqSU/ayrBPvxcuTLKtoYkUbLz3pNCPii1PlbANbHqVdqRwsDgKqeQZcpmG5gxhNAnV3BqOl
 tMZ3u9UwU/w6bCV0Yztp9HGANDWZV03dckThVSHEP9OduMvP9zuFJcZhQnBjarv/keOHyiYMjac
 zHEjA2TdJV20CEn4ISGpd3pcR0g6poGntr0TdNWlMI3akuuz55eDMuLnE9oZzTR1A2DIZV0yWFt
 P+JjwhdPA5FqyGATcydSsFn3pt6EK1CalS8z7+IL3res595v048ayEqWSpwAFgFOuIZ0aOHUQra
 Xnis7vADfTeT7FJkMZiQObiceVWalxhXs+FKUCK0GxlTJ25w7KnsecOo1VvZpw3ycU3h+yqqsXP
 Vy1i9bh4bmSZwKgNQE/xaLfP42b06mIYAbADMXqlH31yt01/aiEuqMklZcC8MSYAJwRNWdFg2uy
 KIt8kQt58L0Hh6euJVf4pc0a3J6/j6sbRdKxrcxxBggB4fZZSeNuBwmFQ4Vvtjn6/rw=
X-Received: by 2002:a05:6402:3213:b0:6b8:7a5e:e63b with SMTP id
 4fb4d7f45d1cf-6b87a5ee775mr332155a12.24.1794908163717; 
 Tue, 17 Nov 2026 01:36:03 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com.
 [209.85.218.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c262338csm5558938a12.33.2026.11.17.01.36.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:36:02 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c4d28f75d62so857921466b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:36:01 -0800 (PST)
X-Received: by 2002:a17:906:7309:b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c509614e541mr1048610166b.2.1794908161503; Tue, 17 Nov 2026
 01:36:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-7-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-7-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:35:49 +0800
X-Gmail-Original-Message-ID: <CAMXXpfbH=02pBVT_RCW6eLZaLqEFQCMzzA77Xfn8eo9xdHwn8w@mail.gmail.com>
X-Gm-Features: AclHuK_nJZYDNFS_dxfJrZCugsptRtZ3hlCBVNE6viA_mrDVPu3Z4O6EKmX9RRQ
Message-ID: <CAMXXpfbH=02pBVT_RCW6eLZaLqEFQCMzzA77Xfn8eo9xdHwn8w@mail.gmail.com>
Subject: Re: [PATCH 07/13] hw/riscv/trace-encoder: add interrupt support to
 N-Trace encoder
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000005efa2b0660759f32"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x529.google.com
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

--0000000000005efa2b0660759f32
Content-Type: text/plain; charset="UTF-8"

>
> +static uint32_t get_inst_len_at(uint64_t pc)
> +{
> +    bfd_byte packet[2];
> +    uint16_t opcode;
> +    MemTxResult status;
> +
> +    status = dma_memory_read(&address_space_memory, pc, packet, 2,
> +                             MEMTXATTRS_UNSPECIFIED);
>

 Could this be an issue when the hart is executing in S/U-mode with paging
enabled? env->pc may be a guest virtual address, but
dma_memory_read(&address_space_memory, ...) does not appear to apply the
CPU's MMU translation.

Thanks
Jay Chang

--0000000000005efa2b0660759f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+static uint32_t get_inst_len_at(u=
int64_t pc)<br>
+{<br>
+=C2=A0 =C2=A0 bfd_byte packet[2];<br>
+=C2=A0 =C2=A0 uint16_t opcode;<br>
+=C2=A0 =C2=A0 MemTxResult status;<br>
+<br>
+=C2=A0 =C2=A0 status =3D dma_memory_read(&amp;address_space_memory, pc, pa=
cket, 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MEMTXATTRS_UNSPECIFIED);<br></blockquote><di=
v><br></div><div>=C2=A0Could this be an issue when the hart is executing in=
 S/U-mode with paging enabled? env-&gt;pc may be a guest virtual address,=
=C2=A0but dma_memory_read(&amp;address_space_memory, ...) does not appear t=
o apply the CPU&#39;s MMU translation.<br><br>Thanks=C2=A0<br>Jay Chang</di=
v></div></div>

--0000000000005efa2b0660759f32--

