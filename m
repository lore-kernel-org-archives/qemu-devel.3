Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3492606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ReeGsFSE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwjg-00020T-Oq; Fri, 27 Nov 2026 09:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwjX-0001sj-5h
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:15:30 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwjU-0001LJ-N2
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:15:26 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67db6d4054eso8707473d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795788923; cv=none;
 d=google.com; s=arc-20260327;
 b=MIqXLHHvs5WcbXoNk0D1mYea/z5wk9QuQWab5rP2fV5dBvtRQBM07EElq2a2tAifYO
 MZRbXQs7MXbuIlX5Ye4rOkzY7yIWQAm8W+le05YGmfy6g6CDQUHtWxijvDepduqrSCNs
 q+0a2VO9akp+OQqblwKVnN/IhrE5r6/Ie4KWEX6PReLKlsWML3ZWv/fo2msa+3N/oDew
 rWZXZRL7H0UCXVNYIsvMXntAXr5aY1S0geUFSiqU6aFWyKjtATD87+uDVT1jLYs76Gsi
 DtsxuR6AWSk4aHm8jcpbMvmBxB688PL5gMc4PonFht6fcDeBXUhIfNuK1C5lgKzR1FjS
 kJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=po/7sK5knjk6t/+2KZt8fSsbUS6JEabi44DUPg3Kmfk=;
 fh=vC/uU4M5uV4UbxLhfWAsSLjz/kqUTNTugKKi/gUgbKk=;
 b=aQgCCC/VZkwxVTA40C7kilxbIMk9IJ7nDZlkof4+pp7wb0B5dptywZ0eWqhONr5Ocm
 xM1oznz6oiAszy8VkT/JGnIdtWr88WDBvpq8Fqlod1hD/ehQ6rB2g6425HDYNdwB30+c
 LlKLxubZUjj8ue1qpj65ztVqTYGYzMEqYr5QkNkoRH7U8R5XJbCCizO31c6DCGXU4TO2
 D5gZ4IDDnOcn4NJbmMJbRNOKucSUy8mv+R/EY9tRITWNM7WEnZQB80rcZMXH89798Zv4
 yJz7ggXySxGRFaIesBqCorWYgkP3nO8JNnjeWB7jVQM6khqHvlf6fmhPaurq8t0nADBL
 ZOpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795788923; x=1796393723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=po/7sK5knjk6t/+2KZt8fSsbUS6JEabi44DUPg3Kmfk=;
 b=ReeGsFSEgd7lyT9jYcOSbsM3DHWTI/NbHgS2/eqGuMgMNBLq+P0QM5dSn+/Vx8FSPk
 dKK+ELygBr5wdq3nTseP96QSX9jXA15w2y0ipWdNUNJnMvTGDULycY2XordvNVe5sh1O
 JPGsxvF8n067InT0obBk/iZB4oxju1HDL8/LH+55nYaFnujMkaMPFbkHMUlfH1lXFeL4
 qWGeklA3dsyEKj8f58zOvBslFJ8G2b04JUaHIk1/XfYH4CSWPynzC5HPTXJset7u/0iP
 KNywcPiBx+t2GXNbNoX8x0ahAHCT2nF1TD4NT6iZICsFH5ZeUsrONWiVFgtF+K6/4UDe
 1LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795788923; x=1796393723;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=po/7sK5knjk6t/+2KZt8fSsbUS6JEabi44DUPg3Kmfk=;
 b=h4RR+uu00nPvmdBA2yV5Hpt0inkd2T5bxGk5f6GWY6CBV+7vr07hMj8mqrjFjWonT5
 2xcte5jv/eVeiVxTmZuRpkldtMBXjElLH9TovuXXZJ2XBj9QuuoL//67ivJuWSWakiZs
 ES+1/dmpgcoOdUY6A4ufV9LsxpJItF/XMsAz6E7pq/twItigaZXwHB5SWX3kAqIOKwbb
 WM975y6kQZ8qMmihFvtR2zjgplLPE3DExwOfUfcHiBNbFhQh0MS9AiKajJBoosTYQic8
 34YHdfBZktdvdjRwUygvpsUs6B+Hp2jLxeebb806O3W4WN1ypAqsZw8gvK+YrC6xyjMJ
 tZyg==
X-Gm-Message-State: APuU4Z+t2xK3p3Y8h8cus5en3jbHEpmHEjbE55TRaqNbz95ZJtsNLcr6
 4ofUQe9iHrLUAUBG51vCPKTkPAOhsiyIZ1PN0RauDshXpXgi4gJa+93dXaWV7UztTCVAdKVnbF3
 tibUNvexzLcdUbR0iu1PSTktZtUr9CDLP7xdK8y6BFZ1o+9GV65TH
X-Gm-Gg: AZFdTZcN6L+ULX28OUtaqMB1PQzbPHRvgHJs6+H6QA6hk06lC1wCohrCdjmsWxgixmt
 kbVBSmR/6Osszs1QhUWHU2gawesptm9oN7C7zkfRtO7BHIi7eowuX08ZyJ7EYtVzP7tffOm4W0e
 52zmfDinh8CLdUadkb1bVRbsYeGYrv69gRVM2iju7sY84ORPMgqTVppM+veltIf+IVkzalaGCR8
 L5tx15DnUrxbhSGX6/hiJF6629VGJPDBJX4wulPZEvI9tD7bISUXoy2oy1SBRtNNyJk5dHXmwj/
 6MYvl12k++A2lwjwac9cXy2gH58nrfUH4zne7HeA/Rx2UxCs6ywdNZZ/2IdEJyeNRU/peQg642W
 ulcmInygKqYaPbvwF0BchWDzmt3VJS5gTz5nbM1iYOd87RyfzGD0jYT6OWBCt7U6EegmDkdK5pi
 6lB8C+fIdeqRXbsgkcdElO
X-Received: by 2002:a05:690e:4006:b0:67d:b262:92f8 with SMTP id
 956f58d0204a3-67df43fb39dmr11256751d50.46.1795788923142; Fri, 27 Nov 2026
 06:15:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
 <20261124073406.87537-5-philmd@oss.qualcomm.com>
In-Reply-To: <20261124073406.87537-5-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:15:11 +0000
X-Gm-Features: Aa3M54qpQt5QA0U14AfWb12Ii8nC5PEOumeJwCQlQ1fdc49YIHYCwOc9L9srFys
Message-ID: <CAFEAcA_VhxkiyzEFFLRZqPcomt1qJjV9ouNtvVMB-J3qk6p=GA@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 4/4] hw/sd/sdhci: Gate Auto CMD12 error status on
 its enable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 07:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> The Force Event write for Auto CMD12 Error Status (also reached from
> the Error Interrupt Force Event register) set the Error Interrupt
> Auto CMD12 bit regardless of the Auto CMD12 Error Status Enable.
>
> Gate it on the enable, as the command-timeout path does.
>
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

