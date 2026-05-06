Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF07CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbKf-0004j8-9C; Wed, 06 May 2026 08:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKbKd-0004iE-NQ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:26:27 -0400
Received: from us-smtp-delivery-204.mimecast.com ([170.10.133.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKbKa-0001VK-BN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 08:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FxujDGbQKrxW7GMucibWTIntiho6D4F9de53YPYi364=;
 b=eWUvFT8ocii0mmo+XlgLzPYshT6MiBrQ0Zp0ZUZu7zS9oKO7tr1ZNPg/YwL06kheh+xiTd
 uB/an2pIT8IlvDKOMwBk2u8izs/5/np7OJ8qiug8jM5BbceLzMV7REVkL4NPXDqAoC/GPf
 Cb3N0KkDIuQa9BLGdfWtPnyS9lF+WhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Kc9AMXYhPRKJ9k-t5Pb0Yg-1; Wed, 06 May 2026 08:26:21 -0400
X-MC-Unique: Kc9AMXYhPRKJ9k-t5Pb0Yg-1
X-Mimecast-MFC-AGG-ID: Kc9AMXYhPRKJ9k-t5Pb0Yg_1778070379
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d121738feso22304985e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778070379; x=1778675179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FxujDGbQKrxW7GMucibWTIntiho6D4F9de53YPYi364=;
 b=KE+JHEeePQ9y6Vk/ne9t+BwJVSZSz+rVwFOQYg6NJtkFttW7hBlxuiAvmtorQIiID2
 IO66glBN8uU1nqM1ZTMnbQsmTqlxa9rRYR6eeQPjL6eulVNsUEXtgN7lDPiZEYcQ/PLx
 TycGRvj9gjNbgxN3/uAuGtECNvB4ZdHqU9py/99BT/77NzTfHqvyqnuDzLqc6OescUjE
 5eOu7oMTwC7HyHfJZyLQynbhD9YyQeItIX5x06xq1u5ExkwC2n73ok95sZUiLn/mehKQ
 CG399gKOHtrnqW0RlW7DJpQut1nC1jtwQviFhMrdwohCfQlgXqO2rYG34Caq+wuW4484
 ceyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778070379; x=1778675179;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxujDGbQKrxW7GMucibWTIntiho6D4F9de53YPYi364=;
 b=Qy26MA46Rb1QvY0JcTkcjGr5ysuiOI9VbJxyhOY0SK8nddrytKYKwwMN5pCm8H18fp
 UB6zzUhzLuOpGhNS9u82oOoKrsAD0AuxA6HsPqlVTT7NOvssPLF5Pampcl4gB1slpcL5
 euBsfNhqDzfUTUfwxuHLDVd3Zgb0EEpJ40odkSKrgEKI5c/CzNTvA7DBV+VQ8r76GqRl
 7zYyqzzhGDcCHm0ky3Elx8peignWg2nQmUpkR/uOW+tiUyJNKsy5Xnd9PSfPhCFOY35w
 jLDkcOtLwQ/nRi1qcQ/RrnTVlh/9qhSrRYSJ7S3SBqWnRCxsfqDypyckNXh2WA7OfYDc
 a5yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ThGu4FBCleo8X5BbfuAxtKaaoRoPGKrSdvRmqYdNEOPlLfxBUBEHQ+b4yw05+TKE8d8mMUNIY0iKr@nongnu.org
X-Gm-Message-State: AOJu0YwRrrrE72w1fcFICPC5OLFL7FSa1FMbXKqrvSQ0714wNWj421vD
 ZemG8jkU2B60jT5ETsX1aUz+QlnicOwUKJW4jySJHZaTOY7kjLiA/8772SsNDBsHDqUCpIyCsyI
 mZLA1K0g8WBeygG/Jez5kb4UeDR2fXVowPi3HA9+N/50nZLPx+zLn2YDH
X-Gm-Gg: AeBDievY1z56XzKabRFQsw9Q8JiqVSIrqOKdh9uD/r4VzOqYgjo/3zib+M7wYPDgBkD
 CyGZH3LpPeru+6+Z0LSwN64cOjzGeXVoK+gtR7uH3oNaU5m2FN4zGY2f4vXnm39HbZhxU+Vyfnf
 IyIoB4Fu1nJJg5eohp0sD0JEnmATuRnQx4MmS4TWIXig06gGuLosy/Njj2yZgmhuS1Vt7gmCpfW
 fI5NRetTZd33V5ruSyJHJWITcFswosBaTAGtwFYu0OBugUit0p9T1dAKUtE7MU0jCNSY5K2snhU
 Ex1+pfyIdgiLuhKMENl2UngCI/QaeDYJF8ZRcX6Bpgqnrrb/ZhP1l78h5cX+WB6hD6gh72bUpsJ
 akMw150eJvFPdYeBvi+B1JOWjmsKn3h57W6xhDgqqDG2aDOcM1hjQVguPsXhymMccevThKBY=
X-Received: by 2002:a05:600c:4f92:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48e51e09711mr58660375e9.6.1778070378916; 
 Wed, 06 May 2026 05:26:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4f92:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48e51e09711mr58659665e9.6.1778070378442; 
 Wed, 06 May 2026 05:26:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e6e0sm12162208f8f.6.2026.05.06.05.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 05:26:17 -0700 (PDT)
Message-ID: <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
Date: Wed, 6 May 2026 14:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>,
 Caleb Schlossin <calebs@linux.ibm.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.204; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-204.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 5/6/26 14:01, Markus Armbruster wrote:
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
> 
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:
> 
>      $ awk '/^M: / { m++ } /^S: / { s=$2 } /^$/ && s { if (!m && s != "Orphan") print t; m=0; s=""; getline; t=FILENAME ":" FNR ": " $0; next }' MAINTAINERS
>      MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>      MAINTAINERS:1792: SH4 Machines
>      MAINTAINERS:2022: Machine core
>      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>      MAINTAINERS:2555: vhost-user-scmi
>      MAINTAINERS:2862: XIVE
>      MAINTAINERS:2872: Renesas peripherals
>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>      MAINTAINERS:3719: Checkpatch
>      MAINTAINERS:3746: RDMA Migration
>      MAINTAINERS:3894: Record/replay
>      MAINTAINERS:4029: OpenSBI Firmware
>      MAINTAINERS:4153: SPARC TCG target
>      MAINTAINERS:4233: CURL
>      MAINTAINERS:4238: GLUSTER
> 
> Some of these have R:
> 
>      MAINTAINERS:1792: SH4 Machines
>      R: Yoshinori Sato <yoshinori.sato@nifty.com>
>      S: Odd Fixes
> 
>      MAINTAINERS:2022: Machine core
>      R: Philippe Mathieu-Daudé <philmd@linaro.org>
>      R: Zhao Liu <zhao1.liu@intel.com>
>      S: Supported
> 
>      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>      R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>      S: Maintained
> 
>      MAINTAINERS:2555: vhost-user-scmi
>      R: Milan Zamazal <mzamazal@redhat.com>
>      S: Supported
> 
>      MAINTAINERS:2862: XIVE
>      R: Gautam Menghani <gautam@linux.ibm.com>
>      R: Glenn Miles <milesg@linux.ibm.com>
>      L: qemu-ppc@nongnu.org
>      S: Odd Fixes


Harsh, Glenn, Caleb, Gautam,

Could you please propose a maintainer for XIVE ? I can still act
as backup as a last resort but I'd rather not.

> 
>      MAINTAINERS:2872: Renesas peripherals
>      R: Yoshinori Sato <yoshinori.sato@nifty.com>
>      S: Odd Fixes
> 
>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>      R: Peter Xu <peterx@redhat.com>
>      R: Fabiano Rosas <farosas@suse.de>
>      R: Mark Kanda <mark.kanda@oracle.com>
>      R: Ben Chaney <bchaney@akamai.com>
>      S: Supported


Since Steve has retired, I believe Mark has taken over and should
be promoted Maintainer. Correct ?

Thanks,

C.

> 
>      MAINTAINERS:3746: RDMA Migration
>      R: Li Zhijian <lizhijian@fujitsu.com>
>      R: Peter Xu <peterx@redhat.com>
>      S: Odd Fixes
> 
>      MAINTAINERS:3894: Record/replay
>      R: Paolo Bonzini <pbonzini@redhat.com>
>      R: Alex Bennée <alex.bennee@linaro.org>
>      S: Odd Fixes
> 
> Only R: feels tolerable with S: Odd Fixes.  However, S: Supported and
> S: Maintained are clearly wrong.  Unless somebody steps up to serve as
> M:, we should downgrade to S: Odd Fixes.  Volunteers?
> 
> These have at least L:
> 
>      MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>      L: qemu-riscv@nongnu.org
>      S: Supported
> 
>      MAINTAINERS:4029: OpenSBI Firmware
>      L: qemu-riscv@nongnu.org
>      S: Supported
> 
>      MAINTAINERS:4233: CURL
>      L: qemu-block@nongnu.org
>      S: Odd Fixes
> 
>      MAINTAINERS:4238: GLUSTER
>      L: qemu-block@nongnu.org
>      L: integration@gluster.org
>      S: Odd Fixes
> 
> Likewise.  Volunteers?
> 
> These have neither:
> 
>      MAINTAINERS:3719: Checkpatch
>      S: Odd Fixes
> 
>      MAINTAINERS:4153: SPARC TCG target
>      S: Odd Fixes
> 
> Unless somebody steps up to server as M: or at least R:, we should
> downgrade to S: Orphan.  Volunteers?
> 


