Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34201D46607
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRS4-0001ds-5z; Thu, 15 Jan 2026 12:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRRj-0001TW-5l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRRf-0007Np-AF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768499259;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oIPbPyKo0LM7b/44liJmIiPppv77sNpTIw2vKZtNUw=;
 b=WazS17e2HH+v6MaRSlimzuMLunjSdIb32eJdEAK9wbTG4Lx+KzLm9pMi1bL+XaI8Ie9A1L
 aWzJgJIZXE5lvbMHlpPUxpoQ7krpBneNQI/jUpcEw1sOEsNf91bMBv/8g7jYUOpCx/M7Nr
 RC0kFoYgq+H93L6fB2tsc6ZvuBYK2Xk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-5JSus8N9Mia-88haMeroCw-1; Thu, 15 Jan 2026 12:47:35 -0500
X-MC-Unique: 5JSus8N9Mia-88haMeroCw-1
X-Mimecast-MFC-AGG-ID: 5JSus8N9Mia-88haMeroCw_1768499254
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ed980309aso10409655e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768499254; x=1769104054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oIPbPyKo0LM7b/44liJmIiPppv77sNpTIw2vKZtNUw=;
 b=h1D5Cxf6bw2fwUVHrhPBu7HZ/CvNOdQeYmqHpmtKVHISK7ymaF6EgAyfcqnULlIPhs
 pQ6nxnzBvxmFAcBpY5DTGwxZaX6b7HC0TATqPGiDMF9npbLK0tt7MsRzP0L6SYJkWNlI
 OQXOaI6w/W63iJOqtUX5pNf89Z31TZtQocglWs4erCr7zxzJO5dkUv4cK1t7i/BT5i0U
 XsBV6C/WYn1+zPDsl3L+yGxVYiz5eNFIRiZIUGD6LZyTxVJUN43poiaX8q3g9bJzI9Yi
 qPT3EL6AkNwbHbiNOeO3NTgnt6mZ2SCOHYaxXKJwyyqGpjg+fIrUhlPrbzGUUrBKiwb5
 /DIQ==
X-Gm-Message-State: AOJu0YyxKcmQzXZKExSWAZMoquEUa9HhVg++Y3KDwi1zKVlaDrSRKq38
 +ZlzEWBKTUQJQHvBrIvvCf6QVR5UGXfq+3C78wiyFpFZCVFI7T/fEMz1DfNy3AhPxtsuAFsQEMD
 MpaOUi9UnWCICggM6yx4PCxGwyAqU7/feAfiVvrMzxp6RqCDD4ZrWOvO4
X-Gm-Gg: AY/fxX4nXjJerz7ATpBJY6k7sIjR4Yf+JXXuSst95ODPboUa7L/Wtb2mst9FCY7I2sM
 JO9AcLniYg0mV3johCe+fBDJNINyihnd2D+jUH1+TVW4Dkt9wjq2MaymQ7i24fdjhlC0LHd3B+M
 Fgtja+Db7bWr3fT+PY84VQIhhGewuh3+kf5gT5r9tgsy7j9lB9DUSmY+ak3j0BbL+KL44Ze1++7
 ToIx/P2Gqymbni4y4vEdNw14Z2i0Zp7AqzGJIakToddHNclyQwYjOska3KYDxNguLm5USgWJ3TJ
 dST/mPPLOQ5iM1aq64WQ6jJQRpgqmBe4S8GB6+TR0fUGcRfGBzDn7gD9lmkSQDhKBXTGlXPmuxl
 SY+yR1E2D2zvRt2kcu1GRfcQyc5Y9Guz5j+yWx3e25v91fyBEwWN2QxML6g==
X-Received: by 2002:a05:6000:40df:b0:432:da7c:5750 with SMTP id
 ffacd0b85a97d-435695651aamr405023f8f.20.1768499253704; 
 Thu, 15 Jan 2026 09:47:33 -0800 (PST)
X-Received: by 2002:a05:6000:40df:b0:432:da7c:5750 with SMTP id
 ffacd0b85a97d-435695651aamr404993f8f.20.1768499253308; 
 Thu, 15 Jan 2026 09:47:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm303138f8f.11.2026.01.15.09.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:47:32 -0800 (PST)
Message-ID: <10e1b40c-2edd-400f-8c8e-e0f3ad4c6f75@redhat.com>
Date: Thu, 15 Jan 2026 18:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 0/7] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <6d50c3fe-e235-48e8-b461-fe0689f12070@phytium.com.cn>
 <9fba7ded-d31d-4789-b83d-efcc96f5448e@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9fba7ded-d31d-4789-b83d-efcc96f5448e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Pierrick,

On 1/15/26 12:39 AM, Pierrick Bouvier wrote:
> On 1/14/26 5:30 AM, Tao Tang wrote:
>>
>> A gentle ping on this series. Any further suggestions would be greatly
>> appreciated.
>>
>>
>> Link:
>>
>> https://lore.kernel.org/qemu-devel/20251224034647.2596434-1-tangtao1634@phytium.com.cn/
>>
>>
>>
>> Best regards,
>>
>> Tao
>>
> This version is in good shape and is ready to be merged.
> Eric, do you feel like merging it, or would you prefer someone else to
> pick it up? 

Peter generally sends the PRs for the vSMMU. Maybe this can also be
taken by qtests maintainers too.

Thanks

Eric
>
> Regards,
> Pierrick
>


