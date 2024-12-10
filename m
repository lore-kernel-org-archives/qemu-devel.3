Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44356E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL1jk-0006NT-2K; Tue, 10 Dec 2024 10:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL1jf-0006Mz-8x
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:01:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL1jd-0005eX-KQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:01:14 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so9215555a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733842872; x=1734447672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j74821d9GAhO8tGU/vy1CRPDR5lIrHW3CZzQqLfOGfk=;
 b=Dlfrm8NIse+sCkwb2k96qMRMVoxFexjH92W7m8XhTqDe6zWhZ8qJtwZxmcSBClq9jW
 NfVevu5WVrnMnVtz8w8PLTBpZa3621oJccxnlrk3NqmWrzKdQ0lDqU7jb0ZWWXOd5g8H
 a2YmMa9CnUC98lfKAs9HJlFKdX7CfR3H083AOdNj6/6ri0ZfCfoQTF/1XlutP0SfHYqk
 NRY57Rw2H6xT+X4pABh3Oes6M+ycoYPn+LVOhXP6oZZKL/aV46Wz6BhLxII+M9igEya6
 zZeaRBWoXaCg3DA74oAEf9z3RHMzXam0UiPelvu2zJJlyATKq1IUv4i5hKGyvv+kSjbC
 /C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733842872; x=1734447672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j74821d9GAhO8tGU/vy1CRPDR5lIrHW3CZzQqLfOGfk=;
 b=TFQmfASLHtFuHTUr9bSDeszWHFoOZDAWm5YFs7AoepPlBRvsm657St5np3ckLOqgLe
 avn0E29JSQUaNBr72JxVaqxPnXz2zqdhvSZBQ3dFLJQTSZkmmOL9MYj59vK/4smnL/tA
 EY7ZtNjShQFn0gkQDVMwJTDkYDvPH6qGoTtXtIihIHtSh0+M4hATns4jdAmnX8HrYm9D
 WMw0W5OH6Pw1q3nnsEVaatVFQ/yssq2OOlUDtATOfpr4146X0b93k7OKv7/a03Q+8fKa
 hZRivfjan6IIzUiiGKTFd4eAT8fJQ152wE1QdDtgT2kJBNsrx6xTrBefthRl5sBtJEyn
 hyqQ==
X-Gm-Message-State: AOJu0YydkoFworEb2yYIruk120vRALiG7pa6lGrim5CJLaDgKzJOTjha
 mDKS8sdn9r7em0iT5gU9rLeDm24WqOaTr5od5QnaH+ZPZtUbwKnubGMeAMrKKJlJoMZvTYvIxIf
 56fxYreQ/ixMuCM0vCbG8t8GG3PxlrhEtHtzkjA==
X-Gm-Gg: ASbGnctYLRzg8mkO3s5SLlybztd37MSXQFBfJ9cdGjDtrZLxf2WJlINuiS8IO8tmGqH
 30MTbQPqry/qL7vGyx+pqk5ArcnFkFUcGA33O
X-Google-Smtp-Source: AGHT+IEcfM3M1kynoX43qtZCkkEoALK1VoV+PUrPzFYwhilWFYxx1TaqKjJc1ca3dLLqyLvkbWpJbEiw1lMatp7lXgY=
X-Received: by 2002:a05:6402:1d48:b0:5cf:ab23:1f07 with SMTP id
 4fb4d7f45d1cf-5d3be697424mr16112549a12.15.1733842869885; Tue, 10 Dec 2024
 07:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20241210140112.43313-1-philmd@linaro.org>
In-Reply-To: <20241210140112.43313-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 15:00:59 +0000
Message-ID: <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 10 Dec 2024 at 14:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> cpu_physical_memory_rw() API is documented as legacy
> since 2017 (commit b7ecba0f6f6). Replace it by a more
> recent API. Noticed while discussing with Peter:
> https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba947@l=
inaro.org

I'm not sure we want to do this as a bulk automated
transformation, because in each case there is likely
a better thing we can do with the call than to use
address_space_memory. For example most of the uses in
devices probably want to have the device have an
AddressSpace property that the board wires up.

thanks
-- PMM

