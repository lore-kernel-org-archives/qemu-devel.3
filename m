Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B40EDEBE2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUCm-0004aY-4R; Tue, 03 Mar 2026 13:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUCi-0004aJ-DX
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:10:44 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxUCf-00032N-0p
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:10:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so69723175ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772561439; x=1773166239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hrIPl/N8HwD7pblZ9laWx0/79GBHCjNjjRAbt5Jgdao=;
 b=cvRTh86eavFQZVkGPLTtI5m/P4Tl7xvkzUXsdfhMwBwOTJ9yaAUk8FaWBlJojKpoQC
 HALM78LC2Ii7EBSMHWmp8RQt67gSuKClGFcpu3XgaMaM+B/tnYmFHtR16FA6dRXQp5RH
 NlkYhYI9Jhev1GLlE6s5FpXCzVol2PeiiLBP67BzflxC4N+iD5UB9cDgG83PVBdad9RR
 NbpAfgVaIQOglvSKohT28WUksMjkCiPp73cSzcydpnVZsgnMfmkKSWrl+CP9e+IbqG93
 VOUfj4JkUBiOh+i2pY9E0k29Wg2kJb0M/s3CXEXSjjHhmr505s7xsOsTiAsq6ayQmZr2
 YPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561439; x=1773166239;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hrIPl/N8HwD7pblZ9laWx0/79GBHCjNjjRAbt5Jgdao=;
 b=S/JkwyNJXYSPwJmK5iXDTB1/uxEjoqlhpxXpWhoqE8lfeNN4+b63rxKmLX+CICJtO0
 rF/OC7KSLY+ddcyD7bHJ7AJZbY5WbCN6aUqBCODRF6Q+3wB+wOEBdCJ2EUjbsAiZ7MnT
 xZKOwQx++1UZ+P0etQhhfehVCHhSKO+p/9qJxoWd+vXW687+ifsYvm+JwJBpWvuU4vg5
 w/I6k/Uw8J2rA2hZKLBrs+repZ/1RTvhq2Gt+X0VvwZvgH0v1GicAAqkDsQo1jzAD/j5
 DlvbaqXN083tvLNDEYR6+e7bEDlvAwtLHNAYBsKdlLsEE6ElUMgD301beL12xaRa1PmI
 kYmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6CVJN9pRxtkmDazCgTl51IDmVEGIY8kQq/JyVAx7OlkVe6VBNqKsTIybtcy3dObHumQW9b8ywaW0i@nongnu.org
X-Gm-Message-State: AOJu0Yyy7b1nU6DA55gzyGtWSjwNuuFZF2SNtGcb+MIbsBHVhhuI+Mb1
 9V5EIYxsrLf2auLS9dtBjzNOqu1momNUWSQGrwqcUzBpXGfYpIUg9bQMgs/0AY/t3O1lazGfPLH
 NccoB
X-Gm-Gg: ATEYQzwnB2CMnmYHTCgcnIv/AbxrwJk8JOQxR7Yokd3dG5Mzv0NsyRYqtLrFzx2/Y0f
 9Fm9Yl3ayJwiZOW5r7E6E5jEpvj+rnFeRdSO1yBJz1XenS0MVaaRwk36pSErhtWux9bYl1Y8zaX
 VdX0VIwenQDp61m9sWLV/b8AR8VYicS+1fNC9zu99rzPKEIT9c2DvJmar9hFCPu6Smmaf/led/y
 k1+4rmWHsi+N8UIBe3MUJTlsgq/EK+cdp5Ai6dwe0boON+/HVCko/HuEQBzTvicbEZQR6NKWYrC
 +rqXA8ZPw7D4iDVzmXBwY8ZCkH7bU7T9CslM9opRY8FSfhLGVtoldMLUWzZN5WQTkfsa7OpcoIu
 20wIDOC2jC7CQjpMmZsVrISuA+ceLyeLP49pxvtuNQGWgUCH5zTl9ehE5rYBjYDycDTbgyq4fEH
 vn+bgVzrtSC3XT9OepC4dvoZO22XRS0hkd6tf3oVoVCL5h/ncIWtVLHoQE2Osg37iIYDIO
X-Received: by 2002:a17:903:2352:b0:2ae:4aaf:3b04 with SMTP id
 d9443c01a7336-2ae4aaf3d52mr96202125ad.56.1772561439296; 
 Tue, 03 Mar 2026 10:10:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae45e07626sm102668665ad.39.2026.03.03.10.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:10:38 -0800 (PST)
Message-ID: <72808dc6-7e5a-46da-8ab3-996aae4d46e9@linaro.org>
Date: Tue, 3 Mar 2026 10:10:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] tests/tcg/plugins: test register accesses
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-7-15c77cfe184e@epfl.ch>
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
In-Reply-To: <20260303-setpc-v5-v6-7-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/3/26 5:07 AM, Florian Hofhammer wrote:
> The additional plugin tests register accesses, specifically both for
> read-only and read-write registers. Writing to a read-only register is
> currently not tested, as this would trigger an assertion and fail the
> test.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   tests/tcg/plugins/meson.build |  1 +
>   tests/tcg/plugins/registers.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

