Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C9EC5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQkm-0001AW-1n; Fri, 21 Aug 2026 11:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQkk-0001AA-O5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:01:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQki-0007rG-Nc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:01:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso380593f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787324511; x=1787929311; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wcgTPIPEEcyDjQzsJSz/BrGPi75SyypM30Btlcy9NRE=;
 b=ktRPWtMYLow7LcqV14NfHQ7KJFT1IgC/oOkCivOBd6B2s3k/ilkRToH1A47FneeNP5
 lzQHJJ18IJM/3Sodd6UeaHqNr2w0FrWNjjvmBuzJBv3hkNiEFF/tl07d2W4vX/by4HxA
 +BP6V7UwbHt74ONwGlRy1NcvEXWRjXuAyAP9/SjzP4iugtH0B+k9Mrlw5KIwIXJ2GuBa
 55M70LqUTT7nZQSoLpmfSvRgU0KMJeGLLPLYpgHeZXq77SuBenIrkEaRRwkZeUpPRHEE
 bgUrBAi9MdoHBMcuZ6VQ10qyw3yu6DmBq0cQZ2kWUmmXOr4BE/R8HjKQHwE56RRXCz9E
 ApFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787324511; x=1787929311;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wcgTPIPEEcyDjQzsJSz/BrGPi75SyypM30Btlcy9NRE=;
 b=EK0Yfx6ED2Gm8zSFigVWAov6q6vYzUTGz5JxoZdIFys4+/gVLFYu2ZcsK9D9VYnF2w
 JqSBBhPPPpO0cX/cXjknjOM6PEsj3e7RElm3cS389JpC3w+bJQBfB4Y/ah6SJw1ftlt6
 HgD0FkTPZYq5KYhUDbsgHKCoMUUTJSitfQkjYlzYbWWxfHLbmwaCynqg3kizX4YSFxMW
 Pw/UEjqWlEhJKFYKR2titRsqYBtn2UfVb24drwgmGMErJFBtPhhFidLG4Q2g8xY2CM4Q
 0tKiU2yvM3VoqMZUT2KKOYrG5bEM6g1GLIWP+3fkmViyFPvdcAMmOWzpEu5EtBE+eoMQ
 IoLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoembPXY+gVd+Zye22pCa7K4g3vzGRyQS47pGTumh8K/QteK3GZEzXO6SLB3J5R1SwGSmScpX3yDGas@nongnu.org
X-Gm-Message-State: AOJu0YzvE3Vw1ySMqBqzMrc558b3gha5GmtROWXuFfzwJO3ZT4r/+5NM
 21cPC4KZC6RejG40sxS7EcXmN8g/GsSgHa5MDNnspuueYE4LSAq/cu7JpiIj2TXtxCc=
X-Gm-Gg: AR+sD10H1PUI3rSqTCSzFJ+yMx9ivRqi8o4PUcJkLdyiojQv73LGBmABiY99pbp/J8l
 nlUmScoOOZsRg9ebRlM7LeT1VMdH9CC1FT5j2/e6K/SmG5wCT5QkZz1ep9E5FNosk9lX/acan3X
 wptiZUeQ8RBkea5Denka03vqd/wNDPS91yc8izbic1eJCL/VWlF21VEhG6GCqNvsoji1fq3Nwx/
 i/DWPioq09fjWcH4+c8/O9DISAEV+1nOEGgKELECd9rOZ4QJHvBZkgDxO/O4SRbDnGvR/9ibX8N
 qqY7E84xy83Y8muxLlenkska9aay8PYwKbzdJ3tsNtxJPd2C7vhmR0iAPir8fQQ6o6h8+6ReJcn
 8fjv1V3JS6aGDWidB7WCszAuvCGXP26a+F59tOc9gVvIagTwR5evsODk+msW4aCm06PQYAP72BU
 z5qwGxLcUzmrQy5t1xZ8KFPVEWf9cOUpv9UGPt/yafmADsd6f2wQZCCHNuMfAXBAY=
X-Received: by 2002:a05:600c:4e56:b0:495:4859:8f9b with SMTP id
 5b1f17b1804b1-499b8454b9cmr119150295e9.9.1787324510823; 
 Fri, 21 Aug 2026 08:01:50 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9049f84sm30884575e9.0.2026.08.21.08.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:01:50 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:01:48 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 08/28] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Message-ID: <aohoXPhB3gEsNSA2@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x436.google.com
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

On Fri, Aug 14, 2026 at 12:24:44AM +0800, Tao Tang wrote:
> Adapt the configuration cache to distinguish entries decoded through
> different SEC_SID-selected programming interfaces by introducing a
> composite SMMUConfigKey. The key combines SMMUDevice with SEC_SID,
> preventing Secure and Non-secure configuration entries from aliasing in
> the cache and leaving the key extensible for a future Realm SEC_SID
> namespace.
> 
> The cache lookup, insertion, and invalidation mechanisms are updated to
> use this new keying infrastructure.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
> ---
>  hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
>  hw/arm/smmuv3.c              | 12 ++++++----
>  include/hw/arm/smmu-common.h |  7 ++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>



