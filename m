Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486F6C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyPj-0008Ug-KW; Mon, 02 Jun 2025 02:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy79-0002j9-Pq; Mon, 02 Jun 2025 01:53:54 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy6s-0000CD-Nf; Mon, 02 Jun 2025 01:53:28 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a58b120bedso8901341cf.2; 
 Sun, 01 Jun 2025 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843574; x=1749448374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgPMuU93U1FMwITcOwsbLYmf1HcFNXdnE3EV9KStwoY=;
 b=aDtZLYUPMBq7YJzVGfq9sVjAYMIFF1RlWUPhbKxNDxZkrKsqfdje0VfQiuOuGzFlbp
 LRvKxoCJJB4OEqc9p9zyYyoS6HoVgEMqy571PFoMTK0WAU2TtTk9pWgXs13+Cq115pKU
 xfqPbQ17HkzoiKoEX2US6HQR+Ztv7SXHhFQYy3HWY8rTk63EK3ye13PvftXLAkrWt/Lr
 vgMtvQ9vijTzaP7Bn4b+kBMBXfrDrhZiTJLzu9VQHNyQlEU1kXy0bOcktwPw0LFp6Iwh
 U1aDvIf2j8NHyEjsMxtFT9UjM1XV3KbfMcZ4nhXKYYzg5m/w8oMAyIP8/Ro99REgSStE
 zwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843574; x=1749448374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgPMuU93U1FMwITcOwsbLYmf1HcFNXdnE3EV9KStwoY=;
 b=XiNrOn+jNtKCpkIGzGfsfv3x/vcf9c0Y5RbOU4Zl7H+A3RIA4UpPDZchqxXmcbxksO
 u+EYuyrCa62x/89c+vEibuLyXjErkoxJnJTQZEq6Pc8/cjdCcFIWA+1qgL5TLAFZ/tU/
 9+TklRNBu8GNLOYB0CnI1QsfhlXHA4jg+TgpLsFgJrZ1qVW6ZZN4vZEPwNwMc335Syf1
 X0ztBEq5Te0gWuqa7QoWqA/J3qj78NduaGqGy3wf+OCfpBnv5J8yDPiiOLbkhIRTI7eY
 PjKbyNL38TwbMGC4PHFLEOfsyebwL//GOV5O0shLA2T9FkiQLVk9dBiQ+B7YEAf/gdVa
 fHhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHLIuoR9ay2kusn2DBljwFpOXNkqVduY/RO8cMgCovVzNo/xQ93lMJOBFyEXai0hBRierEA+A3MsL2@nongnu.org
X-Gm-Message-State: AOJu0YxEB2ELlZHwnGFzQ3hcMuRd5Mo0La++b1f7awWwFcmpTEI2OX3i
 z15Yw2sNTfUtsIuF1Ms83hV1T0Hj8MESbACkMuVg2DBiENDnWq9f5Qmgf510C/i3wN5Qz0bAYGl
 h6ah1gMXXGa57lGeGjO0hRYmS0YHY3KFcQA==
X-Gm-Gg: ASbGnctCygeZ7NJhHj2z9q2e7JflW4+lqPwOzzHomb7ZALxbAf9BBY95KornpEbx+bi
 3CAOcyFExBA6xxQH4SXijtPnZzB9VlBBBdjiALRynCikX9xhyKSkDczW8YE6Ok3jIFdVH94HDRO
 8Od8nOdI0r56mdPLG3l8Nt68YROALgKgj5mriFc6yn+Ttx7V5Ah+2nYKzU6c5nxL4=
X-Google-Smtp-Source: AGHT+IG3RlrJdylFbVkWnfXc2PzW66lcXAZJpV4rC3XdQBLaDEEz2MaaFAeJEPnEnWHKH5v8rhYtjyrDi1yJtOVjj18=
X-Received: by 2002:a05:6102:5112:b0:4e6:df89:66c4 with SMTP id
 ada2fe7eead31-4e701c885c7mr4215824137.15.1748838837775; Sun, 01 Jun 2025
 21:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
 <20250529202315.1684198-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250529202315.1684198-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:33:31 +1000
X-Gm-Features: AX0GCFv9Hlr49_kY0JBhhcMNzhB93ECXr6rPEGH3Lwaec49t1wVkpSfnWEO2Nts
Message-ID: <CAKmqyKPx6ugzvY=FEC9ff803U1MtKfH1jq+2kEXssSDQBqfmDA@mail.gmail.com>
Subject: Re: [qemu PATCH 3/3] target/riscv/cpu.c: do better with 'named
 features' doc
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x82e.google.com
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

On Fri, May 30, 2025 at 6:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Most of the named features are added directly in isa_edata_arr[], some
> of them are also added in riscv_cpu_named_features(). There is a reason
> for that, and the existing docs can do better explaining it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cd0b159ed5..fdf2eb2b1c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1377,13 +1377,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experiment=
al_exts[] =3D {
>   * 'Named features' is the name we give to extensions that we
>   * don't want to expose to users. They are either immutable
>   * (always enabled/disable) or they'll vary depending on
> - * the resulting CPU state. They have riscv,isa strings
> - * and priv_ver like regular extensions.
> + * the resulting CPU state.
> + *
> + * Some of them are always enabled depending on priv version
> + * of the CPU and are declared directly in isa_edata_arr[].
> + * The ones listed here have special checks during finalize()
> + * time and require their own flags like regular extensions.
> + * See riscv_cpu_update_named_features() for more info.
>   */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>      MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
>      MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
> +
> +    /*
> +     * 'ziccrse' has its own flag because the KVM driver
> +     * wants to enable/disable it on its own accord.
> +     */
>      MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
>
>      { },
> --
> 2.49.0
>
>

