Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A868FFED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZaH-0003oH-H9; Tue, 17 Mar 2026 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2ZaF-0003o5-LF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:56:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2ZaD-0004rX-M6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:56:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so73395215ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773773759; x=1774378559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hJsX1/snRoUQA/r6c5N3fL5SJimkrezXtXPh6xaGwe0=;
 b=yPU2FN8mp9codOr6+mky+1jxTpqK3Ki3GqFFS95X9V4DYFoe8dIPSOO5ykHfQ/tLSC
 06oKPIIIA5Y05ytRX4PTuOrG9Ppbt/YVD8/4lLURwIptPlTvdiB3F4qbux0Ag+LE2UfS
 c2JwTf7+imIuVecLRPy27xfzLXv5adrZ/ss+hac1UxO7Xt9N9oM8Y9EBh3hJnPKrknd5
 raB6A8WEfy/Tm1KL/z48aj//wDyLBiXWbgOwMNND+XnNvlFJVfSPg01Hd5Fu+De8l1H7
 GrWM2r+uiD59hcgMa56OgNiCMwqvNIOv9LgTSo8McN1eb3Y5ASIYUNEj2r8yIsUR9tW0
 I+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773773759; x=1774378559;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJsX1/snRoUQA/r6c5N3fL5SJimkrezXtXPh6xaGwe0=;
 b=VeoyTVGeB168MbRxluDYvnURL4mCbtE5/bYNApWn3JA3wUCh9jRwGHZudRMJWygYtf
 Bk0gcpWP+2dCG0n9mfnWhD0rV5FiKzb3Zs9PBPi5dN+QqBiYHHsxwkD2lA8D2AcLudbN
 gAjX1EAdDoeDRtTO+2l54oo5IB4YAQT8s7YYehF1JwApnjeURk0ZZggq01fxLcpz62+9
 CuZjs77djugMWXibXsA0BDlFk5+/bgVMOgRZajnQJGOLOVGCKCSaFUb1aQmZBQI5bfUN
 VkdtU1UTGv+BLV1ZeujGrhBW8oiwCGOP9jER30xG9acOMfObOfBDu8RlmfNk4Ofe8y4v
 hw2Q==
X-Gm-Message-State: AOJu0YwA/MrUUvLgdGwFuhWGyUbAVCHv0lxzsrFdzPsm8+6A9YriALPc
 FfA84kaXn8cw+Is1CDcROGFWpO9d7TobgeTmaYelMkCG4xDwJLuFfwEPpVU4cjR2KvXOQGQS/Kp
 nbi3MLgw=
X-Gm-Gg: ATEYQzyldllwcKw48UTUHsZcngerRxkSqjsSwv6d9Yi+D2V3gQZPacdVAFmYt4bdk19
 5XXh5S9buMirngs0xXlnPxmloRUc97OvLfDb3a3FccF8rGhl4/rdAXL+MrNnmJSGf5D2ju21i7f
 RcCTOF+cQx1Vd9tz6mOKPDT2CY40hYeAI+WraiSQOWUeO2nEkL026DB1MekHhkaZ7eZtEg6K6+V
 j6oTUQd48afK5BlKHnTZq9zLuwnw/T+x2o26HznRMqZND0TbNY7G3H798G66fj/jTqoQCMRdDjW
 NFnNKJJmNL2eaUayzuQ7BfY7uWFSFPBPeImqyQ6X/nO95AP+mvO+bTjhfpig+cWKxYHbcurV2Ou
 1kUHjg069F79niGjQsINOzBOz0gRjOD++w+YJaBCgT/VZjWs4pZBhik9lV86pdZGBvhGveTDX9s
 uDT+9HB2uIrTVtv3emB+/cercA8DqBu+t3rsWrdAYweXg3WJJTkPhFrnV07R04Dg6xnG0+
X-Received: by 2002:a17:903:750:b0:2ae:7efb:6068 with SMTP id
 d9443c01a7336-2b06e3238e3mr3392665ad.7.1773773759272; 
 Tue, 17 Mar 2026 11:55:59 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5ef58asm2547855ad.47.2026.03.17.11.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 11:55:58 -0700 (PDT)
Message-ID: <918a186e-7e7d-40d4-9b9d-759c898a4a05@linaro.org>
Date: Tue, 17 Mar 2026 11:55:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace.c: fix depth for exit events
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Honggyu Kim <honggyu.kp@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/12/26 11:34 PM, Pierrick Bouvier wrote:
> Uftrace plugin was recording wrong depth for exit events, resulting in
> incoherent traces, especially for partial ones.
> 
> Thanks to Honggyu Kim, one of the original author of uftrace, who
> spotted the issue.
> https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

This was merged into master (6667668e0cf369e47aa9dd0bae40989896e9ed9f).

Regards,
Pierrick

