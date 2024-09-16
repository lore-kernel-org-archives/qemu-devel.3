Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqD0I-0000oP-M1; Mon, 16 Sep 2024 10:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqD0B-0000n4-2O; Mon, 16 Sep 2024 10:46:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqD08-00021y-9P; Mon, 16 Sep 2024 10:46:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A34208F642;
 Mon, 16 Sep 2024 17:46:26 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B41B13D729;
 Mon, 16 Sep 2024 17:46:40 +0300 (MSK)
Message-ID: <3b104a43-ec9f-4a43-a554-6c5529ae1913@tls.msk.ru>
Date: Mon, 16 Sep 2024 17:46:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/ui: set swap interval explicitly when OpenGL is
 enabled
To: gert.wollny@collabora.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11.09.2024 12:14, gert.wollny@collabora.com wrote:
> From: Gert Wollny <gert.wollny@collabora.com>
> 
> Before 176e3783f2ab (ui/sdl2: OpenGL window context)
> SDL_CreateRenderer was called unconditionally setting
> the swap interval to 0. Since SDL_CreateRenderer is now no
> longer called when OpenGL is enabled, the swap interval is
> no longer set explicitly and vsync handling depends on
> the environment settings which may lead to a performance
> regression with virgl as reported in
>     https://gitlab.com/qemu-project/qemu/-/issues/2565
> 
> Restore the old vsync handling by explicitly calling
> SDL_GL_SetSwapInterval if OpenGL is enabled.
> 
> Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2565

Is it a qemu-stable material (8.2, 9.0, 9.1) ?

Picked it up for now, please notify me if I should drop it.

Also please notify me if I should pick some other changes
for -stable.

Thanks,

/mjt

