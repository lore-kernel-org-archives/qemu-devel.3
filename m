Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894D606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K4Xbbw+N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpID-0006wC-6M; Thu, 22 Oct 2026 05:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJpIB-0006vg-Bb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:40:59 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJpI9-0001uw-PT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:40:59 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b06c0794cfso18166307b3.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 02:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792662056; cv=none;
 d=google.com; s=arc-20260327;
 b=NKoND7b6BZodInCUvzX9QO75ejmy/w+8m6wrhFz5T4VWS74Ffur9CL3ncVXy7oEUIU
 lRj9kvaKklf8DD/fQpA4dhHtL/fYn/StaEMNDiRkBDs9ZCT23o64waAXk+HsByFolYJO
 AZZEcVMeo5KPXgPPdmr2OvNfJct7vniQMqPVe4a3Q7uj7NDY3xO5Ov780JzBIJCvOviF
 K2sEKzB/8h9oz3OXe6qgByyCMgVsvVLKLDaLfdbSyFxp1xlbWdFYUhDznuYqk9IRcZrK
 EmuSOHg21GlU4UYwpSdu6W/DLeYqS+PvnJ27/H27bFwdAFgf3+cAxxItrQz5A/XkxMQH
 wOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ANCWdpFW9pxcgr6z+DbMI9YpeloVUIeDneRA4SA2uHk=;
 fh=+v54tjaz45EO7l3MhuFc+8ZEvTVYLlZkR0gJLUDbgVw=;
 b=BbMvpE/cJUAPigjM37MXuD0MlKxH/sfLpnUSdOGXLvGyfjLk6vJWJJQv9fCywQgMN0
 YFWaV/QRqYBgF7Gp1BGC3EYm/9NLDwpDto5hv5Rf49QKQztxNlWEUqfPNJLIHXM0A5NR
 0O2IWYlHQlV0/eX5mJSXrL2MCEEjbIah20vC0WUY6tJztaidRlXVH3S29NXtmBfIEz59
 ygCpb679f62ocJ55ayZHsjHkm03XUUI/ZslFcmU2kKHJVA47HFCkfj1oipKjO2qWHRDR
 nVqokpaNGxIz0Ur3ezfydPL4yatVSuZlBEZXpWhYNGo3JzK3ejSOQ0Xm2QhrJqyIjfkr
 GibA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792662056; x=1793266856; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ANCWdpFW9pxcgr6z+DbMI9YpeloVUIeDneRA4SA2uHk=;
 b=K4Xbbw+NWJEdPL8aHraaRxKWcmY9gXxMLHQBOGkF41tFAHqgGa7fgd/dtPpnAw0q/0
 GlLRTSlAc5oegb2hyDiZgJK6wkEd6JP1u0CDvixaCHNFyIHqVYEJ+3acwit8IDnol/QZ
 B0HWqeUNI+ErPDJxVGU1T0zP+Ve9lbeOru13ICqj4H6rh4cK97nBspzk8laYUvB7hL34
 wJW+TKoUIgokbEpPb9QFQHAGFDTFFYg3mvgedEvAkKJdy3MxtBKrWYFiASjSZXB+w2l3
 1g2bHqSyOmvkQzX5LertVTG0tUFXzjNHTb4Y+IM8uNcWYg2thj6cr3qHp9Y6bTxrJjAX
 zhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662056; x=1793266856;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ANCWdpFW9pxcgr6z+DbMI9YpeloVUIeDneRA4SA2uHk=;
 b=lcNSQBKd5kFj6OJbilkjcaDPzRnn5um5SS5aIPd1Drm+tQNHmURULPnuyS4QKOo+ON
 0awDa98AgzBz5iQHwJ2Muy2fk188MBmKdIlaGpviIZEoLtCO6Mp0Ry5SrEXsL/nst4Wt
 jQpKegyJ9Gg88ypA2d2kDp1VTuHoaZQoO0ftuGLLhPUguby3keJO62QcfOD41Y2FGwcH
 6Xp9IETYoThorIgMlQc+F14jfkzyHo10ECZGHqNa70M2w+SsQhiS58voD1Kbei8t1VOF
 LGoP0wkT3qNc9ypCuMncNjZI+gKmExppXNgRmqrZEEK0PT1JHpihbmFlK/sNzvreFC5y
 qMUA==
X-Gm-Message-State: AFq9FYJctpzEooM5iV3ykRAbgAv6TKHyGEMoOY3uJjTCveRXHJvS+BEo
 pRtjN4TW3r7TzBNuGzs8UBX/zCo5XnnN8LfEt32gTmIzIGhC5SRWUO60fYATpBOH9y9Tji29iJu
 f5u+HC4WBM0zvStibwXnzTYzyyi89uxiupWWeCwjihw==
X-Gm-Gg: AYBFou0TW3kUiEGr2unEM6FWrEUMSnsWsXKc70hb4cmvPke7KciLqUs1V/6SO/biXYo
 /j0DgcnyBZ4KmtCL5FGzyIRAyVRHzG9YVz3FZEHpOlV6zDMnaPZ7+dAh7/Gfa+nyMOM76I47uve
 ChuasOsKUsWKNRaVUWXgQEpr3vcqTAyGjtBiFUKjFGALHmPAK18iizIRYEPmtufWa9otZtJxb2R
 Ncj4JDAxzZ86xfDHAO7SNnGYaK7DJVt0EZ6MNw3ko5cV8BFz4PwKortUyxNdrC6hawQultOI3A9
 0fEXu7N/snqDVJhZXg6LlqLB9j2C1Yamd/vsICkYZNtQjW1O1njUhomkwyKYSA5u1o63ovsOHGd
 T9H/fZHddWVa/QmNCtYQceo8CRf1eFrpTL1PZ4p1mq1vgGO5vFXt+R1HZ8U60M/FOc7EmQID+ep
 ispW6mW4a4QH+49z+nZN+e
X-Received: by 2002:a05:690c:6987:b0:8ab:4f41:c97f with SMTP id
 00721157ae682-8b133d1c42emr28616367b3.30.1792662056266; Thu, 22 Oct 2026
 02:40:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019130713.4127060-1-imammedo@redhat.com>
In-Reply-To: <20261019130713.4127060-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 10:40:45 +0100
X-Gm-Features: AclHuK-SvnUEuOcjFmTxceCyXX4tEZg4-4LzaRXyScuoBRWCyIbTQBVaDwQNPfw
Message-ID: <CAFEAcA_ejp+jo9jypnu06PDCNZqQOfjK2PERp40UxXNeW+mZjQ@mail.gmail.com>
Subject: Re: [PATCH] tests: arm/virt: add GWDT tests
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, eauger@redhat.com, 
 leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 19 Oct 2026 at 14:07, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qtest/meson.build      |   1 +
>  tests/qtest/sbsa-gwdt-test.c | 227 +++++++++++++++++++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 tests/qtest/sbsa-gwdt-test.c

Applied to target-arm.next, thanks. I added the new file to
the same MAINTAINERS stanza as the gwdt implementation.

-- PMM

