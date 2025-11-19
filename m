Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB9BCF3189
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfM9-0002AN-A6; Wed, 19 Nov 2025 05:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfM6-00020K-L9
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:24:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfM4-00027s-TM
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:24:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso34408485e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763547843; x=1764152643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jq/B2/Rvq1Q+blwsqCFIefwfSjc9LnYb73ye/qTWsAI=;
 b=IgKAtbmCx/PLgi7ftw7koPR7JcrmaKCWFGsDEZ0ahfQOR3kqMO1sDJND5+YETHSUD+
 DpV6IgEfNa8K5cpwed9udwHYjrwEhVsNainB6mb4R47L6Zf/YJQUmhwvg8mmq5MwbYUW
 9fRf19Pax7uqSZowPV8ZXVrLizo4ySxYrYwcwjSHFewOAp098yNghHj9Lf4wj63ro7d1
 1fzvEdU8iT3TKtx77xNoLp6bPWW8iq8dLFeS8GPNQVFOin2Cr9elsHgGRbNo06KeFVtl
 EkxxbIsSkqdVOiLg4gQbxLX2uF+XPIkMfy1CldL/QQCb0T2h44M/gKmZRsNxCBcScEI2
 6OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763547843; x=1764152643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jq/B2/Rvq1Q+blwsqCFIefwfSjc9LnYb73ye/qTWsAI=;
 b=h7T2iBlAYv3nxdBWUvt/ueZVHLyqW0dfRSj00TQPGxHYirTWpk+9WjpGTxcyytUPqq
 VeMw8ldT+xIf2a8E/bCy+DWtgoZ8+5+aG8PbUJKZGDWO11XHvavqAhMkkKP+3C1omXXJ
 uIBIL05tTsb1JYdpbABLhibIecN0aaZCLDASL9qUPBrR2Krg1OVEdVKWSVBgmakUBfov
 HJy8ns1BLuSLMGC98MtMtyhp5lRqTlfqcmEhPsIUIcZO0H1kS2oUHJXU4O7UDj+irp/l
 nJAQuJmdiz5Xxmmkd+zaEmiAxwj30X6CP0eMmaiJVNIpJhsRSR8/KsW/SZaMY5DxLohk
 OQVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS7eUKtG8nWTBduS9CYNbsWUkE/h/nCAi1EPVMeqhX8uEpqd0ZuxIqSX/vmRxUtnEc2+d32mU20Nkn@nongnu.org
X-Gm-Message-State: AOJu0YwLNiNkW10YpmayxpDO+evAQF9uu5fcCohNefHLkldAcYDbGisr
 kHvy6rnjhasxoS/IJhZyR1pOH1oc4b++xdoUhB5CytAY055iTli1GzegJRC6hA1DtHCsPckJAFH
 NeRxPKu1qOg==
X-Gm-Gg: ASbGncsQd8hbwUZywFMX7vf2ZJCGkDpcS/mpF6SMqYuTXAALeQYWXekHFoqTVLawPC9
 u1ixnVl0u7JPS+ekzRR/ohh0ETnuQNUCDnOz84zl4DizDlcMMcV6XIR/if3zdTEHyzXUQdEgMPf
 c62NSmpdtFdNQJhZDhj/2fnBSZXVG7xKwIq1jlXL9yYcIS1GL34MocHhewqbrF1Kmz5couxnW4W
 P6oUhwUvF9PjFMLyxi3j+F0keM1WDqTFG45Ccls7FmBQRBkR7o3KCSXmXDdv5unGnGhlTjBQ4cT
 rRoNH5XOTJbhhWh2v5mZZ5kn+qqTKEIk8jy+Mr/EqJ/G3IgvQJHQXwQpwor3RMtEk52QU2omgDo
 MzWKztBwMcWzd4HmDTvGdEFsJWSNNqUt5VtYIwkY+PJ4g5N0Hn027XDCdehP7D+z4VbwbkUha9j
 53PUr3VyILfZC+4RcYlbAVYK1edO3j5e1qW/AcLlUTUxYya4oypNPvFA==
X-Google-Smtp-Source: AGHT+IELI341RCjafWY7+B9ikDfLuF9he9lS5yVWKrv/Fj7/iRidll+LEaJ+6BzdGPo02CxXjtrbLA==
X-Received: by 2002:a05:600c:45c4:b0:477:7658:572a with SMTP id
 5b1f17b1804b1-4778fea84d9mr167520705e9.20.1763547843121; 
 Wed, 19 Nov 2025 02:24:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10260adsm39318985e9.7.2025.11.19.02.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:24:02 -0800 (PST)
Message-ID: <4956c439-56e5-4050-be23-67db461945cb@linaro.org>
Date: Wed, 19 Nov 2025 11:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 14/15] tests/functional/aarch64/test_rme_sbsaref:
 Silence issues reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-15-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Drop unused import and use an encoding for open().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/aarch64/test_rme_sbsaref.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


