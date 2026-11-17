Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89897606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=mwgSGX1U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFJT-0008BH-Ot; Tue, 17 Nov 2026 04:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFJM-0008Ag-6T
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:17:08 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFJJ-0007Ka-Po
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:17:07 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so647649366b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794907023; x=1795511823; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TipT0447L+wpGEH6/84TiZ7W5Hpg04ITL+TeBuQ8V1E=;
 b=mwgSGX1UwkbUr7UlP8QmFDmVzf9h5fpVmidf/BFULLSbCfKweyV7q3TsziuTpDWdqd
 V2cSecTeksIUI0QRDV3VCKrgsb9GkZoZ2pj9Tq6tO8e15DcDOuYDCPXuoqcMMc3QmA7d
 2NN1FhpOzK10Hz/s8EqZXPnvfnMIASAexP/y+K/7+8iGoCQr5Ry0jaWJXf+8CFAIaTW/
 /lUwO7qCRWM78P1nH82nu7T9mG1WYtdiY+hRsZWT0Kih1EQGASUQK9brr7k9pAnPP/qB
 5JqVS4qjezm37zbWQVq5Jqc3HUlm7qdbXi3uq5CaTzZ7mI6cQ9dJBxOhW6yeIm0GWN17
 cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794907023; x=1795511823;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TipT0447L+wpGEH6/84TiZ7W5Hpg04ITL+TeBuQ8V1E=;
 b=HCmLZjnVFgjXPYKgJ3lNGXbRLOst29frICoroJEAIYvIXgbNqKvy9Gs9+3Poe2fGny
 Ef6kFi5dy57u3926wKnDQyWhcXfQxn6msoMRik/X1LydnazRK1oLodVWVHYJ3AoV2hnA
 RxLILaYXb7g5jJiLFAZhDTUBtmWyVEzZuIH9OmsFQ5KaFmhsUvVFgHm8YCewbe+CpXP9
 QBYZSERcKyM/d3G63AN0qwjtMKh4JP3ylxUXxta3SyjkTdAxBU7DWQGwVfPl6SEm5A+t
 w/yPv4J1PRc9N/FPcQ+V5fn7lB8A0e+2SmSDhwwOKcvwelZKsLWxrv7yJFV/J0ORhbHM
 1PKw==
X-Gm-Message-State: APuU4Z9phN6a1K1X7NqMs0n8Z2QdPWO6KORyXklvoGVPKIGok/ghTNEv
 iJLnmcro59Qn19cE47uhsm8OqGdEdicJOwwmf6y/KkhA8WO9gAP5DMzygEI522tOc4LlF2LuB7Y
 ODucWq6u/0m6DG6FMIK9ZFMSIc6w4Ft0zw0cMx1m/qNubgASqRrkAF8RWSUySN7gFVCdfGw7o03
 6aLuFa67RX2nJUfXVrEN70NHv4v0C7CKk4IYvvXrY8b0A=
X-Gm-Gg: AYBFou0A6c7sGKbBPBkMst+HW1/fBp/Q+w3B6s44T7Rg36Tq62Qd4lVVNN3dYscWJ/7
 4Q17byXe46lFQdtdh0gIClpEneIwDT77xqse3fGBTgws1AyDMQTNz/EJQdmPg/uz488AEM7+Yqd
 Aw+4NDU39HPUjhTFDo1IaRJmqIPa0UH7nQMPfWeUCT14xqnBOl1KqRfidRWjifdkIUEVnEXCQ8X
 HJg7FDyVADtHWPT4mrxJETWpL7RHXDtERSboG4ZIqQVQNPTqEYlxDtpAlLobuyU1x7wJGCL6dJz
 Lgps9zlv3lEcyxctzuPi1p7KNG8YY6B7XJ703d3x9izGurD5VzUEIEVVQxetLE6xzBkc/CP4EUx
 5MdjJzm6WjjXdzrB0GXrQxLuJZEERjOQ5AZEsUVk0ELecgb5YOMS0s9Eh/zwlRN+LSPnWuuES7A
 pjWJRHKCFXPwzDQDkCnFKXOYXu1RQbZ4fe1jtketsQycuWZi2ef0g1V9qyfBVVYm8ee5m/aJAir
 F49QxttYORol+vbXOmOzyiprMvwcOiSJXnHrNBSYZ67Kvv9T81FM1MsH5XhQxzYw1AiDx3N1PXG
 M+QQ4HasA2CSCk4S40jYWn2vXWQ/wzGRWxgckBaHRxN/4C2p59HrJ5APWwA04VLXVhQ=
X-Received: by 2002:a05:6402:2712:b0:6b6:ea98:2539 with SMTP id
 4fb4d7f45d1cf-6b7c0891b0cmr10347792a12.6.1794907023204; 
 Tue, 17 Nov 2026 01:17:03 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b86fb94190sm338938a12.27.2026.11.17.01.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:17:01 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b7a488a0a4so4897105a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:16:59 -0800 (PST)
X-Received: by 2002:a05:6402:210d:b0:6b4:86e1:cc67 with SMTP id
 4fb4d7f45d1cf-6b7c0c6fd49mr9417438a12.27.1794907019198; Tue, 17 Nov 2026
 01:16:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-5-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-5-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:16:47 +0800
X-Gmail-Original-Message-ID: <CAMXXpfagDhmNPV_vrGRHxCfAqFg=2HXEHMivJUVEd8XPbGYzSA@mail.gmail.com>
X-Gm-Features: AclHuK92GJqHx3zO68TWKhcNXa3aY8HYGWnXICD8rfVlUCJB-XMonHW-xbIp4Mo
Message-ID: <CAMXXpfagDhmNPV_vrGRHxCfAqFg=2HXEHMivJUVEd8XPbGYzSA@mail.gmail.com>
Subject: Re: [PATCH 05/13] hw/riscv/trace_encoder, target/riscv: add trace pc
 history logic
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="00000000000048c81e0660755b54"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000048c81e0660755b54
Content-Type: text/plain; charset="UTF-8"

>
> -void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool
> taken)
> +void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
> +                             uint64_t insn_len, uint64_t offset,
> +                             TraceBranchRes taken)
>  {
>      TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
>
> +    if (te->ntrace && taken != BRANCH_NOT_TAKEN) {
> +            te->icnt_accumulated += (pc + insn_len - te->last_icnt_reset)
> / 2;
> +            te->last_icnt_reset = pc + offset;
>

nit: Could you align these statements

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

--00000000000048c81e0660755b54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">-void trencoder_report_branch(Obje=
ct *trencoder_obj, uint64_t pc, bool taken)<br>
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t insn_len, uint64_t offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TraceBranchRes taken)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TraceEncoder *te =3D TRACE_ENCODER(trencoder_obj);<br>
<br>
+=C2=A0 =C2=A0 if (te-&gt;ntrace &amp;&amp; taken !=3D BRANCH_NOT_TAKEN) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;icnt_accumulated +=3D (pc=
 + insn_len - te-&gt;last_icnt_reset) / 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;last_icnt_reset =3D pc + =
offset;<br></blockquote><div><br></div><div>nit: Could you align these stat=
ements=C2=A0</div><div><br></div><div><span style=3D"background-color:trans=
parent">Reviewed</span><span style=3D"background-color:transparent">-by: Ja=
y Chang&lt;</span><a href=3D"mailto:jay.chang@sifive.com" target=3D"_blank"=
 style=3D"background-color:transparent">jay.chang@sifive.com</a><span style=
=3D"background-color:transparent">&gt;</span></div><div>Thanks</div></div><=
/div>

--00000000000048c81e0660755b54--

