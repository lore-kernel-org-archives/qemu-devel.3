Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6793AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 01:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1samtN-0002xh-Td; Sun, 04 Aug 2024 21:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1samtM-0002wh-0r; Sun, 04 Aug 2024 21:52:08 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1samtJ-0005A1-L3; Sun, 04 Aug 2024 21:52:07 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f51981b1beso3650455e0c.2; 
 Sun, 04 Aug 2024 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722822724; x=1723427524; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Hxr5Mrhh6FpZja3ucnsJYc4mcK0pf1svcq8cdqm8M0=;
 b=GdGUS3Dg5brwpjhOOcnsECzTTLmEA2aGcsVD6euRz6qrjq43F/5M4TYNcwf1WBzF/x
 D0KM9xyalDa29ISaB/kjH7sDK6sglXafoMK/O8aAKhvFy8tFy6LlJQH7DVMTTn8Q88C1
 KwTsAHSUe1DxWXDQGPCQk7mQILha4LQC8o2hnhWo1ReZryJrpZtk8+eGMRHWzbajNY1c
 TMle0kz4/MvLxuXgPYLXQ4FVhtfwVso/4SguM0O/Co5CGbK/u+tZv4uO+f4Ag7UI8WpK
 Zz0YcrcSgfJvaKkHyuwqXqacP4ExhP3q4YOphJEbMZ4cmrT89N/2KVQcUH8KW0/srX5t
 HT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722822724; x=1723427524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Hxr5Mrhh6FpZja3ucnsJYc4mcK0pf1svcq8cdqm8M0=;
 b=hOOEKqdZgbSPLkTSy5yzGdISMtc3whZQ3bsyudvacnwcOsFGDT130+a6hZvV6qOwn2
 +itLRkQS5MEXpWiZiGSXXOwUb6CCX2DR5s/DEgj3LH9tDtZTX/9xKM2r2o5G2FoGJcPA
 xJB9PjxLgCPSb2LKmNkZ1f81DYgtN5+9wtAuLn3FLukr6RqIWiC6NBIPYl9YhQI2NOn6
 NJfDl7pD5q+EEhGDOK8V2xitTyPqiaJ+wRyoc4KMyK5yjX8PaBxZQoJgeRZ3SvxNOkpU
 a5a1gx5cccsF3ahlRAp6j1LIQEVYWeMqIOtXaaFh0wF8cg+XpkStU79gnoJwXkTregRF
 h/kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXStbmaIJkwF1fK94Bu7f7TOzjrSyQC3m9A84MJTR44TrpMqd8S/Dx+5WjcTEbeQMB8I89TrcQUaWKnRzCUglareqBu/l0=
X-Gm-Message-State: AOJu0Yz+L4Njbn4vHmbU/K4wP8RVvhwa35z5do07w+1njL3L7lu5jGBF
 NeW96QHLSdWQvF8WfMBqx2M+BGTgbf/grQJ30AKC6YWgGYLCOiwgnEKfj601HVuKtwkBKOfTBdj
 jqD6AFNKuXgWSxtw4nTeregDx2x4=
X-Google-Smtp-Source: AGHT+IHbwkU+zgs1NRKg+q2HQ4kIhU+MmFrQLa6n7axtmpNpyPY46YvO+WkA/IU4kydfTQg9dGQ6fVpj7Qenuu8dg5A=
X-Received: by 2002:a05:6122:a11:b0:4f5:130c:bef3 with SMTP id
 71dfb90a1353d-4f89ff3aca6mr12541182e0c.1.1722822723858; Sun, 04 Aug 2024
 18:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 11:51:37 +1000
Message-ID: <CAKmqyKPwbkXRzMiBK2LwX0fRvCqe+pLAQ1ipT14662KK+zZHeg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: Remove redundant insn length check
 for zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, Aug 2, 2024 at 5:25=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> In this patch set, we remove the redundant insn length check for zama16b =
as the
> specification clarified that zama16b applies to compressed encodings[1].
>
> Richard points out we should obey the MXLEN requirement for F/D/Q loads o=
r stores,
> so we add this constraint for trans_fld/fsd.
>
> I notice that we have a too strict aligment implementation for fld/fsd wh=
en xlen < 64.
> It will hide some problems. So relex it from MO_ATOM_IFALIGN to MO_ATOM_N=
ONE.
>
> [1]: https://github.com/riscv/riscv-isa-manual/pull/1557
>
> v3<-v2:
>   1. Using get_xl_max instead of ctx->misa_mxl_max as documentation.
>   2. Fix not clean split in patch 1.
>   3. Explicitly specified aligment for fld/fsd under all cases.
>
> v2<-v1:
>   1. Add mxlen check for fld when applies zama16b.
>   2. Relax fld/fsd alignment for MO_ATOM_IFALIGN to MO_ATOM_NONE.
>
> LIU Zhiwei (3):
>   target/riscv: Remove redundant insn length check for zama16b
>   target/riscv: Add MXLEN check for F/D/Q applies to zama16b
>   target/riscv: Relax fld alignment requirement

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvd.c.inc | 18 ++++++++++++++++--
>  target/riscv/insn_trans/trans_rvf.c.inc |  4 ++--
>  target/riscv/insn_trans/trans_rvi.c.inc |  4 ++--
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
>

