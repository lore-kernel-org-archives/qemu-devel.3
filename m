Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686D9C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcko-0006XO-Dc; Mon, 29 Jul 2024 22:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYckm-0006OI-5t
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:38:20 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYckk-0001f0-IS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:38:19 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e0365588ab8so2435884276.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722307097; x=1722911897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmVgJeJKZoT6re2xWLVSucu4UZIT21PNUwUfJHRP9Ho=;
 b=M/ruXLQ3de3ZyPSyG2LYaVN/hRpehzdHsYi1wCoOsYCH2/8K9CDdbiodGPfLfxbPCF
 fqy1NifiL9e3VxyBPb52hsTSL99/z1EPdd5aJO8zo3ns/PH5J/gL8++z+SulH5wQm0qI
 hQKpXeDt7HO2yETWug46iEsp6aiI2aoJOeZCvuBPCOTWAoG86Ap509zAYwY7arKaYgxO
 Ih96XakmHv2KvoIJgXWIeaPKv62QGYEWOhMHJBrzjjHsFCa2bFHMvm1/5Vb5zs4fkp0H
 baPuxPg77lo1B6hcl9YIwJrwVkV+Ft6/iQeTdX0gSuNcRKWbl4DkiqFYltjCUNY58J3y
 gYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722307097; x=1722911897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmVgJeJKZoT6re2xWLVSucu4UZIT21PNUwUfJHRP9Ho=;
 b=dQzDn8tXH3QiNkQaMxBOaY+iBFnEnLk1OCJAshnTVCWFxp9DPzklwf8wSL321LhOkz
 /TxRIS/s4FtdYctr716SYlDL++5fpOZ4SGBvREWyS6QeRvPzFgpHrsXQ7WEAyMd1yKVH
 5HyFfvtRYzd3Ib4PTF3U/PyQHLwiQa4TmMzzAikHnfQbhKOKEh1XUQV570F75Cpj9a1V
 pQXv6wGUWvjWTpWCLtt/uFC9ouDaP3KMDi61RlkFerHWy8BZiQhrcsr1bBXYdBsUkGDD
 oo1vuBMsayGR/zVpLq7Ck25m5p/M4ZlCw8oTplyXH61SQm5jvjx+I0/k85HXqQe6epEm
 c2jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGDYHfcu686/j4cwZ61akPtazggcOAaOHXYXqNHGkIVG57guBVlNjBrAmWIMBG45JRCK8f1kbmm91bEKoGssQLLkGx5kg=
X-Gm-Message-State: AOJu0Yz27Tpnsx1MaWcIHwm6tASAYmAFv3dl5ZYdS02Xj+iospvt17rW
 /uZjX1Zchb+EvmwLK5NqGIOy0paaNaYe4F0wd6oWP9zPLDWe2+5G03YIEhc+/PttHrNlS33DdDE
 IMuA=
X-Google-Smtp-Source: AGHT+IFFHl3Uu+KCEeW09W/I/fM5Y2HjKm+X/OQt55mAJv8bkuQR45HMbHaSVktfWUcLWRmOZwD58A==
X-Received: by 2002:a17:902:e846:b0:1fb:44e1:b5d6 with SMTP id
 d9443c01a7336-1ff04827042mr107304815ad.23.1722291829021; 
 Mon, 29 Jul 2024 15:23:49 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f1ca6bsm88021965ad.199.2024.07.29.15.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:23:48 -0700 (PDT)
Message-ID: <c008c4ac-3785-4ad0-9ec5-2baf3234b990@linaro.org>
Date: Tue, 30 Jul 2024 08:23:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] tests/tcg: update README
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> Update the document with details about the layout of tests. Remove the
> out of date cris comments. Refer to the developer guide for details
> about how to run the tests.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/README | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

