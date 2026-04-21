Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FE5F327BE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF69L-0000h5-Fx; Tue, 21 Apr 2026 04:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF69J-0000ga-AO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:08:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF69H-000241-VW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:08:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso2356091f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776758878; x=1777363678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nIn7GQDc1GMZ78SN5buO4eSJjGOsm8LULlaB+FDNtlI=;
 b=ZsZv46RAapF/iiR1w00xnmyIjoCzDCLMHkwbuLNtiGn8BBwYnhxeIYIMCPCFviVGR3
 9FKn4sgnXhLWpW+a7fsrKrUklEBC6VSOLydLSQmn4ZdiUGequicuZK/fZHDUlzq6gVjI
 xECEPkDKcdfv1LE3wmfPwVlyqX0DMOzKw6+R2440HRuj24h5MiHMTYTRuTbQN2NI/392
 1Wma1MPnSXCkUVK7sw9RfdqQcIWisQl/tn0WYuiJN347u6NxB9M0k3m6r1gfnjZQZjIq
 CVmKR40m3XDprDbAM/opcuqVmNUm6ydVNSwYRSw53JNf8zMRcVuDKxXeExeGaQg20ehv
 yGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758878; x=1777363678;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nIn7GQDc1GMZ78SN5buO4eSJjGOsm8LULlaB+FDNtlI=;
 b=InKxEdLV2wUSwJ0O6hgoanxR3/IZ/aZtXQ7tsC9Mdzj+iRq116EHYtuJ4tY2qpU6ff
 +3yDH0komoHpDKxxyFy+0ReZPtcu2lG9dxxLB2rsX5vodXrXP5h58+BpCJzCrY/Xd51f
 nyOUMb7AOBLDHM/MpHd2ZMJ1iH5ifvgikDxFq/lTyz7TTPmrOyuv/m1CR/EHS80Ly7GM
 sr0fViEm6Xv35EgQ84VcC9px2oT/VvfXgBoh1hYoEAfoHB4hER3z6VbgaGivZHiiHUXt
 fUozhACgFcNqprQ8skCpPV65l9PJtBB8wAEj3/62LDq7YnRsw2id3XuWctE8hEpA4yD0
 3pHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9L0A5g1Tx4OBSJuuOPoi3y+OFi5kt7KAgvGbKbIMBSKZlxOuWXYL4DxzsUHdoLdYLuy+Wh5Wy6Uv/r@nongnu.org
X-Gm-Message-State: AOJu0YwQ0/naw1h4ZZle08lQFGJh4eoguTd03ZS0YRtEMsRvxg617LVb
 igRElvljhWtkaaL7Qqt8CFzPxDRVWm0RdrfRusqTrMtGmyF2CdpjzGK6qlcekN4TxQiImX7Y4iQ
 I6QeKBdE=
X-Gm-Gg: AeBDietZfyVRb6H//4grHvGGKKUe6TBvm6GAJ8cG9tExyFDVziA92MTZ9oNf62xqXQm
 Zoiuqlv3uB1/zWtTMwM16Xrgaz3NRwAH3veFJsghIu+ZjyAsIlqLS0Jkdut5+Pm3d+pHLnNEbS9
 cESKlgLxxvSjQ7Evu/zBVkQuBlnYHOWTKJMp6Jat4tQrBIr5W/V0iyv/g3nQvwBpgzznBL5U0xi
 ot+yZcKt6DD1OuyGYo5noyTy1L0S/55VOr3dyH0oB56hKoJpwJT8QIp0oUCWMbFFOkBlmnZ9AVg
 WewqhUkM2u92E8WiryXZruCOye+QmgIvrFFyYsiO6NQ+RKsr0saHt4SMt1F6CiK18d5x/143mhi
 SonNfpFDRc0d4ArVaUIRzzLejVf8vteWXjdgbI5wBmdFutVMQa5u4Oqpi3XFKFxBwAm9vyMWF5f
 8Ck9c4Z6TxaCtbBflYcjV6WTo/i1TMNLZkx00hwKlGtuVN34ewlKOVBNq7MGnsQ5EObnUoxEzNE
 OQf
X-Received: by 2002:a5d:5cc4:0:b0:43f:e430:e6df with SMTP id
 ffacd0b85a97d-43fe430fc09mr18439660f8f.1.1776758878216; 
 Tue, 21 Apr 2026 01:07:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e591cesm47410822f8f.36.2026.04.21.01.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 01:07:57 -0700 (PDT)
Message-ID: <bfc966b0-b8a3-4a58-a40a-6221d27262dc@linaro.org>
Date: Tue, 21 Apr 2026 10:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv/vmbus: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163844.332663-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420163844.332663-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/4/26 18:38, Osama Abdelkader wrote:
> exec/target_page.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/hyperv/vmbus.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued (squashed with other hyperv one), thanks.

