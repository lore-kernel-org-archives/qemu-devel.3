Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB30C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 00:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rekvP-0003sc-RB; Mon, 26 Feb 2024 19:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rekvL-0003sA-V4; Mon, 26 Feb 2024 19:02:20 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rekvK-0003SL-Bi; Mon, 26 Feb 2024 19:02:19 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-21fb368b468so1868187fac.0; 
 Mon, 26 Feb 2024 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708992135; x=1709596935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW48Raih0KzKtumNcwBwUBVHWX7bUtoks2rRULxVj5Y=;
 b=d7BbPla+fKNZQos6I8oFfN8tAxf/uNm59yAsfEj8IuLQCAk5htI8rI8RA1HxfGQIvZ
 90fSivX748vwW2vttHliOYRDtUzULvgKdBEeBkEHPNz3P3dRbN+DkZTfY/2Rr5vtfO4O
 VFFCYzSsYCZ9NPsw+c4LNgeI3ENXv7yky3vQI/N/42o6UM86x1oPsbV1u0pgeEHwHKgA
 MzR1Zbci7948QbwAkd4t/E7fHCmMyqV7/b9Lbu2HwdyzOOfVK4X3n9ZZMu6bMe1hBSqh
 evVyY3/c2lQM4IKuA625Gq+ILfq4HxPmxAMKUfkOIgYSUorL9A52Dl6mnogF4H3YzVAU
 sz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708992135; x=1709596935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pW48Raih0KzKtumNcwBwUBVHWX7bUtoks2rRULxVj5Y=;
 b=w4CoXkfbSr1/15NuABaZm7DWdb597itVwJSm8BAwECjs2Xp7pw3ia9yNXg92YEhY3s
 0IKFVEryfbDgXljFhqya5znK2LsD92eavQBGgGj1TCth9y8YWKhmn7TJw7wC37qvnQJ2
 KF0yUysyTAbJCV6EEP9q8THepMRbh5jiv87yWcI1e2Ti+Zwha8ratVS2lZvsvXdyb7nt
 h5HoXGNeIaoj87PjNGye9CvQ+YkNisGEvG3v7d05qBwG2SFs6WWrxqtNCAk0/L9rJsnl
 cmZhVEPevDzJXo5VZec669sC1iIpTQPSDIy5LzQ9Cilu6NYx43BOZqRLVM0ti7DVz0a1
 fwoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2KhZCWI6QCMxpQCWxuIaz8W5h/kWG2HPDvjd7uwdh6udbaHE2W/S3IMkjjsf8eTTzNHOxX3jzIBvnlFue6qHBLfJNVs8=
X-Gm-Message-State: AOJu0YyNu1aVJvi7rBZRYqZR4JXEy21yjm/qA4IxW3WBZSHZq4/M5OIJ
 7SQWlTfF10jcoYLU+mNIfKry8TNkf+e/84XUwn5Y1WybXdOsORXUQPEnribuKgBJCVUP1GT5oX5
 gNaY9IC5mFSPg9kS8N73G0L5qNC0=
X-Google-Smtp-Source: AGHT+IFkkbL5txNFz5s0PtaKb1fA6dvReVCSdkwsbFh+lmNQNIZ8sHDpQ2sws78QVhgGrBaBwBE3f7B7HnUSiKj62+c=
X-Received: by 2002:a05:6870:1583:b0:21e:a1aa:ab6a with SMTP id
 j3-20020a056870158300b0021ea1aaab6amr8522894oab.6.1708992135155; Mon, 26 Feb
 2024 16:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20240226070825.51120-1-alvinga@andestech.com>
In-Reply-To: <20240226070825.51120-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Feb 2024 10:01:49 +1000
Message-ID: <CAKmqyKM9914UJ-Fta=b-xuVoy8bQOWsZs=HqC4TsA9DUa69cXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] RISC-V: Modularize common match conditions for
 trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Feb 26, 2024 at 5:10=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.=
org> wrote:
>
> According to latest RISC-V Debug specification version 1.0 [1], the

The issue here is that we really only support the "debug" spec. That's
the 0.13 version of the spec.

We do also support bits of the 1.0 spec, but those should be changed
to be hidden behind the new extension flags like "Sdtrig"

I think this patch still applies to the 0.13 version though. Do you
mind changing this to target the 0.13 version of the spec instead?

Ideally we can then support the new Sdtrig extension in the future

Alistair

> enabled privilege levels of the trigger is common match conditions for
> all the types of the trigger.
>
> This series modularize the code for checking the privilege levels of
> type 2/3/6 triggers by implementing functions trigger_common_match()
> and trigger_priv_match().
>
> Additional match conditions, such as CSR tcontrol and textra, can be
> further implemented into trigger_common_match() in the future.
>
> [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asc=
iidoc
>
> Changes from v2:
> - Explicitly mention the targeting version of RISC-V Debug Spec.
>
> Changes from v1:
> - Fix typo
> - Add commit description for changing behavior of looping the triggers
>   when we check type 2 triggers.
>
> Alvin Chang (4):
>   target/riscv: Add functions for common matching conditions of trigger
>   target/riscv: Apply modularized matching conditions for breakpoint
>   target/riscv: Apply modularized matching conditions for watchpoint
>   target/riscv: Apply modularized matching conditions for icount trigger
>
>  target/riscv/debug.c | 124 +++++++++++++++++++++++++++++--------------
>  1 file changed, 83 insertions(+), 41 deletions(-)
>
> --
> 2.34.1
>
>

