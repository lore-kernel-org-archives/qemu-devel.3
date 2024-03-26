Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820DBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpASh-0004HE-Ta; Tue, 26 Mar 2024 13:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpASg-0004Gn-8d
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:19:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpASe-00012d-2F
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:19:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a46cca2a979so341675766b.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473582; x=1712078382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXCkP94MSmM1uxur23H8MFRNABPQpCIMzDvgMjp9xfs=;
 b=Q/NT/mz/3wB61jSYYYgNb/MMxpFpzeIiwbt/I3jRO6lVUCXjG9bJ+iknM7b+k4BkVL
 uYP3NoQAKTAodTy+PPEhz1LE0/IFJJ+opnc262VbX5kQUQc53RA59xy55qzWL0Libcy3
 rZmJuZZn1vqDnndtQMH0HeWfpzfNd+gs3DDDKydlqsoB6QSaRplofQNQL8tbi//T3MYU
 +ZA9V893C7ZUYK13WxkUpAXqXAzDVrGOQKt1WTf/eBH6OlUgLv38boVDcOmdX6Nsf2Km
 6mgvNfDoML5ELcQi4bY9GorEarwBxRdTKU14hHrhWH6Vm2UyzCOsTo53fHJ7xDKmFgqX
 x0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473582; x=1712078382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXCkP94MSmM1uxur23H8MFRNABPQpCIMzDvgMjp9xfs=;
 b=LdjtgTMjcb6/HbuBr5eZocWAMA0+s1mQIEUYcuDJp02FV4X5kRJ3P6rN+rhyphgw/9
 pc73e4j6P6aUcR28krZlzExkwVxf/M8vymVUtynKLos0am0m4yt1q9AytUZ9ZyQrzNvv
 F+ldPBhvnmFdyjcnvH2A+Fag9HlDj38z6wHREsDJKCPCrVCPp98fd/KjqZlZBoPpeW3n
 gxuVtoRtSEwSsUIO19gnTWSelP8A3MkJkW87WsEr/64BUGYvOpQvBne3FagknUcCrg3a
 ABdxWkoBrgqs9y1TLGCzGWdc2+51F4tBYx57EsxJcFNKI7b9c4U5gTIJrr6fNDfEHgmz
 +O3w==
X-Gm-Message-State: AOJu0YzhKzFn4ehjjI7QiJzc8rJqh46lmYYBgm35VPzr+0f0/yn4dQcm
 IXug6EUP54U7ASUgASba0ZCJAF8zGwC4RKOwsO9bhCPmtOEafbGK6m/qzLZTx1nFiS7MPU2NV+7
 BOSC95b8WNcjgPyTora/7rFbfG8k1MWWjgK4PDA==
X-Google-Smtp-Source: AGHT+IH5GN8Z6LIHhQzj7UUVVwqfzke1HbpmW7vU9Hdw6rSIX4yfk26HCmmMkvyx227Pvhr1k3Cm90jC00y1ISVgN+8=
X-Received: by 2002:a50:d711:0:b0:568:d19e:7ab0 with SMTP id
 t17-20020a50d711000000b00568d19e7ab0mr398984edi.36.1711473581887; Tue, 26 Mar
 2024 10:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240326171009.26696-1-philmd@linaro.org>
 <20240326171009.26696-4-philmd@linaro.org>
In-Reply-To: <20240326171009.26696-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 17:19:30 +0000
Message-ID: <CAFEAcA-d=QsQKBSFsbV=EAPKs2MbX1R-CiwApW=w8sSFLzQzkQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? v2 3/4] qtest/libqos: Reduce size_to_prdtl()
 declaration scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Tue, 26 Mar 2024 at 17:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since size_to_prdtl() is only used within ahci.c,
> declare it statically. This removes the last use
> of "inlined function with external linkage". See
> previous commit and commit 9de9fa5cf2 for rationale.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

