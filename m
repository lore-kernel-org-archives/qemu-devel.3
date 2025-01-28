Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 12:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tckYF-0002lq-Ji; Tue, 28 Jan 2025 07:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tckYE-0002l2-2b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tckYC-0008IP-88
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738066717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5n+WzSjjZga1/5dzHPwJh+sb0Qk6Ca3DIe5tAah4KKk=;
 b=auH9NutCYMGYvEyHx77vv6BPtiT4tAi6Hec3c9JMvK3Yty79FuS+StY6PlCXTjNFBwIJHy
 7XTsODkaONLr1e5NQyt0gtAT9pKobfA8RRYtuXpTjO3XcPcIV18fxILWvZNQtHPhCjYe4Q
 soaxdFroy5rhrjmSmKZu5pWrenqlYvg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-UWTbzmfbPh2CNl5LXSs_bg-1; Tue, 28 Jan 2025 07:18:36 -0500
X-MC-Unique: UWTbzmfbPh2CNl5LXSs_bg-1
X-Mimecast-MFC-AGG-ID: UWTbzmfbPh2CNl5LXSs_bg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so597960366b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 04:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738066715; x=1738671515;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5n+WzSjjZga1/5dzHPwJh+sb0Qk6Ca3DIe5tAah4KKk=;
 b=MWNixDiSK1IU3JR0zusn+tLAQZppU+7uYudhs2esHKUDx+1J1K/322ouoTcuqS+1e5
 joQs1ybgKuZ5sd8f+yDGCls1oiwp6w5mHDbX/LFTl/+DuvonLfY3pnoMzpH+lT0qHu9y
 PA10DKVQOOORchmQ+5XY95HGArysb5yJau7246dRuCJfoORDRdSlAbByqZVUPIEFx/g0
 wmuAwa4Euf/G55qQ/xwvdnuf1KJYmq5oXgkXQAQrPyFzbX916V7mR3OrMgGHVC8JBm0o
 mqZC40PfsOnb+P6DhNzr+KupC3/dhTAVzWLFmI6cLjs4cCnWLKuOJoxuGFPZFET3u97O
 gyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXtbyK8cUaYNkBzBGoAUcC5IqUsEjLWK0jL37elSU9t5YtLSm2XNKrqsZD2igfR1fXo/5Z/23IoHNe@nongnu.org
X-Gm-Message-State: AOJu0Yyu0bTDU8EsoohsKLKej7+kg0/7+buR2lVSxBfPX0zDXXsrD+Xe
 VrLmSbpQ3WOFaQk6RHmePTsAzJMpH8NXpqhndjdkkf/vEuGxIoa6kYzMmCQA1ZkN/qVnuyiJZVx
 eFoQxL+U7Gf/UL//fiwxmpD99EAazdZj/D3p7T23uQdOZ9k4qg4Hn
X-Gm-Gg: ASbGncsAUwWTivPRoACE8ac1cmUVGCBQctplpYujpGrhXEi8w12WUtLqGmcdcRVc7+e
 b+v4mIylqmqfP8vBCt+Jo3PUdvU4EEOQQgRofyNo+E4NgFfPEuHxVpjaRb5Akj0dBCf91HYalEq
 WeosP0CReOgJMYRwvIZbXwQokHAo8ClG1oICl1eqMNJOEgyMsLpnWFV0+skHg5lgU0nkWlgM++C
 Zsc/2XuLi0NOv1KYz0XLN4tRXNBAgKvLBQhRYQQpH01yXfnTVSjRNYD13ss6lhhlC+FpjwkHkex
 1Aj9vejO9NejQ01u6/xHmaY6psrh67y7OlUG
X-Received: by 2002:a17:907:2da3:b0:aa6:83cc:7996 with SMTP id
 a640c23a62f3a-ab38b37eb86mr4119385766b.42.1738066714911; 
 Tue, 28 Jan 2025 04:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPV1rzvwtGh/0owwTO1K12pEHLlm4LLq/EKPT+RrOmpKFZmOoxMbTgyLuoVeAf0osD9CBfRA==
X-Received: by 2002:a17:907:2da3:b0:aa6:83cc:7996 with SMTP id
 a640c23a62f3a-ab38b37eb86mr4119381666b.42.1738066714544; 
 Tue, 28 Jan 2025 04:18:34 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6bd0afb93sm149916966b.128.2025.01.28.04.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 04:18:34 -0800 (PST)
Message-ID: <a29c4005-dea3-411d-8564-d79739a7befa@redhat.com>
Date: Tue, 28 Jan 2025 13:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest: Extract qtest_qom_has_concrete_type()
 helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Bernhard Beschow
 <shentey@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128111821.93767-1-philmd@linaro.org>
 <20250128111821.93767-2-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250128111821.93767-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/01/2025 12.18, Philippe Mathieu-Daudé wrote:
> Extract qtest_qom_has_concrete_type() out of qtest_has_device()
> in order to re-use it in the following commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.c | 89 ++++++++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 38 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


