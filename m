Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E30ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngQC-0008Js-Rn; Mon, 09 Sep 2024 11:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngQB-0008JH-2C
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:35:19 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngQ9-0003Dr-CR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:35:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f760f7e25bso16184261fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725896115; x=1726500915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxfKZP8Ad2FL8b3Zz2/iX/CT1VxdkYPkw7K654YdQMk=;
 b=fR0UokHp78qDbDGYFRh8GXdJm+jVH4tDo3s/9WwX+tdPEvpGti9DB97+PLi5crvFXN
 6BbcJQnPEloMyRd0jfYZh1/DU0jtWrz0X4vLV2EthgAGiIdba4WF6Hgewocsnrg9ZqXv
 qB0FE108/0mHW0skuKX6Gbh1OkGFWwLZAl7MNSoGT4ppjcWb1QMcswJYtSBqRC4DEO7j
 NvxW8qdP+MubLYieqtN466wmYF4rFxWtbP42/1s0OWmM8ux8ISLs7zHtvPQBEp3HPt22
 m2obU2KP3piwr1eB9RuKKtmcdARSCr/AxF0UTA3Axnohxt9Lj6iNNf5N4kBmv6anTC1e
 Ndiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725896115; x=1726500915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxfKZP8Ad2FL8b3Zz2/iX/CT1VxdkYPkw7K654YdQMk=;
 b=CqADqN6Ef5L2nYC/vQeIVWx1Qv38and30u164ruQgKGpY39ClS20ShvwNexu549oQm
 HuLpj1Is/KXRW3gZEAG6Qti/DZ4JjewTXujytsfOnkBwWgH+y6ExAY4wNHgtMVJvd1PD
 3VpuC9nsUwov06X7rIlB6B+AScdOIC24GgkIpIbHhfpmN5kJRUhktwLjLO06WhfiMLI7
 czyhnG12Sm38RScRyYC50dKOGGt+m9/7lqMdjAKtBxk0ZpJxaYb6Oi7f6V38n5dtgbrr
 pUhAQm0BJ5uspC7CHwAxP1BjC+ZHFAWIgYP/ekc1LYM3tVjawGHnGjtg1Mz71VxVuoyg
 MgjQ==
X-Gm-Message-State: AOJu0YykTIx+mslEzlYUYiVLc7cfSoCXwwswcm49L61S0+X1BxDUq6o5
 qK6aYIecxCKGn8MpPqF2pFg+b5XgoHqviMWDYoVffihkUgMN+6FUUyhM/5hW6aNReaVTW6MiItk
 c+1/HFDY882VnLLFNmiEbIWrW51r+gOfFuqXARQ==
X-Google-Smtp-Source: AGHT+IGlhkC8G3tq8kD39qWek5YouLgD0KnA+wlHGmq4p9wadY2tVtnott5enignH3VYFSHK1lbL8Rn5O+DAXxcPk9c=
X-Received: by 2002:a2e:b8c7:0:b0:2ef:20ae:d111 with SMTP id
 38308e7fff4ca-2f752209e68mr73037761fa.6.1725896115266; Mon, 09 Sep 2024
 08:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240909133921.1141067-1-peter.maydell@linaro.org>
 <87cylcyhp3.fsf@draig.linaro.org>
In-Reply-To: <87cylcyhp3.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 16:34:56 +0100
Message-ID: <CAFEAcA_+FGsrR8CY_chzyk6+RAsM91HYUnNK4oR+uEXwAbAV4A@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest: Don't parallelize migration-test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 9 Sept 2024 at 16:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I guess one question is are we getting value from all the extra
> migration tests? There certainly seem to be some sub-tests that are
> slower than the others and I assume testing a small delta on the tests
> before it.
>
> On s390x it seems the native test runs pretty much to the same time as
> the other TCG guests. Do we exercise any extra migration code by running
> tests for every architecture as opposed to one KVM/native hyp and one
> TCG one?

s390 is an interesting one because Christian pointed out that
although it has "KVM" support, we're actually running on a
VM under z/VM, and so when we run a CI test under "-accel KVM"
that's actually nested-KVM and its effects on the host CPU's
TLB could be such that it's actually worse than using TCG...

-- PMM

