Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2803BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Rkn-0006fp-M7; Fri, 25 Apr 2025 18:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Rkf-0006UU-L5
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:42:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Rkc-0006o8-V4
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:42:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so1941361f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620949; x=1746225749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2rbLStzN02M5iQRntjfJCOmskoQoKr2a9tppL9dGyE0=;
 b=ENWHBwxMZqY/3/KPjGb6QroOmMtkgkiMYPN3VeAyxm/gm8MJsTyaeH/Y7PAygif8Wi
 7wX+QvVGfNtdWH6G2r3cV3FcjuZCQXI0rzX8taMp167i1CS3wk4DHDB9m8kI92HT4FPD
 PfQmNVzAI3S2h/VFKSIvahzcps7uPn6NnLzt3IBWlnWzzk5yx35LgWOHsFHO4xuFS+Rk
 6oLIv6eoUeudRoOuc54kNAvACKMYjWi88rXQaIpLSvv1ca/8xlj1KSTzOGcrQMZBLHn9
 jnXmt2kCAuCGiX4r+bTvwnRWwcKk+ON24GEBfLdrJ0DpkhqY5a5q+b+aRaTHwBPl4LGH
 gWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620949; x=1746225749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2rbLStzN02M5iQRntjfJCOmskoQoKr2a9tppL9dGyE0=;
 b=rmlWlb0y5vGxHtdFtFPN/rjBsoEvDcrXxrFM3cxXreOx0ADVhBQ4P3pCvSFIo6NSyR
 IWh3UbKMISMV+iDneB97u4mHMdnpExtRa57Ya0BQii9n2uBZ+jt+cH3lPttKsaP1dLFf
 h3dOTdCokJptYmWaqHm3SE9rN2i1p9n2vQO8NJ+TEcS6TOI0d3hQLQWlca2FZmCWI8CQ
 d6424ektqxIYVarRxAf/I0Wi9I7a+c4/Jn796yn8hmUGyvCfGfyvMcJO5bybMS1JhiiZ
 uaQaPzzoXqVfWt4Aw75WmKX8TQnvblScONY8I6H00E9ftbRgm8RtO/Ar8mEKCf3FyLMS
 o2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmA3Pc7fmUi3/iHzbiCVhUPyab1yTJDrReaoaR7FguXqT1BpKP3D56aVBIbi9XaMBxm2HSA7huuimP@nongnu.org
X-Gm-Message-State: AOJu0YycSvQ8mini8CB9p5O3dkxYsTbauCZg6Q/XlCrEujX+UFWeu680
 8yYpuXTlmahMFTzHJVygH8D5joWUF8RtxUJLb9GHN8y1ZLG96AAueGjiFRYDX+A=
X-Gm-Gg: ASbGnctSWqsM54ps62z2jFi0xePHXUiJyJkbZaGMyumqfcXe+EDgFMeQHHrCtbq8Yqw
 JKqUJHn0CHGS/WP8FAXtFtVw20ucygc+NBh+PG5HQ942422Ps7/N+pMj/U32Fe01KnTOPRE/bN8
 ae4DBfbMIcFYGiI5f/6q8pq1IHwPh5BnYhsBxyT/yvmQL+V59oQqP9GCCO0js6hk7bp8JVgSPsp
 HyhyJkZeJVwVZdBIs9PjDGYiLwTrFwmeAV9qfCZBj/bJuZAQ7dgGfyfZFyzRxts4THhVq50Hgkb
 /KoKNeHGeU48vgS68h9INYgFrCpnN7L+r0pX7HgHE00lOSpcgsjtU9maCQR39N5k4hb+n3eBG6U
 LvOR1M5d+btYT1SX4HYM=
X-Google-Smtp-Source: AGHT+IHoi60J8kGJuJ4heN3is2CD0TZDRV+KjV20m/nS1r41fnVm46rDJa8MdeTOb/RHs7hxCM5gJg==
X-Received: by 2002:a05:6000:178f:b0:39e:cbf2:e23f with SMTP id
 ffacd0b85a97d-3a074d8f101mr3552075f8f.0.1745620949191; 
 Fri, 25 Apr 2025 15:42:29 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm3545086f8f.27.2025.04.25.15.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:42:28 -0700 (PDT)
Message-ID: <8a93af10-e921-47b2-a051-e2df03929fe7@linaro.org>
Date: Sat, 26 Apr 2025 00:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] xen: mapcache: Split mapcache_grants by ro and rw
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
References: <20250425143156.204452-1-edgar.iglesias@gmail.com>
 <20250425143156.204452-2-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425143156.204452-2-edgar.iglesias@gmail.com>
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

On 25/4/25 16:31, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Today, we don't track write-abiliy in the cache, if a user
> requests a readable mapping followed by a writeable mapping
> on the same page, the second lookup will incorrectly hit
> the readable entry.
> 
> Split mapcache_grants by ro and rw access. Grants will now
> have separate ways in the cache depending on writeability.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


