Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFAFCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfUR-0000rp-6i; Mon, 09 Mar 2026 14:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzfTt-0000p0-Vz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:37:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzfTm-0003nE-UT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:37:25 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aaed195901so55025885ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081441; x=1773686241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CB0c8DocWs9nC0mRqWJrFur/DeD1o0K/iABvpYV8rYI=;
 b=JAgupj03SObRGO8EPOs7kXWk8pqu6ta3RWch6UlPpUBQx+tZvAEJcYcUkj9R+YQXcr
 amXAOUmUKhgJPsTCvKXgTQUG4YROSdKsyHrAgwqAMn2kpHHxV6RYH7TL8DyCjrNHbyZ5
 YYMteOpT8i0/DNHaDhR5SkOAbo/S8QHzEK2DaoMEutL6Vwcwi95qHBmhURqIvRHy7Jsk
 cTNnHzG5Hsup1kodZxd2uOuNPJnTQewajpGdJErCA1NLzPTmU/cNC9dUuF/7d9dK6uf/
 K1RQdEkTKoKfLmTnyJ0dcKHKD28tn0ZswPqprJRkuqZ4XwnmbW7pooQVKL15T0twdIMl
 GbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081441; x=1773686241;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB0c8DocWs9nC0mRqWJrFur/DeD1o0K/iABvpYV8rYI=;
 b=o0dkKTIJXV/k300M/NFEONMQIEBn0QNJ2YfNQplxV6vXQIzJr0LcjQRwENWphrny+3
 tReDGTnic9fE2HSzL4hXSLm6EDq0836wO2mXYkHjsz4QVFxsF4YLRS3i7BUim3wWdR3O
 Isob9A2BStXMnmMflbhr1aUgh6fl5qj1VSrYXnpOnwvbkDTcHUHlc5Dv6NmdEvwEuVw0
 v1pDJ7UUVYTn6S2qblh8QmpjhyFE1VxCat1LfpKoC4rw8tvq73JFq7/BJXkRgCzYMY9l
 A1LQrK5ojDDQA6/EpkPrJ4LY7K+y1UKIhku6NkjnRP6IV8YnCZglZJ2JmLhgNjiqxslu
 6K8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7vCiDch9pt40DhzgIr3qGrP0IxLBw5+dDw5Ow2rurEAMjrOV0md+n2wqOuo6HGC5tUI2iZMEymn1r@nongnu.org
X-Gm-Message-State: AOJu0YwxSkJ0YR/q1BitwFiSMc5axJ+RVRPwmNJC1YI6HP6SMZcLuxnM
 vYENRPGmp6Uf/8F/SOcNI6fEqm+vdxd1APEfWDPbYsiOmjkqQQMz/8wyMgQZyS0F2xY=
X-Gm-Gg: ATEYQzxkmLtE9vkS/vbXhlmhxnwXrOQuMJjU4SBLm509dYeThi4ij0EBl8ot8lgH/x/
 HlSoxKtG1XTmcWgc776ipjPAFQB0/bDjETuLu8pg4ifaWIRN2gEPFA+i9oFMz7mX9F0aTRM3yaE
 Y5pnpy+pRTZFkwMau5mW21W4LxxatxQ1XLVlb1Zho20+B6SCX2XCoCXfgJWMJikFmDn1QEfMenY
 mVov3P1JeE95gH0YJPzKqHaNb+H1VnfBS39jF9DI5dj1iiamfz0cv62KV++MMJRHRXGSebg1ypL
 /BIM5CzevHFBt2mFJlbD3NW2jsw0KNpxFkCYBl1CfJTCuApF9/3KfUl95EVVjr9F+K7rmTbxrmg
 2ihvue2ZxLuPQ8+93nUQaDzHX8oUjZD4BBOHsgUXLFHKh/kIvn34zfjL7SeEYrRE4MVwaUJSp9+
 DmowbzkzTgKmIXB5CB7DJqKUpUkgAZTs5Q+sI9E2RO0+UeeiE1dQB+K2KOSCafb4zG6FpwmCpVx
 yeyAoA=
X-Received: by 2002:a17:903:ac4:b0:2ae:69d3:5b9f with SMTP id
 d9443c01a7336-2ae824ac5abmr118864835ad.52.1773081441272; 
 Mon, 09 Mar 2026 11:37:21 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840ad9b7sm206390295ad.79.2026.03.09.11.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:37:20 -0700 (PDT)
Message-ID: <5483ce28-65d2-4726-b7f2-1003113ff58c@linaro.org>
Date: Mon, 9 Mar 2026 11:37:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] system/xen: Constify various MemoryRegion arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260309183536.88976-1-philmd@linaro.org>
 <20260309183536.88976-4-philmd@linaro.org>
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
In-Reply-To: <20260309183536.88976-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/9/26 11:35 AM, Philippe Mathieu-Daudé wrote:
> Mark the MemoryRegion structure const when is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/xen-mapcache.h | 2 +-
>   include/system/xen.h          | 6 +++---
>   hw/xen/xen-hvm-common.c       | 8 ++++----
>   hw/xen/xen-mapcache.c         | 2 +-
>   hw/xen/xen_stubs.c            | 6 +++---
>   5 files changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

