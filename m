Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7AC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 05:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty27N-0004uW-I0; Fri, 28 Mar 2025 01:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty27L-0004tr-6L
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:18:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty27J-00027k-GQ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:18:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-303a66af07eso2453081a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 22:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743139131; x=1743743931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qxe6/vH6pc4ou9pzuZ4OfaKT5uzIZ0TXJ/5poEzgEAQ=;
 b=GoKvNMRpHqE8zfCT6yYki2VztniAyVcFl83mwLv7R8iXgFYWgiB5xTC0EmdGxQOdx0
 i7OTIjl07EQvi5KDFQZn7TB7uQ13FPqoO2JQgkNBM3mW3g/hqo6ysxyclqrnCOP3texJ
 YC78cITcjD0Y5Wul501edzY/5Qu8VLa6tM8ccL8keQpbSyacpqgtA0MFV8FG4mHNVyP2
 mmds9WUCSSLbHjiRowE0F85kp3t/rNJ312KCud0msA8HoVsm+RODx0KcgBWYpg/R4CY/
 w76Ujzp921GuJbFuYEaXu1St6iZS7GIh/jyUnZakEgoayrsZfrw+TB4KDfkhlBA7vxAl
 fzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743139131; x=1743743931;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxe6/vH6pc4ou9pzuZ4OfaKT5uzIZ0TXJ/5poEzgEAQ=;
 b=BNuS7DujWO7UY6ftR+ys8SQbg7vagDgG/BC1qGsy2WrGmWzpsdW1M0EjqZ7NhvdySn
 BGk3BpFiXqHg1vzHh57yQODPKlYmIPHJv7WEGicqm8Q4wPUH3HSu96Li7adRh4/4QgQr
 D6QIVqYhtYSLTKfMcldip/y8p7y2Voki0M9uV5cfkbXIVB3DhuazqOzx+Nu3l0JFYO8s
 40MUEDEclYiqScYs9vmDur1emmAdKogX9l4N5ot55YZCwccZfeTuQy+2ypPWSYDBTh9P
 zeGIMlu1IE4MI8GZ/KZNNRNBwt9qaWm8OuoWNLXTSAsqTJcLsAr6T6YQY5hCDMl4PT9O
 fuVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFEXJApGpruBwtdSRTtu3ancl4ghAT/y6fU3/7LHdBb+OTw0pwSTS5ChiixyM1bjw79a0lz9ZBSbNY@nongnu.org
X-Gm-Message-State: AOJu0YzL9Cbj59j2ET9nfrLWH/BLW3+DEdrimNKUE53UxWTWNgBmjtWD
 v8z3uqJorBnnTjGuMbl1ip3U9M2EwjZOsKnPAXXzU0d3qb/Iwezz
X-Gm-Gg: ASbGncs7xQoN4tQkYqn9xvjgpYkf+3BAp25OBuUHCyiBjLjuUbj7slZR1r9xWmqruhm
 M+OmUoBrKgRs0/Tl+8V0tHupqzYRwEK0bgXf56bPNuzT4YV0SLUS3CH85HwYWHj+a/TxAOQHtAO
 uRYPJqviBzE6lJ+Mk4gzY4w1Wqq0b4VnMRR81T7V/771lMT27w0zp2vaBNyXAREszJzJUSDKnDf
 dr+yZUopvnRBafphUL+xssF6blgx7YrHYfuVKq2gOrCvN8OnBUK5DaiSx4ZT8uAdwO0l2wr4OWn
 evVCuQYe+dYp9DNEZ5UKNz4IvUgQMauiTOSUlG0K57eIQbw81ja36zUFOd0N/cMftBk8rUT3sx/
 GIFY13jOt7+dZ
X-Google-Smtp-Source: AGHT+IF9bCVwPyYoBqdlYEEtKjix1alx//zabe4W09YJocELPC0MZxY1jLQKIrY5b/AspiNdcPm4rQ==
X-Received: by 2002:a05:6a20:9147:b0:1f5:56fe:b437 with SMTP id
 adf61e73a8af0-1fea2f4c37fmr11628430637.32.1743139131396; 
 Thu, 27 Mar 2025 22:18:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b6a02cdsm649753a12.26.2025.03.27.22.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 22:18:50 -0700 (PDT)
Message-ID: <f69ea09f-e66b-4ae4-8211-f7c0683b8bdc@gmail.com>
Date: Fri, 28 Mar 2025 10:48:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 1/7] vhost: Refactor vhost_svq_add_split
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-2-sahilcdq@proton.me>
 <CAJaqyWc0sH0o9MnnJPO8jLbpQVyec+QeG_TE2hnWxoiBqmivFA@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWc0sH0o9MnnJPO8jLbpQVyec+QeG_TE2hnWxoiBqmivFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On 3/26/25 4:55 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 2:59 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> This commit refactors vhost_svq_add_split and vhost_svq_add to simplify
>> their implementation and prepare for the addition of packed vqs in the
>> following commits.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> No changes from v4 -> v5.
>>
> 
> You can carry the Acked-by from previous series if you make no changes
> (or even small changes).
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 

Understood.

Thanks,
Sahil

