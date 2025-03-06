Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCC0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq6q4-000384-9X; Thu, 06 Mar 2025 03:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1tq6q2-00037t-SM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:44:19 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1tq6py-0002rj-Ll
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:44:18 -0500
Received: from [192.168.178.101] (p5b151561.dip0.t-ipconnect.de [91.21.21.97])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id C817BDA0270;
 Thu,  6 Mar 2025 09:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1741250649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6Xdc+0nfTFltfZ0skq3v3vXp3lUGmQd00DydpgHWNts=;
 b=CHUnMzcZlB0i0y7xk1YtZ7HuMyigpwlW6UGj7EeAMTpjdCgulz3/gFdFYznaqUOFmxEx6N
 LXDK80cDb0uBi0TkdWLA07uYa5xixrVX1dh0I5Yr31C3NdmwTZq+8Im6tNWayjDrHztqFh
 Dzl8UmfR6xWtO/VOePtnbOxV64u3VGs=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de smtp.mailfrom=sw@weilnetz.de
Content-Type: multipart/alternative;
 boundary="------------htB0TgyZVHWnP5i4qdVzhWU1"
Message-ID: <125e287a-d887-40a8-9193-eefc242d5596@weilnetz.de>
Date: Thu, 6 Mar 2025 09:44:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] download/windows: Drop link to 32-bit builds,
 add aarch64 instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250306080557.681538-1-thuth@redhat.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <20250306080557.681538-1-thuth@redhat.com>
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: C817BDA0270
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 12.00]; BAYES_HAM(-3.00)[99.99%];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 RCVD_COUNT_ZERO(0.00)[0]; MIME_TRACE(0.00)[0:+,1:+,2:~];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------htB0TgyZVHWnP5i4qdVzhWU1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 06.03.25 um 09:05 schrieb Thomas Huth:

> QEMU does not support 32-bit Windows anymore, so we should not
> tempt the users to download old builds.
> OTOH, there is now interest in Windows build on arm computers instead
> (see e.g.https://gitlab.com/qemu-project/qemu/-/issues/2850 ), so
> let's add a link to these builds instead.
>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   _download/windows.md | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/_download/windows.md b/_download/windows.md
> index 8ce3f0d..f97d216 100644
> --- a/_download/windows.md
> +++ b/_download/windows.md
> @@ -1,6 +1,6 @@
> -Stefan Weil provides binaries and installers for
> -both [32-bit](https://qemu.weilnetz.de/w32/) and
> -[64-bit](https://qemu.weilnetz.de/w64/) Windows.
> +Stefan Weil provides 64-bit binaries and installers for Windows on
> +both [x86](https://qemu.weilnetz.de/w64/) and
> +[arm](https://qemu.weilnetz.de/aarch64/) computers.
>   
>   **MSYS2:**


Please let us wait a bit until someone confirms that the ARM binaries 
for Windows really work.

There is currently only a single experimental installer on 
https://qemu.weilnetz.de/aarch64/. I cannot test it myself because I 
don't have an ARM basedWindows available for some minimal testing.

Stefan

--------------htB0TgyZVHWnP5i4qdVzhWU1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Am 06.03.25 um 09:05 schrieb Thomas Huth:</p>
    <blockquote type="cite"
      cite="mid:20250306080557.681538-1-thuth@redhat.com">
      <pre wrap="" class="moz-quote-pre">QEMU does not support 32-bit Windows anymore, so we should not
tempt the users to download old builds.
OTOH, there is now interest in Windows build on arm computers instead
(see e.g. <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/issues/2850">https://gitlab.com/qemu-project/qemu/-/issues/2850</a> ), so
let's add a link to these builds instead.

Signed-off-by: Thomas Huth <a class="moz-txt-link-rfc2396E" href="mailto:thuth@redhat.com">&lt;thuth@redhat.com&gt;</a>
---
 _download/windows.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/_download/windows.md b/_download/windows.md
index 8ce3f0d..f97d216 100644
--- a/_download/windows.md
+++ b/_download/windows.md
@@ -1,6 +1,6 @@
-Stefan Weil provides binaries and installers for
-both [32-bit](<a class="moz-txt-link-freetext" href="https://qemu.weilnetz.de/w32/">https://qemu.weilnetz.de/w32/</a>) and
-[64-bit](<a class="moz-txt-link-freetext" href="https://qemu.weilnetz.de/w64/">https://qemu.weilnetz.de/w64/</a>) Windows.
+Stefan Weil provides 64-bit binaries and installers for Windows on
+both [x86](<a class="moz-txt-link-freetext" href="https://qemu.weilnetz.de/w64/">https://qemu.weilnetz.de/w64/</a>) and
+[arm](<a class="moz-txt-link-freetext" href="https://qemu.weilnetz.de/aarch64/">https://qemu.weilnetz.de/aarch64/</a>) computers.
 
 **MSYS2:**
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Please let us wait a bit until someone confirms that the ARM
      binaries for Windows really work.</p>
    <p>There is currently only a single experimental installer on <span
      style="white-space: pre-wrap"><a class="moz-txt-link-freetext" href="https://qemu.weilnetz.de/aarch64/">https://qemu.weilnetz.de/aarch64/</a>. I cannot test it myself because I don't have an </span><span
      style="white-space: pre-wrap">ARM based</span><span
      style="white-space: pre-wrap"> Windows available for some minimal testing.</span></p>
    <p><span style="white-space: pre-wrap">Stefan
</span></p>
  </body>
</html>

--------------htB0TgyZVHWnP5i4qdVzhWU1--

