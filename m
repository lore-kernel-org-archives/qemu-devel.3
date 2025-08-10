Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C02EC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 07:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul0VQ-0000Mk-K9; Sun, 10 Aug 2025 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ul0V3-0000Go-Qk; Sun, 10 Aug 2025 03:29:51 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ul0Uz-00011C-Jj; Sun, 10 Aug 2025 03:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=cnpd//lMFhpfBHQxgABnsEmyC3bJQgsaUr5QPOrI5Wg=; b=UCrdq319lgRQxdnx8k00
 3e+C/MBEUCFbgm9974tsaYC/WUC8vRuUtZUCcXxMT8n1EGz28SKja1xSedVIYRqckF/Edhiv8rTbR
 V8R8loGoolvYYcKSDk6oLZr/deSFnoU6w5PqF8kYNQlRIE+d4OH3QTRM6opAxKMFVHj/P7dOCAxdY
 xwG9kE0W43FpCBOMn+YdJ0KhvxzQKXQB0LSMznpIjz2qpWnG/C5CGaBilpuT8EZA4QQbqok7to1JH
 OKgw5dWsI92OGoiBPwymPFApdUB4n10VMAtK5CZlmCR4PIY80sTAYq5+1JbXslcsgu5r00+01R7Rn
 +WvprWG0F9r5cQ==;
Date: Sun, 10 Aug 2025 09:29:41 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, rent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] chardev/baum: Fix compiler warning for Windows
 builds
Message-ID: <aJhKZcIBLRj8SWzC@begin>
References: <20250809061302.596931-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250809061302.596931-1-sw@weilnetz.de>
Organization: I am not organized
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

Stefan Weil, le sam. 09 août 2025 08:13:02 +0200, a ecrit:
> Compiler warning:
> 
> ../chardev/baum.c:657:25: warning: comparison between pointer and integer
> 
> Use brlapi_fileDescriptor instead of int for brlapi_fd and
> BRLAPI_INVALID_FILE_DESCRIPTOR instead of -1.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
> 
> This is a rather old patch which I now use since more than two years
> to support Braille with QEMU on Windows.

Just curious: what do you use this Braille support for?

Samuel

> It's a hack (because Windows uses a pointer (64 bit) which is
> assigned to an int (32 bit), but it seems to work.
> 
> Regards,
> Stefan
> 
> 
>  chardev/baum.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/baum.c b/chardev/baum.c
> index f3e8cd27f0..5c3587dda5 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -94,7 +94,7 @@ struct BaumChardev {
>      Chardev parent;
>  
>      brlapi_handle_t *brlapi;
> -    int brlapi_fd;
> +    brlapi_fileDescriptor brlapi_fd;
>      unsigned int x, y;
>      bool deferred_init;
>  
> @@ -654,7 +654,7 @@ static void baum_chr_open(Chardev *chr,
>      baum->brlapi = handle;
>  
>      baum->brlapi_fd = brlapi__openConnection(handle, NULL, NULL);
> -    if (baum->brlapi_fd == -1) {
> +    if (baum->brlapi_fd == BRLAPI_INVALID_FILE_DESCRIPTOR) {
>          error_setg(errp, "brlapi__openConnection: %s",
>                     brlapi_strerror(brlapi_error_location()));
>          g_free(handle);
> -- 
> 2.47.2
> 

-- 
Samuel
/*
 * Oops. The kernel tried to access some bad page. We'll have to
 * terminate things with extreme prejudice.
*/
die_if_kernel("Oops", regs, error_code);
(From linux/arch/i386/mm/fault.c)				   

