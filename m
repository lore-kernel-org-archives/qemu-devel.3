Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC44C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zqp-00047J-DF; Mon, 06 May 2024 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s3zqn-000472-OF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:01:57 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s3zqm-0003io-8D
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:01:57 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5aa20adda1dso1467425eaf.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715007714; x=1715612514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEjhjrqEJ5hFirUN3tktRysnyA8F2DZew47dDvO3nkM=;
 b=kq0qPyvJ8DCrs2P3RUcxp8Xc6Fjg9hWoCNoWCKtd6LZdRAmqWKNmW13xaMPOFi7uKA
 7av0GQmcinFyq8yD30iEHWYxwKDpNx4fDP973LErExi0bytquvr7y/Wfv1eWEe6TYuw5
 gJqcYPngCYulMTBVqTR9vgK3+F+QV4TV0MrJoKxjW3x4fDqRPhZ1zJ/0VXJ6kkGJwbY7
 C8jpjicXzFV1n2Wl3i9SNEGS1e6gcVMUPbZ+d1KrKWIo4VNZzIujwj9DyJfmlAPuaKe1
 gMfvfNlv5NOZgUc2VQ9+TMPJOevJKkzNcbzugL+LlzD2T/Ut3PHNLAzTXEqghzELhfd/
 T5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715007714; x=1715612514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEjhjrqEJ5hFirUN3tktRysnyA8F2DZew47dDvO3nkM=;
 b=e+vvjyRn1GmR4LnVx1YfG3oszxAaCnZ1263uRpjoOtXSm0UZZTolx/1kv8Nm7CI674
 9McS2MoxrQYH4UZZD6rUjlshyUWrRG/nLpFOPQbYh/4ooVNsfeD35vyOgKLMs76JE6W8
 DAggWcFhdoKs+o2ixlI6syNP0yPggIUxfveXuXkCkO8y5S/dl1s6lreeqZSvZvyao3eK
 6zcMkGa8U5i/MvlGhHMu4R4uygiEXGaDC9fwuzSWESqFiZzj8Mrw5vtkL95ypIinI/Hq
 8ElceawGhpTxF4a2vKIcslRqQxpwNmXSbQVt5APWEAsFeegYfK6oucyy7STqsMjKL8Qm
 CjKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdejkFsMH3x8CG44JbuN6rIHNkQyeKzNX4q4DT9Nay7ngsD2Wr2lwEFhWyrYaka/Hs29wgUi5EHM7TJE0NqtYcKAd5zwE=
X-Gm-Message-State: AOJu0Yz3ZRIs4bI2iRnJ0B+myi6/0OtLZcnCeaT1Acn5gCwatlfWmqja
 sb6D7Or769Ud3NPaqEN6qmHI5Luz0mCks1BDXOieTck+axCBR3S99gryoT94RFbdZMkcL9kibME
 HEtUlPMHNjobUutAr00XMb3do2rw=
X-Google-Smtp-Source: AGHT+IGPY9/n8grycb3WbmSg2fuE9ntnbmfotLJsLCgCLPQ8KIiN7OR855ioOhWxpE0Qai5c/UmXZzK7qISh0P9vlKo=
X-Received: by 2002:a4a:e9f1:0:b0:5b2:bc0:f385 with SMTP id
 w17-20020a4ae9f1000000b005b20bc0f385mr3357323ooc.8.1715007713813; Mon, 06 May
 2024 08:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
In-Reply-To: <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 May 2024 11:01:41 -0400
Message-ID: <CAJSP0QVxJ__44uTHfZ+Ry0u9iL0QxyL-ca7ypO6YUmyEE5WL0A@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 28 Mar 2024 at 03:54, Mattias Nissler <mnissler@rivosinc.com> wrote:
>
> Stefan, to the best of my knowledge this is fully reviewed and ready
> to go in - can you kindly pick it up or advise in case there's
> something I missed? Thanks!

This code is outside the areas that I maintain. I think it would make
sense for Jag to merge it and send a pull request as vfio-user
maintainer.

Stefan

