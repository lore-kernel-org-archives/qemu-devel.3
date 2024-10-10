Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA0CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywBK-0004KT-Si; Thu, 10 Oct 2024 12:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sywB5-0004GG-2O
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:38:17 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sywB3-0006bM-Ga
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:38:14 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2dcf4b153so527590a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728578290; x=1729183090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iD1THtGkw2s94rEXpaYNmKWMNrYewJBmceo0xesUU6U=;
 b=HUI/L3v3Qpv4jBt4X4ucNMS/Y2/OO1vMG2ZtB8LxyujFowfJ+OV5ZJrhwiQRCEy1BW
 +rCB8dLnzmIsiMh080yCIZgwmHlkBxCP+fUZ11RZCUzi5xqCJXhio20VFLijcx8QHBX2
 GJMcxAlC/ihrJnT0cucKoyh+IXYYX2bxQ03MNSen/2wMJnU6McGkodegumM97YmuSnfy
 3fWV6sDt5eb0/DtGE+wdIQV2LCrqAKxPBlYLo1ms5W11gt+ZFTWMo1gHQRNeMTM19XEp
 7iwfH11tpUUj64uzvl9wgmRy+RKgHu6l6QxF5ZwP6+2hHoZppD0gQsuNaVu0hd5yxQdQ
 Mnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728578290; x=1729183090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iD1THtGkw2s94rEXpaYNmKWMNrYewJBmceo0xesUU6U=;
 b=pSlfdGclO0eHIlDlhCFqbZJ6TPJrdIQWlL6WYnC7hD5ooCgonD+sPbUzVDcCnypZjs
 pL3auoV5Vc7S8pRB/xHNtVLbHYsJKrDYYUzzPYMrBPvYRknJ+/eq8JV/Pf6lnIl6Wl8l
 FEnpNd0vQHVJfH/U5kVa2Kl4G+sCcqGCf0W3xUKP1nzjUIHORiHW/2z+3vQYxS8M65uZ
 YqCt1vNENzd5TXtdWt8rJL/4wgHbaIehJ7y+VB05SqxCJ2cHVAZl7AbAplFkhZVXNhDC
 1Ntp/Ze/Y1FV/hXWPjXYZlS18BVhLmUSMEsFgNikbxeYguEr460tTN78z/+sVseIyJYB
 4zFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwCfCgMJWnUc76c1dY78A6Sv4zgEPLoWg2NOj3i4ZGz1RpxO6lkPNiv8tTK8gY2YMOw8eJqyYAgm3u@nongnu.org
X-Gm-Message-State: AOJu0YziFXPK2NRSutpondPPaqkOO8L6VqzSy3KeWS745YUtuF0jyyB4
 ZKKyek8ha2DijpLQyp/EQ8hzsLS6p3G0HVw/qlVmJfYa1XOdxTToDgfu9htvvfg=
X-Google-Smtp-Source: AGHT+IHaH4yEFKQdFh5t81plJ4PIn2xqMWtvVqBr+bb1+EX77bRHp3aeFccIhVR52iy0MJKAjJVIXg==
X-Received: by 2002:a17:90a:8a82:b0:2e2:9e1c:4461 with SMTP id
 98e67ed59e1d1-2e2c63aaa57mr4483081a91.25.1728578290306; 
 Thu, 10 Oct 2024 09:38:10 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2eba1a23csm131152a91.25.2024.10.10.09.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 09:38:09 -0700 (PDT)
Message-ID: <591d4244-3264-45e1-805e-4ced406d0a1d@linaro.org>
Date: Thu, 10 Oct 2024 13:38:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] block: Adjust check_block_size() signature
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-4-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010150144.986655-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 12:01, Markus Armbruster wrote:
> Parameter @id is no longer used, drop.  Return a bool to indicate
> success / failure, as recommended by qapi/error.h.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/block-helpers.h                 |  3 +--
>   block/export/vduse-blk.c             |  7 ++-----
>   block/export/vhost-user-blk-server.c |  6 +-----
>   hw/core/qdev-properties-system.c     |  6 +-----
>   util/block-helpers.c                 | 10 ++++++----
>   5 files changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


