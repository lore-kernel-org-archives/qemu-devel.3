Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma1oCx5e;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=drabZTfP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJutU-0002b7-Uf; Thu, 22 Oct 2026 11:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xJutQ-0002ak-Bb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xJutO-0000wq-S0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792683585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRdDwD16FYdo7f8MRpViIOxs5O7sss2LQ1g4MZ9nNPM=;
 b=Ma1oCx5erxqsIvCHPLRgI6OrRDFwT1RSVYLY5qqiHC70ruziWdA1ax7MABmipyIZDibJoE
 PVpxPbU9q4951kOp90MWiafT0sJVU7RExxmMt+ariVX4CRfuAGQ9TgDpONOxZ1BUq3eGyB
 tudOVRz6wPGs0SLOP7Q33tf7TxsZt24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-WQgLD5iqNUqo4kQjYh5H-w-1; Thu, 22 Oct 2026 11:39:37 -0400
X-MC-Unique: WQgLD5iqNUqo4kQjYh5H-w-1
X-Mimecast-MFC-AGG-ID: WQgLD5iqNUqo4kQjYh5H-w_1792683576
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so1553919f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792683576; x=1793288376; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SRdDwD16FYdo7f8MRpViIOxs5O7sss2LQ1g4MZ9nNPM=;
 b=drabZTfPb3FnVHVM+UbjzxEdKctixdHkAGpr0s7uQH5RzFh9+a62jtvSjjNqAHO7L/
 5HAEArJZ8yQpPHA5JbGAbUnURJisNBjeE97k3eYyjD/4snODN9QlMDf4IngIeOxDRPwr
 BwFM7Q+NW25qL5ocoY36KTM2GDA4VZLrga1AaJ1Am8g1jt7pEOMIps7Op/SQLU3CjDh6
 ePRQfAC9ZDZj/EQ0QpLIVt0ruIfthFHt6Tztd3YsNA58SDSQj4dNilF6vm9hrlHkqJ7Z
 kSzcVon7e3/CX3VA97Hjgzq5sLqHdOYRytHMCAUXQXBjrsYDI754/MGVg1j8jVcvS9ZM
 yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683576; x=1793288376;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SRdDwD16FYdo7f8MRpViIOxs5O7sss2LQ1g4MZ9nNPM=;
 b=BlFIhve4edLtmfwL/nzUvAzLPCDZd9w8T0Qkh1OCt8vgy3DwIZqNrFpKU2+n4UDG5/
 AozE4fkHvY9wY/mWzPUQac9BcmIMEnO/vB3h3WkMFx8T47DXgL4tK80gECL6lthcCJDl
 x4QxpuINp17cNmHly/MtUXVsZCjjrwH6gEFnNgGwsdC26thNwKTID+G1ovhIPXoVpIo1
 lXu0SpbKrPVrfc2vilTkSX6K3N1ALpjQg7IpIEN9Y8XjY05SMf4bOVQOVzvNBasFRfg5
 pKpV4MNq7lZoowHOYLIvncpR5J1yiMj1RunAxw3Dfm7IFOwpd9ST8K6LNFyrpnbiTXRE
 vRZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxozMaqVBfP9svaFMPjTiszXyrhxexJFmgrtKsCvXPAzCLtV0zuaD7Ni/pz9RN7kYDid8uFAPnpqDdI@nongnu.org
X-Gm-Message-State: AFq9FYKD6KvSN1bijEJKiOrJqf7xFT6o8lP3l8DMzj4t6ilqTtUFoGzm
 M0gI4PyhehUgydv3Ai+qVbF94+fjMgrlr20OlZfy6WJ+Ac/6TeVvQqnuFCIOpMVVob2PnBL0fm6
 8Z+mDCPeHx1a9/p3uHg+Kq7xBYjLue4cAzX363feFu8P3ZYOBQH7yEbVv
X-Gm-Gg: AYBFou1Q49VTpiRTvhZwq4lZ0fP9sUCanOdiEHdrDkdaKezbtszA96a0XjeGmSs9fVo
 SG8XlUIN/gXuhQwVIgCyeuuAZZOc4cBGCnNEY0ZhtrIyUvXxMbYZz92oCiyvp8LAoucLbQzX/m8
 pcrZh1SCJQ4cBE3qbusoSLz1+65Snpq6OW5qHR9xJM8AI9X4GFCP9f3Elr9vEbGGtq8TxX/+U7z
 LAbznsnJ6eTUWl0SqHNk5Qh89FXXEVlEAssUUnILcqPGojzS11w3Bflcip0ZxzCm/avlS1oHcDu
 rFg+opWZZfLTKWLrySA/ZNcI/0CTNnd2vBEMsvB+WQZ+LaS1w1Wl+ot+2WOk0A==
X-Received: by 2002:a05:600d:8653:20b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4a205ca7975mr40893985e9.4.1792683575942; 
 Thu, 22 Oct 2026 08:39:35 -0700 (PDT)
X-Received: by 2002:a05:600d:8653:20b0:4a2:5ca:767f with SMTP id
 5b1f17b1804b1-4a205ca7975mr40893675e9.4.1792683575553; 
 Thu, 22 Oct 2026 08:39:35 -0700 (PDT)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd13891sm91091195e9.2.2026.10.22.08.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 08:39:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 17:39:33 +0200
Message-Id: <DMBHAGC8CCIH.KY6YB03VCSMJ@redhat.com>
To: "Anton Johansson" <anjo@rev.ng>, <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <daniel.barboza@oss.qualcomm.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu@processmission.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
From: "Tommaso Califano" <tcalifano@redhat.com>
X-Mailer: aerc 0.22.0
References: <20261022130657.6449-1-anjo@rev.ng>
In-Reply-To: <20261022130657.6449-1-anjo@rev.ng>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 22, 2026 at 3:06 PM CEST, Anton Johansson via qemu development w=
rote:
> mstatus and mstatus_hs are uint64_t but accessed through
>
>   tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
>
> which on a big-endian host running riscv32 incorrectly accesses the
> top 32 bits rather than the lower bits.
>
> Widen the operations to 64 bit so the lower bits are modified.
>

Maybe a Fixes Tag and cc to QEMU stable?

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index ede9c2563f..79b0f444ef 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, in=
t rs1, TCGv offs)
>   */
>  static void mark_fs_dirty(DisasContext *ctx)
>  {
> -    TCGv tmp;
> +    TCGv_i64 tmp;
> =20
>      if (!has_ext(ctx, RVF)) {
>          return;
> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>          /* Remember the state change for the rest of the TB. */
>          ctx->mstatus_fs =3D EXT_STATUS_DIRTY;
> =20
> -        tmp =3D tcg_temp_new();
> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tmp =3D tcg_temp_new_i64();
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> =20
>          if (ctx->virt_enabled) {
> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_=
hs));
> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_=
hs));
> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus=
_hs));
> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus=
_hs));
>          }
>      }
>  }
> @@ -726,21 +726,21 @@ static inline void mark_fs_dirty(DisasContext *ctx)=
 { }
>   */
>  static void mark_vs_dirty(DisasContext *ctx)
>  {
> -    TCGv tmp;
> +    TCGv_i64 tmp;
> =20
>      if (ctx->mstatus_vs !=3D EXT_STATUS_DIRTY) {
>          /* Remember the state change for the rest of the TB.  */
>          ctx->mstatus_vs =3D EXT_STATUS_DIRTY;
> =20
> -        tmp =3D tcg_temp_new();
> -        tcg_ge\n_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tmp =3D tcg_temp_new_i64();
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> =20
>          if (ctx->virt_enabled) {
> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_=
hs));
> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_=
hs));
> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus=
_hs));
> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_VS);
> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus=
_hs));
>          }
>      }
>  }

Regarding the code I am not an expert, but this fix LGTM.

Reviewed-by: Tommaso Califano <tcalifano@redhat.com>

Regards,
Tommaso


