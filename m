Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38921C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCywQ-0005Ea-37; Fri, 31 May 2024 05:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCywO-0005Cm-C9
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:52:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCywM-00041A-O0
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:52:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35dcc681f70so683272f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717149169; x=1717753969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hf6kJtuim518JzfO4xCI8JR2wSGNLAwFB/Bm4BXuuKY=;
 b=lZa7CteaADH1sTV3YxXtMn97AVtAVmA/B1AFtXVO0IsPwUPpwd6dABWmnlBzibFUL0
 kzJPKmoQ4zAuViHJ5jrF+1yg/aexLt1OX+QSoXl3hy1i68KBbx15V/NSn/my0pustWT5
 AeurN6yo26J1zaLYstQ67pdqQKyd6gYoQr7Li8jegdIcVHVjBzGDsdTR6U4hmNhCqJRJ
 sTfkJySVXO9bYd5C4Vc67f6RNJ4qaA8QIqm54R+wvzjt0Yw+6COn65uyp/FyAwyrGpsW
 8RsTVQCHakqXzclXBaXxXnd/OBtjjrPFR/IcjtQVnqtfMAJ64vGzOVUQVur9MnTbNOFk
 Hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149169; x=1717753969;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf6kJtuim518JzfO4xCI8JR2wSGNLAwFB/Bm4BXuuKY=;
 b=q7Zdlh3avp0wAIUmKUoC/6mDnwQ/uFI1ulKPwyUH+nFEZOD5HNPYChF35QvxXD60vn
 4iUX8NFxIPs80bkc0Evc7D0CBiDIIK0ITv5tdAJeYGlctwqNCcLKPE9qkQajED9IaoNQ
 QGXUnC1cNPLO8nts3YwU4e5IvwrANUQOUeTrg7GkMcX3b4LpuPOD7XNHpCjk4IMBa791
 DCLXpJ9Y0AVT3rIAQPDwt/DDI7PnvsMmM3a+6e6jIFt/G6TLpRfg/kblaC1iywe3J4An
 WgTWLXr+nt5akv6/Pgg0svrTYD9pdvttUPpw1r/Xhq9NbWpXiplWNZ+rmYO7NVZfk8BE
 TgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO0msRYCj0sl6VB+NnZpskagnSeHKqs9yRIbMYi3nxCqgK+57VLDSkK/WUEScqfg9ktitHka01JZ4PZbDxw80SYI6HzC8=
X-Gm-Message-State: AOJu0Yxi+6BM4niBxxaS52v3AWwQqOegaG3OmvEbqwsfMqlnPPWAY7Yk
 8/6XKuGt5m9OO5RtU766Dzy7vyhqimx0oUSLvBQ938blLCxLrQEX
X-Google-Smtp-Source: AGHT+IEmAqd0XCpRFy8zmJwHnoCNgGkDW2xaUrnVWSz6NQR69vAe7JyIAXDN4o/nuWE0i9HYxGE4Aw==
X-Received: by 2002:adf:face:0:b0:34c:d5e8:faad with SMTP id
 ffacd0b85a97d-35e0f337d0dmr844739f8f.58.1717149168693; 
 Fri, 31 May 2024 02:52:48 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caf05sm1456441f8f.42.2024.05.31.02.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:52:48 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3c1d9624-90d4-4248-97ac-4bfea2ee273c@xen.org>
Date: Fri, 31 May 2024 10:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/xen: Make XenDevOps structures const
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-5-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42a.google.com
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
> Keep XenDevOps structures in .rodata.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 8 ++++----
>   hw/9pfs/xen-9p-backend.c            | 2 +-
>   hw/display/xenfb.c                  | 4 ++--
>   hw/usb/xen-usb.c                    | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


