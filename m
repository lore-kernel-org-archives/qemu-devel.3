Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F3ED68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcOr-0007kP-K1; Thu, 14 Nov 2024 11:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcOp-0007Tr-8V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:08:51 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcOn-0003Sd-J8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:08:51 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so7063055e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600528; x=1732205328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6qnMo+/4yndqgm6LFUOaM8Yj88pJ25E2DpVCwT7cuCE=;
 b=W7O1nw9UHD+CnoNru0oz9EYPdbisxk3ll6Klvhu+oDw9+LI4wFqZ62MTwcUpJWRTxi
 F6sq901lMdf484KzTqvWrQ7kybQ3TiRGpWrArbh4G1M0SVYow2QPbK7q89cHVFndcEDO
 v9FUAlHLqVXGG4xzDR+ZSVKuNnueIKxPPOLYnvPBbvmgGmNjM9iLzjP173W5sfOfgbbE
 pwLoxUcew4LUD2TOFNxzmEnGOwVE55NVw1i9u1VcBQ67492EBvJjT8hUAYrcWxwl2xKe
 CjptfKHGJ5rgtCnRNohLuaoYj18lDa4ra5CGu+KmRVcnDGNzhG1rFQJXfsQc8GWKDrnP
 AUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600528; x=1732205328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6qnMo+/4yndqgm6LFUOaM8Yj88pJ25E2DpVCwT7cuCE=;
 b=A7NrNJ4VP+9gyNn5+FoaM3dLevIEk+zqMKThk9CtmB1cMI1NnlnzenBo+/hrDBZfM5
 BACHUzAu5e6blikXlECxIWZfAJ8R2K0fPLMpZEnt6f1kbhht3678YRuhfTNXvNqbbCib
 5fCjNTXarGim0qZGyXMTTksMz/1s4jIYAhC07r2FCxl/RIpekJ8D3/e/wIujdvUhkc8t
 pmcV50w5MTHmp0RYAyG4izlASq+3OCnqOur5p1eYHiylqlO6papwkrcdugORCIEGb+GC
 c2nq+OT78n/TPonL5NqeFVYcy+I8hzPECmx6OkZiFBkIGpjNC0P4cfDkJsnyoCXMwIuD
 XEjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcyQZfSRGhrpO2XOSwG/0htxVR+x+mvQzKzwT+Pg8Qi0fbE66aNGwEGNYGmDRh7Mkt52M3aXh/U02v@nongnu.org
X-Gm-Message-State: AOJu0YwQIcOYiLsvAQNakNBt+2uSKDoCZHTJM5hu9ixC7DC4SFAXqntP
 DwjCTogIi/aWlsgeTieSas31mxFRAHoSmVLdN91gQ86x2uUhELMdoq0xHWaDULILfEOhNBhpgfd
 Q
X-Google-Smtp-Source: AGHT+IG4yWm9WWZIjHm9y/ewCmEu0IzksgwFE+jFMiHHzk2NCBHJi8zu31oZdfK47vc7ORAlVhiF3Q==
X-Received: by 2002:a05:600c:1c28:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-432d4acfc2emr56751465e9.23.1731600527795; 
 Thu, 14 Nov 2024 08:08:47 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da298760sm28304425e9.37.2024.11.14.08.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:08:47 -0800 (PST)
Message-ID: <a788197b-9254-46e0-95d0-77214314df57@linaro.org>
Date: Thu, 14 Nov 2024 17:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] linux-user/arm: Reduce vdso alignment to 4k
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112203757.804320-5-richard.henderson@linaro.org>
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

On 12/11/24 20:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/Makefile.vdso |   2 +-
>   linux-user/arm/vdso-be.so    | Bin 2648 -> 2648 bytes
>   linux-user/arm/vdso-le.so    | Bin 2648 -> 2648 bytes
>   3 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

