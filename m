Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 07:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seUx5-0000Bv-Ip; Thu, 15 Aug 2024 03:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1seUx3-0000An-49; Thu, 15 Aug 2024 03:31:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1seUx1-0004oH-Ab; Thu, 15 Aug 2024 03:31:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so474141b3a.3; 
 Thu, 15 Aug 2024 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723707073; x=1724311873; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7Fr67iEKUcmeOsvw+AlXn2rFrseuZqnnLU1IFaFLLw=;
 b=V8EWb4Pv6F52fGkFDtttu5Ub0UvFSLmat1wv/6Scam23XuHKflAHLyw0kPyF42lBxC
 iZZRsP6QUf4mwGKDB2LPFF02ZjrzUGIpx4Y4Thk8LiFaNrZ51QBsxZcwhwUe5OHQTGG5
 8bJEIJWvy5FHHsTML7gndYUeqPaf8S9AEjtm+AnreejM4/sLlaXg3yQkzHVO1RHVFftD
 fqs9chryewNKHNpuQGYJZTOvUgTJWLJ8YzsfevoEsKEskgWyLrvDgaMxMFe+Q9iup6/V
 ISA082d1S7+6tLtPuIRG7c3a1m53txPjnu6129uN590SAeKD4IaWL6cUOJh6/MNBW55q
 rVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723707073; x=1724311873;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T7Fr67iEKUcmeOsvw+AlXn2rFrseuZqnnLU1IFaFLLw=;
 b=DFVY3AkCVGycIetGkjWM4JwLY0qpDeV/SU34oozjylnyjCqEN5YRnGbxZbZ8dOtfbB
 x9AqHjKtw/TiBh4i0BCKEc4VK2R58SPZOhu9P+DsulTOcj/tizBW65S0E6DyZIo/BPy+
 r7btd1oedZ03HGLUMVZSGbd60+hx34NfKaudfYQYjy2PD4IhUUMaQWryQdJx7UFqszqy
 GQ3dSffxpXeceWPeaIImruHKRU6pQ8ROHtlNN2H79CaBPzS3zeyYobM/F1HblERXfaeX
 IKX3Bglstg0KLl2Ow7cx9e59ZpzSneAVSX36sqXta7pv25BYVoXdI/ISDCYgDs9zqlav
 LgMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpYM89cSOuQAign+I2NYIHbCLVmV0UD65I8ARbadXplgvf1JLf+PVJBf0D0iAovxlDaJx+aVr8pULz8bD3FC+yAx32
X-Gm-Message-State: AOJu0YxDIWu0latm70vY6bRCkLrXmj5kKaRZC3b/t1YxtZ/VuPWjlEnd
 QNG7yeghp5eAE7fI9Fqw7idDSvJawq2EDUyiTjKq34QtWI/X/Gt0W31DPfzF
X-Google-Smtp-Source: AGHT+IG+8dMvrrVRCjAnBOGuXqgNj/WkGVSP4RVx293eWUhewEtR5JjhPzfcbRYGrpuzo9+tGnWUmg==
X-Received: by 2002:a05:6a00:10c2:b0:70d:3938:f1a5 with SMTP id
 d2e1a72fcca58-712673a8571mr6413276b3a.22.1723707073104; 
 Thu, 15 Aug 2024 00:31:13 -0700 (PDT)
Received: from localhost ([1.145.66.109]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae06b4fsm565556b3a.46.2024.08.15.00.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 00:31:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 17:31:07 +1000
Message-Id: <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
X-Mailer: aerc 0.18.2
References: <20240813134536.1204513-1-adityag@linux.ibm.com>
In-Reply-To: <20240813134536.1204513-1-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Aug 13, 2024 at 11:45 PM AEST, Aditya Gupta wrote:
> Currently any device tree passed with -dtb option in QEMU, was ignored
> by the PowerNV code.
>
> Read and pass the passed -dtb to the kernel, thus enabling easier
> debugging with custom DTBs.
>
> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
>
> But when a '-dtb' is passed, it completely overrides any dtb nodes or
> changes QEMU might have done, such as '-append' arguments to the kernel
> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> when -dtb is being used
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

This looks pretty good, I'm inclined to take it as a bug fix fo this
release.  One little nit is MachineState.fdt vs PnvMachineState.fdt
which is now confusing. I would call the new PnvMachineState member
something like fdt_from_dtb, or fdt_override?

The other question... Some machines rebuild fdt at init, others at
reset time. As far as I understood, spapr has to rebuild on reset
because C-A-S call can update the fdt so you have to undo that on
reset. Did powernv just copy that without really needing it, I wonder?
Maybe that rearranged to just do it at init time (e.g., see
hw/riscv/virt.c which is simpler).

Thanks,
Nick

>
> ---
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> v3:
>  + use 'load_device_tree' to read the device tree, instead of g_file_get_=
contents
>  + tested that passed dtb does NOT get ignored on system_reset
>
> v2:
>  + move reading dtb and warning to pnv_init
>
> v1:
>  + use 'g_file_get_contents' and add check for -append & -dtb as suggeste=
d by Daniel
> ---
> ---
>  hw/ppc/pnv.c         | 34 ++++++++++++++++++++++++++++++----
>  include/hw/ppc/pnv.h |  2 ++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3526852685b4..14225f7e48af 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -736,10 +736,13 @@ static void pnv_reset(MachineState *machine, Shutdo=
wnCause reason)
>          }
>      }
> =20
> -    fdt =3D pnv_dt_create(machine);
> -
> -    /* Pack resulting tree */
> -    _FDT((fdt_pack(fdt)));
> +    if (pnv->fdt) {
> +        fdt =3D pnv->fdt;
> +    } else {
> +        fdt =3D pnv_dt_create(machine);
> +        /* Pack resulting tree */
> +        _FDT((fdt_pack(fdt)));
> +    }
> =20
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
> @@ -952,6 +955,14 @@ static void pnv_init(MachineState *machine)
>          g_free(sz);
>          exit(EXIT_FAILURE);
>      }
> +
> +    /* checks for invalid option combinations */
> +    if (machine->dtb && (strlen(machine->kernel_cmdline) !=3D 0)) {
> +        error_report("-append and -dtb cannot be used together, as passe=
d"
> +                " command line is ignored in case of custom dtb");
> +        exit(EXIT_FAILURE);
> +    }
> +
>      memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> =20
>      /*
> @@ -1003,6 +1014,21 @@ static void pnv_init(MachineState *machine)
>          }
>      }
> =20
> +    /* load dtb if passed */
> +    if (machine->dtb) {
> +        int fdt_size;
> +
> +        warn_report("with manually passed dtb, some options like '-appen=
d'"
> +                " will get ignored and the dtb passed will be used as-is=
");
> +
> +        /* read the file 'machine->dtb', and load it into 'fdt' buffer *=
/
> +        pnv->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> +        if (!pnv->fdt) {
> +            error_report("Could not load dtb '%s'", machine->dtb);
> +            exit(1);
> +        }
> +    }
> +
>      /* MSIs are supported on this platform */
>      msi_nonbroken =3D true;
> =20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fcb6699150c8..20b68fd9264e 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -91,6 +91,8 @@ struct PnvMachineState {
>      uint32_t     initrd_base;
>      long         initrd_size;
> =20
> +    void         *fdt;
> +
>      uint32_t     num_chips;
>      PnvChip      **chips;
> =20


