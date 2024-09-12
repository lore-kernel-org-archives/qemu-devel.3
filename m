Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002E0EED635
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooIW-0005La-Mm; Thu, 12 Sep 2024 14:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooIT-00058j-FO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:12:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooIR-0008HN-Tc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:12:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20696938f86so11677525ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164718; x=1726769518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKHvgWUVJ+01jgoQFW8d322vT3mQt2FziRAouxUiYk0=;
 b=QRVJXIbEYzUcB8POATI402KWNktwVlwcs6V/HsK3HF5LqX+1M0P85UHLHJPtqB7eF6
 piG2Kz04LiSY23vZl2SM02zzD1wcOl6klCrWOpu+yREPFy6G2gOqwF6spVvD2+T90SlW
 o2EMpJ1wSUQmGnz0b4OtIXi9WIBzbvLINlh7jW8zczWNyZmVjzz23fqxqkViifCNufH7
 SgvOJAITyKkL3IRXuS3Ag7phdI2DG2/3mKOfXQUBObJXih7FAJ/qXw4pj3gF43wh2bEW
 32466VJ4rkI2mHNgDfc7USjRhPLkRgoqIYPs8K/4TpPIeptcm+oiyz4CXLIQpLtThBFP
 ehmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164718; x=1726769518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKHvgWUVJ+01jgoQFW8d322vT3mQt2FziRAouxUiYk0=;
 b=tpu+amvsKTmI3zRecndlwYjmF9wPuqTL11AogFx5PKWXHe5oN4ZqhhVEjkC1WAaaS7
 7UhM5fB5DoCVI1R+KSGw1Z/Hby5i0+m5xL5fP3MBoYNMxdLoQkrvafZG+gxt2F2rn808
 a5vEog9FSmsVRaS6Qem9rB2Daxd2BOHxh8GvJp0iUHpDxUJEGf1tLP1tv8T74Q2WOu8i
 PPvhiMkoWUR58zObyZrmA2QgVOP3ZByqKsJcHc0pBaz5kcm/aOHzXCiIfJPl3u0j3GcG
 bnA4E2TCOhtthU+Mw2sdS486XgJmKLTsD3exIpnQCRX/yW0AYRSgLQM72aTfk76U8VRX
 cbqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+YuHpdv6tSgAcU22TWDrU/Nz22EeJMMp/tzn0Vh6I0ZNowxXba4rIB6qr7aUDMHEBpM4uuQ8Xi6h@nongnu.org
X-Gm-Message-State: AOJu0Yz3rbU6hR6wUXV8GR9U41aHr9GYFF4lM6qjzr2fVupE0mWm9vsD
 dOxNoKmpgSqC34YFzrn6dml0PPdT0rRCrd7ayPTJN+ys534jN4E2tDcIC/FjprI=
X-Google-Smtp-Source: AGHT+IHuBTKGELVgJqCkxIsAP1L0AqSCuv9yB2TQb7AVEwkIXTnlrjE3FuVIEc+ZQzdP8G2NgEggGA==
X-Received: by 2002:a17:903:1c2:b0:206:8acd:ef7d with SMTP id
 d9443c01a7336-2076e44b8a4mr57169375ad.52.1726164718402; 
 Thu, 12 Sep 2024 11:11:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076b01a093sm16881375ad.276.2024.09.12.11.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:11:58 -0700 (PDT)
Message-ID: <00d8613e-8f2a-41b9-a726-11a1fd4b2d49@linaro.org>
Date: Thu, 12 Sep 2024 11:11:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/48] hw/pci: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-43-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912073921.453203-43-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 9/12/24 00:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/pci/pci-stub.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

