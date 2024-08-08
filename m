Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC7DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4h7-0001UC-B9; Thu, 08 Aug 2024 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4h3-0001TZ-B7
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:04:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4h1-0002T7-Fg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:04:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so1251787a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723129481; x=1723734281; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vURf/KIj1132Vr4jC3wCpQhBLIpk4jr+ccCkBRizvHE=;
 b=RdufZYTD/xAjyYomAW6ri5lmg3qTtjLdRLMzArZuoy10XEmJymCPm5YoE1wSsalfpK
 YyQw14wWN6ZR5vXqe7FvZTMxcBC1na5FswPNX1piEyWO28obtR6SjuiCT2vOJnqoJhou
 N0fJIOUcFAtMRKUh1rtzNI77GbfVDJN0epc4IUoKH0Gw+3hMNR0sflgwaFs80i9MQHUB
 k0HCbkVOdp4St8T4cN0MBWt+BpHGDXa22k1h5EVRlmS/zPsJ4MW4czHxmTsc/wNoJ9WO
 IMj96X/Ug3Wyb5w6t8Iun+c7B7vr2G0WI70FXYf/3bNTWV9GhZB2JnpWfq95UtZNDRAw
 JEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723129481; x=1723734281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vURf/KIj1132Vr4jC3wCpQhBLIpk4jr+ccCkBRizvHE=;
 b=YX/+P1Li4UEufZaUDTz2sCgdJIeLjHNGFqhtDC7P1p++8pjl3wwNYFp9qnaFInRqo8
 HsutCmSaVXxJrnvUPHbWdqB3YoUh7bRzgAYmwi60wyA9/VYlbGnl4/eIaVhzSHR6VeY5
 YmACSmp9nznsA70Mhfipzvwy9YSsuox028Gh2wlNI/Rk02nH3UBTFCzjEyXbNJA2ihtU
 GA47ZUkyQ3ZAwiMApdmT+JfvKPafDvkYeZFIPYeG3f6xy7rIznQd31fIQimvSsh2YgWl
 pqu7lBvxBQKzyCqlucPGg/ShJg/eglaNqs0B4TktmIL4HzylTSJjRIbuuKFi83AebXiw
 ehXg==
X-Gm-Message-State: AOJu0Yzqpfg7nOc4AxmkLYFLqPjHSrrt+UUR2CLd1vNj0ou+x0MEkz0l
 FQAdMQm8ZV2aCyJsfrGfZ+pQKpFhs5gT0d3gg9raa3c6mv7J0Z1klsakL8ZBVHkM4e5/LvbzA3E
 CdHt22K8tkg922vZLIBXd8xO0rpVtyAIJgdqHyr8OkDEqZ70E
X-Google-Smtp-Source: AGHT+IFVJkMgadv92Z6M8nHK0Utaky5ExKywpwofr+SadfmnwzpoWJj0y81xsYxnaNS/ME1wrQoHpW096Q4c1Hm+OF0=
X-Received: by 2002:a05:6402:2809:b0:5af:37c0:b5bc with SMTP id
 4fb4d7f45d1cf-5bbb23c8630mr1931689a12.28.1723129480479; Thu, 08 Aug 2024
 08:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <3DA024AEA8B57545AF1B3CAA37077D0FB75E82C8@SHASXM03.verisilicon.com>
In-Reply-To: <3DA024AEA8B57545AF1B3CAA37077D0FB75E82C8@SHASXM03.verisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 16:04:29 +0100
Message-ID: <CAFEAcA9zp4AOQKFT48O2txeO9kKvZVwCf5dGgsnGaaZqZ6wv4w@mail.gmail.com>
Subject: Re: [PATCH] hw/core/ptimer: fix timer zero period condition
To: Jianzhou Yue <JianZhou.Yue@verisilicon.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 7 Aug 2024 at 10:13, Jianzhou Yue <JianZhou.Yue@verisilicon.com> wrote:
>
> The real period is zero when both period and period_frac are zero.
> Check the method ptimer_set_freq, if freq is larger than 1000 MHz,
> the period is zero, but the period_frac is not, in this case, the
> ptimer will work but the current code incorrectly recognizes that
> the ptimer is disabled.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2306
> Signed-off-by: JianZhou Yue <JianZhou.Yue@verisilicon.com>
> ---

Applied to target-arm.next, thanks.

-- PMM

