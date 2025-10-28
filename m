Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68918CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjmo-0000OO-5l; Tue, 28 Oct 2025 09:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDjmh-0000O1-Sd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:30:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDjmf-0004Ed-IT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:30:47 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b6d78062424so1243426466b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761658239; x=1762263039; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab0akvkC3mgVWGYARJ9qx4sI05tVRHB3/ShmUCOOMwk=;
 b=U0dRa+OaYhSbb3NuaitbmyTKMGQpL/010roRYQdOsjmlvqVkhhalcp7EwmxZP7ykPc
 uKOnrw53gW51KbaGYerEU28GPgb0//LaNG8N/TOmT3ykbm2gpOAUOiQi+DcH6AKOdJhM
 96iMm04R4wvFm3DTfGIsCapPKQ34qQfo7JlrY/UQF6chaVk4umR+2srW+SkeIpMGgUWy
 ajU2b+NbuZalv4eIoyML7wHvA0Jq/CE+8GYwvWFUpwNjn4xYMzBr7fVPgGAoOvlpmcSk
 XT+IxPPgOndb/jq5xdHLQMt4XDfHzCHqLlzZjdMU8BrzzLxtYdeogA5GMgMMsuJavWXh
 zSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658239; x=1762263039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ab0akvkC3mgVWGYARJ9qx4sI05tVRHB3/ShmUCOOMwk=;
 b=qAw9QZEsl2RBQGN/DvjJ0ZZi7iLHnDFGLUyrjEFaO5xImW9OepWAdgYsLBHEAx4oFC
 ByY/hXmhOCuwtn1r6k3sM2LCPD9jd+mZWUUK0XTquchf8ugsSc5iCVEd10ZZ/HhyGDRd
 ZueAaTuOq5XLCekoisAZf6x5U/rwTuVT3NXG5E7g9IXdgNqOxGsFQfdiyqzLtOdERw+o
 qkMikLD43OOMQzjJAnSmfr2A3fTphNg7R2+rVuhIY7dD3C2DJelCTtgmH0K501thDeI6
 nlkK9xD8ptr+2x5ynLv/SW73kaeQh9TSKBltu8uaPoK5ZAL/B4zYoMi1LhyVzJOIMWT6
 5aNQ==
X-Gm-Message-State: AOJu0YyL7gN9obNch1JaioxnPIbSy6a16mvNyCnYc21ZsB5SZOA9OUy+
 lFwx15BmkqkXWZ/b1LEjDgXPmJuZ1IZCVvc7t0q6HtvjFyigKyWVaRc/3yQ/JmdcKwn/PlkvOR9
 DN80WKWbzbESIL+u06LE7097N6KS1UMI=
X-Gm-Gg: ASbGncv9baU1Jhf6I0xhPChw6ATWWK8xiaIYSiqeMg4hcL0lrSiijZm+FCnsjARoKB5
 66/zHHWzzjzggI984IAU6hIHPvkp/v5dI5WAo/Tyg14Q67MU2bs2Jp9LBB/euCaoHNOxWOKMN1v
 qW/sLQJuzCllr85TzuAvpeEni+Iw8opSIIBda0PMgOt8vCdzDc8Fn/PvRXZGdEl2V22mmcyalf3
 NiUppsOsHQuf1fH3y1CuIhORRC7/Jvi45pzjqLakURA5660eOe31c3VlbUoZE3OsIabJhl1h0HQ
 ECDq86UzG7uOz3O5
X-Google-Smtp-Source: AGHT+IGEKwDSDjx23kdnF4Jh9Lmsm23ITKcOThXaGUr1fTRmeGjyijBG7KD3Xi5yydFvwPxcZ1oU+NiKBWOJFaZ5qJo=
X-Received: by 2002:a17:907:6e88:b0:b6d:3f8c:a2fa with SMTP id
 a640c23a62f3a-b6dba58317amr378764966b.32.1761658238901; Tue, 28 Oct 2025
 06:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-4-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-4-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 17:30:23 +0400
X-Gm-Features: AWmQ_bldgE0LGX31anVT810C7d-aEZ8VcPRcaCnlRGTAOYcQ9hR3Te3iXVuwp9g
Message-ID: <CAJ+F1CLcgEC-XoET_UPM3z2_T_AUi8T5rnj0dbN6BPeDLSmHhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] chardev/char: Improve ChardevClass::chr_write()
 docstring
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Oct 22, 2025 at 7:09=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/chardev/char.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index b65e9981c14..d809bb316e9 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -263,7 +263,16 @@ struct ChardevClass {
>      void (*open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);
>
> -    /* write buf to the backend */
> +    /**
> +     * chr_write: Write data to a character backend
> +     * @s: the character backend to write to
> +     * @buf: the data to write
> +     * @len: the number of bytes to write
> +     *
> +     * Called with chr_write_lock held.
> +     *
> +     * Returns: the number of bytes consumed or -1 on error.

you could add that "errno" is expected to be set in that case.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +     */
>      int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
>
>      /*
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

