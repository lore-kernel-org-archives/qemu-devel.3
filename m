Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HsNgUZBS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKb1W-0001Cs-OG; Sat, 24 Oct 2026 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKb1T-0001Cg-TB
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 08:38:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKb1S-0005aa-7K
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 08:38:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so942121f8f.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792845530; x=1793450330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kJ2na4HDMHmXNK3g0DgbNHBC1KQfYmZ3vuOahOE4Mwo=;
 b=HsNgUZBSPrnMWfldZmra+oc9qLnxkZdMlcW12gZj+XjPpZ15y4TQD9lyXaJtGe0VFU
 wZ3voz2Jqasa9NPbJZcG5UIL2im2WveHe31vr7O3mK3pSt32EYw7qF+b6uHkKABjvV8d
 ZiB4+YRo6EhAO+KC9gfU9st9FFdaSyHw0gYx3vy0wvQK2Rrdf9rilTuSLyEbHtBEvBx1
 GzKAoGp/wuGj3P9cFSxqFlDmZzEX5sG0Ux+D2QAncOcvZsv09ITjyNY3FV+hLyVrvsk1
 vOG7nrF9ZDG30+ihmx9mouiJIjrweWECfC5UzqDvvGh7+fJTKDtOPH/8Ag5RGqOjv2kC
 /syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792845530; x=1793450330;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kJ2na4HDMHmXNK3g0DgbNHBC1KQfYmZ3vuOahOE4Mwo=;
 b=jI+yE/F/7IVf6Ri8Ztrvp2VZ8/DIkChut1B/Pu9wHuXWzvyLkuI6FKRB9IbQRUBj1r
 Pdg7jPyPrAISjEJcD1ZthR6RkVwvMDVZnZc21G3qyiNDpJEeas7vDUKH8AWLIYmtILZ1
 ltg+MXZIBOvyalCf2xhP3iydDz3G7QCsnEP8Kygh2UfSxqU0+VsIdyT9/80dxZGxNDSz
 Rh1aDOjeYLANJJ5kwh7KYXuXzu3lMl/vgMI1V+v0AVA+VCsPlUSZlgy1IskAdjlJEuw+
 x9ESzEfKeS/N3in1h6zg+bOSKXV/ZVqUzW4T1Mbt69VvHKjAJtom+t7fZSOqAysBlpc4
 DeMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcTyVgDYW+RboCCSocssKr9WaBNaqcmEAonsVFx8UIv3aLkUMNGuWNSSMvbNtQDEbzRcWlfVYlkNPx@nongnu.org
X-Gm-Message-State: AFq9FYIqPTLoD5bGC+chhYfKm+JLS42Wx33n1jm1QN2qJRbUuLMkyp6d
 gqVu9MO08b+olZZd2q5ivvg0qni3pjTBrnZd0TkOj3EIS/CiwDF8BGg6cqBaMI3ossQu4dhgH36
 zGwKZ9HE=
X-Gm-Gg: AYBFou0WzL93e543nNpphSW9HD5xQIO9xdpUG1aZmQ3Z91mtTGfHk7jqlVrFStVCSGx
 XTTGIU3S8OSwgu5NJC8lBHQeAMBDh5+gSegArArA8LzPg2GAP2yCdh2X57c/i4rDz1UN4vDnWw3
 UW5GZkylB/Llk3ihUEofk3QGGJ5QIG3CDLVSspHlzK+8WnrxT1SEf0ppOjSefzWnvaD5o0aUIML
 jSRo9RfNM22JPJJiTSRgw4EP6+zkCMKkyLNHqJLUZpQEJP4Yhskv+kJ/9bddp7f06NpfctTqM2+
 wn93/sD26flv6z2bSIrvBJN2D8bNPgNumh2mO+ghTbQx5v8DbDJrJOngzoZ2yYQjpvktjXLdgki
 eLFDLznrd/KHrg/gVUKVTC8m50WGNL44dvw79OXQ2xa4bnUD9rTZ0eg8MxquPwG2ZjoDLKia2BU
 TEdskdPVe1lLR6+6DrhY/H3xuqozjCHe5f27REle/rBZNZOY/LpSJYqgPT3mWhIy+3IfkJ4kvio
 juuO/UhqZcd5TtupGCWWbIrr2MlhaGIGOUpaB94AtPY+EL3A6p7NKuaoWesN7LBXTSg
X-Received: by 2002:a05:6000:2501:b0:48d:f14a:9173 with SMTP id
 ffacd0b85a97d-48e3eb247a8mr2883355f8f.8.1792845530229; 
 Sat, 24 Oct 2026 05:38:50 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm4481921f8f.11.2026.10.24.05.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 05:38:49 -0700 (PDT)
Message-ID: <278e00e7-a5c5-49f4-a491-45556c20640e@linaro.org>
Date: Sat, 24 Oct 2026 14:38:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/83] Misc target/ patches for 2026-10-23
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261024095151.67948-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261024095151.67948-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 11:51, Philippe Mathieu-Daudé wrote:
> v2: Dropped alpha FPCR exception status fixes for IEEE-mode code
> 
> The following changes since commit ab5b7ba3794a016663c7200a92045fcca3ed7f1e:
> 
>    Merge tag 'pull-loongarch-20261023' ofhttps://github.com/bibo-mao/qemu into staging (2026-10-23 11:45:20 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/target-misc-20261024
> 
> for you to fetch changes up to ee7963229f6627ebed1b26b8290380026b0ca4b4:
> 
>    MAINTAINERS: cover riscv GDB XML files (2026-10-24 11:48:48 +0200)
> 
> ----------------------------------------------------------------
> Misc target patches queue
> 
> - Make TCG halt-to-exec transition explicit and remove cpu_exec_halt()
> - Various conversions to translate_for_debug()
> - Add common CPUClass::exception_name() handler
> - multi-target: prefix helpers with target prefix
> - Remove target_long_bits() from GDB register reads
> - MAINTAINERS updates

Applied, thanks.

r~

