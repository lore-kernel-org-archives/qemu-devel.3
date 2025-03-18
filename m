Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC029C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuZyZ-0000zq-1C; Tue, 18 Mar 2025 12:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuZyX-0000yc-Eu
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:39:33 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuZyV-0005U0-Ic
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:39:33 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e637edaa652so4447430276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742315970; x=1742920770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rbNQxrWPKgNC03cG8BVFNXAwV21VUReGzLMEZsXe10g=;
 b=FA2WFSpJ/D7qnqW8foSl8bqXmYcAvGyBZtKcFfpLWGcSGTZd1u+Vo5A6KosF870Pvm
 uyTzpSgZp1o2u5kRnY5z6g/V2U37wCPmKc9N1B8nJyx4c8ESWmT1/sTiPhZdP5VjszZg
 EW96f+6FGweGdh7ssNNOUa4wUcbWj5PlZ1LJqu19HmwJcU0xNcgawHAeCOXufYNXW/nn
 SFRqxPN+Yzvpo5ahD+XeFulvZegL7QY6t12tQX6EsX6EnWoXSXsKS11KtXHu5gv5aTqR
 6xt1VjlVSVynebWACG3tx91332CkTYjYS8oTSI9bRRd0yYVAzPNlAEx7YvFc8b3vRxxc
 v5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742315970; x=1742920770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rbNQxrWPKgNC03cG8BVFNXAwV21VUReGzLMEZsXe10g=;
 b=qI4HSx6vben+llNvkfZAQr+sEE18UzVkuW0w/nMCh4XQnNdMmNpvUAKkO3RDgS1sBw
 NVdLNAOZSqqzQ8RZmWnez1lwdwu0niGD217XXqaKxkSK5zN8MiqupzFq/GwIw3CGgrnl
 9wYgsDuvvRLmWU93OEwUUGLCmSaEsUjRz5co7CUrFxAWXiGY83xppV3mV8z2QOsSQxU8
 BH7jcBdwm9Lr2NgMSGJ0w0C28llTKE56qYxuNg2lWNs13dyVoOgp2dTXcrGf2aZFcDgu
 NJWHyawH3tnFgsYs5vrPrzWtNVCxqK8qxMlqNmTllGO2QtLYeUhFISQRw15vpdH6BwRx
 HGgw==
X-Gm-Message-State: AOJu0YyIFvKPAH+/pz4Omh0C8y1nqaZfUATORR6Xwe0bFYdePX2B/bRU
 d3cUaP5mIIXzq2smNmseDfjyQNdrxZ0crf08PvV84Xdszb6AxEMnw3+jVutg6tFADB19oTJAMws
 sDCQoqACy7evGpwA9+skqHIl6MstcC7QMWTnVBQ==
X-Gm-Gg: ASbGncuWva5gCMaQUFgi6rzaMJHokAshaBYO7BdTNasSwSjJLjpl1jljKR80Wp9Rre9
 3uiK+ftREFUimGJso4vRZpfAe499OMTDvhU8fyF2u533nAny4bsqg2cEBwnJuGyWtCTPXxgJ7vL
 2Hao9YT5JqA61NJOfI9qVjpNcYZDrFcvGtgdyeAQ==
X-Google-Smtp-Source: AGHT+IHrKloikrCHywPESFaPaQZKHGVmGY6cTQ+uE9cw1DS1D6jzP8lp48gv02MCCtp9mQZ4+oxpTqIlPLWJsv1xsVg=
X-Received: by 2002:a05:6902:2701:b0:e60:85ed:8ceb with SMTP id
 3f1490d57ef6-e63f6512b33mr22050871276.22.1742315970334; Tue, 18 Mar 2025
 09:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-15-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-15-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:39:18 +0000
X-Gm-Features: AQ5f1Jruzr4RzXaG_o4fgU4CuCcLtIcR63x8pV0RKxi79gIv6eTCbFbGDSqECr8
Message-ID: <CAFEAcA9_rb321OBOfv9v84ZLO7aw_8t8pTDMUYxj2SNnSBfRmg@mail.gmail.com>
Subject: Re: [PULL 14/24] hw/uefi: add var-service-json.c + qapi for NV vars.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Tue, 4 Mar 2025 at 12:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Define qapi schema for the uefi variable store state.
>
> Use it and the generated visitor helper functions to store persistent
> (EFI_VARIABLE_NON_VOLATILE) variables in JSON format on disk.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20250225163031.1409078-15-kraxel@redhat.com>
> [ incremental fix squashed in ]
> Message-ID: <pji24p6oag7cn2rovus7rquo7q2c6tokuquobfro2sqorky7vu@tk7cxud6jw7f>

Hi; Coverity points out some problems in this code
(CID 1593154, 1593157):


> +void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
> +{
> +    UefiVarStore *vs;
> +    QObject *qobj;
> +    Visitor *v;
> +    char *str;
> +    size_t len;
> +    int rc;
> +
> +    if (uv->jsonfd == -1) {
> +        return;
> +    }
> +
> +    len = lseek(uv->jsonfd, 0, SEEK_END);

lseek() can return -1 on error, but we don't check that
here, so we can proceed forward with a negative length...

> +    if (len == 0) {
> +        return;
> +    }
> +
> +    str = g_malloc(len + 1);

...so we might try to malloc(0) here...

> +    lseek(uv->jsonfd, 0, SEEK_SET);
> +    rc = read(uv->jsonfd, str, len);

...and read() will treat -1 as a very large positive
value, overrunning the buffer.

> +    if (rc != len) {
> +        warn_report("%s: read error", __func__);

If the read failed to read all the data, we need to
bail out now, not proceed to pass the uninitialized
buffer to qobject_from_json().

Coverity doesn't notice it, but the code in
uefi_vars_json_save() is also not handling errors
from lseek() etc correctly.

Do we absolutely need to be operating on a continuously open
filedescriptor here rather than a filename? If we could make
these functions use uv->jsonfile each time then we could use
the glib functions g_file_get_contents() and
g_file_set_contents(), which get all the pesky details of the
error handling right for you.

thanks
-- PMM

