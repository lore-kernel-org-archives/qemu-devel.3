Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC0C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvWn-0004gJ-Cq; Fri, 01 Aug 2025 15:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtuB-0004FA-Io
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:56 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtuA-0007v5-21
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:55 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7183d264e55so26413557b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070652; x=1754675452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bE0Ql8YI2czpSFEHIjZ2pObm6nZaZPt9sRy1tkyh/1Q=;
 b=RtXuCeUdwuxpuMOJQVKRViGI1BdXLyrGVcjpehEBu9rXIPME6C0LHxPi0z0Ntear8N
 yrrmQY4nxO9943nQINPVm75PGCcPaGsCskC19nJ7dRZ5gD+dEu8+yNZwsvQg1SwH0LaP
 8OljNbJ1d9WsYh3QrR+JeJgOS412hLZxtEFP6LJhU69dFc0jABpcBKravCdblZiWmmgk
 QjSvitSPFSdEnYEUHL2WoDpL8HutjZQPDTWKFFcTT23cVNVal01BsdGGHOqICRovc0US
 AUp3/obumAnnP2dkaz0ieeAAmy0+V5fMd8kLqaDD8KgeZRK/DeZN71bswL1R1rvziZIU
 UgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070652; x=1754675452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bE0Ql8YI2czpSFEHIjZ2pObm6nZaZPt9sRy1tkyh/1Q=;
 b=eyliKWYVa8gyYmG1DgDa1+6D4nCv//e+/Fil0wBDYkSDGdXmxq1IMficDMXOnUoqj9
 V7IwnTHI5aJp3oq92bNsIJG4sZeJBSVA9VvzWiMCCABapxah1ET5JmlQyJYlXf24qP+N
 cpRVwAlIdpON50KXDid8oDSGymEDbKY+y9AZY+WEFY0PCIoqB5xfMvPx2GbSZsEnPLyo
 WJPH2H1OYkxIFlf29Cd5BEr5FSa8hu86h6R8l323ZwtLPQDQRkJI2s641wMq5YZbzPSQ
 mcwhDyoKfV4mFEBp+svflCqfUxy+izm4iexM6lHQA3Wu8QVCBReGEpJobHoluv49ikAW
 irVw==
X-Gm-Message-State: AOJu0YyeCVLQRhsX4zfjkKu5hGG1Opvx36Ee6QrRK9uKqw9AWpgwdStm
 /RvbX5chtgBgX6LKxu00jTaKXDV+Hf2vNH4xNVnd39RyKKxLdUjUUeLuGu25k7Oc0UBu5MFwsmb
 vn5xdShL2/8Cv8ZGj3aUNVf8B6sJYqMX9LJsZxlKdpuvhDjgd4BQr
X-Gm-Gg: ASbGncsol9NkpmC2nKNLuzWzMcootCQhpgiLaS3jmb0J+kR+vg8b4cqXcU/d5qvv8em
 n4S0EICYGug+0Dz8sCeTesFzhKDYGxBDVgpW5GBiou7b5Kw2XxG32lsb8Z1RQPK5k8LTSekg9P7
 NGDgMvNazYXZb758IBn1b4yC8/Ba1CgYhIKVUdL9UBu3YCrchZCQEfa32MfjjJkMiZOBp7T4/Xj
 lDjMhCV
X-Google-Smtp-Source: AGHT+IFXfoFAijhYHV8FlDDnjKB28hm62aXngHlclWthwBIZ4H0NKkOCeazbYJO578vN+gaM7kznWXxQGD9t8TE2Yq0=
X-Received: by 2002:a0d:d087:0:b0:71a:44c6:ef57 with SMTP id
 00721157ae682-71b7eda06famr6522967b3.17.1754070651912; Fri, 01 Aug 2025
 10:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-55-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:50:40 +0100
X-Gm-Features: Ac12FXwbrXj3JB-2cT-wSf6ZXTe_eF9jbTP15wP9QvK34GVowxhp5t6V6TjJU0c
Message-ID: <CAFEAcA9MB8Sj2R9dmv_z1g3qtg=ZE2Jd6MWjhUjx=ZpRhH-E2g@mail.gmail.com>
Subject: Re: [PATCH 54/89] linux-user: Unify the include of
 target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 30 Jul 2025 at 01:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that all target_coredump.c.inc files have been created,
> USE_ELF_CORE_DUMP signals that it is available.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

