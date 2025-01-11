Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773EEE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 22:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWjep-0001mo-1f; Sat, 11 Jan 2025 17:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1tWjen-0001mg-44
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 17:08:37 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1tWjek-0004sR-OV
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 17:08:36 -0500
Received: from [192.168.178.96] (p57b4248b.dip0.t-ipconnect.de [87.180.36.139])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id AF350DA0795;
 Sat, 11 Jan 2025 23:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1736633311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nH8QJ3iFpmm2taBx7sgznpYSi6spGtsjtMK14A7WqDE=;
 b=VmJJKNZKyFfdZFu6qORufYaEIoJHHt81G/Fj0w7uGvt6jtLIGjfeNCqBPY+EwTkSwA+1RI
 aAZpVlA+F7OvzUJexnsie1V402LAUnzm+9szeXfI/X609ND22RmfcxlBn32SEkUuUXmOxv
 vFAW9hxao2rn5KazkxkooYR4R2QIhK4=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de
 smtp.mailfrom=stefan.weil@weilnetz.de
Message-ID: <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
Date: Sat, 11 Jan 2025 23:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
Autocrypt: addr=stefan.weil@weilnetz.de; keydata=
 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
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: AF350DA0795
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.60 / 12.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWELVE(0.00)[13]; TAGGED_RCPT(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_COUNT_ZERO(0.00)[0];
 ASN(0.00)[asn:3320, ipnet:87.128.0.0/10, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org,crans.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[patchew.org:url]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71;
 envelope-from=stefan.weil@weilnetz.de; helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Stefan Weil <stefan.weil@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 10.01.25 um 21:33 schrieb Pierrick Bouvier:
> For now, it was only possible to build plugins using GCC on Windows. However,
> windows-aarch64 only supports Clang.
> This biggest roadblock was to get rid of gcc_struct attribute, which is not
> supported by Clang. After investigation, we proved it was safe to drop it.
> 
> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
> hosts.
> 
> v1 contained warning fixes and various bits that have been upstreamed already.
> The only bits left in this series are the gcc_struct removal, and fixing the
> plugins build with clang.
> 
> This series is for 10.0, as we decided to not include the gcc_struct removal is
> 9.2 release.
> 
> All patches are now reviewed, so this series can be pulled. I'll report that to
> MSYS2 too, so we can enable clang environments for QEMU.
> 
> v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
> 
> v2:
> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
> - add a section about bitfields in documentation
> 
> v3:
> - explain why gcc_struct attribute matters in packed structs in commit message
> - reword the bitfields documentation with suggestions given
> 
> v4:
> - edit for bitfields doc requested by Philippe
> 
> Pierrick Bouvier (3):
>    win32: remove usage of attribute gcc_struct
>    docs/devel/style: add a section about bitfield, and disallow them for
>      packed structures
>    plugins: enable linking with clang/lld
> 
>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>   meson.build                               |  6 +++---
>   include/qemu/compiler.h                   |  7 +------
>   scripts/cocci-macro-file.h                |  6 +-----
>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>   contrib/plugins/meson.build               |  2 +-
>   plugins/meson.build                       | 24 +++++++++++++++++++----
>   tests/tcg/plugins/meson.build             |  3 +--
>   8 files changed, 48 insertions(+), 26 deletions(-)

This nice series allows building QEMU for Windows with the LLVM cross 
compiler on my ARM64 machine, so you can add

Tested-by: Stefan Weil <sw@weilnetz.de>

I only needed a trivial additional fix in scripts/nsis.py for `make 
installer` because the usual GNU objdump and the LLVM objdump (or the 
cross x86_64-w64-mingw32-objdump in my test) produce slightly different 
output (indentation with \t, indentation with four spaces). I'll prepare 
a patch which eliminates the need for objdump, so no intermediate fix is 
needed for this.

Stefan W.


