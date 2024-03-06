Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499F1C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmgq-0001Ul-RS; Wed, 06 Mar 2024 03:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhmgn-0001UL-Sg
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhmgm-0006ds-I8
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709713907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8Q8szHIH1Jm+/Qv/JLBLHMcFrjMbttCLOAe1ZNJ3n0=;
 b=OixBngXnWFjGVGeYex6jT1YfW6QLit8qBCgk3SO6FTTFfSZ4YdgZbfrey6oWU/kfSmGJ7c
 DonloHVkXIll1Oq51KwsCx/i4DnbpYMes+EpRsBsTKOwd1jOTbSld9sLJbu6/3Hd0MprSP
 f4xZh00AGM7Ro9O6G1TO6A74QEjLNls=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-_xM9rrPrMpKyXgjHu_lr6A-1; Wed, 06 Mar 2024 03:31:46 -0500
X-MC-Unique: _xM9rrPrMpKyXgjHu_lr6A-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e558ec1a52so4553474b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 00:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709713904; x=1710318704;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8Q8szHIH1Jm+/Qv/JLBLHMcFrjMbttCLOAe1ZNJ3n0=;
 b=SLSW8yb87zDhkZTw/Jvz+LEyhpAwFOGP1IYSfWFi+PlTLmdwY1imYBGMRGuYX0QuTk
 pD708n4yaaLy+lxuIsozMr6ZHkIlfcd/9eBNVWSWdNJcsm44G+Cetpt4LS7atxnnP/v5
 ijYA+ocwgcWdIP9LRxeTrFk6kdY59EYKYMfmkJ6pgBA9zYmso7RVH/hg0fLfcv9j+INv
 JASyoeyWXOCCGBsFpGU8OpoNGeVWXmRc81fhI7qBfPgc9Ro/joK43HNqTnPGWB/KjRh5
 nChvJ7TUFzZw/J+WcFxDPvCk6aDwRbbq/zdS9RnaFs67R3KWM1dscWQumaVNBL82BFpq
 3S/Q==
X-Gm-Message-State: AOJu0YzfGYSToDVrBESpONlhaBSYClFnK9YptGP8CgiXKvG8WRnvYpgq
 URWjoysve+X5WxgujTTCd9zGWmhbQxOmmf7Q2Xz78LdowEjdmp1Emqwod489buoMDhV4CYd9Put
 tEZUPtqWW6YyrKyJyixirHJnTjiNDCSZ99EULGAiHWvzH1yvHeXdo
X-Received: by 2002:a05:6a00:2315:b0:6e5:61d5:d49f with SMTP id
 h21-20020a056a00231500b006e561d5d49fmr14301067pfh.26.1709713904201; 
 Wed, 06 Mar 2024 00:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVZNxm3UoIFDrBa2kq4BPBJWnXwWW5XUwziF3P2uf91QwPbD4OUSd2o1aDpxrfHETdEsw8gQ==
X-Received: by 2002:a05:6a00:2315:b0:6e5:61d5:d49f with SMTP id
 h21-20020a056a00231500b006e561d5d49fmr14301047pfh.26.1709713903791; 
 Wed, 06 Mar 2024 00:31:43 -0800 (PST)
Received: from smtpclient.apple ([115.96.30.47])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa7845b000000b006e04d2be954sm10234846pfn.187.2024.03.06.00.31.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:31:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 18/20] tests: acpi/smbios: whitelist expected blobs
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240305155724.2047069-19-imammedo@redhat.com>
Date: Wed, 6 Mar 2024 14:01:26 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF322AD5-D867-443A-842E-6D5DC7AB1738@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-19-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 05-Mar-2024, at 21:27, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
> tests/qtest/bios-tables-test-allowed-diff.h | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h =
b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..81148a604f 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
> /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/SSDT.dimmpxm",
> --=20
> 2.39.3
>=20


