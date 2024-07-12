Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4C0C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5FW-0003cF-EQ; Thu, 11 Jul 2024 21:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5FR-0003ZT-Cf; Thu, 11 Jul 2024 21:38:57 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5FP-0001bq-Ap; Thu, 11 Jul 2024 21:38:56 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4f2fcaa2a3aso510892e0c.0; 
 Thu, 11 Jul 2024 18:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720748333; x=1721353133; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWtxJ0dcTgnG25YpwN2DroWk2hpH9Qntg9pW1RZauHU=;
 b=P+kTuUrPl77SBjOPZ4I0G64M1V2o7K3vwTnm4y7vPU1xLj54YIFQSQ34n9CKmAnCso
 UWJlAF6wMvCLCFWA2k+yfEnvksrLWATT6ynwV7WJWtYnX4MXoDUspA+Om5kLxuf+deuS
 aVBKjlAfCgIY6dj2fd6avyxPuG6xMbdk/T0Og0pOsOuRvmyvrXG6NPaLzXR51jP8kFck
 ra0woz2w9S3wtCjZMJaQICzM1jza0T8TF8MISXVpPkq1F2rW3L518TTRWOTiDdHIMxiV
 PgUcarZCAha9LZKohyKAcXprupTcDTBt2vlhqSLe6AT3nDKTn0HdqNq7vYyHvzUgifMf
 qi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720748333; x=1721353133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWtxJ0dcTgnG25YpwN2DroWk2hpH9Qntg9pW1RZauHU=;
 b=R9ccPXdaFUTT8G0Dd/v43xnPEEplv0Gk5CNjLP0Rap4KwCliF/9B0aha9/IjslJzk1
 KhGUboVjYeWQAY3XgT9Vb3SWLgO73knEG81OxEONPcPRXE9853xPxk77YBNNt07stVZ9
 TCLtSaNXteHnzlPVTlcIjPeX3IYmyQv9TtkylmP1JS5FyLiZluMs2Nv1QdqhgRewcd3e
 RoZsqUQNWPZmt98HOREOncFgOlspls+IzhyZZ8HTtlAHEJbGyLpLMb2JEd3Ae/g/woJb
 oNxQxf7HIDbZtkQYOR3Pj5E5Ta5W0/8M7gLjhE29AjSTk3AibSzdkPAhnc43815TCag+
 5OBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT0LOY5ECt4JwBTTeq4ZjduiGH61ikkxZELnd5MyHFvGpzP4ijFM+hL2avRbTThd65qMmKQh6e/fWZBlt/9XYZepUSXaGGoZFpzfAUHXmqBdQfMF7msgR+dUaMaNsXUawnVMJCUuOZPrrKjUHrnt12UXZO4NnZ+p6J79SpXEjS9R866yRt4g==
X-Gm-Message-State: AOJu0Yx5xQ7VvOTSAOG2NhU5OoQ650KqH4NgIRWvwEd5Cggd4qmCOGfg
 QhQkzHqFVLepDVQX2t65oY1tEVbCksXfHbMyeUPn3MjWadKXNRAYF/LgQsOYYhFRBmAZ6uDxeuH
 SFXUCe8nKZYrkTqCTdCjBMUCmkkY=
X-Google-Smtp-Source: AGHT+IGsBZE4Y6iKi5jn8R3lkIQwuZkeHw0y510BoRYvbZLE7/F296R3x7pG/ocTDgBfQydXr2aeLdLQhSRlvWJIn1U=
X-Received: by 2002:a05:6122:910:b0:4f2:ebd9:8e12 with SMTP id
 71dfb90a1353d-4f33f24fa48mr12860662e0c.5.1720748332575; Thu, 11 Jul 2024
 18:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240612081416.29704-1-jim.shu@sifive.com>
 <20240612081416.29704-4-jim.shu@sifive.com>
In-Reply-To: <20240612081416.29704-4-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jul 2024 11:38:26 +1000
Message-ID: <CAKmqyKM0mua8sGP46aRYucHaiqcSL2e-urK6pC7X_H7fJ2YFSA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/16] exec: Add RISC-V WorldGuard WID to MemTxAttrs
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Jun 12, 2024 at 6:15=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
> transaction on the bus. The wgChecker in front of RAM or peripherals
> MMIO could do the access control based on the WID. It is similar to ARM
> TrustZone NS bit, but the WID is 5-bit.
>
> The common implementation of WID is AXI4 AxUSER signal.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  include/exec/memattrs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 14cdd8d582..d00f3c5500 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
>      unsigned int memory:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +
> +    /*
> +     * RISC-V WorldGuard: the 5-bit WID of memory access.
> +     */
> +    uint8_t world_id;

Everything else is using `unsigned int` so I think we should as well

Alistair

>  } MemTxAttrs;
>
>  /* Bus masters which don't specify any attributes will get this,
> --
> 2.17.1
>
>

