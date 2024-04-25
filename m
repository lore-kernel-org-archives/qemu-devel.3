Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E630C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00dg-00075Q-5y; Thu, 25 Apr 2024 11:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00dd-000751-OE
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00db-0005xX-TH
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714057430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ihm9J3LVmjbf3LszgDtSK1KhIvaqclTfvqbt8gJc+2U=;
 b=LFINcQDtqiriphlXt1ySwclvFMaj4lPyZ8urQd6UUxP3Z0IOgkXawn5VT/QrLADAptcIzk
 67dCCnre8SFsAaKLzrzfhZSKLKAvW80SyiWswvbq046KWxo+pi/Ct+t3l9AIHsjtT2AKYx
 dLtWlTms5/Nb5MtyNews3IiQZPLy0l0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-4tCBpcmrOBmKM91cRr2C5Q-1; Thu, 25 Apr 2024 11:03:49 -0400
X-MC-Unique: 4tCBpcmrOBmKM91cRr2C5Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a097848a56so12801306d6.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714057429; x=1714662229;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ihm9J3LVmjbf3LszgDtSK1KhIvaqclTfvqbt8gJc+2U=;
 b=G2NBikRjpZ0o7dwn4HMjsKurGs8EohuAtZlaJfQtJ59E1g0tpao0zRl8B7QXu874yB
 +S/hYIub62IelZf9Nexw9dAfDs7oPaXmDSJDL90K76U7Mn0pIwVH3q0BEvlCdP9+WNfZ
 9wZVibCgGHiYP5uV+/7FB/UfyLVG0VPPlfyhtgw0NwzDOkE/NBHxWIIKmW1/flTJza3A
 tvFEDUOy4tuZzP3sLI5XFcRmSILBfQNucSgdk/nHtsjXX3JOjrj26par/UveYEyFZjfb
 e+a8mWebAO+5zp+c+farfGik5xhKzpi2qTIJfTmmYZZeWW5cBy6BCMuxFEICvZKHkNCf
 yK+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXygSgd83hDM4Q800NWQhqvZTlfVQkFb5bxI2rmLIFNHWahHJNN8LcAL8As+zw/RovFlQNNzi4pEo+dWxqXmkk+4lsiKoM=
X-Gm-Message-State: AOJu0Yz/jkIG2KpNzeeATREVXt6W+M2+lozTdJoE6aoP7HiovqLieWWL
 rxqxkNRP1TCExy1Ab+FUHSMHFQ8C+ZZrIs+h5z4K2NOkcyTT1UuqlSlqnPH1//JLk1lqF8JRQs+
 iGZOBN+ns4ST/QFhyaKtc8Mj3/H2GmCMDCA1wSzlrqZ56YjZW4tak
X-Received: by 2002:a0c:e607:0:b0:6a0:7791:3d74 with SMTP id
 z7-20020a0ce607000000b006a077913d74mr6416135qvm.38.1714057428846; 
 Thu, 25 Apr 2024 08:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHljoHcxrNZLSX/S0oycFELw4aie8YItHu/4TOdwIfWNdEf1gcc1p6lptpkAS24RV6JEkgzUg==
X-Received: by 2002:a0c:e607:0:b0:6a0:7791:3d74 with SMTP id
 z7-20020a0ce607000000b006a077913d74mr6416030qvm.38.1714057427643; 
 Thu, 25 Apr 2024 08:03:47 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-130.web.vodafone.de.
 [109.43.177.130]) by smtp.gmail.com with ESMTPSA id
 a7-20020a0cca87000000b006969f5d3159sm7069710qvk.50.2024.04.25.08.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:03:47 -0700 (PDT)
Message-ID: <73911b7b-da94-441a-95b0-bcfb23f7b8fb@redhat.com>
Date: Thu, 25 Apr 2024 17:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: move external build environment setups to CentOS
 Stream 9
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240412103708.27650-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240412103708.27650-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/04/2024 12.37, Paolo Bonzini wrote:
> RHEL 9 (and thus also the derivatives) are available since two years
> now, so according to QEMU's support policy, we can drop the active
> support for the previous major version 8 now.
> 
> Thus upgrade our CentOS Stream build environment playbooks to major
> version 9 now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .../stream/{8 => 9}/build-environment.yml     | 31 ++++++-------
>   .../stream/{8 => 9}/x86_64/configure          |  4 +-
>   .../stream/{8 => 9}/x86_64/test-avocado       |  0
>   scripts/ci/setup/build-environment.yml        | 44 +++++++------------
>   4 files changed, 34 insertions(+), 45 deletions(-)
>   rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
>   rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
>   rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)

  Hi Paolo!

Not sure whether you've seen my busted pull request, but anyway: It seems 
like this was not enough to update the custom runner. You also need to 
update .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml for this.

By the way, who has access to the s390x custom runner and could update it to 
Ubuntu 22.04 now? It still seems to work with 20.04 which will be out of 
support from the QEMU POV next week...

  Thomas


