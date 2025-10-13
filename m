Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A47CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Nxa-0003nT-Ez; Mon, 13 Oct 2025 15:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8NxY-0003nI-P1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:11:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8NxX-00016L-5e
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:11:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso29824285e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760382709; x=1760987509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d69zgUPTrFtp82ihw3AHcKLF/RSIV9yvM7YaHsx5tA8=;
 b=M4wyZOtPBbHQJkZYQqyovaWHTJt9A5kfDJXdRBq4mVl+tTgdVHRCIlC8dLI5+OdbpI
 MPZplfG9x4Hw1bO04U7KnBulnWfvCou+36ivCPTxq4KuyD0dfGPVL5Aif+lCGyO1ESrP
 tk2zEiAgmhn4/LyTFvI+boNHRZKPZAVPTizy5Fooy/9TYZjiVELhjIyDUKovAaxIjv/4
 y7WLrcAnSEdb9mCNYXb1emTZlaYsFnRLVkWwsO4Wr8gwRqEzrURXmKRbx4+s2/Grw0ZH
 912TP5TNFtVa0xNg+dvwy94XM1ub4Pn6J0Z7RWkvGX68H679afCu4zErPN+kqEJAdNOM
 MdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760382709; x=1760987509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d69zgUPTrFtp82ihw3AHcKLF/RSIV9yvM7YaHsx5tA8=;
 b=QPT3pIH7+x/e2HWapyZoJ4AbhtsPE/R4cY4AcCCCKIDCuifn5Fj+kqPSnLnx5gbOup
 kMIIIXMqry6A9sLHuYQIl5xZ5T0VzbwtAjzmF1Fy6sr5GlcIrtm+Ek9Lit6Qa09gLE4W
 pBOCP3Wl4g0TY96mlK66y2DK2p75KVcdx+D4gf2pjwrH6+nuGNnle6rJbL/WXVqzZhqJ
 OTCJOI8SpCp3/Ptz9YrmzmeDejxHP0gPxhgjU+sM9XtsPrbvRZU76qisH5wAo8TNDQqM
 FAjwWZTx8mSlP8Kym73O4OF60AWr09bE3Ud1Cpyx+eR7hxIuvvmjrOYx9crjqJgpxZxC
 eBKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp7T8hVHz/A2k3V/xfQGEL+zfN1uXQt6YS0g/tFUQZRIDj85zwpK3pVHUDlE6fHl2wYO0YoO6L4U10@nongnu.org
X-Gm-Message-State: AOJu0Yzw0USEnth/SNFRmox3JBV0rff57Lbwv63lrc29YuOUMiqNkEt+
 6cnTxecdsyGhu1NXLMpq8Om6+BAJyDqLFu4Hd7ZlNQzaTPmsLI3LDbuOOf9QGwklyvw=
X-Gm-Gg: ASbGnct9pNyhBIH4YYErY/FKt6F1cZo70rh8IZ+UlNXrInR4u4+rx1EZUDUuxXo5qcz
 NL0Ve7npaKU393hZ9zDFfdfwxdWHXsPmLBdW9/oKZCwqg4Uh9S26LgZ3/u0e+4wmK9oa9oHagb8
 VKNi8DlXwvL+nwQujxi5HmKr/eiTkgP/MJMp5P4WYK4jRn1/yfMyaSncvQoWOwiTKgOwqZ2fgsm
 gHVYa33aH9pwybAVk8rldBHjeFPmFn55qkpMH92tdO/Cc8moCemd6KYZ7LaopcW/bQ/Pnu+KxYN
 Tg+U1jWKorpVwnNXJKCHq4gkfkBLYKHV7HiiVh85oBy7MnBaDoKKlTJH2zMpIN0fqVlpOgIUmYd
 PZABEP/NHAhK60ctv732tJWQlwEjl3G18HahDPKVlsDHWjQ2CXivrf3Hx+0qdZ6X+ie3BKwdjnT
 /Yr4R4VA5o0n2nvJJbORZES5U=
X-Google-Smtp-Source: AGHT+IHTv7ds5d1Hdxaf5RrzZwtZHemrwN1cKiLTx0gjCJxPscNWzVgRZ5NUDpFcgkLQPoY/b1l7AQ==
X-Received: by 2002:a05:600c:828d:b0:46e:44bf:210 with SMTP id
 5b1f17b1804b1-46fa9af8107mr149584195e9.22.1760382709251; 
 Mon, 13 Oct 2025 12:11:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm19709652f8f.37.2025.10.13.12.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:11:48 -0700 (PDT)
Message-ID: <7300d719-e354-480f-9476-19e251a461b1@linaro.org>
Date: Mon, 13 Oct 2025 21:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251010071008.2555267-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251010071008.2555267-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 10/10/25 09:10, Gerd Hoffmann wrote:
> Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> optional support for logging to a memory buffer.  There is guest side
> support -- for example in linux kernels v6.17+ -- to read that buffer.
> But that might not helpful if your guest stops booting early enough that
> guest tooling can not be used yet.  So host side support to read that
> log buffer is a useful thing to have.
> 
> This patch implements both qmp and hmp monitor commands to read the
> firmware log.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/monitor/hmp.h      |   1 +
>   hw/uefi/ovmf-log.c         | 265 +++++++++++++++++++++++++++++++++++++
>   tests/qtest/qmp-cmd-test.c |   2 +
>   hmp-commands-info.hx       |  14 ++
>   hw/uefi/meson.build        |   2 +-
>   qapi/machine.json          |  23 ++++
>   6 files changed, 306 insertions(+), 1 deletion(-)
>   create mode 100644 hw/uefi/ovmf-log.c

At a glance, why not "info ovmf-log" and "query-ovmf-log"?

