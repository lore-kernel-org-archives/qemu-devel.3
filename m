Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D6E88D6E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nnW-0004Uj-6C; Fri, 03 Apr 2026 19:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nnR-0004Tc-NH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:19:25 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nnQ-0008Ml-5Y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:19:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c757a9251faso722951a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775258362; x=1775863162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQ9BXFCTc0czh8WYTg86lStU7t2ZzcBaS0KkgmnOOsI=;
 b=zOYlipG/H+qhWv1dcnW8UCuGJFDecNgnDTbHmtBBqnewSw82Cs2nQgxSV4wwIrrafE
 KCHCiQloMAaPtiv+gMy6TNWMV1bIpRqO57BAGc9OqmIesAFUTiNXwHgmfGMTB8RZxTER
 /bVjxAzJbmcMgQFSYQta1OuXkEhJA5zQe7zzqFz8w6EgATM+5kTLclgVNdlqFR7eNukt
 9u1C15ttq7UlpwRnhVBAoN7Py+ZsBByFIltNq4XQ5Gtc0zagRmdJK9WEQOOaD1j1yoOs
 zOHmEN2PpUjDRv7NNSB/NwKjN22b890yMleKfQTRztWN2rO/DHH7HoaLLua491VVTSXf
 wgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775258362; x=1775863162;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQ9BXFCTc0czh8WYTg86lStU7t2ZzcBaS0KkgmnOOsI=;
 b=o5czn6eZuoSV+srPvFSOTY87c/IHo5mAnpZXHTTX5EPCwcQ7jKO9DZT74p8GIallMK
 hYrnlmUPvs4YPutpWTogtRN+iXUQLODRKAOikROULhdj6wBmgNQaX8MJjAKPXfJHh6Z+
 /eojfqYAxVK1Pn5U6i1Sd/+0s/HLVBZhXUchVPRB17+hXzQwjiF/qHO0b6ZLAWQsBmfC
 lHIzQoRn/P3+t7Bb0UYpcfFZYaMz/wZGQqNpygcUsHvjPB8prS+xaJn0Nzdzp8v65emg
 //gTNxzoNpNSkB7jZhO+6tcPcMGrMX6fdlNLsRgjZcL2vZLtGokIcl1b1VZTEt/COK8+
 4NHw==
X-Gm-Message-State: AOJu0YzKzofDvI0ZU+lLnTQAxWv9Sac8436O3Y2DnUwHMEEsJT6jSrON
 zgNeJ7beAqjcqcKgI+syBzAxhIZg+EE/iHVvfjhaem0Bf+fYk16un9YBWv80MFlZS7TKrLIOl0o
 Ccd3CbwM=
X-Gm-Gg: ATEYQzxRgHL3YtDYcz2XPDp+oLNZL8TxW8Jt+ruHVGE2fcyGhuckAG8VUhRjkVXng6k
 BmA7+lpT4I1ASvIlZsV0MF24xKC8puLPc0WX4weAHXM279d70gFIzc1lC45h7kujYdvf7e1oEuS
 2YwxckmEe69El0mA9VV3Kt+NRg+ffJhVK5Fcq+UZ8XkKNC4c1Ri6Db7XQhdqcBytBaD+wX+n05h
 Pu1OHSpoT2mcMVYGqq5rZtmWmJInfTYGo1fhYJC3hwB493aCItG/NDY7KAEOW7MATBKUCA+rq9Q
 0qdzRmCy3D37UPz4h+7ez5A1T8WBYqwjdv1MENptOInXV7mAhDWhXtuYaYeRBFPfyTG8Ib0oqzb
 Rm85fpIDQXNocyfkgUPF08tbieLA2VdPO7XQtBD5DbxrwWHG8HNb+g/GSrlGZU5V6n1CmFuOucz
 qKKmD7j2zpdjNrHS4Uiwt6p8H6/b6Jx2mN1o8HUUW9EsUH8pVAOJmvR93uHZhthpadru8=
X-Received: by 2002:a05:6a21:998e:b0:39b:81bf:15e9 with SMTP id
 adf61e73a8af0-39f2f3348bemr4342424637.51.1775258361848; 
 Fri, 03 Apr 2026 16:19:21 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491157sm5508156a12.9.2026.04.03.16.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:19:21 -0700 (PDT)
Message-ID: <6875d1bf-1d49-4f9d-9f66-75d11fddffe0@linaro.org>
Date: Sat, 4 Apr 2026 09:19:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 3/6] qom: Declare GlobalProperty structure in
 'qom/compat-properties.h'
To: qemu-devel@nongnu.org
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-4-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260403104327.1163942-4-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 4/3/26 20:43, Michael Tokarev wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> While GlobalProperty is expected to only be used by QDev board
> layer, it is used by the lower QOM API, so define it in the
> qom/ namespace. This helps to build binary which use QOM but
> don't need the QDev layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   include/hw/core/boards.h          |  1 +
>   include/hw/core/qdev-properties.h |  1 +
>   include/hw/core/qdev.h            | 17 ----------------
>   include/qom/compat-properties.h   | 32 +++++++++++++++++++++++++++++++
>   qom/object.c                      |  2 +-
>   5 files changed, 35 insertions(+), 18 deletions(-)
>   create mode 100644 include/qom/compat-properties.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

