Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C34CC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6AL-0004on-NY; Wed, 30 Apr 2025 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uA6AH-0004lB-58
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:03:50 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uA6AF-0005mg-AT
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:03:48 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-708b3cc144cso3155077b3.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746014626; x=1746619426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnKVVtp0tA5v1qxF8otOQkxSZ2tWgmedGLFyxLrLsqs=;
 b=efaEk7em8WQ7CPgiwkcA0vTHX8pN6BcU2p22J2cUr4zzrP72kDm/8LYIA/nT1D7W/d
 0XyNhj8JC6k8x0508akRIZ992gQ5k/qL5OUSroA8WdRSB2QBeCjcBFRc1AO26MRnRf66
 8Ozxu9+mTaSLmPgvqJML+lhE0V77681/wBDbpbELKZu6BJLFykFITg01AedOYmBjDrVt
 RXIHhdMbJpy48XgTocQWlHFwFRxOMrpUQoRZAqQJhCYD6TULMeym9l9IBFjVoevLAS1e
 QkXuqijiKEje7ojdt0cu3d6ZHdQ7VNoxr6/f+V/zWv2ccm/R6kDcz4nnPuH+SiaYVZYm
 t13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014626; x=1746619426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnKVVtp0tA5v1qxF8otOQkxSZ2tWgmedGLFyxLrLsqs=;
 b=wljf4DVOF6iIxNznsJHWfd6ZasG6ObhjhjMK4uIegV80Q1gKq+kc5SUmWOEog4V7/+
 IfUkOTpMXhPmvUPf4zvikk37radyYpfbYPq5nJcRFyb04uZVWkid668eZusdWdd9aZQe
 BK50DIaUq6gQkKZwJOSH0Gv5xjjzU6CTcsO/zodD4xkKGd7a1l6wJO8B8dpcRDy+3X7+
 A7IQHNJh7tiW925lVFoyUfJMr6Fr2Tpg5hAX/xk00TuZ/huBJ/86kKO07CAscWQvrGAT
 9Jh2MaBs58whDTeKWGQh4cFPwzVRhY6JQ5mwSzFLxu1Ak1x858QnFczh9zuQOUSKZNoe
 jcmA==
X-Gm-Message-State: AOJu0YzPgvweY8r5HHI7Yx1V23JPIsvzgrOfC6SeS2VR3s56QxtbewCA
 3QyRLoP2WcPM27+TNmHnjSBQBe78gZUnnyXYrGhwsTRcfK0wcFdTmeDDcC7RSK+wQoZWRedLSke
 f0HJ2jR4KJ/L919OzNxzyPQLYlMDZsWlPl/hrig==
X-Gm-Gg: ASbGncsbTNtK6mzCVo+lrR5/D02c4/Jzki0XjwGmI23ray7yqhxV2ZSd3lUVLis79SQ
 +0dBD2bbFURQnznHRjnQvGZrc2zxNHE27/N9PSoUQAJ5ShpXsivXUHOvZ45zDSsqErfwvrFmxqA
 nz6+sEn6n1P3/GwCXzSd6VZHQ=
X-Google-Smtp-Source: AGHT+IH/Tvl4x4T03kwzdTuuAKcXkFDb5acHPcV0eqzjQcFQAWUzN58Oeqjo/7zcLlHf6he/in4WGazFgMZg5P8T6ZI=
X-Received: by 2002:a05:690c:25ca:b0:6fd:2062:c8a2 with SMTP id
 00721157ae682-708abd653b0mr47028507b3.11.1746014626056; Wed, 30 Apr 2025
 05:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250429155621.2028198-1-nabihestefan@google.com>
In-Reply-To: <20250429155621.2028198-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Apr 2025 13:03:34 +0100
X-Gm-Features: ATxdqUHHYtjNplMhxNBL_6UFmnv_2nUodfKPTd_MvHrZ6xZELfqXrIkI3lpXYPs
Message-ID: <CAFEAcA-K0B0gfpmG5x92o43aCNp-q3ocrgfvRG+7gN-NfgybJw@mail.gmail.com>
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com, 
 farosas@suse.de, sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 29 Apr 2025 at 16:56, Nabih Estefan <nabihestefan@google.com> wrote:
>
> v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
> suggestion.
>
> ```
> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> ```
> Instead of straight casting the uint8_t array, we use memcpy to assure
> alignment is correct against uint32_t and uint16_t.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  tests/qtest/libqos/igb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..2e0bb58617 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>      e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>      e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>      e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        ldl_le_p((uint32_t *)address));
>      e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                          E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        lduw_le_p((uint16_t *)(address + 4)));

ldl_le_p() etc take a 'void *' -- the casts here should not be
necessary.

thanks
-- PMM

