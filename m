Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B0606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ssuEPebv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXnm-0008Uy-TK; Wed, 04 Nov 2026 05:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOXni-0008Su-BS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:01:03 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOXng-0003pA-DP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:01:02 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0a921ee46so4496547b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 02:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786459; cv=none;
 d=google.com; s=arc-20260327;
 b=RB8NksQOapKutHO5IAl+1WJuW+LvHPjltZCchDCTeBAZfbOUxzjD/84l/lt9EZqVV1
 31ZtKDyZ7nKEzYOnulbUNepLHMLYBQHxbWJ0hq9f0/4Jo6/UYyzXVIDIfm1xAvAdDyoN
 nogQPUj6CtTvGxtDnA/L/Ly4MdDYW5pg2uPEUlB7njSbeAzgT9MeCKWvQJ95YlaFyfzG
 zctz2TvsydKGaf0DDJBjfSD7shsjvry7VD3lVDeVFTe7PcBSm/rXSwDLzwZXuwfOoSW3
 snYn32bVIqNgn+bWXMNkee+fjFA8i4nQt06YTJGzg47uTXXNqzbed4hLsMl94MF12Nwh
 pvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s+HeId941ybxFGZv4e0OxN5tln1f4usSxRJ/nkrmvcc=;
 fh=W4f2uhIRq+gJtSeL5hkWjsbwbM818OZHQnjWw/DvbI8=;
 b=rab9aNHyoWT2X3K4QClUFvNsbNwajnm5jxGziRj8nmQk/EzaN9IWiwkJs+KtU2zcNP
 AOkwO34KI+7EYbcv7Cg2/d8dvGmjMiW5xpUl1HFqfv1bKV4oHCNxQgD5Wc5a2aeuJynJ
 Tz5/u10/mGXRHVBq7j1xGBGWgSdhHgFAXvsYCSY4K5yjhSmGffjBgvufVj4egQN2gg52
 HW0a4ZpnQHCj/VT+ZuNZwXra9Xvw60IrdizFnDG5hWpCWIlpvgJ7CStCj29hVgyjFWj4
 Nkjd41g9dllhsDwTCSb9PMKzZipjiDj3V+0NvU9w0FPKnl0Zw81hrFpLTeJh6d/1HKM4
 jkOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793786459; x=1794391259; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s+HeId941ybxFGZv4e0OxN5tln1f4usSxRJ/nkrmvcc=;
 b=ssuEPebvrPmwNlHstRf17ovd4/xSRgi/foAURiXWAXcRzI1P6f8ZzLIhfO5HurlJ2Z
 Eq6Ns2xujuHsdxEnQYiF0aapbtf+EUcL4q9WJ9TDg1BbtwOsq81UhpcKB9kJK+syTooV
 EuEoxrrU7XCso8yVd8+Hh9UQm8KNphMouwHQekRcgxVFR89ulkG+Vub4VGeaqyUoNCW0
 KZmb9WrPFiIi+VnHkyHR4GigYGe5vrjN6znR0a98tbf+0kfNQvkB6D/O1MX+7QhXtcqq
 vhRx9DgngDf39yREWtSPVESgDwIUK4VQOGNhceGFdGkSx/2/J/98gLSvN+mtJF6jY3Kd
 CmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793786459; x=1794391259;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s+HeId941ybxFGZv4e0OxN5tln1f4usSxRJ/nkrmvcc=;
 b=q4yiZl1z5L3ycuMVAjDAljblkooV9cZ2Ac5wkMKuojxg3POKcOnlKy0GtUP6M54BpT
 XVU6o6vkMnhHc+/PCcTRUKOj5We/ucg9lbJAeubIY4YbzUt9fZZqLs0qXO6wVq70iS9r
 6K9gtwpfuvnqJtJoViA7JG35G1qQ0j4FbJn/AEzrrb//RdTZ9Z8a8g161RTxekMUFtFl
 ZL0X1eWmGGvlQm8AnIx1SmGaMHNNB7RjDxhDCAOZ/ry/wQs0mF0DiumKXoAKomvWhVNy
 RnBKgz0nTn0IDFA1il1LkKQMVJqIlrYVeMH6MyMI2ZV8+ZNrMXGZwT1ifoGGdXh1w2fW
 ycDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwET7sORaTW+/uB62b5qCrP56O9q/aasVFWK0mhC8eCB9c6y2lHBhXUpj3+CxPpy0byHHi564FKqSVN@nongnu.org
X-Gm-Message-State: APuU4Z/RLDbzd1sfhevFsxYNSmfr1+ts2TXkeQ6WsZ0bCrT30ii1bUE8
 bPpww/Zf1ELmq+YKWzDSGhnNX/dmpNi9ei0VpbeU0yiuDuRJOz77Ud7UkiIqwBlfKtk50a/YliQ
 mtwRtuX1MQIjoWXviy9xpw242i+BNVUJdCtP40ZhKIw==
X-Gm-Gg: AYBFou1S9Zkz540rAtxSxkafkvR4N7//bBlX4g4u6/FXxHlxrfYndUZqajD3QWYA8nD
 QYidgpCFagSoeXVMNz14joM/GjLdyaOFJsApH6Bh+RhnyetS5orh155/1JTY6Avv03CsDJciwOK
 wrQTMLLQHOwyrbewJPG2LJmuTR/4goTll3Hd8+D1UQTGRH97VKeYd4gHG8qSQLlb0luFJV40sjR
 f6kOxFTQudXZ8eu8+NoqyvVO6n5qfOl6uBP8upXEZaj8Ze+88suvwqxk6DvLCH+qtcz63qxJuyI
 LTZA6WYHRSKlreXS6oGhDH6Dl22DAmgLaHdDZZeW/kfp101xJG/RGSg9Ew4vl93DEW747M7+Jhd
 c8nPYtV06wYZWcMT0+9ezdUNgT74D2cSKZEbfrmgmkK6/yHCkhAA1HyzWoy+dI+NTXimQlsSVkU
 V3ida0G+fKSkkylAEp6Ya3
X-Received: by 2002:a05:690c:6605:b0:8b0:76e5:ed0c with SMTP id
 00721157ae682-8b2b66f82dbmr93165377b3.39.1793786455974; Wed, 04 Nov 2026
 02:00:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103215430.703404-1-sw@weilnetz.de>
In-Reply-To: <20261103215430.703404-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2026 10:00:44 +0000
X-Gm-Features: AclHuK-pvYrM5lr8SkoWXQbaH6D6-RRK7zKRafTAM0ywZfKs1x_Ic0O27n-Q5pk
Message-ID: <CAFEAcA-ipjU9q_NmWYhJsZSC6Cn8GH+G0AsxWb5_NYUDryCRdQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
To: Stefan Weil <sw@weilnetz.de>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-devel@nongnu.org, 
 Hui Peng <benquike@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 21:54, Stefan Weil <sw@weilnetz.de> wrote:
>
> e100_nic_realize() registers a system reset handler via
> qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
> unregisters it. After the device is hot-unplugged, the LegacyReset
> object stored in the root reset container still holds the raw pointer
> to the freed EEPRO100State, so the next system reset invokes
> nic_reset() on freed memory.
>
> Instead, define a reset phase on the device itself: assign
> phases.hold in eepro100_class_init() to a wrapper around nic_reset().
> The device is already part of the resettable tree via its parent bus
> (TYPE_DEVICE implements the Resettable interface), so no explicit
> registration is needed, and the reset state is automatically dropped
> when the device is unplugged. This follows the approach used by the
> e1000, e1000e and igb emulations.
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> v1:
> Initial fix, created and tested with AI assistance.
>
> v2:
> Removed nic_reset() in e100_nic_realize as suggested by Peter Maydell.
>
> I did not replace the DO_UPCAST macro by a standard QOM cast which
> was also suggested, because I think it is better to focus on the
> required fix. Replacing DO_UPCAST would be worth a separate patch
> (to be done later).

Ugh, you're right, this device has no QOM cast macros at all
currently. It's clearly very old and in an ideal world could
use a spring cleaning, but we should just fix this bug for now.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

