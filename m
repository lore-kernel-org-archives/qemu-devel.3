Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE9606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=RNgVZbZ5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLZmO-00014p-Dl; Tue, 27 Oct 2026 01:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLZmL-00014Y-GO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:31:21 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLZmI-0003kt-R2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:31:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1ec41d8e9so3889477a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793079076; x=1793683876; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0B4m15N5kcWjbnKFHohmSUTKb71f17BsTuaazBulgs8=;
 b=RNgVZbZ5j8Uex4soU9qVqEkNpBwV7KfwLulgNyoAblNoflnMt8SB2qF21VjekVpuG0
 xCn+cknFqANHQsNOyCunAsZNouAOBk00iIaqccu4WxjFUaTFh3m8ScyzBDZqau43ZkSP
 7rn12UvAPRQsJXk1boN0YkcbfOUO8UZj+id1NkxXqtCBY1QO30JbjL7Je+k+HIFPKKEz
 DKIXdufFu7MnOAfmwc+80FrToRph1vrJVBJUfEZjzGxDEQGavy8YPPExAy9iFLIMM3Ca
 ST6iW3K3FSYILJJ3vLXjQCc+jcGmXon+/drsuTZI+y1d+qofytY+rY6ftaH2nGzeNQkO
 JQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793079076; x=1793683876;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0B4m15N5kcWjbnKFHohmSUTKb71f17BsTuaazBulgs8=;
 b=v95wHVsE4+5HZOzn53/Our3xjWFUYqe1ZzeMs1RPRKZgT3ZeNbpYsVnb2Pudandnb3
 qC6VPTHCWfeXK1jA0f5a4n63EPbgBEe3C3jXuXKPTF0qL/6sswZOhQ+KrQ5fHrEQKpim
 quyAnu45L88tP4XVj/tP5kexRPanyr+O4e1KNpyVgklHwK1cNPlfPGVvM+gdHjuRG42P
 +oYNDaALoNNrQC+F1ieQF7btwlD8ez+QxniKbhnzc92YQu3+VE4GEfitsrQD+mi2bWQG
 5EE3lp8b+lW+IbxthpiC+WH0e2syjdk2QX30MVO4JPUsNqZh59Trkee6OaEboXuR5j5p
 jFIQ==
X-Gm-Message-State: AFq9FYJYpjYnP4d41SfJry/FtJwAMBNLfstos78GPUieE7PmjK2Qo0Ey
 ODumtB3uSdbgGf0KdnYJ8YCcghsKT4XRjZlvLD63OvM/X8h05zeFnYYl0d7UUtfgcBOZtmNu6wr
 197zmx43SE3qvAtY12EEkdaG6omxQW6KKQKW7izbK2mQrYmyZa0e+JWad6LJ0fKeCJVWIbIp++/
 nh+Hmu6/b/KNsZNZ4qlrLioT3vrvol5Fk1340z84omGrs=
X-Gm-Gg: AYBFou2rEoS/HFpoOP582isBU0P3yPCJ4YxAIE2eKaNuqSeuvdjjPF9zMV0752L2dMs
 gsOSHB9ShEQ0ir3/9sDpbq5bUsXzWtoE/Gu6XwzGYLD1jI5HapVNInKgIMrAOuN7Um/gZWJpLoD
 BxGZo4Es/GwV+6ijOrvHtOQXJqFK9M/H2gl31slLzMSIAA6mR4rLXPwT5zZLrgRcWBZtfHf8xal
 GjcFq2zu57rJqoe3Qe2B3N5J1XZiqDLSKDYzkGhRWltqvumZ9/v0rxFGAWYCMGfBbF9Vd2oZrky
 /+D3Fk2lmh3mlGeOGgELgtpmAx1R5/R/94Cib3NPtXdnUGjEXDpTVn/GlYu5zwNZKQgKBkoSv0L
 iA4SmLVbcSF7GO4eVOdk0Z7UD+ZyX8yhQIbdb8Hm0SSQEtnKV4KCr08w76h7Y8opjp+37qUPeE/
 wDh6RLTKjqMCt8eJItqteHKlCvLuuI8mRpNdNYAg/EpsZcAOcvNNEwQzvV3OYJMMwIEnNy2PeHF
 JFg65fbgmabafjBTAMgG8QjbA/5ffQdJ2ln3ZKHeEcQ3lW1nAVRMtZ07grJj7LN7JGainzoRFjz
 yM0zH5qiBUpSShjDuw==
X-Received: by 2002:a17:906:15d7:b0:c49:8fa2:4a22 with SMTP id
 a640c23a62f3a-c498fa25bbcmr285260266b.41.1793079076252; 
 Mon, 26 Oct 2026 22:31:16 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b445971383sm4308034a12.21.2026.10.26.22.31.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 22:31:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b45f9ec1ceso2032680a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:31:14 -0700 (PDT)
X-Received: by 2002:aa7:df94:0:b0:6ac:5c83:bb9f with SMTP id
 4fb4d7f45d1cf-6b442fe167dmr6891648a12.9.1793079073603; Mon, 26 Oct 2026
 22:31:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-3-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 27 Oct 2026 13:31:02 +0800
X-Gmail-Original-Message-ID: <CAMXXpfY0SQiqBBxhbnxV0sDyK40WwFwFGvB_dcbdxBZJxo7DxA@mail.gmail.com>
X-Gm-Features: AclHuK91An0Ffpvw_tIMTmx-6643buJ5x8CzuVAD66nWAFCkOlA4-J0m5S7g2m8
Message-ID: <CAMXXpfY0SQiqBBxhbnxV0sDyK40WwFwFGvB_dcbdxBZJxo7DxA@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] hw/riscv: Trace RAM Sink initial impl
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000003c879b065ecbc17a"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52e.google.com
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

--0000000000003c879b065ecbc17a
Content-Type: text/plain; charset="UTF-8"

> +static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned
> size)
> +{
> +    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
> +
> +    switch (size) {
> +    case 1:
> +        return tram->msgs[addr];
> +    case 2:
> +        return (uint16_t)tram->msgs[addr];
> +    case 4:
> +        return (uint32_t)tram->msgs[addr];
> +    default:
> +        g_assert_not_reached();
> +    }
>


Could we use little-endian load helpers for the multi-byte accesses? As
written, both cases only read tram->msgs[addr]; the casts do not load the
following bytes. For example:

case 2:
    return lduw_le_p(&tram->msgs[addr]);
case 4:
    return ldl_le_p(&tram->msgs[addr]);

Thanks
Jay Chang

--0000000000003c879b065ecbc17a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">+static uint64_t tr_ramsink_m=
sgread(void *opaque, hwaddr addr, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 TraceRamSink *tram =3D TRACE_RAM_SINK(opaque);<br>
+<br>
+=C2=A0 =C2=A0 switch (size) {<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tram-&gt;msgs[addr];<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (uint16_t)tram-&gt;msgs[addr];<br>
+=C2=A0 =C2=A0 case 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (uint32_t)tram-&gt;msgs[addr];<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><span style=3D"background-color:trans=
parent">=C2=A0</span></div><div><p class=3D"gmail-wnfdnt10 gmail-_1ibi0s3fd=
 gmail-_1ibi0s3ce gmail-_1ibi0s3eg" dir=3D"auto">Could we use little-endian=
 load helpers for the multi-byte accesses? As written, both cases only read=
 <code>tram-&gt;msgs[addr]</code>; the casts do not load the following byte=
s. For example:</p><pre class=3D"gmail-_1ibi0s3d4" dir=3D"auto"><code class=
=3D"gmail-language-c">case 2:
    return lduw_le_p(&amp;tram-&gt;msgs[addr]);
case 4:
    return ldl_le_p(&amp;tram-&gt;msgs[addr]);<br><br>Thanks<br>Jay Chang</=
code></pre></div></div>
</div>

--0000000000003c879b065ecbc17a--

