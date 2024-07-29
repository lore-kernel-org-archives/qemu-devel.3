Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4380EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 11:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOsm-0008Cy-SJ; Mon, 29 Jul 2024 07:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYOsl-0008C0-NC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:49:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYOsj-0001lc-06
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:49:38 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36844375001so1177158f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722253775; x=1722858575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9JnXahZi7Ry6BaSaWzwQlRdolcTPy7oGkuYP98Cp3gk=;
 b=X7660nBKP9TBn+HBB65lQ1TmH4qLeQAehh+oUalQWAF7+IgC5HLNqZmuS37NvAaQGY
 flY7BY2be4vgsAL0qRiaKwQE8Ju0eMQ2CnS0pHii3V0d09B2zTn8QpCyWsxiYEpkWhic
 8n+MnMyquZY7j7GOb9xbyZuAQ63q443aFu8LhNuj72Nlnqfi32y5y5VabTcOIXxk2lNa
 McxlLfQcqpoxoteXQfFS0ACORtYl7aYxz54w/1IPTDwL0Fyjm2rxhQWgxS4FgEuOKcz0
 bqEEWTpXRyoQFF+WkJMOUBmy2o2GAH8hI/XcsqCozOPyVJB78uNTAljjxlH695tmsQ5v
 6HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722253775; x=1722858575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JnXahZi7Ry6BaSaWzwQlRdolcTPy7oGkuYP98Cp3gk=;
 b=jattrGp2vLtnz7O8xqXFEAb0Ff6KqOtdGJkpyIOntNWXNJpAnfIbUF3cqu190sSTi4
 /cUZbMfOABGYpV3hrHCWa5pUGEw+LMI9H/wV70WrW/1UC8d/q0U6LYE4un70OGPcuaQ5
 ikv3OzGofiHHtDQxWA9MYhi5E0EWpONsQhCukxZmrEO9YiLY9fwWsIvF3Sokkb5R8WnY
 mxXeYW6+O2eYQH9LoYgBELlirdqnR8QBeX8mJOn0Ag9pNN2ndk8iR11nCUKOV/2P6jaP
 cCn3c2xZ4HqDD2UqSvmRHkI2vk03HNsZfHihqudz7hUFu5RlnrnwgeVDdbIKJ0LtbJF/
 Q4WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU6ARkQsA3xceLE2WImuQCrUKeXeiDlufrZOt8zgFd8SjFBLOuQqRe5Rc2mCQv4c9cnnqAPToZA0Jj9Ez3IrMuCDT9rPc=
X-Gm-Message-State: AOJu0YwTHQz+yKkKuHxJcL7clSReig2vjcNFZOwwgJS8wDfZqXxnzPzF
 EET9tTxJ+F54vGXXZS3pB1zkJdg3yGQi/2ZUqM+BHlN9Y5rzO1Ywf8UMf2/XwQw=
X-Google-Smtp-Source: AGHT+IFeeCiGV5thGBTiNh7gr+7QbahBgArLsgKhz9+VAJf8JWTBngqYPYwRIe5wowq9hn3JvNtDbw==
X-Received: by 2002:a5d:4e0d:0:b0:360:79d4:b098 with SMTP id
 ffacd0b85a97d-36b5d03ce06mr4046832f8f.29.1722253775119; 
 Mon, 29 Jul 2024 04:49:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281a26e1bcsm51280515e9.34.2024.07.29.04.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 04:49:34 -0700 (PDT)
Message-ID: <7ef24be1-e79c-49ce-8c73-3509a7c8d77a@linaro.org>
Date: Mon, 29 Jul 2024 13:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] tests/avocado: mips: fallback to HTTP given
 certificate expiration
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-2-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726134438.14720-2-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/7/24 15:44, Cleber Rosa wrote:
> The SSL certificate installed at mipsdistros.mips.com has expired:
> 
>   0 s:CN = mipsdistros.mips.com
>   i:C = US, O = Amazon, OU = Server CA 1B, CN = Amazon
>   a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
>   v:NotBefore: Dec 23 00:00:00 2019 GMT; NotAfter: Jan 23 12:00:00 2021 GMT
> 
> Because this project has no control over that certificate and host,
> this falls back to plain HTTP instead.  The integrity of the
> downloaded files can be guaranteed by the existing hashes for those
> files (which are not modified here).
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


