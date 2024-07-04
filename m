Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F2DC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 16:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPP5A-0002Zz-Ig; Thu, 04 Jul 2024 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPP57-0002Zc-HA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:13:14 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPP50-0003h4-Il
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:13:13 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c46c8b0defso414804eaf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720109584; x=1720714384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pku2I+y9JB4gMnvz04hc6wlS9R3406ct2W12MXX0IZ0=;
 b=u+RUYvJaXhVe+P3NWDcbOgdGhvZ7F3sjePhi2uYgv0qSfZs6T05gtT1qKxgjCYizt4
 rW4+GXmpxlvCpdlKDzhOO6vBY1i6HeZZxJfyjawGz62TReJGO9Sk2VbPcRcBFV1XAfMh
 6UBd/aYR/zPrLPNI4NU+VrAPKQiiuz3adX2VJHeVRouDJoHg3n6T+CCdN0A1lDLEDBqm
 z4PH5kI1JJAe6n/Z3jyOiXPLDCcfZ3SmlV+dRT9VqAk59OfsEu2S+OO6KHEiTHRQFy0l
 5p0D0ZIXGBka2YA0w7krs55v05OuasSmYkMwl2j17+Yh5Klr8GbxwJOnE5gWcEQJAWYp
 ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720109584; x=1720714384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pku2I+y9JB4gMnvz04hc6wlS9R3406ct2W12MXX0IZ0=;
 b=Bvjix5ikLaU1jVLxRqF3B89o16vVU9qkcUg1gdRj5T7mqX9DzE/OhIQ10dFMqMKv+C
 tNdlOhb3jKlOWplcRDLGh+kHVQMMXG9xFQNAbT19FvqngyI91LPuWyCZhkRN+UBgIlgU
 EZPL13eutlUTKBBV35jR/4KXyQsbwv5+xFvKlsR/pAoihWFlduM78IlJeXUUB7reYg0F
 9k2Q61guO6JF4LZfElcYgdsN7sJhCVnnxzDmTucOWKCDVXQBunJhgf2Ib5yPferJk12L
 HB5Cm0zNXa0l+m6+bM5Kl6pwRzP2Be2Qujh6D+j9s90xy8d8vWGlj3Q7MI7VmbL7BRPf
 rdUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMvydoS+B2n2TTNc7FC57dyiFuNSGLCeejWtHm98d1pY9yqTIMK46dgmAnf6jBdFIEpgcvXS4K4GIQ0ubQy0Kw8DVpPbk=
X-Gm-Message-State: AOJu0Yw/njCdbRWFLQJE5+gOJB6WGB5WtZj6/8LuT+asJjsOj9FwGKCf
 SQyQpkKKzkDDBlYe3MQsY8wqw4u8jMGaEXDU/KwiKXetn9oLAcfx6yHtQO0zmMU=
X-Google-Smtp-Source: AGHT+IEr8h9JJzTyFwjMmUND8DqJmTlBOIbJaTT/h4p2tdFZOKybe1Qo6E5rZpJCho5biInRgm5Uig==
X-Received: by 2002:a05:6358:618c:b0:1a4:558c:e135 with SMTP id
 e5c5f4694b2df-1aa98c7aca6mr168981255d.30.1720109583602; 
 Thu, 04 Jul 2024 09:13:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70801e53b2csm12420531b3a.39.2024.07.04.09.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 09:13:03 -0700 (PDT)
Message-ID: <9a4d8995-9283-44f5-b3df-506dead90bad@linaro.org>
Date: Thu, 4 Jul 2024 09:13:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/85] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1720046570.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 7/3/24 15:44, Michael S. Tsirkin wrote:
> changes from v2:
>      drop part of vhost-user posix support due to test failures on freebsd
> 
> The following changes since commit 1152a0414944f03231f3177207d379d58125890e:
> 
>    Merge tag 'pull-xen-20240701' ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging (2024-07-01 09:06:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 6a67577d8003428bdbeba61d32a9f8158f12624b:
> 
>    hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-03 18:14:07 -0400)
> 
> ----------------------------------------------------------------
> virtio: features,fixes
> 
> A bunch of improvements:
> - vhost dirty log is now only scanned once, not once per device
> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> - cxl gained DCD emulation support
> - pvpanic gained shutdown support
> - beginning of patchset for Generic Port Affinity Structure
> - s3 support
> - friendlier error messages when boot fails on some illegal configs
> - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> - part of vhost-user support for any POSIX system -
>    not yet enabled due to qtest failures
> - sr-iov VF setup code has been reworked significantly
> - new tests, particularly for risc-v ACPI
> - bugfixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


