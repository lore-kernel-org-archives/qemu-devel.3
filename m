Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F2EE0AF3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 20:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voops-0002JG-Nv; Sat, 07 Feb 2026 15:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voopm-0002Ff-Q9
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 15:23:14 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voopk-00066B-Ij
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 15:23:14 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso1013590b3a.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770495789; x=1771100589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=14h26wfj6u/n4/H5W4z/tOTalQTkUaWEXLpn13fi124=;
 b=HUdHGxQ/ZJUrlnh/30pi7p4qaxlSlVEt/UNCXi7Pw/AcQw+oUS9NPMHA5yjkCQ0PCZ
 A+g+iCHhCrra5hXWWOja7GJr3w/mNVXm7RkjT8s8XgKxOTXjU89ThbVRPSnxmGEVghLI
 GJ8lUj5rbjOwxx1GsaEKmcDn3BTIMlE3R4O5mnb+dR//A/0+SASa1wj1Sdp92ZN9cT61
 fy6hQ5POpb4HqDHIMOExu4bRAHMikmffH6IOajslr8vfAbyxdeYoKhh/LXUxwLs3L99Y
 Q9EFklNxw4ZbhPkfdVFLvfgrDsofOptXzClc1SRONJqI4uMDMLOzI1mI3WzQ+lYCyPpW
 R24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770495789; x=1771100589;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14h26wfj6u/n4/H5W4z/tOTalQTkUaWEXLpn13fi124=;
 b=qyhor163CgLe1bQegyL4bRcJ3uwGqUr0xuB3ZUwtf9g+iJU2jDHtX2suQ2E1UCn7iN
 mFNF4bmH769QVWmFzjNACk0JpmzI4RndJhJtS9JfVNdYnYc4aWJN4wXaeq2IFTR3MJT+
 B74TVHsSciNdmdGers3B7uAViabkPQylQ4bHIb8+s7j5yR0/vt34AJ8vGGp8kkqMh0w1
 QFsN8hzLS/kOdnvIPQgxQABgVG3D/87ljzc981oP26tNNUsRzIwm62F2k+qjJqlwajC2
 8O4/jbPaqqK5oBYi6FYGTYVF85rilgcBIJlGPKQuSVC7q2vHhukGro05AGfkbTMqFozt
 6mtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURCHEq0xyZHgt7sxFvrY1aBVkltag1HSMv+UjZVLD7RtX0ls10K72vrDSGlks4EkwR/kFezVHyfN1q@nongnu.org
X-Gm-Message-State: AOJu0YwFrl3r1WXA/hELMj/t6Su62fKNzERqPrm7/YXbMAFx4X1kh53z
 qRnPI4aB7mNAyXeFyScSOzP3pVVWIaOpDeMnLt+cOcgZdIMNwxdcaehM7EoU/m9WqHI=
X-Gm-Gg: AZuq6aIGG+3v1p4GZ4Z1uqxLrh5ZjvYKcBli3rojYPlP9Tgi5qqMiyIPJ51wky1JW5s
 JhpwOkTPevRtj4Io5ZxSzjBlxegk/M+rMuhDDoBbWUQVvEcuXHHXgYc5pEDsaOPe5dq1hmVaTly
 AY35nagJgjY3SP/aXeqn+3QiFWGOsWt37Ucp0m+AcuMa3aCPSMdypuR/dlPSfmlCyVveAjDoqHP
 Ydv9zPmoPWG2iBGXqcqEPh2ScHJEp+m/9Ro8t+66Wj/gXHpoWPjJoMiwo8IeitpgApBepC6Le0a
 bGL0N6iOgt4y+WPDL/1L13V6GCRSU7z3P5oLB+jNmdKht2GdYXHWn0JRzBtb6XJKOh1X7Vs/Tz3
 AHLQX4MMXct4GXR89Y61mlHwZLdnHx1YFNXfA3RP3L4E1Xlwa8JHb+oBRLj/8iCN4KnapDJbFwF
 hMyPtt8i85seNzethtGHAi2LgwvQhcL425E9HubbL0D8cMjEpoVEdLLaqV
X-Received: by 2002:a05:6a21:107:b0:38d:fbb3:d577 with SMTP id
 adf61e73a8af0-393ad395726mr5945530637.66.1770495788876; 
 Sat, 07 Feb 2026 12:23:08 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb526610sm5835356a12.13.2026.02.07.12.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Feb 2026 12:23:08 -0800 (PST)
Message-ID: <d419de22-21cb-4af5-b6fd-1db7a349c231@linaro.org>
Date: Sat, 7 Feb 2026 12:23:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/tcg/hexagon: Handle SIGILL internally in
 invalid-slots test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, alex@alexrp.com
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
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
In-Reply-To: <20260207180632.1042754-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/7/26 10:06 AM, Brian Cain wrote:
> Rewrite invalid-slots.c to catch and verify SIGILL using a sigaction
> handler that modifies the ucontext, matching the pattern used by
> invalid-encoding.c.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/tcg/hexagon/invalid-slots.c | 76 ++++++++++++++++++++++++-------
>   tests/tcg/hexagon/Makefile.target |  6 ---
>   2 files changed, 59 insertions(+), 23 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

