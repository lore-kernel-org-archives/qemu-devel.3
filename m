Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E811CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 05:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umQ5X-0001Qh-9K; Thu, 14 Aug 2025 01:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQ5U-0001Pu-UK
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:01:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umQ5S-0004Sa-CJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 01:01:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so3543855e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 22:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755147671; x=1755752471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hGZOY7Xy+gz59SCRsDC8nGqZPo2X4D5xAdde61ajILE=;
 b=I8hLCU2s5UuoIq/VC3PQ0Gg9oaODZF7DwtwQEeDSGGH82wzDILtw3LDe9mpY/EJS11
 9sRAwi9kRGsB1I5qlBe+oCKzS2NdRHwNqKRUZVUc9Zb+TJ5evil4N2lgaiNpdtbeTrS5
 i7yGmSp2tk/unk5IVyuT1pGzg9QobOc2gAG+ylkTrWFfqzfo5wmZ/nKv1vwVy/I42GD9
 X4V2jjc8A8AaskfjMF1O56rsmYWGfcN9d0maemqrKcCPdTYLfWphC+42P2URVsvj3Goq
 sx8pz5+Llfi9mcPh13X17+GQflf5eSPqh1S8/nj38tWplMeRo1V63XYphGb3zHLSOjiI
 5MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755147671; x=1755752471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hGZOY7Xy+gz59SCRsDC8nGqZPo2X4D5xAdde61ajILE=;
 b=Wyk1sh5M11e74cT4XLqbZ5P0Rv5aOjiWEcwZ+uUM20tqE4dxIN+/khVxjrC128bmaX
 YyqfVaUHW+vhiDpOfLkkF83LNYbVSWBzsUVTl1bmiJ55epPqpFUCOmDlzQsVJRBnSXT9
 ZIQX38b/5fBQPD4LojoH1xOB6OLdIV53NhWm4KUThdQOYTInCv4QgvEvWSdFtiGokL/8
 7/6yaxYLtmR0IPsl4tNF+P06mm4591CLe78ea0fJHPYbm9akeizKGyxpmHe4BbBEK09S
 dYDpymzz4hgXSXelVh0iyKO1ICdpXV+eOL1u5YvOCEWqvlllko7lpi8sR3qKm9/VFl/B
 RZdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu/7ruUnabBYJQUWPFsk+n2QqwCw/JDZm1XaWlo4y7BuuUx9MEXriGrTfPo9EbHE6E9Iz0ICUN1o/A@nongnu.org
X-Gm-Message-State: AOJu0Yzuff6/SRWu5YjJ87ql98hBb2v3ij6Y4w708j8py5n9I5iTBwLd
 YjJXfuHA5KY1FUPz8RiwHWRXzjVOkYqZ/pZys4b7/arhIBvPhfxkH/6DB+y3A79bWWc=
X-Gm-Gg: ASbGncufnFn+GxlQA8HsgXW4+4FZuM24qPLTjRBYiTCoOfGiOKJX2gO37BHFinmKvYn
 fvzYen9bDF4seecc4k09a8fIjFLsU8/UrdaN7Y2MBVdf9xK4NTSrK3DYB082HD2s8Nlnhs49gCi
 sfBRjOsEquQ3xb0zmgSm8xNnLmk3lcxAzd0M37Gc2wStAypkt0gvPEsXY8YgbSvpfpn47hAQLF7
 HPBRpIkzuwJlDyJ9v5Oy5MYsrel3P9TR1fy5bbQ1ZbLAWI4X8XCoD0apFZT0OjOBp106ULtzxC1
 +vjYhVVW1MD95+OzPDMAC9qaIMmjp7kUoYptdlnDs3LsGhrqMv69+antU2S/lzGz8XpcJeAqf19
 7Tx/r+83aId6+/ng3ir+02V0UKUYA/SiEVOwDh48zpzyjz8ygxvDUmpiJkFEsuTwoDZ2QYxxCxq
 Nn
X-Google-Smtp-Source: AGHT+IFi6qc0pPUKO+qZqo0OonpuM6qkpkwthhk4P3xB6lRnLJikhZuWNblrczgWNcb7QHC/kGs9CQ==
X-Received: by 2002:a05:600c:46ca:b0:458:d289:3e26 with SMTP id
 5b1f17b1804b1-45a1b78c070mr8855035e9.2.1755147671014; 
 Wed, 13 Aug 2025 22:01:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm41234913f8f.41.2025.08.13.22.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 22:01:10 -0700 (PDT)
Message-ID: <27aea1ad-9e5f-4e53-a3d1-8b279a241bcc@linaro.org>
Date: Thu, 14 Aug 2025 07:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] test/functional: exec_command_and_wait_for_pattern:
 add vm arg
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru,
 Thomas Huth <thuth@redhat.com>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-33-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-33-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> Allow to specify non default vm for the command.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/qemu_test/cmd.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


