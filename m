Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF2606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DV2Zluvq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUCTS-0004Af-8r; Thu, 19 Nov 2026 19:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUCTO-0004AP-Rk
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:27:27 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUCTM-0001hT-TP
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 19:27:26 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8a070781f63so210443b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795134443; x=1795739243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4BwO0Dy6CHsluWaF3KwJO0iUlERrBj1aOfvAvYnrX4A=;
 b=DV2ZluvqtAN/pJgBSXIQKF8mId3AL4xkqrGqK36El6IO60m1vheJfNqMvHzxatKcZJ
 T1Kf8t3T/jCNtMeAP5+ql476m/g3nkjLREy0mZGVn4hDsRmz3ZgrPL1+4ASQfGUrMrD4
 lLRn+71HfOpdeSCF8wedwe8KpEKuAq3gVf0s/StbZqVTpRd6u+8iziP8vk3G+o/AAw6+
 T3BKUFot/OMUJrQ9AKCTg73MNCP/sdulIaSSVmpMjAzUBkHA1nGWSDUImDtHa2Wxr/oD
 Y+04sTl8mTAFB9KtwL+5NdKwIlOxqOMKk/sAdN+QHIG1BUMB+JN+yKI+AFGzXc4ZESGN
 PEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795134443; x=1795739243;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4BwO0Dy6CHsluWaF3KwJO0iUlERrBj1aOfvAvYnrX4A=;
 b=Dhb++hH94xDM9rtN0Wn0RZdd9l373KoTvh8PLYZwzQivlE285qhB9JH1p27kO0X6Uy
 nHdPb45s0aEW7DwBsUZLEEb8XY5p4hpx1WH6tmSYWMQ/hSqaru6EVhwE6Ykx+j57vWSs
 xKgaKtuHZUfNGYLmIFaGf8HDR8usd9D9xCOjaJzc10127o6bTB0ugMNQHzoLTNP/cVFW
 wNBGSnhW25DtVy9ZhOD4o1KjnZnpAIB9c7j2IAVBlNsPQ9NroHqOB24LMSdRD8kIyBGM
 t9Rc7A8Tlx8UcVtHLms2TpBAmyCY47+2o2+f9IbCAjBKElRUiDD3+/P/76mwSd5X7yq8
 JjNg==
X-Forwarded-Encrypted: i=1;
 AL+hErHSMya/curZKA06k3k1Ax3MTZQm86n7xSJy6fepjPCgVMDx/CaJ3cpdgtMaHvX/PQWKaWeFtllKW/kq@nongnu.org
X-Gm-Message-State: APuU4Z/6KjyZD4ocOm9ypOPrWxnBug+uXBN6xXpSAbS+WrYRTMIyHxf8
 t82UjnyiQhw5tWAyaXAJu52z5jTT1nbHcWN5LJayXbJzklvlF8ljUPW5LbyyyLpX/xeXF0Ubz+q
 Ucjue
X-Gm-Gg: AYBFou2QDuOFlD4a/e0Xf3ykmkKQOxnuO7WlM74573y/xn4OOuART071oUaFsuUdIQa
 aJ8q0vsRMqw+WegdPXjYwNXGNpjmv7zSzs9Jyxv1uDRH1cwgeER5f8tKQKq/ki4IVjILPbdTSre
 vdTDy3s8kUCEND5dbQLLvQsviieXUX0QY4ISnUKrJ99CmqwgCQcd53LRDOMiVsgTeF//YVo/BRw
 e1flrEz5V6zdT8wzHTJKSWy6KOvAC6oP3vtr8zG/aTo2wnjzPQKWFdUzaHzAFsHSHVYQPpOABTG
 XW7TNE/S8XEEJhru6bxBuS4V4ZM5WKqqoPWbBm/7usBMwYNSWl+Wn0OGSPm285xuyNlr1hAyYmn
 /2cnk1Kv/AHdxdKJwRJx2XriGAeJD809qXqo5BVhFAjT3xjAgAJlkoU4BswleVYLrOkyYBCQb6w
 zcBr44adaxSeeWPcz7g+8kyrdXfyjyPUNzvMQEEBH0xLnOEBord2ykBRmdjx4r6J9cOTQNB0Ilz
 tAMZ35NFjVflbC0BB6NAL8h0s35vSwZFklxUt9zwEwY+Ti/eDQrIAiXRLgJdIm4RxaJZGCdZIoL
 k7zx4EUBDfI1xhUZ32GZI7M1P4HQoozYF11pSIsdHx997nsaOZbFDz4pU6wGdtOjFRa8/uc=
X-Received: by 2002:a05:6a00:1817:b0:8a0:5f63:5521 with SMTP id
 d2e1a72fcca58-8c8792bef60mr1213386b3a.8.1795134442912; 
 Thu, 19 Nov 2026 16:27:22 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873c1e2f3sm588614b3a.54.2026.11.19.16.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 16:27:22 -0800 (PST)
Message-ID: <5869b786-3b54-41b4-bd36-3b3132c907cd@linaro.org>
Date: Thu, 19 Nov 2026 16:27:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-11.2 0/3] NBD patches through 2026-11-19
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261119202330.3853797-5-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119202330.3853797-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 12:23, Eric Blake wrote:
> The following changes since commit 08c9bbb825148dec9669f5184ecf18823bb6d631:
> 
>    Update version for v11.2.0-rc1 release (2026-11-18 12:57:24 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-19
> 
> for you to fetch changes up to 470888ffb0220911a0ab58f9ffd41d95f36e4a22:
> 
>    nbd/client: Don't leak uninitialized memory on malicious server (2026-11-19 14:21:23 -0600)
> 
> ----------------------------------------------------------------
> NBD patches for 2026-11-19
> 
> - Eric Blake: CVE-2026-126657: heap leak on client to malicious NBD server

Applied, thanks.

r~

