Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D47C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 22:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdzgW-0002jV-4N; Tue, 13 Aug 2024 18:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzgU-0002iy-JA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 18:08:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzgS-0004M6-2V
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 18:08:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc65329979so54883865ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723586882; x=1724191682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=legZjuOVJ3yo6guZZK7DUp73BgV4Wu4bx+oQ5GcI1Ug=;
 b=c8tqZyO2kQKtv+xb/3WK/V7sPv6pEhSZN8S4oYcg8TAPO3H7zIf1Spyer26PBFGaKr
 dBZzZpLVA4iXepp3BI6/qGyBnD0LnBgaPb7/CkOl7NOe3Tw9Grmm9W71OWwWMYJ/NXch
 S3L493Wg6l9fNUadhwWETUBLlttWQTzE7xjhBNrfQsh4qr3ZP53MeV+rmtjjCbZOcEqW
 dwz5iGdw+df6r739yyxfuTdL0tdbg5hjFP/5wXX7hZHftzV5rIkcSFZYpp4l3Jjkleek
 1xFcJ0tEMyoB4HnQA9wZR91AEb3bqFISh2YvvuwrFDL1mU+Okpbm6HWBPfFsa0juJwQj
 FOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723586882; x=1724191682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=legZjuOVJ3yo6guZZK7DUp73BgV4Wu4bx+oQ5GcI1Ug=;
 b=uxkpSO7wV1Q6N0+3UcJhUpbRKHLUtw4ayu6tsfVTyQY8nU+KRUsIZwHkSisD9fqRD0
 gMw0S+R+K/RqLWdvlXjBwhpkQhjSYNahFHm2wVd+WXaXldvcU4S3yTOhn4lB8wtRzhQA
 8CQYLPFgFlQ9GPf5oYDQYdVc6rIVIoLBSkKyDLoYrJl0+YAeJfOi7dE8vIIlKQ54XCsE
 nl9D5lQDhrhuHI468P3XkMu6mhtc4OyvsjEQ2dhWyGGPPB60eGJMouSRDmeawiUtDpEA
 +4qOwcSj2Ld2gaNB5Jws6JAUodB6MkmtfOl+pqhzFfqnYyiX6tG0PlO51Io0ioVw1sAq
 wGhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiAd9RN0fRweRzirQg9Dp47GSRADiba3zi2BmX6ZmvZsd2/xHUnGGTgCjUjoSLmXVhfILzfUUPTiztuf5c8h5osmz3QWc=
X-Gm-Message-State: AOJu0YycqAuj7vAucW0yroLjueQhvAumdAMNJY7G+RBU/8nCyaNLgalI
 A0T32GKm4WM10cjNL0d4qcOsvy+BQk7feMZTKe3PmKdIoiauYC3gwuevpPlZMQo=
X-Google-Smtp-Source: AGHT+IFAJn7BNqMgKPsrIfYP4ub8QJK0Il7uNMyGmyc38DYIrci1bvPel1oM8O+wqPfdJU3EiMjXuQ==
X-Received: by 2002:a17:903:2283:b0:1fb:31c7:857b with SMTP id
 d9443c01a7336-201d63b3ea0mr12148515ad.1.1723586881703; 
 Tue, 13 Aug 2024 15:08:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1ce9f7sm18188325ad.266.2024.08.13.15.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 15:08:01 -0700 (PDT)
Message-ID: <94469769-0fa7-49b6-a8e0-f42a04bd9eb3@linaro.org>
Date: Wed, 14 Aug 2024 08:07:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 01/10] hw/s390/virtio-ccw: Convert to three-phase
 reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/14/24 02:52, Peter Maydell wrote:
> Convert the virtio-ccw code to three-phase reset.  This allows us to
> remove a call to device_class_set_parent_reset(), replacing it with
> the three-phase equivalent resettable_class_set_parent_phases().
> Removing all the device_class_set_parent_reset() uses will allow us
> to remove some of the glue code that interworks between three-phase
> and legacy reset.
> 
> This is a simple conversion, with no behavioural changes.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> It looks a little odd that we do the this-class reset first
> and then chain up to the parent's reset, but that's what the
> existing code does, so I left it alone.
> ---
>   hw/s390x/virtio-ccw.h |  2 +-
>   hw/s390x/virtio-ccw.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

