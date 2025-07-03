Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC8DC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFw5-0006VS-Ft; Thu, 03 Jul 2025 05:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFw3-0006U9-7S
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:08:51 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFw1-0000U0-Lu
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:08:50 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e740a09eb00so4221397276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533728; x=1752138528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ndLtpZNVY8qFyDjOn/xAexiIb6QRnZYtnSMwE7mC11I=;
 b=ruOIElXCLRXE8dTis4pn/sPSgJS4oHhsUtLkYay85OdYCPRLkX8qUnScZGCjkkRWrb
 TpaKmHtPg6sE902EH6JCxSIfrKaPgZO9o4vnr+cV+URCz0Wo7f4eSIAModOBl8BslBlN
 B4JdcyjHpwHhj9MHNpZtwKpZrL28wX5xuHCppsrs4pZ/wCl1ysvpdDKtuy0tm724qhaD
 cwsm1u7ll0H2/Li0DW2kP8sKSUEwvWiTEa8HaEBq6TqSonI9pFYLViG57OXgtpS9KawR
 YN7LeJnPe/T4mfCP9n4SiPaSVyoj+Y5DDq3LHLPZQvHg+0/X5WepQKBDiFPS5PjE/inu
 FKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533728; x=1752138528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndLtpZNVY8qFyDjOn/xAexiIb6QRnZYtnSMwE7mC11I=;
 b=itMYUCZ7GC1KepRIfjbdHIOSVJCF8YXI3Y/GkpHLcqayaQP2B235NNZ5Frl2j2NZew
 7DdqLmdSq+spYFPDeatX3yhl7E+Py3beglzI3/Fvt7GygEI1+dziHDMgrXQHnYs8kwYs
 VMluUSkjZ+0tSWGXxGzNpwtM0CrR50RNISQXTxVe9MVXHmPhDkMm+AQhM4fAESY1MHGz
 8e9U56CJrZ0PMbgP/oUR2SYq5WUoLKAGa+7mdcjRjGQ4L8553mM9cf70E7rPPHopz747
 OBWmonjF+3kfSdpVeKOpQkNlxRRZURDN6WgWuxcrHqw+hgJ6NoRBLJZT8uY/fZOtnDly
 lJcg==
X-Gm-Message-State: AOJu0Yxun75fADZGUS0URu8nx3ChKmlzjbzLhVn2o33oIWhq3SXCaJCL
 NSMFYZswhTnTeUSFqp2YckfqmsoiKfsgxlLRmg+xrYSQeI7jJ8U5V3rgXJgJ4TD5IRNot6wfTE6
 Z/SHYRCFhOGbUJzDUxDRfzgiYHZeWox69GJtUrNBcnw==
X-Gm-Gg: ASbGnctaXYoCLaPFD69HseTW+jUt7MAGe2Q+57DCcOwZL+6uSBc79pe4NDfEZWZ2xIn
 sLwhuJ6xddie1XlEhA67obpJASsnXqDcmzrGJ87wj2cYcvhqvEP8ME8hKPr1IazN5/6m0VIR97N
 HvCXUBN1zpRxbzTjP9idiP5A5v1NOfQpmYLRomDjRI3TeY
X-Google-Smtp-Source: AGHT+IH49jaXu7Wd931Pwkzlp7T8J4oO7x/B+TEOkDsfLlpcedr3dLgh4QrlGV3vFmCv0Aest6B6X564hvxY7LfxggU=
X-Received: by 2002:a05:690c:6282:b0:711:a54e:8e11 with SMTP id
 00721157ae682-7164d40a037mr86462557b3.24.1751533727826; Thu, 03 Jul 2025
 02:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-4-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:08:35 +0100
X-Gm-Features: Ac12FXzjzR08JqGApFKRn6cTh1v3NH7EQz96r_fYdGdIa1cTMqHZPpyc9AzusP4
Message-ID: <CAFEAcA8ye-51xVjZzXJqdDnsJHuo9LY5s+EO4t-7BRbJ8Jd8Lg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] target/arm: Fix 128-bit element ZIP, UZP, TRN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We missed the instructions UDEF when the vector size is too small.
> We missed marking the instructions non-streaming with SME.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

