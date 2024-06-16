Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F29EC27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIuFL-0004Gu-Rj; Sun, 16 Jun 2024 14:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIuFK-0004Gc-GK
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:04:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIuFI-00075M-Uc
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:04:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f717ee193fso26423075ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718561091; x=1719165891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EX2S7T4MOXJr8cjMXMCS+XWIyTwLweIYoN0glkySBpU=;
 b=x+BO4jCbqWIlRPZD3g23BGWkiFKK8yWwbFk6A9Z8DnrPJYSy9qq4gk8PGklxMxBdvP
 W71aZuMF3xlyIZJ8GpmFGe8FUwSGzm9LQe5i8qaz6q7HIQk2kzZ4lKblAJutC1vfxCfc
 Ac3a+mhkyUPvSN7iLK/OgC71amG7VAFSyil6UHOX9/KHxVE2pPvKegEhqFPohpbdgw3S
 bdBSrg+HdWsttdGJywx04WbLW++MBDc8SI71LtqKVZBegXx6WBxKZx4Ttz9DX5CqsnU3
 HfuB4gNo31/gojD1b6wp0/n9i+NdJlC1dV4zC2JkqFk8DMxiMbpV+Y5/46tQZ08B2Wjc
 6IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718561091; x=1719165891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EX2S7T4MOXJr8cjMXMCS+XWIyTwLweIYoN0glkySBpU=;
 b=lrQPfaqG0lNczb00BbOn02aiCMp3iC6MQm+PEqIce8WDF0mK3u/4YOmzyzpsggzmMr
 jPmCjnBKrPWO/b62s5d3Vhg+ogoyLQeKjNwjVjOoU2o/lzd17pWOcmX1xsPci2ki+YCj
 K8oQY7JGtIjZn73X9GydUPj6iRfSr37b6cj2dbt9a3VmZn55TIu8L+fwu2i3ZOUKk1H5
 iHYqL8rgwdlBIBBMJXnW1qNlO1wdad5CVaUXzKYmR3Zw9hdCv96DOyi1To/AzHEZxsIQ
 HNz26sq17y2PzweN7Gq1ueZJfvZIPCqBjIIHVb2U2PBpjXlX3ffE6l9WxwdW72kFWUBF
 /E3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5kuJ+kezXv0mqUw8rcRBdd9j8JZV39bgRFSjdVQ18QhCzD218OqWWr0vhqel3MxaIh1MeNvFq1xgtuJmta96V2ccDVzI=
X-Gm-Message-State: AOJu0YzsQddrAF+gUNY6K7EA18m0Lbn5dmpnjvm3Pr0HJY64a0D8SloP
 rwxHF81GYI1QMCZrbH0woEAWI7CHoJTl6LgnBZ6Tq4Liyvfcytx6WDkIReSO34hUZZlKVtS7SDt
 c
X-Google-Smtp-Source: AGHT+IEHnPE2SrUcPo/sq7IXjhfFJcOqS8xtQaLM7+SIHPK+qQyLvKjF3b/yBXLkUQFPHCC0m7T+Vw==
X-Received: by 2002:a17:903:2302:b0:1f6:f0ff:47a7 with SMTP id
 d9443c01a7336-1f8629ff1eemr134184835ad.63.1718561090756; 
 Sun, 16 Jun 2024 11:04:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e6e235sm66385985ad.68.2024.06.16.11.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 11:04:50 -0700 (PDT)
Message-ID: <241916ce-3ad9-439e-bfcc-85f999836d3a@linaro.org>
Date: Sun, 16 Jun 2024 11:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] virtio-grants-v8-tag
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Cc: peter.maydell@linaro.org, Edgar.Iglesias@amd.com
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/12/24 14:29, Stefano Stabellini wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'virtio-grants-v8-tag' into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/sstabellini/qemu.git  
> 
> for you to fetch changes up to 6d87a2a311fe4a8363143e6914d000697ea0cd83:
> 
>    hw/arm: xen: Enable use of grant mappings (2024-06-09 20:16:14 +0200)
> 
> ----------------------------------------------------------------
> Edgar E. Iglesias (5):
>        xen: mapcache: Make MCACHE_BUCKET_SHIFT runtime configurable
>        xen: mapcache: Unmap first entries in buckets
>        xen: mapcache: Pass the ram_addr offset to xen_map_cache()
>        xen: mapcache: Add support for grant mappings
>        hw/arm: xen: Enable use of grant mappings

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


