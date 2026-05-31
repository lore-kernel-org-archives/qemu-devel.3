Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652ACD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 22:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wToQm-0001Kc-3g; Sun, 31 May 2026 18:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wToQj-0001KO-Rk
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:14:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wToQi-0007US-G4
 for qemu-devel@nongnu.org; Sun, 31 May 2026 18:14:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49041e84237so76975965e9.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780265686; x=1780870486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MedXYkZ1AjWr9/mSPPkHwabBTdE61L5KEQguZWDlotk=;
 b=KBd/mUet/6doLk9rZdMDVht0OgDPsXfvYKP+ssmvrn+KSpjDbcB5pLlJiiqqW1PZUd
 ZygR1ouIf34r8qhKbMIyw7czhgT8vspiGd7s1soaSBtNvyvs7KtTmDzBchkG7aXwaVDh
 y5/z7apNqVQNVFpi4gB4ix3EVj7AC7GMslNsAzb7Y1ExVJFR8i2YCqpMgyt6zM0qMTpl
 ywBo/ef34HIECpo3YLo6BGduxu1C4WwxrD8+2GFegxacwKtxwq8KzXV9RoMZctv8TxcX
 ReTd9XwS2IevBC61Zc9EizKCgMPe/wD+DnMrrhMzHWPLjbCBV9ZscD8g4vBf7zFhEne3
 VAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780265686; x=1780870486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MedXYkZ1AjWr9/mSPPkHwabBTdE61L5KEQguZWDlotk=;
 b=ilxZXNUmcgWb1IijrqwpsSDq4BclcSGWUssv4PHgxkgc5/IYXBeimkgcPxzZtxx+0z
 UMXTxRkzkcxPYZrcNTJzFNWu1gTsw0ujujma3bqZu/6YxRaeEFrIztupQ3rHtxiC7bXj
 d3lFNZ6mNsLzgiM97CAxk/pCJMvXubDOMZuJmANIzvOJxbKwWEGIAYa5JX02Vggj1xgL
 X2dbtLJ5I8SRnnpAPgfC6PZxcF7Ie9sOP3LGoTm6tV+zNWDLkWdc/7mbr1IwQStCb0or
 Ub+UEng+rn9VpxTaqXtE+PhuNbjkNlRH+L5jdAiybJjuHfdOfJiBJmOEWBOYN7Cm+XIO
 e51g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n2Omh6B2DVZofCXTsrbPYMBDG0gSk5C0kdLwqbe0/xS2jzpDS3u4eAgzIm2Kx60KyHLlSB9JOUHwH@nongnu.org
X-Gm-Message-State: AOJu0YyXEr7ITzt7wWYNxdwL6pWtAs9KxFq9409CRsjyCj8IPDc6QPSs
 BuLqQNddY7YNEDiMCf2MKRz2bxosXBDbbDZ4Xr2nC/f28Hu7soVSsS2+C8dpzBWRCxU=
X-Gm-Gg: Acq92OEi+CN3ZW+A+a+zgAeU95SJ5ZV8ha5qo7ljKjW9qkT/+IIDAqR2C2WS35R0WVp
 x69YEBCHIk9mFjm0KuDdI108mi81oIORpTY3ZfMvh3Zz8+Mxbby/0deNWt+gNgo9/Ra4WKidSXs
 u0QmnLYseernbKLDfv7IbiAmgLig/W1FCCRYW4KrhHS8Gw8vRcaxq8tl6pIgcgVM3niQOPsW+g+
 j9RjsZdJqNQbEv5OgZBfq3IiBHlb3mlV+ACurS2n90XhuTO++7xy2DFNtPwiP3TVZqF2Apw6cWR
 H7ryY0YxzyZXwIMBeOCmj0U6QeiAkdWsiSpR7FzumdSMqVbs8DaTOCqedPJruYT72AKLgXYZN0V
 E3WyTH67Y0cNb5yi58wJcmOrDruj5u/ZRWmefTSvdmOy+TEZjt68bOj3uFf+7RXqXerGZTEIvrD
 0jGV2nhFxl7Gj8Qca2Xw2XgY9EipiNO5TzeNM1LGJaQDCb5zFo/VNA423TtzdB+q3TPM/iECwKh
 zPdFTwFTZ2XD/4=
X-Received: by 2002:a05:600c:4f83:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490a2a49218mr115537915e9.11.1780265686570; 
 Sun, 31 May 2026 15:14:46 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909dff2a80sm230694965e9.3.2026.05.31.15.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 15:14:45 -0700 (PDT)
Message-ID: <0a5fb24e-4d75-40e3-947b-a17d31731a33@linaro.org>
Date: Mon, 1 Jun 2026 00:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: use debian-all-test-cross for mipsel tcg tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260529181713.612230-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529181713.612230-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/5/26 20:17, Alex Bennée wrote:
> Although we have had the mips compilers in all-test-cross for a while
> we had been surviving using the mipsel cross compiler image. However
> when that was removed we missed updating the container to use.
> 
> Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

