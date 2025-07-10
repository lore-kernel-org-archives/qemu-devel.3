Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C300C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZszh-0000Q2-Kx; Thu, 10 Jul 2025 11:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZszW-0000DE-MM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:15:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZszU-0000XU-Lf
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:15:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso1137260f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160514; x=1752765314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sffuV6RIb4hQ/6kzsrOBnM0BsSy3hksaLNByAe6PK+Q=;
 b=CUg7vpCRYiZcFzGlaAiOF0Lc7m1jmt3o+SHrq5YkMGeHraa6Y1H2KB9WTsFImF6+DR
 COBfu8bIWehWrQcf0ejmfAnExmDXJTNGr5oRFavYV87BF2QuLcaQPNWFfEJODXQLMkfH
 75MtyXo2NOdyYxttY4vSUYIfAjuhF30RRs1e5GH9bcN+nvXAN1Ntig3F75wdnUSQj2LS
 QBlOsYRbWYa1gjBlvU2p6FzJBQMWdMcmAbmDyWCu4HkRZg7uVL1lJ6h7KuGvsFsPDzlm
 7fsSX8bnarKHA/P/i0sXfQ6yeMBB85tkr/wgchEbWmWr7G/bDYBnt2/joiAdroLeEltW
 3+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160514; x=1752765314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sffuV6RIb4hQ/6kzsrOBnM0BsSy3hksaLNByAe6PK+Q=;
 b=jZQxK9uVJKCUjh4sIES0iPrRhoIbUPagn4aGRpTWYAU+6JI+r6RUDT7c2bcPg0YQNl
 MOb3NYwEXJieuzTSCrtX96azaTlocDt8xLsxImI/Wa0IpzMGeG41a0FymPoIQ2A/ish2
 GLYx8Kwow/Afu4YbIlDaBIW8VI2yhNLM42SmOQK8RNq5WGVhiN/gZ+DIIf2FGzcCwGdm
 KwctP6vD7uZgY5Axo2VZQ/T07jBPQV3ON/paQQ2ZrJnmiS3xFEi98eYSKtT68oLVwq2V
 fp147tWrpnisSlD61zHjzMERnoaM+/SdK44Mg/7Q+gMtUokSH4ZiFBzClYnpgfWtIoE6
 GT1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXorXIXHysczMDYG2tyiw1EAJDzW0TmHs/eGnofYAXPYp7GK4POgjQjFo2J1Pr7jqEQxgGskhzf8jE+@nongnu.org
X-Gm-Message-State: AOJu0Yy+WBDL/kFBNhl37ciypE9cSdZ4tMLeTuwNF6snawYq0MjvIJns
 JCv0KiPmEiAcvRV2ZvX5CuZGenKQ0XuQ75Zya9XSXEHwdpr/ltquCk+dnEOI+iI7q7w=
X-Gm-Gg: ASbGncuuBHUyesgczDVEX2Uvbc4qWgMcU5Gzm/1BLxIUwiHb2Zl2w+6KtmXDqjT9J0g
 MXQ9ezjFSHYkJJ2PeB7dPALra5ZqgAYL1qjXdI7sQoDVk/sFKOTMdPekMxeKq93yXayk3DUH6A7
 ZfJJK0ZwnM/vmfI+THqUnizcUK2QUzHz18H3Zkb6JX0ueAFx9SFKs3lum4MFYWjN3DU8iYVRXmW
 sVGRKuU6UPCPfygsVMoJN8/GL6I8HyFz9OC00z3DcJcHSnJ4WsgPT6hz5kJfViQdQkGA9MlBrPZ
 2NFOGKV5osyLyyJTG8lJ+OeG5HntrQK2YORpMPdB9T1PfhZc+fUsXF9u5bZxxVdmmYccrq3rbZT
 /YJjTWjllbAYBtgMy0CpMJJ/zi0fm3qVDF1+eIZ/OO7LNvBuJ
X-Google-Smtp-Source: AGHT+IHbcFiI45Nn9U7gFTDhrU/0e13ml8rfmcqpbqwoW5Ii7yV7RsvA+dL5Om6cjUi3uZ3fJ+tFkg==
X-Received: by 2002:adf:b601:0:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3b5e86beebemr2137574f8f.41.1752160514036; 
 Thu, 10 Jul 2025 08:15:14 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd241210sm22967505e9.0.2025.07.10.08.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:15:13 -0700 (PDT)
Message-ID: <1fbb8424-7fb1-410a-9790-3498dc98829b@linaro.org>
Date: Thu, 10 Jul 2025 17:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rocker: Don't overflow in of_dpa_mask2prefix()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
References: <20250710144453.1187576-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710144453.1187576-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 10/7/25 16:44, Peter Maydell wrote:
> In of_dpa_mask2prefix() we do "(2 << i)" for a loop
> where i can go up to 31. At i == 31 we shift off the
> top end of an integer.
> 
> Use 2ULL to avoid this overflow.
> 
> Fixes: dc488f888060a ("rocker: add new rocker switch device")
> Coverity: CID 1547602
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/rocker/rocker_of_dpa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
> index 4aed1787566..9c0fc728eee 100644
> --- a/hw/net/rocker/rocker_of_dpa.c
> +++ b/hw/net/rocker/rocker_of_dpa.c
> @@ -202,7 +202,7 @@ static int of_dpa_mask2prefix(uint32_t mask)
>       int count = 32;
>   
>       for (i = 0; i < 32; i++) {
> -        if (!(ntohl(mask) & ((2 << i) - 1))) {
> +        if (!(ntohl(mask) & ((2ULL << i) - 1))) {
>               count--;
>           }
>       }

Alternatively using ctz (untested):

-- >8 --
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 4aed1787566..431638dd64e 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -198,14 +198,5 @@ typedef struct of_dpa_group {

-static int of_dpa_mask2prefix(uint32_t mask)
+static unsigned of_dpa_mask2prefix(uint32_t mask)
  {
-    int i;
-    int count = 32;
-
-    for (i = 0; i < 32; i++) {
-        if (!(ntohl(mask) & ((2 << i) - 1))) {
-            count--;
-        }
-    }
-
-    return count;
+    return 32 - ctz32(cpu_to_be32(mask));
  }
---

