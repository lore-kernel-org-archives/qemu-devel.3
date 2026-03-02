Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEC9EB3629
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7Sd-0001oD-EG; Mon, 02 Mar 2026 12:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7SY-0001kn-9t
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7SW-0004k1-74
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772474011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8btxV8nPdxJ+CM3cpxhcU/QVzEUYTpZ6jcDlRHIzDeo=;
 b=EQqc3GoUZV8jQTeMTAP3PnFYCPLm/lLyY3HII8yOCl2t+U4aOpkE/qutud9BG7TViHvsoI
 jd+dy9Qs27WwK/HZtL1KkzSLzcWHD4h5+2Kj+fMbJFf9jsVN/6qchNdkc3x8dcJTEMY680
 M6oOcAwvvAqqoiOa16pllT6cmcTbqmg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-TCIjOW3QOCOCJMlGl5yKpg-1; Mon, 02 Mar 2026 12:53:30 -0500
X-MC-Unique: TCIjOW3QOCOCJMlGl5yKpg-1
X-Mimecast-MFC-AGG-ID: TCIjOW3QOCOCJMlGl5yKpg_1772474009
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so47992565e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474009; x=1773078809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8btxV8nPdxJ+CM3cpxhcU/QVzEUYTpZ6jcDlRHIzDeo=;
 b=rp5nB6a1Dw8vHnZok2+njICVqDuvENXw0Arlvv6yQjL+aEZdIRJj7GITYYfb+P+x2S
 sMpdqQqsyNPMh7Z0j58mF00WN35v2qiRdikqEZxiII99R1f/jLT6mWR1aO/FSK3z59GW
 jLfmBylRv/e0t8II67Uore9YLa2vNjRt+9yb2stJXf+6afHXHOrUWRJq0QW8N7uxHghp
 HpUB5F0TD2WMs2orTPnY4jUQdVK+VjVdvVclDdmstDUfz6n1/kqtERmNe9g9DKi6FZzN
 5kj4J8cdqd2ezKvrgW97pbAwS/TA4Vp+T4mPHbIqev3G0PWeyqx6wfgxMUgpLeeGqryp
 JNvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI53RnrTzkaq8udJw8JylI9mAoR+ZeKzAsyJM65NXINFs3PcvYd3Fhoy4ncmQPqDoclBWFUyff0hLy@nongnu.org
X-Gm-Message-State: AOJu0YxEAWZO2Nuc5XW1FQKx6GzgnHm3g3nIPMcPy8WVIovzYDfd7cXa
 UF59eBehJF5QOz9ML2MvUYYQNRix1FDCCJ5JA7rZCS4Bw/o12lEffI1no//k+lZGxqFlTVvLFlI
 czJgQySiKd6a4O84BgqqPUfBozMhzOmX0U6nQ7PpUezD/fU9zVM2qH5N9
X-Gm-Gg: ATEYQzzuE0fwyfK9pn+7K3V8mL6VAgux+lQAHBLyBsnVk8wB3k3lwBj2UTUqgRhyf74
 dt30Wxfs5nrkGGYeQ1rD4bMvC+cw41Hha5dlHcd0OkI1v2O4wnolh4hlgF31ZuuSwzdxq4bRMl0
 AOa+uqb8p4/h4KsC3r1D0KUoDDCEOuOiDOtF5v4nuecOkl/4Zz541UjjdwqSKtPLNVXwujBzi1N
 Rdfi58aQnJbmVBNCGdY95Mu6mr5mZpa02ykkMXkBlt+1BFTW/uyyuZBVOGVeoZ6f+NZZJLwFnMs
 gAunvb4dNLC7kPwcC3hO8gpiSjKbzfuJI4KdXck6IS745kNUE1lIBsCn+oz78QrJO/sv1zxBWhz
 1pvRf5SBwh5tn3Ps9+xjfr/jcqvD5VUkbrZpiZUbwLB3m9A1dypNkgvVeHN8zEnCWtCG40Q==
X-Received: by 2002:a05:600c:1f91:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c9ba7dffmr222208925e9.1.1772474008940; 
 Mon, 02 Mar 2026 09:53:28 -0800 (PST)
X-Received: by 2002:a05:600c:1f91:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c9ba7dffmr222208525e9.1.1772474008452; 
 Mon, 02 Mar 2026 09:53:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm312457385e9.7.2026.03.02.09.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:53:28 -0800 (PST)
Message-ID: <b6c17396-be09-4497-8dd1-8f66d9c2fe63@redhat.com>
Date: Mon, 2 Mar 2026 18:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>, Mostafa Saleh <smostafa@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
 <aaGu5v0To65M5LkB@google.com>
 <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
 <3cff6489-e487-4f7b-b2ea-984fb5379ed9@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3cff6489-e487-4f7b-b2ea-984fb5379ed9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/2/26 6:47 PM, Pierrick Bouvier wrote:
> On 3/1/26 4:33 AM, Tao Tang wrote:
>> Hi Mostafa,
>>
>> On 2026/2/27 PM10:49, Mostafa Saleh wrote:
>>> On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
>>>> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL
>>>> path
>>>> and return CERROR_ILL when stage-1 translation is not implemented,
>>>> matching the architecture requirement (IHI 0070G.b, page 176).
>>>>
>>>> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>>>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>>> This is a separate fix, it can be sent standalone to make this series
>>> smaller, similarly the first patch.
>>
>>
>> For #1, #2 and #19 commit (this one), since I’m not fully sure about
>> the expected process here, should I resend these already Reviewed-by
>> fixes as standalone patch respectively right now,  and try to get
>> them merged first?
>>
>
> If a set of patches is fully ready, you can always put them first in
> next version, and ask the maintainer to pull this one.
> If your current series needs them to build, I usually prefer to keep
> it all together, instead of having two different series, and using a
> Based-on tag. But it's a personal preference, some people prefer to
> see several series. 
Either, either send them in a separate series or put them at the
beginning. We are approaching the soft freeze so maybe a separate series
would be better.

Eric
>
> Regards,
> Pierrick
>


