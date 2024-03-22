Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FDEC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjzV-0001lQ-Rn; Fri, 22 Mar 2024 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjzQ-0001ko-TR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:51:43 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnjzK-0000sP-A1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:51:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bc753f58eso3023868a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711133487; x=1711738287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5DQETAIf3hyQQrRzWpZBKS8ulJFDYqHzLUM8L2zZaM4=;
 b=tiyyLEYq0hP4828aH9ud2qqWJbY873S+SmbmOOqRfBRiwSEJ6OP6i4njIccd4uL8oE
 YJ+FATX/aL/pM/BnvoZLliN+3otQhOqtl5Amq7Fz0i6sxCtj9asxPQuhQPjttOGvYhxo
 vSi45UyKOHZeI50fZzn1SfL7zm1dmG10S7w3X2r/FLAy9bn/j725myiOSj44oX3rgH4m
 2liBIDQlaL3FaHnTIPtj22rnqwarQxyOzRkLbsQxSp+ytWPi2Q8TF6Rf7rD/YsLjwD1C
 rZtsgAKwa7SbFYXEHUVbRKgWDtHAZOjawSkB71+1vEiM2FT/PLzgbsINctuB7AYz5lU5
 TZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711133487; x=1711738287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5DQETAIf3hyQQrRzWpZBKS8ulJFDYqHzLUM8L2zZaM4=;
 b=hmETLSmtDX6juLt7psZCIEkElxyCEVrv2qYKVgfyxB3hU5k+5NydQdgvkwkWEfykEZ
 9W2ZVOY9VtZVDb4iii1UmspR/jkKhlBIpoGgRouOsqiZUqAuN01ZnB1KSYB9dWidVS3K
 LEmuArVIhbOjE5GF9PxWVbvI1LAKkcTSXukv6R05sgTR9foAu6Z0VK0yT3yP4aPb68Pr
 CobRSTLXU8DnHw/DbiPgMILmTzfEBbiScdOs5qeNE/QxWAg8B+VMEWYXdEwBe4ibYy0M
 Jel75uLyP75EKUkvch8bnOOIF92OPsX+0FkwWQ1/td7qlFgnXMtWgpOxEwXW7ZrccKYT
 0S9A==
X-Gm-Message-State: AOJu0YwCx8q2Ufx7n7EsG8ZtAg4Ic5YX5sfS1wmLzJoHgsJwYFvcNAEP
 rlHVh3Ufy7y7H0AOPw9XQc/OY6N1w/H/Wja4qWwWAVW/lYcnp8FGKvTm51tVBO6XpJpra1xZRxv
 ZwU/eyI1wPDo8uri6jHLDgeTDhA0CNcbqxvZvg4W+BAKg9BWV
X-Google-Smtp-Source: AGHT+IFkxQ90jNSiJMYY4rJjV7L3Y2i6tYpH0PiELHir2YBHOCWJAY7Pcx44udQ337m8SAYJdOJwRJUzc7g7CGmGPq8=
X-Received: by 2002:a50:bae2:0:b0:568:9fc9:ec72 with SMTP id
 x89-20020a50bae2000000b005689fc9ec72mr266167ede.35.1711133486977; Fri, 22 Mar
 2024 11:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
In-Reply-To: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 18:51:15 +0000
Message-ID: <CAFEAcA8sQnBzFq3b_WscYY1o+J2CutFrEcTGHXvbi8YVn6vorg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM Sbsa-ref: Enable CPU cluster topology
To: Xiong Yining <xiongyining1480@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, rad@semihalf.com, 
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, 
 chenbaozi@phytium.com.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 12 Mar 2024 at 08:32, Xiong Yining
<xiongyining1480@phytium.com.cn> wrote:
>
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And this
> topology can be passed to the firmware through DT cpu-map.
>
> Changes in v2:
> - put this code before sbsa_fdt_add_gic_node().
>
> xiongyining1480 (2):
>   hw/arm/sbsa-ref:Enable CPU cluster on ARM sbsa machine
>   hw/arm/sbsa-ref: Add cpu-map to device tree

Thanks for these patches. I think we should squash the two
patches together into one, because the first patch is only
a single line, and also because we shouldn't say that the
machine supports cluster topology until it actually does
by putting the information into the device tree.

There's no rush, because we're  now in softfreeze for 9.0, so these
will have to wait until 9.0 is released (in about a month's time).

I'm also a bit confused by the Reviewed-by: tag from Marcin on patch 2,
because I can't see that in my mail archives of the discussion on version
1 of this patchset, only a Tested-by. Marcin, are you OK with these patches?

Also, is this change to the DTB something that would require an
increase in the sbsa-ref platform version number, or not?
Should we adjust the documentation in docs/system/arm/sbsa.rst to
mention that the DTB might have cluster topology information?

thanks
-- PMM

