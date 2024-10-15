Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B150CFC293
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 12:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0gPb-00026P-4K; Tue, 15 Oct 2024 08:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0gPZ-00026G-Jd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:12:25 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0gPX-0001RU-TO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:12:25 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso7723951fa.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728994342; x=1729599142; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq9+EQHa5RzPJ63/qEJv714h/xC0C+d4H3hoRol/rlU=;
 b=DOZQohvss48oOZqEBiHgo0+k+sswcvAjedWlJGvt+MS74SF3a0BNpp7MeYmuGLLqVz
 nanOb5dWI74HWbU6q+AwIJPb3HQ4Pqa6YgfuL77hfjcNnFB699/laap+XVzYZ3W7J8V6
 rIIP1/RF/DLQuatTQqQ/mIa6tryKAQ7Y6H7UbnEcVPWVvA8TMfU0I6Pi7I2Z672Zzkxc
 bFl5IVR5K2+y/tTWuDvwe19/uNF9TnXi3aCWL0W5An9ZLYuFSwurJs0D2YFKYdQYbf6+
 Fs7Cr3BEBxEdXJKCb6LG0J8TY4J3i4WCht8uelizxM4IcYhs2Htr4gmBb0c72Ih7QagA
 8oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728994342; x=1729599142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uq9+EQHa5RzPJ63/qEJv714h/xC0C+d4H3hoRol/rlU=;
 b=eOnalZYpiJ0L+jY0TFTIwq1jWLskkf8Q/gyuyQYSRGbMcvxFq+aPWubUh9lNzkZ1kI
 sjT9stlLEAf8pUSIj5ZQEcvgML5R8iQEC6ZetuWxA3axXe8m80hBh/ot8uYMCok9d388
 dFalSjkKHZUH+jd3OkdfdSQ8Glqh8gbk5DKu/uVaQdxb0VTBi8qNvJyR9RT/fGOYzDfJ
 r7w23mxRuexklmG7j9AjBACAz2ozsL3KUDa8NJYJCveq92SvOs7ssrKlcx8WLQQNxBa4
 dHpX+PK2qjcb+UD05lw1XbHsGOCN+pfggEHrlva/gtSIux3uffYRgFpUQMNzyka0pZG5
 tS2Q==
X-Gm-Message-State: AOJu0YymHPitKLWKrO852hjmvaguP+M0qsEt+BnKByezDLm4/V8yFvql
 WcbijrgN3gDa2GnYMVk6f+UgGC30hh+WKLk48RXtJOtjecQOp0CdnM5N9sTGF8PpXZHPKfElN7a
 YYvmeEhlTEYyrxLNC/TY1FsPLdoKvH+SCR6jpew==
X-Google-Smtp-Source: AGHT+IGN7On2VjzDcXGfxsTZzOI0ynfgPByxuziiCA8/RxSzUoI3ufhPFSazy8s6phwGoIB1zGfsl8te7Is0eYP0Jlc=
X-Received: by 2002:a2e:a544:0:b0:2fa:bb65:801f with SMTP id
 38308e7fff4ca-2fb61b45f86mr2451081fa.10.1728994341944; Tue, 15 Oct 2024
 05:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241015113705.239067-1-peter.maydell@linaro.org>
 <24e57088-ebbc-4a9e-919d-5d05cfca00a4@redhat.com>
 <CAFEAcA_QWnxWfZn=rqbpVC8HrhZ5eBi6BcFc45UBKqVX9cLY=A@mail.gmail.com>
In-Reply-To: <CAFEAcA_QWnxWfZn=rqbpVC8HrhZ5eBi6BcFc45UBKqVX9cLY=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 13:12:11 +0100
Message-ID: <CAFEAcA9h3WD4OZ-A=EyB9hjd_SUaRGDh3+4+Nvho6HidJPg7uA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Raise the ide-test timeout
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Tue, 15 Oct 2024 at 13:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> If it is, it's one where it's intermittent whether it hits or not
> (e.g. I grepped a bunch of my local logs for this test and there's
> a lot of 18s and a 30s and a couple of 60s) and it tends to hit for
> multiple tests in a single CI run when it does hit. e.g.
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8065512834
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8069311713
>
> are a failure and a pass of the same git hash for "clang-system".
> The 'make check' stage on the failure took just under 40 minutes;
> the same 'make check' on the passing job took less than 3 !
> The 'make' stage also had a similar gap in timing between the
> two, and I don't think that's entirely because of ccache caching
> effects because the stats at the bottom of the passing job
> say the hitrate was >90%.

I managed to both misread the ccache stats and then miswrite
what I intended to say about them. Rereading them, what
they say is that the hitrate is less than 1%...

-- PMM

