Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E555AC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsJJ-0002on-3Q; Wed, 19 Jun 2024 06:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsJH-0002o1-OY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:13:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsJG-0004mg-1d
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:12:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42198492353so49134485e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718791976; x=1719396776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a1tr7tP2SVesgODm/vbuIdxD06B23qmLvwOZcXy60hk=;
 b=EsgI4Pp2aCd3mF7fi40E66lAa7dZoLNBjmCcsg1Q4Qj+9e2uwwSaYSW8i6gQ7rS7Uc
 NEL6dtc9avvR9yKlLaqVUXyr2sgVJbcwYQdTq1xtfwh99wt2AUudbJDiAO3cnLZ9vg4g
 LZgS6W9UdTZVBdcVB8D4bBSmrKg2RpveD21Uu7cfStLU6m888E+o0zYGnZyXHw/IS5wr
 qoKTQ6NrbE1OzoMN1KMyr6J78x0KnGedy5oZXqfc/8HbTyoOYzwNlhKvvs0X9y5VlkU1
 7VeaWwKDJerhEgKOdRb1JXTjw415gRgaxZ21eAFRhfUJA6UgrstdU4W2G1OoekaxH3g+
 bY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718791976; x=1719396776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1tr7tP2SVesgODm/vbuIdxD06B23qmLvwOZcXy60hk=;
 b=WSmB64OrWdxq9zOMshqWcKSBoMyDcLMz5Tbzu94g5KxDCvmK3mw5Aw1WEWb1BLvAzZ
 BKAdQmpFaJQETeZHqysAB5CSMs1+7s+ed+TYLf/ncmaFuzvrUVhagwjUGMlYYuwtBdXl
 nFjhqdLhMJLIUNUOElU7cUuiNGD+e9b/dfUUTuPx5exvf6g/zHUwE5fOsGUounf1w9JN
 NBS0v6KoPUVTv3JjnjWK71tCq2RXwKso/VJS+1v9Yhu5R+OCbvSxciv9NkgAK9H6eF4O
 9Asn+5fMYvK06KxpooQ/iYdGS0XUM/n8seIeTz6wtq+UPvkbULe7IDDO+gWA8eVacSex
 jY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEjBMp543sGZP3+OJ3pc6CTCIgt6cfzAYFpHcS6X5UjzdTeYHLv1dpjgwxSwz8+zLPwKlwKy51Ice6dEKGMd92Gj3unM8=
X-Gm-Message-State: AOJu0YyRIFvCWEOFif2r95MOeaKPbRrQ3S4RGK8jdGpprypmxhwiI0WI
 PRBFT/txSuKMLP3AUbK9LcLD4vmUBQOMIwH4+U2uML4XqgnfVlL7nbXrcECW0TZWWhlK1Q8aaVI
 2
X-Google-Smtp-Source: AGHT+IHRX7mHbuLAOojOezzeYPHES4WriRoAprioWVNGtUE4Rimmmpa0e1uSqAuXxWhAEw00D8j8RQ==
X-Received: by 2002:a05:600c:54ee:b0:422:3da0:3ca3 with SMTP id
 5b1f17b1804b1-4247529cb34mr13455115e9.34.1718791975997; 
 Wed, 19 Jun 2024 03:12:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e73e8sm261158225e9.43.2024.06.19.03.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:12:55 -0700 (PDT)
Message-ID: <a9d58834-ecaa-4aee-ac43-7b47cee656e9@linaro.org>
Date: Wed, 19 Jun 2024 12:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Cover all tests/qtest/migration-* files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240619055447.129943-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240619055447.129943-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/6/24 07:54, Thomas Huth wrote:
> Beside migration-test.c, there is nowadays migration-helpers.[ch],
> too, so update the entry in the migration section to also cover these
> files now.
> While we're at it, exclude these files in the common qtest section,
> since the migration test is well covered by the migration maintainers
> already. Since the test is under very active development, it was causing
> a lot of distraction to the generic qtest maintainers with regards to
> the patches that need to be reviewed by the migration maintainers anyway.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


