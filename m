Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128ECC87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugb1c-0003JI-Ra; Mon, 28 Jul 2025 23:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugb1a-0003ID-7V; Mon, 28 Jul 2025 23:29:10 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugb1Y-00068A-KL; Mon, 28 Jul 2025 23:29:09 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e9a284c225so1802679137.2; 
 Mon, 28 Jul 2025 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753759747; x=1754364547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izOVY+MbUchb+peejDaIk5KoH+WOFoXrfYq7OKf0wK8=;
 b=jCDWCKuTSUEA8F9U8lExlCXBJVdl9G1j1yhBFnTZe1oC6hwb7ltpHAVlvaxm7Tdjy7
 famfAbs3FQSN/koqkKuoOJ4pZOSi9nY1HnPetv52v4H11YkSLx8b2WQ6+/WIRmnRfo9W
 jHRK9Bp5RxZ8+EaGIvrHw3Mm5f+CT5+0r9afeJTckwAhIHc/i3ArQ/OqY4cAhkhYhmBd
 nD/oh514JbuWmEyaphByn2cPq+Gxo8dqMeqH06cnVkPvnDJH79AUhW0u/6IKuf4Yf7KN
 zP855XpJZxD8G0wTAqjM7NCTf8AMBRJqOeEy85MVIEWBxw3SdORFsJ6pBRy12ZKv1mNR
 QwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753759747; x=1754364547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izOVY+MbUchb+peejDaIk5KoH+WOFoXrfYq7OKf0wK8=;
 b=LacwbNmsREK+S7BWASKPozSXL5H7B51AW50skZkZqZZ1qU+lHlubu/kiiy3xq/GNng
 3zA7+0IzMfieEfI31rfmq1kCS1AWjzB67518m3c2oydkXESvDFZ7YMW3kPIq4m0E/Yxj
 UP6NLL+D9bNhoLin0kBseWh4BSbM3AZD38CIkjDQ8ZBnC+7k6jDoLmeVQA/dcBngigiD
 PssOfsl548yH3G8Y/vj47FvjimcZ08IuC93XRH+nqqyx1kw5yeIg7y8wPH1UGe0PfZDl
 KhYB9Zjmk/aGFGDo5O+klW1YkQu50VDmIubDzf+5Dqk+m45rDmwBYLw5LS14g/QPNi/n
 Vsuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9jetbg06fk8Obrj+a4cc3xwtAIvzxTGUQ24lZeK6k3QZURVmKhnXvaNGC/s3/9x89zYOhhjSo6zex@nongnu.org
X-Gm-Message-State: AOJu0YyTvYl2MU93y7gMM524NvdoiMLOq/P8dZ77G6RqAuU98FiHCAK0
 aS7do2NSL+oabehcPdcdwrhpH4QihLv3vCNqRm9OF7FW1BEPLWx94szq1GDdCOxZv3ak0kxobbg
 /Ds62m2W4k+rUoXs812rAv/jFGHjC2cvy1Q==
X-Gm-Gg: ASbGncsgoQF2hcL7spCG+i88HooCjIzXw7pg4FB2Fu92YMA+xahoizUCXflnuxVHTqm
 W3ZdfPg63MLZ2I6pEpk8DzG/jETlRLZPLfXjLAYgFpG6Ca2Oj4MutTLtkyODKy0Yg0EO9W4ikPn
 jwQY6gR3TSsBPG/HvdeHJHPIIaLHwfwLiSpxWHkvj0C7vhbQuxc5/dXfI/b7/G+vs5a8MayVDMa
 EPg8UDO34BJgRRxcZ4Xydo7ISGh1XTltbT6KA==
X-Google-Smtp-Source: AGHT+IHMJBZA3O2fcbEZ0HFWz1tDRfaTBka2LtQCnvZ9fQhIuQlLq21Sc0loFFSiM/sd+GblpfbCiVWSUZ/cMIO+ng8=
X-Received: by 2002:a05:6102:4a8f:b0:4e9:a2bd:b456 with SMTP id
 ada2fe7eead31-4fa3feb1976mr6399984137.12.1753759746926; Mon, 28 Jul 2025
 20:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250701030021.99218-1-jay.chang@sifive.com>
In-Reply-To: <20250701030021.99218-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:28:40 +1000
X-Gm-Features: Ac12FXwnIlrxwMxubi3e85i1o10YB2_L2scWUd8JFXT2cHeohmSxHOe79439utM
Message-ID: <CAKmqyKOo2AyzUdhCgnVGiFFuqk++sdFGf61c4MLM4sn31Kw7ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add S-mode checks for delegation-related CSRs
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Tue, Jul 1, 2025 at 1:02=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> Patch 1 adds a predicate to restrict access to "medeleg, mideleg, and
> medelegh" to harts that support S-mode.
>
> Patch 2 adds a privilege check for the "midelegh" CSR, which is defined b=
y
> the AIA extension and only valid when Smaia is supported. This is enforce=
d
> via an updated predicate in aia_smode32.
>
> Change log:
>   V3:
>     * Add cover letter
>
> Jay Chang (2):
>   target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode harts
>   target/riscv: Restrict midelegh access to S-mode harts

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/csr.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> --
> 2.48.1
>
>

