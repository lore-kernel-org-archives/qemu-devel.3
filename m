Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6582AC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCQd-0004hQ-Py; Fri, 11 Jul 2025 08:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaCLj-0002BB-Sc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaCLf-0006aM-3C
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752234925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rYOoieg3xfj1xk0rOQOiEMyS5aHEKtSzPoIVmGyJ5cQ=;
 b=i3eeTPlUdgNBqBoqJwgLg9fOroiGRkJKQP499mLjJmSl3XGAZ54fG+Qa760LFB8LlZlSYz
 GwWUn2m2DJd0At6K5xXJJJ4KKOPAExuJOinFyYIkKx2hvBZWHcycozsI/e/mEuk7LKzrfl
 CHFucxLcEocYF1YltGvL/N0q9V3gzsU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-DggTFKNsMbKR48N7Hdskrw-1; Fri, 11 Jul 2025 07:55:24 -0400
X-MC-Unique: DggTFKNsMbKR48N7Hdskrw-1
X-Mimecast-MFC-AGG-ID: DggTFKNsMbKR48N7Hdskrw_1752234923
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d64026baso11157305e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752234923; x=1752839723;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYOoieg3xfj1xk0rOQOiEMyS5aHEKtSzPoIVmGyJ5cQ=;
 b=a9BJeUmyaT5qDO3Pk7yl5qFtQ+AfyZnn12bIGH9rAFFt7r0ypKhmTcJ87W6Sdpu7b3
 XrTRtMUm5rQQMWQDuTiGJ/lOpHJ4XZOeDpscmCfQ+2KPrNFO78qX6xS9uaHsIBgrACuT
 B2zShSqxhJAubkT+m2FZDyLBpvqBwb9Syw2UwuutuEk8BrmuGOC2sPw1ddLBOO17UZiG
 gFQEVPuqP85dBAYhKRVG71n+9hJ1ffNSnqMCrAndCEMT3m/6gVbxt/TFT3aY/N9WhwnN
 bKfk4BLCrW4OqqAFKWQbMpGDXyE2ZgVerweMsf28QsrR9KOlMgOEi80xvqgF6vqgYsxX
 9kJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnsfejoaADkAVcKuZ5VlHoIXC0MRcqDzLTSGNfNOXCbC5OimiJ0i4ROc1CBpkQXQIyxMjzXG44gr37@nongnu.org
X-Gm-Message-State: AOJu0YxmbNQ5BbqycvTU6EDcoFA2HpJrV9cAQThuol02PUJN3KhxWpum
 SAAdta34O1XuueKxQN6UvsXtux0sS0IT647p4rhdwDuxQ760egSqfA+PAUZ51i33kpAuwRrNMfY
 Urw4LaEFiMDSKrmCjBe44Jtx7hU64u4jCaGpgB2ogtNNeRcV+yyQofIjt
X-Gm-Gg: ASbGncsOH0D+pOzUB5wpsdyldHbS1vI4K0ncnGSZ9VC1yBQ6rXYSBDtjS8lweDXNCy7
 tY6UwvofDGyb3XqSLd5nveN/QymIrls4UvFibQ/0hpKKo5PdPINmW3KwnN1sf6bBvuoQkMtzMYy
 jau3xmGI+B3k938OT3dwHhuirAKWvStyw+1YU796IR2dHs88J4WpnZpxxVcDW8z2g1BjJd0iMZ5
 CnwKDQUKP4+adsd52BoREWSeKhzNW70fqlgf29vxkqfBVwzYkgLv3kMDO67uAx63kOdHHIe572m
 gApEx250uOg+d0bRtA2B91/kUNoo6jXqnEbq/Jkd1Am56EIFCXpJ2lwHcOIEl1tMbHAA2o/QoLm
 YHVGE
X-Received: by 2002:a05:600c:1c25:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-455f7d131dfmr1167665e9.12.1752234922690; 
 Fri, 11 Jul 2025 04:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9q9MAa2Bvy/PgZjUdchi6hrPIJZKIPVaRW+2UgKH8mNPNbKXAHPp4i+CTWUOcqPuXvXUUCw==
X-Received: by 2002:a05:600c:1c25:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-455f7d131dfmr1167335e9.12.1752234922258; 
 Fri, 11 Jul 2025 04:55:22 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e211dcsm4165373f8f.84.2025.07.11.04.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 04:55:21 -0700 (PDT)
Message-ID: <8f90fbd7-1edd-45cc-9540-06fd9d0ee978@redhat.com>
Date: Fri, 11 Jul 2025 13:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250710094251.139514-1-thuth@redhat.com>
 <643f1db1-4a7a-4bc0-a187-9ff1561f8a3d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <643f1db1-4a7a-4bc0-a187-9ff1561f8a3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/07/2025 17.51, Pierrick Bouvier wrote:
> On 7/10/25 2:42 AM, Thomas Huth wrote:
>> This patch tackles two issues. First, the tests/functional folder has
>> become quite crowded already, some restructuring would be helpful here.
>> Second, we currently encode the target architecture twice in the test
>> names since a lot of the test file names contain the target, too.
>> This contributes to the very long output lines when running "make
>> check-functional".
>>
> 
> I agree with the "crowded" aspect of functional tests, and subfolders are 
> definitely welcome.
> 
> Concerning the long line, it seems that setup ("thorough" in this example) 
> is repeated 3 times on it, which is a bigger issue than having arch name 
> being repeated.
> 
> A simpler solution for the "long line" issue would be to change 
> mtest2make.py to generate shorter test target names. This would not benefit 
> for using meson test directly, but from what I understood, this is not 
> recommended nor supported anyway.

I agree that this is a bigger annoyance here, but as far as I understood 
that that repeated "thorough" term is just a listing of all the test suites 
that the test is part of. I think this would rather need to be fixed on the 
meson test runner side - why does meson list all test suites here? The one 
that applies to the current should be enough, shouldn't it?

  Thomas


