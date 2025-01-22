Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4B9C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVov-0001Mm-3b; Wed, 22 Jan 2025 03:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1taVoq-0001M1-Ew
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:10:36 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1taVoo-0001XU-9o
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:10:36 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so1127781466b.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 00:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1737533431; x=1738138231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kk35EJvfrz3TasglmjDLnunQlqZKSdzsS6Rjn3Y85ug=;
 b=V1sJV9Rd3b5/B/olVs/mh6+6sB3MPMxrmYn2eqbVItTnj8VYVS0j8jL3OGc7TuvMKr
 DGZxNZJOF38QyvCfbObMrUKNeqaICEFfrQECLI7asGXtuJVIJnZAeH4m39OMGEEzwhsJ
 x4R8oCuSJiLoW/DPDWfLfphKWc62T4hZjW3vLF57fdBPAh8wae+UzYW0laWznitFTDpl
 00+HG38SlizhEIbERppVgidMxo3Ge3RM5US1aa0MIPdMFhaZD/WhMKJ6RocXFxAg1Rdy
 jMLUjiqtftXSWIS3vLKJrf3rghY4gZE5cMFWZ4XoKrXwEacg/LdHulWCcBEV6jXuMi5C
 efNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737533431; x=1738138231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kk35EJvfrz3TasglmjDLnunQlqZKSdzsS6Rjn3Y85ug=;
 b=tNT2AKLZlEndYnGZ66GfbKcaxQav6lDtIPtOQzpJ+puKjCKUCbk/FD2s33wa/YcRpx
 xrpg6izdVbuxg2jbkptrBnIUdM3vkpwG8TC4Y6TwNJW0NzziNnP6D4I2j86XhWuxxhIw
 IsoksswgWhE0Xul3ckbK5KRRW/6gZQLH/h023s8d609W0MWV1du8yPsyuW46ZlfiTr04
 2EVdPXUbUODqeoNepqu/PSNrYJ4uKNzHQ3ljHmPaEf4ZMiIRY8Zr9inVy1bymyB7QPgE
 fj5PE7iEH0Aj1xxT8psUVoXJDg9AOaSpVR4Xi10ROSzQ91pQLhQq7F5TR/1QLbdgBENs
 DYBA==
X-Gm-Message-State: AOJu0Yyg/1lnNV3lxs6/aASCDfOEDNjxHkSeQKdPMoXPwEM1idfsgmhn
 +Fh/RHzlka61SQApD38OP5lWE01uaZ+F/9ESNXYMB1pf2OpyCbyfGUEWgKX1PVtY72BdTEPI3VX
 JZxXcIST4l0UPD0hIHPhxcEl3SHObtt8I/26ypAF8HswVJc10if8Fnw==
X-Gm-Gg: ASbGnct5RUs9m1UqbILcxEGmGQJmKPCpdpNihwKCZEqrZHqVODwdMFDMAfszc527vN3
 tIJq/thKoD4tvTACQVbLCH39ACjO8YF2eGyofcJoNfYISuo7k6zqJCw==
X-Google-Smtp-Source: AGHT+IFRrbgi+SR5Yx6lC/dvLFdP6IDVoMSOXG1ydL8S2L3NIE4WgysjEyBWFLaZ0zazyK2t+XMbBNdXLub5V1nW0C0=
X-Received: by 2002:a17:906:dc8f:b0:ab3:ed0:8d7 with SMTP id
 a640c23a62f3a-ab38b15cd26mr2074999866b.23.1737533431250; Wed, 22 Jan 2025
 00:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20250115141730.30858-1-jason.chien@sifive.com>
In-Reply-To: <20250115141730.30858-1-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Wed, 22 Jan 2025 16:10:20 +0800
X-Gm-Features: AbW1kvaGHYZu872nuXWkZLv4_qxcgFrZgxpuFOIKVfNTEMkYXv0cwmO2O0sNkOs
Message-ID: <CADr__8onD=_FYyp03y+-fB5wq_8kiOrfydWx9_3BWwpWntpKfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/riscv/riscv-iommu: Remove redundant struct
 members
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: multipart/alternative; boundary="000000000000f49cef062c470607"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=jason.chien@sifive.com; helo=mail-ej1-x633.google.com
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

--000000000000f49cef062c470607
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=BC=
=9A

> Initially, the IOMMU would create a thread, but this thread was removed i=
n
> the merged version. The struct members for thread control should have bee=
n
> removed as well, but they were not removed in commit 0c54acb8243
> ("hw/riscv: add RISC-V IOMMU base emulation").
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  hw/riscv/riscv-iommu.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 9424989df4..fa8a50fa24 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -58,11 +58,6 @@ struct RISCVIOMMUState {
>      /* interrupt notifier */
>      void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>
> -    /* IOMMU State Machine */
> -    QemuThread core_proc; /* Background processing thread */
> -    QemuCond core_cond;   /* Background processing wake up signal */
> -    unsigned core_exec;   /* Processing thread execution actions */
> -
>      /* IOMMU target address space */
>      AddressSpace *target_as;
>      MemoryRegion *target_mr;
> --
> 2.43.2
>
>

--000000000000f49cef062c470607
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping</div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Jason Chien &lt;<a href=3D"mailt=
o:jason.chien@sifive.com">jason.chien@sifive.com</a>&gt; =E6=96=BC 2025=E5=
=B9=B41=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:17=E5=
=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Initially, the IOMMU would create a thread, but this thread was =
removed in<br>
the merged version. The struct members for thread control should have been<=
br>
removed as well, but they were not removed in commit 0c54acb8243<br>
(&quot;hw/riscv: add RISC-V IOMMU base emulation&quot;).<br>
<br>
Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" ta=
rget=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventana=
micro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
Reviewed-by: Andrew Jones &lt;<a href=3D"mailto:ajones@ventanamicro.com" ta=
rget=3D"_blank">ajones@ventanamicro.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/riscv-iommu.h | 5 -----<br>
=C2=A01 file changed, 5 deletions(-)<br>
<br>
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h<br>
index 9424989df4..fa8a50fa24 100644<br>
--- a/hw/riscv/riscv-iommu.h<br>
+++ b/hw/riscv/riscv-iommu.h<br>
@@ -58,11 +58,6 @@ struct RISCVIOMMUState {<br>
=C2=A0 =C2=A0 =C2=A0/* interrupt notifier */<br>
=C2=A0 =C2=A0 =C2=A0void (*notify)(RISCVIOMMUState *iommu, unsigned vector)=
;<br>
<br>
-=C2=A0 =C2=A0 /* IOMMU State Machine */<br>
-=C2=A0 =C2=A0 QemuThread core_proc; /* Background processing thread */<br>
-=C2=A0 =C2=A0 QemuCond core_cond;=C2=A0 =C2=A0/* Background processing wak=
e up signal */<br>
-=C2=A0 =C2=A0 unsigned core_exec;=C2=A0 =C2=A0/* Processing thread executi=
on actions */<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* IOMMU target address space */<br>
=C2=A0 =C2=A0 =C2=A0AddressSpace *target_as;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *target_mr;<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div>

--000000000000f49cef062c470607--

