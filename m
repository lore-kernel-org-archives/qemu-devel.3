Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEBE6BF22
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 16:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlr4M-0003iT-7D; Fri, 30 Jan 2026 11:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlr4K-0003Wx-C2
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:10:00 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlr4H-0006Bp-W8
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:10:00 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso19146865ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769789396; x=1770394196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2DV/PkOGhxgV6dRDamboeuiBvQG7mEsNvJJrHuJVl4=;
 b=tv9h+DDNVk0xNhC+N5SRb4wMcePrxKdDjOn1ZhfSoFFTWbCWCn7Tu4XVPTa7fMseX5
 yDnvuIhjP1smpr8DPERl4XreTIs2y3T/+fEXg9eCg3mpbXIHC22E7R7U5M4UKbQI9Pkg
 fWKHlvICytJ34T67wdz+LzrD/KLWwJ/0Y613nt1z5e7Rc1X2O9BvsVvaguKLX5uYQfLN
 4T79VFOkqOt/mD9HWnPOlHTQi1KuQJPfCGGfNGztocVraH80nRCmXW3f6worsynvK3Py
 c2ZJrhZmw4/VnBrWhnEa+4WK1AV+6yEugZXWaguGIgFtoR6L0y9lhJh+sWNIK0SrXsJR
 pRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769789396; x=1770394196;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2DV/PkOGhxgV6dRDamboeuiBvQG7mEsNvJJrHuJVl4=;
 b=cMj9cm//fb+GgE8rWegC4Je4Lju2Kp1O9JkLcmLsfiEnv6p3IdbOQroBlwwCM8Iik/
 pLaVWtC5ge1AEq3xHYvPKBdSWuHOwSJ2S6mTbDl3dSmg4TkFInXApfGOtOTA2twDceAJ
 iShScCbVN1H2DBMq4ghIsdS9BW8wJFOb4b6srC6+2mWOFnKLPZgmf7B+Quk7irNxPg7x
 H4ZifhjOJsTgWzN9PxWiyNlw58DlJFxl7TZNxEZFFP9dCE/f0UpXDLs2rofyL7rpt8Kp
 HXjl2NnFSg468s7ZQ5Vwy+r+PDuWw/B9ohdQ8sbpsixfBC+xMq0U3529hXQq7WZWB+xN
 mAZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQCKBAf2yu15MhBmYY20n7Dnr3Hq2pt4KLlA9AjBL/acrozYgi42UmD/fboI/FUQU2hxTKdw/K0zTp@nongnu.org
X-Gm-Message-State: AOJu0YzNgrVW9LDE1CPrQqOEcRQRspEwko6zP+6Sy8KXw5YvrFLbEnVE
 zTbTolLlkpLDfh+aiyh/iGMTdd/TFziSAD5+T1swmk29DcyWFjbZyXOaKuiml1rh19A=
X-Gm-Gg: AZuq6aJCita3De0BlrTinkMgyF9lfjYpuL99fjTj7/nbq/vqHcDepCv3BFdcVqH1suR
 uTf9XuLBoi3L4c0nmM0iXlw7Dqm/Cy1rESZ65fng4odYWKD6I4jmyuLBHJKrP4YSSxCSOYdW4dy
 1FY73jmWIbqTv0LjSoWa0FULDuPnQgofClHQH54SPpGbUzKFUdi654Sv1UZIC04Pal7dkF3LlBA
 f9C3m15BFJOIxWCqPBCoS+M5Lx2U/h17BEQBz6fsvybGZtYItwGwAhh65lLJpNo1WXpmQhrnSmI
 /dKCoelHkflI8JpBZ2wAKhlZab594Q9pjnl7G+Q0bEI1KOURCggTU3ar7vX09hOE5nXKDZYkLJY
 C1Zlh8qGI3q39RGKC4omFOkU8pqf1/3Qg0p8/XgYX6XB96YqPG1B9uwAvd7J+7msr8HjaHHgsYg
 Tc++4FrHM6jLjQeEjKqPWWVPJVIa+iRu567HFTtHpyu1KuRzGXpbM+SXJU
X-Received: by 2002:a17:902:f686:b0:2a7:cb46:7069 with SMTP id
 d9443c01a7336-2a8bd51b6cfmr68441765ad.25.1769789395722; 
 Fri, 30 Jan 2026 08:09:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4154fcsm78654985ad.36.2026.01.30.08.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 08:09:55 -0800 (PST)
Message-ID: <06fa7871-dce7-458d-a01c-f720424b1832@linaro.org>
Date: Fri, 30 Jan 2026 08:09:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, devel@lists.libvirt.org,
 qemu-devel@nongnu.org
References: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Markus,

On 1/29/26 1:53 PM, Vladimir Sementsov-Ogievskiy wrote:
> They are the same as fds and vhostfds, except they accept only
> one fd. Let's deprecate redundant options.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all!
> 
> after "[PATCH v2 00/12] net: refactoring and fixes" options fd
> and vhostfd becomes redundant, fds and vhostfds may be used instead.
> 
> this patch also based on
> "[PATCH v6] qapi: net: deprecate vhostforce option", that's why
> it's sent separately.
> 
> Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
> Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>
> 
>   docs/about/deprecated.rst | 6 ++++++
>   qapi/net.json             | 9 +++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 

I'll let you pull this, including doc changes, in case you're ok with 
the series.

Regards,
Pierrick

