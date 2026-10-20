Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E8606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qOM7OIBI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Ya-0008JQ-JR; Tue, 20 Oct 2026 02:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJ3YZ-0008J6-Ll
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:42:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJ3YX-0000EF-SE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:42:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2396535f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792478560; x=1793083360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tamAROQ2Pg1htMA1ag9uMuGkiPW2irzDwQrO2cZFABQ=;
 b=qOM7OIBI70gGVzaojTd0jI/55IikwdzbhJpu6g2XWh0XVCp3IR0n0GLFj1kAddINEr
 /6V8DtZU+BNpiZsA5ThxHqS+K5BZrj9xHclRGuyk5KtteDkgxFbVYgWBJ1kY4byJ+fr0
 jOVQuWPB7wENrnpst1tPMBvXxksHfLnLfZXBQfjljk/BbUqmoDp8TW+skDXKkmKy09vU
 ULE0/aPtkYN+qkeOmX5ImSaR2H80CvNCwo//I37vzlw7Ar/NVSa0ncDIFGyUko8y4xLo
 b7aX9oMs5bhz7YPqrKNrMtk1RhsrddHeRx/7IAmv3tzHEPlxvDLbmwGO2we4XhYIQ192
 ADQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478560; x=1793083360;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tamAROQ2Pg1htMA1ag9uMuGkiPW2irzDwQrO2cZFABQ=;
 b=UqHA4zSxNUmSzhQqwf+agtQsWdEDCccAP3aJ9kX6FK+DV/kB/gKjR+iqXFpj5iHv4L
 MwJG9h4hKrjl9cZk3JOCAdjIQQlkDe3GzyHpu2kCNLB7/mtMK+EL3zMOPl5m+hFxYgkR
 jDrs6uFSB3gqz7Kt22rziaJFdfjiRU7tSvKrtpU3iRjedD+1IW431quRLZYQ3V4RJR+B
 bCUwHr/zMtoyxVtIemWvri73LUrgaqPZINdYogs46lXGVePLdzvI1Q8Q/1goBIVMlgZc
 3qs70+Aq2k9nvZOLpYw1exnJVY8xHW3LGCvCn3sY91kcYeyl1xOzntbAsbv5VOc8juTX
 9z1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAo6eMOkOJoYfIPbhvipBKYogKT4rb84dmOfEyLqDJcmilUNbnIvRqU6OkebDEmbH3G2jcxbjtfQZR@nongnu.org
X-Gm-Message-State: AFq9FYKfIbUsqJSYqC88/AWITHboRrwlQjgNYHmJOqefmPXh7ZUjycjn
 jAsL34oRvqu/vB3KV2pgRzyo7A6lU5k97Fi2Xz9MaU9ntfxuA6XORf2RzcV5DXE3kQ0=
X-Gm-Gg: AYBFou2BslH5JHt/J4Uw3Wikq0xnmrCSycBpsRdS0qErEDs1AmIjy2nsFq0gXbcsxfV
 TQ/t7MJpdqM/tYTJ7XPPP+7fFy+C2QUxVGored1w4WF7wXoSR7AYUlZFwSTVE1CT3SAFReBQzxR
 x7ApydABgPH+Eb42VkVoONXiIFwsoqwO158zbqxjjfsgQiHGqstgJz2G3QeeWB6GQuPSP4o9f/o
 Ag1pkmGqODgtkkk4wpsBlsyTZNPUpd71Gh/fzroWunj8yu3Fh31CgkTmIxYwqHx2zawl3SHhQfJ
 FEinLm6YorRBpUc7NEHpGiU9e+rQvXBeBnZQrbRMXE+/94uwg9PakYshQ1zqKestT66IL6qhRTg
 C4q5Zumxc/DOJ8qKJEhnA+1VOZck1p/OlH4haojce/10Y74FW0LR3c2SX7TXx9pPalL78H6ZoXr
 kXeELu9e0QiY7MvwLUNGs3WIGP2pdn/Le3m0eijIYVDwu+AvtmsawyWz7m2pQ/ilxH177U1qn2U
 gkIe9cLQ/QZ8yql8rJCWidOLiSGeURH1nTcOnCiLBMWwRrA8M/yiZQMtlMqIw==
X-Received: by 2002:a05:6000:4b0b:b0:487:2387:7c9 with SMTP id
 ffacd0b85a97d-48e07bbe7damr18766238f8f.14.1792478560080; 
 Mon, 19 Oct 2026 23:42:40 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d83a338sm4066336f8f.59.2026.10.19.23.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:42:39 -0700 (PDT)
Message-ID: <96cefab7-f3e8-401a-9075-8f6136a227fb@linaro.org>
Date: Tue, 20 Oct 2026 08:42:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] 9p queue 2026-10-19
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 10/19/26 16:27, Christian Schoenebeck wrote:
> The following changes since commit 288b6c9e78913401fac4880b3281ce431540b8df:
> 
>    Merge tag 'pull-nbd-2026-10-08-v4' ofhttps://gitlab.com/ebblake/qemu into staging (2026-10-19 10:54:44 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git tags/pull-9p-20261019
> 
> for you to fetch changes up to e727e0c5d7d31640708fe3cebe31cc1312eefadc:
> 
>    tests/9p-race: add Tread-on-dir race test (2026-10-19 16:07:26 +0200)
> 
> ----------------------------------------------------------------
> 9pfs changes:
> 
> - Fix dir stream race via legacy 9p2000.u Tread request.
> 
> - Tests: add 9p race test suite (registered as slow tests).

Applied, thanks.

r~

