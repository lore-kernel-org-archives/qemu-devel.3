Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98590C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJ4h-0007nw-9B; Thu, 04 Jul 2024 05:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ4e-0007nN-Qe
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:48:20 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ4P-000345-K6
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:48:20 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cdf2c7454so811711e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720086483; x=1720691283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eTGtAckJ4OPcEYf3bG6lbqS6cGVXgdLQAk3WTr1SGgw=;
 b=NdSZetiD63igXmtSEIVC6JJc/cAWwLKpU7TsS9NWF7yZvxV3W6KJ72kLeyY1gi3tmT
 GW02Ntx2B5HTbMG7M2rg9qjAV7egfAAF7f2VkrqQVNNzaBIjtlfLGCbuCoI5TPIeIr6J
 tk0Do3vOWvQf66hSpzkKWbsM3d6CW5d1n2dyVdu5EEObUW38RQEDP8w8y4bLoK3z1gSF
 dmYXKGtWeSl6z64XFrHuDUiug3rUNDJKpEMpqIJ5GTPh9DrEb9x27CAjeLOHyGTeOAe4
 T1KCiYKwRgVH8XiDaEq3nR+KEGTrOIjuhmoGAO06kUgl26U5pHBDdKWowM2FNf5W+ZOg
 O8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720086483; x=1720691283;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTGtAckJ4OPcEYf3bG6lbqS6cGVXgdLQAk3WTr1SGgw=;
 b=BqigDbmm2duAgMTUNvzmYrCT4YL5lc0Ow7NsVUoPVPKRNkkBEsIX4OXdhV2VTj89ZL
 cgr3bMViGHqtCkdmSKML36V/HMYQfjWnyYmDta09Zb49eK5a4BFK0yIRwU8g+HZFz1hM
 gllOs5dLxHLz1RXGWDvw2VF9jKGRAkbVtZjM3Xt6BUvhuwqwW1ozg3GFpR+rCsKhd+HO
 KiTz7isKEtBwqNQtDMCs1QkFf8DBCuOGExcV5pX8MYVordYL5TOAKT1qKkBRNM2jAbRk
 ouRL3z1ZwgS9eKV7ouMYFLFKjb0lvYOwdbfZ3jEAkQTreicNkc5he1e+aipByuRqa5Bd
 zBuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUarj3uui0/1Vwp58okUTtQYZAmFSr3G9CcyPqn3euUridJA2ceDscqTlMs/Txb6a0uzPO33iyY+0B3PUKPUVWafgbxHRk=
X-Gm-Message-State: AOJu0YzH2LBn08FPDB6mVK0x//DLfQlWIAcRX/7ubHCfIi2PWjqrRcHx
 DepWbMqvkF9A7VeqO8uFD6cs3vAm6RQAFONIZ5X9Er43Kju8b2OdNql+eSvEaxQ=
X-Google-Smtp-Source: AGHT+IHHrsxmnvpZAyGJcca6l/ncdPkOXI0cqmZbtEj4hJx2fPkPjCChla7/npTlrlvo8UknmC/x7w==
X-Received: by 2002:a19:6a0d:0:b0:52c:905b:ea5f with SMTP id
 2adb3069b0e04-52ea06c7fc2mr869461e87.63.1720086483236; 
 Thu, 04 Jul 2024 02:48:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77af9f46c0sm70223766b.181.2024.07.04.02.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:48:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14A7B5F839;
 Thu,  4 Jul 2024 10:48:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Laurent Vivier <laurent@vivier.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] accel/kvm/kvm-all: Fix superfluous trailing semicolon
In-Reply-To: <20240704084759.1824420-2-zhao1.liu@intel.com> (Zhao Liu's
 message of "Thu, 4 Jul 2024 16:47:56 +0800")
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-2-zhao1.liu@intel.com>
Date: Thu, 04 Jul 2024 10:48:02 +0100
Message-ID: <87cyntpjxp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  accel/kvm/kvm-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 2b4ab896794b..64bf47a03300 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3878,7 +3878,7 @@ static StatsList *add_kvmstat_entry(struct kvm_stat=
s_desc *pdesc,
>      /* Alloc and populate data list */
>      stats =3D g_new0(Stats, 1);
>      stats->name =3D g_strdup(pdesc->name);
> -    stats->value =3D g_new0(StatsValue, 1);;
> +    stats->value =3D g_new0(StatsValue, 1);
>=20=20
>      if ((pdesc->flags & KVM_STATS_UNIT_MASK) =3D=3D KVM_STATS_UNIT_BOOLE=
AN) {
>          stats->value->u.boolean =3D *stats_data;

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

