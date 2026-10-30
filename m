Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=azP+YBoU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnpG-0005UP-V9; Fri, 30 Oct 2026 10:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMnp1-0005QW-9O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:43:12 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMnoz-0005EZ-L1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:43:11 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0cf2c0785so7032507b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371388; cv=none;
 d=google.com; s=arc-20260327;
 b=lIBZdblfh2WZsQQvKjIUkq/32HaTo1G//EDRbC2Zy5BJ2IwVR8G9kUggzWe/7dOhPl
 rjNnL7ku839oO9fb75p0OBScnZp1LJuahfLncWUh1iRNkdGm2cYyCIs3xtKiwEKOGk0O
 okUsC1GKyfo45yB8h+SBdCzIfNOX2WqiMpuCa126w3NjY1vnYzPhIXXuTgkvvUDBeE74
 38P4ZpWcZURyi7Zz/bJ22vnEvEFXYUiGUIz2Sgfuj+wQ/CRYq6e4cZNBIdZ35r3PKzRr
 gz3ZnLi48ys1C3tIzR8m3Gn858zLs4S+4qeF9W250I5rrZhXExPDNLIONTZ75UzPbdxM
 /bFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5XBfL3zIAxBj5/WTLW4TZNvwKss131iP7qDtg9gvbVY=;
 fh=ZvG4EwRqc2Y9GTJr/RIcaO01P8vFyoXk2OimuR6TuT8=;
 b=Iawz33l8SGOcWQCPxfGJGN5I/IoX4gsNYjK0HxB9n/fzGv/MMoQz1JThpmWU4YYD95
 /QPxCWuaBPfbXcwIP/JsGQD2kWw5Geb6iREGMQtJpXUpo3KHlWvSmVB8u5oGTIw2yPMG
 Kejse+PgRLB6al1QAQdvBIAj7OUQMDmA7TLSOixDkzsDdTBunTErmQsw5LME8PL91fxL
 mZ6qQZmAMk7JfiXiFGwyn7Oi6BIEJ+veNxv+XzpFWQcvCCUOCgT2XOjtXTuFHZ3XQlUc
 ieI+L+8F0JPTuc60qeWWIK2Zfw9OmWOe0wGxeBh3nm7frKdF3+7XVuRbSHxNf1xoDEkS
 ru5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793371388; x=1793976188; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5XBfL3zIAxBj5/WTLW4TZNvwKss131iP7qDtg9gvbVY=;
 b=azP+YBoU8IgQhvQbFB7uHHEVJyI4DwuE8Qnw8WcDAydI/kCSznZDf5NJHlKssUi8vC
 ecRhunPD0Or8UMfjo+Ud46BAS1M4F7ydMBGj2gPR1a1DiBJIU2oGHd9F57KZxcgdQK4g
 XTN893gueQ/qIGOf3Q7eajrSFBDsvPvgm1HTztQYNJCNg9uUmPF0hzsVsDiWpwX6Sqev
 w/ugWDGB7ZPUy5lYIaBSemLovQ2ndhq4yDYEVmCbW1rVxzyzzwdNcUrd6IWtqDB9Qzxs
 pyOV53yqTP8K8nIWLavS7/oe4XpEZ7tbciz0PRxnBdyDxOoo6ymd4tbl8OESviYjSaJ4
 LCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371388; x=1793976188;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5XBfL3zIAxBj5/WTLW4TZNvwKss131iP7qDtg9gvbVY=;
 b=zCDL1pkGNnVelutaLxk6/1AHSGTOKYKo9mZWSEi69MLGN3E3RoZi4p3s0TqSNPR/Ie
 7Y1Vi2VjE0UMpLzG53jspcZDWV5j54rSU4PgWDJD2BgsJ+3IveZ3aIZo0VZYxLsriPBT
 ZLdVcy3DTNQYdiFmK/vaZ9agTkgTmZilUUeBH/+gufYwJhZWs7MGuQdXnxzFdhnpaNtM
 9rW3/6HJQax0FalbCG49M44lNbCaIVqVMRSkJcfyTe/fV88Ja8VnwtNxHtIxRgc/zhm3
 MwQOlnPPpJBlcj+o+UF5w/+/N1jkcnMs0aORb2xRQ4OxpEyvKs8S+EXoP1cjR/NFQ3TJ
 cp4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFRGRw/yeImYOO85nCUmxn0Ky22jLt3ASzxXJZmaJdEc6ImyaUy8xLEoeLVekQu8fdTt6YNkjXuHCy@nongnu.org
X-Gm-Message-State: AFq9FYJ3tuwxFhckY6f3QfnA670Yw5pAznXv9wDuWxnWhRjdshyvsM1g
 K9fO/lVPdUuCt1BJZ8Aie9Cwgne/+maeXVMZF0Dw8EHhvkZC8c9UHBVigCwQGVC4dd9yI/Syf30
 SsIK4TyFDakMaqE9R0Yzxnt4KZ9T+GEr99JXE51PhKD6/jqubNOc0EQ4=
X-Gm-Gg: AYBFou37nhovt8CVpr14eL4Y9ase9LY/SKGoV6ZnoOauNYq13h7c7P8AfO66bbZOHxH
 uU636XfLiwmRzaAGT7d6lTCxK+/DbPHiNzWZrDCaEmI1B+zdGdaxUpxKV3wtoL95b2LCgaeVF2s
 YbjsHwXFfESDfbJMYRFY/bgHR2SFRZ0PA5Yne7OyAEoxIUyhTDrSlNExfKAYaGoLl/tfGZtBqd3
 vu8mofwvRH4d2+Ou0mwD6xZLUTj+k/oY76PX4DVPGu/bDs7QGP8/RwtQ6XehwVvSC8NXNzXERrc
 EAOgn9EC3BaXgE+mWvxLy/Xsu3gZnZrCOt3Mk7ncnUixm+h8UfXGFmDbB4NiDN7Z4IfDbkuw6V2
 wMdfhJQu5JsSviClcg7WRehslB5maipMaSP9Q5lu2FZR/Ind8XaG/c+ty7cp6JlcctaQNbH7lG1
 DcAO4PjUpOfjkGDjoViGpw
X-Received: by 2002:a05:690c:fce:b0:8b1:738a:b44c with SMTP id
 00721157ae682-8b2b66c780bmr12910777b3.23.1793371388004; Fri, 30 Oct 2026
 07:43:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030143435.57230-1-sebott@redhat.com>
 <20261030143435.57230-2-sebott@redhat.com>
In-Reply-To: <20261030143435.57230-2-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 14:42:56 +0000
X-Gm-Features: AclHuK_r0kqVhi8LlvQGUgGswBkO8dvXYU42AIZd8VarOJKUgeHlI3R_01kyzkM
Message-ID: <CAFEAcA_At+wWDPw7jqCqaB-DD1j706Bm2ekPs_p64w+prSzL2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm/cpu64: fix typos in
 kvm_arm_set_cpreg_mig_tolerances()
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 30 Oct 2026 at 14:34, Sebastian Ott <sebott@redhat.com> wrote:
>
> Fix a couple of typos and a #xa0 space.
>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/cpu64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

