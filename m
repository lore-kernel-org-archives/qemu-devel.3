Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5467DC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 11:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU3Ts-0008Sc-V5; Sun, 28 Jan 2024 06:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU3Tr-0008SH-9K
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 06:37:43 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU3Tp-0006GQ-Fl
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 06:37:42 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ba903342c2so87877339f.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706441859; x=1707046659;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fYDFaq2gXQnaGH5NyOWen9KnObV1D1c1v0kq27G9/ps=;
 b=OSbzeWhuYfKXvMCjx7WJX+0MXAt0Jz4zdzWxCJB5Cg2lq3/GDs7fFLHj4BzCoqD2eF
 YTSqjtKwsWfS9u+D12cwqD2uv/GS6CWCvvpBhX2BHupQCidsnFRS6D8r2i4lStfYksr6
 IhY03xwqFIgx+LQAKWlZ7r1Ne4JKNMJk7XBaxF8k4X2Tv92+VXRRfbo2HwQc82tMsQG4
 UUw6Ez2fT+UbKrmSPMgm1jEq1m8s8aHTqnxjrG3AW8Ix3RJBwnmmuUCQdvEIiCuf63G+
 Ywomg7lYolh8P4oME5P5xI51q55RUD2gOTivbexmL+XcVz0Tklv7FpCs841+A3RXdgw/
 HVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706441859; x=1707046659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYDFaq2gXQnaGH5NyOWen9KnObV1D1c1v0kq27G9/ps=;
 b=SLDB8jFlws2Vbtk2jk+of2KX1NOc76wO1sfKCST+rDJJPJq3FS9oRUx7Ls/Y7Hmd4T
 UpgxffOirOMueqW1kJ0J9jh8Nfg+/TgjBC4cGji9/7zwB8rQATqkXubzhyMCpkkLBv5K
 yyWY+mvy2gYejlsRvJSJ6H/su5zzKQVwebhUTHEVuU3udT1HzONaCZMxUl10e88v5f/p
 1wxgUrHwiFlrbBdy7+2yobpLvh2k5bMf6BYrRXMcNRI72Nr8WPVytcGL+31QI8Syjdeq
 7p+/6AaUkTOsuPWExaPcGnWEDJUtU1Uf3ZUrHZCHh6sPw3KjIQNT41BFvLz/tHlEYfkF
 LEiw==
X-Gm-Message-State: AOJu0Ywqg1+rkZJKHGlTd76hzdkFqSzM3Y8U7tBDSlEqLsM4n0TAUIVJ
 Y3EW3GkRLI3kIAjjseTnaKQt1Yu6P0I3V7aSiHq/UDefZJzurTDHPiQIGEQKK3o=
X-Google-Smtp-Source: AGHT+IE6qRMZR6c8vFcuOimUseXFPpSPuI6jofoUlM0BTF3TBOXE0BfYaw94BTFDYEL7cPpgovcP1Q==
X-Received: by 2002:a92:c5ce:0:b0:362:b732:98f2 with SMTP id
 s14-20020a92c5ce000000b00362b73298f2mr3328131ilt.11.1706441859578; 
 Sun, 28 Jan 2024 03:37:39 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 li14-20020a170903294e00b001d74048eb5dsm3580615plb.89.2024.01.28.03.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 03:37:39 -0800 (PST)
Message-ID: <9ef70fe4-6c0f-4504-821a-dda22d8c6c3a@daynix.com>
Date: Sun, 28 Jan 2024 20:37:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: fix link state on resume
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20240124104006.335166-1-lvivier@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240124104006.335166-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/24 19:40, Laurent Vivier wrote:
> On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
> 
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
> 
> Reproducer:
> 
>     # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S
> 
>     {"execute": "qmp_capabilities" }
>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>     {"execute": "cont" }
> 
> To fix the problem, merge the content of e1000e_vm_state_change()
> into e1000e_core_post_load() as e1000 does.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-21867
> Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>      v2: Add Fixes: and a comment about e1000e_intrmgr_resume() purpose.

Thanks for taking care of this.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

