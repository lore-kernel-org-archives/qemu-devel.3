Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB480C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 07:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKCZ7-00064a-Jp; Thu, 20 Jun 2024 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sKCYx-00063t-W4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:50:32 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sKCYu-0007J1-UK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:50:31 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ebd421a931so5288381fa.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718869821; x=1719474621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmvkKLFrAnVOzJzAWCPbqsQqK73OL6BibxebFQJ5USQ=;
 b=ipIvtqXZViCZJWq+TLeaOastw0XEOoA4zTKzD3kvTdYnkWBpr/YVyoNkQ5yvfGH65i
 7gqGbDOL2eK1IzBmJ+790KVftPJf5/aI1dJhp21YdRgvCfwx3KMBJJbaPz0GR+xSci9k
 P1RG+c0e6qPZn9Fwmr0NY1buonlNbLbAXa2ST4oK1mzjylypYcw7MOYRRGGy+nmrEbk6
 5AP3oXKHC4OTTPShBEnLHlKRssRToFBYSgIUUglxf2B+J8gKqj9gLswQbvEUxrctInBN
 lIZ8I0xbEHI6aSkyfwX5cjsUPxnzV9xil1b2rYlkdOMLYUfwXZfVOLxTxTv24n49cZpQ
 jQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869821; x=1719474621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmvkKLFrAnVOzJzAWCPbqsQqK73OL6BibxebFQJ5USQ=;
 b=wFegsrfIXSTd/vCvQpXqAQbLNAN6QcJSOcIAkW2WnI8P4F7PUVlp8xklB6RhmRetQo
 /ArQQhcgTVKAnc4dy0Qs+A7vTVQUnkL9CoSGR7+yNx9tGPEQ9a3jJ5UV/nqKVHO2OAY6
 v/ea2ioCC4IzUnT9srkhHRobAsui/tuHggPDzLukd1L9mPz5x28Y7yv6mggcMsU1Q1oV
 kMb+vORutZxlCgy2FVkd7uxMTlH00G6wMqc9gIU2nOAMQUkHMimEyUJ5PS63Ac0qx/tc
 b+a7TGTlw8D4CsE85XpIWAu3MIr1/YncM0g5NkPEb02rFJTTlAbnlilyvpzSrjJgEVrA
 9HyQ==
X-Gm-Message-State: AOJu0YxzJnYttOWXTth/l51d7cbZ5cU+G3kRmq+mWEIgILc5aMKLThug
 f2YdIyDrYCieAsinDkwJx1+HB4KCRb2BFgAZKih8isBnPccQwqVGOPgwxnehAlg93fEAg322Mhf
 P/+lqK2BY8RzkVl8gFZ8TILLSDeImzikolAOD82Ut9gGEAszYvch4IRqepxVeKzz25kUX2H4328
 /gIWaoqNWqYrhigHhzqfFRpeVlC7whZL/YAsjfKZc/eA==
X-Google-Smtp-Source: AGHT+IF2ixeyspbkIIPLJ9ia+arAnqWVrkUi92D4ejN1yp3VYf+T+RLKoIXi6ADPfjxOPDj/QHQ74Q==
X-Received: by 2002:a2e:80c9:0:b0:2eb:1ac4:c9cc with SMTP id
 38308e7fff4ca-2ec3cfe1c38mr25972341fa.52.1718869821141; 
 Thu, 20 Jun 2024 00:50:21 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ec05c783e3sm21623471fa.77.2024.06.20.00.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 00:50:20 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5295e488248so702422e87.2; 
 Thu, 20 Jun 2024 00:50:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWh3/MBIA/zjH+WDOxLJc0AVLqpjx8Y3d/KJ/2oBsbPIg6zRJoUN2VA5zGaclu9ie0e9KHtixy1Pkft8TvlFQUZMXYBPtg=
X-Received: by 2002:a05:6512:a92:b0:52c:851a:a0f2 with SMTP id
 2adb3069b0e04-52ccaa57aa5mr3171088e87.50.1718869820458; Thu, 20 Jun 2024
 00:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-2-max.chou@sifive.com>
In-Reply-To: <20240613175122.1299212-2-max.chou@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 20 Jun 2024 15:50:08 +0800
X-Gmail-Original-Message-ID: <CANzO1D0MBHREjQgY0D+bWXMu_y=dXoXfGMhsWX-fhFaKRrDELg@mail.gmail.com>
Message-ID: <CANzO1D0MBHREjQgY0D+bWXMu_y=dXoXfGMhsWX-fhFaKRrDELg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/5] accel/tcg: Avoid unnecessary call overhead
 from qemu_plugin_vcpu_mem_cb
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Max Chou <max.chou@sifive.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=8814=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If there are not any QEMU plugin memory callback functions, checking
> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
> function call overhead.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  accel/tcg/ldst_common.c.inc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index c82048e377e..87ceb954873 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -125,7 +125,9 @@ void helper_st_i128(CPUArchState *env, uint64_t addr,=
 Int128 val, MemOpIdx oi)
>
>  static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
>  {
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_=
R);
> +    }
>  }
>
>  uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintpt=
r_t ra)
> @@ -188,7 +190,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
>
>  static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi=
)
>  {
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> +        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_=
W);
> +    }
>  }
>
>  void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
> --
> 2.34.1
>
>

