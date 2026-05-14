Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C6CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNShg-0004ZL-Aq; Thu, 14 May 2026 05:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNShe-0004Yy-6d
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNShc-0008HG-Li
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-452169ae568so5968766f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778752199; x=1779356999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmJV3T79IbAjzkkeNYsYywV0a564uG0qsoEwRl0OZ0c=;
 b=G32+WgOB1a7/nKRbRacIM/2sZ5ckI+8DCnZjH/HN+gyPmnPHXEhPzjz+UeQfqtVOfU
 L2qvBb4QaDcVb0lbTcfQsNlDkURX1g99syEcOKFav/WX1vkvTVcH6uUAPo3reuJe1A5+
 yoeTSFJfd4W016iXi8JE7O5a0R2Otayky3V09lVmLZUQOgLQYfmbJr72X44F75Djff//
 Vrg0sG0j8s5Rn8m19i8Yxj7Bu3YNel4vM/QFTTLg3sGY99K+BBystUJL1vOqbJS06OTS
 CB3wOqyLCegtugvBgifHs3qoQKgtIlMy58qGpEs+OAjodEjCojmwP8qfYDxmICBmvbH6
 pvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778752199; x=1779356999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmJV3T79IbAjzkkeNYsYywV0a564uG0qsoEwRl0OZ0c=;
 b=ZNoOo3xLICHzHcV3Il+soJ+9OQ8oIXnQr4QQak+dwLfaCBbS2benX3JVBrQY2BLG+w
 9vtSKPQ+lH8X+pXpu/uHX6unF2UK4AyGtgAfG+duKJ1N9jtTYr7mxq1zdz2G5tTgpp9u
 /JEBw7i4cid+1lTTzwwNa2c0glkfNioVC+W5IpZqIVZUk12ncustzHt2S2YDaqNPRzzV
 toF064mP7ZIJA1TnKGQsrjD0rsEQazMyCckyhT3WsNTBXpAfDl96lTao0s9yxpxp/oGQ
 V970LNet3S2f8DgmcWmyxuXvVHYrR2g+QszEsQ26DBUwrE+IQtYz1KRurF7n8WZROsB3
 mtTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9sWH2ctgxrOwT3iOUMOpbJA9+/pxjN1vWyKQJjbWnfMNMuMLdM/0mL0yZT4BmgPVWjGay4Y3HWlkj@nongnu.org
X-Gm-Message-State: AOJu0YyQMmcZ+SzE2fxoW1As+UMiyjGm1uXowcYfpmwFL/1K7Ub3Xz3N
 G+YM4Jr8E3mxqI73T5ityb3UNtHqJOqqgXVNST84oT+qE2MxB4uEnZ3m8SlKiB5Et2Q=
X-Gm-Gg: Acq92OFFG9P9sY+uVk8VzgNpr6PXgsdklrDiy5Ej2ocLaUP4TgcMMHRwA9UtbfNn7Qq
 BgtvrXbZJ6DLkGW8fXbqy7FxZNAEPc6NG69h4D8+4C5J5NGxTTh4+569cN63ezt1EEzr9rJYlc0
 iVfbPBLurko/JMK3I4Xl8MmAikQnseujwJUPJZeAyq7oKReKe43u8IlOtcl/0g9W/aX1QvhGH1+
 5VqPmOP4E8REvVpvXYyU1ltspjhs/x8E+MCdNKn0pUSR2LH8xzD0Gpd1lXtTrhelz7vs8WIOa+1
 NpvNcGzgqd7CR24xW8E1i+Nf86fovRrA2MQy/T1tdWhbke5uxJmzJLyVTBj0Vw5f4t+IDxkVfP9
 PR46BChnTFfEk3McE794UmXktzEbe0zV0l6ivR4U/RwcLLRIMd0Ex1f0fUtL4PpahUSrGdjsJcC
 IAkHFJU6cOl4I6uOLOBiG+X5DCqDmXJ66X2sWJ5sZ7xbhKSuunBXBzwCmMH9VrnWJJpPLrNYgJR
 IyE
X-Received: by 2002:a05:6000:2081:b0:44f:db87:8919 with SMTP id
 ffacd0b85a97d-45c77b7b8bfmr11142403f8f.4.1778752198658; 
 Thu, 14 May 2026 02:49:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768bcesm6047994f8f.4.2026.05.14.02.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 02:49:58 -0700 (PDT)
Message-ID: <212ab0f3-49a0-4e9e-957b-6e0bc3f22729@linaro.org>
Date: Thu, 14 May 2026 11:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/35] target/mips: add Octeon LBX instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-8-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-8-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> LBX performs an indexed signed byte load from base + index and writes the
> sign-extended result to rd.
> 
> Wire the existing indexed-load helper to MO_SB so Octeon user-mode
> binaries can use the signed byte variant alongside the existing LBUX
> path.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LBX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

