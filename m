Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B27CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIU-0007ZL-0o; Thu, 28 Aug 2025 13:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdt0-0003Ga-7r
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:45:58 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdsw-0001Ls-QA
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:45:57 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71fd1f94ad9so9347027b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392352; x=1756997152; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c//lTL82chI1PW3TaAr+CXIQB4IstVy5lRRfnNQVIG0=;
 b=VSW2bl37S6iga7j9GzGrKIQettk7fV89WeOdQbzX2sUTyPZBUORskdrMK69q2Yjnie
 kVS6YLDSyBd36PUEIB+4g5fmQnGk9j1jGknRvJ706p/BnuNV3RNDQ+aQuFDTiCWI20x+
 T1/1H3+9fu6+OXuCB00e+rEZC0e4XxAZ0G4CmfqL8im33eFhEQ3Su0ZFLtziIwQgtVAo
 6X6V5KF0mmIZJ4Z3cOwYGwndN9F4xkQ288Erm0kaXs7BJ3PPaaJ+X9kBrZzMhMHe84WW
 LSJGcOrkrSRYt7bC3Vi40pjQS91Y+MRXNVG89tDPZmgO0Cl3WSD17d33dqEBIJYHly0m
 0Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392352; x=1756997152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c//lTL82chI1PW3TaAr+CXIQB4IstVy5lRRfnNQVIG0=;
 b=IoavAkPzTWZN5i+4v58MsV5vIW0JnJl4eK0ntQ26a+bMjanKwAjlriWfrSTtANZ6Mq
 2QdDAb73ef3tKN05qE88jFv8rVK8Iv+P7NovXcAx9CdejNhOjEfOYcI5sfjyi9ztA51T
 hycJNHzHYodwKqzWToNwQJmf6UE9Rzjlpk325uZMsfiyLZvZEEFNZakXfvFWtj/7ZIHt
 qnsG09IsonaIFLyaw7l4mYph1tDUX7yShb18g634zBBPlfj/+nVuUPkW4L/QpElF+3OB
 EQT+mYqalZlE3giaDjq94/6P8jNs4uEQjtiOylQzx9DF5EpdlzHHpW6ZZgsF15UTSSoO
 oh/w==
X-Gm-Message-State: AOJu0Yxqt45ENg+8OGadPurhgw8+SylEZfx5XiNdlO4QvW72u2HpCtz3
 XJwRiNm3ytBlbPYj5Dv7EJmotYL9+OG3ip5gcliH6aDvfzdffyCVbx1edezpgk58ZqnhRugQhxt
 nbyLQFCpLz1m/ut4EQo10dsafMvUN+e2qRN68mUP9vg==
X-Gm-Gg: ASbGncvFCmle/GkbFE9/prU/1e4STPcrlmaoBVk/BpK3NNb5DpVBEcoIW1aV0cFqblR
 3wc+8vxvV3zVokNIm/CRsCFiydNRLlwTPwhmK58ffGKZjPoJmFGXACoHFRjMzQanUw9IfzpcY0E
 yxcjOcsdNO9JHQFvZ/xb7bvoKYCcmaQ0wHhmk0c7hl30Ah0gMe7uX5UC0BisCoAQgw1vxVimFLP
 Kf204A6yPFV7kBZT7Q=
X-Google-Smtp-Source: AGHT+IExhfyXKqQTYjlD6IKxVWw6owPMiykl0SPbyKe60iUnKGF/5mTY1vrZmIPxdBQdbEAQ+mHg7ZvUmAWtf64NMJo=
X-Received: by 2002:a05:690c:9201:b0:721:4a2f:5b88 with SMTP id
 00721157ae682-7214a2f70dfmr59344617b3.29.1756392351957; Thu, 28 Aug 2025
 07:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-34-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:45:40 +0100
X-Gm-Features: Ac12FXxeizv3Ia59UPxbV3ryLYrrB1CkB9hWq6nx5bjWE5FfkmxpYdNZGmGllqQ
Message-ID: <CAFEAcA8r2Jx3R9f9-T8hQ+y6T9bWNjUEsUDn=0eE8vj_ScT9Xw@mail.gmail.com>
Subject: Re: [PATCH v3 33/87] linux-user/x86_64: Expand target_elf_gregset_t
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The comment re ELF_NREG is incorrect or out-of-date.
> Make use of the fact that target_elf_gregset_t is a
> proper structure by using target_user_regs_struct.
>
> Drop target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

