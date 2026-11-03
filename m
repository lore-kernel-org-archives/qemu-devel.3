Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R+pF4Y3j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOIe1-00060N-C0; Tue, 03 Nov 2026 12:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIdz-000604-DJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:49:59 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOIdx-0008KJ-TA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 12:49:59 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b306bbff8eso3075407b3.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 09:49:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728196; cv=none;
 d=google.com; s=arc-20260327;
 b=CJwbtCxGN4E3zOpE+swMRTeyikv2zcwXdjYee/bV1jz9atLO9B+zovMkxGKG9RyLoQ
 +HRAgUvVT85ybyOMQUioHRKbd7UECjDXa7NnI9q5JzYkea9jvFelvdowHqAxQYz1iXhj
 qJKqwrNP0bOX5KWKZiELcj9PteBV78hJtsN5zkEVRnL5/0MEziJT4QUCuRAu1tbfKrfx
 PXC+RKxH/751rmfJT6TXg9CKU4c4CH8BxgOzC5imhWZIDvQOVPM78l60rBQKhIxbhO9I
 qWYMimYTRW1p5Fe+/LysN5+5lRKhKzXhVrXL0vm61kT2mGSxAtz6XjHY5zYaYEEOrUz0
 mqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=KHD63WxroFQlHpiGxelkPA8Wve5eDaujYnpu/A8vIO0=;
 fh=dc3ThaQxlIsQIYjAKVWECeraAhMQTsLDtJFd7t+aIGI=;
 b=egmQw2PJk8RMWku7RMUhkTFOOlc+y2VCyh4G40ZGRZ5FE86bwBGlikK665nnCavt/N
 ER/1EIghQk9SgfjIYKpUpErZMUf4zRJFb1w1CDnZw4IkkMlt3PzRlW4cYjO02qyDuylq
 su0rrXK/J9pjQjJZMKOPweLMwL13+aZ8MEIgwH1iUYhdrund/O/H2S8UHh3vpGnMfklJ
 xAcjsn17vQdMReHbaGZZDi8gtYq6piUIDpa8jFiWoaeef3zr0k48dhNH1QXtCjrV3ddW
 bdMwqa6gW8Q33HyH+5eA2EopeLjZj+l/Ehp4XLg7Vdt4616Z8oe40CNuweScztja2NPa
 HMag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793728196; x=1794332996; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KHD63WxroFQlHpiGxelkPA8Wve5eDaujYnpu/A8vIO0=;
 b=R+pF4Y3jIAhiRBvXK3gKbb4f/6eXko7Y4NlMSfj1bHqo5p7H6M6EvyPDismjC95X89
 c198cI3zZl2eTylLA+4KA1XfZKs1nXSUA8E84nbDm9Wot5P3HmD8sbUorv+mCKiJKuxA
 BJ1OIqjAM6P34wkeR8P4sMvO2xjTYAzU+eg/Qkv2DII/5jgXO8RgPVvQjRgwCL9ipzGc
 N5enBYXofp1C3WdU44DmjHZvW3wZEw2riagZtcdGGRhvlcOeABGSnEmClkNaLTyTbrfc
 2C0CIui49sNQsDjd1XHusGbO5gy1+BcTRaa+WrVmFGNhcJUVwGGjbIVesbyrUs64o3Ta
 kqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793728196; x=1794332996;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KHD63WxroFQlHpiGxelkPA8Wve5eDaujYnpu/A8vIO0=;
 b=zdMb2iDxFGxYlPtRykNlLq33pTtvJe2D5uOnv/o9pGNQv/XpCy+VjwZtIrPDd5wcNx
 XhSMXzOTZXf7Al5jxfuv5/0YMWg3YwsgTgxBdSXBZN2JJGaidf7tWfnvLLrlEebUIY4f
 z6+HL3IXfw0lUg3S/mzTzNtnnoi8H8oDZWUu/i/8/F8YgZAoCXxL//bC2Bim1udInScy
 hcN9V2MeVIeU7rD0W2GlfbBOQx3EbTgxzWPYAbF4RJSbHoqgU1JMS2BRoTN2ERm7yXvb
 DxC6tRfBsWTTHjj+4HpAIei5C+Pluvx3it3PKzlKZNlxebv3OxhgCaovcixVsAu5VySq
 l85w==
X-Forwarded-Encrypted: i=1;
 AKwUvBztL1glAWwZ7DtvouwwKsjsD2HfAcGeMiLJTPxGZAriMz7VNUtsvqnK/SkqgBAGvl1r28x+NNoG3F61@nongnu.org
X-Gm-Message-State: APuU4Z8rfJou2EDOkZBvP/jKpweWebRN8P+20+W5FpXfPQagNcC9plNf
 ulAbFS9GAOZGnlZ7s3S8CT/kNlqfF04pSAD0ms/gpTbvqRhkyuC9+AqwCKwGWs3OCpZ+uJ52++3
 xfc4FAU/Ow92SkjZHZoJsr5vvdlVLTeHTtbiNFnSVxy5VQyCUiuaIMaQ=
X-Gm-Gg: AYBFou1OAJQoOvHpJjsA1nkgHlW4854na7F/oOw4jvdVKv6pGWrskdUIt2DRqFmxvy7
 3MiQAzO9SnarM6A0WwDLqkhel6r9NRNramrI/Pha6/1qxBjP7SyCQYzA0sUsdIdqAoSwy02/tJu
 eh6NSfLQT3Z7uTbQAYvEOR1cYaBsmjvwPnJ3h+QL/0BbaKKYd9eLxDXN1ihV2LupEsuuTIAcSum
 TKSqLlFUu7BaO8kP/csHQ/FwZiOtQrbiPwg4UfFkjRA7EFmPXv64d5qqKtWP6Q+cMwhdpRc0w2J
 TIMuEqLj0bRGDNL84p+MfTkV5HrQ9IZEhRInoJrdKehzldhwA3Xt4ANy/hlVY796GzTjcq4LeZx
 noh0IdQJmU/F/F2DupzaGH+TSxbNWy9jvH8rFlAcCQwN1+NeThAaGj4cs7g+GLoDFTGtzpsUdbo
 MVQ+jsuhzLKKzm4bRiqlNy
X-Received: by 2002:a05:690c:9510:b0:8ae:9448:14e6 with SMTP id
 00721157ae682-8b2b67738eemr72264867b3.54.1793728196272; Tue, 03 Nov 2026
 09:49:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-5-peter.maydell@linaro.org>
In-Reply-To: <20261103172616.2400758-5-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 17:49:44 +0000
X-Gm-Features: AclHuK9r9ZwgyO4vbg3YGCrPW4tA0H-36SOAC0OnSf9gUzh8V9hvKFyjwfOtaSU
Message-ID: <CAFEAcA8X1ARhpncsz=kE2JxFjALGej4ycw3hus=m5kfcVSJXYw@mail.gmail.com>
Subject: Re: [PATCH for-11.2 4/4] hw/intc/arm_gicv5: Use correct type for
 value in lpi_cache_get_hppi()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
> to iterate over the LPI cache hashtable.  This hash table has keys
> which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
> value, allocated as "hashvalue = g_new(uint32_t, 1)".
>
> The function is passed the key and value as type 'gpointer' and has
> to cast them to the real types itself, but it incorrectly casts the
> value pointer to a uint64_t*.  This works on little-endian hosts
> (since we only read specific fields of the L2 ISTE using bitmasking),
> but won't work on big-endian, and trips the clang sanitizer.
>
> Fix the pointer type.
>
> Cc: qemu-stable@nongnu.org
> Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index fd6456cd8aa..a362349e5ed 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
>  static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
>  {
>      uint64_t id = GPOINTER_TO_INT(key);
> -    uint64_t l2_iste = *(uint64_t *)value;
> +    uint64_t l2_iste = *(uint32_t *)value;
>      uint32_t prio, iaffid;
>      GetHPPIUserData *ud = user_data;

Looking at this again we could also make the local variable
be uint32_t; but getting the type wrong on that doesn't matter.

-- PMM

