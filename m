Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B20E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7w7-0003FD-HY; Thu, 19 Feb 2026 12:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7vv-00036x-NQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:35:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7vu-0005EU-0J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:35:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a79998d35aso7607145ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522520; x=1772127320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tn46sG3IuWy3mbwecQATzlmonoodhTKVen3EFYxSLp4=;
 b=ZTpAGbpls3vTCHrWzBTFk4d/p2r0mJtFubFlm5WTEbWyw7N9QoAMJ9hEpK+5KetDxT
 aJdvoMSJFjJWwDQdgrDIx7ellzh8CSdTR7cygWBgq+WN/NIPim0RvAvncQbwtMT07BzN
 BDuBdlSEkR0PNE20K5KwSJieARZUbqk+XSU4BnAekyoDWPnePvb4vRrNjNM7HDFsa4Eb
 KbiVuaYMrZHQ6HZl91Zojw2n9NSE3xABKAsWtNkNNpxs0XqatRYcXucwoWUV8izFX6S+
 pCDM1cBdZBqBRjNiGRQZ2SrQPJO4/fpNxyIWz3z8KgXAC+stkzk8HWEt4jYfmKPYuFFj
 X1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522520; x=1772127320;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tn46sG3IuWy3mbwecQATzlmonoodhTKVen3EFYxSLp4=;
 b=RD+8S5qLuiqgGaiwtHY27GhV1BmZPvHoSYAt2/qJLuTeCqyLm44FGVKQJlcQA/2KjQ
 D9LOrNWnlRAScClfciHKgpHg3J7dqY4Nv5+xlE/zztxAz4WeV8wYqFxFGQkij1k6t+un
 Uz8tfn4VNyutFLumq/gR/R+QGQbbQwUGfbt3kHZQePEV5EWkVQ+o3ECT7dw6CcLxKVqI
 FNipIGPfw5zO4J1x7Pnd6G3dZ4KpTEsN2s8SPsA8/roCwYsEvFXqnArYSEwBso7JBUBv
 gDew3deM36ywEDiIhDpB7k2VCwxOIFIcZBYRwhc+dvoFz7bTgWOTCLIP6gkpMhW+1Vb+
 rpKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd1Gwxr8/Xfa2LI6S/+F120fCEXaUKQnm69Dnz0/2hE1EZuOHZSrOdtNbcDhsjJiQovVJLY14g+2GF@nongnu.org
X-Gm-Message-State: AOJu0YyocHFLtUG8KbYqRM8mGUiF2y45NlBS4jhcCYg8XoAN2DLORg2x
 XZXK/+0ayuD1JF+I3sjT1MOx/B7C8Onxent1jPQoexzVxFXgAhOkdfvI21Tw5pZ1+nI=
X-Gm-Gg: AZuq6aIT7XMCG6hoNzQUSHoez6zDEageuSzAHQh+ELmx19gTW0PwC1HqnuDf4M4Jeky
 XT70YA1DrMH6oIKFJ0CJsLr8NBBysbFZ39ADrcydVGjWPDhQ4v14HYLh6inQ7MEssZilIcNlZtm
 hj5w9ojjnIeVFaOUXutevO63l7G9R9ZQBqkuBLVSu5JWcZLvN1MbFhuwezAfpHyjW03fhheGTtt
 KmAVz1S7IWi33cg2LVorOiYFGM4MYa9gOFqqW4mbgRSaTWa2HIzn8bzQYgw6/j6L3a2DuoJtxz4
 USxGTR+eWtISVRysRJHfZhsOYQBqGSkJyV68DzsAwbe1NfjPPhZtb3ei+jw4kgQn5P8mqvmNses
 Acax/xQUS6vfACFNnaGU8Z0PPwg+I6JK9NFzZU6j4rzF0zp3kth+llHzUXgupyqvFcXxKYGJi59
 4DlB8FCOwGsj+RW8sUG9vYOYWWxqigvS6WnVNu7jszsXgRErvTrD6Z6S/YRJhpE7TRmpRw
X-Received: by 2002:a17:903:2b0b:b0:2aa:d288:7bf9 with SMTP id
 d9443c01a7336-2ad5b0e19b5mr33810215ad.31.1771522519629; 
 Thu, 19 Feb 2026 09:35:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aafc527sm159872025ad.89.2026.02.19.09.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:35:19 -0800 (PST)
Message-ID: <1844834d-3b02-49b8-b0a1-28e34e71bca8@linaro.org>
Date: Thu, 19 Feb 2026 09:35:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/14] include/hw: expand cpu_reset function docs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-15-alex.bennee@linaro.org>
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
In-Reply-To: <20260219171810.602667-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/19/26 9:18 AM, Alex Bennée wrote:
> Add a hint to the developer that this should only be called from a
> reset chain.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260108143423.1378674-13-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

