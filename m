Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF2CC02192
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3Q5-0008DD-2P; Wed, 29 Jan 2025 03:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td3Ph-00087X-Pi
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td3Pg-00057N-4Y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738139227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uhRPwPXXkUtk4qtk1ADHu85nY/PQCqPJP8ED0l5ljJs=;
 b=gfcaZaH0A6vsejjc7p0ujUVsPmkhRbnmS2VncjEhYI8dP7qkjqnjha+gFemGQq+YLOAKd4
 XlFWn3+Gd/ObMkk/V0f8D3oqCziTco6j1cEMIf98P8d9MeF42g3khDrUyZ6mWpIizCtu1t
 +DSDzr9PDua4PwvWjed2c01B1kC7E0k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ITRPNl-XMNuSoU-POkLYnQ-1; Wed, 29 Jan 2025 03:27:03 -0500
X-MC-Unique: ITRPNl-XMNuSoU-POkLYnQ-1
X-Mimecast-MFC-AGG-ID: ITRPNl-XMNuSoU-POkLYnQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so8412325e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139222; x=1738744022;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhRPwPXXkUtk4qtk1ADHu85nY/PQCqPJP8ED0l5ljJs=;
 b=rGcZzTfb6WknWZpXlX99gfwTxc/9TvmLTFrIjtl5Jmpsik5Dp3iiaI+gQn4fYycBrI
 hT3bM5+RI4C3QwG6qkZjmwGW/nkiDIlfw1+T67727oz6k9ZC6yLKhv2p1UUC28/KFYc7
 h4+N+7O2mJUYTi9Qi5puSKowsgDF/msfa7IXOYlnPMo+0pQq6ASxXS5+a/LUk0mOv3cU
 6vQoqkZSYiIQB6Q9G4SCxNJT0SOqei8Ws6kCat/Z5iQ4c+dvJR8IOp9sJ1PitdW8qin+
 VXxlsDSFM6JaTKL7MB3rOiDcdyu2XI1gZigcaNgCGfUzlo/J8Jzrgy+wnB5Gd/0PltH6
 ZslQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZz5d5J4/DoNM1q6aqhtqVkDZeHIp0fnBqhyhQGhMHtHVrFoEC8r5i3Uucm5UjYnQw1vfVy6UfUPGj@nongnu.org
X-Gm-Message-State: AOJu0YynWlv8cbfWm1pRqLuSm3Q980teM+Jqtw7wPG5xoJLEP7Kc2kKN
 VZxu5sDzRzAMVeIh49usVcSlWa7ZqKni/ZaQDPacbPTBMr9hoOwsdYmBmgYHE2Rge5LiW+nQZ7Q
 yM2dQhyAsohC8Dz0fKpBiX/KAWm6gqvdxA+rsyhMgaELL6wwfZkln
X-Gm-Gg: ASbGnctF9mdOqof4b+OyV4Xh7jbwK/BKWso6ttBzjx8SFnw5CnMyzLYP1emHLBXPnYT
 Z+onhJgYjGvDuTTGfqnxh3EDbesMSjentKmV0+d06FlqYPPQBa4XIB+HTEVOHGy+oIsDXKtWDKA
 10gHnOHJ8XzHR9cYXmDHzCfUtR9EhmGvuKxoGrarv7V7WO6xWrSVCQCXoL+tKzdv01efYihEJ/Y
 04mYBon3Bywzf33urWS/ijQyz3/z1pjl3mdfQnrkj+Lu4uzo5WuRV26YxfFQHgfAcpSG8H+kCN5
 zQ6nucRJ+MfHSIY8kG+O2hnRKS+BOLte2EtR
X-Received: by 2002:a05:600c:3c88:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438dc3c2992mr19662275e9.11.1738139222192; 
 Wed, 29 Jan 2025 00:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY15f1vv0TN9ui2CWEl5vmG35aOeyZqcmwkiACNmpppgzBRjB8oTNg7pnGSkhkwCG0r+HB8g==
X-Received: by 2002:a05:600c:3c88:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438dc3c2992mr19661785e9.11.1738139221471; 
 Wed, 29 Jan 2025 00:27:01 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc32f6bsm13799495e9.26.2025.01.29.00.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 00:27:00 -0800 (PST)
Message-ID: <b31bf66c-f6ac-4520-ad23-35fb78533eed@redhat.com>
Date: Wed, 29 Jan 2025 09:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-rust@nongnu.org
References: <20250129082045.1319203-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129082045.1319203-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29/01/2025 09.20, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index 39da7698b09..4cc19239319 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -63,6 +63,7 @@
>     stage: test
>     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
>     script:
> +    - export RUST_BACKTRACE=1
>       - source scripts/ci/gitlab-ci-section
>       - section_start buildenv "Setting up to run tests"
>       - scripts/git-submodule.sh update roms/SLOF

Reviewed-by: Thomas Huth <thuth@redhat.com>


