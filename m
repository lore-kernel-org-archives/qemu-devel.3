Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21848C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9E8-00024m-BK; Fri, 01 Mar 2024 15:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9E6-00023h-Ob
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:11:26 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9E5-0001Kh-8h
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:11:26 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2394995b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709323883; x=1709928683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73XN9iZT7cxSnt+vHjRMw2eTqfLQwELsWFvFIN++fxI=;
 b=GNpWH8oiocEhkTj2oQhTEKT65YfrP1XucdDPue73UJl7jB7AlMX3w7rd89NvVcJPkF
 /ZzZyNzudV7eQUydZ6ZAvbaesz5rrVZDbt24084vne6z1VueYi/VYBslYmh23WJ3nwvD
 p1jbO7aVosOfZ1YuRbMLDU8ENFULPP3dYlNmwdIpwlmq61U1GK/V0WeMD77hv/DG/fA1
 5FcHOBRkjsxh1C6HIq2L2L553swgHo1/GYpmHiEX2nQKat8yb1cUikDsI4o4Ix3uYUg8
 +E0MpQm7X+FMcZHB0YGqD3CBzX5gFxe32xl1AdLDjcCzyHccD4jo2QrmJLVwUZrzmzvH
 jbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709323883; x=1709928683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73XN9iZT7cxSnt+vHjRMw2eTqfLQwELsWFvFIN++fxI=;
 b=Be5QIaRa84NgI6YpPI0CtyQZBHpWRwB8OALTaazfKPovA2/yoK7NAo77dkCYMbeeAB
 3U2Edql7hrSQSntGQWWTLfyt0iq7a61AVibi+W40IPRU9ifLWJvsEMK9IQ8GZMNNX4I1
 1jf8GvqTU0AgP96bnQzJ6ix7K5OPDzPSDR1LjBvM1q3qG5IlumelLk1yZkukpaO75PJy
 XB/5BQfzqSm80Hw4Dstitxkr0ypByAzRcrNpTGcPbk33t4IaF8d4gVFpHK4QD6U3L2L1
 KmSAt1LJP3XmXoRc4CX0BtkZAGs/v6o2mFX3PA5z5yCOuYZFWOMad04Hx99Ct4yJ3Vch
 h1LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAYI7B6SEuziTKLkRqN+TNFvb5n84dBXCtkR4G5rVl3ExCz3FUlYq6+6ybsKy2mFfnhS2gCHP8QXUghbLRx2mvMHilPnk=
X-Gm-Message-State: AOJu0YzKdXFEfmRAFeRz91iuNLOUVNDrRljbaSTDf6JQ9FYbmNTB5MYF
 1lvTzThGMA6x66EQkODmfWOLPRnvLxurJLyWatAlSe6UuzuuFkvLBHRFGzaPbIE=
X-Google-Smtp-Source: AGHT+IF5wr4s+AUWDtFOHdFImWZFVUb0wAPySNNzjgFPbbO51xgkHYRUyLjwpiR/m3ABu4v41YoOmw==
X-Received: by 2002:a05:6a20:b2a9:b0:19e:a1a2:60f6 with SMTP id
 ei41-20020a056a20b2a900b0019ea1a260f6mr2209394pzb.57.1709323883220; 
 Fri, 01 Mar 2024 12:11:23 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 c6-20020aa78806000000b006e53cc789c3sm3349553pfo.107.2024.03.01.12.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 12:11:22 -0800 (PST)
Message-ID: <6fa95443-3eae-4192-92e7-89f916aa793c@linaro.org>
Date: Fri, 1 Mar 2024 10:11:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/i386/pc: Remove pc_compat_1_4..1.7[] left over
 declarations
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240301185936.95175-1-philmd@linaro.org>
 <20240301185936.95175-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301185936.95175-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/1/24 08:59, Philippe Mathieu-Daudé wrote:
> These definitions were removed in commit ea985d235b
> ("pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/i386/pc.h | 12 ------------
>   1 file changed, 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

