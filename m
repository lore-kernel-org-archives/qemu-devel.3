Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2820BC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeEg-0002wo-PW; Mon, 23 Jun 2025 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeEe-0002un-9p
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:17:08 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeEc-0007gu-EP
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:17:07 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-710e344bbf9so37868117b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750673823; x=1751278623; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=03OORNCFKUysElZyA7+gA+xQAXRYvv0OoL/R1xd/6+o=;
 b=SFQJTv8uYpvkcRgbhNZfnZMNbWXCXEoRxkhaV29dCMNcLYTZ38tzdfZcbK2gKIaVcp
 9FBMi4uYaW0ht5h96F88UBMXFaOwLhEiOvFdFceUOqNUzvSoIwAjc1kG4ITavXunkf69
 0X49uyP5iGzD3FWM27r4onkMxEqowlyXRpn7hh2oii3ZnKqBTyt4k4eQgY+PI+GhImQ6
 L6wCW/RxTt8zh9bsX+rcbkT9dMnZHQHkIIJfe3q5++A8IIr9GvC8+y2qe1VFde+hGg+F
 CQhM0hRmbo3/Kh+99uA7JIlE2IRvKoQxqNVDwkNUAe4Gfy7i0ViL2EKxQio7peC5+t8c
 Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750673823; x=1751278623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03OORNCFKUysElZyA7+gA+xQAXRYvv0OoL/R1xd/6+o=;
 b=cJWgCmT66VRK4G0BOY9KXJE5iaMhdjkuGcEvVoWJ8Lr74Ku+31sHaNJPZ6oFUZFQKg
 5A000UP6JeF+HXJvWCvpctqL0zqiudkKvtpJ9e94gYO9hA6V+A77jv9sI1WT1WptZ4KI
 qlc9VzaJwsWUyr09bzw/vFbmc1fiAGbIEhBesw+ddvEN85rqhhN0bF71gJ8uzYLB91WD
 TwFJp8oADgSOt6EBhWhP7UXIQoAJ6vZCg4tde1VLvfcrZLXtVlrLUy5h3AwrrdVIVjrD
 6mUsDIjCPlPQuLcFEDiSBM58CPHLt64hjVI18bWMidZ72lt8TqjbSqGa/nAnmkt6y82V
 WuJA==
X-Gm-Message-State: AOJu0Yx6bTg7fjLgdcq67jW5G4BF7jzl1p2ChPFEXZjXxHAXNt6vzZqR
 4iYnfe9nfkKvoi3yQsdgBbgXhbbulZq5NYgrFa/IpAsG+oJQk7trpZZjJZqX6RKgONpG4IlzMGf
 SNt0vn9ldqbPPiJRu6YCMODflT7V2luv2t9xSi6v0RHndCCLaT++j
X-Gm-Gg: ASbGncu0zjhGtbSHjlRqm/5RLT15vYS/J7h1G4NWS0FF5SP+Y6sJreXkLER7UP1qwWr
 36cuoAHtuk+z/6y6NevpIBcNGPKrSJz19UZg9GoLd5MrcHOwd+egI4F1PR69uyRUUQghIwL6Rbk
 6iveHGuqVV/bD7G4x6uSDZGg5IA5LiU4AJF8VvSn/aMQQU
X-Google-Smtp-Source: AGHT+IHxjbEQfIMe5HbQdFj4Z0rfLLTC6evOowx45G8ftbsdoeXdQa6bhdY71gkswYydv0z2A0FE408bVY/Kqy9gEg8=
X-Received: by 2002:a05:690c:4909:b0:70e:7882:ea8e with SMTP id
 00721157ae682-712c6644dd9mr174998017b3.31.1750673823217; Mon, 23 Jun 2025
 03:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-8-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:16:52 +0100
X-Gm-Features: AX0GCFsIut15mdObHbz30D3uLHDBLy3qQ6RPUc679HTN4k-_Q6D8bpMHgF3c5tg
Message-ID: <CAFEAcA9d6bzkhC4wvk4pSM65o0C=tX+rt7-Gf1vLPHLid33njQ@mail.gmail.com>
Subject: Re: [PATCH v2 007/101] tcg: Split out tcg_gen_gvec_mov_var
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-gvec-common.h |  4 ++++
>  tcg/tcg-op-gvec.c                | 21 +++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

