Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E8CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Gf4-0002ce-MG; Thu, 16 Oct 2025 01:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Gf3-0002cE-0B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:36:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Gf1-0004Vu-FC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:36:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso543288a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760592980; x=1761197780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itkQV7sgpQVFOb8iQ9DGOKMH66B1oqUuX3nCjsGsA8g=;
 b=ACbmUFC3MzxACMvijQlv8MwTYkV+mQCDhugCPsaWSXNO21JHE7py8SK/U4QfMkJUaB
 LdST4YEiGVXtQ0/XX6mF/wR1dcjfyefBhsuWDXdjqozdL1avKaxBuN+8AWrtmkQpML3w
 +Zkgp/mk1cif6qF3Avtg0lYLptqx9FHXkwx2c24U8eZiXnbuIVpp2ep6ePwLs7khDVHm
 s8eTgeF4tckuwqVl4hSgiiep7WC+ooro4LIqUDwuYCgg7sddxnMwADmbknIiEqWLbZ98
 HzIqbMVvvSboZZvyCiRkjJKK8ofgR3lu+E52XPGcAtI8DRH1XLzqmON9AK0h0EKn8XGu
 6dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760592980; x=1761197780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itkQV7sgpQVFOb8iQ9DGOKMH66B1oqUuX3nCjsGsA8g=;
 b=chke2pwqcpO7RW9lsA8qDtT+4KS60/8dZjGqxjAMMamENwPN4O5NGxIygVRRICdYFt
 4yidQB7RTEwypy+RKeNX3ohPHzoI3eOgbXsPJvMk6gbkIFH4VM5/KrXMr2qHQw9AJVPM
 J7iPMIJqe1mAAPRUO2vPNJaUFYBQKASe7zBP4gxQxJ8LVJlRznQ6pkWISUb+hkVPZ4ky
 rJw2MtOM6gbPfexbdazfmMpho7lb3YGw6QXPICRb3pLW5ANIG0CIthwB1b7KDpXgP8XQ
 NUYRGRH100KE2N33UwbrQkESisdeq3B3HUrM1pnUFE4FDot4sVmaIiADQp6F3Em/cJpn
 NsDg==
X-Gm-Message-State: AOJu0Yy/a4jbLqdyZEhFP00f1phVenjIO173wjhmFLmrs2g+p+VlQShH
 ImUEpTEpbs1QbT1Zvaab7FBxppGZ27rpZxWWIcZTK4rnHVKozhLkyYQzVmX58J53UZUjF4s3wXv
 DcBS+927uQEOjjdNWFCcLP+kCxBICG6w=
X-Gm-Gg: ASbGnctb5ebMJ7kYZmRSDS8N/2cxSmM89ptmYpDuZXU4Ziy4xqMSaBRSPIFApCTr4HU
 T6DIFccNOj2TJ22c62vVvbOatVDQN8dEPgZcTU35y1gNnEH5KteoN6q5QU0DHTNT7gpEO5xWgMr
 G49DVLBjaJ/Tmmyc3c9SGDQncF6sO7b6ACbAZVEDaJ4RFlfAJUVeuE3j+ki4dY6QxtAPbNzAJsf
 AKa/nCZczHHojfZdcahmfCbwa6g1kLyY1xkg3y4oeSj+57pcbKjYlzqqSxQWk+z7tnjopAyZYz+
 fcao4ruPQTvv7l3jVj3hgztF4Q==
X-Google-Smtp-Source: AGHT+IEEDP0/xJ+V2U1q44ICDtR5FgpDsRe7thzLe41rboogmX++k1KYHjrZxJSV33ThCdkPyKInNX5GC4UQFzvjRpk=
X-Received: by 2002:a05:6402:234c:b0:63c:74c:aaf with SMTP id
 4fb4d7f45d1cf-63c074c0b4dmr891093a12.36.1760592979711; Wed, 15 Oct 2025
 22:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-20-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-20-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 15:35:53 +1000
X-Gm-Features: AS18NWDAbRP_fgPcg-thzpArFPjr9XeWPn4fx8F5KkTXInWPArC8pZZvS4WQ10g
Message-ID: <CAKmqyKOLQJVCs2LMJQSmXqGoRKOQjuv-RQoGU-CEgO31q=1HQw@mail.gmail.com>
Subject: Re: [PATCH v3 19/34] target/riscv: Fix size of excp_uw2
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Wed, Oct 15, 2025 at 6:39=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix to 64 bits to match size of instruction start words.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2a71393118..6bee15cb5e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -257,7 +257,7 @@ struct CPUArchState {
>      /* shadow stack register for zicfiss extension */
>      uint64_t ssp;
>      /* env place holder for extra word 2 during unwind */
> -    target_ulong excp_uw2;
> +    uint64_t excp_uw2;
>      /* sw check code for sw check exception */
>      target_ulong sw_check_code;
>  #ifdef CONFIG_USER_ONLY
> --
> 2.51.0
>
>

