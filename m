Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E70DD637DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 22:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVdsa-0004tO-KQ; Tue, 16 Dec 2025 17:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVdsZ-0004sj-38
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:50:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVdsW-0000NW-In
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:50:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a09d981507so83235ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765925445; x=1766530245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrFSEXMCtN9IHtH5gK78qFKwKLLgrg3aX257v7py5T4=;
 b=bTAQShvFUyo5BG0V1aP8qRF5UbGT3ONFOqyIkHUYhY/tdn+BOqHrIIAAaQkjWyuTpI
 JwgR+R7TsDb9JA9XExrFu3z4NovB5i1l6sPEkpO2Q/VYJzimt8Cmmn09kiLgAWzmXv8c
 4zWOwbtxvbyQ2JmkPQF056Xdgqxd1tvUL4sktntKubUX8OnRpDDOVUnzb6T8v08JxxYO
 l8qDw/I7OP6828PguUq6t697MXxF8tpb2QyRP1G/Zpk65IETOOrFn49i5D1WvbzF6dfx
 UChH9uX+JM7dThqZaeBqIem1u7BVk4iP+ewHNw2F5H1eEvySBbyIxoRGrS0OLervnoLe
 PnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765925445; x=1766530245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrFSEXMCtN9IHtH5gK78qFKwKLLgrg3aX257v7py5T4=;
 b=k2m5rr+TlyAgn+JHJ4+hqp8Cx9CrF4RgAGNSymaHXYMzhv0AWCMKcfBSXpGAChQm0N
 PKWlgaCL6TnLHM+k7/WeBrVBFpZPFehb9lOVuwJ5g8TRspwJKloLTQJ8EU3cgzFGmtQM
 aGkEew3rR3jCLMCll3uuRZDAwuObO8/wg9jTjfcL1nodbP+GHzvcYbHqd+ZfE70e4HA7
 XZHArDrYVwrTDlRAs6TeywsZcP8vD4djK4VJDT6XPBRgn9BNw7CTw8RWOIt1tee2/Q4o
 JmCl307AY2N3VrtFajGkwOn7nhzlcdoN915ri1vPd1lIrrPGkaAhl9h+rfHWQ3wgN45Y
 DZ6w==
X-Gm-Message-State: AOJu0YyGOHN51uA1wvZ/P3lLf6DRL11C2vSS7kPIs6GZgtdkGuylaF7n
 xl7P0ionie9segCvazV2MZMR+1pzNnNtuLrvmXKHY0jg0zaDa3sPfGyWwDF0zV3aHXGf2z1sncn
 QvSeFnfyKHw==
X-Gm-Gg: AY/fxX6VT5gS70s4d3tE3hDzTUWU0cSm4RGikIW/Bnw8XVb5iCVPDaOjUG4tv1wPprD
 uoDuvvFdgWn3BK7eSRUPUkIpAqrmLv2kvKRmuIN/lWVZUvXL7+U/NeOOpt7TgyzWP5IWBjHXG8E
 fAKKH2ap9AM6YXibcQoX3bA7bnXZeU1o6gWtB9OzvCc0U6yn8XFuccc5Um5fYrhhzNSaA1hjUUN
 lGreWMWkWglzsH2SAenv6Yb+suCcsTQITXmwhrNX5K7kvl8B6Kpy9wIQI9cUUovto6EFFkKtRPF
 weLMnwbdT6SNb2wbziL+JR6lvmdzRT4/+w36qLPXW6cz0sxiczLv3F9bnYDYbQRpbMKbLoUolFN
 9wVjmosQqJ8kksTHmf+Lj1Ny6Hdr69xZn/O2NbkMlIQT+Idhz2xANCNrtYJnppn0TY72hTO0RCy
 VqPq0qpzbiZrTP2jliYhF9lIIMFgeP8uta1OCeKB7xkesfHvFfrqXkkyI=
X-Google-Smtp-Source: AGHT+IFkazMF2ANplMozY98aE4ccIf9yp0XEK5AdL1iTypBVmrcHEuC4X8ITn4ISbXMRaluxXA8RLg==
X-Received: by 2002:a17:902:db11:b0:295:50f5:c0e3 with SMTP id
 d9443c01a7336-29f24e6fd04mr182094245ad.14.1765925444614; 
 Tue, 16 Dec 2025 14:50:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29ee9d36ddcsm177245115ad.32.2025.12.16.14.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 14:50:44 -0800 (PST)
Message-ID: <84215ba7-f529-4321-890d-44c0cba855f4@linaro.org>
Date: Tue, 16 Dec 2025 14:50:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/smmu: add memory regions as property for an
 SMMU instance
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org
References: <20251216001053.784223-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216001053.784223-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/15/25 4:10 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 52 insertions(+), 9 deletions(-)
Sent v3:
https://lore.kernel.org/qemu-devel/20251216224845.1673051-1-pierrick.bouvier@linaro.org/T/#u

