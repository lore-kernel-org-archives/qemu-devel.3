Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E0810F2863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BcM-0003vh-BF; Fri, 27 Mar 2026 14:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BcI-0003vJ-Ht
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BcD-0002L1-M4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b0abdde280so23935155ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774634940; x=1775239740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3bjg+d3EtkZ6C9GPorOCQXN3+M1ybS1ESjLKr6/MeFE=;
 b=fdAeDDEH9vIz5yTx9OofOLg6iq1DQbEtTlYPAqle4PSX9oEiLKWiuAPJgTtHbnQhwL
 D/khC7PqFMy43jhVaVhvepx1+jzLH2kfjsxmk++BJEz6Vl+ZVpc/fsPdmGjEhSGFoLgw
 lURNv6Bl9DIpOIf+XAq4AxJHIF+pEBwVrK/WTqJGGFH9B2E1iFaX+ecK0G4oj2cAkck/
 h+GeeTxTRe5mnKHBvPTR2k91jbEKabHue2m5CB3Dk4CJ0SsXAqaoPzowZvDTjg+AXFL1
 5VJTEEAumIDvG+kgKGAq1wvz2EHifjrw1TQ2CVvXFfAvnLmbWK24uBoY3vLTQ4RA+UKb
 tIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774634940; x=1775239740;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3bjg+d3EtkZ6C9GPorOCQXN3+M1ybS1ESjLKr6/MeFE=;
 b=UzFG7l7jIz7y2ihkUrNydhDqOMWOIC+byoViUKWNRWafr35DKgFvWso+1NQMH+vbvv
 hI97OlZODYBWELwxciiknI8mIrAhX1tXPnve3Gplo++TBYwMYgdVecTEsNAySWmZQ6gR
 3OrxwO8Yh68cZv3DAQBpd0PDOZ0JBtTC0Se2oFjeiI9GHGWofokNwgnIr6kSkTRHJw9x
 cQQsgkWGp6X+WiAokoxwGp1J2OZa/kuYhE+PxBunwlL0TnNuhBIVgQxBSr5kSLqh+7tv
 a2aETNjSRwnrrCZ550SPRVDx1g8YYFXV+bOmc3zNfSdJIt9PBv9mKyK0t5ae8AALnhnN
 wQIg==
X-Gm-Message-State: AOJu0Yz7zJ5HCDbYgMsG5Du3tIG/DJfutY/JU/kBd12btM9G/1tZ5DEr
 ehEq7TLeC8DBrRF6sv0SvP/JIix9qr17ZjKJz7hoNcclafAeN+mR7bhOzoQdiXMiGME=
X-Gm-Gg: ATEYQzzRTGc4yd6OS/vw+QlnNQB8szUXPfLuWlFceQCdcuGTQLWOh0+eYO8dfNYBmBN
 EpQjqvw+ZP1z43LAneCDERQRpIczwT7bJgS4sNcweLecq8OIxMkKVeMeRAjukHEBwoPctG1uX/H
 HNCd2cNYb5yj6pCOStoy1ZPAj6XAYkakzTxOtQzRTUJBjTiWCi8uSH46w5WWKFqhnniyatxIh0v
 SD7gwy0b7oWFFrgVKADzep/tPccV9+lhcVDJc2WB0sbRGtQi/db+ybmKy8aHoXgGHG/Azq7X7Je
 0OOFTPjpwHeq9MrMw1pRnbKt+I+igRJcI4qD+uO0+9mb7DqQMVf7MDPoPvfL+jV8+HXzQj9o2ev
 z1n5LPdYBWSkefaQtibERwdx8SOt/8ztX44E//LUWJ8Vprf/Kz68g2xBTovlMPU8nF/gDcD3Txf
 b4HjSg/Q8Gz+hbbpk4Wm6C7LzhmqUG5rxL8QiAi5p+21DxXzet0pql3oM68hKomObE/b4Z
X-Received: by 2002:a17:902:cf0b:b0:2b0:5cb3:e4bc with SMTP id
 d9443c01a7336-2b0cdc3c274mr36729855ad.16.1774634939594; 
 Fri, 27 Mar 2026 11:08:59 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc783099sm89686925ad.18.2026.03.27.11.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 11:08:59 -0700 (PDT)
Message-ID: <48d242e8-9585-45db-a10e-83eff7f1748d@linaro.org>
Date: Fri, 27 Mar 2026 11:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] target/i386: emulate: remove redundant logging for
 unmapped MMIO access
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
 <20260326233130.59392-4-mohamed@unpredictable.fr>
 <6a000434-cebb-4076-8350-32f7baf48493@linaro.org>
 <5B4AB65C-64C1-45FE-89C6-3081AC815045@unpredictable.fr>
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
In-Reply-To: <5B4AB65C-64C1-45FE-89C6-3081AC815045@unpredictable.fr>
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

On 3/26/26 5:48 PM, Mohamed Mediouni wrote:
> 
> 
>> On 27. Mar 2026, at 01:38, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/26/26 4:31 PM, Mohamed Mediouni wrote:
>>> ReactOS's install ISO does a bunch of 4-byte accesses
>>> to 0xffdff124. This doesn't happen for the boot ISO.
>>> It looks to be an access relative to the Windows KPCR
>>> which is at 0xffdff000 but mistakenly done prior to
>>> paging being on...
>>> As this logging is redundant with -d invalid_mem,
>>> remove it.
>>>
>>
>> It's not obvious why it's redundant, I don't see another mmio write path from exec_movs_single.
> 
> Hello,
> 
> It’s a bit long but it gets there :)
> 
> For example on the read path:
> 
> exec_movs_single -> read_val_from_mem -> read_mmio -> x86_read_mem
> 
> x86_read_mem_ex -> address_space_read -> flatview_read_continue or address_space_read_full
> 
> address_space_read_full -> flatview_read -> flatview_read_continue -> flatview_read_continue_step -> memory_region_dispatch_read -> memory_region_access_valid
> 
> and memory_region_access_valid raises that error message with -d invalid_mem
>

I didn't try -d invalid_mem on x86_64-softmmu, but on aarch64-softmmu, 
it can be more noisy than guest_errors.
In this case, your analysis proved the message was a proper guest_error 
in ReactOS, so I think it's worth keeping the warning but in a different 
category (guest_errors).

> And on the write side it’s fairly similar, with it ending on memory_region_access_valid
> at the end.
> 
> It’s a bit of a labyrinth though.
> 
>>
>>> https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   target/i386/emulate/x86_mmu.c | 3 ---
>>>   1 file changed, 3 deletions(-)
> 

Regards,
Pierrick

