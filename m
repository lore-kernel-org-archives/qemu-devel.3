Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=LfxYGcYN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSVz5-0004Kj-UT; Sun, 15 Nov 2026 03:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xSVz3-0004KR-Lv
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 03:53:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xSVz1-0005xx-Nc
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 03:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794732783; bh=78oux7jPNl7obsgICvDkHC49GJqoI/fuAHAQ5+pvDX4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LfxYGcYNuBRrxpIxIqa/K8rkFNrNjoTWaFz6CgI7HcKanXGMWB6UWJjKMgM0FI9wd
 R2TK5o6MSxs5LjIkc3PBxgyYHvRVrgxQdHBG0eRVIcp6vZf5n7jOYblyiUlb52tsL4
 yp1JxA3zwaPuF7NAdN9IPXvNEmhaSBt0C0GtBO/gW3cCIoY+x4Dg1+iWL+M8v8dRvq
 ks37M4jd5eQoO16VPlqqMRCUjlUQxWxGBtTRR6hmVEEOAkpbOfj4EvM85nqzwr1RH+
 6bTaWLpdh7gFXLyla2jFBSiTtKGwNHXCl/gm88685NXhMv3uL0ccKPkYDaw/yIqUOF
 BgfSpa228hp8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 159291E69DA;
 Sun, 15 Nov 2026 11:53:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DAE0445E72F;
 Sun, 15 Nov 2026 11:53:02 +0300 (MSK)
Message-ID: <b239f6d3-bed9-4d9b-a7f8-c07c3d297cc8@tls.msk.ru>
Date: Sun, 15 Nov 2026 11:53:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/vdso: make the binaries reproducible
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20261111121259.14941-1-mjt@tls.msk.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261111121259.14941-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 15:12, Michael Tokarev wrote:
> Currently the linux-user vdso*.so files are not reproducible,
> because for one, the binaries embed a random temporary file
> name used by the compiler during compilation, such as ccuckKYd.o.
> 
> At the very least, use -pipe to avoid the need to have a temp
> file in the first place - this makes the build repeatable.

> --- a/linux-user/aarch64/Makefile.vdso
> +++ b/linux-user/aarch64/Makefile.vdso
> @@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/aarch64/config-target.mak
>   SUBDIR = $(SRC_PATH)/linux-user/aarch64
>   VPATH += $(SUBDIR)
>   
> +REPRODUCIBLE = -pipe
> +
>   all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
>   
>   LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
> @@ -10,7 +12,7 @@ LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
>   	  -Wl,-z,max-page-size=4096 -Wl,-T,$(SUBDIR)/vdso.ld
>   
>   $(SUBDIR)/vdso-be.so: vdso.S vdso.ld
> -	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
> +	$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian $<
Unfortunately this doesn't work anyway.  I dunno why but apparently
some gcc versions ignore -pipe and still use a random file in /tmp.

Besides, it is still too gcc-version-specific - for example, a more
recent gcc generates additional sections in the resulting binary -
.ARM.attributes, and even symbol referencs - aeabi_feature_and_bits.

Sigh.

Thanks,

/mjt

