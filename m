Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B93FC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0U4U-0005aO-Vh; Thu, 03 Apr 2025 19:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0U4T-0005a8-8P
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:34:05 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0U4R-0007G4-JJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:34:05 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86d6ac4d5a9so762749241.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743723242; x=1744328042; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhgG92tkk7tvDYMRR5rEuWW399GqhuKHFVFPAjY9GS0=;
 b=Pyyk1VMUPqLgZPvXKUvFKPMjQcOvxn57TZjdhplH0i/5mGg8tqaZP85o6tLxBIHvmD
 aWA1NZbINbzoqXX6bIDdgP3hIruq2P+EkX0B4YQbFt/AR07HFvwXGyw+rnoefCdqgwl/
 hOp7ccroR4xQQb3XhhHnWD1+OqJDSf9p9cF/L8xNWF2jvMcVnzblSVPABmAwcCBUwg7E
 VNs6vm9MgN488CbnlyoReyTuS3SQaFDBxxgvHh5udLmc2BEps+k3DhjnKqLJylwLBl3Y
 UhG/DLkfwy00kE/GP+okatwrRz5OINsdVTkX+DWx3w9BdVB+cj1Q1YHhlBr+fU+Nd7yT
 1hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743723242; x=1744328042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhgG92tkk7tvDYMRR5rEuWW399GqhuKHFVFPAjY9GS0=;
 b=T6DMcAtH+FaiDiP6Ft31mTG6XEjFZlcXeZyJvzor+WR5Ew0iEZN7VbgDOiL3ReT/fX
 NiOYJywS+2FlnDKqBf5wS4jBlgl/XGSAnJqaHJUAkJR7SGaVmJie1lCQHoOIisGnuJ/4
 0mlQMuki5+DOuAdK7pKWp8f4hK+qL9CgAbI2KhlKlXGNLUEtmm3yig80O/FOcWJ0FX8n
 kVBbREdsm0VT8IwS7kdzRuDjPq8ZbjvJs1VwJvvBBsafOQsabDqJt9q8ImOcegs5IKmm
 +3JOt9uliChEe/hWIF2/5yWs23PkctV0NbtCrYNUCf/7uZAT+m0esvY4a5ZWSD76hTar
 UOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+FFBgzSWCmMTSnZvBgt11MqBUeGdqoT89faGIPD7bcDTLrAY1a1ZXRrR32DKcffPdbM4DbRlmRm8l@nongnu.org
X-Gm-Message-State: AOJu0Yx0eU8g39pOCRoHBjnvdqP+EB0EdnN1tTlP0Xt1vBJrHGnGYMr6
 CsBTKz6bUK8qwiPRFD8oQrVd0r7u+Jf+s/brG7J+yf9fUeq2t7ie3Iu+DooAhrK4DCt1NQPch2M
 MLaBgz1edLDlC9a5lWMOyfm09yvQ=
X-Gm-Gg: ASbGncukZoXkqqlXw/FPTzRwJENCdGRv0zYhm7FHCmuk1/XqjmtU+RjwsE8MpWhn18d
 02SO2pNNwRo/IPaygIE/lrD97bNnIgBCahq5UTDehOTvdiNyNZtMvnfpVQMF4MOFWUTgOE49cVG
 dztOQqjfrWpap2IMBZ66+dW2eJQh8KQRlf/2vCQnDfxRytl4EZaLA/S/9JASh3oA4r3Dk=
X-Google-Smtp-Source: AGHT+IGsvbEt9ajI5HzSt3G9I0lpeTVuqWEdmrfufBP31Gch8BuQZSnftmwGFgRTIG1/+AezfRQhuHdR9ZbqKG7jEkM=
X-Received: by 2002:a05:6102:334d:b0:4c3:6979:2ec with SMTP id
 ada2fe7eead31-4c8568e59dcmr528495137.11.1743723242159; Thu, 03 Apr 2025
 16:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250401041509.719153-1-joel@jms.id.au>
In-Reply-To: <20250401041509.719153-1-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 09:33:35 +1000
X-Gm-Features: ATxdqUGtHV-7iCyHouX4XYGaVCAVP3RwtRX8lP9BZwQdTjgSi1kPFy7D4l1BGnM
Message-ID: <CAKmqyKNkESJ_BfrCVteXrgdrfEK9Ku7WG1RtS+3ispaYxC7rYg@mail.gmail.com>
Subject: Re: [PATCH-for-10.0] hw/core/machine.c: Fix -machine dumpdtb=file.dtb
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Tue, Apr 1, 2025 at 2:16=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> In commit 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb
> option") the call to dump was moved with respect to the init of the
> machine.  This resulted in the device tree missing parts of the machine
> description, depending on how they construct their device tree.
>
> The arm virt machine is missing some PSCI nodes, while the riscv one
> is missing most of its content.
>
> Move the dump to after the notifiers have been run, allowing
> virt_machine_done to be called and the device tree to be fully
> populated.
>
> Fixes: 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb option"=
)
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/machine.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f52a4f2273b2..63c6ef93d296 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1731,12 +1731,6 @@ void qdev_machine_creation_done(void)
>      phase_advance(PHASE_MACHINE_READY);
>      qdev_assert_realized_properly();
>
> -    /*
> -     * If the user used -machine dumpdtb=3Dfile.dtb to request that we
> -     * dump the DTB to a file,  do it now, and exit.
> -     */
> -    handle_machine_dumpdtb(current_machine);
> -
>      /* TODO: once all bus devices are qdevified, this should be done
>       * when bus is created by qdev.c */
>      /*
> @@ -1750,6 +1744,12 @@ void qdev_machine_creation_done(void)
>
>      notifier_list_notify(&machine_init_done_notifiers, NULL);
>
> +    /*
> +     * If the user used -machine dumpdtb=3Dfile.dtb to request that we
> +     * dump the DTB to a file, do it now, and exit.
> +     */
> +    handle_machine_dumpdtb(current_machine);
> +
>      if (rom_check_and_register_reset() !=3D 0) {
>          exit(1);
>      }
> --
> 2.47.2
>
>

