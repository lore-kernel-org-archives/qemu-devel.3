Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C517E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZqd-00023l-Nl; Wed, 08 Jan 2025 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVZqc-00023N-OO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:28:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVZqa-0007QC-Fh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:28:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so970555e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736357278; x=1736962078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUrf/I7szr0Lo3YFGSMczd6R9et4GhqfnMxy0XToLzU=;
 b=l97vEQVBMahQDEBcM7tuJp2HbMLaLFMjxE/v1oR/OiOQL6UX7bn1F/pXztY0hYQgbc
 Fa2V8SvKqOmPlR4LcJmj4iv3Xyw481MVISEr/sATkOGw7rHYHMf4qGSxHldCOcE8OkKN
 3fp8el3vEjXupmoekw3lJ8i3xu8QF/zpyZjn5yEfghAtb/WzYBeVUXiKumE4L3oO6UrS
 I0WiqNH15qEj0f0+ZVISMG8EpSOWAl6/KSL0K2UsMXxeYMBeTCbqMh+te6TU3aOllcfd
 mZPebpESgM64oUPv03Unc+1b+od86s3pmwmPoFWQNKx58XyGdJFtLy/5VbqlxnDz9iQi
 ca2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736357278; x=1736962078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUrf/I7szr0Lo3YFGSMczd6R9et4GhqfnMxy0XToLzU=;
 b=caXovliPKH49AHLuB0TlN1aUZ24blYVivpXi9UrkVBQ3B5B9rRFZISHzjaC2WBoMPx
 fbNHq5ooNiN97xsNsFewmdqR7+FBSXy1+evVyfgiv6kSag25SbmTCTLpyp5+2ZDc1jIP
 FGEat3UInJ+DRLhezQ5SrL4jK0+DaKx6VG4getOG8Uf0VzRIF/VdTewL1zMa+tV8+nlD
 apR20jtdx/BjM0a0PDxDInrfLDeiNa/fqLj3+P4yrSIphBx+KNpmpYIis57PFxX/MgoO
 EdND5lcxXv0DsxRQ5QkEEwNs9cJ1F+16lDMY58iKfFtuUw2/lGT0mFN2cKu0db+ymMl2
 JEOw==
X-Gm-Message-State: AOJu0Yxt7fzv7m0TQMp1BrpZO5Ec+t6stX1j5JH0AquywVeW1b86KZP5
 DxyvE9Og71Eexs+mbmRdW0UYA2VdEAEbLqMhZkzypj2aoKJS461aBC9qVPVtgfs=
X-Gm-Gg: ASbGncuzoTJByTV3uzS1oeK03eYKBlUS8N47SLeahKCccQS7nu0jiw1efeFCEkwcPdi
 2+lHHIVIE4F+TwMIFByrEyjALHMlWiV1+Djci86Xmm455HyEy9GyHgoxAv5nxvKpKWas2KmLiUw
 Te8PLfuAy7/e6drfhHozMKoBjIw+oJ7oecPem3WSlGqdon8nM+RwuVEkZO3Tnr2rguYMMer/4UP
 qmHin5SCKTq8HF67QBeLUQWlXPADzTVTK/v6eb/VqzvxI5rpJFzu9uouaiPuY9cvyQ7OFeQvY4g
 hwo2sRjwY6m0bH35mgSXvSn1
X-Google-Smtp-Source: AGHT+IFcSvPNN8fXBrreM1e6r/7/HcomRtMM0zZeKp6WgWjGHrkYZlZIY93ZlTNWoA35jR55zrqCFQ==
X-Received: by 2002:a05:600c:1e08:b0:434:f7ea:fb44 with SMTP id
 5b1f17b1804b1-436e26bea4bmr35757545e9.14.1736357277631; 
 Wed, 08 Jan 2025 09:27:57 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8a326sm27687625e9.35.2025.01.08.09.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:27:56 -0800 (PST)
Message-ID: <a6a821bc-ddec-45fe-b593-a4d694209236@linaro.org>
Date: Wed, 8 Jan 2025 18:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pc-bios/meson.build: Silent unuseful DTC warnings
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231006064750.33852-1-philmd@linaro.org>
 <0038faf2-3e3e-57df-5ed4-9d4b53c8df75@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0038faf2-3e3e-57df-5ed4-9d4b53c8df75@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/23 13:40, BALATON Zoltan wrote:
> On Fri, 6 Oct 2023, Philippe Mathieu-Daudé wrote:
>> QEMU consumes some device tree blobs, so these have been committed
>> to the tree in as firmware, along with the device tree source used
>> to generate them. We know the blobs are "good enough" to have QEMU
>> boot a system, so we don't really maintain and rebuild the sources.
>>
>> These blobs were generated with older 'dtc' binaries. We use the
>> v1.6.1 version since 2021 (commit 962fde57b7 "dtc: Update to version
>> 1.6.1").
>>
>> Since commit 6e0dc9d2a8 ("meson: compile bundled device trees"),
>> if dtc binary is available, it is directly used to compile the
>> device tree sources. New versions of 'dtc' add checks which display
>> warnings or errors. Our sources are a bit old, so dtc v1.6.1 now
>> emit the following warnings on a fresh build:
>>
>>  [163/3414] Generating pc-bios/canyonlands.dts with a custom command
>>  pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): / 
>> memory: node has a reg or ranges property, but no unit name
>>  pc-bios/canyonlands.dts:210.13-429.5: Warning 
>> (unit_address_vs_reg): /plb/opb: node has a reg or ranges property, 
>> but no unit name
>>  pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): /plb/ 
>> pciex@d00000000: node name is not "pci" or "pcie"
>>  pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): /plb/ 
>> pciex@d20000000: node name is not "pci" or "pcie"
>>  pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed 
>> prerequisite 'pci_bridge'
>>  pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed 
>> prerequisite 'pci_bridge'
>>  pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed 
>> prerequisite 'pci_bridge'
>>  pc-bios/canyonlands.dts:268.14-289.7: Warning 
>> (avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary 
>> #address-cells/#size-cells without "ranges" or child "reg" property
>>  [164/3414] Generating pc-bios/petalogix-s3adsp1800.dts with a custom 
>> command
>>  pc-bios/petalogix-s3adsp1800.dts:258.33-266.5: Warning 
>> (interrupt_provider): /plb/interrupt-controller@81800000: Missing 
>> #address-cells in interrupt provider
>>  [165/3414] Generating pc-bios/petalogix-ml605.dts with a custom command
>>  pc-bios/petalogix-ml605.dts:234.39-241.5: Warning 
>> (interrupt_provider): /axi/interrupt-controller@81800000: Missing 
>> #address-cells in interrupt provider
>>  [177/3414] Generating pc-bios/bamboo.dts with a custom command
>>  pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: 
>> node has a reg or ranges property, but no unit name
>>  pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): /plb/ 
>> opb: node has a reg or ranges property, but no unit name
>>  pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): / 
>> chosen:linux,stdout-path: Use 'stdout-path' instead
>>  pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): /plb/ 
>> opb: Missing interrupt-parent
>>  pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): /plb/ 
>> opb/ebc: Missing interrupt-parent
>>
>> From QEMU perspective, these warnings are not really useful. It is
>> the responsibility of developers adding DT source/blob to QEMU
>> repository to check the source doesn't produce warnings, but as
>> long as the blob is useful enough, QEMU can consume it. So these
>> warnings don't add any value, instead they are noisy and might
>> distract us to focus on important warnings. Better disable them.
>>
>> 'dtc' provides the '--quiet' option for that:
>>
>>  $ dtc --help
>>  Usage: dtc [options] <input file>
>>
>>  Options: -[qI:O:o:V:d:R:S:p:a:fb:i:H:sW:E:@AThv]
>>    -q, --quiet
>>          Quiet: -q suppress warnings, -qq errors, -qqq all
>>
>> Update meson to disable these unuseful DTC warnings.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks, patch queued.

