Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE08C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGkF-00048Y-8B; Thu, 04 Jul 2024 03:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGkD-00048B-Rz; Thu, 04 Jul 2024 03:19:05 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGkC-0004m1-9E; Thu, 04 Jul 2024 03:19:05 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7180e5f735bso207008a12.0; 
 Thu, 04 Jul 2024 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077542; x=1720682342; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zg0OPkjqYoVo/z98XnrOu3gmca9ERpMyaK1oUmKADyQ=;
 b=dQcIh2aYxv3Z5pK6vfHwVZWVDl3t9Q9A/x0+jmLeHeBBAL31NcoLevgEeOgUaYhCfv
 2g35rP2ES/qrLUkIMzbjS14jX64L7PqOy6RspGSfyj+3sILf46Palq+nAKgGxyu8l7o/
 Vftm6QNR9vhtQwqbQoq8vSWNQAyYKKal5L7wp0ABcVxIe3B7qe7oqmPPpSsMUS6fLpmX
 Tjyx9kk6BsAsFGcOaZszLW+QREM5cKEMUwECutjhpJOFjh2SNzdazPoQkhLF2hzy4vlV
 L6vP2DCnm2o9tWqIya4q1qJ1x/V5jBXDGoKRXuq7bHeoZmNz0ZyqisXlR/RnqFFt08r3
 6wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077542; x=1720682342;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zg0OPkjqYoVo/z98XnrOu3gmca9ERpMyaK1oUmKADyQ=;
 b=MXMi2iS2dTHl8WNoTF4IxIQg45igeUtdtOLxMaDCswoFjkWwp2I9n36ORGVSY9mNLw
 zcviz3G87JZXx4FxbwQ8x1fM4eLUsSDMikZfGLPxYp43Ik2Uwbp1JaR0ai3K06rRMG7C
 W8dF2XQW1D4HgXh5oP5+FMBeBRPfNuIPxhr0qPTtNAJGWpAOnoVv7ccwkZGoTV+C2Rt+
 eS5N6ysBV/jbgTKUzYD0pSnPHQI5uauNq9LbWxuhjlSw9O8jpr8VYg/DBeyBSVJHAwYb
 l+G+KAGdErpjS+6/8FnGfH6JLHpo53UohLSJfpoCneNnH503kE1M/vuZi0VHQBx+wtSi
 +TjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpLx3Cqkuh8RFbMemO+yrnl9fCcbs5/RDkB1VRCMrJiD4vk/LBZ1cIIgewM6vUPfXLVkeK9QHKL+idmUI3JMLJQN17YUQWccNlEDW9UP9ucu1gPK4UuJ8eDSU=
X-Gm-Message-State: AOJu0YwyTfRu7GdjZkh5mZDvoNo60L38RMfNFIE9B+6KgrzYfLFLBV5P
 FBUxXmJgkAZK0+w9tYf9h7B200vmVg3oDz8joD3IEWoQom76StYb
X-Google-Smtp-Source: AGHT+IFYN6R2UrO1vcm6wh4Uw5Su6Tk1SdiXOnpyA9BbcQQRLP6gLE3AA57jJbGsrBmiVWkUTOMyDQ==
X-Received: by 2002:a17:90a:f18d:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2c99f309b21mr964933a91.7.1720077541917; 
 Thu, 04 Jul 2024 00:19:01 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6c7f76aesm9086956a12.67.2024.07.04.00.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:19:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:18:56 +1000
Message-Id: <D2GKLJBBSWBH.2873DA1I8QJ9Q@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 33/43] target/ppc: Remove single use static inline function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <c30ddd4f433bbe60629d2be66c5214076f677fa9.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <c30ddd4f433bbe60629d2be66c5214076f677fa9.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> The ger_pack_masks() function is only used once and the inverse of
> this operation is already inlined so it can be inlined too in the only
> caller and removed from the header.

Is this needed for later patches? I might prefer to keep it, even
move it into vsx-impl.c.inc and pull its inverse out into its own
function too even.

Thanks,
Nick

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h               | 9 ---------
>  target/ppc/translate/vsx-impl.c.inc | 6 ++++--
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 20fb2ec593..8e5a241f74 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -293,13 +293,4 @@ FIELD(GER_MSK, XMSK, 0, 4)
>  FIELD(GER_MSK, YMSK, 4, 4)
>  FIELD(GER_MSK, PMSK, 8, 8)
> =20
> -static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
> -{
> -    int msk =3D 0;
> -    msk =3D FIELD_DP32(msk, GER_MSK, XMSK, xmsk);
> -    msk =3D FIELD_DP32(msk, GER_MSK, YMSK, ymsk);
> -    msk =3D FIELD_DP32(msk, GER_MSK, PMSK, pmsk);
> -    return msk;
> -}
> -
>  #endif /* PPC_INTERNAL_H */
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/v=
sx-impl.c.inc
> index 0266f09119..62950d348a 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -2819,7 +2819,7 @@ static bool trans_XXSETACCZ(DisasContext *ctx, arg_=
X_a *a)
>  static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
>      void (*helper)(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32))
>  {
> -    uint32_t mask;
> +    uint32_t mask =3D 0;
>      TCGv_ptr xt, xa, xb;
>      REQUIRE_INSNS_FLAGS2(ctx, ISA310);
>      REQUIRE_VSX(ctx);
> @@ -2832,7 +2832,9 @@ static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3=
 *a,
>      xa =3D gen_vsr_ptr(a->xa);
>      xb =3D gen_vsr_ptr(a->xb);
> =20
> -    mask =3D ger_pack_masks(a->pmsk, a->ymsk, a->xmsk);
> +    mask =3D FIELD_DP32(mask, GER_MSK, XMSK, a->xmsk);
> +    mask =3D FIELD_DP32(mask, GER_MSK, YMSK, a->ymsk);
> +    mask =3D FIELD_DP32(mask, GER_MSK, PMSK, a->pmsk);
>      helper(tcg_env, xa, xb, xt, tcg_constant_i32(mask));
>      return true;
>  }


