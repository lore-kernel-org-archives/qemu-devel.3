Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B869CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 22:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsVNA-00082b-41; Thu, 04 Apr 2024 18:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsVN7-0007tQ-Tv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:15:49 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsVN5-0005C2-0Q
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:15:49 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2f6da024eso552729a91.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712268934; x=1712873734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdI+gYYmCJYGyCDKTeICD5A0y7TADwITpPB37wXZFxw=;
 b=gnZgvcGCqJByM8Ci2+2aYxzpFMpR7oX4N+Y1BWiLvsPiW5pgi4ynLg1/Pa1nxTon9s
 EsKpSeBaHxS9ztfjVcm5w/XID4kargSMPhv5qBmFwknmr8oxTgN8CkvW5kcj49BGMvAj
 3dl4hWMjgKuKM3t0QtvslwyeBN/NPi0Ejnw4Ap/jMgWaJ7cPk+CprOr7l7Wh3JDINeYo
 1nnPOv3mGmML34/DmFsMT5P2mA6cUdhJniSQyQcx6Nl8xFuV/T5eTF65EbB2gNqaCsuW
 9XTS/wL7Za76RJaE0OjlFxwu2HRxikfkfoHkKQhF1Rcp4aoVUP7rGplvaGhOM7wO2NCC
 J7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712268934; x=1712873734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdI+gYYmCJYGyCDKTeICD5A0y7TADwITpPB37wXZFxw=;
 b=dnvWhokhiZPkcuPCcA8Ct2nG5Eh05vjaYbk3oT0tssfCq6EyLxJgFsubOuPAZmep9K
 PYVCizAHq/df0HdaAZpSTASECKNYJeiKtoclHRwa+C01DdQIfK526Qug8n6O5SOm9NE0
 2/w87AuJ2v6CL5nARzNkI+/osRI9qy0tN11GwuHoPjICrhdC5qElhE/8wRYxZm4uJ49o
 YLNqxnFTbuxXklmXTe7sof0O/mTmKdA1lDkWLNIEOFTuQHf+gJUJycJuwwM9aarShmmo
 MLVe/kOuSY8F1VimT8stph5J18m80ROglWpY/2cxQZp8yfFBziErZfnUYsvv1anYK+/C
 IN1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWElZJk870+u2G6R8H4/0aISwonNHy5Qy/hefRTPQRfj6Q6tQYntWP1OB7ZiucExCsKBZ+zztqP94051DBr+ZbY+qO7h7Q=
X-Gm-Message-State: AOJu0YytNLXPGFmH3uz/9pRLLwZIzzfGWUHMmWkFDEKWY47ZHfiwD0rq
 K2076lIqT5GeBWmAkIG6I0mGVYU6l+KU13+4J3jJDo98O+5pyTmbWlvGbIrPOBI=
X-Google-Smtp-Source: AGHT+IF9BGIOw6Bni5w3z3WivA5ox9qAy3RXXyIaDNZUFEQtkTxxh1eHmX4z/kh+WmX7fOr9ahkeIQ==
X-Received: by 2002:a17:90a:d801:b0:29f:66e2:d2a6 with SMTP id
 a1-20020a17090ad80100b0029f66e2d2a6mr1112955pjv.26.1712268934540; 
 Thu, 04 Apr 2024 15:15:34 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 mn8-20020a17090b188800b002a1f946c65dsm201127pjb.39.2024.04.04.15.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 15:15:34 -0700 (PDT)
Message-ID: <72358a6a-9005-4155-9a87-9ed7b53f1449@linaro.org>
Date: Thu, 4 Apr 2024 12:15:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 2/7] yank: Restrict to system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240404194757.9343-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 4/4/24 09:47, Philippe Mathieu-Daudé wrote:
> The yank feature is not used in user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   util/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

