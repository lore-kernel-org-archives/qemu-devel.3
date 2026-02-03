Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09080E8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMma-0007n8-TZ; Tue, 03 Feb 2026 15:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vnMmT-0007md-E7
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:13:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vnMmM-00034I-Ij
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:13:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso50361405e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770149617; x=1770754417;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZt0tTyaVPF0eKulEW90n1tZ0brxMogj5rOdtYYBxRw=;
 b=W37GR/1Hyq+Xj/KP9ujaIvvVCFMUEOR9PRMgi8+mKpyzTke3/LFOdT658mx5JxGURf
 ihxZk4zpLQKtbpGWfw0O78zyTjArf6btb2erRA3N0zJkbZFNWdJonXIbwGDqy6V+tMWp
 irfiWPmw20Ku0PSljoeBdAfiOkKhXLMCq6WNDhntx9fBwUzq5pXA7oMwRF4p/q/NvvLO
 ybwYwHD2Zz1hm4fBnuBWQPkiAypnnhjQFsU37mMGGuZhvdRD5527X77OdzZGBcKZzEXn
 +vMml5IdzjZKaNI5MQUn06/9m1pBuBNm3tGlQKx/I+trI0tlO2GtsyqnuDDd6yofuT6u
 zksg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1UFLZpUOuHgrhn/4qh7BujxxpcOS5Ix1bzEx1QcBo0475DC+h+YcMP9YWzlTs4jhPCxTzhAF2YLW5@nongnu.org
X-Gm-Message-State: AOJu0YwxsNgY8eQbJTRNKrDnVVLH8R1Vb+q+T6EGqr8KM6Vi9OVgmM5i
 9llUlOgXsaARo+IzmqzUsoNhKEBYPenPVFVSdxR9mI81bolkbl/3pxDx
X-Gm-Gg: AZuq6aI1uHULNpHkoutl4X8MPaSYIts81Ekd7NPAYMkRDM+EAaqsOn38dlvrMJeYSvj
 FNeOvW7dmn6NqUyvlQAwVqwIykG7HbcVMaH+JXy90O2d9jRIYO5IDljNSTMS8RsCHz+GXmWY2UW
 CuVhf/uZk2bXXGuNSMKZVP1xwlJpudAVQaTmeQM3JwY3i4uixcTBBUrd8PY+e7e1kRV8IXfE+bp
 hVaVJ9TzOCRg/oZjz2XitrOSFaCGlYdzroZppnHCUf2L/klhvj/DSP0amokYhxP+QxGupNQTt6M
 IyB45qi7Djslq+1e1hS6Aja+h/x5XLXyc/mknlW5h10YBxxMOg9juIjRNguXA2tIsZgm5eG9HZp
 l1LIroZY0NZJw4m2E+gZba/AncHqH129xR5V32h4RopB0Xr+5TMz0kkkP1K2RvVy/V58d76wr8F
 2s59FvfpAgtY1GMemjFzhEk/2KQTFuBVfBUYyjTL8s48E=
X-Received: by 2002:a05:6000:4211:b0:430:8583:d182 with SMTP id
 ffacd0b85a97d-436180575efmr864131f8f.29.1770149617316; 
 Tue, 03 Feb 2026 12:13:37 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25e8csm997564f8f.1.2026.02.03.12.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 12:13:36 -0800 (PST)
Message-ID: <3fd2475e-f070-4255-a716-8d06cb888981@ovn.org>
Date: Tue, 3 Feb 2026 21:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
To: "Chaney, Ben" <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
 <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.65;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-wm1-f65.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/3/26 8:10 PM, Chaney, Ben wrote:
> 
>> In for-loop in net_init_af_xdp, we do nc->queue_index = i,
>> where is is int64_t for 0 to queues-1, and nc->queue_index is
>> unsigned int.
> 
> 
>> Also in parse_socket_fds, g_strv_length() returns guint which
>> is equivalent to unsigned int.
> 
> 
>> Let's simply use unsigned int type for queues, and update
>> the check appropriately.
> 
> 
> I have some concerns about this patch queues is generally signed,
> so negative values can be used for error handling. We should
> probably be consistent with this.
> 
> 
>> - queues = opts->has_queues ? opts->queues : 1;
>> - if (queues < 1) {
>> + if (opts->has_queues && (opts->queues < 0 || opts->queues > UINT_MAX)) {
>> error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
>> - queues, opts->ifname);
>> + opts->queues, opts->ifname);
>> return -1;
>> }
> 
> Perhaps the condition here should be opts->queues > MAX_TAP_QUEUES
> instead of UINT_MAX

I wonder why would we use MAX_TAP_QUEUES for something that isn't
a tap interface?  It's also not defined here, would be a bit awkward
to export.

Best regards, Ilya Maximets.

