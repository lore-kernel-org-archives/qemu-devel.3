Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8811FC369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LmW-0001eX-2r; Thu, 17 Apr 2025 05:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5LmU-0001ct-7b
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:43:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5LmO-0008Cn-6w
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:43:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so503614f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883010; x=1745487810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzQqhBqYOTr8GstfyP2yaciNFWnEfiFwEJ74ULD/3WU=;
 b=TkHaxpfXGkq4GU17ZhOFEtskcQRIUugRh772ORF0q7sWqW9om0bJQ4sflZBh8VzokW
 qVTfESbRizp68pQAyMMfQOLhs/Y58eLEtuzpmzgFNWUvJ332Nr1bTp8tH83yfo8w9aLu
 j/APYXnyP4bfaOOBHkl6Msvzb5NM9Z1y9kdd4bQIt8PGw7TcsnIM61AGNhvz8KC98bvM
 V9fkdqoDtN/5IZ/mqByOjFaBZgrz+f4xIludw9VWT8KAC87Bd1xvb6b4xzCv5a7NeCZs
 GxNeYNvL5iTUn5BxqMld5etAeAqmmWVAxTKEkkbg0OH+NaXLTFMEuicXZr4PMhEG1+We
 SSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883010; x=1745487810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzQqhBqYOTr8GstfyP2yaciNFWnEfiFwEJ74ULD/3WU=;
 b=JEr253VJq8VeycdnTl1M5yYb+iGExKCE9XOVw+jfj7AtKd5mUwm515u5xjx65CHUrI
 EgaYYs3IXG8eFLfSRUOKlyzVnUBIAK+e3Nh5twsH6JMqtjx8YlbfAc44J0xH/yQ8QKup
 lWqN8YCny2rWTRTjNQx3kxItUyDTiw7R/rigc4sh9XFRiTYrpXCNPeqoMH6rEBP+A3gR
 whv6ngKL7JGfRRREg80SKywu6S1MnIUjH6pXX8sruVyjSMrlEQ16rPnldDMZUbDCyw42
 /YfZfLobJg4ClgNLaLeErJSbPvCfKW9d/3BCag3YgbW9aVdrz41GXtHUEvKV9krSLWrc
 9soA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRQhnxV0WsRhwnRvj7P+O8YdrCPKuAlK0xBd7NK9mRUYTHeOyHz6kWk7mUPr6nEdSYlm1T7mriWt/@nongnu.org
X-Gm-Message-State: AOJu0YyVIzqDzYfq9nMKB+d0PFn4pGdoHnfVvIFR5JGvSFGr5f3T1Hk5
 em2SxwsSSFTUNtLWSYB8cU+rSeekPa+ntpQQEDVBF23O6vKHXd1CHuFMxxyjZUM=
X-Gm-Gg: ASbGncvD965lYf7AX614l3KRyQsrYrkMvoyfxP7PQDTe4w+5EeisQ4XPn58NQ7FS4qG
 uweiHiWvlOC20qQUjGDhgkNomsSqzSYBPbwnZ/StxTw0mHa8LOs0ehzl9+Lp2C2NFjgvrgC0fzD
 b1+Spx1SAhPeVLE5yQF2swnTfgJm5gnq2Y0ldgvy4arb0Ywz8A7CLlG06TizrzTFDoFTTSKINr7
 M+9NM4BiwquJnwpbZuPwZ5qHn8v8UUTMiDnCYuw9bml6n7UYP7iXGJTB7v8z0uWakCx4BftuxS9
 QTKqQLWv9fNPszf8Pe+tqKcb3RAMFBTYpl1Uex7+X2D8H1g/IH099kbkVdZpv4kbeZ9/HAZp+TE
 BbLOgF+Bf
X-Google-Smtp-Source: AGHT+IH3mJPRgXPE9V60y4Y4EQvtkPaQMgZKKvNY2ikQDBGp9nXMH62FlAKNtu9q4OgmSEryIpjKHw==
X-Received: by 2002:a05:6000:2503:b0:391:2e0f:efce with SMTP id
 ffacd0b85a97d-39ee5b0fec1mr4788330f8f.1.1744883009631; 
 Thu, 17 Apr 2025 02:43:29 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c05asm19246183f8f.26.2025.04.17.02.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:43:29 -0700 (PDT)
Message-ID: <8c6d6586-1d0d-4047-a9f0-34815e7ed00e@linaro.org>
Date: Thu, 17 Apr 2025 11:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest: Add libqos function for testing msix
 interrupt status
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20250416145918.415674-1-npiggin@gmail.com>
 <20250416145918.415674-4-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250416145918.415674-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 16/4/25 16:59, Nicholas Piggin wrote:
> This function is duplicated 3 times, with more potential future users.
> Factor it into libqos, using qtest_memset instead of qtest_writel to
> clear the message just because that looks nicer with the qtest_memread
> used to read it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/pci.h               |  2 ++
>   tests/qtest/libqos/pci.c               | 48 ++++++++++++++++++++++++++
>   tests/qtest/libqos/virtio-pci-modern.c | 31 +++--------------
>   tests/qtest/libqos/virtio-pci.c        | 40 ++++-----------------
>   4 files changed, 62 insertions(+), 59 deletions(-)

Nice cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


