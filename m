Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C3C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 12:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxOTG-0003Xs-7N; Fri, 21 Aug 2026 08:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxOTC-0003XJ-Om
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 08:35:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxOTA-00057v-Qj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 08:35:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47de008b020so497619f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787315734; x=1787920534; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IbJh2QSZ66GmvEyNk343YZCOFdbHwmsXMFl+nOfZwNk=;
 b=HfluvWxgqeYbWrmhBwTLCHqR4uy5XOw6CXS82Osiqp9KgTHbJys+iJUlGWPuRIEi4R
 e9/2i02iTH/CQCDq90G49VtRLndorIzzMIouhuzUSaLx28mQLzcEWjCqg0fZk3HOZzI7
 Wg3tFpwsCKrwX6a0ezC73KYhj0h00jk3C8FOYj5hReyGYKGpHE+dcvGlUWn3DP6YOG+K
 XllvSn/Rw9M+qKQ8SdBT8DP2bXjlfWoH1PNnUNBLhNdhvhsvSqXKXisMtjQPemwg9MqJ
 6XCbU23A3APdJ0bsMeqqd0p0pp9ZY2HfFJnTOZyN+/5A845UtKNulvpR/wwXMbsYIYgv
 VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787315734; x=1787920534;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IbJh2QSZ66GmvEyNk343YZCOFdbHwmsXMFl+nOfZwNk=;
 b=BE0Z6DGSydivrtPGjJpMCbWbhpj4F26Wo0u/nF+OO2qx6WkyXPnxqXnrnA1WXoHaAK
 fO1hfR9hpyLKtQHj4L+wboDnTuoDfGRiwu5u+VYlTbIWTU6Ncwayi7+WYnQ259L/1nLw
 7npxcR1vB6eKXh5I/jgHcKg56iQNfVTbacZah4S5dJqWTOn6L/t11tQGll+RaKu1r1iU
 af6HjVnf6OVvVvbOpXnVGNeCOz4+tdAf6TBjCrPIUkfi7IpJittbctk4xxVnzkZTDQlk
 nHkV/koDtCoxMapTEHewSLgB3fHQGMWNcSiCvKKjAZYElbz4atL9QU5Qh/l5XP9EZgRq
 SHkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTpg16wUIf6IXScLnTQw3B3AmMe8qwT5M1PpbjOFArSuULkyIvzp5DVz0gxt/HeCgWTH655Pdjw0Zv@nongnu.org
X-Gm-Message-State: AFuF++nanQhqKPEhoU/frL6ukaxO3qBa4cd8HE94Xko1PidzMmGp8cQo
 /KBDnKvz6NJ7y41L4ZiFuBDAs0YRxGXvuSOD/p1XmCIvwX/7YgXnUyWllOZ99vWAufA=
X-Gm-Gg: AR+sD13gYcVTS4nYyHm377ucuiQWHYnYDMvLEy2V6/0FW2+KF6MGEnk5MrSYOp4KDSS
 DVSRf9Ulc1KFSXEjtdW95gkfgiluR1NIDCO7lwfQ85wWgqpcdxdiscom9e9WQnWE4htm7eKeiMD
 a3uzlLImPeDtc2RsCN25PkyMoslNR26+ITeVJQKsUFHuJ8E4e21hM5zaOUh2+v1CxZCBh8ajGlD
 51/8O4qQQmKx0NnlKCv5t1iRvSLLdXuYvdTTN1W6Bj0BDUjInwqbCvcmYWQxbrkQDEFr64lb9S2
 7uHTgcPD81eELyekbkibux4yEjoCxWws0UnTwYS/bEcKwkr3THhjb5WZurIxEh41vFAtbalotFk
 I6XK9VbuD9JtdmZu2U+2WwgK7z/9pvQqlKer6/BDMaUwTCKo66R+30TXu4zppwZM+LDSg++Nqp7
 QfNK2Wd88qM1bp4UJOpVfGt4nfNQAAAcvWfemtafaVjLqdH/9R6aKH9vStb/fqg2w=
X-Received: by 2002:a05:6000:250f:b0:47f:8cd3:4bed with SMTP id
 ffacd0b85a97d-482c104d89amr6864367f8f.5.1787315734335; 
 Fri, 21 Aug 2026 05:35:34 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm17559328f8f.24.2026.08.21.05.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 05:35:33 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:35:32 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 04/28] hw/arm/smmuv3: Track SEC_SID in configs and events
Message-ID: <aohGFNEatt53f0Bw@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162410.2805113-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, Aug 14, 2026 at 12:24:09AM +0800, Tao Tang wrote:
> Pass the SEC_SID explicitly to smmuv3_decode_config() so configuration
> decoding can be tied to the correct register bank.
> 
> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
> and event logs always show which security interface emitted the record.
> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
> identified as soon as an event record is built.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3-accel.c    |  2 +-
>  hw/arm/smmuv3-internal.h |  3 ++-
>  hw/arm/smmuv3.c          | 26 +++++++++++++++-----------
>  hw/arm/trace-events      |  2 +-
>  include/hw/arm/smmuv3.h  |  1 +
>  5 files changed, 20 insertions(+), 14 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


