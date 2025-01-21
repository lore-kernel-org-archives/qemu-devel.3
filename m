Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06633C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 05:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta6Zu-0001Od-LU; Tue, 21 Jan 2025 00:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ta6Zj-0001Ms-5Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 00:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ta6Zg-0006j1-6n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 00:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737436393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tKC+SeEpf7IiVik/xx0QVRCDFJzXzDGXbp/OCRGsgnc=;
 b=JXDU977tD7bGQbyn1NLhUg9eNLqsf35tOgs0I70BrXyAKzddLfOH4Rtcq0i/8e0HsnVlO1
 Fi4A1gTagOkn2q8VqVaD4irSZqORPQbjsnsQAAuthTrBu5YEEZXRIVEGWPhTQpp9NKwaCn
 GuyohYOko/gtuc+lDVJDNxG+AwbDOrA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-j6QvYWtPOT2HtZbmxoeaKA-1; Tue, 21 Jan 2025 00:13:12 -0500
X-MC-Unique: j6QvYWtPOT2HtZbmxoeaKA-1
X-Mimecast-MFC-AGG-ID: j6QvYWtPOT2HtZbmxoeaKA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d80576abso3629809f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 21:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737436391; x=1738041191;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKC+SeEpf7IiVik/xx0QVRCDFJzXzDGXbp/OCRGsgnc=;
 b=whNsS8czI7+vz2WSonIk3wn3ti0/dCa/bRq+K/3jl1CAThRFk7Qtu/AFTmKciusEyx
 bzI220k1YyBl2M7NB10rTGDIv5pZxdQ84AlKire8oVgD3GXaDQjaRVAvcUI6/me+iUvx
 RvFVSkZ24BYUgdbT/dcLY8UdLntlCSZDATjqwtdvfQx9dOgmX8AQmVCettUSE3V1GJWj
 yffwsID4wnMPs8olyvd8WDPuG6nDBVe1/iCyX9f2vb0mPrD/AIIqoEsXxZX5L56YJpio
 LSrbF5zSzUT7jFDRUnxjYPs1CBvXW19C9jLyvykdsbS+DCnvtwjKypz/XuDnEnwp5nNx
 SmVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw4fJTs+Wpr2F9p23f+TSRuLGMbKObSa0FhVNWMkft3zN53LLTwYn7sKseM6aFUg6PzyGdeuOXo0X4@nongnu.org
X-Gm-Message-State: AOJu0YylLC9BHcZFVsKFCvelaUn/n0Fq6XH52Ym2/MYyRy+/jeQxSLaX
 P7oJqHvHRZbeFTXeGRgvTP3fxjh2PjZCB1yyjfrdyDBA0BCruMpSDekUw/qqD43D5svO/nMBV9R
 vF0/OSC0Shxq8SVaCQh7iHEnxoqeamsn4eNpUNJY5XtgX+/lMaZmh
X-Gm-Gg: ASbGnctSAP2R21J2uajtVqC5YYYZK3fUi4QdeMdZlDR33ibTAYYfp+o4RLltXX6GsaO
 yudsIcckoQtLwZRlsa+Jz4rmds/GhrYrZXzgLdHHDO5NbfNbKzYM2kHGYEETYZ0PbQmwJ0biSDV
 Hfv8fsVJlYdYsyJ+I3ZpVRm/B1aPBBYdy9ii1F9fT+ZKdOXc0AAbxK+5LkVcJQitm4LUPEoiH43
 wkJ96K+mRaK3ZzIPF9nbc8bJTEzgLgVy9dA50WPJze2Et/ze0Bj81kJQjiEsuW2QxpM8OjI85D9
 xL8urxsZ4T/XQoYDL6qQWXDbHQ==
X-Received: by 2002:a5d:59a3:0:b0:382:4b9a:f51f with SMTP id
 ffacd0b85a97d-38bf57bd650mr14251312f8f.47.1737436390774; 
 Mon, 20 Jan 2025 21:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyxSuetByLQp3uVx3NAC6S7ZdTDOk+q7nNcRbK88B9wD85NnAGq3YW0tNUMQ4vrLLHkiOl7w==
X-Received: by 2002:a5d:59a3:0:b0:382:4b9a:f51f with SMTP id
 ffacd0b85a97d-38bf57bd650mr14251301f8f.47.1737436390458; 
 Mon, 20 Jan 2025 21:13:10 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275562sm12520214f8f.66.2025.01.20.21.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 21:13:10 -0800 (PST)
Message-ID: <e7769309-6339-435b-ad30-e56c18679892@redhat.com>
Date: Tue, 21 Jan 2025 06:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/qtest: don't attempt to clock_step while
 waiting for virtio ISR
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
 <20250120210212.3890255-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250120210212.3890255-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/01/2025 22.02, Alex Bennée wrote:
> This replicates the changes from 92cb8f8bf6 (tests/qtest: remove
> clock_steps from virtio tests) as there are no timers in the virtio
> code. We still busy wait and timeout though.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/libqos/virtio-pci-modern.c | 6 ++----
>   tests/qtest/libqos/virtio-pci.c        | 6 ++----
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
> index 18d118866f..f6e3e32891 100644
> --- a/tests/qtest/libqos/virtio-pci-modern.c
> +++ b/tests/qtest/libqos/virtio-pci-modern.c
> @@ -173,13 +173,11 @@ static bool get_config_isr_status(QVirtioDevice *d)
>   
>   static void wait_config_isr_status(QVirtioDevice *d, gint64 timeout_us)
>   {
> -    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
>       gint64 start_time = g_get_monotonic_time();
>   
> -    do {
> +    while (!get_config_isr_status(d)) {
>           g_assert(g_get_monotonic_time() - start_time <= timeout_us);
> -        qtest_clock_step(dev->pdev->bus->qts, 100);
> -    } while (!get_config_isr_status(d));
> +    } 

Trailing white space in above line?

Apart from that nit:
Reviewed-by: Thomas Huth <thuth@redhat.com>


