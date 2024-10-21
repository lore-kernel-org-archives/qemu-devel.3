Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CA5D3C927
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2go4-0007ZR-74; Sun, 20 Oct 2024 21:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2go2-0007Yf-7Y; Sun, 20 Oct 2024 21:01:58 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2go0-0003Wk-L6; Sun, 20 Oct 2024 21:01:57 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-851d2a36e6dso1786765241.0; 
 Sun, 20 Oct 2024 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729472515; x=1730077315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kbl0ttaHl3kiCRHtALDsLaYzPoqfRztwI4CErz18Klo=;
 b=JFCdxA9Umv1NGcx4YyKw+1n+yWFHj1Dyjm2h35VwS8VTww2LIkvRL37cjOAVnvJpT9
 FuKiBbIlHcI1FQj0KbwaJj+j6j9IbGISxIqaL/A364hAEnTAqCsQ7Zx4Pivq3AJLewpZ
 HfBLu7qKSpONlfKqSAka8vCUHJZPCQNCiRQI+T1Fyg6Nwr6oqIFa5Y1z5ILrGXy4sqqL
 OOuh3jNFCvhEbwOyVULvcnPF2p7In2iu/tKkpjwIfo5Ks7mAd7zXekVz43/k80SlMmLm
 1JWqMLsbzcpOS69FXk1PhCVuTDv3w9JDQCTRVBF8oyat9WHkPpVx3Ct5ExI73Fh7a/O5
 cBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729472515; x=1730077315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kbl0ttaHl3kiCRHtALDsLaYzPoqfRztwI4CErz18Klo=;
 b=K5D5y2gsEiUC0FN4VKmaJmK2HHy4EU7lnDN7ZdBkVPt71aQ2CmTolic9qoDHXhkmi4
 mF3yaWiL0uJCkle29nQuS8MK3JkFw9NxVL7gkJa4dYP6yoh/S+K63mX3M3l+hu6dJ4fp
 S9dSnRXbV1GhAyGaRHkedZlqQwvAhbHly4sDTW5EHeN0dgGV8a/Q+GeL76SmnEe45KzJ
 DVOGjgTuSa89F21TGP+h2hzuoRjNb+//5f3JCKfaR31uoXAV5utw4xy8pLSxOlL4em8G
 swn0q5xYrq7/TkOVXd+Vk78VdkjzOg8VnQBIo+1+jiUjqw7K2DWF8qdeky+J4mmzr7Sr
 DD6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl3guylZ7tuW3f89VhRJ4wU7fF5KlvtD3HjcjQTN2naWlSJLX+9DENYGRXGbZCeLRDJpUAENZFXEze@nongnu.org
X-Gm-Message-State: AOJu0Ywq9fCC9rulHlbHpxUewaAWMCGCT+Vxp4y28oTa/8gs2zd05Vq8
 jeMXLbdaJ96at6D4do/mVLPomjb3wmgKrmhIhdHt0Ucauka2b9VinqbzffWDtOlHAq7J4/T4ZqL
 YqMZ0L20PVM2lg3T34BLUlZ8XsAY=
X-Google-Smtp-Source: AGHT+IGeRhmg2v9zmo7+qJLubO8inGBk4QjUtXrJNq/yYd3xkzbz2KAzZiFWmZ6jaxlHixiXCV4rguQpmHvGn8GkO2M=
X-Received: by 2002:a05:6122:3d0d:b0:50a:cbdb:b929 with SMTP id
 71dfb90a1353d-50dd9bf9117mr5933007e0c.2.1729472515244; Sun, 20 Oct 2024
 18:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-6-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-6-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:01:29 +1000
Message-ID: <CAKmqyKNRrZXCeK6FHmn8ecRGePfyC9SgjD=br1-yK3aOW=eUjA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] target/riscv: Add Ssdbltrp ISA extension enable
 switch
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Oct 18, 2024 at 12:54=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> Add the switch to enable the Ssdbltrp ISA extension.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5224eb356d..39555364bf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>      MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
> +    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
>      MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
>      MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> --
> 2.45.2
>
>

