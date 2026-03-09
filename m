Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE50F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcqf-0007Su-4n; Mon, 09 Mar 2026 11:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcqd-0007QS-8D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:48:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcqa-0007Ip-G6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:48:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so27202825e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071323; x=1773676123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h1ymr9MHNM7cG/1C8WlXJT7tye89prJGdl2MMMwvSxE=;
 b=CuJkGVkqXH8Jqnrh2tu/PGS/pO5lS0EHnoWdB1kv0rxD1cT8QDVVUSk9MUpb68rzfo
 MxttFGoS1acxkoXSFV8/d/Hlv3ek6gnzeqX06/0yiA0zcOTUIO/2AhCcuiPt6GL+QMf3
 WeGlbt9dLHN64TN6DBDDwhO2Gbq0eCJGVpuHBf0OOTgddP+Dy4skMzF+EYV20LRcIfpP
 U45qYp+1NcvTfHX6B6GmCSvzTMHfFPXtAkxlwrenrRsWljpybU5G4WWq6ULEu6dA61VG
 4QHctimGc6To9kS4wNXbr+e8Loc0OgZqyQ5/5aCbTceMt6rNn+r0wwUTgCnZ0VODT0uG
 bznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071323; x=1773676123;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1ymr9MHNM7cG/1C8WlXJT7tye89prJGdl2MMMwvSxE=;
 b=egR/Oiuvu+UNI7cj1bhLoZg7SD5U7ZZuANLidvTaXbVEzs4hER2tH1oqZvVzaZNT1i
 38s94lBvsx2Wwh6dSuhJoz73Jk6VnTb2xrKgGu/NbXkZOimgOseeXz4hrod6uF6hQg+c
 D0YP5VL87J34wwCUg1Mt/h8NRdxE6CoB3lKhZPNWZxJeYKROvNOwBcLOhJFF3K+rNqWk
 UixO7h/ZI8iCU5SL/KbiMSBZ0d4sSoImFLwu5puMY61ys88K3XAYaVohhT/lOgK8wGBA
 ed1u2RQyyHSCFeyOxgj6mH/1RgKo0hc98NS6MR5IEZhcI02cQB7GMj7wKqReaBkUdHSG
 OWqQ==
X-Gm-Message-State: AOJu0Yxnke/6pnzVRK/dmSuhDvu/GJFEoaog+fHx8Ig1/lmPmkpLjHiy
 ZONfq8TZc7A64LMWUUJmoLaOsJqhhWEv7fP16hZ1FWcQRY1NOr1cM8aRostmqQBfn6jX+e0iAFU
 V2DG+SqM=
X-Gm-Gg: ATEYQzyDScaRi7HU67ZqGz9k7qbVsT8s//zBWQuqFFB1GSY2a49dgQ9NVk26chbmO0R
 UD6aKhjeGuw5VvJqwXTD5yUSa3LMR8QMFEknTHT5205z0CrXwEVOt4y03Ytt1T89MjXw2H5Jpmh
 KoZbXt302povppM3NCPfTidESUYxHmjgs0O4IVZ0dDYK7yUFoXzW28d4t68y0XHAfUB3rB8cV/9
 C2sMZDDbn1LwxIynop3gFCxrxdVivG/G78CRESxfdqtpaO+PbfLJoU0EknySYd3aMw3X0cW1Hv2
 BBkgNRZppzoURPPJ2vZy6ZDnRPqxPmL92gkhJYIQN+OPb4JxCpQ+RVCPMZh0pI6Ksr+ZqAp+ufb
 ACYd3HB9ZK/6B/vZeq8WxLvVodYIlm8tb2y7uWl/975soIim9OsN96jvmu4xj5s4VBjojdXGz9F
 Qtaiz4+dYQzvJi/SJjFOoF27edv1zGI1k6XTw6FxVn9rVB7GJSP+JQMMdrDMGQlN7L4WTu7mM6R
 org
X-Received: by 2002:a05:600c:64cf:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-48535a4a174mr97481095e9.28.1773071322649; 
 Mon, 09 Mar 2026 08:48:42 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm76568295e9.4.2026.03.09.08.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:48:41 -0700 (PDT)
Message-ID: <1c89ab32-b994-430c-9cc8-948a250c9ddb@linaro.org>
Date: Mon, 9 Mar 2026 16:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/i386/pc: Remove deprecated 4.0 machines
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260307154202.86309-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/3/26 16:41, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and pc-i440fx-4.0
>      machines
>    system/hostmem: Remove HostMemoryBackend::use_canonical_path field

Except patch #2, series queued via hw-misc, thanks.

>    hw/i386/pc: Remove pc_compat_4_0[] array
>    hw/core/machine: Remove the hw_compat_4_0[] array
>    hw/virtio: Remove VirtIOBalloon::qemu_4_0_config_size field
>    hw/rtc/pl031: : Remove PL031State::migrate_tick_offset field



