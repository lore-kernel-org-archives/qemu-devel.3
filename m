Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF36C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyFz-0005jw-Fn; Fri, 31 May 2024 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyFy-0005j1-BF
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:09:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyFw-000519-OC
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:09:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42108739ed8so23673515e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717146539; x=1717751339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X7W3xI7fAUh+NEJTD6wipxw0E8s8MOWy9REBP0vU0L0=;
 b=kyZlFa+j0CCaDgw73rCCj7U8XDH66lG3tRYbX/B6fhUJdOALjLzHbfso/Oqk7y9mLK
 cL2/v+CD+z6jbn+KEf8zfype0JwmpbypyFyxpFrapUqU+o65cnQYGc7fTsFc0pY9ej70
 mNzxfwDhB71BrwdHflO6ZZdssQtqGsmL22QB6QsIEO7bI6zis55+j9+g5dJBx1JWl/Lk
 D3H3i5AhBSrXbOL4JGo7IVX3dAAiEdy/9T3VkzbOimcTdARWWmxIItedJBDS8QBzuKsz
 e1S67wbxp5apl5zEmgTWA7LBb0z3OwI7hKnpJqbHR9w1MhAvA2o8GPpBBSZyVtw+xi9x
 E88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146539; x=1717751339;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7W3xI7fAUh+NEJTD6wipxw0E8s8MOWy9REBP0vU0L0=;
 b=xE4Ph+jaNMZMw7w5u+7z2EPZJTxrZ33SSvePcGLFrRc+KVsrkT0OCiR8d66ADbfIm5
 GqqO41aqU0QAnO71rKHEJJsfeLBPNiIzzqc/FGNVwBBIA6Ihm0l4/Ebf3SD/s8n/LgTf
 +Z6sTYWIzzFLlsBnLDkNS+wI2yo7w1d+mKhlS1pnH5Ror9oEJj26+o//4Y0U7YbW90rp
 XZIY5IHFnLPrkSdRtSZX/NbIp84EY55ZuYk0QqxdiVAjW7ckVW+B7DnghWgmWIklG30D
 9kNHGeRnUcVitJxGhkRZuXJpUqPZCH/d5u2O4auFQ0q66SfBv1n46zQxMdDCPqMdK7KD
 Br8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6H6040tcbyY+URPIJwCQDqxEhx7qG8pUx01SlQX+CldQdnBHNsaispDKvO3x3+QFnv5KaQefkZRgRYjxr9vPG4vsaTK0=
X-Gm-Message-State: AOJu0YxB4C7W7x0hvgsecUUGno2/dcyS7kD1WuL41Mg7MMuSUbuwOI/P
 ihpj3tNWpR1tt/GRmugQwABzCzUpejzXBegEIu5UvaULSMZvHB0H
X-Google-Smtp-Source: AGHT+IHbCCui6ZKB/GXsi4frRAPCbIqN2s04w/9+nqMtxHLIvrzvqQlWWxzQN+FYwKi/P3fUX1a+oQ==
X-Received: by 2002:a05:600c:3106:b0:420:28c7:7260 with SMTP id
 5b1f17b1804b1-4212e075761mr12383245e9.21.1717146538559; 
 Fri, 31 May 2024 02:08:58 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b85c628sm18926505e9.25.2024.05.31.02.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:08:58 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fb3dca59-bacf-4457-b1cc-d751750de161@xen.org>
Date: Fri, 31 May 2024 10:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] hw/xen: Remove declarations left over in
 'xen-legacy-backend.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-2-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> 'xen_blkdev_ops' was removed in commit 19f87870ba ("xen: remove
> the legacy 'xen_disk' backend"), 'xen_netdev_ops' in commit
> 25967ff69f ("hw/xen: update Xen PV NIC to XenDevice model") and
> 'xen_console_ops' in commit 9b77374690 ("hw/xen: update Xen
> console to XenDevice model"). Remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 3 ---
>   1 file changed, 3 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


