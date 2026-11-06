Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F25606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma+qXJuV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tbjrTQBV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIw6-0003yl-GD; Fri, 06 Nov 2026 07:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIvm-0003kL-ID
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIvj-0007pk-Ke
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cqcg8FflfFk0KsQkfU1sHiREKKapMM9PlLOcj/lVGFQ=;
 b=Ma+qXJuV31GTgueFrpYklA9dYyhtLAPRyYuKzI8S6GMFML3niayhTIZM+002aZSzGcoNVS
 ztaTInX0E72tuSLC+cmZUDNy1LBsJ1bTYKv5P/RheViKJL+IJJUNXX49Q5sdCVgA6y/mgw
 bd7mZ9sW08FugHXDv6Nw0R8AQ+7UfJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-MEhMmvS6Og2iJVsxip3Pkg-1; Fri, 06 Nov 2026 07:20:25 -0500
X-MC-Unique: MEhMmvS6Og2iJVsxip3Pkg-1
X-Mimecast-MFC-AGG-ID: MEhMmvS6Og2iJVsxip3Pkg_1793967624
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c6a1d4034so622946f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793967624; x=1794572424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cqcg8FflfFk0KsQkfU1sHiREKKapMM9PlLOcj/lVGFQ=;
 b=tbjrTQBVQ2C29ns/8QHlYihvoK9qR2G2GuOMo9AbQtTjfMImGg+6NT1im9qEbJJQ0J
 FLRox2XjBll2Reixh/Wnjc0pqlfDZ4izO/fwBIstqwlQ/rRCGlSPJWssRdPMFpRk0F+f
 UKp4QkSN4it5EtbzCw2yFWZz1geOfNDolc35ysHx28tMHM06R7zeNuYFleeXnn5ZkiVl
 S2+JG65ltZtJuzrxUW+wCYcpLhCveajRPW3Al1c+GE6dO9E/QTuoutk0OMzNOFqr8/fV
 fTRXtNgZ4I03FmIwFQBodPs55CBTWRcOWqCYMD0v19eqeMhWpwvjid5ZzE4AJrmNtw2B
 tVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967624; x=1794572424;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqcg8FflfFk0KsQkfU1sHiREKKapMM9PlLOcj/lVGFQ=;
 b=viOV3xzdS5Y4KdoEEleLuFetE9P6SZOo5FfHMEKGVaLe+vv56OPxIysTi9VdaLRZz6
 VJSVu+jiAOhV7TFIsW63PecwmpsIPaWXR4q6rRVAlHZZ0JvlLq0iqvxJSs4+193js/vs
 ZWloWUaH4U/0VqBEsswgEIAnIxhBhV2Y1CEghsiTVf0PsJM2a28ZQQen+gLQ9GbDEmA/
 Og+iiSsL9ob1Lm4vg9aY9cvahIHc87VUtKn0GrVf7SP+JnHmXbMY+F1Ha2sPPDQHW1QN
 G/vQQZC6MalB03doUnPTgCUM9Gml6nllLfUp+AdOXqe/KNVhtcJeWqwYcYcdyUUP3Fv/
 D5Rg==
X-Forwarded-Encrypted: i=1;
 AL+hErHUXG9k5zPzkzYFHy+A5LEVQNA4/LWP5l6fL3prEwMKn0zEHw3uJDixnjwQWYTEyJ/KmDbznnh6lAu0@nongnu.org
X-Gm-Message-State: APuU4Z/QKKuYaIc8KT/FOuWab76Ach0g5o59B91c1YO0dFLQPzyHJn9B
 9flizGc4sPDo6d88bvxBM3RBY7xBQfZXWS9wLkTLleMehGHdWPBvkE/dDGi1YypgLFuXbsicIcO
 NAS3mWvpuvhSgNYjSS8Zw83k860ivrvwW8vohN0Vr5+bd6F7H3MVkJZA+
X-Gm-Gg: AYBFou0g4sgO1lz5TBZDPWsFyxLOCYiJJuL/umGKFr9wzo0sRAWpM4NtkF+H0xMJbiE
 yyFfcoqDATjCQ1utzLW3fhjGhtkoHSQM+v9EeJalSdiGue0/YqoRAkew88eYCj/C+wn6rh7Jlrn
 Ak2efpFKbVtKGSWac86y/HOmph4fPfTKpCd6kF0ayFo7MIWYlMiQqZRLRBN1zl76y14us2EScz+
 WfknOYuC8D1pti5fgK451747028GdO9uU2WZ8b47OrPrYJikEVkFyMtmy8rWeVzD50b0w5xSm7c
 R9Lk/zWMeBTQYFQ+nLdqpLE/wq+rCAreY5RaR4yAfRnzdpGoCzkUQd2YpC/ykiTo0LbANJplKrF
 Mmq1jzDz9dMjyfiLvGzs+qy4KhllpxOtQyGq0ckUdE5OSUUgKQDzVgcazBOqK97C3qfBBcNrabb
 4fMNQH7+3Whg==
X-Received: by 2002:a05:6000:470e:b0:492:20e0:f666 with SMTP id
 ffacd0b85a97d-492707c3b8cmr4880606f8f.0.1793967624412; 
 Fri, 06 Nov 2026 04:20:24 -0800 (PST)
X-Received: by 2002:a05:6000:470e:b0:492:20e0:f666 with SMTP id
 ffacd0b85a97d-492707c3b8cmr4880558f8f.0.1793967623904; 
 Fri, 06 Nov 2026 04:20:23 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d809dae9sm3290194f8f.52.2026.11.06.04.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:20:23 -0800 (PST)
Message-ID: <e81da370-9301-4d9c-9037-4961ddd896b9@redhat.com>
Date: Fri, 6 Nov 2026 13:20:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/28] hw/display: mark bochs, ramfb and VGA as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-16-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> Most of the display adapters are emulating old hardware which is not
> relevant to virtualization use cases.
> 
> The clear exceptions are the generic, simple devices that should be
> considered secure: Bochs, RAMFB, VGA (PCI, not MMIO / ISA).
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/display/bochs-display.c    | 1 +
>   hw/display/ramfb-standalone.c | 1 +
>   hw/display/vga-pci.c          | 2 ++
>   3 files changed, 4 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


