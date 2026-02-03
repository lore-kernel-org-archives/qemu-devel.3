Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9379FE8B377
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPGe-0004jo-D9; Tue, 03 Feb 2026 17:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vnPGc-0004jW-RN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:53:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1vnPGb-00040I-1L
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:53:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-482f2599980so33800565e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159183; x=1770763983;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29TWNMDvtaWK7nvy1l8a24Ckev1UNPImxG5xPYhCvHU=;
 b=T9PWWeETz6eERU0XqMtDVnf8c+eAKNsuK0ae8Jg9wR4bofGbKk8rvJm3UnwjkvtH0v
 9NRxg2xw/s1n8V43DIR3qV5YtgTxEZkQq+3HKFOUv17bsa+q5itP/wsEzCw9kVy/dR69
 BoCKAUui0O5KjMkvGTCK85V5DaaxrSkZY393dW3Lte60c+kz36rZdQ6PLb9rT2DebG6Y
 cAtR6AFN9nbfNFYtSS7wBOmIH0zNwB9e7TiAjwuZMdbrE/aWvTOQdMiOuGsJ+DXXOcHq
 6Dlqyk89gePj0QomGA+t/bPZ71h/Tne76xE5t674da0OJ2Pt5U6zF63x9rZEqN1havCr
 yAVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF5fgWIQOttI4OWIIabweUNQvzuFqFYu76q9oeeSZGvLuDJ2Bzb2jOTY/ktAj0xveiOmfX9xoWNh3A@nongnu.org
X-Gm-Message-State: AOJu0YyRuLORfbzO2n6Rs5RQCyb7fjF1O7Ks16cnn9tNhyCEFxPrCJwX
 mctNDSYGPqygC7pCjmFDxbjkdNBG8wQcTK8mp2XEi2ES/TXFZhw47eHxcW6k+pms
X-Gm-Gg: AZuq6aJ3rKhtHNcg6vyD9EXSXCZw02MaTsGnCl8+Iq2GM/cvTPcbXm1dVubbFTeQcH0
 kqUOAbpDv/qlUGnYgYLetNW1Qt6eF9Q1FlTFmtBrBpc+ZCTDeORRR6tKpkrgEJQlqkYezVAa8Ad
 KzJ2fP8jdHwbM9euKYKgNt2K3r82+K0M4JtZpiumI9IQ+ay83o4VED4BB5Uqmg+RG2LDD75J93G
 HEUrAxjwveTisR2fgIF1FXK8PwVgOcdE+3xe+qRnwih6ZAEUuUhOTWSntcSWY+nxhQe+u6UYL4K
 FcDgA1rX7x0BT8prvF7AImY8QejimDq6OFHbnFMQO6u+hYp1Pz8dRwa5t0CvZjTvdo52K+l45Ji
 DKwEN8/nGMX1d/7W81/dcB3YFCu89QSZVIPyrtSAcLyRCCnjOceG16PNjDUjsy6nR1Vqc/9pE7U
 Kl1RsI+WplxP/Pzu0/3iK/1ise0RsOB/AFEe4WvLrULPg=
X-Received: by 2002:a05:600c:8b63:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-4830e93ea19mr18469175e9.3.1770159183394; 
 Tue, 03 Feb 2026 14:53:03 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483108d7b1fsm2305135e9.2.2026.02.03.14.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 14:53:02 -0800 (PST)
Message-ID: <2d704c50-37a4-4080-9c78-2b2a3fb2f25a@ovn.org>
Date: Tue, 3 Feb 2026 23:53:01 +0100
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
 <3fd2475e-f070-4255-a716-8d06cb888981@ovn.org>
 <F3E91DE0-38ED-493E-ADB3-9FF7139AA6A2@akamai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <F3E91DE0-38ED-493E-ADB3-9FF7139AA6A2@akamai.com>
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

On 2/3/26 9:21 PM, Chaney, Ben wrote:
>>>
>>> Perhaps the condition here should be opts->queues > MAX_TAP_QUEUES
>>> instead of UINT_MAX
> 
> 
>> I wonder why would we use MAX_TAP_QUEUES for something that isn't
>> a tap interface? It's also not defined here, would be a bit awkward
>> to export.
> 
> Fair point. It looks like I got my wires crossed a bit here. (And also in my
> comment to the other patch). Would it be possible to have different
> MAX_XYZ_QUEUES for other device types?

Why do we need an artificial limit on the number of queues?
In the kernel the number of queues per device is not limited,
it just needs to fit into unsigned int.  So, I don't think
we need to create artificial limits on QEMU side.

AFAIU, the MAX_TAP_QUEUES was introduced because implementation
allocated an array of that size on stack and it is not wise
to do so with a fairly unbound values.  But today even tap.c
allocates everything dynamically, so I'm not even sure if the
MAX_TAP_QUEUES makes much sense for net/tap itself, as it seems
to be an artificial limit for the number of fds that can be
passed in.  It is also no enforced when QEMU creates the queues
on its own.

Best regards, Ilya Maximets.

