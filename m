Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4971AC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 19:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro6y1-0003yO-Nz; Sat, 23 Mar 2024 15:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1ro6y0-0003y9-6W; Sat, 23 Mar 2024 15:23:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1ro6xy-0001UM-I3; Sat, 23 Mar 2024 15:23:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29dd91f3aaeso2242591a91.3; 
 Sat, 23 Mar 2024 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711221819; x=1711826619; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F73dvEtwIOBh5oFshfiS2mW5qnmKccT/uXo1IvtmEks=;
 b=DSI+ieo5x621pFQDy6Z50qnK/eRuarbXK9tpy9YYfdp2yAW5Bcz0+zjF+4GtAi+gSn
 N39FYQ/OqhHx6HcRL5TSGp9J7ZTmKBYWUEvtJU7BMP59GmJJnn2ANqkEXOf2u9UMUbgL
 hzhVFSPiYWPQtXTbXZc87VQaDw+zBjGsmQgsWXk4IjQFcgWo8DpnayRgWxCvd8vQsLYH
 GHgOOHkc7SEmuBmqJiWvewTY3rO0tLeNseP+diVLcIf2iBedRyWy4DGaCO9R62HSdq96
 3Eg4GbDGmVFurOslI5CIJ9AJuDU+u4keAgRfa6VbylaQspBbOSNTI1WzZklWJKyQCOT5
 3yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711221819; x=1711826619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F73dvEtwIOBh5oFshfiS2mW5qnmKccT/uXo1IvtmEks=;
 b=Dh01mPvutzu5cELVR5KomG0kIGVlJ9zlROevQeQBRUN3RQ/bGXQfZhCDx1bMFXzW1L
 wdjzh6AXBfceMdePJpf0a186akSqyDS43Wrd8e+7GxNSlFkSrln4Tl3YyybyhsRbjXNw
 leXnAo0BtGxOq7FanqxP+xBPVBOflK2yJHjjRtUxR1lOJZH0kLtQhwYe0USVJy1HQuNb
 et7fuscqiH00vBw2E6rsXIbZ6+ujv7RCh31r/+PFYg9KzNyTLu2P6Dtz2Sk4LmoM9Ylg
 gsTPdJ0FB5cWs7heLyE5FkbAVbSE6KBSTluXTaR8xlQzXHgbJaaOLGi2twBSu3B2pFCk
 BQ9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV06ke2rGRE9jEgzM4xmVWIKebsqbOGrQSa5I6wvhYaUI6jCqhQnvviVkT0p8oShAGbXySxtMcfGIdiFDAAYn1RurAb
X-Gm-Message-State: AOJu0YwDRTBlAScWVvKN2BbDNe/sZFcAeaaO8syW69usUWw283vLmEkF
 iVedr3qvU+aTgHyVS+NNfWETbBbvdm2ZmSaYrlGbUuKuzbQyu7PBwNkr7cWwpa5KTVYs8I7VpXT
 M0maSz0PImHyI/8b714MJzN4d90E=
X-Google-Smtp-Source: AGHT+IFbO8PbPeLAO9WOB2WFteDlOlfWHLdI/nIustkgks+OnGD8d7ASVuFv3Ief99MI9bGT+cSpT67+IsPd22/LV10=
X-Received: by 2002:a17:90b:4f89:b0:29c:6a5c:b8f5 with SMTP id
 qe9-20020a17090b4f8900b0029c6a5cb8f5mr2372254pjb.43.1711221819010; Sat, 23
 Mar 2024 12:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-19-philmd@linaro.org>
In-Reply-To: <20240321154838.95771-19-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 23 Mar 2024 12:23:27 -0700
Message-ID: <CAMo8BfJ9XYvzd4hTRbVvbsk0LkxWqKZ6trLuJpZRsRy7wjuP7Q@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 18/21] target/xtensa: Extract MMU API to new
 mmu.c/mmu.h files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Chris Wulff <crwulff@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 21, 2024 at 8:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Extract the MMU API and expose it via "mmu.h" so we can
> reuse the methods in target/xtensa/ files.

The MMU/MPU are replaceable configuration blocks in the xtensa
architecture, their internals don't have architecture-wide significance
and I believe their exposure should be kept to a minimum.
I have a half-done xtensa MMU rework which I'd like to complete,
it only exposes the interface for address translation, opcode translation
and dumping.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/cpu.h        |  32 +-
>  target/xtensa/mmu.h        |  95 ++++
>  target/xtensa/mmu.c        | 889 ++++++++++++++++++++++++++++++++++++
>  target/xtensa/mmu_helper.c | 892 +------------------------------------
>  target/xtensa/meson.build  |   1 +
>  5 files changed, 991 insertions(+), 918 deletions(-)
>  create mode 100644 target/xtensa/mmu.h
>  create mode 100644 target/xtensa/mmu.c

--=20
Thanks.
-- Max

