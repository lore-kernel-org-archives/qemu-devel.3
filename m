Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40424C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 05:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Jm7-0002kr-EL; Mon, 29 Apr 2024 01:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Jll-0002je-Un; Mon, 29 Apr 2024 01:41:45 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Jli-00024A-V7; Mon, 29 Apr 2024 01:41:41 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-47c26f67c7eso578815137.0; 
 Sun, 28 Apr 2024 22:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714369295; x=1714974095; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBi0qg/ZQSQ4ux2ec1U/dDOHRnzUZkeozfe9rDUFOEE=;
 b=Ye4sJ9I0Wr0zpBlKpzhQEA9XNXWPcPu3f/ATrNc+deRDsBEXaomBOMD2Y3LoyunWF7
 0BelT71ZGVKujUNIzdtvR3yn1z3arub5Ron/gSisCjiLI0UrmlBLh06ljE7E9RIto/gl
 o47HoSM9f5RHdBQ9Cxvm5xFati38zXJkyCfJqSRWEEqPdXRsuwN+lQWZt7kWLKiRXmOH
 E0MVs9KIsSrQYxE+DrsNxRiujn2wDijU2f+ubiWfI6PFSh8z8ByIplKnpH7hyjBlGzjl
 X0ubXVfR7ZKIeXg9H653idJn9+e7RcniGcrrBOYjT9/1vl7P6l/Dv1Ry7QJYBj9e0rhP
 NonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714369295; x=1714974095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBi0qg/ZQSQ4ux2ec1U/dDOHRnzUZkeozfe9rDUFOEE=;
 b=YZPoivw4tf5+2dC8yiGmRYWER9FrDRAiGskZvvNMjgpbRc2QlBXG1H10DmbZtdVpij
 /CdEKcAVPVyOJqC0+cpn4dwMlo3RZvRWk/arXdWpwvkwDRYjaGp1iFTLKMpjjTu+UQwI
 7x7nlNHcAuY92yihzg0PxG4+iDUJqw44niw1toE3GDO063icS0+CzJ5ofUadY8dZgNhv
 kykhWmTi/rH8OVv1S9eR0My3L1exYlpFbwWcoUpN8TceOXWg0VQZCo6eIo8y0QlrsvIJ
 lChxruay3iftDu29hU172ybdTbmRpbP6Tzai4aAet/aLr4URMcHyrgZyQM5pt7sq8Z0v
 m5Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo89ZVQz4e/JWiAaEmGX+SM5uV3aahd7Mrt3MfslO+kkq0CMfWCa3MZI54C6ntuFdLJpggyCcn52J9Wj7trfa/sUtJCOA=
X-Gm-Message-State: AOJu0YzRnjmUbpl8CvKgabzEdMDIicVDM4hkPFp32AW0aCmUnMPduEYj
 kUbgP9ufsbpudiQvZZus+EJTz1lpL3szb5MbhqTrYEPX9d2do6CoDilNYd3ibTm8Tm9zd1wEzxe
 qm/Ul3ZsL+c1BU3Oj/cqgqNi1nmFRzUY1
X-Google-Smtp-Source: AGHT+IGrLNPa1rsrflBDROtR5dLnQZLnbMdBcLHudgegumaq4srwxjCkkUYZcjFqP2FD8fXgWT4zsli5/HXbjuqlCx0=
X-Received: by 2002:a05:6122:411f:b0:4d8:7a5e:392f with SMTP id
 ce31-20020a056122411f00b004d87a5e392fmr9970672vkb.12.1714369294387; Sun, 28
 Apr 2024 22:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-4-hchauhan@ventanamicro.com>
In-Reply-To: <20240314185957.36940-4-hchauhan@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 15:41:07 +1000
Message-ID: <CAKmqyKO67qjXhxRM_j6DP+uu7SzXPACGbCZaFQmUVJ7gv1tC0w@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] target/riscv: Expose sdtrig ISA extension
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 15, 2024 at 5:02=E2=80=AFAM Himanshu Chauhan
<hchauhan@ventanamicro.com> wrote:
>
> This patch adds "sdtrig" in the ISA string when sdtrig extension is enabl=
ed.
> The sdtrig extension may or may not be implemented in a system. Therefore=
, the
>            -cpu rv64,sdtrig=3D<true/false>
> option can be used to dynamically turn sdtrig extension on or off.
>
> By default, the sdtrig extension is disabled and debug property enabled a=
s usual.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ab631500ac..4231f36c1b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1485,6 +1486,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>
> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> --
> 2.34.1
>
>

