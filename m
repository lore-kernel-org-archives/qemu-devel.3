Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD19ACAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDBX-0006Cw-MR; Thu, 18 Sep 2025 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzDBE-0006CR-NL
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:52:06 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzDBC-0004KN-TU
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:52:04 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7341b13f2dcso6161037b3.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758196321; x=1758801121; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1n7Ht8oMM0rY+6Xt1j5k37MQdPRZli6vHpd59JIIXFA=;
 b=E+Yi2iMJW3wrR1HBlTBw+ztqDWcwr19OwtQ44xZf/FgEYDR9rFSe+jEme7de4dsTOD
 Kql6AU7a5tvsSClTIR0NCHqSOGKhmJR/vyExu7jI1y5/Io+p8o2Qo6CLhSpdo5fPYvWx
 27tf7uqcJ/WyWna+J9szFxRzxDLgMMByuZcVmI4UtbAaam1WYXuejgO7tu0RlTchRc6W
 jePeCi8Bg7ZtU7zI+2OY+vfocvfRUS2bBua6tP7aSgvgsf0DUj7YZ6rkso2joV8IWQcA
 SLu6IbaBUlewFB1+6Y4OtdbL/4GHC7+qn1KFEYpJTCVnZ1BDVEOoaMBHSZAQ+1euVn60
 4ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758196321; x=1758801121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1n7Ht8oMM0rY+6Xt1j5k37MQdPRZli6vHpd59JIIXFA=;
 b=uVzfy8FDVUOiOu3vAavAyCv/QbzVKnsdh71MlwVNdxm/H0pt4DOlQEOxoylOLwV/Es
 UfUi6JnvkVP9GS7c3AS33cuZ25czKibUnaSYN/pcvL4IDImZOo+XHqE3uCsJvUSBA64V
 NbGkZ5Zw53+QKFJPAjT1cPiyY3MHNmFhBh/TMCwgdCadUXAjQwiyBDJ8A7pWkcuYcbGX
 yF35cDCfMSdxAEUs4bqgMeXAnItTVSbga0wSiZB9BPlMYdsoC55XJH3tWF9JB2x0uzSm
 2fIL+5x6tDumF5QFXW+pZPnrj7feG1/MHY36JKjI9TuKJn3zx/g3dbUWW4urSAOOkp84
 p6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWsTPNsLdCpavKZOqpKZtKo6TnkQIb5hrc8TPuHLUl/LJS/LOUFQ91XJ/Hj8+F3TU7PqfJ1/ih9yGX@nongnu.org
X-Gm-Message-State: AOJu0YxHVJ5ncD0W7zWZ2r4vpZhnIBnyJWuQwLAHTjCDps98p7fG+Tt9
 F907ovtt2mUfYSgfNKMdbbhXeBKGpXYYHJli54RzBRbCpchs8mKaCcYBNqD+K+tv4S+JZ7rs6r4
 U/AhtX0winVAQXBcMx99ZTyzTt9ivz9DhjEe7LxNbS1PCTHAiQwRl
X-Gm-Gg: ASbGnct9PwA3cERko0WCQTFJIJQ7u3edc5QE9Pwdv2+M2JDf4C4cXu+hNAPRSWGsVjs
 af0P9P7LVEaVE6quNfyao7koDz7hfaXe2jhqhDoMoxl2xx4qNMN+di6ZtDZK27ZsTuCrAAxRpuc
 X40i2h+roGORHue3/uzoRFcE5Snnxz3GyH1PyXPZ7S8geb1T36wg4RvA/59Z/oKPrk/tnUyE4b2
 0FGhsKZDtvRebInFsKRQBap8vc=
X-Google-Smtp-Source: AGHT+IHiE7fBVkQFqepd2cjvrKN7JIpMk7Gnnt2lDyVZ86NVVvAXw1DMVllfbWS8XUfKMZ2Q0wbEZ2c+keK7+pl5vxM=
X-Received: by 2002:a05:690c:64ca:b0:731:b538:3aa9 with SMTP id
 00721157ae682-73892f4a3a9mr48627527b3.37.1758196320707; Thu, 18 Sep 2025
 04:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250918114015.83061-1-thuth@redhat.com>
In-Reply-To: <20250918114015.83061-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Sep 2025 12:51:49 +0100
X-Gm-Features: AS18NWBHqBPy_Y9VlkkHpOM1v09d7owmoAV3xgWSUsBHPUk7syEbB5UY6Xdu6Io
Message-ID: <CAFEAcA8qwgQoGrU1phd+ozQMtWdo=Jt_XNCtaxPysoqaLxd16w@mail.gmail.com>
Subject: Re: [PATCH] tests: Fix "make check-functional" for targets without
 thorough tests
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 18 Sept 2025 at 12:40, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> If QEMU gets configured for a single target that does not have
> any thorough functional tests, "make check-functional" currently
> fails with the error message "No rule to make target 'check-func'".
> This happens because "check-func" only gets defined for thorough
> tests (quick ones get added to "check-func-quick" instead).
> Thus let's define a dummy target for this case, that simply
> depends on the quick tests.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

We also have the opposite problem if there are no 'quick'
tests, which you can see if you try 'check-functional'
on a build configured with the aarch64-linux-user target only:

$ make -C build/aarch64-linux/ check-functional
make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux'
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux/pyvenv/bin/meson
introspect --targets --tests --benchmarks |
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux/pyvenv/bin/python3
-B scripts/mtest2make.py > Makefile.mtest
[0/1] Running external command precache-functional (wrapped by meson to set env)
make[1]: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux'
make[1]: *** No rule to make target 'check-func-quick', needed by
'check-func'. Stop.
make[1]: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux'
make: *** [/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/Makefile.include:114:
check-functional] Error 2
make: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/aarch64-linux'

(Those errors are with this patch applied; without it
the error is slightly different:
make[1]: *** No rule to make target 'check-func'. Stop.)

But that can't show up on a system-emulation target,
because tests like generic/version are in the "quick"
category.

thanks
-- PMM

