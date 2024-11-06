Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D407D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kGs-0005sT-8R; Wed, 06 Nov 2024 12:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kGr-0005sD-Bd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:56:45 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t8kGq-0003HJ-0O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:56:45 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-84fb1225a89so2444276241.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730915795; x=1731520595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72mDxKkkjH8Dy9E7zBtoQvU29JmOXSweqzZRhLMuM/g=;
 b=Uvn/MH/gKqJwsizg6D6+ZtN1Ih3CM2y5N7ejfo5ZpCPfJpjupllSNa42LhoUS7vN++
 Y49Iv5VlqgR8o80zs6k+l4ZeFiG48iDGUuSuishgsUW03ixtwQHdQdnMeeyV941FtrjL
 +VejloYvjzNTEj2TmEqE08W7i5LlzE1O8l8ZjjO+g9inF9HJKNXELtyGrW7xsdlScYN6
 5P2s2sDPs9x6tww2YsuzaYgsf4BUCeqz/qdqx3XN+wHzqWcUjiD3z++NASDYnpH56l9C
 SV1oynth6tEIwBPUSo83wJeEenENayCqHNSbMWLmNaybTtqPrRneyKPl2k/UgVam+oDm
 ADjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915795; x=1731520595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72mDxKkkjH8Dy9E7zBtoQvU29JmOXSweqzZRhLMuM/g=;
 b=GtqJbBGwGs6mE2bM/NZvK+2SCpdVhXz3xzwYwu3WBbU9mZivjVoepryGAyLXkb71d7
 7YDGma6zpj5XAq9NeT8WIoeJwmcuDM30fPSSL2kM4CrjnrVRWsvcV0QM6BvPav9/xg8F
 5mpxtHrp0vW1HZnP7gsIOEMDsU8JVPiWNx3o9aKq4yHsrN/55cpBJ7lbvy/+mjnHHWzv
 2nwS/mftpvRhXJluZhZb96g3H3ld01TJerRcOVdgNz0oPfwMTHP/hdWuer/8yg+fVgAk
 YFqL1ixzXBYwe+hLdvSWOgTzbLd1e0vNAyHQAbJ+AAwFdmV7KXlBkDD63h1sMg+IH0Il
 6nmg==
X-Gm-Message-State: AOJu0YzgMC/ChQs9bibPaqwzL59AHZthPx6B9HpTtEb6UUHyOstXZQyj
 dBoLE2c64r964KVnJVrqg1lSETFF+BNPtcIGZLheVhnly6TiKLadX1hj4dXdZd8vg2/0RDwcngl
 blHT2ofEJSWJoe5jNsZxww1gnuC8=
X-Google-Smtp-Source: AGHT+IEO3tsWNWrWEd4VwUH8DwCxrzxXL1fO4YPIQzWwjZ/R3fI8YGBDW0py7OJBQ5bKk12JIlkR1ffWpRtZO7UqGr0=
X-Received: by 2002:a05:6102:41a2:b0:4a4:97bc:c0d7 with SMTP id
 ada2fe7eead31-4a8cfb4bd93mr42928451137.8.1730915795612; Wed, 06 Nov 2024
 09:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20241106174443.557557-1-pbonzini@redhat.com>
In-Reply-To: <20241106174443.557557-1-pbonzini@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 6 Nov 2024 23:56:37 +0600
Message-ID: <CAFfO_h7h-E-DxJxZDp3hGBEdQjC8x1A2rvLqHrx0n-G0uobUtQ@mail.gmail.com>
Subject: Re: [PATCH] eif: cope with huge section sizes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Nov 6, 2024 at 11:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Check for overflow as well as allocation failure.  Resolves Coverity CID =
1564859.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
>

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Thanks for fixing!

Regards,
Dorjoy

