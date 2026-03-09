Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD33FCA170
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfAw-0008IO-Hd; Mon, 09 Mar 2026 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzfAo-0008HI-Te
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:17:46 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzfAn-0000Nv-BV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:17:46 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb40149037so1270684585a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773080264; x=1773685064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+R4o+BrQrFfyZH2D1qKyt9Ofr35TRhFtMT6NW16++I=;
 b=zybkRPOdW16hNAQUrSN1bCPWLQW46hwGtVGZFPS6CIT716ybwrdnY+Ol/oRBoZsAGy
 NHkbZZcpvpXLVslVxku2sahjGb4JSsWjQFBAK/ixgBiTBVtGqhyyp7IUYba1YBcoPqrP
 hg2ulHvdvzHHuqiz+wiLHmQXnEI7bvyLEmhu2P5JiVpEPy4kAG4SOXuNkSpqKj6CtBdj
 oNj50x6F4h+wFjXKuZS72nNjP0PT2efv1BmTt61031ptITR6aPQv9BhnbamwhmivnUoy
 u3lQTeOCUe3P3ZxEiU4VTF17KDwMBWMZU8eilcDJHlR1i8IZrKbBFEJUK57S3r67hsA4
 OXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773080264; x=1773685064;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+R4o+BrQrFfyZH2D1qKyt9Ofr35TRhFtMT6NW16++I=;
 b=EICqwcazXPYNX4Hng3W55QU/GbCBICA9QSGDwhbfEWxUDLaf45cRdAJRi9WOu0YDu5
 nJqVHeO2ACsAzsnlxknfFE6WJ01owsXTWgF4xA2mWc4zBHCoQddWVzNohs1iKYLnAx7f
 mvSXDoBIDnOzlxeP7OeWpLSgc5UgJMbT+MOP3ucHRS2v6mE+NirHGJOc4WyqonbF+AyO
 Tq0kDfAK2Azz2oWM6z5dS5uy/KoSEuXQl3cl7FrJyvdcfHmEYu3+/XHblTO4dMsKWNe2
 xaXx5RmYkWSu+q1KYWNByBQdX8q6FCvuejMyo/qRHnIa/NWbu12a/Tk21IpYFusNbmMl
 +Wmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVssgrc7k9R4IoMkTUsc9qeRhzwXaHcNVaWktnKJrCwey5w4BVsjtQv/wBQyDktdNDmZUkiTYcty1Qj@nongnu.org
X-Gm-Message-State: AOJu0YzsCKp9wbbNrENQLkabHWElWqZYtkSBYXnGjH/Wg69R3mBIUp3s
 C8DrjuQrH8WUwMNX5zvbC9CF0EYUrEUlXm/m8NJDOGJgFki8HouSBrn++2HTAQLKHQk=
X-Gm-Gg: ATEYQzz370CzkDUnkh9m8P1sG8iwf+CuajBKda6djcacG/EPyQWjbsSQSvWEB4O3FM8
 euFbrgg+rjmiadn7FsThKl0yJU5GmysR9E+zfW8lJJRWsJ4mgfurzq0mF2L8UK9FFqTx2ls8laf
 VO1Gal4gyUqhS2U5JtcVhg4HBDefcJf4jGpY1Q809c2ZdzjcfjzOKDUCkdUopmZ+mIWO0677QvN
 iDLfjpqf+gayOHNQHrj2OjnWghoDLPUX04hg+JS/NHrTSZIfc4tl8MqadSuwmlVpZVeAYT0JZ4U
 PNWMjfBLlXiOORAPBk2fpGxffQeqfIUqOSlOqnI6c/2teF9Jgqyq3OHupJcm6wpnjQhLC1E8rFS
 r7S59PKiomnb30Mn3MtTXO5dUG4mB3zAqUd8kQZFe+iHfqGNvWA+xjzvqPLSZ4ZfAddyPi2+cEJ
 nR9slQWf+KLMOP1BGvrW/dXWisQLusX5/85MIibMfE+myHX+Iv7xU0/JBgQyiI0id2AhQA
X-Received: by 2002:a05:620a:44d1:b0:8ca:2baa:766 with SMTP id
 af79cd13be357-8cd6d40d296mr1626454385a.2.1773080263786; 
 Mon, 09 Mar 2026 11:17:43 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f57291esm798679785a.50.2026.03.09.11.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:17:43 -0700 (PDT)
Message-ID: <b9c77055-e055-48fb-b504-6a00f912b4c9@linaro.org>
Date: Mon, 9 Mar 2026 11:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional: add VBSA linux tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260309174841.4184117-1-alex.bennee@linaro.org>
 <20260309174841.4184117-6-alex.bennee@linaro.org>
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
In-Reply-To: <20260309174841.4184117-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x731.google.com
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

On 3/9/26 10:48 AM, Alex Bennée wrote:
> This extends the VBSA test to run the linux tests. The sysarch-acs
> test suite does provide some pre-built images which is good because
> the tests require a patched kernel. However due to the structure of
> the image we need to jump one or two hoops to get something useful:
> 
>    - download and double decompress (zip then xz) the image
>    - navigate grub to launch the Linux Execution Environment
>    - shutdown the system once tests are done
>    - extract the logs from the MSDOS file system and parse them
> 
> It does make the code a bit ugly but it works for me at least. So far
> the subset of tests run is limited but that might be solved by adding
> some more devices to the PCIe bus to exercise the SMMU behaviour.
>

If I recall correctly, all TF-A tests concerning SMMU are based on 
SMMUv3TestEngine device, which unfortunately has a proprietary interface.
We would greatly benefit from all this is Arm published that as a 
specification, and this would remove all the needs for ad hoc SMMU testing.
Or we could reverse engineer the interface from how tests exercise it 
and implement something similar in QEMU to run original Arm tests.

Regards,
Pierrick

