Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0170FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 15:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2X3w-0004Sf-Ma; Sat, 27 Sep 2025 11:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X3u-0004Pv-E8
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:14 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X3n-0000y3-Pn
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso2955552b3a.2
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758987721; x=1759592521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRO/Jzr1sYq5Fql/U20uzPF7X9GH/4z1ecA824ypnqU=;
 b=MZmwkGutOd+WPZuFZa/zwFVtb9Mq32/mXD2f0GtcIj1ZnIOAKUfxhT5xEO/lGL+tXW
 ifDRWLBqavfH0Szi2mz6+YTkp0UhQvs7eHWx5WecsoiW+OFBjrkJzxv1QvjsQPvw0eEn
 Pw5zoL+oHaBpDwCYqhRX0t8Kt6M70j0o6zMji8yJJpNR80ynnyQTLokpE3CaTfFXpotV
 PpssW4vXNxhbZS7BAyalawxhqejrB9U5CzmbWJbvDoA+l9w/DETTNcqrzst+ic6o2UMT
 PLCSmoI1qts89O26bUaRma97s0rfF1pr01U8nwcualJ8vqpU1UuVrqA1zkCz0nuUC6ut
 BUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758987721; x=1759592521;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRO/Jzr1sYq5Fql/U20uzPF7X9GH/4z1ecA824ypnqU=;
 b=bjdb1Y9b5UzyV9t6uvb+cK/EKUwF9Wtk7J6UqoDvDQ6iztdX87aXwRJi6cW6/HRZZp
 Cu5iMPqfhEPFw2KKvk0U2Z5MMTVjDVM6j3IlT7qFIz7YW+Dzpv2lPyn7XeZhIckoAb7C
 4s7VFfvMvLK377hjmKQGOEUR1ctzUTDmaYOx3ELHJtOLXIeJmdyKwmckWcImlkQf2mzr
 UCZKCjO7hI+o04vQMp+JQgPdx4c988BcMKMpoH6/yPNoUALoULA5WL+BdPduLT1s2Czq
 v3ZJZ0qgqn3PjDKA3aj4Lw6h661imLNPzcsFN3xMKFojPvjnd4S1BtPuvJzIUOfsSn98
 piSQ==
X-Gm-Message-State: AOJu0YwbF7qcdWp337zEnU7g6bz0d7B4t0ocaw3Gh2HAzJzxmiDXGOLH
 EQTyIslvt6OWZM1dehRPPTrGcSeMd1HMBBNb2nytwsiRrKTKerujh0FUwVBHbZCOWrFLBf36aWf
 jz1D4yjuCvA==
X-Gm-Gg: ASbGncvcTMTCuuIE4IScbYFNyMmvqbUa2zjeaZyMo7FB8Ommmvchmc6tvTzsnySS2yw
 eZYh6Ug9WpNF8JhWQc6ZpQ4DE4cojoEoR/fuYu+owtO4/GngkDmDZ+jb52E+qRv2fZod1RLm36g
 xWhmgrQG31KMx3huS0Uqtppa9Hix2kRAY7NF1Iy3N+wbwyXK6Pe7miToGb7+rbTlqr1yWzF16VK
 dXK0103GLmsj6XNZc2SOquOXYLsjG0uLv69NIueQdExrErC3j25fkDTU9qh/SaS+MUQB1UNCur/
 6XjyCPvS3L3/2DeH148IcVor1W2/e46tN85BMgsc3vRMxnSyXChIS/W/pj4b0f8IrPFr96OHIrW
 sCpM076gHdU5icgdGBevWoH+VNvmxWLMnhFEciBWyPQ0u/Po=
X-Google-Smtp-Source: AGHT+IE8fBkLx5+kaEDniM+ZgLxneP+UFvchoXsPMPb5qbKrLY81Yo5XSdoCs4TkgGJYunst9yqrLw==
X-Received: by 2002:a05:6a20:918e:b0:262:c083:bb38 with SMTP id
 adf61e73a8af0-2e7a438eda1mr15119936637.0.1758987720648; 
 Sat, 27 Sep 2025 08:42:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53cac77sm7399726a12.17.2025.09.27.08.42.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 08:42:00 -0700 (PDT)
Message-ID: <1746b423-7daf-4c05-b173-45c88ce2048d@linaro.org>
Date: Sat, 27 Sep 2025 08:41:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] vfio queue
To: qemu-devel@nongnu.org
References: <20250926053358.308198-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/25/25 22:33, Cédric Le Goater wrote:
> The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20250926
> 
> for you to fetch changes up to 7c773b4267ae10820ed5e3ec6b15219b39dbcebd:
> 
>    include/hw/vfio/vfio-device.h: fix include header guard name (2025-09-25 17:55:20 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * New vfio-user functional test
> * Improved naming conventions

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

