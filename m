Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D537606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rQP7Bsmu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCf6-0008HK-OR; Tue, 20 Oct 2026 12:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCf5-0008H5-8z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:26:03 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCf3-0004D6-MP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:26:03 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ac4806e210so23541947b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513560; cv=none;
 d=google.com; s=arc-20260327;
 b=qNNrR52boABMJ0tGo5AZeLsKQ2wmg4cBSBzX2D8ygP+E5SY0wA+2MYW2yIBbqmAAV/
 DVvxLDUqzF3w/qYaAkjSbxo6Hl1dTDDUlqSFiccVWJkPE6N/cAIf9Yr1UClqH/RaV11h
 f7SBWKVzGPbvt75JxEmyeYKOPra7wLA2dJn9LvA61ktc74/+MHb2YLXoEXnEgbp4mKZV
 ZP7tuveNidJdxCemTPTMpKcnKb3L+F/F9ygEn649lKNetRej4u2kzNun5QobjGhEam9q
 HLfrhMjhVXgMwwIDkUW91VoReYB30FYctQyebs5yNkjNNJ7tvupcvUD4K1h029PvLNRp
 2opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0H70iKzAA969SR73zPnNY9mwxeFlOcwPhNOOkWbaM+Q=;
 fh=U8w7Jio6JIQ1yc2Nqp/xHJj7DSjIZ4wERaoswJt3BfE=;
 b=ZXdVNnLByZJtdRR2SijDhNCuIYxCvENWyO3N9EsNGJ7rtFCoOqe66g/5WqRxDhsQ+r
 +rjEBe0TeM77y5KM5+V9xN7jPa1l3l0sOu/Grvr2vue5REGtfzK4GgJVnWW5/9oSJ025
 YI67bSdHSgGysww8YKTDKRaUWYoBJyKafpiUF/FLhnWx+Pix03Y7/INIDFTtQjbAjhL/
 RqHFS4C/WH8AyNWTfl8o1t41Q4qsCneJZkDxt7k9GGV+/5UgPbol7CEP5IuLzY1citJe
 LoLkAVAtZcdFlicHQXw4wBg795DqUKqufoSeGRY9CF3SnFXcTKyX/xkiptruIJk9E+tF
 MzSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792513560; x=1793118360; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0H70iKzAA969SR73zPnNY9mwxeFlOcwPhNOOkWbaM+Q=;
 b=rQP7Bsmuw4XZnLbPqViKfMk8MxW4HLPI2cxNIj6lpbZey0hiijCzNu+0ErhwO1dT20
 mHb3a1e4dquNWH60BlIE6Oy3OxbLa+BT8rLY3keTg47KliP2DtHM7g2dkaGpgHFasMY2
 MjhPLPw1T0gO5vk6aGTUfqvtND2zI2f6fzpiUklZ+BnAn0GolOYvooAx60owVe0J3r4J
 ecRZHUOq9yzQx4f8JGVSpteVQy8A2ln4ChH/o6aoe9EiTjMGoouvIyx/lGCfBu2i+Imr
 A8xMaKVuKQ7aWxyo/+HGvXI26e1oywO0n3KfPsyl5W70Hn0NZpl6cyJTjT2AFofk9jOb
 Ajaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513560; x=1793118360;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0H70iKzAA969SR73zPnNY9mwxeFlOcwPhNOOkWbaM+Q=;
 b=csWzIe7SvmMuP9ln70Nhlh4J6gemPUwaIMY7WllGhl6iBGDQ4b/3Uh72EW3zHXgRRf
 SaNSQdYzNnH2zluVm9EbFxEmUaT1tRrNygp29Iv3kDvmQOCEoSPctSGmCG1K6ClL9WwX
 QJT0cbdmA8bnlUqNVZtjk5z7NvcVIsL1zeZvLcmhxD2mSFhoDgcdEvMJGUt3MiQ/v3C9
 MC3N3+y6bkfr2nMUfoBTVMMe8gh44c5Y73sJ1wlXoRlt0B6qikm8JopgwdvyfyjszYQa
 UUe8YSOvZjjt5R/UzC6C7R8PHd4vIK0JXYCiNio3dl3BB5hfbO+vzopJL+2fh99jGkLT
 P4oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ4i7U6gaCSZ+kmBNj01lFLNJ5vd8LUx8HO+ESrN4+NWIPAoYQs7j0dO0dKMvm6FD5ZssIQDAnWMhU@nongnu.org
X-Gm-Message-State: AFq9FYIMIvXQnFFdHSKxegMYt6q54N1F9XQtExpdMa2uSV0YRrMBhToE
 wsQClsfcnUuEnX4pcVVSHVA0TQXuYYFcGgX6vUVNupxfg/YZ62AUyiYNdqLnYFwoUq/UODc/88/
 SXuekZog0Vx5zB4WlQMc8IhIDT5ABPetu3qzOrq10NNUjeBTEU7oguDI=
X-Gm-Gg: AYBFou1BdfQG6I80fjnWj/1Dls3FchybTtrT14KnuFlFp06QXlVItLav+OZhYYzCQEe
 egdvgwJYacYfb85omtHvpotTlsOxufUhdfcaXwEfMKD4t9rJ5hK6mWToUCu35qpDsq2iu/nCg4r
 9NE43A8QU3KWk1YmObbn9cjrWDP9C+3zVpZROFnjlhoo+q6gG7nuXoSeazO0+E1f47ZdfIiU+p9
 vDV3/2Lu3MjCG9dVoFu5UykfqSXXZO2O4Lw984UBwNBc0dQ0U624z9+aykNrT2PCZ43NzrzQEvl
 9Ga5FxDWpCCqaBiAAvUosC6dH1jEo7EZ6MiBi115VOkGJacGTr6J3h47yK16VlCF3yE0KTcNWna
 jBF2XTfi6GidBcTXm8zx3X5g+C5QuaCsOH8pqM5A=
X-Received: by 2002:a05:690c:c4e9:b0:8a8:6a39:37e0 with SMTP id
 00721157ae682-8b0f21973f2mr38103367b3.42.1792513560025; Tue, 20 Oct 2026
 09:26:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-21-mark.caveayland@nutanix.com>
In-Reply-To: <20261019120517.1448687-21-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 17:25:47 +0100
X-Gm-Features: AclHuK_WLO7-DtB7Su2eRjiC_GGoRME7VJlerd_B7UXaWvtf_V6xRSQGWvB8Jog
Message-ID: <CAFEAcA_2rmfbbgSu8VLxybD_y+u6Rmup3mCt_vnOWu4FRDLMEg@mail.gmail.com>
Subject: Re: [PATCH v3 20/28] i8259.c: properly cascade secondary i8259 from
 primary i8259
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 13:07, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Currently the cascaded output from the secondary i8259 is returned directly in
> the pass_irqs[] array, instead of being connected to the relevant input of the
> primary i8259.
>
> This is a bug fix since in a cascaded configuration on real hardware it is
> possible (although unlikely) that the cascaded input from the secondary i8259
> can be masked on the primary i8259.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

