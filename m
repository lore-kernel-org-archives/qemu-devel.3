Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAEFC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5IyF-0006rr-BS; Fri, 10 May 2024 01:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5IyD-0006lX-8l
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:39:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5Iy9-00026n-IW
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:38:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34dc8d3fbf1so1194045f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715319534; x=1715924334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYa1+LnwPeDa9D9Sib4Yz3C2KRqxkRaC0oHKekPt5Wk=;
 b=MZDHgFg20k9jBbdlywikz6h6f5ki59DteayoaHtlI6e+qL9VKECjDz1vMD0BbrnRu7
 U4LmWKi26NRL+3M/sctNYz1fNSgJ5ERaGE1I1skmtZbECGY+RNj0rkZQTLXQmgWFpUHu
 4bRbGQQ6YG2wneRLnQImXMVr+EfjbxdpVvirkIJ0U4ygILG7HEGjvT20LnMq9aQv/dci
 /7H4VRhNtLXiNjBfYJsNndy3sxvy8FU+790wAhNJAzLANY7efLSAdMMpgxPvg8166qNy
 Dci00IlVV9vFjdiS3j7yPfhINT/8uAmy0zaKBw7Z/0gzKScDgKNY/oeEnaKbSNtIs80Z
 PRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715319534; x=1715924334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYa1+LnwPeDa9D9Sib4Yz3C2KRqxkRaC0oHKekPt5Wk=;
 b=Y/g+P9faEimFHMlxWXRFPqZzvo9cQ/08nnR76xUvzZJHURHqwJmhANVo+PVRJSlJTL
 WvlX+baIx1lnmvUoIpZoyUWjaoqA1wOaShrT0yGerEbKSzrJLm9n8C5nWQkyB+n3Ox/Q
 fYS9ht3MyvunI4Iy7JAu05wppOEeKXXv3lfZXWp8y8oyZvzdjjxwl39amDQEA+Y0lcqe
 raP0CeHmOctlLJ/Inu0JBM4H+OxdSZPAYe+gTV9/m01AVgTU3vW1NxBFut/8NM8M+ssg
 XR4RBtNaNARQsf0LP0mRfWDUcJMC66DNTjn212sd8I++pHyx0ugD4O6aEEIuFUkZNXnv
 DgHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqtPV9NjlhzXxQoUGy99l4Lbin/wO4UyscrZqB7uGWtf7hCwueUX7VkJFTmVESx3uMDNhrDO/JyO/Fb25Me26YRc+iGyo=
X-Gm-Message-State: AOJu0YzEfflcrO6dKzvFvUNjaePG6WHvhs5PFv6xBB1DaCqPXLUkt991
 Rsca9bKQ4cgp8UbU201K21TBRIJW9Nk67uzGim6kEc/GekQrB165j/Njlui0j/A=
X-Google-Smtp-Source: AGHT+IHdBAMhRpxweUmg4yAjr7RJmCixGDeto/ZEX0/kwY9pDXWhzv5klqqj7YTOqGr0pHrsvVAsng==
X-Received: by 2002:adf:f4cb:0:b0:34c:2ac4:2f70 with SMTP id
 ffacd0b85a97d-3504a61c88dmr881797f8f.14.1715319534252; 
 Thu, 09 May 2024 22:38:54 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacfd3sm3523004f8f.84.2024.05.09.22.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:38:53 -0700 (PDT)
Message-ID: <0e971b27-102f-423d-9db2-95810a921ae3@linaro.org>
Date: Fri, 10 May 2024 07:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/13] Migration patches for 2024-05-08
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240508233541.2403-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240508233541.2403-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 5/9/24 01:35, Fabiano Rosas wrote:
> The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-07 09:26:30 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git  tags/migration-20240508-pull-request
> 
> for you to fetch changes up to db8cb7b6e73690233bc7c6abbb90979af3a18143:
> 
>    hmp/migration: Fix "migrate" command's documentation (2024-05-08 09:22:37 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Will's WITH_QEMU_LOCK_GUARD cleanup
> - Vladimir's new exit-on-error parameter
> - Fabiano's removals and deprecations series
>    (block migration and non-multifd compression removed)
> - Peter's documentation fix for HMP migrate command
> 
> v2:
> - updated Peter's documentation fix.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


