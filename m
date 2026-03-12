Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF74106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kLT-0002dT-Qz; Thu, 12 Mar 2026 14:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kKy-0002bo-WB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:00:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kKv-00031P-62
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:00:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ae4e538abdso15203515ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773338439; x=1773943239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqX5EEJ3dFuFsiImSbdPOrKNYOeA8OHjUSX+r59ikGg=;
 b=nE0cE0HxhLnpIZANX1CCGU2jCa0/DBUGrSUY1U90Ukf4YS0aieaFcq67/zZNISLXnm
 z3lXQDftoqld/ZUM4ZiPVhOl3dC6XW9lqQGD/KmCbgox6lTspdaBRHYSKGxbPBLvb6dK
 DfLz0xwFM2xWxv+9zrISHzzjSs7yjRSESepgHqzy1HoE/GG7DQzSmu+tIchZkRiJM0wz
 ZQ6Gy7q+9afBTvPNMXzG+IF/CZppNq1sS7tp6EUj6RO1OJuXhkdu70nWCsLbL3LXh1EM
 gmbZiPbzdO87Haflu4GjqGoLw7rHww1lHOA1CM2CASCAfuTD7s4G73K1dJJ1d+VB5oeF
 0JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773338439; x=1773943239;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqX5EEJ3dFuFsiImSbdPOrKNYOeA8OHjUSX+r59ikGg=;
 b=F4KMwH5ekx4JVCpF35xvKqsDsQChbKfZHA3myKoxtbM/FlKKalo/DHwBwKDRF10Z0E
 CukAQJbOfjjw66G+kHvRs4jwHWJTGtE9eRQNfS+UAMFowRtIuyBVjA+rJCZ0C88GrMkB
 VMdVEcydzHkQPr9lZdH32l0IprAAMHPCZ3JmzcvLELxTNagpyN889cPp8pfGtf1qP6bS
 Tedyo9OxCIZxYRI7McvyzbMQXFCfFEcMX5IDwcdTN12Ik2WgnqG/ExYhE/y86owrJVqM
 bcoBM2wIT+6sEyJ4eb5UUFDLlXy8WIsf6zldIl7801b8E0H4KFZoHH2Aj5CPJFBE+Mnp
 m8xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlcSEJmakpyCIRJYTP8FDpLANdxjAJrwucMT5GBfJy06JMnZDgTYSLREweeleIl7gnvf88pSplgenL@nongnu.org
X-Gm-Message-State: AOJu0YwlEviTbjas10VNnx7PWmEI9kceszD5xz0WveoYfK4g8iuimTao
 n+ZvXzlsjEhBEHNZEM7C5xbnbUe1zKdRh2bmTdWD9iNzh6y9LLdY3APaEKE4u8/6gj4=
X-Gm-Gg: ATEYQzysiTk2OzYnXWmSpo6fT9EL5rbo5w5EnXi8BIZf9Nsm5WqkvMUCMSPy2ejdY9O
 QnkzRHVeZ12E7VSm4LGiYq02T3M2cvUJOt7QOhaliTGLSw3v4i0rA+H2hQMPu8zMzmAFoF1x39J
 IwuRfEAN7Uclvvih5VGvBG9YylNMSCr0O/8DKZA3s/ROF3rTnotn1WRw/BWbGotJTyWBBYp+72I
 /2rCE2O4sdVreIP2Fn8H6TQNUOCDlsUcLuVLZllQxTM2DMiDZqj52UHyJk2yYBDriwDfvdxOvKl
 4gHxAxlaL2S9j2bppKVJnXcltKNkeVsTjl+S6kZNZvFr9SLzV8jNECeUp3lh/Y54FoRz4aShJHK
 a98f5H+5EcGBtdBmIYKpm7UHc057OChuCA1RYvAdivqreWUo0ymwWMadFJBcGteBDozAafafK08
 rcrb8r2y+6p8AmzREYOzpM0wY7a8sogNO45Zi5EiHUs2QPmEGgpxz0GxofcJJLo3b2KyDG
X-Received: by 2002:a17:903:1d1:b0:2ae:5a0b:9ce8 with SMTP id
 d9443c01a7336-2aecab2fce6mr3316595ad.45.1773338438019; 
 Thu, 12 Mar 2026 11:00:38 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae35eec6sm62053275ad.66.2026.03.12.11.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 11:00:36 -0700 (PDT)
Message-ID: <4d7c6db3-0915-411d-ac1a-f26b5b38dc28@linaro.org>
Date: Thu, 12 Mar 2026 11:00:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
Content-Language: en-US
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260312121617.228654-1-vikingtc4@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260312121617.228654-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/12/26 5:16 AM, Trieu Huynh wrote:
> migrate_add_blocker() can fail (e.g. if migration is already in
> progress), in which case it returns a negative value and populates
> its errp argument with the reason.
> 
> The previous code ignored the return value, leaving state
> inconsistent on failure. Fix this by:
> - Passing a local Error ** so failure details can be reported.
> - Checking the return value; on failure, report the error, free the
>    migration_blocker Error object, and return NULL to the caller.
> 
> Resolves: CID 1645470
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   plugins/api-system.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

While the description makes sense, how would it happen in real world?

Plugins usually will request time control on startup (so no migration is 
happening). In all cases, plugin who want to control time will have no 
other choice than abort.
Maybe we could simply assert that migrate_add_blocker succeeded in this 
context.

Regards,
Pierrick

