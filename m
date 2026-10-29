Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C533606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hYUrqfnt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQXt-0001QJ-JJ; Thu, 29 Oct 2026 09:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQXX-0001Oc-VV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:51:41 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQXV-0002h2-I5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:51:34 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b0d91601bdso5852897b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281892; cv=none;
 d=google.com; s=arc-20260327;
 b=ryN3y84KJUXcJK6OGA9Oc1AfO3seunIb1lW8z4s1kAw0b9cqaUjpxv0MARZp//J3j/
 gO28jjGNCHE71k9TZm5snuoFlzUEhZa4NiiwjQNIaKe+f8B8Pztw3Wu6Iky81rs01YsD
 dG6ZrH5mNMrBPq+DabKGwlA1E3zQ8imiTN7NcLjQRBkofXjQBnorJc/iEaIpCUCmpX6k
 EuPCEFfOTELs2FHdFNrjKuaOMXeJXj+xxMSCjSKYd5VUG01zY9KJi7TTYYuZqqWZ+Pry
 V5fUy8fhDEUiMBP74IRgmyECFAZgBTvwzE0qb4uV5V04bcllO6oVslrO3fWQEnTeBUXz
 xmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CIkXcxf8+PJyHV4D3teiTigQGSh14bpq+BCbZy3Omd8=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=O4cEITs2TR8tZV5+dKAcaYJN64CNiETP53lDBSw9ASqMNP7LIgMRZeQYfETCWoiDOe
 DdMB3IwA5ZObJq23iDG7zF8oqtbew+S1AQOIr4I631OjGTngusAkC7H9rVP6+N7vWv6X
 eY5ZO35hcwFc2QIWeaHWP3ekd+C52m5BTZc0pzNlSx+lryXf/0AtGQlKM/hmMfzRtrq8
 3dTEACu7DcBfEdxojTO6LZgwrNMe0Pyn9nuXm2t0S57fxfpXPstjMvQC8WchMUHO4pup
 TBXmrdHuuqOdk9ogBdK7GD1hXEKypvriDWcyEz1X9dsvwGOhbuDkOy1dATYFW1x5QW7v
 yjzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793281892; x=1793886692; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CIkXcxf8+PJyHV4D3teiTigQGSh14bpq+BCbZy3Omd8=;
 b=hYUrqfntoIuB7b5dmMTl3pR3xIXJmHaY3j1j3MdfAv9XAQkAEG241JmbqWiahNl9fX
 Li9yFnvLgefaVNVaQFwwrJI+KfpHHXTkhdltXfjzX6rsH7mpOLENLJTML7bER1PvRgtF
 Yj0DuJ+p8ntj0vX+gsYtLNvkWJKEHapb/4kfnq5FLrRFx4+uXkssMTdJhK8/EYtU830U
 9eOGg1/NIgJD3EeB/DXPH3kn9iv6Vt9wi1bxDe0buHtbvwq0GTUHzyl/E4FnKhWdbc+b
 4GrF2YZXTuwsCGZo6WegZeiQ0e6VGroV8rIBrkpeo6vkQMbhprH86RGfjuwrk+RzhL9J
 WMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281892; x=1793886692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CIkXcxf8+PJyHV4D3teiTigQGSh14bpq+BCbZy3Omd8=;
 b=e4xaeWSbHaYzVKFBBFkcAGOPdbreJYZ3v3PXxKckBnUYmuk7HkPkMpfeJjaLHIqFvA
 XbWS7Ye9hw1cT2tBgOxnW9mNwUYzB/s5N2GUEzxYIiDVYn1ob2ZWPllq73cwq05RvM6L
 ZF9AKk7vN2adQMCx7oZSEFXV3jG+XewHyM4l3C7ZGNDKdZvPgYnhdnyq49hCzBDHYYZ5
 GZj8YWWQx1b5FBnY+zl6cyb1rNceB9T1FYwAE1FTdHqEn0kjJugVqggwP28b0kV9un3p
 w3LsvzD67NI2sMG+PbYeS830SaIUPZuRDFGUp0NNTyZrxVevN4Ky8A9ZzA5Rn/XBJgWH
 MQEA==
X-Gm-Message-State: AFq9FYIrLGjlcF+lZwF3awOZiC7pSzmG5TxIImhR88UyTOAVsMo0v6s7
 r1dODR3VWsooopMNA0Z5Y4O3Rcv0jxMOpl+hKeCmNG40VXMGgzeruJBrKlDNQtYpwm5KZ4lTsrA
 FiV0LarBfJksxSO95csf7FtIYPz6riSLDr4CzPeX+qg==
X-Gm-Gg: AYBFou0bNabj+c6nsR3gtPIPqH5xbyDjFtjIZ5MLlfaoIJ24P5RjfWeLZfWe89itk06
 HPqUzd3InpEWJruxaIL42MN0q8z/ak08aoVJ3wG0JRWRLn5uojskad27mCglcxJSOqhXdSlhS/P
 pMoZtHqqZI4MngiWcD4klvlfJSNqQd7rM3+JJUEVLkOagAUOKhBif/ScutfJF04dpMeM3KIcFfj
 TcP9+WeozkrwkA3Fe6Lu0+PdmfRzVLwGxqiuCKUOpvWFZgwrNBfuRvnEbPj2F+kUn7wgYC9rZNG
 lf4p1ow3hDaZhQbaNwYJL/jqe6f9EUaUYS0sRTyORe32/6Rs44+ZNmspD37jG12u5wM6CdVP3Il
 RrkQyGvX9kNXeTP9b8aTdY+mibWUnJefhMTnBr6Me9ToEYC5z8U3gN7OcVjLDPSYR3MEXC2stea
 SzlhagKLGQ9s+7Uq5h2yfB
X-Received: by 2002:a05:690c:c3c6:b0:8b0:9e7c:7b11 with SMTP id
 00721157ae682-8b1c68a8d2amr14447187b3.32.1793281891721; Thu, 29 Oct 2026
 06:51:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <20261027120135.53048-2-mohamed@unpredictable.fr>
In-Reply-To: <20261027120135.53048-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:51:20 +0000
X-Gm-Features: AclHuK8t0COkBkibOwBlpJpUCqipNaBjsqh4sKLnlVPeRXXlKZ_LkjWiX_6JckA
Message-ID: <CAFEAcA8uU2VowVTKhawOYHMChFqKfwxdjY06D5Usgj5yP9aosw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hvf: arm: save/restore SME state only when SME on
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 12:01, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> When SME is disabled as part of the CPU configuration, do not restore SME state.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

