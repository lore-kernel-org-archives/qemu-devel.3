Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC01CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQl97-0007Fh-AN; Sat, 23 May 2026 08:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl92-0007FH-UQ
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:07:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl91-00031m-D1
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:07:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso41254595e9.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779538074; x=1780142874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tk2R8mJeqdvDngAuCxHvjR4qZlArO8FppQmogPkTrUY=;
 b=uILms3Yxx+HZigtnh3+80LoEiEvn6SIdrInbxrmY41V5B+TjjJVAynh723jHaTKNL3
 07kFWiiyS3Ulb7nwTMPqhWqDBhcoEV2WSmq6dSB+z1G5yhQDE0pv06UKZBvrsXoMnKjU
 NG/YKq/r/YmrzLc8O6PQB9owscW7wSphGdikyhK/6BdQReeRfZEFATMcnyE2mG8bXKY2
 F8n4zbBY+taquvRs0DjX3HXng0ga7CR7bPQFPrRHiC1zsXC9We9tPc+cEkRqh/l5yCU3
 7o8nLQLm3YcZX/wxJDBijkKhHCSHCElyFerrkgQSgOLd0uLsU9Pk3FkxLWFngmH8zVBx
 Ac1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779538074; x=1780142874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tk2R8mJeqdvDngAuCxHvjR4qZlArO8FppQmogPkTrUY=;
 b=iUmGAsVUSPXCvUjNwbi8X5eNsxta9j6ib7k8ZDNMCXnpiay6JI0SAWlWu1mPgdNqcs
 qBV4a48dfMoeXLxT2HwoigjnugcS7fb9cBltrHvZfacRpt83/sZbcY9cWSToIaEtT93y
 gSeVx23dTpqK/18HkNaZfQa+bsGRLU0AnSHaEBdcl3SiMmb6r77+aDren8kTfH9ZBMtS
 H+RiM31P1S5rlmxSDs/9J03Ba4uv2yN0ne5jy3UnxnIDXfwXcm+X7YCF5AAzGee9352Z
 IzyxvU6UiueVGMDoIDKutm+nwNsXwChHOsiyn4Re84kK0HqGfE4uYZRcEyeAJpgEyLax
 tigg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NenWdqKcKZq3FG9394HTZ164q9MYDw/34ijxI0o5CojsP+mZT+Oz9NnBom5UBhMxmMfn/DVKX0aVm@nongnu.org
X-Gm-Message-State: AOJu0Yz6XSHsYWZZYM67D9/2bZPqhUSBcn4tLzjng8IRMI8/ncUeQKVu
 8LrJFaENpnvBfqoNZlYXGVDIC8O8+ZoJlOOsKnAf/Vs+vQKsbmi8hcISKiw/GXBEeK1paYXLPO4
 /X0leb8faVA==
X-Gm-Gg: Acq92OExy+7/hf8mDtGQi7+2McAnumyMM8dO/kom4gkpzZg7LFTAFZtUgvkq6WiPj/C
 GpK06S6XY1V3bIf9x9pT7y6bIUnjJrfpTTLsTGiJRuZIT48e3ijV/LB7a5r6FNOanW3Rlj1hnrd
 kjcaKHTwYJvvL98evQFVpHmNpcUXDMx8LBcb4dW4qjxwsb57xTwggQk/MNwl5ihafIRmP9gLX4t
 g00/omGt5Bop/MLzfpWzINsRk2fhSSSilfjwgzs7mTTSHv+W1f9uzznFMTOBzZhqkPuXNE8+WL+
 NApSu7jTKMduWMGsK6VyuQRiSRXG64aC6BcbE9nzFrBxCnqYceEamdi1/EIeKi2O9FDwRXqceZU
 kxnDS/yj/IZALEpVJC+E1GRosJuCV7PMb/sd4S9iIlV6GiumIq96IBzri1RJuypSoo9JCS5pNaK
 48XvlO/c7s+Ls5Y3mL5Bbg61Fw6Bz407Qlm0lZKfTMWi04IGQ5xs/9RDiaPCG5wB0Q8jxMpgHo7
 C4=
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-49042489c30mr128630615e9.5.1779538073703; 
 Sat, 23 May 2026 05:07:53 -0700 (PDT)
Received: from [192.168.1.117] (88-180-58-130.subs.proxad.net. [88.180.58.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4850dsm11197444f8f.17.2026.05.23.05.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 05:07:52 -0700 (PDT)
Message-ID: <49530161-7d87-4358-9331-a783169ccff8@linaro.org>
Date: Sat, 23 May 2026 14:07:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/39] MAINTAINERS: Fix F: typo in "Dump"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-29-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521080511.999266-29-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/5/26 10:05, Markus Armbruster wrote:
> Fixes: 6d3da32c8b (MAINTAINERS: Add Windows dump to section "Dump", 2019-06-19)
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

