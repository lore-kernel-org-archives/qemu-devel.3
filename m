Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED203C3DA64
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhIJ-0003rY-II; Thu, 01 Aug 2024 21:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZhII-0003qg-KS; Thu, 01 Aug 2024 21:41:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZhIG-0006pO-Re; Thu, 01 Aug 2024 21:41:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so61717005ad.3; 
 Thu, 01 Aug 2024 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722562878; x=1723167678; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhfSQeXVvl8lev6E4pBmnoGpo+FZbPLjOX6fbiH10qA=;
 b=OoNFSyXUrlY/3mW5hSy8S9f5KgW/6tU5mgiwuu7lJvM0Owno5b3avyAYW/YSaxOPXm
 iUQzw+zg/saDqaLkVbmIPp1i4JG7ylETFfkXxgJ96Uu/AP42gqLVJO38pMMkFGxboY/+
 7jmCK4yYOP3Ry3aDbcHacMRCTlhJSuyiLzhZrYawycCx0/LG5IOAzDuHt4+XKrfauoP0
 Fw8sXOj5GPjwyX+ad3CRoxRMiQ4pgEvroFAeH6MydneJNeuu97Lqese5vFNP4Ke5ErnI
 BqLUtTgcsXr1Mtx8R1ETvuMoO5zLK/E1GrScjKwVpOmyxHmMPWGRDnc6PHXOFHewluH9
 IZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722562878; x=1723167678;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fhfSQeXVvl8lev6E4pBmnoGpo+FZbPLjOX6fbiH10qA=;
 b=DNpe5Z6mMdDUUHVteBaX/S7+WVIZV7J6ePzxLPva+h0zTC/vgjryVMTs5AQYTbOKAo
 HusSvaOrLc2hNqDtQvcmwbCh4znYQeTVK7ayFx13EM1eKaDxzq1274vRnz5GWfkfbRNJ
 neUHAinxg9sxRWDjR0cRctZd3NoEwKHdQKnOiTKAUbL7RbgY/F0VoNq9PsAKYUI0eDjS
 fGHzk1qHRXBBjrjKxVxLitmsFXNNNQ2mGjQ99BjL0Y2klRoZ5BzHvVnrg9MouH8q3RFE
 UoJhVkcHvg0Xg13mUO4P9XQ7fSpriIOZKQS+wYM5WE38gg/mtAZihGqfO2LW5mxpUFtk
 cxdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkV6Q3QEIdopIhbx/vWl+4k3E82ZLYKw7SasoLNFRKzmyVS1uCr6dGyrOD1fum98fzaSpP3YMjjKzFvK66OzI7IfmW1Fo=
X-Gm-Message-State: AOJu0YwP2Fuz+77Dg4jlnSDfPx4sGZbZL2JcEYBsdMvEmJCEUsKPhACu
 kEPZ2ZvvO9nkGG9L60905VAJDRqfqwVIr2c18TqXCzIN8N7OFsdOZvWBAhdD
X-Google-Smtp-Source: AGHT+IGAJw/O0R1QhbXXGKYpc8MX/tJWmk6RqVl3ZpEaBduUZATISsY7PAWrp+JO3PQ5RG9WJ1LiOQ==
X-Received: by 2002:a17:902:f54b:b0:1fd:8904:ecf6 with SMTP id
 d9443c01a7336-1ff5728c53fmr30436525ad.21.1722562878443; 
 Thu, 01 Aug 2024 18:41:18 -0700 (PDT)
Received: from localhost ([1.145.56.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929ae4esm5447385ad.269.2024.08.01.18.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 18:41:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 11:41:12 +1000
Message-Id: <D351KQYRFR7O.CVO9X3Y89JG0@gmail.com>
Subject: Re: [PATCH v4 04/11] pnv/xive2: Add NVG and NVC to cache watch
 facility
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20240724212130.26811-1-kowal@linux.ibm.com>
 <20240724212130.26811-5-kowal@linux.ibm.com>
In-Reply-To: <20240724212130.26811-5-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jul 25, 2024 at 7:21 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> The cache watch facility uses the same register interface to handle
> entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
> specification' register tells the table type. So far, that bit-field
> was not read and the code assumed a read/write to the NVP table.
>
> This patch allows to read/write entries in the NVG and NVC table as
> well.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive2.c | 49 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3dbbfddacb..dfb0927fd3 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -465,10 +465,30 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, u=
int8_t blk, uint32_t idx,
>                                word_number);
>  }
> =20
> -static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
> +static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table=
_type)
>  {
> -    uint8_t  blk;
> -    uint32_t idx;
> +    switch (nxc_type) {
> +    case PC_NXC_WATCH_NXC_NVP:
> +        *table_type =3D VST_NVP;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVG:
> +        *table_type =3D VST_NVG;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVC:
> +        *table_type =3D VST_NVC;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: invalid table type for nxc operation\n");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
> +{
> +    uint8_t  blk, nxc_type;
> +    uint32_t idx, table_type =3D -1;
>      int i, spec_reg, data_reg;
>      uint64_t nxc_watch[4];
> =20
> @@ -476,21 +496,24 @@ static int pnv_xive2_nvp_update(PnvXive2 *xive, uin=
t8_t watch_engine)
> =20
>      spec_reg =3D (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>      data_reg =3D (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
> +    nxc_type =3D GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]=
);
>      blk =3D GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>      idx =3D GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
> =20
> +    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));

Hey Mike,

Was in a bit of a rush and forgot to let you know earlier (thanks for
reminding me) - I flipped the assert condition on these when merging.
IIRC I got an always-false warning on one of the CI tests there, but I
can't seem to find which one, or why it didn't usually warn.

I know you're part way through wrangling a bunch of other xive stuff
that makes this stuff difficult to test, so no worries.

Thanks,
Nick

