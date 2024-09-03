Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A881CD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUtx-0006gL-1S; Tue, 03 Sep 2024 10:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUtv-0006VW-2z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUtt-0006EZ-1u
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c7856ed66so27496315e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375175; x=1725979975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hANxtOkOyI0XBBTsVegCNH0dy+uSmaqAF1psQ3KvJk=;
 b=eaClv8ERL+OEXLoslogZyRWWSzsXTbaczM5b4h0j90AHQhxtO/LSc4WZ3XHWhbtomy
 d9YS+CSLicUDy3Ke97TUVFo6CDxO3RHQniVJ38unqBmz+FKhsG/FeadLws0WOq8Q9EYn
 L86k8jyzRTpAyvF8TuDcBg7MSSD5IL9NL7JKb2gLPYqFbmofFZEau/1ZnWyz2EYKi2zh
 FMm5PQ07u6ZlkJ0NmVGbMCn2U8UP4qYWjuR69g/6RnRCefXyXH5X8MEA9VIhJ/YXDxmv
 TDWK0WrybnTFlXo+rIBFUz2Tqh+nmU+K8X3LOHawzbtQryJIfL6AzgTDY3Ib5gmVJW3i
 7jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375175; x=1725979975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hANxtOkOyI0XBBTsVegCNH0dy+uSmaqAF1psQ3KvJk=;
 b=Uo8otXonhY+pYcZrA1OenRh5u3KULfAgYbRCYEzxG5dMoDswg3VDxeGpYF6nWaD/IG
 Waj+ApB7bFIyU6haguCQEserQAaCIKkgGz3APmvwmatfkq+//7WaB/vq+1kueGkceBcy
 Z3iPkSFvVE5HlYt7s87ILpPh6xMnARVb9ndhBVXgs7zgdX5VjCDQCoQkSi/j8Y131nm1
 6sI8ZrUyf2PwQLYwmIUzyBF8YWG3ti3BUuaEhwNmvKaEJFeNWoyOJEGFJ1DRFGADRoPN
 O8iHeae5MY/Qyijg4hfkC1tSAfN6JsnSoL1l3Q9kH6kVhEvvIotwyFRbQkrZianvSNlK
 +xtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo7xm1WbuN7Zk9TCNiEO3oa2iHcgdD0vRorOF4avHZN+Y6NCERstxdWCE84bPs0nnKq7NU4lGtsdFU@nongnu.org
X-Gm-Message-State: AOJu0YwBJ4WdHpB6lDmRdLG67R4qBqFHVeYm0ZFlxAwhhu8u0yMASwY5
 T5CZVMDA0lqwwwaLgC/rmJuqEZuPPn7PUNeb982XYJWO+veKyAMvvcm6ShYnC5g=
X-Google-Smtp-Source: AGHT+IEbM5x6GRmqsHAmN2IKar00ZSl/CNUAFDBhHIVjkf4V34JNJQ4ibuM+1l5Lw5kyfZjyyW4zrw==
X-Received: by 2002:a05:600c:3ba7:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-42bb0306f94mr146564655e9.21.1725375175465; 
 Tue, 03 Sep 2024 07:52:55 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm211848965e9.45.2024.09.03.07.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:52:55 -0700 (PDT)
Message-ID: <c8d76402-b578-44c2-8e37-c2fd259ccfe0@linaro.org>
Date: Tue, 3 Sep 2024 16:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/core/qdev: Simplify legacy_reset handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <20240830145812.1967042-11-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830145812.1967042-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/8/24 16:58, Peter Maydell wrote:
> Now that all devices which still implement a the legacy reset method
> register it via device_class_legacy_reset(), we can simplify the
> handling of these devices.  Instead of using the complex
> Resettable::get_transitional_function machinery, we register a hold
> phase method which invokes the DeviceClass::legacy_reset method.
> 
> This will allow us to remove all the get_transitional_function
> handling from resettable.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/qdev.c | 55 ++++++++++++++++++++------------------------------
>   1 file changed, 22 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


