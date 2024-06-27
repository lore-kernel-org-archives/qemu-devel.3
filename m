Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C15C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpi2-0000Uv-1n; Thu, 27 Jun 2024 10:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMphz-0000Tw-Pj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:02:43 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMphy-0002mN-6k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:02:43 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so68188961fa.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719496960; x=1720101760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LAK2MWgc/ykY00o71q7fpH3L0gb+GjbMKTYZI7bbceg=;
 b=kjb3Kp0fPnzH86gbsSMpTLGWSHcL2pev0rCuH0MzTxyXeT83gU15uaVaWWz3QQ1PPI
 iHczYp2oBDah6/iyyrElVMKcch9kX/JDLvHwC795qDdPsbZolWRYQwNYfvLx65Fse+3+
 OVbJ5ciIfhVpNgYFBtJrklyyUPBGb7L8+5kBu7+mnUbO5APeRhapk74RaMv2CFUJumv2
 7OHzgx/ZXw6zu4e8AdPpVG2f1B6GBWVDUlPRhQHpAdi2aTpBVuHdSAVyi3J9yM7QkuuI
 DWsRRtbCNKmswbeg9pxsgY3pfDU3+v13H4xxG5KuWssJkUUQtrBDG1Lm4Fd3T97yy/YU
 gD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719496960; x=1720101760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LAK2MWgc/ykY00o71q7fpH3L0gb+GjbMKTYZI7bbceg=;
 b=qU+6WwRdEdtKui+ZOSFhAzSkL+J6tZ/dGq78q3fDYFIJivI8BIeeaNsQGjncfLwOFP
 wy1Vp1x/GqP9hZhAjJAXFRw3MbCRAhKkrPv7ANqBxC45ZFpBppWGT/K8ENpljkXZmPlf
 AxCwV9yCm0WLSPUiVdD3Om+fa34fgSYrl2+AvPoacLq8WOi5zquFJRWK63hMEx6D9hvE
 o5qJXVO0IqesjPHpjeTYW+rOkU8hRTuMqA3J/ldBFstqko33se78qPvTmf2St1fXj/Az
 Ba4wfXiapaV3C6SKlWeOvmYyIhbTtPrFFG/vvqVN5A+ud27HwSq0UnseMhtoKJnRLNSZ
 wOEQ==
X-Gm-Message-State: AOJu0YylGzHYQNlKhWKFazJa3WknB81WJ0raZO59XR2MLJ793kje6+uw
 xCl22mEv35Hlzjfem8fpA4/4iVpGe76ibS5yYAD0LlaIfgeUQPHKVdpVAurpXHo=
X-Google-Smtp-Source: AGHT+IH3xWCTvER4HAhwRdK9XEPdCgyFO8NzgMmoXmMLkpjN11BgH/QgfksjY+F3XHHV93jUSGBriw==
X-Received: by 2002:a2e:8752:0:b0:2ec:4d91:5156 with SMTP id
 38308e7fff4ca-2ec5b31d14bmr98275011fa.28.1719496958158; 
 Thu, 27 Jun 2024 07:02:38 -0700 (PDT)
Received: from [192.168.23.175] (227.red-95-127-45.staticip.rima-tde.net.
 [95.127.45.227]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249b4233b3sm64536315e9.0.2024.06.27.07.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 07:02:37 -0700 (PDT)
Message-ID: <4b713ad2-1f92-49d1-88b9-6185a1b50062@linaro.org>
Date: Thu, 27 Jun 2024 16:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] ppc/vof: Fix unaligned FDT property access
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-5-f3cc42302189@daynix.com>
 <efdfa803-775c-4aa2-b7c4-f016dafe9a88@linaro.org>
 <9fdabbde-1ae8-4f78-af20-b4383b7705fc@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9fdabbde-1ae8-4f78-af20-b4383b7705fc@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 27/6/24 15:12, Akihiko Odaki wrote:
> On 2024/06/26 21:03, Philippe Mathieu-Daudé wrote:
>> On 26/6/24 13:06, Akihiko Odaki wrote:
>>> FDT properties are aligned by 4 bytes, not 8 bytes.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/ppc/vof.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>>> index e3b430a81f4f..b5b6514d79fc 100644
>>> --- a/hw/ppc/vof.c
>>> +++ b/hw/ppc/vof.c
>>> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, 
>>> GArray *claimed, uint64_t base)
>>>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>>>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>>>       if (sc == 2) {
>>> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + 
>>> sizeof(uint32_t) * ac));
>>> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>>>       } else {
>>>           mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + 
>>> sizeof(uint32_t) * ac));
>>
>> OK but please keep API uses consistent, so convert other uses please.
> 
> This is the only unaligned access.

What I mean with consistent API use is either use the be64_to_cpu and
be32_to_cpu API, or ldq_be_p and ldl_be_p. A mix of both makes review
more confusing.

