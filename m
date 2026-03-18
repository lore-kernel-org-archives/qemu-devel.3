Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D3510775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vOX-0003iJ-5E; Wed, 18 Mar 2026 14:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vOV-0003hp-PW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:13:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vOU-000165-3h
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:13:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso128928b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773857600; x=1774462400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+lq2n931krQCmpkuUaOwWrn5HMMxX9dtX9TNpSC1zw=;
 b=pQh0t4Cs19F82xjUVbi98dZyBGvHkdB197TnZalT/bKqTqFNXrzJorCMAy+yKMZKsh
 oQ6/HEZhQTH+uCpEjAoPvFEQAxwolFrqHPyZxFnsYI1wCSthNkJoeA78tVSJhfyjX+BY
 osCQf1B81udRFS+HjHfJSDFYEhQ47IpRckLgdRD/oQ475sGUBpigrW5CGrKxsSk3WYgj
 MDDC+QSQF6KygsXX3YciCcA6zvdxZ4sRjxbKPesJ6kFBVH5IV3J8XodVXh9Or/FTlPgF
 ZVyazO/02e3iR+IfcUA26rDDOjAqR2Yd0SytaQc8soqY3Dwe3HraP7Pa0vrmRWzMEuYY
 1/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773857600; x=1774462400;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+lq2n931krQCmpkuUaOwWrn5HMMxX9dtX9TNpSC1zw=;
 b=b60d4Z2ndZb04y/OUIiKs26umrDdZgGkKXnaYdVxnv59tbaP2qrjIdu6opq+Vm4I0L
 PI83vcr7cO36dIpenBoBaxk1aBu2E+5+BOqjjxWQkDEOoOMGX387h4hDYcUb7a4D2Yxi
 dNaygtYITjZrL4QVGKTUUJ+tsrgT3pHK0qU1vfzAQ8ZqMkIRb9c0n35z6KGU6huraq4D
 XQOiask8pD+Z6XAyepApM7/HXwY2PcjC2kOKAEdW3qkyAM1kG/3LzAZybOXaG1afnIFF
 tzF8v3UOdK3irvymoCYoOsGQMv/Za1+2lSFAPWQMUsJBW1UzQFCO6mzoBRAOjSkn9T+k
 JfWg==
X-Gm-Message-State: AOJu0Yxl9EA4d+QkKCZGSNqZaSLGFSvu97DeuPT1dzYZR3YEPcO0xhik
 sg9ttglEDdI47KHHbXYwvkDi/4/GCEXo2AcDSwHqgwdojO/FTWkdG6vp2I+e4sP/Gol+8Rg65mw
 OqmBE0eM=
X-Gm-Gg: ATEYQzzEDPjM0ey8fqXWY90MYV8FAhm8aAJjQykvWBD0dTpk3rGb7WAbLfrSnyTafKv
 iLMR2B8UM72bb96Rfv3ZTrGRR/3lKOi/PjHcp5ObG5/1RYznNpME12BS5XwmW4ru/1rmv6O59cV
 ueuuftQs/vyYANW5TKqU7327YRtrv4aNYcpdXmv6BXKkuloBtx79HHBEcLyWlpPF7BKDOeeipXx
 c8Dm6Ui79iS3wb6Vt4ON5H04eGqoGsdlpka6yrV5sQHiUlQHUz4CwbiJdCptMr+jzf6YJZmk7nl
 p26+iwEwZa3h2N01oKJfU7KeoOv1zg0wiljFgctqpYZ7YlZ7AWKPI+ZP4uIEujrOmyalAUfy+FW
 pCPdnCe8kbieuqFVo+YLJ6mecSFvyjxMzgONX+8+dxKVl55ByEMnWVE/diCHngYIiEHP7XUNnoS
 e9sWar0xiZV1pxv7YpX1LpxHuaPlgcGOEOwSjn+y5Uawmxs9arl0GflYP7aW54Jra+8sRk
X-Received: by 2002:a05:6a00:9a1:b0:82a:650c:1630 with SMTP id
 d2e1a72fcca58-82a6af58a67mr4024518b3a.52.1773857600348; 
 Wed, 18 Mar 2026 11:13:20 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb2802sm3391011b3a.31.2026.03.18.11.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 11:13:19 -0700 (PDT)
Message-ID: <a14e7351-0e22-4cc4-b198-9ffc54173a74@linaro.org>
Date: Wed, 18 Mar 2026 11:13:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommufd: give hints to user about kernel support
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 philmd@linaro.org
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 3/17/26 3:57 PM, Pierrick Bouvier wrote:
> Using iommufd requires two different kernel config:
> CONFIG_IOMMUFD and CONFIG_VFIO_DEVICE_CDEV
> https://docs.kernel.org/driver-api/vfio.html#vfio-device-cdev
> 
> It can be complex to identify what is missing when trying to use it. This series
> gives hints to user about it.
> 
> Suggested on:
> https://lore.kernel.org/qemu-devel/0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org/
> 
> Tested using a cross compiled QEMU and a custom kernel + debian rootfs [1].
> 
> [1] https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough
> 
> Pierrick Bouvier (2):
>    backends/iommufd.c: report error when /dev/iommu is not available
>    hw/vfio/iommufd.c: report hint to user when vfio-dev/vfio*/dev is
>      missing
> 
>   backends/iommufd.c | 5 +++++
>   hw/vfio/iommufd.c  | 5 ++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 

Sent v2, moving the /dev/iommu check to iommu_backend_complete:
https://lore.kernel.org/qemu-devel/20260318180641.1797902-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

