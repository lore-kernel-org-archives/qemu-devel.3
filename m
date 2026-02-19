Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B951E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7sH-0007W8-IM; Thu, 19 Feb 2026 12:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7sA-0007Or-Oj
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:31:34 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7s8-0003z6-Td
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:31:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso8690415ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522287; x=1772127087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/iLFkIHXUCVufy5nokAySZxAU4ki/40SOws5HRuqG/Y=;
 b=M5cJoCR9KRnrAPak41sox9f4e35KhFQFDUCkiOu5URMg1+mj/1ZOGkqpVejwtGzjht
 f8Kc8OxyzNqkphaC6Ocv5NoW55W/ehO2oyQag+cXZJ8Ak7augw4U1bw7YVoRd+IHXQYR
 FmSbQJ+Tx5gxdvldLezwD3pUqaViFKCVrBSCAXeIsbZRQhCuii+H3Xctm0Girk6MpvAW
 FvIlhmzUm5E5ejNO+UFhLmcIfRtoTrQv7iPtkT/xqP5AQHGP+lJxRXK+TuK3wlg1gwkY
 kJ4OvR/rqVI4hg1uYPmsK6tL+uPHA/4bj0zeat8yaYEUSqDhN1UYXget9QQSPLqBEah3
 gq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522287; x=1772127087;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/iLFkIHXUCVufy5nokAySZxAU4ki/40SOws5HRuqG/Y=;
 b=PxTNU5EBh5ewVaYSLsw3RrN9M6hqPZBNI/NALBW+cgZFvRTmwud2PHY+t3A+tCZgs5
 S6ewNfEk/6jrg2siLkPBUpvtxJYXZghSdDpWc39ZNx26OCcW5g77waenq3ARfGLjWX60
 dBGIMu6NtKcfGYtqZR9xuK+zF9N1/iRU69FsBzHKsK8iV3gkvoX7DId5HvrxhIOS9WXd
 6fhIkZ8/U6nucTjysTIdtAbypd66QVn98e792ICNrP3au0QwwqykaVBoAgwxC0Tj6eu6
 Ss8H3Nup6ZOwbmhpVNU8EUc51pjT2g3h95GiWM4biztldvNb+62z1Crm1oS8ym5dlrgM
 VG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg+tPLR30f5dIwHJ7NOD/4fNGbjpcSg7rVE5iyrKDECJCtF8o4enZ0ftIwnUe3ewNkwb5L0Jh3ZNnz@nongnu.org
X-Gm-Message-State: AOJu0YykV2+MDbbN/YaoTdmsGl6J8TQH6WWZWjDWbGz9/M3X6t/ggYF3
 o1zvmXZH8htg2OxLDI8ybINeZzAyhoFR79EvD3AYLBqEqHGl7AOifCgA2F911lfZBKI=
X-Gm-Gg: AZuq6aIIBZe/qRTRXOkDIa9M1nod7+Y1EjsST9sY00qydrPgLmGLBilmGrBXobTdbNl
 Jq85DsPlU5C4DdYi17cYdqcEdc36p2DX5CLXXY3EllMXXynHyjK0V+KchK0oZNRwsD+KQFyaLZ9
 pE+KNUd/EFU5Pf6zAaPxX/tPtawoQqsnbTCSEKs6hu6SQubu8khzwp+5CTOox5zmvIDtATjN4n/
 fzuxNtn154uOMFGijef5BKauNCPHcJSHsV7MfQvCOPMF8/lFGLygzEL/VActZX5GG/iqvyk2PqD
 3cn4gGTuDP6aiRfL/I6iGUa9VgrcRHDRzNBRxInXPiQPQS7gbmeB1ZU8sg/6sFmltMSx1R+HLub
 U3kdUEd1/U9h7Nak9u6N3fsYnxkcMku4ATbTOiWqWNt0TgZ7JJ0m4+g0NgfQQGOHSp4sOcK13er
 FXyD4E/UPIQGRPHlCgvR8Vg0lvaEG8YLTem2YfbSifcekF4WDM1BHQKPzgNm85hWW5u8BO
X-Received: by 2002:a17:903:11cc:b0:2aa:d605:a314 with SMTP id
 d9443c01a7336-2ad5f7020d0mr24118445ad.4.1771522286779; 
 Thu, 19 Feb 2026 09:31:26 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aae9fb4sm164493495ad.84.2026.02.19.09.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:31:26 -0800 (PST)
Message-ID: <fabe4415-ebc6-4766-afe1-277fc4ead9d4@linaro.org>
Date: Thu, 19 Feb 2026 09:31:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/14] hw/mips: defer finalising gcr_base until
 reset time
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
 <20260219171810.602667-8-alex.bennee@linaro.org>
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
In-Reply-To: <20260219171810.602667-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/19/26 9:18 AM, Alex Bennée wrote:
> Currently the cpu_reset() in mips_cpu_realizefn() hides an implicit
> sequencing requirement when setting gcr_base. Without it we barf
> because we end up setting the region between 0x0-0x000000001fbfffff
> which trips over a qtest that accesses the GCR during "memsave 0 4096
> /dev/null".
> 
> By moving to the reset phase we have to drop the property lest we are
> admonished for "Attempting to set...after it was realized" but there
> doesn't seem to be a need to expose the property anyway.
> 
> NB: it would be safer if I could guarantee the place in the reset tree
> but I haven't quite grokked how to do that yet. Currently I see this
> sequence when testing:
> 
>    env MALLOC_PERTURB_=43 G_TEST_DBUS_DAEMON=/home/alex/lsrc/qemu.git/tests/dbus-vmstate-daemon.sh UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-mips64el SPEED=thorough MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_SLOW=1 RUST_BACKTRACE=1 /home/alex/lsrc/qemu.git/builds/all/tests/qtest/test-hmp --tap -p /mips64el/hmp/boston
>    TAP version 14
>    # random seed: R02S0d3b1a4f1aef5198107851bdee539e7d
>    # Start of mips64el tests
>    # Start of hmp tests
>    # starting QEMU: exec ./qemu-system-mips64el -qtest unix:/tmp/qtest-530181.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-530181.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -S -M boston -accel qtest
>    main_cpu_reset: dbg
>    mips_gcr_reset: dbg
>    mps_reset_exit: dbg
>    ok 1 /mips64el/hmp/boston
>    # End of hmp tests
>    # End of mips64el tests
>    1..1
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <20260108143423.1378674-9-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - use proper 3-phase reset
> ---
>   include/hw/mips/cps.h | 14 +++++++++++++-
>   hw/mips/cps.c         | 26 +++++++++++++++++---------
>   hw/misc/mips_cmgcr.c  |  1 -
>   3 files changed, 30 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

