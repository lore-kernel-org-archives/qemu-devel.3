Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996DECD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNTKZ-0005Et-St; Thu, 14 May 2026 06:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTKR-00057q-FT
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:30:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNTKP-0004KB-9v
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:30:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso50079205e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778754603; x=1779359403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvT1D13TOcwec3Tnu0wpAc2ElM6Q2LyvFRkTbV2j4Nw=;
 b=iBjzwI3X4M+wA0mr44ts8nMO0MQA9ZrRzmXVqH139YK+pAK0nTUJogYvsEit5Vx84b
 gggczt+7+g2UgnasXnNlqh8D0yh/BNs5Rpffl3vt1HrafPkfCnms5suBejup27qqKct/
 0hSWYr6uvcJcbTiEYJlEUS8wMmyFJDi5YTz0+m/JB4+GdvrmdI151cbi0QaPR+vx+P4C
 y3GpJZCOy+8YY11K/FIMg1bcBbBw5ymY+ZT5VkIB9xORW5SLkH2y5+kaTHjzOT75rv9W
 72WoUT8lOk1nGCIlxode8CM3x5pQw0kUFXTuM/eq3RQMlWIS9ijXG5v6AwBGKNFXUJPE
 pYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754603; x=1779359403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvT1D13TOcwec3Tnu0wpAc2ElM6Q2LyvFRkTbV2j4Nw=;
 b=EpgxXq1efpuIEYVrz+DMfjkb/43PzzMrtjxSKpvOhSvEU/aJzL5LDAcyTJTnCxNmtf
 zPSi18x2fNUoKPtHKw7KrUT95u5NRvY7r0NOQzbAQUVNs4Y5vBbjQvqjWcZITtbtNcRs
 TslC0DHH2npT4uLQ15OgvsNhliT0wcuj+dgUYnNcrQ8XRCSrwU/zzYCXvp5zOYYVOqsW
 UhzpcQN7zXcJ+LVLmrseUtzkqwhoqH+7TfgAma02Pa0hQLjlTExbEJm5zc2VtWxBGJ9Y
 HOxoXVP+/0sAE1uwQTVAHR9P5rceZpjRiIfmtHwHqQYq99FgtZ0sHpkNrmzIFF4pFen6
 bj5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8+RjX+q1nrX9H+DqEJG4rwQRFoIg8dBCUBtylltakWMMGJkvx5tRS5VRVUyo5fluIylQ/ZhB3kWIu@nongnu.org
X-Gm-Message-State: AOJu0Yz8OwZ2Ia0JgI5yK2bAdlwxNFT0nxqiZgyJ8qrXa8ETnoBiktiL
 43eQE9fWPQ3lfNBwVlsmAKunNznA972ZDnOwVvAWbh1g2cxtBPDblyaIzoO6UAI6VqyZn7gTQNG
 EWnUcJsM=
X-Gm-Gg: Acq92OGRqySyi8CW+5RfH4/cF0BNwI2BFDl2OeHYpxyx55T6CTC9XoZQDbFI/CdQP/w
 ft1Yb3iZCjW5owrKl+SeR+5dsT1VoRDcARgJpDkHu3aeQjHaLE47Fla8HiZwxMkRWCEd5ivZbgn
 W6us9UOzE2elmm/77/tWi/b79QxKytCcnjH9NWqcPZEOAIUb+QbWwplwBUcgraBv5B52vHL02mh
 y+VJ7OtIsr6NeJ4177eNnrFQhsYH2LqjHiR7AMnG3IkTqyYzqPBzTyQ0P8mGOzPplSlAVOSQ6Io
 +ZiFkATrXflvY9LPPCJjaehqWbbghDyFoI6/VVfszaMhCCu53bWEry4381sWTQwtfZxLon7w+CR
 6y7zGbxuxAvzVu7VZGmLrH+LixwEwId4xoa6h4wpyQpDEg54pcpepyudT0Q2A/qi+CewL0jEzsy
 E8gdYl4eB8/q6BzKa3JQeLXgMWYviH8A+EYuakDWY1a+Zy2oglVLuCWfQGp4crFlA6Nw==
X-Received: by 2002:a05:600c:8b86:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48fcea207f4mr104229055e9.28.1778754603372; 
 Thu, 14 May 2026 03:30:03 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd769286csm15819405e9.33.2026.05.14.03.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:30:02 -0700 (PDT)
Message-ID: <f19f0d68-d4f9-4d4e-957a-d86ec90754f7@linaro.org>
Date: Thu, 14 May 2026 12:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/35] target/mips: fix Octeon arithmetic destination
 handling
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-4-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-4-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> BADDU and DMUL write their results to rd, not rt.  Route writes through
> gen_store_gpr() so rd == $zero is handled consistently.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Split the BADDU/DMUL destination handling fix out of the Octeon
>      arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Remove the rd == $zero fast paths and let gen_store_gpr() discard
>      writes to $zero.  (suggested by Richard Henderson)
> ---
>   target/mips/tcg/octeon_translate.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

