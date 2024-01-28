Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A139EC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 11:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU3T3-0007el-FZ; Sun, 28 Jan 2024 06:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU3T0-0007cm-Uh
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 06:36:50 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rU3Sz-00069x-1J
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 06:36:50 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d7881b1843so17119365ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 03:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706441807; x=1707046607;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kM9WFGy6NbvbGAvzzxR9vAHBKJx+VI6tCNuaTSRC++4=;
 b=OjBPDQ725jQhf9+bG5rKTVuQ7Bvp/KTnTERIVUfSRnHh+eRGG/kJfZdcuqGbySnFK7
 Z7OgDTh+XBWVPZlNpNEyHL0l6CAq8jWlTyewpgF5H5vO6cRSuL8qbbEBQPxpIWO9h4jb
 82OOnDBgHTQMbDRC1oYOg2znzK1CrWQWRXMFx7gv0c5igl5cOpprWGnPS10InvQozQ3l
 wo4XWwgvwVSFtszwgjDt/Pro8X9V72r6zKJPSU+Q6xsVQGdU1jw8vSMb8R6nfiPA1IUO
 nw5oCSXLUCsup+u7TsmLIpEwcFjs2vDnwRSF8hVhOCBOW9fnXST/cJruQaZa21S6iA2q
 oGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706441807; x=1707046607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kM9WFGy6NbvbGAvzzxR9vAHBKJx+VI6tCNuaTSRC++4=;
 b=bx7ZIjzeeK3R7ctSVphjqzL0HlfJ+Fii3xfE27cqzsVlTn11eCSzJLCUFpDPmDWe8i
 svi6Vp56HbeA9JK2IG4d9J4+uENJ3gQWP4hpZsh5jWlM+/qtl9mWCCV5YodPvCScDmDh
 TLo5STqPCGhavJgtOeSoua5W4R1jacJ6uwlDbgKnii1dlIML0X1lbCwu2WfxY7mMEJdr
 9Q+IvSvH3tvbHK+SythvqrelgIS82u3sJs15+ZjgvtotFdRQjVaKWKgVdbh9d42iq8h+
 udlEXrACOUAimLBby897OgSDmXWPbCkF/BmiWMF7dGljpsH2p/wj/Ok/0GO/UhO93Pcm
 8JaA==
X-Gm-Message-State: AOJu0YyOwJQyH9QXNdhbPInoE97HL+01Tpr3YvSb0MUiUXpW9KzA7WMa
 jRrrnacbuiUyZExuBSGmYbpj/eSk8YHOMZeA+efhLnphMbtpqyI+IhE2MZlb0bk=
X-Google-Smtp-Source: AGHT+IHV4pKf4ebx+YLHF6VmwLpEZdSZHqoez3BfM92btXKgU0w7baqzlmL4K4D9XspVQ54Bx+fESA==
X-Received: by 2002:a17:903:184:b0:1d7:49a6:a0c8 with SMTP id
 z4-20020a170903018400b001d749a6a0c8mr3827840plg.106.1706441806768; 
 Sun, 28 Jan 2024 03:36:46 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 li14-20020a170903294e00b001d74048eb5dsm3580615plb.89.2024.01.28.03.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 03:36:46 -0800 (PST)
Message-ID: <caa6524d-8629-4978-b7bd-cf60f088d27d@daynix.com>
Date: Sun, 28 Jan 2024 20:36:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] igb: fix link state on resume
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20240124102904.334595-1-lvivier@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240124102904.334595-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2024/01/24 19:29, Laurent Vivier wrote:
> On resume igb_vm_state_change() always calls igb_autoneg_resume()
> that sets link_down to false, and thus activates the link even
> if we have disabled it.
> 
> The problem can be reproduced starting qemu in paused state (-S) and
> then set the link to down. When we resume the machine the link appears
> to be up.
> 
> Reproducer:
> 
>     # qemu-system-x86_64 ... -device igb,netdev=netdev0,id=net0 -S
> 
>     {"execute": "qmp_capabilities" }
>     {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
>     {"execute": "cont" }
> 
> To fix the problem, merge the content of igb_vm_state_change()
> into igb_core_post_load() as e1000 does.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-21867
> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
> Cc: akihiko.odaki@daynix.com
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>      v2: Add Fixes: and a comment about igb_intrmgr_resume() purpose.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

