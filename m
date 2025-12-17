Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB07D66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwYF-0004A4-V0; Wed, 17 Dec 2025 13:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwXl-000402-Kq
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:46:38 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwXh-0002tJ-Dx
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:46:37 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34aa62f9e74so7675183a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765997191; x=1766601991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pI42kNWgZIf8o9hHQclQE0NOKqpoW5cIj2mxpLTq0Fg=;
 b=x2RXzT5AQav11r1D0AsBq58CVSsFq+8hyo515Uda6ySR2qyrWOj4xL+d2S8Q0MsW5z
 AzlwV7cY/soISXlVOjFji6jfDVTcmztqos6Z9KhdMwT3E5/U7bR35yj/J3F4jvXiGnMN
 sZpBUo8u7i3QhAIuxs/5ljfA2ZB6XtOsU4O47zBcpWCl/6/h5zpDeZIJuicfKANJXiwz
 l+bR0LLaZbq4MQ2w2pMV/fJHTmm+ukWSPLV+B5k7IQvOQBIcTFh8ax1Sq/T9tEM56NPu
 iRHKqaGy2n5FvqhaSwNSDfHT8P9MS8g/IJTvTAfcmhDagYrE15PNztFhZhiMy1wOqQTv
 Weww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765997191; x=1766601991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pI42kNWgZIf8o9hHQclQE0NOKqpoW5cIj2mxpLTq0Fg=;
 b=vkvWCOlcB1/XI3W4O/L4d2hhFu5P9Hihce9mfUguy9u9XBCzB5hE4BKeqOsUnzzT88
 8dBjNDQfuw7ikjvMhLrwnV2yR9AsvzLBITjTfT5vbhv29nGSCMDswF0RIQfg/M774HZ4
 zNeKJ4PFom4r0/MhECLblFiIEAL+flqK2MpxF+Og1WYbyITzRo3qs8bQPnbZXa7BGJwT
 6/yv37gh6+sC/9s3r9cxoS0zet7PKFI2QYeiptpmqka1hKCbjgvqPaE+suuUgjHvPkHE
 H/A3tNE0N/x8W4DJiapWnRxvO72X061lN+LHTLVkYMWBYtfH82cNXIFP4lQ4DnIfwX/d
 rIbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX50a+BXgGGR9cjeTeN60jXj1CLrzWH1+dEmA2LT6bFUkMbQiNg0/zeE7aEFCQ56UrfcBBQEjr1V8ND@nongnu.org
X-Gm-Message-State: AOJu0YzZ24nAVq1Y4DOLjXnq+z+/2F16sDcuOAuZF5YRILfaDjoG7LUA
 +dI3MiYVbhGbONkDoBrScOwTS2fBcAKu0+MP60mGEaSKd6nyWpKz+IY9FeNhWI1BuMk=
X-Gm-Gg: AY/fxX68+PoNySNjhDXMA0JUSjRfYbmzl8PQ0Vu30r6DkMHUdvlvR2s73kHbB/bqSct
 QggnULpizilKjhN3eI6wL6uH6loFAABhPKaJf1II0KmNBXXafWBwtU+qESYQKZBURAbRx6Nmlqr
 q7SrrrxX3jYp8RxbjbXhif7SEo1GNRvcFocH131ctJQMRqTxTME9mCU2h0i8nAqdHkbfWM4GuFP
 xtqGN7e5vCRZ4E1QdZwmNKNB/gw/5uUroLpTtktUP54P5itoi2h73+UVCfIo0DB+auHgQr5+4nI
 7qsDc3SSROUTxPS5rXcR99q5LghdoBvX2GEZ4OHYUhI4Lj33EDGV71gIJ1Pod80XsCMVE1+Zu6J
 TjDQz4I2gNZH0MyFWKX2pabfMAG0PTGcM/rNbimsHh8cvhTaKev1V0zLqb5FG6YE3CoK1XLkLUV
 mIFQVZMVH2MPdBeo7tRIcWUkDuTfW+fHjik1pgdTXT9fhtTac7OSUIx7s=
X-Google-Smtp-Source: AGHT+IGuDLF9hCkCQ32FxmsehbFeIBUpAG5nJUjAyHNNul4pwRz228BbMvUsiU0p7xtSmpAR597cjg==
X-Received: by 2002:a17:90b:3912:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-34abd7bae4bmr15971409a91.34.1765997190784; 
 Wed, 17 Dec 2025 10:46:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e7452f1f2sm117983a91.3.2025.12.17.10.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:46:30 -0800 (PST)
Message-ID: <46a75a2f-18d3-459b-b9f3-ddd09e5dc89f@linaro.org>
Date: Wed, 17 Dec 2025 10:46:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] system/memory: Inline address_space_stq_internal()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217143150.94463-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

On 12/17/25 6:31 AM, Philippe Mathieu-Daudé wrote:
> As its name suggests, address_space_stq_internal() is an
> internal method which can be inlined like all the other
> ones in this file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory_ldst.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


