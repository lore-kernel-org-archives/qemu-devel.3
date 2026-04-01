Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C84D3517B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ugu-000093-Kn; Wed, 01 Apr 2026 08:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ugq-00008j-Mi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:28:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ugp-00060Q-3h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:28:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cf5d14d6eso3162186f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775046531; x=1775651331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=25p+N3z6Daew8/VXd9MlHy/1l48QJ0jzge11Z2Ry/d8=;
 b=M5Bk/GnEQwUh2abEjXhvAeYIcTADNDW04/eNXCAtKXqcDVcHOhTHaKxJzFvNnZ55f0
 cMFnuJ9QzHPsJVyw2Df3tUzXCUaXbh518gBFNyElwDb12m7B6RLhDrOIB/QPSLjABd+C
 Ytpt4BB7KtT3nCfxcQ8tuy8Z/Y6FEBNQpumhPtgeP7AeLOk+AGa6xwb7nCf74cPoIcbY
 XDmMGh6dxNGGBBzhv1Tggf2kzDYiwd/Qz5IQj9viOolXcnqiIq5OZdUe/kw7ROh4dNll
 8k34KAwQ9JKRa+anyY8xRPYn/xCEDpz3GXcSvsbHDirJ/VsYt3ErdN2fazNciZmYuxvP
 GbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775046531; x=1775651331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=25p+N3z6Daew8/VXd9MlHy/1l48QJ0jzge11Z2Ry/d8=;
 b=JnbggYbNA4OhT4mHqJBwlJhS7IIvnajr/JVKzpg4lZjyOqgOe7kcXlPsL/Z3PYN6Qe
 Sc2RhWPn1HCohJ5sdUED4aL7r0559HmGLjZ9FIeFku5m5lhMZo+Yt2tKZgAoIHXIE6Q9
 ecAnl4FpvO3DrxA2CFiMcgv6m7Igrb63TKWxZ98MR7LEcoUJnm2gnt95GT13HjIZg0k8
 2/GHR3d9b3wt8lLk8Z47hSckaP9OXFQVk+PeGbT+LsJwyQn2UFP+ZY2deKADuSxR4RVD
 1oN1r0uS++vFbC1CsfgQ3rTy9dhflXCsQRcm+oWmznn/4+ZhtYHShnFHldj2ygrPQKqo
 iFOg==
X-Gm-Message-State: AOJu0YylGi4RzCkMITY736tf2t0e3WA3rFYz5YinyMngInLCQgcrx8hf
 EaGzCwN8UDMOLgt3nfDv0laX+gVUjHwVpX+ONj8rJ82fdghOc6xHffdJ8sHInWf7M2VMUGiamPV
 LtP2YdEo=
X-Gm-Gg: ATEYQzzXF5Crsc/QHiXauV3qKnO2dlVfpPvoQiOIbqM0xbdvbv5tFgS/t/KSL3BRSQL
 R088uC/O/CsXpeO0Ww0AZNVwN0u9YJqXSZOWOzq5tSOUE03yg2JRIiq+vX+vjTkpLwO8MgU4WXD
 DVi8eYqWXb6MIPzzXdz1VKR7mi9EAnM+oQ9eCEcRSl1UH/wdoF17ZKCrcozX9/jfnaAqvvP6NCG
 glcLeFGZcRLoiVSeERsg3jxuSR9QerSfDwPx+I7LySgFRsz7764Mta+OSXHZp2y1IzgiDlXp+6l
 /EQPirarSA68+Zcsh3lTEofzAT92EI6dEvH/Xz02BzlKf4dqOX32nfSsUayE6/EHZxJ22kLV7Uv
 1lpii55LDD69asYortWAqqKfZo653Vl/cD/B5dyvSuVlRH018fG0/xmJcYr4oHRcewV9i7b4ARr
 uxZ8VzKBCaZw0UsIj7euNCH7JNVUfGIfeJkkFr+YoogcHvCN8TexqnEiFh1gh0tfy21g==
X-Received: by 2002:a5d:584a:0:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-43d150488e1mr6436105f8f.9.1775046530596; 
 Wed, 01 Apr 2026 05:28:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf90424fcsm31210041f8f.32.2026.04.01.05.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 05:28:49 -0700 (PDT)
Message-ID: <8abb908b-ad05-46f7-99fc-5ce10a07ad76@linaro.org>
Date: Wed, 1 Apr 2026 14:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv: Replace legacy ld_phys() -> address_space_ld()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Ani Sinha <anisinha@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Roman Kagan <rvkagan@yandex-team.ru>
References: <20260319082954.65069-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319082954.65069-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 19/3/26 09:29, Philippe Mathieu-Daudé wrote:
> Prefer the address_space_ld/st API over the legacy ld/st_phys()
> because it allow checking for bus access fault, which shouldn't
> happen here.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hyperv/hyperv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Patch queued via hw-misc, thanks!

