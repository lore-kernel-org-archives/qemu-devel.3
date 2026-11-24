Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F7606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XMLPeopM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVob8-0007B9-R7; Tue, 24 Nov 2026 06:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVob4-0007Au-SJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:22:02 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVob3-0006ZZ-39
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:22:02 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67db6d4054eso4854088d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:22:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795519319; cv=none;
 d=google.com; s=arc-20260327;
 b=c+psY8Ac/tnvSSRVmhAJdsY5rjl6YWsg6PiYbP2ypLPDL5OEVh6b97/DJHE/MSywPN
 7szUS86/Eh4Ocy1MeyG0TaKmicbf2ZquQtovlMVpi0CAXhV+ZChSIyLCehyE7X6c91xi
 c2zq0LYqNzeYHJAwn8GE6zb826boyPePBL2AyzilxtwfmswXQKhnzfQijf9IbBTJkH8E
 Wcl3IRqmlRVp5xaMjU9BtaPSzyKNNzdj8w3k1IIzmTcPqik9Q/ZoXjUmvrVagZWxsLBJ
 j5ibIJBc8izQePbgoaVV2hvCJTNb6+50va2j5NyihWpr7M8BXCKXm7NeKLoeIZH6qa8I
 zmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TuGzYmj/Yy4ea5mjbiIT6jiJmdzK3dSPCpy07gNOWNk=;
 fh=OK/ecxOj95/JUC8h0agYNT23pPZ8n8ci89AGBtyMnIY=;
 b=kHt2Usti8iFH2zHCx2N0CX02om1sZzTc/jWmktrQK8D1dNCbe0uj3ppprYtDeBilBu
 CgwjWNlMtEvSR2zpjqu9MDvCax8PwFQs7cDGpkFFtsz4IfAtPHJJz+0ksbpkDLYlSh9a
 wPanj8V4qkNTfrvkhOehzB1aR+MemTf1BVs3yVRhj3q/iTiaAyUtXb178NY0ZvCAUYP/
 qEi9pNEvaHhh+rZ7HOuQZSmlNR2gqzR7UB22PD/froROa88HSYHPhtss+BwjK6v60l6s
 iDUKMAF/wVhP2LcKRjgfxUsIX/38eangTxWCby4b7pKMsTw0/Sw11G5eSTOPf7NfGvWi
 42Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795519319; x=1796124119; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TuGzYmj/Yy4ea5mjbiIT6jiJmdzK3dSPCpy07gNOWNk=;
 b=XMLPeopMrkrl0r4l4ZjcFuRTspuHy2LjgHnZgE07UzJkhAI7lp7F8BPqj4Xyky+N00
 Jzbm3nGeE8aBtAHZuAuhAeowkv4w1mJ90T/P6egs6nOcbdqV8G/D8JSJCV8wPJ26r0PT
 mD9gY6UZT5AKrJvAVtSBb4zL7yadgUUi4CGlPoLPsVWjnCLxVUVpzCltnsaTxUbMGl37
 T8PKtFllFAQbAbPLe3QDRSvkxHJy87avmIsqWb4LdMtWOJWi7Fi/6BzN71RKrA2LYKxz
 keALKGRPnXSEsdGVvFVetv0nKCCaNv5gmPY6tb8JkJbxAgyaZKk3/js22P60EYl5fFWS
 Vxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795519319; x=1796124119;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TuGzYmj/Yy4ea5mjbiIT6jiJmdzK3dSPCpy07gNOWNk=;
 b=AMNcdy+8Xjh/IK7VgKtUyYVbwNaJ6oLGAXroE4WRpOppR+D0l35s6cxW6EWAIGAreY
 xiRGJ035Ul3swO+dqCOJF/BSJO9/frEp1MlAGdIctIHD5F4WBzQPlKSnBrzdZdYBqoad
 e0sbac4XSNw+SarSEVRe9dFbEoY4V7RJEa+Ek8PPOlg0Qr6kfnj/7Wu7myCiSy6Wpes/
 frFXp2TRijmXa4jMPzK6VXTYo4un8X0xcciHjO99rgqm5S1975Uf99pBqKqim85XEjvv
 r4plaifo10eeFlhhYLNze70Uu6JzN7U3XOV3XAJR7/HCYK3H+fBvy9CxY2MZV3XJIvb6
 ligg==
X-Gm-Message-State: APuU4Z+THkH3EZP/s7zr503PQ/UIRXI420uU79qTchIoVC0QH1qYkn1p
 D62A+slZNmSP9q12yO3FVETpmIufd5ieeDI54D3fQ7Xw5iz0EhahOLcKmy3WewmBHOCeGVckiFu
 sLSutIGTTVtYuBZJW7u7guxKgLVtQGh1BR93li4OLcQ==
X-Gm-Gg: AZFdTZcXUQUb2wY1wRQG8T8/iSjrtuhkF+xP3218DAwMv32ci1fR2ls74tjr/RwlAcB
 0BMTZv77Tsuqr0hPOywq0V4meje8tFlL0OwNCXDtDmNk7BNjPxzTVxKcL4SNGBfZSR31c2PQP1Y
 7knlRVmSt0/EOILB/ehmKm0lpVY7dXPn0920Jaq/v3XEGqT0JNl2dIOmCCGNQJjaBD32l0Ejeq9
 qG8mRkJUOm8gs85eoauFN4SjldosiUSHyEJwPaUeUMRjQs+5pkNyFnB5yPPWgbFeYkU/FnNOPD2
 KL14iZWKCuZv+2RRJg5NytwfahcMEdmXsIyEQ7Am3TQAuLawCjCDWZZQwEBlzKb4q6xT6bOWtjt
 2BItc/TL4/C8+YkgLo4yqCDv5mGInbcnZAp0wDmN+dI8M5EcHBpYqmeQgf/93+lIIB8o26Sjsbe
 OCP2FGScUVSZyJnA3HR6Ye
X-Received: by 2002:a05:690e:d49:b0:67d:c1a6:1d0e with SMTP id
 956f58d0204a3-67df4487eafmr5026714d50.94.1795519319111; Tue, 24 Nov 2026
 03:21:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124110938.1480880-1-pbonzini@redhat.com>
In-Reply-To: <20261124110938.1480880-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:21:47 +0000
X-Gm-Features: Aa3M54ojk-p-TS0R6NyOkT4YpL2watc2uMuEg_ipWG6rsaPzt-umzhEGmL2v4mE
Message-ID: <CAFEAcA85CNvFpOG=eaP4KNbFEvd-6Genb62X8ODK3v7hajA3gw@mail.gmail.com>
Subject: Re: [PATCH v3] hostmem: allow building without KVM support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 11:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Michael Tokarev <mjt@tls.msk.ru>
>
> On architectures where KVM is not available and so including <linux/kvm.h>
> does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:
>
>  In file included from backends/hostmem-memfd.c:23:
>  linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>    16 | #include <asm/kvm.h>
>
> Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
> when KVM is enabled, and guard the actual code using memfd definitions with
>

This seems to be the truncated version of the commit message
rather than the corrected one from MJT's v2 patch.

> Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Link: https://lore.kernel.org/r/20261119111050.1203459-1-mjt@tls.msk.ru
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build              |  3 +--
>  backends/hostmem-memfd.c | 10 +++++++++-
>  tests/qtest/libqtest.c   |  2 ++
>  3 files changed, 12 insertions(+), 3 deletions(-)

The code changes look OK, so otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

