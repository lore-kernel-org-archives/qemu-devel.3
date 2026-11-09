Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F6606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KWBSwk8o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMcB-0003nf-MU; Mon, 09 Nov 2026 05:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQMbz-0003my-4b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:28:28 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQMbx-0002Cf-MO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:28:26 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67bf27f179aso607992d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 02:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794220104; cv=none;
 d=google.com; s=arc-20260327;
 b=U1u3mt+tCl7ikuMt/wpn/FK/7OE44nF4O7jwUJtL4xbFjc3Tqb3D8Ja7sCBmhdoeOj
 HwqJWcW4ZnomTYlyCHkVUexXXaASFE4pDo4geav89kLYnnAYViTmCaM4mTj0oH//iir4
 e+WZLEf/3mTqXZMUp1IRBRPMIiniCUKLLaN74OrZw+eH8TJuMGdSSBjhbxn5NSl9mF0K
 BG9ivcUK5dlhPUhEffdFcY3JMT5I4a12AbXZphCszaQomf72wSK/FXiRyBCoLRtr6HXT
 Sbo6tjqaqdkNAtMSbbTdVVMmH7fOf6hER0ChqkXGXcNPGYdT9UvO2YGa4bUJypg2ew1v
 u2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EkbMbvfKxbPpEJofGKP0L5Rx5eYXZ7QObRfE6GwoIAY=;
 fh=eXkirfYSc6C3u6xP4T1vL+4pWhTyjsxX6MsP0rYpORw=;
 b=RcFI5LtOef1Hy5TnqCxn37WcCkzjuyjaICJ0/Vd/8NupSWpmimeFr6urxrSLf6fcXI
 PkDopjIZcnGDqOAY+ML/2ZE2m+f8uFIqqfxdUgb65/tOlxAcZzMbHZ+yaA+zXAJpvjyI
 UGtDhB6D4Z+I9AnMrrm6MkX3TG9uu1V2c3AxdEtTtpz6AswBL6VkTbbN5fw3lKAWQSXr
 U8cGxVBJSK4WIIi5xofc8kg67xOfYX60P3hE/WrqlAlbiNODl8fXDvd+pZHm3+P8B8fF
 TORK6C1YU8gaN5HHR/Q1/rOjEYaigSbakJwEnzYvzWV25XvMELox3fk4p3+5W+5472DN
 4fcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794220104; x=1794824904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EkbMbvfKxbPpEJofGKP0L5Rx5eYXZ7QObRfE6GwoIAY=;
 b=KWBSwk8oyXT9AOb1whlyPmoPIE1Q1ohEFB1N+owF2o4BAmBKrFrC2sSD8bnZfbzWEc
 p7nD9ldUSw9k8RwFgydCK1iQHJZo5NhZyl0IPgBoC4ebabpxCPc7Py5EWh8Rwz9VFP7e
 u7QmJcwfjQXCiDwfv1LpUVL0x21ePxeb8Sq+ILWdk+eOnejyMFd8ctEM0JSzCuvZNJ1D
 e/1U5n42+qqmpmqn7kK8VMy7Z1DrQ8WteibmeV/9e304G/vrQGXLwFbD9DeK1aR5H6zQ
 +UAZcYjjsBZ8gJvP9QMLrJ4XuePcu7hwsie9EcqxLri4cWgaIyKOZq/SrsheTbxw1tmQ
 XEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794220104; x=1794824904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkbMbvfKxbPpEJofGKP0L5Rx5eYXZ7QObRfE6GwoIAY=;
 b=B9zim9uRP1vNCu9MmDgFP8O4DlwSuqAldtNVGqKWYAbh12zIzWkn/pvH+KMjATk1KC
 EhpB3f9H7wXAeJ7gn++0DYkAvv4mwVDKVMqsvOiYYAIC94m7eyxJrIn2XRHiumGcviww
 3XS79hMoG+cvQetdUcz3DlCEuiy0ydHpgfaK6kOWB0crqAlCTUoqvIb/5pbClITigok2
 Fa7zBxXb1pE/G+ixcihZ+sw7ImL5eWuS2q94bEKA34F+6ieTPIHEhR1rL9JnvoAuvnrr
 ZyOhScjHEVqR+0Fxxzvc6ZCLqthGJ2WIisKQUgL41vGJg89UU2vwSykwzhY5dy00L8Ny
 9Vjg==
X-Gm-Message-State: APuU4Z+ypRpmZWe7QW/y86SAqgnqHdwjaO4xmL92rDzlxfl8G5oyfwg/
 fopSlsdLYTF6bSd3gPiNOGO559jqkdJrbgK1nbKyGkkhJoRWu+y/mdB7JJ14U3uPG0kkcQ97a1f
 EX4WA29jy4NQohhITKE1bLG0Y6aFgWEOGcb2Cvwh8Rg==
X-Gm-Gg: AYBFou3veYHmEk+ofw1ui4M5RoeN3wZHF0DmubVac5mnJp9Ba31uRfo3RqDdVHc2X3K
 lz7I3xf4neMxdCtwb5kcJTGtzUB3Zevnb/hR6MPNHOqvUL/gAPNPEm4UTIYx/cU0ve8dXjrv+Ke
 cjmaFK8rJGmdViXFyJk1sjQL1lfWzPngzncEIUi3MUBY2xPiDo/f8MnwefbExNIqdMzaHxAlZUp
 En8Gi/4HYq+vf4+cTT4R5zaqjpj/HBOMPDTK3tDN4WIddQJo2Hx2i8tJb4aaKqETbY8x/Jz/fFg
 /IAu2tB0TgDAyCxSVWThdY81LL0MYbM8UL/6G4LWTgdGEEADqwaueb4MCUtqW4mqusw81Z24SCE
 AVo9ECss2LyqixEeuU2tM74tiHYMs6Z5xf7Q68KDqTzeSJt2ThvuXtSbVXxZ/CH5WHdik34C3rB
 zS3m1byrYG0dFdq49rKywe
X-Received: by 2002:a05:690e:4807:b0:67c:2804:faba with SMTP id
 956f58d0204a3-67c3d96dcbbmr1175686d50.23.1794220104205; Mon, 09 Nov 2026
 02:28:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108-armv8-exception-return-clrex-v1-1-ec11079bf695@chrisnc.net>
In-Reply-To: <20261108-armv8-exception-return-clrex-v1-1-ec11079bf695@chrisnc.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2026 10:28:12 +0000
X-Gm-Features: AclHuK8ML64z4UUye3-l6-HYcStOD_pRmRhA3dzrpJJ7bNW9JY7ynTW4VaLsK-0
Message-ID: <CAFEAcA_Xnyf8f0szzgZYYqqagEmTffg-E3_v7P20XveSvXWvBw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Clear the local monitor on AArch32 (v8)
 exception returns
To: Chris Copeland <chris@chrisnc.net>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 00:01, Chris Copeland <chris@chrisnc.net> wrote:
>
> A/R-profile exception returns prior to Armv8 do not clear the local
> exclusive monitor, but in Armv8-A/R it is cleared.
>
> From the Arm Architecture Reference Manual for A-profile architecture
> (DDI0487 M.d) =C2=A7E2.10.4 "Context switch support":
>
>     "An exception return clears the local monitor."
>
> The same language appears in the R-profile manual (DDI111353 A.a)
> =C2=A7B2.11.4 "Context switch support".
>
> Signed-off-by: Chris Copeland <chris@chrisnc.net>

Oops, yes; we do this correctly for A64 exception return
but missed that A32 returns need this updated.

Applied to target-arm.next, thanks.

-- PMM

