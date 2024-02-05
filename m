Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099ADC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 08:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWuTk-0003PU-SR; Mon, 05 Feb 2024 03:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rWuTj-0003P9-1w; Mon, 05 Feb 2024 03:37:23 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rWuTh-0007h2-Iv; Mon, 05 Feb 2024 03:37:22 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-295cfe8f199so2350387a91.2; 
 Mon, 05 Feb 2024 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707122239; x=1707727039; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBPyctciBgARMDJvVxUGQVGkikaVxDa7VWEdmJ6eeRQ=;
 b=eokaTVjXxh2FV0YswnwZjCgcNSjj7qNblkUEeuPwfrtHTG3uVmiOU9MQKn396u5we/
 6oiw7UPXc+OpzBDVR+3bXvzTgrM/l9C8qrotGRNRZV82WW2ph2YGJpxfAWgVB6l47hZJ
 7QeAej9wNZ+CPHVGNkFlWq9Pln83hSxb2C+3wBQ6kqKh+DSbVpJbfxLmwolYB59l64A2
 kCv6Xunl+Srsoha7+axazi22uDtBab1gukLAEvAM/6WKrqpt+ocOE3WnIi8ZZihK8yIS
 bwsh7gwogh0bVKk1/QZ0eRiYXsA+LBob1OLu9bCJzpwA3rX1u8f22XadJtN3IMzCCp/z
 WkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707122239; x=1707727039;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XBPyctciBgARMDJvVxUGQVGkikaVxDa7VWEdmJ6eeRQ=;
 b=UhRLsVcqkRr96/DpxRv6z7vyuYaqgL46zKMRQkunxkONOg2z9aZAw96tIjgaRTAeF3
 3ezcRji7QAOzKWmU9cKf7TrU5U+l+mgSeJoLO6hPLWYMU4ZTfdYpm+QI/N2QlsGnrupC
 fDTv1I5b+oJqEcLoubItfAiDYBlJx0WsAYvI/X8QUVITWxmFyne/mekZTB2wvoSzEnDm
 R5SYwyCK6PnqLP2TZxNAy3O+hdzk365N+eruBesA2BHfcy6AkWOE8T5ecogB3i/3VS4Y
 A92IrcW7sBqNymKWUXYhYpGJN0S/obJi82RraUXRqrfoNr17nn2TPe0sSNKoODVVqeFS
 O/3g==
X-Gm-Message-State: AOJu0Yyv6B4PouFtfiO7k2b1bDJiHl00udUJQZArte9ZQ4POZr79tW5e
 pHqU1GjMjaGhEJC3Ha+i+JSoLwRWXC6kDykajKa0nx9WR8FHywVV
X-Google-Smtp-Source: AGHT+IEveNJ4ZteP8llrLSlsCc9lwBBI/LSaUEbpm0AOeU3sF4TUOFo5OTkn8pqqjvFvIlR8qZ483g==
X-Received: by 2002:a17:90b:11c8:b0:295:ef33:49af with SMTP id
 gv8-20020a17090b11c800b00295ef3349afmr13175508pjb.9.1707122238951; 
 Mon, 05 Feb 2024 00:37:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUGjBW3vuMTPnJZzbg9h16iw7Xms+fP2sE1t+GWICCfVlo6tq/pkZdTA50Ob1a0Ls0hZzKnTodWOtqLcyipZGcWD28Kzd5o3WQLqmSKBc6VO5VAlrHAiV9EVC52Qg1cgNWZ748TLv2Niwdz89+1teNQIZRNq1bFeVw981OP96IUWXRbuP8q
Received: from localhost ([1.146.86.248]) by smtp.gmail.com with ESMTPSA id
 y9-20020a170902b48900b001d73228cd88sm5745470plr.255.2024.02.05.00.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 00:37:18 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 18:37:12 +1000
Message-Id: <CYX0BR3QNAX4.3O5GDHTDLPOOI@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 2/4] target/ppc: Add recording of taken branches to BHRB
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
 <20230925174351.617891-3-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230925174351.617891-3-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> This commit continues adding support for the Branch History
> Rolling Buffer (BHRB) as is provided starting with the P8
> processor and continuing with its successors.  This commit
> is limited to the recording and filtering of taken branches.
>
> The following changes were made:
>
>   - Enabled functionality on P10 processors only due to
>     performance impact seen with P8 and P9 where it is not
>     disabled for non problem state branches.
>   - Added a BHRB buffer for storing branch instruction and
>     target addresses for taken branches
>   - Renamed gen_update_cfar to gen_update_branch_history and
>     added a 'target' parameter to hold the branch target
>     address and 'inst_type' parameter to use for filtering
>   - Added TCG code to gen_update_branch_history that stores
>     data to the BHRB and updates the BHRB offset.
>   - Added BHRB resource initialization and reset functions
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---

> +static inline void gen_update_branch_history(DisasContext *ctx,
> +                                             target_ulong nip,
> +                                             TCGv target,
> +                                             target_long inst_type)
>  {
>  #if defined(TARGET_PPC64)
> +    TCGv base;
> +    TCGv tmp;
> +    TCGv offset;
> +    TCGv mask;
> +    TCGLabel *no_update;
> +
>      if (ctx->has_cfar) {
>          tcg_gen_movi_tl(cpu_cfar, nip);
>      }
> +
> +    if (!ctx->has_bhrb ||
> +        !ctx->bhrb_enable ||
> +        inst_type =3D=3D BHRB_TYPE_NORECORD) {
> +        return;
> +    }

BTW while debugging what turned out to be a mismerge, I removed has_bhrb
because bhrb_enable is always a subset. Shout if you have an objection.

Thanks,
Nick

