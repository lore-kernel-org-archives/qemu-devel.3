Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11271CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kwW-0006Vk-41; Tue, 14 Oct 2025 15:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8kwR-0006VX-K5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:44:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8kwG-0002Gr-1r
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:44:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so46447775e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471040; x=1761075840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOeurXAkir1Ea8+e0dMMj0YaDS6oMfJTkfGBcNEy7fA=;
 b=nCw0hyQqcXmkj2rNxGaKcV4GjEGSUw6vvbnMWnjXWKi41YjpJ3yLbWMx9DQiYZjVvu
 fVg/1zCZCZojn0g6mC4MQIhjMscQgtcGM2iMWMIuNXb0XIADnNEXzvoT4cvocWXMmOsf
 Iaa7dxO6aBsrb2HIK1IchLenpKEMy+9toLABoD1uweD/qWXMKHUIyadUeha4sTz76DRc
 vVjkb7qhFUh4zmQOWvkD0IdhAjAb8QJn0RxFrWTQa4FlojF4xiRCW6bg3LSVF2eIFZ8C
 x6iI1RldwquAlJ0UAy/HzJjVdje1Bi9rc46cLsPW0DJ8/zzHjuFdUG4+QI8xmSBCL734
 XE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471040; x=1761075840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SOeurXAkir1Ea8+e0dMMj0YaDS6oMfJTkfGBcNEy7fA=;
 b=aw5YX5Mu+94EdB7sI/OlGxWKDrspuTa/tyTBw2S1MKIHsqdp8mza9+d3vxWvqKkBhb
 q/TuOZhnUSLuRxJatvvotUkWs3B0xDNnC9F4YQwPoz9oY4TaUC1YzeK93vv+6fiFRGb0
 1X4G5IP75zvLjt0aPaA5pon1naZeiRQhqOvo+7TsNhmi+9SLeu2Q32UkiseMzP970sf/
 Mnrxiq2kuAh6srxgqdpydafT/xEOb+spJaSBuIItR1jYlHY21/e1mswlXUYOUmctGUpT
 tmNpg/cJOxN/2fbYw6t+3g9mmJ/ArXqLkur63rvNr8RA1p4ZwJ34pnRC0mMED2qiJGyX
 Hj6Q==
X-Gm-Message-State: AOJu0YzloF66yiUz12LxkV29TWUpLWlv7LKz9LT4Xzv31OA6LO4MWtfv
 lYtCYxYEAPBvzQHevL6m63sI+SICKvAFqVOXtZDGLOrLb1YwqGXt73Xowr+Baxz+cusiKgUET3t
 FFnq4ea4RJg==
X-Gm-Gg: ASbGncvmedwD6NUjulndEyBZxP2CCiMXUVDLplPsd92lLDz3j5Cz1jRFf4JXbKYQQHD
 7W0j1Hp5TAstYybpGVHHJuz9MdHJdKRlFrtXvT6seLN9skT1A3H4U/+moKyad3lLlYX5MgHY/DE
 a878DaSJJcJc4WU7blHypNNfbEoJXlmGmJ9+T52EPTHsGbpw4mui3a9IjBLsCg0u9UIK+7XOp4p
 JBpajtl28rTcgEHRGvD3b+0v/1kbT0pxvvZn1pgXT/8Ae5S0lYeR9ArcymspCFSfI/WGOfVDiHW
 8dOJR4v52BXiTX56kWAmRiKQfKE+W4Ah6X1UvGB6AG+2/SDgEPttvVPen2C9WC+QXbztdZixj7g
 0gDAsErZ3n51Atesh56FwusAFkuizPlrTE9pBCbHpPIcB1ZqzUqk3ulBT4TziQ3I0aYAk7dadBI
 j/57Vw/ZRhnRyB
X-Google-Smtp-Source: AGHT+IH0KXm/oOSnLKkVen6OrIIr+1/i3BdcWdM8D6/ziR1qguuFgTqujZCmgt8AmNHNaH8kIiMGyA==
X-Received: by 2002:a05:600c:1e87:b0:46e:4b89:13d9 with SMTP id
 5b1f17b1804b1-46fa9a22e67mr180653425e9.0.1760471040474; 
 Tue, 14 Oct 2025 12:44:00 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fc57530b3sm139481005e9.12.2025.10.14.12.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:43:59 -0700 (PDT)
Message-ID: <0e246345-6296-4df2-8f1e-4c8beb9532f0@linaro.org>
Date: Tue, 14 Oct 2025 21:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] target/riscv: Centralize MO_TE uses in a pair of
 helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Alistair,

On 10/10/25 17:50, Philippe Mathieu-Daudé wrote:
> In preparation of having RISC-V cores changing their endianness
> at runtime, centralize the MO_TE uses to a pair of methods.
> 
> Except the 128-bit LD/ST change (first patch), no further
> functional changes intended.
> 
> Philippe Mathieu-Daudé (13):
>    target/riscv: Really use little endianness for 128-bit loads/stores

Are you OK to queue reviewed patches 2-13 (independent of patch #1)?

>    target/riscv: Explode MO_TExx -> MO_TE | MO_xx
>    target/riscv: Conceal MO_TE within gen_amo()
>    target/riscv: Conceal MO_TE within gen_inc()
>    target/riscv: Conceal MO_TE within gen_load() / gen_store()
>    target/riscv: Conceal MO_TE within gen_load_idx() / gen_store_idx()
>    target/riscv: Conceal MO_TE within gen_fload_idx() / gen_fstore_idx()
>    target/riscv: Conceal MO_TE within gen_storepair_tl()
>    target/riscv: Conceal MO_TE within gen_cmpxchg*()
>    target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() / gen_sc()
>    target/riscv: Factor MemOp variable out when MO_TE is set
>    target/riscv: Introduce mo_endian() helper
>    target/riscv: Introduce mo_endian_env() helper
Regards,
Phil.

