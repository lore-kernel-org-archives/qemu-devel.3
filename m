Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B18606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EwleL8+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLyH-0005NX-GL; Mon, 09 Nov 2026 04:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQLyF-0005NP-6Q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:47:23 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQLyD-0006qn-LG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:47:22 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67bfdab8f20so287026d50.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 01:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217640; cv=none;
 d=google.com; s=arc-20260327;
 b=BsMSZ8iu0aRPUf1oNjMrH6S2bOylMWl9hxSoVfSScUBpjlv/vY4z/RQcczkPJUTrym
 jZxTrv1PF9svNVjUxSNPDMpembeJME6uXlFRkxY/s4+mD+vSNyeZD2GySiGhQ6M9mTsZ
 5RiuWFfbsIEfV6I38HAeu8sjrdPG6fqGS6zss0mfZcDSJy++WafnFbON+i0Xu3VlEM+B
 lhfLIWzcpUxt1rrBP1lxYbOhTWQOc7aPwW6gCOkaf7138YdGuxcnk09axN15dNilMzDz
 arzEtqKpN7hVvesZyn0FbWhdTOu3lNdt0uVuveexrPcnHE6XVnJFdpZz2rAT4qb5rjsT
 MoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3kMfTQ7C/dhD1+azadgUmL3XUQvh4AQkYCc0Vgs9fOo=;
 fh=fLQ4ZfroYDUa6tLsELkNuTY2VTTXzM1gBnK5CrncjjQ=;
 b=JFWMq4xL4cLOJvuOcxWnUaZu9bzyvzYCg49kR6dk3yZwGV3jp6AVklJdFFEpxW7Sw7
 Xqwba1u0ZHeu4jfHT5Mk/vWOSJczslNgt2ieNZx337PM7mlGbEQYEyu5nl8Oo3jRRqbg
 u4u858Vasdv36u+ZzhkU/zNzbUpUenkEBtS+bWPjWlH4oRrAodYzfGocGn/hOkn5CIcK
 574ggDI9haZgVldK4JVzQ7H7GVCVgWiqnX/v8/U44jhYBC7nhp+dxxExiZK25O52m+1H
 ccYpSmRc40rz+SCbAWCsfAdixY28IhUDVbOlXackVcqglStTF2DGNtg4/bcx+4uXD4v5
 SIaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794217640; x=1794822440; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3kMfTQ7C/dhD1+azadgUmL3XUQvh4AQkYCc0Vgs9fOo=;
 b=EwleL8+l0Pvsq0Yzwlc/2HWUbhabc0h4wT/O+wJf4pdwH+ZfWqLIut1qmWJpG5oXzN
 2Z26TugibAgmCTi9r2BdtbkgXdZyObWGtulJMloBxsVTFLhfBMaLuQv0Z2Y3Aoc++/ep
 x+KG6GjPJjUSlnMV58p+VDXicumIUvztH0hkAmT4ZvEN3OtsSNvbxURqP0fbI7rtvaK/
 u2fB2lB0XegMCX3cLxzR/tLS0UEnbXpFwfHd2ElLmHkE4x/kPXBK+/+2COZvwr//JEVs
 XA86LFo3xuu/pM2P2J0BvCK4MHch3RCSIB4Wn2o/2sGp5G1s7iw0wRFuCRoKjMYVRNUw
 fHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794217640; x=1794822440;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3kMfTQ7C/dhD1+azadgUmL3XUQvh4AQkYCc0Vgs9fOo=;
 b=YUMTiQoyMq0Ev5LpD3+NDYqKCBpBvSsKlRgvmyeeY8joCACj7EzriArpf2eU1o9Hg7
 01vXJaPRnsNOtUdpI89IYgiCCFAW1IMbsoTl4/1tBOe8Ef3/MCQ6MiO9ga4CS29mVWyb
 /IYheZTxkmkC+f7KLCx6VntKkf/cg6Ti9ECoyvA7qRvyIkdydqmilwgQOrsXwwwY7Icv
 6p6rusPvji+wY1zPmfZlkUgZ12FkKPkqDnx3c59l/jKVU+v90LiRpUSAdEmDH/Pa7zhD
 9RDOqNBSfWrKJmqTi4GuVPpSebEony/lIdgJrLAOafQzRQFLAPdoBdWIt8iergHge2xk
 WtsA==
X-Gm-Message-State: APuU4Z/Y4oV34WcwQDqJe1T1ncWlv8ptSHzSE8/6/ePl6IkjiWxeWHui
 hA7OpPsVeUpvYqmUsRLpECd7FJyf/5B4LE2w30DscDved1F5tJzGBPg7q8+8xISMdG3NRkciZ+I
 Utf8LLsleb7YMdO12RBQlO+6b2cdm25PatVr/Ghjz8w==
X-Gm-Gg: AYBFou1OWVlhJ85eF9ohzy8J2gRgK/nGLiRzbCubMpXzYyYLJkzepuJE6w0RnC9EYOk
 ct2Bkc/pQjVkal0mkxVoFkoT42l+ObQm0u3zvSWeUj4kBjl0mWqtKZDXAbgpKAorC8snqf/JL+Y
 BYNYl356YpTupgpzm65rEIDS9W4Tcn3N3RoUZefIHd94owekBWjQM/w96yicbyH/a7clCbHMdf/
 PUlXqW4dxujJ6v0Pf/gdrM4dFcUREyAk8QxBPDz7OvWx/anp4ME/Z2MvZZSy6hj3dHvYr+sNS5B
 Ra/KnEkL/TgG9wz3z3d0UHF2SJBkM67YRmRE6rPYPsRsanvwA7IbC5sDxyvJQOEriXvV+0SXCO0
 EbCZwR4mTIa85tPQCg91amznuFiRftk9bxBWc4XWwnhd9tIjYciwMJfSFZoNB1Za41Ctvzt9A7D
 Bu5tLqfcxDahIRX7F0/uU6
X-Received: by 2002:a05:690e:441c:b0:675:690e:e6a1 with SMTP id
 956f58d0204a3-67c3da43d84mr1246058d50.120.1794217639786; Mon, 09 Nov 2026
 01:47:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108193423.225720-1-jpaulma23@gmail.com>
In-Reply-To: <20261108193423.225720-1-jpaulma23@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2026 09:47:08 +0000
X-Gm-Features: AclHuK-dwV2mPerHrvIob6RcdVYz1rRmiXVIo3kOUy_0Kb58qKVlvwF5xTyFopM
Message-ID: <CAFEAcA80KwukhQ06QVy7K6nC2GopHV06fNtR+QiRWopvUiDayg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess: Convert malloc, free to
 g_try_malloc, g_free
To: jiputer <jpaulma23@gmail.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 8 Nov 2026 at 20:39, jiputer <jpaulma23@gmail.com> wrote:
>
> Convert malloc to g_try_malloc and free to g_free in
> uaccess_lock_user.
> Convert free to g_free in uaccess_unlock_user.
>
> Signed-off-by: jiputer <jpaulma23@gmail.com>
> ---
>
> Something to note, when len == 0 in uaccess_lock_user,
> it will return a NULL pointer, instead of a non-null
> pointer from malloc. Any read or writes on *p will report
> EFAULT since it would be considered a bad address.

Do you have any concrete examples of where this is a
behaviour change for callers to this function? I don't
think we ought to rely on malloc(0) behaviour, but if we
do somewhere it might be wise to fix that up first...

thanks
-- PMM

