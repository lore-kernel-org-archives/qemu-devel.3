Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B690DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQU1-0007kj-K1; Mon, 29 Jul 2024 09:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQTs-0007jL-5T
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:32:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQTo-0003vp-GL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:32:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so10187055e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722259918; x=1722864718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQT3T6RmZ2H5qvtEBp4V600bTpbpclW5WCf38eHwquU=;
 b=QJeuLEw8J6fPfv9GwFBgzCupY6DoXGXfj/TEbodbOKIWj+B6xnFWbrlOP67fLwhpd/
 WsS7GPjHyenwspi6/B1cAFwuCEqMBTpJHNTeq/xXC1ZOghcwvT7U71atT4+0ujpzgt5j
 MlJ6w3Ao4CSXcFbzERWV5nxyoBjX1857tEtwr1Br9i5XIzQfa/fP97SuAOhazZ/G9XKY
 JdrRRCijzAMq3MLq8V19wcw22UF2dc0ZUyeNNw+e4c8zhyHUjBwKz8hyyknWC69bTP07
 7cWX7bzJDACo5iTBSUExwkh2PtBBN+8eMLUq6X26RMg1/aRnZxUJL5jbPoA3oUQ7IHVn
 Aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722259918; x=1722864718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQT3T6RmZ2H5qvtEBp4V600bTpbpclW5WCf38eHwquU=;
 b=rUJV3oJBcUgtqLrhEAzjQ1744w6+z6OsZiPS1+hPnvDFrhZYa8pNUoL+O9B+tb8Bj8
 Q+hMex1XyFnyPeBA2Z/ckCS9SzaORd4G7kQWu7o8ziFMiJqncsKEUn16LT5w2498aoJR
 H/bIUGn0G8yWEuey7mcZwdd023vhvtTbQLlwWSrkzYfprZ552JOBfB0qajIgT1vc4X+4
 qKXmapeuRjjkof5JCoFZxNThJHTNew+57tIbpu5TK5fhiby/aNr8AD6k9OZM/9o7j8pT
 DmjGOJlSOPX37Wb7m2L0/b75QcA3iZsFrE20OA2kaIG2OAIjLAmThbgaJM4tLJ9jx1F3
 KVHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxIDqxl6TR6znc0v8Hob/3zCcOuBKg+nXUahpEW4tvYWaThCYRiYWzTv+b/h9BRjyPC+6qEkU8fHgdMdQJomQZvrvsnOI=
X-Gm-Message-State: AOJu0YzrKlz/9sZnLv+g8iwHcOVLgUsUCaq49V8Mzaroz3ncNF4yhtyK
 u3QsD460X4jPCZZt7E+Eh086LdkENFatbQoXQjdAETttUuqMYaUAyhkRelA8MZM=
X-Google-Smtp-Source: AGHT+IE5cgvLd+kbGwHgIBV3aDODiXIYjj1tV1CioKxN6XGbK76LVWvlf/7jgZ9nTFITZ3JFg7QiEA==
X-Received: by 2002:a5d:6508:0:b0:367:9048:e952 with SMTP id
 ffacd0b85a97d-36b5d7d00ccmr4827409f8f.18.1722259917619; 
 Mon, 29 Jul 2024 06:31:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574b2c2sm176563135e9.28.2024.07.29.06.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 06:31:57 -0700 (PDT)
Message-ID: <64440298-8a9e-4b36-b1e2-0a9436bd5c12@linaro.org>
Date: Mon, 29 Jul 2024 15:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] tests/avocado: mips: add hint for fetchasset plugin
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-3-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726134438.14720-3-crosa@redhat.com>
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

On 26/7/24 15:44, Cleber Rosa wrote:
> Avocado's fetchasset plugin runs before the actual Avocado job (and
> any test).  It analyses the test's code looking for occurrences of
> "self.fetch_asset()" in the either the actual test or setUp() method.
> It's not able to fully analyze all code, though.
> 
> The way these tests are written, make the fetchasset plugin blind to
> the assets.  This adds some more code duplication, true, but it will
> aid the fetchasset plugin to download or verify the existence of these
> assets in advance.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


