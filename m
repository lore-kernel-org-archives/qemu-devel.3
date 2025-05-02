Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1838C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 13:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAqQn-00088a-CG; Fri, 02 May 2025 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAqQk-00087m-W3
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:27:55 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAqQi-00069o-Sb
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:27:54 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so357724166b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746192471; x=1746797271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ubSbcn7zAOHPDZtTaQIa9au6yQFfdMsj4W9wD8fj0vM=;
 b=rugoYktLD8KkpHTvg+GZVknULXe/BoNDgl0A/ZeytJyRYvbfBgScYmaDnRMwHijMsi
 BltVLNW31OL6fYOVeKcjCtTFf0AkxzZCPgb1LMwpoqyoVZj0cNkTPdC8RE/QIOFF9l6E
 Wh0BFHyOATAwrgkkuBKAL/9f5nvf1qF/GtsGv1L2A3JRLLApWKTsLRynuA9jJqxINYIw
 q9Lk2cHQxrAqZcGGWV9j3J6SmIF/BUMAflE7mQdM1VEIStL13h7CiD1561/w4COS1/I+
 u3r39Zp0hwIl9oqcdsEtlJi9M8ShB2SFUfnibKIf6rULxBmVHKhIUclSocEIvHMbwey2
 NR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746192471; x=1746797271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubSbcn7zAOHPDZtTaQIa9au6yQFfdMsj4W9wD8fj0vM=;
 b=ErhBUUJr+VdGAJ5vSN950V9CEhVGi/KzLqEJZDCPcsP50pH/4s0H6FlWJq6YOiBRsq
 0utAuEiDhNQdbCsVW97FjY4Gq2zUzrqLg56ZUVNJWbzAEdmjXJS2pWMvte7Quwo5R1yo
 QaKpMmUftfWxUY9M+qBNnjNxscqiOWumrT/yRhoUy74YttE9ONkbA4MucoEOXxv6dho3
 6k6gaOkuOoSkzUXTvK6OOZOX0/Jw4mmiwASYY2JBpEh9EjpWnNIlGVmxqi7uohZtRECq
 nDkfbpOTrKlIvqOyohcAaaaykhL+UTy9grCt7eblb0jjAq4Eos0f5wsG2s7sA+wHAcX5
 zLYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfPcdGQUVgU4a78A3haqPe4BC2uEQbsKfj9Y8ydefVbehLfN816JEVopfs1Xm8M3nZUr58h8lyWArn@nongnu.org
X-Gm-Message-State: AOJu0YxElVfxBuIgwzft0FUxJjD26ReJoQdZv2KOpiEw1NY/4OcTi1mJ
 2DKe2JkFf/kJgQTLCTwicMiXr4ehkFOlcPorRClfVGvAwvg1pKrF31rybikrsnqIMNgO4wf/NCo
 o
X-Gm-Gg: ASbGncvfHSUWAkablkGAzpRXe+pgv9iWxYg/GA45lJZs3sevewUpQ99vh3JMTfENhNE
 plyBO6PVNTAPPw6pgkhzi12Mrv4K3Z2xY8BOq7cLDbHdLemS2oLvGqFb/5fAM2N2qmiE6i9TPAg
 bIfzfMOCtNjTt3IBYiXE4iaUdwu/bUmzvg6TYpnjDskFlmgCgbgDtGIZMuVaFgUvVQksJ4SWhMx
 gFJb7xQuNQoppXxPK3eGFVsgLkusdguSUfW6nQ9ChBvAlRD3HTJcO15PitY5V1ci0Sl3KLF931H
 i7Xg3svhqVjEojR8cPwEmf/YXoZ5jPFa54RCNLFXXtT93eKGuL6piMUDFIa6InLC2WAzGng7and
 c5t8+OFj2
X-Google-Smtp-Source: AGHT+IHnYFmTJcAtR6ei1dN8jXX57i9Dodoeb+zm8Xp4ZBrJEAnraV4dByKo/x6xFHL3GehXEaGGdw==
X-Received: by 2002:a17:907:a0cc:b0:ace:d077:3bb with SMTP id
 a640c23a62f3a-ad17ad44585mr282416166b.1.1746192471252; 
 Fri, 02 May 2025 06:27:51 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189540dabsm49799466b.171.2025.05.02.06.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 06:27:50 -0700 (PDT)
Message-ID: <75768b03-4ff8-49e0-981e-20fb8defd55e@linaro.org>
Date: Fri, 2 May 2025 15:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] target/arm/kvm: Drop support for kernels without
 KVM_ARM_PREFERRED_TARGET
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250318114222.1018200-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318114222.1018200-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/3/25 12:42, Peter Maydell wrote:
> Our KVM code includes backwards compatibility support for ancient
> kernels which don't support the KVM_ARM_PREFERRED_TARGET ioctl.  This
> ioctl was introduced in kernel commit 42c4e0c77ac91 in September
> 2013 and is in v3.12, so it's reasonable to assume it's present.
> 
> (We already dropped support for kernels without KVM_CAP_DEVICE_CTRL,
> a feature added to the kernel in April 2013, in our commit
> 84f298ea3e; so there are only about six months' worth of kernels,
> from v3.9 to v3.11, that we don't already fail to run on and that
> this commit is dropping handling for.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/kvm_arm.h      |  7 +----
>   target/arm/arm-qmp-cmds.c |  2 +-
>   target/arm/kvm.c          | 55 ++++++---------------------------------
>   3 files changed, 10 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


