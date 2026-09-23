Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B9C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KNT-0000e1-Me; Wed, 23 Sep 2026 06:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9KNR-0000dc-9H
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:39:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9KNP-00086z-Is
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:39:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1505396a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790159938; x=1790764738; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rgk7+V3j4anuXaBEpk6h2W+cHmZP3BLwzml0Lhr2cWQ=;
 b=Mbzs3dyjLXRimVEL56rpXcxHWEM3v8hE5mLP07ViBhmywBxHCuPg1ApPerEvkg+sfY
 cxuWQrKBe6PRC9bAq2i9UPClhwXYeck8HwsuJA75SYt0zNLGU7ss4yW9NEoWgqCMTmf4
 BI9FicdWqiARp4vlR1arxw1+EUwylF9ruDcLF0WYY9Xef13Ee+GIX47RhIniCcLQv8Y/
 xe1nZ8QGNslYSMLDQ73htjW7UQHE25LfFC431Rfdwvu8XxOPV28hhn8HbVZFcNPt+Jzf
 GnL3GG0RYIY9rP9BSmwbu8A/rXAxVchTP3exVdRqiwSSEtHnZwprF7/NEZmKngXizDuD
 V9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159938; x=1790764738;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rgk7+V3j4anuXaBEpk6h2W+cHmZP3BLwzml0Lhr2cWQ=;
 b=mJ8zOAHqhXUM90q+vemW0FHUwWuGW0LRlHzjF9zEmZHsGFRkCdNnfY7SMMHk3UaxUB
 k0jn1m6IZ5ZlLO1ZIHXoRmu/ZMRX50bty1uZmEg3VXrfuUQjXYfC2N7T1YnrJrBL2Hso
 qBZvP+efIatLPHTlWe2SzC9oc1lGlD8LjwazorjPVO1FE81BhshTAgxHLzUXHODt2tgC
 KMZf/1gqoNAhXIxnJD4VulVSzujzE0M12/BPQmjirJvSiYSi5MHafeuk7RDEjJjeTXzb
 HTcyMQtVXYVd5o4sAqU4at2BLJpY2R8jYOYa8eNgmplIfyNL57xPOlYKycrSYAWPnfsi
 PqXg==
X-Gm-Message-State: AFuF++nn521yvdfuACrlQ1gu9/CdZQ8neqAlNZR7QPlITOGUn0DQC3dn
 Zqdkv5Ye/BeFDvvVSr2ffu5iK3yIvybP/0xDqyoulbVbhG4VBa2upbWIe5mDHFc0poSpZldnvrf
 MTb5Ua8o=
X-Gm-Gg: AYBFou2pspefE0RPabG51GHeCUyEYEV3roIcpYX26gWk+Hv4mheCJqZHdAOuo1k4UCd
 P8z8ZLhzyPssVbdxfl1hrImziwg/XkLgvLRYaJt2Mh4UMd13FE0KWssHPsHIXhgF63JzV2IyRe2
 Qn1qfwTGRofUuc8y3yvkHuX5NyzJL7zCWBHQRtWBUXjXTRsr7O8PNg4A0ljXrDNlpn5V+rAcWRa
 aX1GtQ7ErujCSX+0aO89V1BpX59uy5dH4JsclFm7daPP72Hjrcv9cKmXpeL08UJqYEMniuzG38a
 bdOvE9PJhrwubWmjBbti8L2GQ6LmOScXOrGOk7nu60A73MnyBCT5NZR8NDdMcViUsDYTYWLS764
 jmDf+K2guhz0s0ojUfx2/F5UivnQnYoB27uPuy1tYwMIomjv1Zr0DiviMlCUh/RtHqZB097DjUG
 skxjxGJKLuRlGcm/HC7Q7GASyRPX+bDbgQTCkfacBNbt33JV1YIHSInRxCnklxYyQEy99C+Tfgh
 MoiJph+iVE=
X-Received: by 2002:a05:6402:c2d2:b0:6a8:151b:4f8b with SMTP id
 4fb4d7f45d1cf-6aa9feca206mr3601842a12.9.1790159937847; 
 Wed, 23 Sep 2026 03:38:57 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab386e596sm1402745a12.7.2026.09.23.03.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:38:56 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:38:52 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH 1/2] tcg/optimize: Fix fold_multiply2 vs 1
Message-ID: <arOsPDpJxK_eRaZE@linaro.org>
References: <20260915014115.1809286-1-richard.henderson@linaro.org>
 <20260915014115.1809286-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915014115.1809286-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, Sep 14, 2026 at 03:41:14PM -1000, Richard Henderson wrote:
> For muls2, we returned from fold_multiply2 without finish_folding
> or any other mechanism to update value tracking for the rh output.
> We might as well do this via fold_shift, which will also mark rh
> as having all copies of the sign bit.
> 
> For the movi paths of multiply vs 0 or mulu2, we're better off tail
> calling to tcg_opt_gen_movi rather than explicitly returning true.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: c9349965ce4 ("tcg: Optimize INDEX_op_mul[us]2 for 0 and 1")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4448
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


