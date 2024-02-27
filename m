Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB8AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reucd-0000AP-Jp; Tue, 27 Feb 2024 05:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reucX-0008Ha-IR; Tue, 27 Feb 2024 05:23:33 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1reucV-0004LH-PM; Tue, 27 Feb 2024 05:23:33 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e4e7e25945so2042947b3a.1; 
 Tue, 27 Feb 2024 02:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709029410; x=1709634210; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxG4Iby1+tX3sZkZFPcReRX+tfcjBLt2I7ESE3/72ZE=;
 b=HriQxTis2K7WR933ZspRP1nWW/2yuZWZC6e/0qnRvxoxR5KUX8O6sgtyVFpux4pcKo
 YFM+uYO/ImZgvl3yXNl1lt2sVEdwAGqQz596OAzlDUjb3p4WYcCAhS2X0mvahnFmw2LO
 wCrpRhCuezVXE9QqUpxFa891yOVWC4igwLHms+IqxxXiQbEnY2vHeVO8csQvUvBkpsrB
 weGe3T3ezQiRoZE2dzuLeMAcq6vH1Hcq0RbCqwCsm58xbu0SrrjeTO9OKh97IRNbQ0Zb
 53+KBBWDyqsETBDizy6/OzbpbW08T8tQQHzb43Ru1Y9NKWGU0JtgrNmJz4ZX2925UhNB
 6KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709029410; x=1709634210;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xxG4Iby1+tX3sZkZFPcReRX+tfcjBLt2I7ESE3/72ZE=;
 b=YVFbZre6RMvhMNUFRkQ50hzEt6KR3RP5Hkr6eULIVx0ZkeG0fPHBbuheZ1+M/Co3/Q
 JAAkj9BY0WHw3Z88dch/R+j69FGb3gGgfHrESFWd8MIcNp38hdPP2R67EVUxeHMbP6sY
 aMKpZ4AHBtNePkArb7cj0OtrEzPJFIKLWF4Y3FabYnUFJc72CwQ+XhvX/5GjujupwP4Y
 0ijQn/ADw1S/ydLhrQPwW0hhlSLCOQfvRZyVAvIrvKotLrzvgfxcaiiOFJ6FhB35M/rA
 rbysO6yHAh3PxH6Hr2Nc7otKCXxy5sBX4eRq/h+nE5+/BhnPGatYDK80MUbjhzgxOhdi
 ePNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJWUpXAzhpWi+TtH1nRxWJjYh8q0voFOyZx4yqkcw7CKz4DipM1WDYzEavN9mdHkSLF36XRSCskMvUOfAa17mwnXHLNrmYB/rzmL9p4DHWrSb/r5nhtzLuH7c=
X-Gm-Message-State: AOJu0YxoMnj1m/4m/Dumq1C2sfwPlcDYn1Baf+BOVv3hVEq32gAYOZ9B
 Bcpfi4176JdRcOiHrERqUxut4wViMs4IgaG/NpR/3FRV69QJ+blj
X-Google-Smtp-Source: AGHT+IGfBRVSMXTedlUm+/kho7xh17f+rGsjvfNhtaojoogj+Y+m/cOwqFM8ND2WtEoWBHX9vmehRg==
X-Received: by 2002:a05:6a21:2d06:b0:1a0:f6ea:f423 with SMTP id
 tw6-20020a056a212d0600b001a0f6eaf423mr1944291pzb.6.1709029409997; 
 Tue, 27 Feb 2024 02:23:29 -0800 (PST)
Received: from localhost ([1.146.52.18]) by smtp.gmail.com with ESMTPSA id
 jh18-20020a170903329200b001db45bae92dsm1214429plb.74.2024.02.27.02.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:23:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:23:22 +1000
Message-Id: <CZFSD126HHHS.1V0PEMMKHEVJF@wheely>
Cc: <clegoate@redhat.com>, <mikey@neuling.org>,
 <amachhiw@linux.vnet.ibm.com>, <vaibhav@linux.ibm.com>,
 <sbhat@linux.ibm.com>, <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 15/15] spapr: nested: Set the PCR when logical PVR is
 set
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-16-harshpb@linux.ibm.com>
In-Reply-To: <20240220083609.748325-16-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
> From: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
>
> In APIv1, KVM L0 sets the PCR, while in the nested papr APIv2, this
> doesn't work as the PCR can't be set via the guest state buffer; the
> logical PVR is set via the GSB though.
>
> This change sets the PCR whenever the logical PVR is set via the GSB.
> Also, unlike the other registers, the value 1 in a defined bit in the
> PCR makes the affected resources unavailable and the value 0 makes
> them available. Hence, the PCR is set accordingly.

Should this be squashed in as a fix?

Thanks,
Nick

>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.vnet.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr_nested.h |  9 +++++++++
>  hw/ppc/spapr_nested.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index da918d2dd0..f67c721f53 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -229,6 +229,15 @@ typedef struct SpaprMachineStateNestedGuest {
>  #define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
>  #define GUEST_STATE_REQUEST_SET              0x2
> =20
> +/* As per ISA v3.1B, following bits are reserved:
> + *      0:2
> + *      4:57  (ISA mentions bit 58 as well but it should be used for P10=
)
> + *      61:63 (hence, haven't included PCR bits for v2.06 and v2.05
> + *             in LOW BITS)
> + */
> +#define PCR_LOW_BITS   (PCR_COMPAT_3_10 | PCR_COMPAT_3_00)
> +#define HVMASK_PCR     ~PCR_LOW_BITS
> +
>  #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>      .id =3D (i),                                     \
>      .size =3D (sz),                                  \
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 6e6a90616e..af8a482337 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -740,9 +740,11 @@ static void out_buf_min_size(void *a, void *b, bool =
set)
> =20
>  static void copy_logical_pvr(void *a, void *b, bool set)
>  {
> +    SpaprMachineStateNestedGuest *guest;
>      uint32_t *buf; /* 1 word */
>      uint32_t *pvr_logical_ptr;
>      uint32_t pvr_logical;
> +    target_ulong pcr =3D 0;
> =20
>      pvr_logical_ptr =3D a;
>      buf =3D b;
> @@ -755,6 +757,28 @@ static void copy_logical_pvr(void *a, void *b, bool =
set)
>      pvr_logical =3D be32_to_cpu(buf[0]);
> =20
>      *pvr_logical_ptr =3D pvr_logical;
> +
> +    if (*pvr_logical_ptr) {
> +        switch (*pvr_logical_ptr) {
> +            case CPU_POWERPC_LOGICAL_3_10:
> +                pcr =3D PCR_COMPAT_3_10 | PCR_COMPAT_3_00;
> +                break;
> +            case CPU_POWERPC_LOGICAL_3_00:
> +                pcr =3D PCR_COMPAT_3_00;
> +                break;
> +            default:
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                    "Could not set PCR for LPVR=3D0x%08x\n", *pvr_logica=
l_ptr);
> +                return;
> +        }
> +    }
> +
> +    guest =3D container_of(pvr_logical_ptr,
> +                         struct SpaprMachineStateNestedGuest,
> +                         pvr_logical);
> +    for (int i =3D 0; i < guest->vcpus; i++) {
> +        guest->vcpu[i].state.pcr =3D ~pcr | HVMASK_PCR;
> +    }
>  }
> =20
>  static void copy_tb_offset(void *a, void *b, bool set)


