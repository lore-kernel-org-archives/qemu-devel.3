Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B896FC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPn7-00026N-NG; Tue, 03 Jun 2025 07:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPn2-00025r-Ba
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:26:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPn0-0005Pg-DZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:26:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ea341570so37828835e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949999; x=1749554799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SyZ1LsBeaOh3rlcOaw1on9A6NvryhnzwGEWTRwLQXO4=;
 b=AO0xxDTxKjo/iHy2QM2wWKKjttn7RA+pSQttx6tJkCVlwru7U9H0HtBIZkpuKcU4Kz
 uR6ioDe50Pb1P1bMXYmpr//I8xbyg1yCJdjixEPTWuqaXlukuiCliM0Zxb1HldA1X6Y/
 CTbMdVEX+IxRrgSaoRkvJB+KtJopEYoSWP18SXNqZ6y55+Q7tG3tZjB6N64r4tGpe+pk
 m50uNuA4W1AbQPnMVkKV9aJToXhcCuCGDL9mxF/W0Hd289QBdGB1gMO+tNLwHoP5hTBF
 UdDB91jQPIWqeiVNM60gK8GnEgY29tf9gI4CvWgdi7luCJxtBxI6dAGN5JPzspbr57y3
 Rb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949999; x=1749554799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyZ1LsBeaOh3rlcOaw1on9A6NvryhnzwGEWTRwLQXO4=;
 b=bZGPlxfBy6GblUnsP6jfTyIjCy82ntXS02qmpeSjUDULvTRQHdYGh8T+W78DP9TfcK
 YLIo/FtkRo/zK/JmK8CarPhdYZthWd76NbS+3sYJYp0sdiI3QgbbJeXKLEpjiwbxwIoT
 mBOI5OFeJ5N4p78UWOI2ZkDyIgn7wFbQ16+9eiYPEJnr7dwq2ZYWxa61jKWUtUmbAK+4
 lV++NAl83Dn2FwZ/C5r0H/e7C5N6tJL6cpOcBr+lo3hfpjS58eqn8iXBVnb2u2LTp+Fs
 E6lHEDc0SfRfNW3ft4s9JMe2hV5F3TFI3wDzoDS6hoP0lh/w1fYPVb2/jwkxWqDXWQif
 2z1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVL6k9HsW0/MFodSP5c3dVrtt3YMfVhlKL9FmySoKRyXcM/zg+N3/qGoblQ9D5T+Nermw4qWlS4kEO@nongnu.org
X-Gm-Message-State: AOJu0YyS272o308C3YLmX48KJXDL/hHi/7MuhGIG+XzjPrQNjwdCBC2w
 EDLkkKz0G33MU8tUQnlV6WWcjmPDJPiL3n2NbkJzNoST9Tgp+8ByUCFqCTxISpGZka0=
X-Gm-Gg: ASbGncuLLeceT01DLyJo48wjNWY4twOypGKuYmM0qOdCPrLz9H8F5Ak/9lMYtCrWCBO
 y2tAXjJMMSGL2DttMYKyTntkwW6oNvTHLzCXlVXiDvS+60tfpe697uavzHaqU4NScEYDxh9FNhr
 UBLPaPR4Q8eOSk1z6RANJOL/wxBkAPQPH2NgoepoTH3+y45FnZmMkqmT13RigdixvjylgKc0kMQ
 nRBlqd/TPwEoi9V1C0FFKi5+GEyL44+pLhqMD/vuGOmv5/NT4oQgoqdjT0jaJPF92Uo8bC4IHMk
 M/izPOIxcPXDega8nUE2gSlAeyOG6MGvnp1DI9D3fY4ONAapnbrHbeDewO+w6iq5GdB/37294r4
 V38VA0BXt9fk3e/6M/tSjQ/OQKc8WEsVUt0s=
X-Google-Smtp-Source: AGHT+IHFgEgRw3iwnsUB6ylL0OHmKbJ/4KTxGR34WlP1kUZeyYbAA48fFmu3mpp092uQFB/IWigDIA==
X-Received: by 2002:a05:600c:46cb:b0:450:d5f6:55f5 with SMTP id
 5b1f17b1804b1-450d882b463mr129921595e9.6.1748949999407; 
 Tue, 03 Jun 2025 04:26:39 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f0097205sm18089079f8f.79.2025.06.03.04.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:26:38 -0700 (PDT)
Message-ID: <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
Date: Tue, 3 Jun 2025 13:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: Xiaoyao Li <xiaoyao.li@intel.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
 <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/6/25 05:04, Xiaoyao Li wrote:
> On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
>> Use PRI formats where required and fix pointer cast.
> 
> Maybe we can make 32-bit build exclusive with CONFIG_TDX? since TDX is 
> not supported on 32-bit host.

Yes please!

> 
>> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   target/i386/kvm/tdx.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)

