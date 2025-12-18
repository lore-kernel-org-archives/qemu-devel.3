Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11217D68BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW859-0006uq-TU; Thu, 18 Dec 2025 02:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW855-0006uS-4P
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:05:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW853-0000tZ-Mw
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:05:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so2913895e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766041543; x=1766646343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrlebsBcUbAORySaEmHXTsxN4ZJUy1eehxvocP1mJ98=;
 b=uhDwrtYDQDTMoNyRo1GNnM37+Ypu/rVl8ndgF0ZQ0xSlyLMhOhxkEDOa3ivTBzPwl9
 39Qkq0bWNHcf6s9sjxLPPHYwDpUnMu7jWV8tTRUjHnNOX4knE1Zz0D0iwOUcE+ioeCI2
 XjcJT7FDEpbkG3Vlqx5ru2N7WGhvGGPuKWvqWF54s/l1sxyNbF3VrrBtB+JoeV9ZyMZt
 lgErxMfQoqNtKxjdb+A90nvGCTNntlpvtGy0kh3ZxkhXzovFl/kSKW8qzoJTQAbbDbo9
 xPEEqts2kMmGX+v2RKrg8xxT9glM3Ne9XZbNNmcYX6wtNwvk3MHXWzhdYlXWu4nSrHXE
 akFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766041543; x=1766646343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mrlebsBcUbAORySaEmHXTsxN4ZJUy1eehxvocP1mJ98=;
 b=ton0vYxCqS4vEnlhhXae2mfHLsT1EdhECF6Axza/tWPjcUuA7VdzM1mi5oowffFBkg
 i6tyZXScDlkap2WT4uRuLq0FfAOjz43js0slcDq1CqpL4V0SyyxQjD4nlva4imoGMeeQ
 BCGwjtcPfOJswTFxNUsc9VniJrueoolYUrCoe9EqXzh7FYFOUMUnVA6sDPK05YuA/Qry
 PbHn156ivSQoubn/ABQVkZolceti+lB+DyVT27MhAEhCHstyClOAHsYrI1Z2c3/v2A8G
 XPudL4o5xBRAfw4uiXau6gtErf8WNXSzgh7zBkKvETjNSt5sTqZyFt5eYFzJh/rYMutw
 j8RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZoXMsvutgwrqGfj3WUkVi7KQBPtAV8hpluLn2V/42QmtPzetS23k4sg+0vAx10s0P2iMCCgiDmdzV@nongnu.org
X-Gm-Message-State: AOJu0YxtQahJcZ+psAvENqVFf3JFMqfaK5w6ADloFW9kzit+vffNBjCv
 me4XNgCSkbU2g16T0o6t31yjufZWFuVe10B0mlbpVpS+iswkupaWGCB94qHtKjquBHA=
X-Gm-Gg: AY/fxX6mak+njwf9VkkI9uWqKTDfBgaZdppxW1kMbtZvhpRRgzx8gTgvipqfMo/R8oI
 iO390dBc5sDd5+dBOefdeBdAXKupkpcDwoXtt2I3eC2iaORl4XWEXVBHq3+d28SVAwXHhOLHDTw
 0wqOqwbnYagEGmDNd7nuq/t0EcIEXUBwq801+Qnek1NQezz2pPVfdJe6lw8z7eBVLqw0weKZ60V
 elHwqxD0ByE7ruSCjDLr3R3O5F8P4PU7g4/bFhCfjfwIpumcrEQ5fX0kRGh3FvCuYA66lOV8BZt
 LqhpUPHTVJwnEgqrZ5waHXV2XBwsZxfLvGivn2nzd0nupE47lnccsIupv0YQH2eo+XAEa0qR3v+
 QXkml1E48WLIFCkPxmrLkkaoHWxbEXxn6XdsKgDZYH0KYkOkncxA0kb2Js9AYL6E8zHVr+c4mCp
 i5VzxLcu/0lZVpok/z/CK+gOpyUkgoa/VBvIySSaYY6awt87SWzUfRnniYECL2p/eR
X-Google-Smtp-Source: AGHT+IG+zo7K/BGm+h9JFGiJxNx0VhgJxss3Oh7avV8ynwi39GXZaGnJI7Y+/TA9nZjCWSBen+utLQ==
X-Received: by 2002:a05:6000:1244:b0:42f:bad7:af76 with SMTP id
 ffacd0b85a97d-42fbad7b0c9mr20763155f8f.15.1766041543257; 
 Wed, 17 Dec 2025 23:05:43 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244934cd4sm3278938f8f.7.2025.12.17.23.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:05:42 -0800 (PST)
Message-ID: <bd0f3903-a2c2-47b5-be21-004efbe37c43@linaro.org>
Date: Thu, 18 Dec 2025 08:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update my email
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20251217191726.194767-1-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217191726.194767-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/12/25 20:17, Daniel Henrique Barboza wrote:
> Also add myself as a "RISC-V TCG target" reviewer.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


