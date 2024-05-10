Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E851DC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MNW-0002hO-MQ; Fri, 10 May 2024 05:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MNU-0002Zb-30
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:17:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5MNR-0000Rb-UP
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:17:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so18259025e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715332635; x=1715937435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vFho2fKDG0hRyOS6vufwIlS0egOjLZqm6sKixgtyUhw=;
 b=fTcNzR8nm6NJHk/zm0YRGiWw1/9Vqi5wWEu2ajSr9ZRkXakAFBcDICfPOwa/OXoWW9
 7D1gw0wvvlsL+tVPnXpR2ZGKvr1Y6VCZplLLxYhUlDtV09Nluu8QZyAZbJPIh3IzL84Z
 kpl3+rssT1q7/ObjwZT6ualpQLzsJ6rxh5X23FtlaF79x3t1vEYdHVDvhROeSt2XmOPb
 PFP9CyMzAXmq48npLnYrF8+GBJtah58hPE/ju2i6tUY8uNsXWwc2zl/wDsJUTBdJW/2c
 7dyTowO8JLynxzKabcp3h2s6MG3HclYaZAqFdUaK6h82HlHXcixG2zlhQVrR0StetNvo
 9wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332635; x=1715937435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFho2fKDG0hRyOS6vufwIlS0egOjLZqm6sKixgtyUhw=;
 b=FEun+qxrwBv2HcHRs23oNfuzj80tr05g/fwVm73/R1BiNNFrirg/2ZdMhvSq6as+se
 sfPYddf04ijow+zZiAsh/Aj/K+sRRI0IyinvkoJr8uYM1eiSm/tvMplcQepfebQP17ep
 F1VXlMnAo1YwdyRVt/XOwvN48XHOIW/ma/hv/onktCAlDLKGGfJ39fL7rM/YgNGmgMMI
 GE8vSNmGHvFR28znk+EkX0aA1znrJkvktM3sAHgLFyySwRF9nHyjpRGulTD3D8Ngw345
 00iccQ06sTng80BvztBMR7RTV4NFMi10bONeu8mqff/szG9Vr2K6lFaJGbhwkeM28kzA
 s+qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf12CBuy+ssEkLeoFF1TqwmcYYHUyLB4H4W3+zhqusih5hay3vo5PIP/dsMUVShWbuMJgRegE6QvX1seuRloG9Y2vj+do=
X-Gm-Message-State: AOJu0YzML2uTLFMh1mvThO+BsiBk0vXnUNPjc+4BiP4/Fg9WUkOptmDS
 EMZ3Ndgj4NYV2+/tnFAuaI9KwgrAGj+LE5b2QgzNGcyj6oKrxQtxX56zdgc1aE0=
X-Google-Smtp-Source: AGHT+IEvN0A9Zf+FRQ7cW9HFuAp8X1mqyDRdEsgbKwSZMieU5hhuSxdCvqKS2mwEcJDkoA2p4bZZ+Q==
X-Received: by 2002:a05:600c:26cc:b0:418:4aac:a576 with SMTP id
 5b1f17b1804b1-41fead64fdemr19515215e9.39.1715332635304; 
 Fri, 10 May 2024 02:17:15 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a11sm4020574f8f.38.2024.05.10.02.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:17:15 -0700 (PDT)
Message-ID: <7a9941c8-d34e-4631-a48d-8f7dee1b2093@linaro.org>
Date: Fri, 10 May 2024 11:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] s390x and misc patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240510064001.26002-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/10/24 08:39, Thomas Huth wrote:
> The following changes since commit 36fa7c686e9eac490002ffc439c4affaa352c17c:
> 
>    gitlab: Update msys2-64bit runner tags (2024-05-09 05:46:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-05-10
> 
> for you to fetch changes up to 0d497106a71a3b17b0228cb87922ef794296cb24:
> 
>    tests/qtest: Add some test cases support on LoongArch (2024-05-10 08:34:29 +0200)
> 
> ----------------------------------------------------------------
> * Attach s390x sclpconsole to a proper parent in the QOM tree
> * SCLP related clean-ups
> * Report deprecated-props in cpu-model-expansion reply on s390x
> * Deprecate "-runas" and introduce "-run-with user=..." instead
> * Add some more qtest cases on LoongArch

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


