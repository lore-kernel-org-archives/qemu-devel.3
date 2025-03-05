Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1502CC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjf3-0008Jx-JE; Wed, 05 Mar 2025 02:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjex-0008Fj-Bo
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:59:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjev-00015R-RT
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xaB82zWmnFiq7sFszgCPrnXb5l77fqe/rPMn9qymANI=;
 b=beGiY/o7XLVB2Zi8bW0w5bKUFENm2piDva/2SHW986h/VG8U7WUuuZoRdpqfHCpAe2jN0A
 0yeqHWwgd79CRLmKhRI93G5R3Q1W7HFdGcAOn1D1i1g0lUceKi1mcTwIH3RXMx/zDdRldS
 HC9MzCvqdIC/C4pbziNUQ6CJZcttfVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-qdeiyh6KPsKHVVFgbiSRlQ-1; Wed, 05 Mar 2025 02:58:55 -0500
X-MC-Unique: qdeiyh6KPsKHVVFgbiSRlQ-1
X-Mimecast-MFC-AGG-ID: qdeiyh6KPsKHVVFgbiSRlQ_1741161534
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c489babso34850825e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161534; x=1741766334;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xaB82zWmnFiq7sFszgCPrnXb5l77fqe/rPMn9qymANI=;
 b=moh6UoZIsG7nAiLTgJBBKi5GErDtcP++Ti9SLyUUwBxtQ+wOqDavMinM5Ex3MvcXZi
 +ikRn1Q52879S80g/WemIPzJFlql27cc+i892GJ9xgCuBtrt7RybvExYfDcGKSSdeyaD
 Ezj94x9XUPK3Md3s4iG1h4hubnz/h7P9C6bcMZVMRbxm5R68yUWEu9/MZc88oJWZFxQn
 dXXr9qh7gjkEcwBtCbHBpyxdplOmf0cxumEcmiyFjYMZ25K/+GhhtEC+9pWzN8XmNh3z
 KQSIe0LNZqx7PbqV13rZbQDBIciLsDpC7OJ8G3lKxSaPSH40P+gTsOiCRKro0xU7STWi
 yL6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvPZhbx/ZQ1vUaMK1zpv+zXPxSw5N6OnAX0UfariDOW9lhSiX2G0SSR/OVwskPag+CvyWNAGDGpeNk@nongnu.org
X-Gm-Message-State: AOJu0Yx9QFC73WLJrGQ6yis+3NfEiT7vuPemyLdUmJKI8/N/QYtrHeYw
 53sUveaRS9dyfDs7Hiw5tGwrSXpcpKeVd2Z55Pt4gjB3RlEGoQWGOPyXq5xQe7YP3uPSJogr8nY
 TjqXv7G9zL9R1oN58EgxLsZ2FwKlL250uCcfLALD7EAa51uK3796f
X-Gm-Gg: ASbGncu5vlOCRXqW4PFgQatRXRYerzq4pdB95FcJA+J6LG0lUet9v8Y0OPH+MwlI67H
 Q0kkhDS9975wSk4ASm5KcSkuCvOi5VZjbIXty1N7KhpGHyQ2C22/uYdeA+gSc980WLCJIpYP3/G
 EHt/XaWsuOSVUeaV+ViZ2B0+e1eMuTuL2AglMYjk1U5mYH7w1zgtMHKH0ENJQi1OBl70ZSVA3tW
 UeVkho49mSQyembF7fnWdr4OFr2yZdsMCY3U2vvw+Hiqta3PCcrglrCCYq0P64bjL80Rk7bEfM2
 29CYvdSeIovq5Kvblf/ZElV3gCKhsDT2qu1TGuauvKq6uJw=
X-Received: by 2002:a05:600c:4f0f:b0:43b:c390:b78d with SMTP id
 5b1f17b1804b1-43bd2aed6d8mr11289535e9.24.1741161534279; 
 Tue, 04 Mar 2025 23:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsLeU3xArhVLMGCkDpAxw7z9V2H7UvqV849ZtltLyAjLJvDl/3OUXiBzOFX1E+SHVE7VaDMg==
X-Received: by 2002:a05:600c:4f0f:b0:43b:c390:b78d with SMTP id
 5b1f17b1804b1-43bd2aed6d8mr11289425e9.24.1741161533956; 
 Tue, 04 Mar 2025 23:58:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c841sm9640145e9.8.2025.03.04.23.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 23:58:53 -0800 (PST)
Message-ID: <1432e257-3673-4467-a2b6-b81d7f29361c@redhat.com>
Date: Wed, 5 Mar 2025 08:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250304183340.3749797-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250304183340.3749797-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/03/2025 19.33, Daniel P. Berrangé wrote:
> There are two race conditions in the recently added virtio balloon
> test
> 
>   * The /dev/vda device node is not ready
>   * The virtio-balloon driver has not issued the first stats refresh
> 
> To fix the former, monitor dmesg for a line about 'vda'.
> 
> To fix the latter, retry the stats query until seeing fresh data.
> 
> Adding 'quiet' to the kernel command line reduces serial output
> which otherwise slows boot, making it less likely to hit the former
> race too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


