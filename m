Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1793C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEQ3V-0000uf-Jl; Mon, 12 May 2025 06:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEQ3P-0000u6-LV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:06:35 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEQ3N-0002ER-SM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:06:35 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e7329792c6eso3451881276.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747044392; x=1747649192; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HczL6Nd7ZixXd5rqN6aNd6HYOrkGqiMhPCFx7BsY+A0=;
 b=y/qCm9jK76bTvsvKO0oIB0q2kguksffE0P9EG05nMaJulfjcPNZhT49HtaUYo8ALKA
 FOhOG5VjTClA+ImEg3Hzby0XtzU4emo+yZDl9vPeP+1VR59uvYOecjcQImLHCehkiZkk
 k2H3edZbd/Xwzu5lEaRJqlMlqtC8pMNHYxaJee3rOC2/uTaz+U8sPbNWwF2z2lfEwiMj
 p1eXxSaKBAAWNZYY8g1TEtHHI9uusRjqv6bXf5v81vvVtpAjieXeA3dIUJYmda6KOTh6
 H6cjnzTrp9hHys1ryAw8XV+rbEDv4RsaeNT6W9z01YjrfXuwSSW/72lEr7duMwqyr3f2
 /cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747044392; x=1747649192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HczL6Nd7ZixXd5rqN6aNd6HYOrkGqiMhPCFx7BsY+A0=;
 b=b7svI7c8Y9Rpku72Mq3plI0cpm+DsulgRg3rmcwnoIKvLwd3kVzk1bc2g8qX2WKWyp
 Hoqi7EcZqpjml5vQckq+ePUY3TmPBX8jDYq5jsshkjoLjwY3vi84Jq2ZC1zwp3mMoS7s
 vihfHEkAChuVhpTMjjIyX9n46sqo0pcKxP4rwjLsmyj1DhkCtrLlwFDiKPyO4R9jM5tN
 P6+s/4pd7VIATqAMj4uqjE4RSz6/ME8cEhZPtx9dtDUdsHmAx+mU1gopP2Wod2lFmcnL
 oemgIcz+REAn6stconoQoZTMk+B8E5fTmn5vUCdg3VjOG3Hk3Ifm8q9X9BKOHxVin8i6
 0jbA==
X-Gm-Message-State: AOJu0YzCUCG0mDGKfg1aJ2D44HW/vFoC+wFDBNfW9KwzkjE1sAoEAJlc
 HQexBCTC5ZjRt8TWid8Zm8NSiR3n1HCtDPEzEPgk3tLWMe59TA8ivqkX9NCqpX+pWmOmQ71jaCa
 XPdeY71FF4zOEQzDFnZoC6wCS/FbFOZV3luMojw==
X-Gm-Gg: ASbGncvO4TsJqcNhhxJ+moEVTlLccksL2ko4nbSQOEzKCO6gMuOkp1OQxWOOfqWWh0d
 3TLrm35cuHU3uhZxjpMn5PO/XThLrhNKtZqdcGkpBQaD9eXac3ytvFgh+e8kdgZS0kjjgvLQ5b+
 oYxiz99mf01fbkl9fRV608M2rijkXwO2IXHQ==
X-Google-Smtp-Source: AGHT+IHmNRW/qNnxHqBflJZnLf2SXafuramMh5ILOK+03y0iN/Soz28pyA7G7z+fbO9s3OJ8xHAKMin6Km5qcXvtnE4=
X-Received: by 2002:a05:690c:6283:b0:708:35b1:d55b with SMTP id
 00721157ae682-70a3f9ed3dfmr156288527b3.8.1747044391908; Mon, 12 May 2025
 03:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250508072706.114278-1-thuth@redhat.com>
In-Reply-To: <20250508072706.114278-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 11:06:20 +0100
X-Gm-Features: AX0GCFvqKcPyA_QwmnBwHh-Uc2dtrJB2eqZqP9uv-vYdt8LLdRDhIbu_mutj4MY
Message-ID: <CAFEAcA8gmFVres5yZTz6QuuioBeEFLZams=BNZR9oXUJmffoeA@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: Add an entry for the Bananapi machine
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qianfan Zhao <qianfanguijin@163.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 8 May 2025 at 08:27, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> This machine was still missing from the MAINTAINERS file. Since there
> is likely no active maintainer around for this machine (I didn't spot
> any contributions from Qianfan Zhao in the git log after 2023), I'm
> suggesting Peter as maintainer with status set to "Odd fixes".
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Seems reasonable; applied to target-arm.next

-- PMM

