Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04C2D1CA07
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t867M-0004iO-SU; Mon, 04 Nov 2024 18:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t867L-0004hm-FC; Mon, 04 Nov 2024 18:04:15 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t867J-00088k-7C; Mon, 04 Nov 2024 18:04:14 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ee1e04776cso515825eaf.0; 
 Mon, 04 Nov 2024 15:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761451; x=1731366251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gepgepocMABpJA8a94CqxtlWtS0jdyJd70TCyi2lI7Q=;
 b=iUCbOURQUSOOQHyXogt2XGi59Z1dBoTY/JBbL8k94kUQI5lULTNyE1MVmeRKUKg9aN
 gJAVyNc2vFECHcvkF9qiXxzfUX4Laweig/SMvRssWBUpNQYVPWEyGM6j0vWlFDCzu3bx
 1BSlGXnoh9icRxbd87oGAgDJMeeo5577T3YcW+dFIfOwpOj0D7S00xKndpsTfd9aMDjT
 zSvnMsFZNiAbn8fI3iOUywUHk9Ajo0Qn+WH8hFB1WUur/J4q9C1PX1q7fUicMGg/rH4m
 8uSo/Fcd6exmZAvQTj060OrZJDumURRmr5DIlrQhFSeq0ZX42u8YqoiFrTFiul6rU8YA
 um8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761451; x=1731366251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gepgepocMABpJA8a94CqxtlWtS0jdyJd70TCyi2lI7Q=;
 b=mLsBRr6o4vIVTWNvvkeoLQgur2TXyAl7U5u8H3GiEuDYnlTnkPokiW7YIE+2kzfTP2
 zVIgFwTJ7KK5hYri5/3t+Cu7+eraRCUqgAWyYl4xlsGVjke++t42AHM7GmX1XSQGy+2t
 6+/pa0lIpo2kyjXbA0kzdZen38FLmjuLtxJEui9FDCpGDkwADo+4lt803BqQe93sJmtg
 aHxqp0TxGYTsmYsxVNAySwfvQaP2a9P7A0gfAGNzEwMDiOXJmeDxuEE3Y4sKS96CI2hk
 Til3WQEdPfGFUdN8scIDCLEetcWLMQaP6A8qD/Hq/oHZF3cNhRQVU8JsdYPQQsCn5Ih9
 w8yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8aS1ut1W++jIbQwOiyXoKjs4Ed2FdVFAgwrI20oTnYXM13GBSxzK20n37g2DQ2AQlMziOtpGdSGB/@nongnu.org
X-Gm-Message-State: AOJu0Yw5GqzJbRrtvx3VaD8ANV0QHZpkKiCeHukxgDrT0QtOLKnu8w7R
 wGc6z1Rx6s7KH5xikg3PqEK8cI56A0yvPiZO3RYGfWmQ0sdLwqDqhujjCXwXVXcwmZeF/CrV1Cq
 r9u+coQzAz7mYKb8zcLIkK7YVhmA=
X-Google-Smtp-Source: AGHT+IH39ljyqG10otc90p6gajPafd7uZ9dcVZ3KmD0NgFPPzC9gGUcNEjKy8ig9IdlWokpk3iEznyjzj31NxXcdSB0=
X-Received: by 2002:a05:6358:4b42:b0:1c6:505:7a9d with SMTP id
 e5c5f4694b2df-1c605057bfemr288290455d.2.1730761451328; Mon, 04 Nov 2024
 15:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20241104173551.125069-2-ajones@ventanamicro.com>
In-Reply-To: <20241104173551.125069-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 09:03:45 +1000
Message-ID: <CAKmqyKN3tu3r07neBEiOc_5O5w2qWjayyfCez9D63RbSKr0HLg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Fix leak of reg list
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc34.google.com
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

On Tue, Nov 5, 2024 at 3:36=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> Free the temporary register list.
>
> Fixes: 608bdebb6075 ("target/riscv/kvm: support KVM_GET_REG_LIST")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cbda4596da73..effd8fed815d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1170,6 +1170,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>      }
>
>      kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
> +
> +    g_free(reglist);
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> --
> 2.47.0
>
>

