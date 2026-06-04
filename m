Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A0CCD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV2Jq-00056D-2A; Thu, 04 Jun 2026 03:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV2Jk-00055v-2x
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:16:40 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wV2Ji-0002hA-3U
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780556231; bh=rXUVXUL8tkdlsGjnPSWc+RhdyZKPv3P+7A2L/HW3h24=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=ZgCsS64d6Wg8ZBcNuhaLjse593qkMUoZg8e1CSP9S3QIi6J/4u3NQZV60hYVR4yLg
 sAWLO1lFAWHzEqoUeUyEgg8Jukx7mYCjqpRtFrWRYPxx3OYcN1pgVglUBEVccgOUj8
 Jz/uKsQZXL6TKdvHZacnQSLTwVreYW6FbC1Z2rv4=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 08:57:00 +0200 (CEST)
X-EA-Auth: ixMrETJmsw2FObfbt3+coCuSPKJ+K0cZriQidlSjxf66FucTySn33e8vFKyjU0aMe8F5r1av3T9GMjgazYkmvWFh5G3+aq2S
Message-ID: <af52feba-f4b9-42f5-991c-ab3ab8163c5d@mailo.com>
Date: Thu, 4 Jun 2026 08:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ui/cocoa: Use qemu_input_map_osx_to_linux
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260604-osx-v3-1-453b4ee0e072@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260604-osx-v3-1-453b4ee0e072@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 4/6/26 08:39, Akihiko Odaki wrote:
> ui/cocoa used to have a conversion table from macOS keycode to Linux
> key code. It is an unnecessary redundancy as ui/input-keymap.c already
> has such a table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
> kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
> JIS keyboards").
> 
> According to the following documentations, the definitions in
> ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
> https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
> https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime
> 
> Use qemu_input_map_osx_to_linux to eliminate the redundancy and
> incorrect mappings.
> 
> Fixes: 708b72557ff5 ("ui/cocoa: Support unique keys of JIS keyboards")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> ui/cocoa used to have a conversion table from macOS keycode to Linux
> key code. It is an unnecessary redundancy as ui/input-keymap.c already
> has such a table. Worse, I added an incorrect mapping of kVK_JIS_Eisu and
> kVK_JIS_Kana with commit 708b72557ff5 ("ui/cocoa: Support unique keys of
> JIS keyboards").
> 
> According to the following documentations, the definitions in
> ui/keycodemapdb/keymaps.csv, which ui/input-keymap.c uses, are correct:
> https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang1?language=objc
> https://developer.apple.com/documentation/uikit/uikeyboardhidusage/uikeyboardhidusagekeyboardlang2?language=objc
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/keyboard-japan-ime
> 
> Use qemu_input_map_osx_to_linux to eliminate the redundancy and
> incorrect mappings.
> ---
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20250115-osx-v2-1-ac3b38d91174@daynix.com
> ---
>   ui/cocoa.m | 131 ++-----------------------------------------------------------
>   1 file changed, 3 insertions(+), 128 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

and queued, thanks Akihiko!


