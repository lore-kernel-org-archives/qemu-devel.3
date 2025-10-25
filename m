Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FECCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCh3T-0002If-Cb; Sat, 25 Oct 2025 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh3S-0002HR-3d
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:23:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh3J-0004tv-Ok
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:23:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so1552577f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761409412; x=1762014212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/THI8Hczbcc0cn59hJ0CuKwHeo1aQKviihPhheU+ETQ=;
 b=irQ4ifC5Oc+jb2kNwKCsL8ZDYqowXuBuvWllxEDeiTAAc0HF61tSJdJAy24r/hpdCr
 hccaoFQW+BNzTjCQdPcOsU3I3117+izBp6RWiyeCsX+dIxhwVKQUU8eWs+sTtJ/31x31
 QQ0cwjiAqwc0Js7mx/pcIVhBGeaXXeu0CWYIarUwIZFonYQFTm7HaHL1x2g6ML2ulKEs
 VnO5htsVytEWw9w8bBrR3CnhWYpuZczUchHCBlym2QwWwpJPmXloTbcvsaeVgsKcaG6C
 7cq5JxbsZ6qrnFBCw30YYEahHv1JB4koO8MHDpVAKXkIOc+Mri9w7RvlUpf0LYPrmOsT
 4abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761409412; x=1762014212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/THI8Hczbcc0cn59hJ0CuKwHeo1aQKviihPhheU+ETQ=;
 b=QgfmU/hxpCKp85yEYUhPApC0tSP8TydHIfTdJZtfvtnqgCx5nnOGrEj5IqIBaIQIDe
 XwdO5F5vYZYuM334lrfoY96lnAuErA5BA711ZV30stkaFMk8lMh7Oy87a9whCdc7H6e9
 PI0jRQN0g6vW7TkaucwSl4JVs8xkK/zNrnuxdM1jNsJK97+l5Nlz3indx9UhhIrXo04A
 PdxMpSicqTR+Ut+s03CSJe6YIOQYJzJieA0x2R7t5+OT4/ffX0D724SxRgqQ7cTEitY7
 cmeM5JFuYUN+tnWg9Db/q3zydVIZCm5JkFYLIpQn+rA/hLkkHhZrIU67ILm6x/bBqqbB
 98Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUvhTMTyewiWRBGaTvWFDsfvnL3Vqgi1b6nHRllNalBhT9bGngRsGF+2FWzSnw70uJmeBWD4SoG//z@nongnu.org
X-Gm-Message-State: AOJu0YxhePmAWhFEEXd/+uEm6Etw5i5r0aYig9O3n7SM4t27eGBHyitP
 5vqBjz0U5jhKKV8lBCNvwuS96Dof0sNAYoPpIFcfY+ZG1csYm95+4cNUM0IvbUI0unY=
X-Gm-Gg: ASbGncuq4J7T/isa2b2aLF8TZeTZFx/fh9H+heXcOw3nkZ5COnp4kv3c3a69R6FRFcN
 2VkNG1lA4IJRpuxzq7uxIVkkPl/wW8s5wM4aO1ZklnAVgudehBs0Z6djc/BelucyBPGl4y8kiqg
 AAvQnqfYSGE/hgodpy8dNFRhj1MWm9VwHZS6ETKkoKLzMOjqbv9z7R+jYY3YTSm9FJjNFooOr/r
 /W6JR1W33TGLLuGLpbu6JENPFkUx52lSCriKBxsbJPa8FHvTgaMuu4ZUee0o2PvfwENQS0EKypT
 rWcoJaUvK+lnzYAvp4OCWbNjwYINjFmlbAiHVHHHqRgotK9rjVBibFLV4I3HHMDKuQ54BmVopNM
 DOEKLhJgFoR0UiYckaN38KwAxnWyt4Yw4XjGjl7bN9LwTr33GaT9A++GNzYrFZ6NCpQsUxDoE9U
 pOFMWLtAzX9r+iPf2WW60UK9BBc87rJjaxKL91V6M8LbppMzP2sc9l/g==
X-Google-Smtp-Source: AGHT+IFLAdauE7uX8Yf9dyefVSv0V6ep+jVmQDzh1rmBCPb7g8OdhzL6d33LjjsLUhs1TiEz92s/1Q==
X-Received: by 2002:a05:6000:2284:b0:3ee:155e:f61f with SMTP id
 ffacd0b85a97d-42704d14489mr19878700f8f.8.1761409412024; 
 Sat, 25 Oct 2025 09:23:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475ddcf8484sm18841745e9.4.2025.10.25.09.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:23:31 -0700 (PDT)
Message-ID: <43e2c0f2-de05-4eff-be64-45969c2b1208@linaro.org>
Date: Sat, 25 Oct 2025 18:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] hw/hppa: PCI devices depend on availability of
 PCI bus
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-10-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251025161901.32710-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 25/10/25 18:18, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Only create the PCI serial ports (DIVA) and PCI network cards when there is
> actually a PCI bus. The shortly added 715 machine will not have a PCI bus, so
> avoid creating further PCI devices.
> 
---> v2:
> Clean up sequential testing of NULL pointers - as suggested by Richard
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


