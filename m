Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AF1C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFlp-00082l-4n; Thu, 04 Jul 2024 02:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFlm-0007u5-Gy; Thu, 04 Jul 2024 02:16:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPFlk-0007Fx-CO; Thu, 04 Jul 2024 02:16:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70af8062039so231088b3a.0; 
 Wed, 03 Jul 2024 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720073795; x=1720678595; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5s/YY0s/zesZmp43F17gNEXR9cqhX60E93MCVah17M=;
 b=m9sxCUAwd9Sj1uo69pGMgNGvoKa1oVBCShO3WAsUDnjmofM5NG40S0MnkkJRYofhqF
 x9oOqZYcEEUJh6n0pQ8nPxqAUs4yfe/4Zx3D+erZOeqSpfM7GdM1vcifVK86RHCZhZpK
 dhObzAJUAwac0iUsZq57jc0+TZ2MFtN8+b+vvQKVW/7paP4hQjReOySKMxISd1zOQGD4
 YH97YD5ChOvH91CZMS5wW3fghkmcIu837LVXk5VWhaENVsXC9jn2EpzvE4i1OTGVazEn
 2oX4bzLA2RSmYP2CjCm8kI9C2Go73YJ0TXGiviVKNo8LcKtkB6ZwmVJ7mTUOAyfL0kCU
 Y6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720073795; x=1720678595;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n5s/YY0s/zesZmp43F17gNEXR9cqhX60E93MCVah17M=;
 b=q40gQLUs+dqRDUHF7uBWotF012dyW/FsouPuFG2E1h0jpQtJvF2cQubv911QqPVnMi
 zAqW/4nY+G3Gme+WeiLU9x2oVxMueFq7FiBsQqhQu8Qc65z95qt/94f7LAgCHDb9SVXV
 Yt1loYijtbVhJiB76bi+1DBRLMD26tB8sDVULNWCwBjXa8pO1as2GqC8TW5OHuRSw7ZQ
 rqYxKF4ZDxhxwPDNCoPJ4hr4VHMmLFS8YvAuz99H9dGIA8CBBOSUw5CfGGIayGPcrbes
 ND/f9fgahjiYnLSkiz5RhAyAezE+dPHIOSLC8IfqwvjTOVI7ebdDtPyCWdzVYTRAh2NI
 k7Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv91lAeDlhY8mFtWnIVnV7v1q/hDogablSBeqWhX8LBqGvZmChF4tq6iNVXwU3qVLQGaLiVYc0Hz+ELxbjmpEFOvST/fWWsNsACED7bc0nMBYf6UqmupGk0co=
X-Gm-Message-State: AOJu0YwB8djUcnvAi/NSLj0efSYBmrktziA6F2OOHWH9ULH9A/9PtSKt
 exSB99ktiGLmmgzZsrJUmmfnNBvpb5z0hfN6eovXEy9WdKtM6Y8p
X-Google-Smtp-Source: AGHT+IHNU5lJPEIjycxV68/Pk8V0S8lNk2yV5lIvTrGapu+ZTkYjji8o7B9YNfSUiWi44WJTdyUHTw==
X-Received: by 2002:a05:6a21:32a6:b0:1be:e1da:2f5 with SMTP id
 adf61e73a8af0-1c0cc74cf36mr682760637.27.1720073794486; 
 Wed, 03 Jul 2024 23:16:34 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a9cb670sm619358a91.37.2024.07.03.23.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 23:16:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 16:16:29 +1000
Message-Id: <D2GJ9Q7MLYTG.120ZEYV5R8WR7@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 15/43] target/ppc/mmu_common.c: Simplify a switch statement
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <7328ddc0644c3eb1023b90d2c654cac62888bde6.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <7328ddc0644c3eb1023b90d2c654cac62888bde6.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> In mmu6xx_get_physical_address() the switch handles all cases so the
> default is never reached and can be dropped. Also group together cases
> which just return -4.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 0152e8d875..b2993e8563 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -375,15 +375,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *=
env, mmu_ctx_t *ctx,
>      case ACCESS_INT:
>          /* Integer load/store : only access allowed */
>          break;
> -    case ACCESS_CODE:
> -        /* No code fetch is allowed in direct-store areas */
> -        return -4;
> -    case ACCESS_FLOAT:
> -        /* Floating point load/store */
> -        return -4;
> -    case ACCESS_RES:
> -        /* lwarx, ldarx or srwcx. */
> -        return -4;
>      case ACCESS_CACHE:
>          /*
>           * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
> @@ -393,12 +384,10 @@ static int mmu6xx_get_physical_address(CPUPPCState =
*env, mmu_ctx_t *ctx,
>           */
>          ctx->raddr =3D eaddr;
>          return 0;
> -    case ACCESS_EXT:
> -        /* eciwx or ecowx */
> -        return -4;
> -    default:
> -        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need a=
ddress"
> -                                   " translation\n");
> +    case ACCESS_CODE: /* No code fetch is allowed in direct-store areas =
*/
> +    case ACCESS_FLOAT: /* Floating point load/store */
> +    case ACCESS_RES: /* lwarx, ldarx or srwcx. */
> +    case ACCESS_EXT: /* eciwx or ecowx */
>          return -4;
>      }
>      if ((access_type =3D=3D MMU_DATA_STORE || ctx->key !=3D 1) &&


