Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F4E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 11:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXHLu-0002Hc-5e; Sun, 21 Dec 2025 06:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXHLs-0002HO-Qb
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 06:11:52 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXHLp-0006eJ-5U
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 06:11:52 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-431048c4068so1726581f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 03:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766315506; x=1766920306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6iDwCKT/gtXEuHgvM34xkiG4o5iFx6ObcUWnDG14Rg=;
 b=xG8dXZoPsRcZog7dxFwnr+B3wrgGJV6MxMFgmA5jl8nxFPhIHxb/qSi64+q3HDBc7M
 MdKqLivDNCSGtfbxOoGkoDRAoJ1gZQ7vQXB1OAKiMubAZ1aFPdogC6axqoN6nptM37Rm
 Dp7E+gT8JyfM9G3mqO8e8wRzo48nDgjzyU/6TGbdvhqRzvVTPnpRh8NZXBW78yHho1+D
 ASBi766oMFUh02sw7bPOVJAWfvUiiuUjUPDCEwjvIxDR4p6E35TW/Z+EiNkRBozPXLIb
 dKUMHNVLqgAjWctH3i2zaX9zY6x81yjO20B19X6M7pW2e8DvirHHcutt/wSM96KRzdD3
 k2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766315506; x=1766920306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6iDwCKT/gtXEuHgvM34xkiG4o5iFx6ObcUWnDG14Rg=;
 b=E8Ttqx6w59g554qqGs0Jt5SoDoDBttEARkto10avAx3UJTWlD0mUuXxsQZBU7xXV8S
 mXvxGsFwbTJExiUFVvlJLVr1rrB5uarRA0as54e04fnbEHC6Rfa7NKXFlp/0pktsWtk0
 vsE/gVawhMz7/K4Rdp7mlhVz0yHoK0DIs36Xjgb3zY8O/fIZjOhTEkM2hUTVyAhREkgL
 9qxDCIF1AOcd5oKxOzq5Q8fBaHxnbZvZHGqtKWHfIhX5h5mxBEci5cY6vDB4/PdHF9DK
 v/0QqNyyWdp+X16U2AdQ3yt3W1+BASfQLW0yz9ZDetLYXxHMoKYASs43Uwp855E88u8x
 mgIw==
X-Gm-Message-State: AOJu0YyBuwzX5WQh+3Kg7JXnGkW+PpP/2G7ssQdw549/OpafLsw9n4om
 Nx2vfWPJxVwckCgjhKN9xkhn36DuMW4CPOtqd3PeWfyscAwyewmG8OqcZk9eROIxShGfMBORjPr
 xSECU9OA=
X-Gm-Gg: AY/fxX6900mPT0NHZ+SRqlCsK/2ZmuYjXtvvlGAbA1wu+d25CVS8NtMNrVFO2XiyCuy
 tAxLLXhgv6RvWWY3bMnLk/f1F4EbLzAYPA4UqcUjEufor7Mu+tAivtG38eMjzPXHuMbOzP1y65y
 Uo5YJNErzzqtqw6oKlIO4xhXC+d57zkqda4wRIy5PvuRbDWmrTlgjN4WAmtxrLvOlEeFD/8g2KV
 +Qo4EDvqIhZg+cZND7LO9sIS2Zbwq9cbKN9W749ug3FIm/qpqk9yt5QRaaIWC8+Ygpm83GPKRlS
 l6qHmJEKNvAasKO/L/Cjx3OFSm3vne5AE1QwDw8jy/5p6pMxeKsmkmp92bzEx+rnRGPRfvW4gIb
 oSkQ7XvWISEY+MQkvfEGkz+eJDUVsMPzRyg3mM1gTN30e0StUjIUH6xzDfddqm9ZALoT34nMu26
 qEHcvBAPSsJlU0E7N9kNcUQpcYoWW4jbHla7OF5Zc4wi1grshijbU1Bw==
X-Google-Smtp-Source: AGHT+IHl1IemNw1yvnSYZvLWRQ2+3bqk6CNyWcIsyus+Wk2woMjtYXCbsoTPYZc5AbD3tHcuxXK69g==
X-Received: by 2002:a05:6000:26c3:b0:430:fd37:ef89 with SMTP id
 ffacd0b85a97d-432447959a1mr13265431f8f.6.1766315506481; 
 Sun, 21 Dec 2025 03:11:46 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm15774179f8f.37.2025.12.21.03.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 03:11:45 -0800 (PST)
Message-ID: <a8b08de4-5bd6-46b0-9f4a-99bff5667106@linaro.org>
Date: Sun, 21 Dec 2025 12:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/sparc: Use address_space_ld/st[n]_be() in
 ld/st_asi helpers
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
 <20251219163650.74303-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219163650.74303-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19/12/25 17:36, Philippe Mathieu-Daudé wrote:
> Do not open-code address_space_{ld,st}n(), use it passing
> the access size as argument. Directly expand to the big-endian
> variant (with the '_be' suffix) since we only build the SPARC
> targets as big-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 42 ++++----------------------------------
>   1 file changed, 4 insertions(+), 38 deletions(-)
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index a87a0b3eee0..e9139814c26 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -701,25 +701,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>           MemTxResult result;
>           hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
>   
> -        switch (size) {
> -        case 1:
> -            ret = address_space_ldub(cs->as, access_addr,
> -                                     MEMTXATTRS_UNSPECIFIED, &result);
> -            break;
> -        case 2:
> -            ret = address_space_lduw(cs->as, access_addr,
> -                                     MEMTXATTRS_UNSPECIFIED, &result);
> -            break;
> -        default:

Unfortunately I missed this 'default' case (which I don't understand),
so this patch is not a faithful API conversion, thus incorrect.

> -        case 4:
> -            ret = address_space_ldl(cs->as, access_addr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> -            break;
> -        case 8:
> -            ret = address_space_ldq(cs->as, access_addr,
> -                                    MEMTXATTRS_UNSPECIFIED, &result);
> -            break;
> -        }
> +        ret = address_space_ldn_be(cs->as, access_addr, size,
> +                                   MEMTXATTRS_UNSPECIFIED, &result);
>   
>           if (result != MEMTX_OK) {
>               sparc_raise_mmu_fault(cs, access_addr, false, false, false,
> @@ -1066,25 +1049,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>               MemTxResult result;
>               hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
>   
> -            switch (size) {
> -            case 1:
> -                address_space_stb(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> -                break;
> -            case 2:
> -                address_space_stw(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> -                break;
> -            case 4:
> -            default:

Ditto.

> -                address_space_stl(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> -                break;
> -            case 8:
> -                address_space_stq(cs->as, access_addr, val,
> -                                  MEMTXATTRS_UNSPECIFIED, &result);
> -                break;
> -            }
> +            address_space_stn_be(cs->as, access_addr, val, size,
> +                                 MEMTXATTRS_UNSPECIFIED, &result);
>               if (result != MEMTX_OK) {
>                   sparc_raise_mmu_fault(cs, access_addr, true, false, false,
>                                         size, GETPC());


