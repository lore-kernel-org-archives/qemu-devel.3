Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E687CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnCU-0007GI-7v; Mon, 22 Jul 2024 03:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnBn-000439-Lh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:10:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnBl-0008Dp-3Q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:10:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso17977485e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721632226; x=1722237026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3C5LdFld23QJZTnpm+OZsFcLc+0U0BjbOZ/gtJ3vbyI=;
 b=ajM7sJwrsn/R2szZhABN96yMJQT4dozC89ah2guJDKcV9sF+3ZxHgqrHvmuVMHmNcA
 V9dZ+fIfGTCl27HMAnRIadcCUBGEvelgUZWNMFDF+TTnSo2rBMhRfHf+CYlz7gol6Y/O
 YTn3nKz5t7G1yeNwPgkK71Aw3HyhUTY3OWu6Fv05kW2qQ75bZxzKW4ULB23fYpPDETz6
 mhUgSO4WURQN1R7V7G63i/E0V3SmJaB0ZxlWguS6j2I4fmbrQHvAFN0wYfTxy25sqDcB
 8fQ8H/w2Tf0ct2FgWTtxTocmbZWtfIVuhD5qyMHHUEHb9UNjJNaw//g5k7gaIJsdz76n
 5tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721632226; x=1722237026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3C5LdFld23QJZTnpm+OZsFcLc+0U0BjbOZ/gtJ3vbyI=;
 b=hCTjp1YSyVzeuu/iKZfJLInUCSrKDi7k4uTxnPiAqprk1tgb8mPmdHwL74BGa7l7Mg
 nTZWYHqjB5aQRL2Q99is6fLLr/v75tT1diG3DLHpEp/9cLYWaQSHDuVjW1sFmyzOrv86
 LpM3B6hOsUqjg4CB5PgqoiWwPTV4kJjOpdvRXfdd4QeoMdOVA+tUTPkwvJFtTvcCCq4a
 0ekPe9a87mCGeU1GUBbggwZWmIWn2XVA1yPrCkJ5ZgyDwqOrp4df96B+SHciy2oWJIbN
 LXz3nXgVHCOrMHl7CeCgvHXWr4hQ636FXocUAoTEySnvNPL4HzsAaBngpD7oTpXBAXwW
 O4iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1BmmUzSgWAs7JOyolfAF86+Ob6UnjYGMUv029cR/IHMJ4ekK/snrV6NGBn1CctsKMZ/T20OfJXNFxzuaqFu+yQI44KYk=
X-Gm-Message-State: AOJu0YxScMAo6V9icoX8yaJEyD8urfCU6S1+TpEkdx8ZgKlF6ve6zurI
 XeFHYrDt2l2RGpr+kibJu+W7xddag+KW+k2frSNGkr8bqXImnztLj6XJ3zAVj+0=
X-Google-Smtp-Source: AGHT+IEgj7g3sDit3zTGeQZnXWaP9laQtl44tCzcp4hcbSVCGBllyqdrXMTtiitnFz2PWZ246ec1aA==
X-Received: by 2002:a05:600c:1c15:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-427d2ac0092mr75557395e9.14.1721632226390; 
 Mon, 22 Jul 2024 00:10:26 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d292077dsm144297855e9.0.2024.07.22.00.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:10:25 -0700 (PDT)
Message-ID: <40355ff1-9025-4501-b552-f3e046e2533c@linaro.org>
Date: Mon, 22 Jul 2024 09:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] qtest/fuzz: make range overlap check more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-8-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-8-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   tests/qtest/fuzz/generic_fuzz.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


