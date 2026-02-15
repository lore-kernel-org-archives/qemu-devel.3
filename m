Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC30EF585F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 02:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrRc5-0007Tv-OX; Sat, 14 Feb 2026 21:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRc4-0007Sq-KF
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:11:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vrRc3-0002Lt-1g
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 21:11:56 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43590777e22so1261975f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771121513; x=1771726313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e6AJVNLmOMpz/vWf7DI6kQV14oLkRB5k6zGG2ZpRbqY=;
 b=WBAoD8jKCabGPPPnEShMDapvAlcxpKzOfIHsQtlPI0dkpbgH0EZ8tVmoQJYf9/Tt2Q
 daepzm8vhxiVYVnbYNQoDokuU/Vf2poLz34aNo8OModPVSpEVhiQ0ghxl6DqtNAq8LRm
 6kCWYCyJ4antKOYI4WAv/de3djZoQYnLgYX2mBkKoKK0G0kybPviEv6VPVDIu7SdAGOs
 ZSd/4SiIVcFc2Qqz0fiws32KJIQOuOPuYsb4kaCLtFky67Etbl5TSysmALa7FA8dBDE6
 uCTIH0ETA1keqN9/cRo4KJbsPGb3HXjZsPzjb5dm13U55ir/XnMlb+WxIslVnmxzFpP+
 ss9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771121513; x=1771726313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6AJVNLmOMpz/vWf7DI6kQV14oLkRB5k6zGG2ZpRbqY=;
 b=ImuWoGK5pcVzv4gS5t4UDRmfyP+aYbWKa3eyAkhJmb4ShbOPmjt7RWf41YdpT0pUt7
 BQqcp16mLqkqU9u2jOAS+Vf8nl0ykDgPY3BetWzDOVj+nBFhsgK7lXGW35zmIlNutDxu
 b4e831YdGLK+AxWsZdmiCrHZnU8bEEQdb32v5VSsXXkOTVY2z6D5ht70d9GAWSX2uLoG
 jZ3SDA4KowKQ5q0TLFT2JhAP36Xb0Vg/blbEcSsyJAw3/fHSGVQw7apaGNmyMFTHrEi4
 l+rcWfLIZJjHIrtI/SBSe7f0tSQVD229qYvOB1HpvYXQPpcLMk9tb7bujmKukDqYcHI7
 3Qaw==
X-Gm-Message-State: AOJu0YxGdUCGKXhD5Ka3DeEpzZi0GzdjK+DsvYkJqzZgBeUe1c1m+Lt2
 vVv2SK5TBQqNj7sEEZ26BlKbYLZObJ+rFblY6MQb75TKpmCdW6M8wO012VlLLRkAHB1wlPSdIxM
 z6FwtajI=
X-Gm-Gg: AZuq6aK8KLofK4F9CJJnIgAUPAkKQmuQKhV9Pxd9eAwbVIH18DT8VGX794HuNq8PmIK
 305ffmogLrO9Fhxqv9Pv8WDKrft7+jbOAeTheqoEMMPi1N9WBLE51wKhP1m+k1SpovNrtPq33Kj
 TAjRY1X5vR/2C4sO7OO5+GcEmLMTXnETGyDYcF5IbtjZTFrT1qxOU4XxUPTKMSUEW0OAeyXJYQC
 F91U/F2Zgc88F+5bU5kcsorNCnxCxS1uZvdJkg4+ugdwMurNu1rwqZ+EhOFsG2Zj3ZUgkI/xSkA
 GpNagV8DE1LA1ttlNvJ33HE8zXW9oCZ0er2njq75sdgm/MT9/ST+uoM1/bMRKTTu2uCPPQJaPT9
 mBKkOJWmD8M4W1aI9YyES1GrE2WT87pz/Rq6luP+hG2AoD1PVL87/ziieUrN9TRwDr7wgJJhvTW
 BjxpnK241j9c+Z3+ZkT54R4XggpPBuEOZ9ZqLyH0ju7tHOzXT+QbfV/O7NhqoamVk1AQ==
X-Received: by 2002:a05:6000:1ace:b0:436:15c3:9163 with SMTP id
 ffacd0b85a97d-4379dba72e1mr6280053f8f.57.1771121512763; 
 Sat, 14 Feb 2026 18:11:52 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm17224111f8f.23.2026.02.14.18.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 18:11:51 -0800 (PST)
Message-ID: <4d6ce215-e75e-4862-8c95-d620a2d3a578@linaro.org>
Date: Sun, 15 Feb 2026 03:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] system: Absorb globals-target.c within common
 globals.c
Content-Language: en-US
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I was expecting Paolo to be picked in the Cc list but apparently
he isn't maintaining any of these files; Cc'ing explicitly because
of his comments in
https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe-b057-9046c70044dc@redhat.com/

On 14/2/26 03:12, Philippe Mathieu-Daudé wrote:
> Slightly rework how the graphic dimension variables for
> the M68k / PPC / SPARC targets are initialized, removing
> the need for the target-specific globals-target.c file.
> 
> Philippe Mathieu-Daudé (8):
>    hw/display/macfb: Constify macfb_sense_table[] array
>    hw/display/macfb: Constify macfb_mode_table[] array
>    hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
>    hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
>    hw/m68k: Set graphic display dimensions generically
>    hw/sparc: Set graphic display dimensions generically
>    hw/ppc: Set graphic display dimensions generically
>    system/globals: Build as common code
> 
>   include/hw/display/macfb.h |  2 +-
>   include/hw/ppc/ppc.h       |  2 ++
>   hw/display/macfb.c         | 18 +++++++++++-------
>   hw/m68k/q800.c             | 17 ++++++-----------
>   hw/ppc/mac_newworld.c      | 10 ++++++----
>   hw/ppc/mac_oldworld.c      | 10 ++++++----
>   hw/ppc/ppc.c               |  8 ++++++++
>   hw/ppc/prep.c              |  4 ++++
>   hw/ppc/spapr.c             |  4 ++++
>   hw/sparc/sun4m.c           |  9 +++++++++
>   hw/sparc64/sun4u.c         | 10 ++++++++++
>   system/globals-target.c    | 24 ------------------------
>   system/globals.c           |  3 +++
>   system/meson.build         |  4 ----
>   14 files changed, 70 insertions(+), 55 deletions(-)
>   delete mode 100644 system/globals-target.c
> 


