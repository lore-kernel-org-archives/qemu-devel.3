Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD27E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdIg-0000S3-4Z; Fri, 03 Jan 2025 03:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdIe-0000RY-6l
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:44:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdIc-0006uf-OF
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:44:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso79390355e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 00:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735893892; x=1736498692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iI5lyeQHnmhMvIXJza8ZDiOiz/tvGmc6CQsZplQtXjM=;
 b=ORomXZYkocW8XsuV3vX2VTq4EkzwKJvtvcmQRxHcgzqt6irdPZ7rzIT4EOstyxGihL
 00TL28U8AQ86mGDRPG17dFLgrASrXMj4vrTNS1V/UxKgwPaDiSPUSxWn4m31XQeRi4gj
 8DZ2o/ky/6f1OB472U/fjlno1lxQHCR11KFk0J8xymcnwNSjn3qSVa7aL7KDycm/xTV6
 ECiDzHmyeVV/Rd92nQ20pGBFnQHb3R3JwdGaStaDAcvm6tUc8wSbqxBhb1ry+rRL3EWt
 TsB2AnOs0i8BFh4qT92QyqEJA/U57yrDoAdjIpiKbU/nPnRGs3Sl83dK5y9ml77+Cw4V
 4SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735893892; x=1736498692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iI5lyeQHnmhMvIXJza8ZDiOiz/tvGmc6CQsZplQtXjM=;
 b=CdibC1BuFlrUmj+8MSt3/kcfgfz8DCCHTEy1b4AuSINvz9w9i3KX7BCuOPy3wTLxbo
 luqbWtgzwSXh/0b1Mgvsv3JSSnKpr9BBM7RgOk7auGIIIBfA3GIpBzopHJ41rS/UTuQw
 WPrF7ETnIC96h8V9879Cc8fWN3n30BMsfUmV8vuNyi1v8EeWYo+gW0WKKuB9+MykavIA
 S7RDFijasSB7eVcm+9mutLXWB72feQKaAevB1wM2coDhlQHU75ysisjFLQfyCDHZ6trk
 qthFpCEoDmuBGmhNKL++My1CtDv0gXOm7YEIj0HYz27/voQgBhYJv5Ldh8oIRuhzRjZr
 xo6A==
X-Gm-Message-State: AOJu0YxggOK6LT2outD9oi4ZMQqo6zD06TBxsGPRZZm3TvyhfvB4WB53
 JFEJbzv6usrbhuUUxzTXYsx6tAFhfTurgs15+lm/HXQPYfKNjBp6wZPZnudjqop//toNlCratRL
 ZAZeniw==
X-Gm-Gg: ASbGncvcQpiq/PlO/tQaMkOqmCH8Gb5IYwfOG+CKvlFsku07LXbmzDOO1PzECo10Nyf
 CDAEK8WzEaYE1ewql0fJaf/QYN+2hBSxsPPvRXnsueXD8doA+gbT8spRc8DYhOzrFUDV/qEL7s3
 6Tgsi1Np3rgn9c57pKIEvrKyf3eI8GE8eUtej5Tw+kQ95rGXUGfIVgbN0/ayHSdbQKnWg9qDthW
 Enjf8F6M/Leb4LitmwhSh/IjjII7IExEQ+mSYTnbkHiNutO7zI7NnXqvbnI9Y5zpp7KHu6UR2Qh
 avaEC/NiKAUM21ZwW9gHGTgK
X-Google-Smtp-Source: AGHT+IGdJiePKpO47xV78O7mUPiKOzLdglLt7nk1xErUEuUp4QKgXbABi9SKNArZ4haLE1TbDeDVNQ==
X-Received: by 2002:a05:6000:1f88:b0:386:4034:f9a0 with SMTP id
 ffacd0b85a97d-38a22408cbemr37514863f8f.52.1735893891604; 
 Fri, 03 Jan 2025 00:44:51 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366121955fsm483801365e9.21.2025.01.03.00.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 00:44:51 -0800 (PST)
Message-ID: <5d2a536d-9b68-4b31-8d92-6cc42ed72e5c@linaro.org>
Date: Fri, 3 Jan 2025 09:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Cc: Bandan Das <bsd@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241211233727.98923-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241211233727.98923-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Fabiano,

On 12/12/24 00:37, Philippe Mathieu-Daudé wrote:
> Replace first_cpu->as by address_space_memory.
> 
> Philippe Mathieu-Daudé (2):
>    system/qtest: Remove uses of 'first_cpu'
>    qtest/fuzz: Remove uses of 'first_cpu'
> 
>   system/qtest.c                    | 53 ++++++++++++++++---------------
>   tests/qtest/fuzz/generic_fuzz.c   |  3 +-
>   tests/qtest/fuzz/qtest_wrappers.c | 53 ++++++++++++++++---------------
>   3 files changed, 56 insertions(+), 53 deletions(-)

Ping :)

Tell me if you prefer I merge these patch myself.

Regards,

Phil.

