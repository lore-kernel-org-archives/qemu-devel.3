Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pEPkLgKL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQM1j-0006LE-Ia; Mon, 09 Nov 2026 04:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQM1a-0006Kl-Ri
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:50:51 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQM1Z-0007BS-6T
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:50:50 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b37c7d767aso3073427b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 01:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217848; cv=none;
 d=google.com; s=arc-20260327;
 b=cf8tQEkS6F1QVKYQJqp/UPd6Lf40h1hwAHoqRjdcrEC5TvFK3a5qGBhbBalYvkAGR5
 6S/G9lb4AIe0Tnpp5q4INTh0I1dwOdMCVQAy8KLWfRDyT/SzVVUFy/UuUtN2Zi2KUdDF
 mCy8OvI6ZNUewV0xKh/R9rlurMKY8HBmef7916boLywBj9399676+nbO/Pg/c6Wot7ZD
 kyGGitq4x3S9W1ari9xiS/vzDjAe3KsS4/paAgm0q/YR4iRN+HJgbRVVWxUwVkA6Da/t
 m8lw0/jtuNCx550vogADt8bIt6ffkzLHuyNHCDhQl/NMThgY1I0ylB6WMo3WtN2BHGHh
 82mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2HBB+RmTYdFQ7GqbaMeWhxbWwxzeRHcryV3CLbFexwU=;
 fh=ro6pPoFkuMMcEs00YvdLOAp9F95/m2tn+FF8CzQJnlw=;
 b=UrBUmvL+UqEEDkC52lzys8AmZiY3DGm2fl+TH4NwOs936KlQDHJC8p2RjKrUiogES3
 EO1do1uNNxzV5aSiVkfK/AZDp6Zc+qSFQoCHWng5xvxxgtvIOduVR/95QKnb/ERViE33
 +WVdgScaDA6/LsCvbH0qAycCBe/4SOEPLpg98PkALC170KBdqylARSMS7oF4cHjQjLu7
 PY0Ckv9BcHDf08rITZ6HUJkhVmHyM0ldCQlq2LhK1BWIYkZPIqonMSY0GZNPAbXZdY4M
 MV9EsIhTWAl6Wqc6wOwTE8K/Ly/LRWz/qHbel0bWwoi5TB5Fz9qgnqqHjFh+CozZjaCf
 ze/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794217848; x=1794822648; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2HBB+RmTYdFQ7GqbaMeWhxbWwxzeRHcryV3CLbFexwU=;
 b=pEPkLgKLIMZMLdX+f4h7kV2P4aEnyTuTjl7oaJMXNY+bxhdkJZDxfFsLWn0O9t22nr
 DUdDUOQD7QyIZvPbV64WwDHAnCmBOvIAIRokZLykTtEwlmoB6bOhsiHpFkNcaohh77Kp
 4kUyIlJhnjKnRZ/MI/w/BEBbqaBwDWbfhYnrsTulXy8xrfFm3c7enI8NEQMPD6RN7LUl
 1owLvv9Pf8+wRTsRy8UAbpG1J2YUqphp4g7R8pk33IWhA6HA7e7/eGBT/Pt7hkpOPY+u
 kmafk3t+9f0xLk5A3yXb2fsJccKLM3xn4K800sGyHkTRvRnQ75ovSc3PyKAVewkPsGbg
 yvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794217848; x=1794822648;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2HBB+RmTYdFQ7GqbaMeWhxbWwxzeRHcryV3CLbFexwU=;
 b=hcVxQDf4X2u2Qa1WbuPM4v0aVtbGeQzNA9qa2RGWh+PCvI9vrgEDEqhqga/gHwcHGI
 7FIzn1RJxB8zwros+AWllGz4chPusvAhL+bi7ODryS9KJKkls9yQwbrDIKYWm2GgQ29k
 KAwWpt5p3bOohTtfBfroJrvKvrr/mChGzZI0qqUBb4LpD/8ScZ/XCQnPKJBcz+mWtGPl
 b0TwDPgLvNhZpSDUKRDON6rhusM26+iseOqiXynU1zMZ0Zwq4pxn3M0n+KPNjMdeGSEW
 rbt8OeuuRRKy5PMNS4bPdk9jwP/bRiAQobMzWD9gD55atJ8Tnr+apc3UDBxVQBXtHp+0
 XiAA==
X-Gm-Message-State: APuU4Z/wQAk3nHqKca8mDZiFNq0JqGl6TUCAbT5r/NLI/Fjqj4Nt9v2F
 AuN82kA8tk2hz4T22IFupLCvqoFXd6/WNxDFJFX2zWX3Frmu1QqrgrYlwmu3xm0jbGNaaUqJtgb
 9y0DETa5ZTJqLM9hvVPNZ3O3smgslPKaZWFcvmymTqK3fYjamnV9i1BV+9g==
X-Gm-Gg: AYBFou0o8bKuq96kYr/xkA41Olrp/Ss1f7onKPH9YQfGSW9HdoavQG6iO4O/Lwbjo6S
 wOtOvTmyoyxb27hStrqe6bYJu3VBKXSxM7kUtu4FP0nPTnwHE6OIOPBgWFxwT1ia4rr7mp4ztxZ
 rckmv71v+wib0l67ej/6YVrdhoRFnYuZrdFM3cqpVCmISLx4ZeRS1MTjU6K/EyhrkrLc/irCedM
 0C/xLNKIc/A9nIEQlXBJOv23Imr1Juh4D4H+Na+MFspZmlLdZTjCn7LsXemd96Ojp0g+4yTzI9V
 4cFydOBrEEh8G8l4Vyo5i/x6R/YOsckXw7dHwNvxR+LVWLj2HMJYMaSnplcv8lIbEID/GULY5Vo
 ZVcNZmC1wuhC/LqwOxRHPCqy0oJLK8jxgFukUsMFZ7hWrbi8mo3t5QD9Anwsuym2Vjh/6OR05dW
 V87NfPxqLb04RQnt+CS1d5
X-Received: by 2002:a05:690e:140a:b0:675:68f6:a6e2 with SMTP id
 956f58d0204a3-67c3d96beffmr1782560d50.43.1794217847506; Mon, 09 Nov 2026
 01:50:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108193418.225672-1-jpaulma23@gmail.com>
In-Reply-To: <20261108193418.225672-1-jpaulma23@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2026 09:50:35 +0000
X-Gm-Features: AclHuK8SXpHsElsSE2HBzWEJPQY6Y0pqu3gPtouFw-ay0CTITgWX9-MjT-9bwrQ
Message-ID: <CAFEAcA8MACehEb3FEdpHUAfQ=H-C6E2K0sLecVWYu1m6AybKuQ@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/fmopl: Convert malloc, free to g_malloc0/g_new
 and g_free
To: jiputer <jpaulma23@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
> In the function OPLOpenTable, replaced the usage of malloc with g_new
> and removed the NULL checks meant for malloc.
> In OPLCloseTable and OPLDestroy, replaced the usage of free to g_free.
> In OPLCreate, replaced malloc with g_malloc0 and removed the NULL check
> for ptr, and the now unnecessary memset.
> The program will now abort when memory allocation fails instead of
> checking if the pointer returned is null.
>
> Signed-off-by: jiputer <jpaulma23@gmail.com>

There is already a fix for this one on the list, picked up by
the -trivial patchset; it just hasn't reached git yet.

https://lore.kernel.org/qemu-devel/623429ea-d915-480c-bd76-3052d85bea7d@tls.msk.ru/

(This is why #1798 says "see the on-list discussion first" about that one.)

thanks
-- PMM

