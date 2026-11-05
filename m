Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD91606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jUYkd8El
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzNQ-0004dX-75; Thu, 05 Nov 2026 10:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzNP-0004dI-2o
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:27:43 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzNN-0000xk-6T
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:27:42 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ac9d666d4eso24553987b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:27:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892460; cv=none;
 d=google.com; s=arc-20260327;
 b=FjRLgcUv88jEIj4bCdRLj+tJpJTJ1QdWUbg1n0vi2/RJZk+Kx1o0fyYdVdUwjVgB4I
 Ucje5Kq27vFfnn2ejKDKbSzi8WDXEsnhoc220iKjEpuvnYdolIECAdvvQPXMdJuuVKUg
 Pn9ood6cbeAmsNnvfENTJrAVN/9I/98MoO7bf/IJdqnAyoqZLhfrBGk8sIY8ZS41Al5u
 UuQmRcCUVL0gOJ7RfgKEpho9lJrV4F0ABYGQPTSTquq7gcy2FBIAxZVyRG+Lqxhaqo4z
 WFZo95KIukpWzfub9Esqn1y5v1/VQQpdXsOAdTVP2Yewa1uOpY2CH3rseujRn1semNMx
 2Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bNwkb7k63z15JBl/f9Uv9ma3XXo9yMBoFn+Mn/5Q9kc=;
 fh=iv2jK++0YJXreQz/PU0IVCxjx4MTink+nIUszu+RGkA=;
 b=UOqwtjL8L1s8S9KbU0/1E6Lc9c0GIhY1K0PtCDYu2wrUkFmYtcREHCqeodnyZIw9Jd
 v5h9PTJcwjLWBQ1zdlrDF3RB8kJn1rM70GsVqOAM35VPOO9+1xRS/xYrmBp2xEVFpOiX
 ip9F1d0F97iMdtgtbMomifiuCnbwWUfPzAUEYnvEdkX1z8cDQGES7/y28RLw+18nU7SI
 4uYIgqetPqxeKGuydSLNMmpvJHeXPEEV0hrKfQmfdzM/FIhx7JMwWnaUMRBMr0B8+AOF
 ybqRQrGP4XOB9qZERbkVpiwTkdVkumo1R8RGw7Mq6tDlw1PuLB0M+E1Q6fZ1HjacBG9l
 v02w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793892460; x=1794497260; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bNwkb7k63z15JBl/f9Uv9ma3XXo9yMBoFn+Mn/5Q9kc=;
 b=jUYkd8ElzUdmIgEXowHiwtNOf9TMhqkD5V/hahn+vY+inZBRjN1Fj0GW3cGzsmJDvb
 CUJHBb4lOS6B6RjGlM1ojj7gFx6Sd8eDVeQU+XnM4dDFQQQ3pXeHF2bvTtuNw4Smj7Yu
 QqOY8mNE0QOIzvWSSvi3KVV4+C7y2edVBMd0lqwJDKQWfCVK0efdDOWtAd78xqeUKaO4
 eggLXjUK73F/YXcSDowrBq2v1BfTzIpT9pHxsscGq3mGAr3ZlR+iaqRZT0g8+QZUdlcM
 pTuxO4kc14UTausXJzmv1lwwkHfpXz7KNTmQkTeJOYdTqtGuiNDXn4XAVU5tntQm9IEg
 lcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892460; x=1794497260;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bNwkb7k63z15JBl/f9Uv9ma3XXo9yMBoFn+Mn/5Q9kc=;
 b=Q28aCrijnDpHqehi5BtozBzaW8s11WRhFMRBNuWLPbGC0g8AgC3kXpFt1wYHO5fwj9
 OFHkmh+pMD2dHgIT/QKgL5UOGNPftJJM574EP6uapCjcVcJYLWhtmxj0B8y7n2+ZQcV8
 3Yy+Nr0fsdzAlOYIPzN5L1jFRdj30HIECZToiFbrnlnIen39/6SgF83U2TO66IZ722Fm
 4pn0zHCadfQGHAxcW9bAP7HuIns4VnZsj1ulaO7Aoy7AfPH3JR1/TPhLiNcT+0+dTWcY
 Jo4IsFpjklrmeks7iVi7jiQYzL31GKL9g9SSdEqE++19KwVq5WJL58w2Kfy+2+mIwsdi
 iVmw==
X-Gm-Message-State: APuU4Z+s5+gI3k/Mq2xKnW+mIpy7AfX9e/pg3C/hkFZ/Wzse8RXCBELr
 ZqKpvuPzfUeYOW0y0D26rBpIRx0HRnDeiMLPTZSWLHTvHHDa37kfw5ZrfMB2pBJUenzY66jkkZV
 fuNKmTqEW3+S1GaesXvMeRw9yNLZ4JXfoHqzLiR4RBg==
X-Gm-Gg: AYBFou0rpFVIBOKEyf7aQkIpFS00bIDN2HAwVVXjtJZaX6P/YjiopYiE5OAw+kDURdH
 tfTG1bnAG5MIR2CbRGDtEjQD3JqzWW4n4EMsX3qg0byVWNeZrm/XZtSnGNb0wnZJaJLBN7aQnf2
 W8BQTuEX+SO+P0oFH8DMNDmo/awBByByMHDPQhvq0uKdkjFQWHquJLh8uaK2aEl1Tk0ZrfwQWWO
 MuVlSIgap8iVm5cC3D1nfgoSIEPLDtiqZXV5KfmAiO0cwSnBF+4EeflFvYUC79RadmrgyOlLynO
 pZcoi03hMUSQPfpUk/NhkPKseKJkGcs0CWLE9IojtWwrGHGsSSGKtPXXRPK23YK1Jd1Vz93S6+H
 iqePw7BLG6BoP8nStZt3vOJvxXWqgAJ9FgyG5gJX+WwcyjgNt7/0j7b+xz5JRTglznZZs/TkVZl
 aRm1jeSVliPQ/aFpVcYL7p
X-Received: by 2002:a05:690c:6d81:b0:8b2:f9dd:933f with SMTP id
 00721157ae682-8b2f9dd9decmr51473697b3.103.1793892459489; Thu, 05 Nov 2026
 07:27:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
 <20261028052024.38377-7-harshpb@linux.ibm.com>
In-Reply-To: <20261028052024.38377-7-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 15:27:27 +0000
X-Gm-Features: AclHuK_iOJlWA2bIJLqO-l5_D19_z1Zl-r1_vwkbXpxAd-WYAKBf-q9KHL_Vtd8
Message-ID: <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
Subject: Re: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to
 struct size
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>, 
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 05:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> From: Chinmay Rath <rathc@linux.ibm.com>
>
> vscsi_send_adapter_info() used the guest-supplied common.length
> field directly as the size argument to spapr_vio_dma_write().
> Since common.length is controlled by the guest, a value larger
> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
> dma_memory_write() to read past the end of the stack-allocated info
> struct, leaking arbitrary host stack contents into guest memory.
>
> Fix this by clamping the write length to sizeof(info), then using
> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
> requested beyond that size. This mirrors the existing pattern in
> vscsi_send_capabilities().
>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Shouldn't this be Cc: qemu-stable@nongnu.org ?

Given that spapr-vscsi is supposed to be covered by the "virtualization
use case", have we deliberately decided we didn't want to give this
a CVE, or did that step in the process get missed ?

thanks
-- PMM

