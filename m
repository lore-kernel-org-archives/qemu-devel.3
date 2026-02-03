Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D292E8B370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnP9e-000375-Sf; Tue, 03 Feb 2026 17:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnP9Z-00036E-3c
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:45:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnP9X-00024L-I2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:45:48 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so41020435ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770158745; x=1770763545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YWiTEhIs0XqyaCiJ+EI5zqF5To5THfgZl5fyWRuqSIw=;
 b=L1NB/Tj488PROBhoOH3Rz6lJwcy1Nha136mzRQ63CifINFdKY3XW6Izwn3O6KoYUzb
 dVrePu9yb9/crw9P6V0aAQ32JoU96DzJvy50FsYaGePo2eV/vuKUGcIeV3O8Oi9OG27O
 XEH953aFM2Y88ZY1RucHzJyPm4q2n4QFMHrz0CEP9z95S8LeF3ZzF062/GBOXGqPZXiM
 hzBeYY6xMriV8T6PYBSSwr/cPich/+bnTLSJWeU9xm6M+AxNoGCG2qMudc5C16+bz7ff
 C/5XSk5ilQk7CCWJhYBM+AwbNZRNsDwRrLbjM3NB6Ms5rgiCXnXEftOmCJLLtGcXczCf
 nyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770158745; x=1770763545;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWiTEhIs0XqyaCiJ+EI5zqF5To5THfgZl5fyWRuqSIw=;
 b=dpOQq9wWObnqBbu8BXDvaZ/Gtm3REvYoBubnVFoFQqx3+C3yNmGUK6T1NdKC3bA6n1
 /SGfauUYDkANT278vN7CS4dJeDwTs6hUrkhqtiH8ar6WqABheOJmZlVJ3R8MP+l22ni6
 /Jdu+hS2CAcgUZ+mZd3o23P1tHxn8YUOi7wnmxznskGDNf+p1M9WdILdHUBKAdKnwtQx
 wl+ZseY3mdPDY58lUkE0mPauQzR5AAZxxJ1QNWg/G/dEOFekq4wms84N0QrYQKqTRCga
 rHjvGnhtMHHYcpZjUnJh20QLnT+Y0RmeQO47LIvNAcjR8pqaWEC2kb+FkU6i2KS8e5As
 rJSg==
X-Gm-Message-State: AOJu0Yycr1gMTPluiqqIC+UiqktHeLqtUi8KtRQefrFCILsNEz7NZLXd
 7V4YebCHb5QfUECGrvfh9UdffiCmHqiZSQxUrWdGdWwkQE+w4ymMIAYntqMwTO+XZKLtGmjb9EE
 obw+fMN8=
X-Gm-Gg: AZuq6aJxUGX4/WM1ndz9HEwpx1EiJQN80JT64ZropUSm5RrZCSnBCanvO4TWAEW2FHa
 x9/QZ9WR8LTa9kHmpuzBRmqz1PMY0W/7lewAts9Wy/Cd5gdkhGf+wkba2ksu2tRpvmpvcUj6Hxk
 SFLg38KG7qr8fm/S/VyBEPoapVDuHK+fHf4SA2J3dLXFs/9sTAVLpm1oh1UHrkC6mkS0O0qg6L8
 RavA3mKU84CJdBH9xHtkr8qvUp2fXyrCRNlBeEogZe/Y2yZJi4zNDGRaTVOemFk/jgqAW0pJsIk
 n2Q3S8DGynxebkkWR8iG35qg0SwVzcIHdIMSdpCq266dTmWZkDt+ZWh9eEmSy0dLimmnA/PA7Qp
 l0TiOur2Nu/sB4ZDIJd8londl6wBt982GZ8M03z30mf1CVUzKWWMa3d+hih+I3hkYVG/jBU0CZB
 ras92WvxocOIp7Yk0saBpXIStWFV4frNzkU1MXFI5aIHvbMPWM3eWQAvBH
X-Received: by 2002:a17:902:ea11:b0:2a7:994a:c02e with SMTP id
 d9443c01a7336-2a933bc9c52mr9256775ad.11.1770158745354; 
 Tue, 03 Feb 2026 14:45:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933888e8csm4694525ad.29.2026.02.03.14.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 14:45:44 -0800 (PST)
Message-ID: <842f10f7-a8f3-46c2-a5de-387e01143fe3@linaro.org>
Date: Tue, 3 Feb 2026 14:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
 <3e6fcc5f-154d-4a71-aa7f-d42f04136616@linaro.org>
 <221a990d-cad7-e39c-2c2c-1aace5c3c3af@eik.bme.hu>
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
In-Reply-To: <221a990d-cad7-e39c-2c2c-1aace5c3c3af@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/3/26 2:38 PM, BALATON Zoltan wrote:
> On Tue, 3 Feb 2026, Philippe Mathieu-Daudé wrote:
>> On 3/2/26 21:56, Pierrick Bouvier wrote:
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Endianness access is constant between device resets.
>>> Use the field instead of calling the same function.
>>
>> Maybe we should justify here, simply adding from your v3 comment:
>>
>>   When doing automated benchmark with fio (see instructions
>>   in [*]) this resulted in a +1.4% speedup vs existing code.
>>
>>   [*] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
> 
> What does existing code refer to here? According to cover letter it's
> within 0.003% of existing speed so not actually faster but only a tiny bit
> slower. The speed up above maybe from previous version of the series
> without this patch so maybe clarify that more if you include this in the
> commit message.
>

Existing is upstream/master.
+1.4% is with this patch.
End result is -0.3% with the full series applied.

> Regards,
> BALATON Zoltan
> 
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>>>    hw/virtio/virtio.c                |  4 ++--
>>>    2 files changed, 14 insertions(+), 14 deletions(-)
>>
>>
>>


