Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CA7C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NS5-0003yC-SQ; Wed, 23 Sep 2026 09:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9NS3-0003xe-Es
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:55:59 -0400
Received: from mail-ed2-x2a.google.com ([2a00:1450:4864:33::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9NS1-00042o-Hm
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:55:59 -0400
Received: by mail-ed2-x2a.google.com with SMTP id
 4fb4d7f45d1cf-6aa06e51bc3so1620764a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790171756; x=1790776556; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SmR2qGvRihWVxsjXteMYKX6NNklEeQW2uHolhy/6T1U=;
 b=MGCzZEE/k5f9B680QltN36k8cMej1SfPoNX3Z178q51W2BgRPtBkVkXiV/SqTY1kNs
 6VEz2Txm/RL5it7CXP5n+at8nuNeM+AoY1FAY5WaTWMhV6fuCydTQv4iyybngGHXn8gU
 g5I+gd/qqW2acCyO0l6CZqJJ7IoTo8DpKnNi97AYwFQ7itKwnF7LhoHzGxXWULOOwcH9
 93k0aWU+OJDIOA71YxmeUYgMtPHV31Xkr0SoW9+sa88qoTm2tU0TOiqQf7H5/EvQC/xn
 juAQ5pY+uWNkurk6rTlrMwg5A2B0HJCeeQ1SMiF8oaBKfzHakwJ+bKhb1LYSh83D2ODR
 sWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790171756; x=1790776556;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SmR2qGvRihWVxsjXteMYKX6NNklEeQW2uHolhy/6T1U=;
 b=0MnMR+3TrmNP7DR3CDAzlGpT7LUm8WNWQbQ+HOoRi42PWHhNvSjliaF5WJZMCYklsW
 IEEGoSesKPnBrAyvUxl+1jTj2lLkRTAVNpkWN+d2y6Vii24DhJOIQM0ejsztoWf44mwC
 Ko/MwLgKSDVAgjSgLr7xColCvmgHIBiouMU0jUpFyY8TbjoDK3nPHvuYl4CPBuLGZ0CJ
 lifNhdCgR4QzUAmVlTpoZGNlmjGTXgOE1rCvCfc8AZ4wKEo43cSDHupcTR/JS5EIaQKG
 38HJHMpw9wmxllky0+I5S3qjRAIfxO2AGU930TsRJKGPmY3kIMqNTtkV2av8A3IvHlLe
 xI8w==
X-Gm-Message-State: AFuF++kfPSGmGEH/DGBHgSbt4CM+qmxIoFBxIxhiEbEzuuPeMTD7D7+s
 xcWOBkbVJ30W5ZGlt9HTMuzrc1o+h5gKL1Efcka0ynt+QYzknxomm0lTCj9LebueCQRdYn2GKsk
 +vajvHP0=
X-Gm-Gg: AYBFou1+BFHdpm2VciIrE0dY7YvTHo1z/Z5lmpQxnDNQC1ws2cAGnFQNSIKzQJySMpH
 3PhkS9yRCyWpQAbwI9vvF6KmXfB0Kc2Ckvdsi4WpMThcHQAmaRdLfCAYrHjMkIOiDH48AEhmL10
 Opz7/eLrN9+akOHIPe8iD9EXWFA+ES1/4EYMOt6IVKar6t7LwxS04RL4d2F+vhffmA8h1YsofEA
 pkLdomQKw1CDuJjZOURajqfiop+G3twtSd0LWotPSOiU9jDcmCU9lZ3s5K7IvGD1KinefoWgQy0
 fADG1kcEui0Dm5i5VlY1gSQFM9gu5wXMRr2csr2yllbuUoZFEQdCqiM1ems1wKceMl2nZ7J7viW
 2pWoZo7Y6XNfbbIIcAlkJZn4eu4grfYn4sdnIgwdEVSlUMj+QLZyfnTmgih0E6xld3zXr0FQISR
 2hXo0FyMEleJPH9luqV9qflpigKAAXSjLDq7I/aiZgoNRLoJjqI4YugOnGAtW7L98ab7TnY4mxS
 Q==
X-Received: by 2002:a17:906:4784:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c2aadf958c1mr227177466b.38.1790171755625; 
 Wed, 23 Sep 2026 06:55:55 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae614b3dsm128614166b.29.2026.09.23.06.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:55:54 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:55:52 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/4] RME-DA preparatory work
Message-ID: <arPaaPh6pdvPs9Of@linaro.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:33::2a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, Sep 04, 2026 at 05:05:00PM +0100, Jim MacArthur wrote:
> This is a subset of patches from Gustavo Romero's SMMU DA branch work,
> featuring patches from Pierrick Bouvier and Viresh Kumar. These add
> capabilities to the PCIe root port and ICH9 SATA driver, and also refactor
> some code in hw/pci/msi.c for future use.
> 
> The goal here is to upstream work which is independent of Tao Tang's SMMU-V3
> patches, while those are being reviewed. If/when Tao Tang's patches are
> accepted, we can proceed with the remainder of the SMMU DA work.
> 
> I have spent some time understanding these patches and believe them to be
> sensible, but some parts of them may be outside my understanding. In 
> particular, we may be incorrectly advertising features here which are not
> actually implemented; although this doesn't cause any problems I can see
> with Linux or our test suites, I can quite easily set the feature flags to
> zero and keep the code structure if that's a problem.
> 
> Jim
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
> Changes in v2:
> - Removed RFC tag, rebased to current master. No other changes.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org
> 

Thanks to Michael and Phillipe for reviewing this - it clearly needs more documentation on it; I'll have a new version up with better explanations shortly.

Jim

