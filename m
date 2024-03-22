Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60273C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 22:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnndE-0006ij-49; Fri, 22 Mar 2024 18:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rnndC-0006iG-1H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 18:44:58 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rnnd9-0005Sw-7N
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 18:44:57 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513e89d0816so3291314e87.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711147493; x=1711752293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gVo4vuYThVrKb1Muw9cZOVr3/HHBkWHsD4WaPLPUGP8=;
 b=Qzm0TCRjHVIUZxGrIBPDdXh5Ctm/6B9Win1W0Ks9QgY1Ose3gfEpFRxnNd2hexnNyg
 k6Aid+Ylu+d2fF7NokOGWwIqRDn4Q/kmpSZtYbTuL2DHTmqoesyMDJQWWQ/R3i9EG1rw
 i/veFpF9wGoAN868uZzacsPXyk/1oFoYjppxwZ44+auzRmTGPDyr4SLIctZrAQ1GqZl3
 INTPX6Vr4a+i8LB8M+1on3CifKDB0/5X6NC4BsZR+D2uU8M9z70a/+xdO5Ldfz5rDXYL
 TCExWvE8YNWnvEDUd6surR1gdSWSXwVsi8hbJl6LnhKu6sbrWYdnZPmY/0EFQW+CYZGF
 m38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711147493; x=1711752293;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVo4vuYThVrKb1Muw9cZOVr3/HHBkWHsD4WaPLPUGP8=;
 b=LjhbNwFs9UInZQyABthDIZ0rNAebLEFih3VuOt1gCjPHpOzHhdQzOGlyQIVkUj5iZf
 hmuV3NLvV+swLVyXoByye8VBVHMZIfTnTD8gKClTkj0oOItxv65zYYuqQzzn6c8DRmCn
 27fTZxZC790OD4T3Ds5skZwx1K/1cGOqoSQVWGwDRVzsaicBhIw6Hln3nVo1SJTLZeE7
 E4/vYRWh0SNXPdx5oKQNlaS4754DJIRRO7Q4+4i93GZ0M6Pc1nc7z1xMDMvvq+kNORHE
 BmGDZ4eXGDJUtIkn6oM7X7+mHer4u/8xLqQzumb+AUXrv7DFu+Ai1xMB7utofsPscZPJ
 0onQ==
X-Gm-Message-State: AOJu0YzCQ+fghDVvlHinArmJSXpAo0KYbaTSBF5Qle7MjgGc4brp91LP
 qRjSzsW6hRVX4zQFzF2zxub5EMoy+iLTvAv4aTaxGfRCNy9Vm89b1SAPcG6ZXyo=
X-Google-Smtp-Source: AGHT+IFgpjBYJEEc5aNEqHUP+jLXp6oCt9eojTpSvM2ye9ut29+ELNZxZG4MWxKZj9herx+UOPeGsg==
X-Received: by 2002:a05:6512:e93:b0:515:a257:cbd with SMTP id
 bi19-20020a0565120e9300b00515a2570cbdmr6595lfb.24.1711147492753; 
 Fri, 22 Mar 2024 15:44:52 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 cx10-20020a05640222aa00b0056bb1b017besm277778edb.23.2024.03.22.15.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 15:44:52 -0700 (PDT)
Message-ID: <c0478bc2-73bb-4048-988b-a05df30cdbd4@linaro.org>
Date: Fri, 22 Mar 2024 23:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ARM Sbsa-ref: Enable CPU cluster topology
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>,
 Xiong Yining <xiongyining1480@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, rad@semihalf.com,
 quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn
References: <20240312083049.3412522-1-xiongyining1480@phytium.com.cn>
 <CAFEAcA8sQnBzFq3b_WscYY1o+J2CutFrEcTGHXvbi8YVn6vorg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8sQnBzFq3b_WscYY1o+J2CutFrEcTGHXvbi8YVn6vorg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 22.03.2024 o 19:51, Peter Maydell pisze:
> On Tue, 12 Mar 2024 at 08:32, Xiong Yining

>> xiongyining1480 (2):
>>    hw/arm/sbsa-ref:Enable CPU cluster on ARM sbsa machine
>>    hw/arm/sbsa-ref: Add cpu-map to device tree
> 
> Thanks for these patches. I think we should squash the two
> patches together into one, because the first patch is only
> a single line, and also because we shouldn't say that the
> machine supports cluster topology until it actually does
> by putting the information into the device tree.
> 
> There's no rush, because we're  now in softfreeze for 9.0, so these
> will have to wait until 9.0 is released (in about a month's time).

> I'm also a bit confused by the Reviewed-by: tag from Marcin on patch 2,
> because I can't see that in my mail archives of the discussion on version
> 1 of this patchset, only a Tested-by.
> Marcin, are you OK with these patches?

I only tested them. They are fine, will check on Monday.

> Also, is this change to the DTB something that would require an
> increase in the sbsa-ref platform version number, or not?

TF-A will check for "/cpus/cpu-map" node and if it is missing then will 
not provide it to EDK2. So far I did not saw patches for firmware side.

I would add bump of platform version to 0.4 one. It is cheap operation 
and so far (from firmware side) we check for >= 0.3 only.

 > Should we adjust the documentation in docs/system/arm/sbsa.rst to
 > mention that the DTB might have cluster topology information?

Yes. I will send an update to mention that NUMA configuration can be 
there too (we already export it from TF-A to EDK2 via SMC calls).

