Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F0DCF6D2C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzlt-0005Iv-BY; Wed, 02 Oct 2024 09:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svzll-0005Ib-Bs
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:51:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svzlj-0002i2-FU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:51:57 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLyvH-1se3F411DV-00Mfo7; Wed, 02 Oct 2024 15:51:47 +0200
Message-ID: <b7b893d6-48b5-4eb5-95e4-50af746ddf4f@vivier.eu>
Date: Wed, 2 Oct 2024 15:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload.c: keep GNU0_MAGIC in host byte order
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241002091119.995467-1-mjt@tls.msk.ru>
Content-Language: fr, en-US
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241002091119.995467-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4H5TOe7i3RykBiRB/wdbTDRVTlOsY2l33Vzh5VEBhvSs0d6hkEh
 m/kJ0ocN7Eu4loPQdYvcV30+vE4IzYJmsbUZHkA4+lImU/S6C2cCC2VRPeut+DhSpvGy+cI
 TNGyTDxGKFMHsMlL0UO3A8Qwte+q0Fbp0tPjofcHn/J5ssxwuXJsU0VEs8mpgrbqGIMDcOY
 WIVE6bMboXPy81rMhQgbA==
UI-OutboundReport: notjunk:1;M01:P0:HR+OfB8Yb6o=;I/W7Yzkhpn2mw/0x56PA1kIOraY
 Zu2eUVFGzjXj2Hw6+mxI8lRX2B2jrY7kjuODkzqb2GL3EZKo7OHQkEpUf/503oMnZBkH6n/K3
 6JjiW2ZqD6VY/nFeRrWlNNGUOoHp5ZMOzUaUl/9SPu2hkAP8IVh5Ceow8i+rEus/ebQnM46nv
 PYATL38UeMiqxx+ApTgAahga+tzTpRFaW7uFwWQ54jeJytZ61JfO0Nw0G67Uj2y5x4Z57j6jm
 00kxZsZSdhLk3z3mAMR6Q5f0IhzB+R/vVWXdoi0l1zc5BICFmuQRHy4avKF2xMJR6Kamh4lew
 CmlGX1lT/QhQIIRAEFLJzY1OBGSwtEfZX27oQi5YznQfFEFQdGlgbwJmHxsbWMCxL7qpcHLap
 RRXrKSP5xUZAElGbB8d3HvwrVhH53kDKyCMBj0iRCwkwWdzea+xf09C3m25OcWLUuvJxKYmB5
 KZIyxZTPSrb3gZAf/WoW19srr+3DDwaZdwRQRi1f/sFOyvbflkpoP/lr7LiRpunc42AGzuEAO
 heQ+7LIupObXKifI3BUiP6F5Nbj3wotyYXEQhiL/tix/ViO6+0J7JyrZNE1Vbli/Zjl3rWkLR
 iU/Qe493BFLSOzpfCUCDOX7eO9KktT29852RZ2efz1772Xz2OySg/QdyGcmleohqX6YSs9fnP
 c7icrXWN30UfYzsq2g2+iCIhfbNzcUe6NLFD99a9RhlEV6vWPyoh0ewk+a8kWkEyZp2OCOVVO
 OszIa++RUQBITeVyYHvGxKxfpYLopJX8w==
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 02/10/2024 à 11:11, Michael Tokarev a écrit :
> Other places of this file operate in host byte order.  Only
> this constant is defined as little-endian.  This does not
> work, for example, on s390x host when running an arm64 binary:
> 
>   qemu-arm64: /usr/bin/busybox: Invalid note in PT_GNU_PROPERTY
> 
> This change is tested on all combinations of host/guest for
> which debian provides release architectures, namely:
> 
>    amd64 arm64 armel armhf i386 mips64el ppc64el riscv64 s390x
> 
> Fixes: v5.1.0-2580-g83f990eb5adb "linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes"
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0678c9d506..1c54c556fc 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3028,7 +3028,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
>   
>   enum {
>       /* The string "GNU\0" as a magic number. */
> -    GNU0_MAGIC = const_le32('G' | 'N' << 8 | 'U' << 16),
> +    GNU0_MAGIC = 'G' | 'N' << 8 | 'U' << 16,
>       NOTE_DATA_SZ = 1 * KiB,
>       NOTE_NAME_SZ = 4,
>       ELF_GNU_PROPERTY_ALIGN = ELF_CLASS == ELFCLASS32 ? 4 : 8,

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

