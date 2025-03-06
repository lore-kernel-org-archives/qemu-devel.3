Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53316C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpylz-0000Lp-M5; Wed, 05 Mar 2025 19:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3POfIZwwKCnMeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1tpylw-0000KS-CB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:07:32 -0500
Received: from mail-ot1-x349.google.com ([2607:f8b0:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3POfIZwwKCnMeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com>)
 id 1tpylt-0006zQ-6M
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:07:30 -0500
Received: by mail-ot1-x349.google.com with SMTP id
 46e09a7af769-72a1605ec2fso33450a34.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741219645; x=1741824445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=H/6NaOVcyKytl+LFcDmVZ36hJJIaYUM/Z3RV+7IsZII=;
 b=PUecQS2tTP4ydWC97DObL8d6100h4vFkVsq5VjNofhuTS29yYD+VoAH7l7r7Bab44K
 qLuHy3WxtOtqT6KHnba05uYX498WJCDNHv9u83JYEOJJLsnkioXn3mMQb2tfk98Bgssp
 TMbDPs/8iMWEFDtDZJvqbpO0+wYXjJJ9YuRcGVP8Zq5nTYKWjPsC1t8h45TgVKweXQKO
 rYd1g1sTGkDW8DXCDS5RqGc8Wtydcnt6mwwrZkZ0Ovcia2FKpYgV4+enzBIsgbrfC90z
 eo2IuvLYrtYn79x8QraVybYl92CLuuwqwtplrOhJA0mJCrD1rh8mPwk1IcCs7i/1CakI
 qYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741219645; x=1741824445;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H/6NaOVcyKytl+LFcDmVZ36hJJIaYUM/Z3RV+7IsZII=;
 b=vdTul1WqsqbyV7vMvOqODKLqh4Q4daPUxl2PlLdGmnjwTg3NYcLb0PBbxDKm6teaF6
 7qNf8peZhUa7QNBaiutSfFps7w84CJU98jDUbOKJfHX9tzAp0ETPruU0o6gfZRyhhRAQ
 IqWrj+NwsFTUJWBVY59kk9ImaNuLRSQ3Mx0UEd5AQ+duAcFQy06ryPUgyFfVDnZi4+Ac
 c29D0QMPQfYDjZc3CSaEHpoZQkXnWvXLkhxlqut13/9d3GuKXOJL8BNUrJv+wcVD0pBJ
 0YGC6gN5f1JYkq2meZclLgKL+ZE5527vjIhGh7BNdQ45ZYasxcnAE/dPw0EKMRtLfthU
 GgjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKKZjHlJYx6Ggf3nHxeecgYc+ZujerbXSvevBQFqc/RmoztpjzH0oXCGIIuc0FSFVQ1iC8pnKLc19/@nongnu.org
X-Gm-Message-State: AOJu0YzwDsgMxXW+uMKZo4qEeIvoqwmyo/MpX9iQmLHGSi6SvAjRvosv
 /xxIUWthEBP11bLmUKmx1r7/D7YQi6ybMC9HASN/qpnzLc0pafwUPS+jRtBktvTDVX4QnNZgVLB
 iUnM1WsDb/sXNIQ23tCyxKlJ5Gg==
X-Google-Smtp-Source: AGHT+IGxLqCfcmhRZkwNFzJGx5zPJAEbAfQviB+BSpwaDOS2cXhJ5UdS8qZLVb3pj/md7Gp3RWOY1PIheM6uQoEbQLs=
X-Received: from oabnd22.prod.google.com
 ([2002:a05:6871:4416:b0:2b8:4bc1:4e4b])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2649:b0:727:2a5:b1fa with SMTP id
 46e09a7af769-72a1fc22167mr2434675a34.13.1741219644551; 
 Wed, 05 Mar 2025 16:07:24 -0800 (PST)
Date: Thu,  6 Mar 2025 00:07:13 +0000
In-Reply-To: <20250304064710.2128993-5-jamin_lin@aspeedtech.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306000715.2095554-1-nabihestefan@google.com>
Subject: Re: [v5,4/6] hw/misc/aspeed_scu: Fix the hw-strap1 cannot be set in
 the SOC layer for AST2700
From: Nabih Estefan <nabihestefan@google.com>
To: jamin_lin@aspeedtech.com
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::349;
 envelope-from=3POfIZwwKCnMeRSZYVjkVWReXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--nabihestefan.bounces.google.com;
 helo=mail-ot1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

> There is one hw_strap1 register in the SCU (CPU DIE) and another hw_strap=
1
> register in the SCUIO (IO DIE).
>=20
> In the "ast2700_a0_resets" function, the hardcoded value "0x00000800" is =
set in
> SCU hw-strap1 (CPU DIE), and in "ast2700_a0_resets_io" the hardcoded valu=
e
> "0x00000504" is set in SCUIO hw-strap1 (IO DIE). Both values cannot be se=
t via
> the SOC layer.
>=20
> The value of "s->hw_strap1" is set by the SOC layer via the "hw-strap1" p=
roperty.
> Update the "aspeed_ast2700_scu_reset" function to set the value of "s->hw=
_strap1"
> in both the SCU and SCUIO hw-strap1 registers.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Tested-by: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih

> ---
>  hw/misc/aspeed_scu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 545d004749..0581c744f1 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -910,7 +910,6 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops =
=3D {
>  };
> =20
>  static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] =3D =
{
> -    [AST2700_HW_STRAP1]             =3D 0x00000800,
>      [AST2700_HW_STRAP1_CLR]         =3D 0xFFF0FFF0,
>      [AST2700_HW_STRAP1_LOCK]        =3D 0x00000FFF,
>      [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,
> @@ -940,6 +939,7 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev=
)
> =20
>      memcpy(s->regs, asc->resets, asc->nr_regs * 4);
>      s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;
> +    s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;
>  }
> =20
>  static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
> @@ -1032,7 +1032,6 @@ static const MemoryRegionOps aspeed_ast2700_scuio_o=
ps =3D {
>  };
> =20
>  static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] =
=3D {
> -    [AST2700_HW_STRAP1]                 =3D 0x00000504,
>      [AST2700_HW_STRAP1_CLR]             =3D 0xFFF0FFF0,
>      [AST2700_HW_STRAP1_LOCK]            =3D 0x00000FFF,
>      [AST2700_HW_STRAP1_SEC1]            =3D 0x000000FF,
>

