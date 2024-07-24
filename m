Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A944C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVwV-0000Xj-96; Wed, 24 Jul 2024 02:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWVwT-0000X7-HJ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:57:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWVwR-0002HA-U4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:57:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368440b073bso314703f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721804257; x=1722409057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIvfOOUAYFXCaM90OssFmwuwWDYBLk24BiRg9gWNqhI=;
 b=kgxPTW0s45iqbrSBNQxSods65QbSX0QR+YbYF3xOXiub4yEt7iLIDp+hdaNLlqpgVa
 a3iN1ww7uyhJGx0RGQzcPTViAwTP/6GgCq9TncfTQjOKfnnyoRzXVasiUmy8/h9rvLNq
 98TtKIEycVqYrAKGaO1G/CYiJTmxwhKa8r/AemC8Xcljr0BjsGpoo+dC8/J+3unQnYXy
 Y2IQdlkceoxMlhKYFH5dmYjiGN4GQ6/WwXSsWN4xw8IWdAWc1Wn/AyHCW01x9kBvNRkd
 RA2OJybvYCBBJDTyi6l4DB9OwPa8VTqXFlNXgJyHB4eEqKErPIriVB9yZWMGTBg8KGdc
 8Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721804257; x=1722409057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DIvfOOUAYFXCaM90OssFmwuwWDYBLk24BiRg9gWNqhI=;
 b=Qz2NeA0SuS5IaPs/QdWLTWMG98YFnhbGHbHnd/gOfKf71xaHzZxM4XJ4o+7+8sozup
 gdFX7Nfrw8N0QyC2/DVhBqmnvR5cu1PUvP/XpZfC8hgAQEMl6IHB+G0KLNepo9oPIFFF
 /wT3NjeWlcxVXjOmXEvfb8zP3SEust0ktVFkDpAO19cNXoOmS+G/O8NgtsrO/kS+Az7m
 KLaye7P1VbJXvyK1bTt+qxpnm+/CJJAPLKh1ISgtXGmnCRV2DvLH9/uTycC4MilPFrQX
 NDSkHJOkQDNMS7AYIyQBu5ZEzjkIIc0/cxkGid1XTu/VO7QKq1vzsCqEko201wBsEG7Z
 6QKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0l/srUXB7h4A3Gjxp4CTR1A1mAT210Qdvy3U9kY/jsO0nXGCX/rQVIm2S+5ZAaHMa/mQ2SO7xo5VvdoMMJ4AY5AoNrco=
X-Gm-Message-State: AOJu0YwSpwTNZJO9VzGX/G/W0+WOfzvo9HOcpLp7neWqN/34OllPj6H+
 nD3LnZJiTnEppCk88RD+Dr9SVtnrUBJP+LMr5IoBryveBc9UOpJTQ1ieFV85NBM=
X-Google-Smtp-Source: AGHT+IEUNWYyswNnVYa/jUrV00IPbS9oLJ+pF+yvTcTZQ2UiiNORNDmZ5YM6a3g8i0wC6lP2CMDvUw==
X-Received: by 2002:a05:6000:c92:b0:366:ee84:6a77 with SMTP id
 ffacd0b85a97d-369f666825amr614057f8f.3.1721804257652; 
 Tue, 23 Jul 2024 23:57:37 -0700 (PDT)
Received: from [192.168.69.100] (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr.
 [176.184.50.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93594e7sm15148175e9.8.2024.07.23.23.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 23:57:37 -0700 (PDT)
Message-ID: <7a4504de-1f34-467f-84d4-549e83c164cb@linaro.org>
Date: Wed, 24 Jul 2024 08:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Remove dead assignment to ss in
 do_interrupt64()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240723162525.1585743-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723162525.1585743-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 23/7/24 18:25, Peter Maydell wrote:
> Coverity points out that in do_interrupt64() in the "to inner
> privilege" codepath we set "ss = 0", but because we also set
> "new_stack = 1" there, later in the function we will always override
> that value of ss with "ss = 0 | dpl".
> 
> Remove the unnecessary initialization of ss, which allows us to
> reduce the scope of the variable to only where it is used.  Borrow a
> comment from helper_lcall_protected() that explains what "0 | dpl"
> means here.
> 
> Resolves: Coverity CID 1527395
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/seg_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


