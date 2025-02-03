Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D207C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetVV-0001Od-GM; Mon, 03 Feb 2025 05:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetVU-0001OR-J3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetVT-00071q-2Y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738577802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cLnZyOiv1i1KGWJVH6PWjJ5K792MFR6uY6FRa7v7JEY=;
 b=Ip9rPn9BXJQx30L0hd6IFLlqFkktT5Zt5/1+4CsuiHei7WLs+RHWfGss4SJ84IVW6WtLuO
 NQW/wqXYKB3nkeRBCTIYRC3M+ML3OtK2YI762s78YvLHcUoLvOCQX0ZVc2GhRzspO5D2wB
 csiQep1PzXyHuS3QCu28CMb/EXzKabM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ryrSIVAMPNedWHbg8ohLTA-1; Mon, 03 Feb 2025 05:16:38 -0500
X-MC-Unique: ryrSIVAMPNedWHbg8ohLTA-1
X-Mimecast-MFC-AGG-ID: ryrSIVAMPNedWHbg8ohLTA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436219070b4so20532385e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738577797; x=1739182597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLnZyOiv1i1KGWJVH6PWjJ5K792MFR6uY6FRa7v7JEY=;
 b=tJE8dqNmyeWGz6nOdjrdOr6Tj/tBldhY6e8PV5yD0DziJGJnEfmW4BBIvi4y71TNRx
 NRKyXp/abqfBeA3oVSzcjdr05Os8oAkM13DMTSFauLl7y3s7EbGSO8rz/VDy+V0nI6Db
 nMWBNrmzzysKjxrWKXVeYS3B0OjzEOqEuPIvlUk9zdc3NT1q9TvVfRJsC86TuuRjP9Q4
 5I3ivlEtYuFnPLnnCRTVFRjHMXbq5NxAV6rbXeq9kbHLk2Np32hVExEW39ye+F7qsASo
 IISHiR4/Siryb6VVxKyyoxzR12KaI869k6firC+8S8seg58gisfh72CFZMtuzWDB1kkX
 v7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDyyeH4nXP/mwbFd4CSpT09sbkcNpE8rlM5tryOrum9Il8cpeOMabQkmWcKR7MkxD8Rb7BIdqBkko@nongnu.org
X-Gm-Message-State: AOJu0Yziwvj3z2iYwDX/cMyxrmzNlu7uu9/dMQoh53bLPNe4d/fR9ynj
 4sM+IKaZMsCcNEkrsYRHsB+5tOLvu9G+prsxD7NStgMFyZnvLMtTOAh6JAa9038WIuuN6OrsJnW
 KzEfzb8T2Pi6ouKu23QhtF+yqME/0nEjLg1iLiwQN/HGgqX77V7Pp
X-Gm-Gg: ASbGncuJ/XpNifgH3JY/9OYBAoSKrtV1NEKEV/IfJnX91GRjrtpMj4Se6F8QN7ncJxw
 CdA/spjiqzYwvN03V0nCXmkJgTVlF0CPOwF8hGfYtbUDYER6Ujw+BGH+IFy5WcE+hur0XAOYImu
 qre3IECMgXvC4VSKZQ7JAIBGpBm9d2pDqNXlJYE0U2TeHZaT6z2/wBkT4qMUbSHBZwlXRZ+rkVu
 Bfrdz6X58OD7pgisjj0/lh4LObjLRw/XLZo7jjfgu//7pgHqAttvVa9z9/QT1CsJ5nn2g8qU9iv
 Ls+YgklcjjlhMHyaYQgUsFIHAPxx5Q==
X-Received: by 2002:a05:600c:458a:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438dc3c333cmr197934695e9.10.1738577797331; 
 Mon, 03 Feb 2025 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN6B0OZ18SDhbbqOu8k1tqqFuYuRa7iQpZwnOffLm9DR4r2F9iH50duAIbmq5xKd/4/W9IJA==
X-Received: by 2002:a05:600c:458a:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438dc3c333cmr197934155e9.10.1738577796734; 
 Mon, 03 Feb 2025 02:16:36 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de35csm149023525e9.10.2025.02.03.02.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:16:36 -0800 (PST)
Message-ID: <0f4db422-e6df-497b-b7a9-89363e894e16@redhat.com>
Date: Mon, 3 Feb 2025 11:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] plugins: Link only when required in system mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-7-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/02/2025 04.18, Richard Henderson wrote:
> Provide out-of-line versions of some of the qemu/plugin.h API.
> These will be referenced with --enable-plugin, but CONFIG_TCG
> is disabled for a specific target.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   plugins/stubs.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   plugins/meson.build |  5 ++++-
>   2 files changed, 53 insertions(+), 1 deletion(-)
>   create mode 100644 plugins/stubs.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


