Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BDEB3629
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7Mh-0007T4-Uq; Mon, 02 Mar 2026 12:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7Mg-0007Si-Fq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:47:30 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vx7Md-0003mP-Sf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:47:30 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82742aa5a3eso2225936b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772473645; x=1773078445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=H2YO6rYSw51nUsTzbnCp1uV4PbREe2ELUJ/5aVOWoOQ=;
 b=osPZJv9zBAz297GkuUyUw3/W4nWcMS/p2tXdY/NnN66Uf5XEHjdfR3FMjjRF9GbdBH
 07BBGADyEnKZd9uVq8JfL4M82QbPLadKMkG62clIMJmAMnjTwrkLBksP0qZbGjxUpuLf
 Aw/dQjwV3xuspglDY5NoRsB5LnIn4KDi79WzgBBaHxYW+41Vsp4sHrb01QdWQZ7xGorL
 0DhLZW/QOWvEyYPNAQJ5T2X/gANvwxk0EyXcvqL9ov7fJ7bdpOqnb205s+rv1y400U07
 gx5FhAMe89zLkPqRz3l8J98DianD0TuCf/OiPPZBoMAEbzEkb9jg7Rv9xoYsBnOI5A/G
 2OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772473645; x=1773078445;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2YO6rYSw51nUsTzbnCp1uV4PbREe2ELUJ/5aVOWoOQ=;
 b=dbN/t1LAg/nhGGBKjN3agFFUkUV9tC55lvkVZgKaE8BYOBBTeJSHsbVLZCJqi6oa/y
 qo4yjIywbNkchsAzKQRe93zL7NfRYEVge6jZtrtRaMJ3OBhcrOQnmazByinRe9d/+fYl
 N663Zw/sChkbC86bykPI+A9tOYP/cEkQ3rmRQZQG0cvF/N6QLKjNIH9IGgxlp3jRjo+m
 9rXt013T8cF0eeHRcyTtDgKXX1BASgwKLunZlXfIKlf0OAqEh57wW6MyOo/q0w4b/UXj
 5WtIrpkdnR4tFzgoPkPug6CH42Y4Y4F+gGRDVLrfoyTsTDeg7rpEQKLkt3HlHZ8GPU6U
 9R4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSw6C0J4Iopz5zlU8vmY6hf1uThWmnI0Jj7ZxnXZlVTNi3FpST8qP2jFpnP3X5K03xEGSradPVuQr@nongnu.org
X-Gm-Message-State: AOJu0YycVe3GISGSS5Gp1XAVdDbDTIWqQbP+i++Gy5CHsJLEzNpD62Oz
 Zd7M/HVvI2w1QxBegCmQmF0/o6n0SCBzmD8/qBDtlPirQLFpbTf0QwcZoLmlGZZ3l+A=
X-Gm-Gg: ATEYQzxUdzBQe31H3F/41CG0bqjSTknWL0FID0l9qhj9O7Tj3LX4qMy8GXi5X7GkLLc
 xe6LXux1nd2x5vTz9FuX6LbdUDKF5tMXFM6ooOmseZvrWnPjjs26KnUq87Vtd4ThnqlvvTvDqom
 FOcEzWhwXbKboy1Bkh2vL/2HUeCfJAyx+nxVyqox67QPTb959VLXM6wbP2srtMRlFbTw3RedTVm
 r2NafPnbi3dwpzzR2dRpyiylHovLVLKm/Uz2cPTG8F1DclRTCayNpEuCMkladLQ6KtxugBoxvTz
 pOXyieU7VUAOBs5bReoh371+s/UoXnD/ekGdmUE1Lqcr0tMzD6cmTGnCWq1eSNjg+HgrfkeeIFw
 1K5z4fAc2sONMUWTNAxAH5uyvJ7WezTJylClJQvGJ2V5X3NRfSFe56ZUgdV52ECtRZLL4RDmW9Z
 qylU+nvPnAj9PfV1GSJFqnNYcpjfhoPYEmflKsC5fXjqTLYsHRlfzEyp0x6NZT7f13y4N4
X-Received: by 2002:a05:6a21:9217:b0:341:d5f3:f1ac with SMTP id
 adf61e73a8af0-395c3b0dd7emr11408985637.41.1772473645223; 
 Mon, 02 Mar 2026 09:47:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae3d19559csm77357125ad.5.2026.03.02.09.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:47:24 -0800 (PST)
Message-ID: <3cff6489-e487-4f7b-b2ea-984fb5379ed9@linaro.org>
Date: Mon, 2 Mar 2026 09:47:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
To: Tao Tang <tangtao1634@phytium.com.cn>, Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
 <aaGu5v0To65M5LkB@google.com>
 <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 3/1/26 4:33 AM, Tao Tang wrote:
> Hi Mostafa,
> 
> On 2026/2/27 PM10:49, Mostafa Saleh wrote:
>> On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
>>> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
>>> and return CERROR_ILL when stage-1 translation is not implemented,
>>> matching the architecture requirement (IHI 0070G.b, page 176).
>>>
>>> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> This is a separate fix, it can be sent standalone to make this series
>> smaller, similarly the first patch.
> 
> 
> For #1, #2 and #19 commit (this one), since I’m not fully sure about the 
> expected process here, should I resend these already Reviewed-by fixes 
> as standalone patch respectively right now,  and try to get them merged 
> first?
>

If a set of patches is fully ready, you can always put them first in 
next version, and ask the maintainer to pull this one.
If your current series needs them to build, I usually prefer to keep it 
all together, instead of having two different series, and using a 
Based-on tag. But it's a personal preference, some people prefer to see 
several series.

Regards,
Pierrick

