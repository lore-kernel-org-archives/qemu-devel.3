Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C6C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcyS-0006yB-Vd; Mon, 27 May 2024 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcyR-0006wa-JG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:13:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcyP-000247-Vz
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:13:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4202dd90dcfso47818245e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716826400; x=1717431200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfmM0j3HF+vLiXdV40d+v8fDYCHro8ZxhgNASHgkLhU=;
 b=dujwixOeDD2yvYkrZPp9VWilbjU8pgZiDYKB0GSc8ijJjLq3vZU3S0W38W7PK5xF4c
 ykJpE+5tfDKYnS0WwvKQtqfOPeaJTvHJKsMztnaufr01ZqP80ZB5FgCrpftHE6dpJEXS
 wdsREcZtvhZZUJnjMSVqMGkzKxG1gBZcKxLvTyelC37ayHunMM7h02KbgHnCeaca+sNF
 iGWUB5UudLTTxgURUwWZVWfDwMeRYgKkun04hQpeeSkbrOFCIwfCHPm7E/7IKTFTHe7Q
 n7uWN7aEhd497sE3lsmS9tsFvCtKzwFrEFbDB+d0J/i293TzDXkFjDrXjr6bc1ULkwnK
 ZWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826400; x=1717431200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfmM0j3HF+vLiXdV40d+v8fDYCHro8ZxhgNASHgkLhU=;
 b=LNqKIL8LQk61Jd8V1pDuwU/3EjcdluG1rMpR9k4OZiq46UDKd/e5dcFmc8dPHmxAcF
 HqGQWMANWJuVSJmNkw68tts1NER5cjp9pEI00Y3Q8uZlkc6U/iXjllvlQK++va+Gb2iI
 UoNLFkvYztkEKRXGcrs5aT5IUipvtHBLOaNaUPQgl+VjTYCqnQmRO5+plocDEtpMseKL
 Mo0r6iXfmi8kZ+7eiXiYMdPg9FOXD3sjvSJI4Eqn8Z3Kax/YP9gc/UCoA9MYf/tH4pGn
 rjuvYzgxFpdeG8qOMlNFJ7SBw3QNYDvOAVD4HTqjQXOAzLGYkEjy4S1Vp1sPNt7rFgIF
 iGqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBjy48LfcIPU7DhK2V/ZAdM1mSppvWdhk7etDX7PLVkUod7sxUaLOmrxSwQcrqytVl1Dbx7kcJiHS8iHr7QInD+16qPiM=
X-Gm-Message-State: AOJu0YySME/LrMbU7A8VPOqPxsf3LgnGSb0C2BqRUv334PUmzHUO6EMI
 vglZiRYEoYqyqLdrq6GBz0mHuG6dpeyroeMnE+p2zl4KeLUA39ZPlZb215W1hmg=
X-Google-Smtp-Source: AGHT+IFPUBbJ4AV9nNMW5an0kxmRJqDQYgV9r0unWjNl5K2YvpMuoRlLjuLz+k0jRnurcN/gTOehvQ==
X-Received: by 2002:adf:dd89:0:b0:354:e021:51ce with SMTP id
 ffacd0b85a97d-35526c27950mr6660105f8f.12.1716826399989; 
 Mon, 27 May 2024 09:13:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0908e4sm9460093f8f.63.2024.05.27.09.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:13:19 -0700 (PDT)
Message-ID: <f4918050-11f4-4610-bcf3-2cca4ac0f3e4@linaro.org>
Date: Mon, 27 May 2024 18:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/8] xen: mapcache: Pass the ram_addr offset to
 xen_map_cache()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
 <20240524105152.1301842-7-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524105152.1301842-7-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 24/5/24 12:51, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Pass the ram_addr offset to xen_map_cache.
> This is in preparation for adding grant mappings that need
> to compute the address within the RAMBlock.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   hw/xen/xen-mapcache.c         | 16 +++++++++++-----
>   include/sysemu/xen-mapcache.h |  2 ++
>   system/physmem.c              |  9 +++++----
>   3 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


