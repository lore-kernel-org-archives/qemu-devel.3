Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D3C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHBR-0005kV-Qe; Mon, 30 Jun 2025 12:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWHBL-0005j4-Be
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:16:36 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWHBI-0005La-Du
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:16:34 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e5d953c0bso51498107b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751300189; x=1751904989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8BZBxgeIj5Ljo6n9tAnEBpWp9p9IcUSOm3ISMJeS7VM=;
 b=E6JgbnXuvHTsuGUBr6BKqqdcnlK02OntsaqnMpYBm95kQaY51EI1EvffU0EsL9yZ0A
 U63mmNRlMISPoED5vOSQNXw5N9Nw2epjrMj/YTvN3XsN7YqpD3TuGaFKG0gRgrADa4u9
 di/qKkkDZ411ITKGb6MhLou3ZRJo3TqNFk4KfM2RsLA4clfL67qi8IOSOuv135pyE/sN
 oNc1sLW1oqtzGFwoUai7n8s7vTQlFzrQ3W54BL18PSjD0sxnghczvrdTV3FYrFSHId8X
 sywoJURVVcLcSxaYS4rfXwTcJV9EAQXVk2+xrbZ9MME7VvnMYuzSA5hd1U1b/ZExuktA
 W4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751300189; x=1751904989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BZBxgeIj5Ljo6n9tAnEBpWp9p9IcUSOm3ISMJeS7VM=;
 b=jL1lBixoWOdVys6ooOLHerycPDioDGoaPPfJaShGcR4yeemLc+sSMMxwnuWLdd9Nwh
 cW1OBrya9InxWzGOqfmeXvJ55KebK3i27exwbL7K0+oDevOOlgy8nNfOxjbdwsvqtLDA
 a6i3tOzYmZ6GQHalKeVENAcC87v8860NnQdGHjkJHVUnne6DrbtbCfZ/9M3Ezb2+ed+I
 dJeMMubUa2PHX/kZj10HllW7YLdpM3umioXdzyp6FWQCqqHFhJIRP852Xbqjz7cNtTNK
 CP0BfXKjN02wkmiDv+UxO100p587IR3jz4lo3RrTFXyvsKAsIzd3MeSKrWad2tV4DppX
 zlFQ==
X-Gm-Message-State: AOJu0YzxuhILcG6xrmNbybcM2nONIb1I23EQq7rUvqmDMa+kTVvXEZfT
 fVw2AUXU8DI7Hf3RXP3gR398y5qZBAXjC92LLZEAG1zv0BaHHBIDsZAVCY/aD6oymOUFLLw7d3O
 W4xoNheh4BDtQpDowVSPZqDEWqH6Qk1y0QEhDfY6pEg==
X-Gm-Gg: ASbGnculOFoTCFQ40aRz6LfSEOiCF5c5Jz5LU/7gR9OX38sLeB/Tj+qv5bo5IWRgAtt
 HDfmQeZlbm6C0NmYoNhWS0H/MMrvCbg6GwbMhv0TmFGFjFJSw5hW4gcQsWBxZMwkOlSp46P67wE
 wdzCI4hofxosTscVa5e741GBITxLy5bcq47sGYmxlCD/+t
X-Google-Smtp-Source: AGHT+IHvTJtFy/nU7dOCoKHEaC52egzb/2X3lb3j1a5kbQx+70kL7EhZ0Abj6VtKqqtQDr+w9dVqmOi9yfh1n12XHpw=
X-Received: by 2002:a05:690c:6482:b0:70c:a854:8384 with SMTP id
 00721157ae682-71517169329mr221842707b3.11.1751300189521; Mon, 30 Jun 2025
 09:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 17:16:17 +0100
X-Gm-Features: Ac12FXzISi-A2WlMiUBX1pzbJT0z8Snzh3hDylllMcn4Z4ESFev1Cp8oWPlbTf4
Message-ID: <CAFEAcA8_ObePy2_A2st+=R2aKPrc=XeqMv6L+Jg5JxJTsA4qaQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off' ACPI table fixes
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org, 
 mst@redhat.com, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 udo@hypervisor.org, ajones@ventanamicro.com, imammedo@redhat.com, 
 anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sat, 28 Jun 2025 at 20:57, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Since v2:
> - Fixed no_tcg_its inverted logic (rth)
>
> Since v3:
> - Fixed remappings in the IORT table when ITS is no present
> - Rebased on master and resoled conflics, like no more "no_its"
>   flag in VirtMachineClass
> - Dropped patch 1/9 because we actually want the instance flags,
>   not only the class flags, and the instance flags are the ones
>   to be used often when deciding about the presence/absence of a
>   machine feature, instead of the negated class flags ("no_*")
> - Adapted the other patches that depended on 1/9
> - Dropped patch 4/9 in favor of using the instance flag for
>   checking if ITS is on or off
> - Simplified VM options for the new "its=off" test
>
> Since v4:
> - Fixed/restored commit authorship and author tags (philmd)
> - Factored out create_its_idmaps to clarify how ID ranges that
>   go direct to ITS Group node are created (eauger)
> - Addressed all remaining minor review comments (eauger)
>
> Since v5:
> - Use of "directed to" in comments and commit messages (eauger)
> - Renaming of variables num_id_mappings, smmu_idmaps, and its_idmaps
>   to make code clearer (eauger)
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
> v4: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg02583.html
> v5: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg03793.html
>
> Fix ACPI tables for '-M its=off' CLI option and resolve the issue:
>
> https://gitlab.com/qemu-project/qemu/-/issues/2886


Applied to target-arm.next, thanks. (I fixed a few checkpatch
nits about hardcoded tabs and an overlong line.)

-- PMM

