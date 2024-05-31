Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E600C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwzo-0004ZU-96; Fri, 31 May 2024 03:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwzl-0004ZA-Kn
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:48:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwzk-0006fF-0u
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:48:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35dc7d0387cso1893653f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717141690; x=1717746490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/8YDU1BDYBElDDEbozTcKR6dhTWSJzPfd8q/v7yPR0=;
 b=bFMD69GFkxT7cdNwFxD6aEoibAuL8KQKfLjD9tqe59XTQ8CBL4wD5a53RF7EFwsoF7
 xv+njPKakVMwqqb76on5b6DRw8FFO+eFHC4KZl9UVs2HdTBNcOi7t2sfvJHCJOOfcFLe
 uesJU8fcY4ZvoNWzsQ8nZ9n+qubApiwGTmMXWPChGDDWlWrnSkyMsW0wD7DBVWN8t7qU
 O+MkkLMkUtLSUwjgrmWhrTdbmzpzPFeZLDMU9nJYbgkHNmKnxhPSgEiDn0bhzfuw/s1W
 U8HPifOgAtRVg0mixd1IG78THNZROCbWRPmZ0h3592i5Ks/4WhIG3QM+rWWtI76W/tyR
 CZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717141690; x=1717746490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/8YDU1BDYBElDDEbozTcKR6dhTWSJzPfd8q/v7yPR0=;
 b=ZzFV0LHkIS/boMmJHheiPVL+EqbDi1aA1PzGmF6oCQMaxu+w1Irz2Bfne6wdMurvDq
 wDClOcIWPSkegxvGdDgEa/Bq+6kFuYK+eeuiQWYKh8vUJmUv9NtYjzvBDT4J4X+JXtgA
 EBlEpJ6mypm0hjLHbBeYu0YUDBlFOHGi7fg+bL998FEFEjdKbG5d12x4I9fyLroU4jps
 u4KTBYEqycHmYqJPwO7Dy4xyv2ME5kBGmq0FLXh5PaC8h+PNJBUvza/CZfZ5ohcYM6pl
 WbBiX48RrZObEB1I4fTc/p7RS3teE43wXrnRoTtQ3tDj0A2QOYg/uHDjYf50e5awjZ/f
 esyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFuAaAoXTFajpNOfgwO1XcXE/rr9A63//PHdu951+dQJg1EKJvfDHDmu8mk91PniSpOlHCbB6g0WLQcHcHR9hE512a6ss=
X-Gm-Message-State: AOJu0Yy9KMbIwt1yAbN1MlJRyf2Sz31wmBW7ah6L3AIXa8aWIuHZ7nLA
 1hkgvrQcfzsK3CDM4cWy2Cc85/FM+sn4n+MRnx4I1Oprq3BIwOM/nuuEiOAOv6w=
X-Google-Smtp-Source: AGHT+IFaA8/EQIpCn9qdpDfT69X2dBfducVVNJpoFxS9TTTScjqkbm82cBGWhknM5BRlNW+GLXOa0A==
X-Received: by 2002:a5d:452b:0:b0:354:db70:3815 with SMTP id
 ffacd0b85a97d-35e0f254598mr820756f8f.7.1717141690331; 
 Fri, 31 May 2024 00:48:10 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d479sm16698255e9.3.2024.05.31.00.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:48:09 -0700 (PDT)
Message-ID: <996761e8-456b-4523-b1ca-f3e5c48d86b8@linaro.org>
Date: Fri, 31 May 2024 09:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] osdep: Make qemu_madvise() return ENOSYS on
 unsupported OSes
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 31/5/24 09:28, Michal Privoznik wrote:
> Not every OS is capable of madvise() or posix_madvise() even. In
> that case, errno should be set to ENOSYS as it reflects the cause
> better. This also mimic what madvise()/posix_madvise() would
> return if kernel lacks corresponding syscall (e.g. due to
> configuration).
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   util/osdep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



