Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D39CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XdU-0006cC-Gl; Thu, 16 Oct 2025 19:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XdO-0006ap-Mn
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:43:50 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XdM-0002wW-I6
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:43:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-639102bba31so2746812a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760658225; x=1761263025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujbW208llVQvky7lGfL5zMm369p+t0cWpniEMjCE0BA=;
 b=NFsVqcX+KHRpW4umEg1/3Z3UjxNNPG+Coig1FSRwL1rSN1++myN+VzbM9Xzvzm/7zW
 iYvHi68h5+cBcEtpaLBlcm9Z4pVEFJ0lZdmOcEKDx73UufgpfEGMGcpPc0acND9hrqEG
 iwOta85QgCiM23ncot5fkryDvtn4SOxtCoQAR+TEm0VtlmSUehSDrADIAQw4w4n9KFc9
 OHMht2Pg52FT7BbpVvw7Eluwv83vFE/5EZhPpG+b+R1uSHy2iEewirOZ572u8mvOkGYo
 zPgFyZDH6d4CzQLI6iR0mLHFch7FxxpgVbp1vFFgLL8oWv/RFxt8et9ASL9Ziqgw1GQ5
 gDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760658225; x=1761263025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujbW208llVQvky7lGfL5zMm369p+t0cWpniEMjCE0BA=;
 b=bT2ybSZ/tlKuPu5FcvgjphJG/7BV+ppxYVe9HsrIe9iCfeAXUw7bUJULqSLfhyGzhK
 xGmWzS/dnjotLN6Cd27UMXXA4+AsKlXEfe1Z8zqdlbgP70upKoojRGRQrXM7LnccMpfl
 oXANgqYO6wqU9dOC87pZqN9n4+qkzCS07MuzBCNAQsvLB4VZskU15yUhUCisVd27OEdL
 uYOBSwMmsaH1onDt9Lo89HhZvI5OFIN0ndsDIuCc82hKZHePIQ68tgt1xKZQ+ouHCmqb
 2dVrR5jvGN7pNAUCFnv8ssEAbrsSnkLRNy5gYRRJ97xncCdxC29FsoDw0Mw0sEogCTcq
 JWag==
X-Gm-Message-State: AOJu0Yx9nkff+hK7KdR4+rd/eRqpp5uNuJKG0gxYVmwtwyE8eiyYLpty
 ck+FsdfL8+wQYM6kNluO2tpwzP9AiIRHhzQOvbVldM5cw4V0SQ91BCjQOKBAUEl3sgfnMGT7Yvd
 PJAnDPU7sUHfEJMeCmnpx//agU/vxPq4=
X-Gm-Gg: ASbGncsXYF3woQUezn9tiode0YClErbt+/Pb9HMSP46gJD0532C9PTUbeB7TdRodxDW
 PyattFwV78EXCNQcJLCHKFOALrrC9yFT8KdzJ/eLW9lmXSDkjkBHaRQlqHLErj8wsYRttiApwEB
 IqYNfrpZlhoJCexOImc32iKCMGt6S/W5wWB/5xspSufxWbp4SNvA611ArftIO2TO9HZIuND+wqz
 YqcDtItMF3gxoJb7Jw1Rsi2jirfzfNAK/BzIP/OWKMYSsTavOip3Wbuv4v05F0mOVxGu5DUzf4m
 CqrbrkAv7Ue+FBADIwcYMZgx2A==
X-Google-Smtp-Source: AGHT+IHe3V2HjR18IsM3xtPSstwD0nwqfO9sWPvDNoZ8BMelkApeEEFlJYtDedMEKVUn94OC4srHKajDf8M/ySXSBJ8=
X-Received: by 2002:a05:6402:358e:b0:63b:d931:3e98 with SMTP id
 4fb4d7f45d1cf-63c1f630766mr1430332a12.5.1760658224940; Thu, 16 Oct 2025
 16:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-5-8b416eda42cf@rev.ng>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-5-8b416eda42cf@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:43:18 +1000
X-Gm-Features: AS18NWAFON5PWk3kyD30AJvWsz6ZIh3QbGsEJFBXZ_Wx2IbkSZfgk4VDVvYq9yY
Message-ID: <CAKmqyKPCi=VPTOKydEw0urZOAGkoGMOFq-cD9aT0sMUoNCwHsA@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/riscv: Use runtime target_phys_addr_space_bits()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 15, 2025 at 11:28=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 450285a850..9ac37efc70 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2449,7 +2449,7 @@ static void riscv_iommu_instance_init(Object *obj)
>
>      /* Report QEMU target physical address space limits */
>      s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> -                       TARGET_PHYS_ADDR_SPACE_BITS);
> +                       target_phys_addr_space_bits());
>
>      /* TODO: method to report supported PID bits */
>      s->pid_bits =3D 8; /* restricted to size of MemTxAttrs.pid */
>
> --
> 2.51.0
>
>

