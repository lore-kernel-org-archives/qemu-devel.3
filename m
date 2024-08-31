Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8B0CA101B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 01:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skClw-0001rI-Qa; Fri, 30 Aug 2024 21:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skClu-0001q2-T4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 21:19:22 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skClk-0004Q5-1t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 21:19:22 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c2443b2581so2657a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 18:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725067150; x=1725671950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P83RmVUIUARSrgDZJBcrsq3zoz+nVIDRh1dzm2mJqzo=;
 b=v1wSnbZ8DjYT0+bUihh9oF18YKT5yl5nJEdKa3sJkKZzzDHF4RSwVBx1/eNk71ceQC
 4TPNS3S1nzjqnf9J4shIomBcusj4NKtQQY0KCS0Y3xbTPJXg68hA4i+iuXYB9yfcQWHa
 ClSZ+BibSStOuead2+Xt4FI+pwXODzmsSa5oWz47rEB91H88aualROFwNX6qrCiPOSLf
 lU7S6xSfOp1ZSolzkJj/jc0lFuq8tmDFNnQBIoLFLX+T8TZMCPz/o9BfvjLe3yPudBD6
 uUuqq7cqahFuN4k6GaL/Ds6eYnN59ALp92XXdlumJS644Q+5ifG54KJNUc9aB/O9R1Er
 RebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725067150; x=1725671950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P83RmVUIUARSrgDZJBcrsq3zoz+nVIDRh1dzm2mJqzo=;
 b=R4rg1q+kth/xzYNx9h+BG/XeyeGyh1Vx5jd2ByE5vJiguJoeE1Ir3QAWkBkT2LfQmR
 1qa46tWgFD6KWAkV0y5iZXwRnrTdV+qRDmH1VBdzJvD3osjm0Sy7uikWZfGOZIYlx09m
 GKKsQ3AQQILbZuRCg87iTXu2qFXVuPeZrs4MM8sDZAeBJBtJFDSARmNkwAxyEI/B03zR
 RtZ2U6MbpgMKTfZPx5dDZUPrDWfVmR3s3fr2VJtlwUeiHZP8Gas+a33fmz3LHo0koEag
 44O8MuspX69My8Tz4VvN2kQkiMKFJhGeanro62STnli90yPdeNGZ19wWwmSZylcyKCLM
 3z1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsvjGfaNRo3/BA+W0ievKTBXZH7EvbMcQVjBOh14LW/7ltStpXEeq09MD0s0A1pM/xNRNVSA6aqo4y@nongnu.org
X-Gm-Message-State: AOJu0YwwsXnjFKuoUgsGnDcqDsat01HGDzKGa2y4tt/jVoZbEVwHXKDM
 5GDyst5El+K5SufY7sPzD3F5EGDKciwhtsdZ9e+2gJ1gRjwktTdphs4iwgD2dWR8g82RMhdd2z+
 sEiQWb87pZ8fUeFcWMlN6xQE1kpbt6/yYDOoV
X-Google-Smtp-Source: AGHT+IGGud7OXHOe3+DDZZS55JJlcpg48+uIX8VCX9nxAfJV92i6QPAUisasDvrvnw2OWX2eNJlBBM9+FETVBZMLK90=
X-Received: by 2002:a05:6402:278c:b0:5c2:30fa:6ce7 with SMTP id
 4fb4d7f45d1cf-5c245b593c0mr34542a12.3.1725067149906; Fri, 30 Aug 2024
 18:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 18:18:58 -0700
Message-ID: <CAGWr4cRzi9-uhTu_cPytFmHWhkP4wNj-YBMtNCBEHJXtnbyF0w@mail.gmail.com>
Subject: Re: [PATCH 9/9] tests/unit: add test-fifo unit test
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=tavip@google.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 5:23=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> This tests the Fifo8 implementation for basic operations as well as testi=
ng for
> the correct *_bufptr() including handling wraparound of the internal FIFO=
 buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  tests/unit/meson.build |   1 +
>  tests/unit/test-fifo.c | 256 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 tests/unit/test-fifo.c
>
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 490ab8182d..89f9633cd6 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -47,6 +47,7 @@ tests =3D {
>    'test-logging': [],
>    'test-qapi-util': [],
>    'test-interval-tree': [],
> +  'test-fifo': [],
>  }
>
>  if have_system or have_tools
> diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
> new file mode 100644
> index 0000000000..1e54cde871
> --- /dev/null
> +++ b/tests/unit/test-fifo.c
> @@ -0,0 +1,256 @@
> +/*
> + * Fifo8 tests
> + *
> + * Copyright 2024 Mark Cave-Ayland
> + *
> + * Authors:
> + *  Mark Cave-Ayland    <mark.cave-ayland@ilande.co.uk>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "qemu/fifo8.h"
> +
> +const VMStateInfo vmstate_info_uint32;
> +const VMStateInfo vmstate_info_buffer;
> +
> +
> +static void test_fifo8_pop_bufptr_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] =3D { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    buf =3D fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count =3D=3D 2);
> +    g_assert(buf[0] =3D=3D 0x1 && buf[1] =3D=3D 0x2);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    buf =3D fifo8_pop_bufptr(&fifo, 8, &count);
> +    g_assert(count =3D=3D 6);
> +    g_assert(buf[0] =3D=3D 0x3 && buf[1] =3D=3D 0x4 && buf[2] =3D=3D 0x5=
 &&
> +             buf[3] =3D=3D 0x6 && buf[4] =3D=3D 0x7 && buf[5] =3D=3D 0x8=
);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 2);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_bufptr(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    buf =3D fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count =3D=3D 2);
> +    g_assert(buf[0] =3D=3D 0x1 && buf[1] =3D=3D 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 2);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_bufptr_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] =3D { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    buf =3D fifo8_peek_bufptr(&fifo, 2, &count);
> +    g_assert(count =3D=3D 2);
> +    g_assert(buf[0] =3D=3D 0x1 && buf[1] =3D=3D 0x2);
> +
> +    buf =3D fifo8_pop_bufptr(&fifo, 2, &count);
> +    g_assert(count =3D=3D 2);
> +    g_assert(buf[0] =3D=3D 0x1 && buf[1] =3D=3D 0x2);
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +
> +    buf =3D fifo8_peek_bufptr(&fifo, 8, &count);
> +    g_assert(count =3D=3D 6);
> +    g_assert(buf[0] =3D=3D 0x3 && buf[1] =3D=3D 0x4 && buf[2] =3D=3D 0x5=
 &&
> +             buf[3] =3D=3D 0x6 && buf[4] =3D=3D 0x7 && buf[5] =3D=3D 0x8=
);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 8);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_bufptr(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    const uint8_t *buf;
> +    uint32_t count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    buf =3D fifo8_peek_bufptr(&fifo, 2, &count);
> +    g_assert(count =3D=3D 2);
> +    g_assert(buf[0] =3D=3D 0x1 && buf[1] =3D=3D 0x2);
> +with known values.

> +    g_assert(fifo8_num_used(&fifo) =3D=3D 4);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_buf_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] =3D { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[4];

Initialize data_out.

> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    fifo8_pop_buf(&fifo, NULL, 4);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    count =3D fifo8_pop_buf(&fifo, NULL, 4);
> +    g_assert(count =3D=3D 4);
> +    count =3D fifo8_pop_buf(&fifo, data_out, 4);
> +    g_assert(count =3D=3D 4);
> +    g_assert(data_out[0] =3D=3D 0x1 && data_out[1] =3D=3D 0x2 &&
> +             data_out[2] =3D=3D 0x3 && data_out[3] =3D=3D 0x4);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pop_buf(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] =3D { 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8 };
> +    uint8_t data_out[] =3D { 0xff, 0xff, 0xff, 0xff };
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    count =3D fifo8_pop_buf(&fifo, NULL, 4);
> +    g_assert(count =3D=3D 4);
> +    count =3D fifo8_pop_buf(&fifo, data_out, 4);
> +    g_assert(data_out[0] =3D=3D 0x5 && data_out[1] =3D=3D 0x6 &&
> +             data_out[2] =3D=3D 0x7 && data_out[3] =3D=3D 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_buf_wrap(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in1[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_in2[] =3D { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[4];

Initialize data_out.

> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
> +    fifo8_pop_buf(&fifo, NULL, 4);
> +
> +    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
> +    count =3D fifo8_peek_buf(&fifo, NULL, 4);
> +    g_assert(count =3D=3D 4);
> +    count =3D fifo8_peek_buf(&fifo, data_out, 4);
> +    g_assert(count =3D=3D 4);
> +    g_assert(data_out[0] =3D=3D 0x5 && data_out[1] =3D=3D 0x6 &&
> +             data_out[2] =3D=3D 0x7 && data_out[3] =3D=3D 0x8);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 8);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek_buf(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t data_in[] =3D { 0x1, 0x2, 0x3, 0x4 };
> +    uint8_t data_out[] =3D { 0xff, 0xff, 0xff, 0xff };
> +    int count;
> +
> +    fifo8_create(&fifo, 8);
> +
> +    fifo8_push_all(&fifo, data_in, sizeof(data_in));
> +    count =3D fifo8_peek_buf(&fifo, NULL, 4);
> +    g_assert(count =3D=3D 4);
> +    g_assert(data_out[0] =3D=3D 0xff && data_out[1] =3D=3D 0xff &&
> +             data_out[2] =3D=3D 0xff && data_out[3] =3D=3D 0xff);
> +
> +    count =3D fifo8_peek_buf(&fifo, data_out, 4);
> +    g_assert(count =3D=3D 4);
> +    g_assert(data_out[0] =3D=3D 0x1 && data_out[1] =3D=3D 0x2 &&
> +             data_out[2] =3D=3D 0x3 && data_out[3] =3D=3D 0x4);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 4);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_peek(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t c;
> +
> +    fifo8_create(&fifo, 8);
> +    fifo8_push(&fifo, 0x1);
> +    fifo8_push(&fifo, 0x2);
> +
> +    c =3D fifo8_peek(&fifo);
> +    g_assert(c =3D=3D 0x1);
> +    fifo8_pop(&fifo);
> +    c =3D fifo8_peek(&fifo);
> +    g_assert(c =3D=3D 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 1);
> +    fifo8_destroy(&fifo);
> +}
> +
> +static void test_fifo8_pushpop(void)
> +{
> +    Fifo8 fifo;
> +    uint8_t c;
> +
> +    fifo8_create(&fifo, 8);
> +    fifo8_push(&fifo, 0x1);
> +    fifo8_push(&fifo, 0x2);
> +
> +    c =3D fifo8_pop(&fifo);
> +    g_assert(c =3D=3D 0x1);
> +    c =3D fifo8_pop(&fifo);
> +    g_assert(c =3D=3D 0x2);
> +
> +    g_assert(fifo8_num_used(&fifo) =3D=3D 0);
> +    fifo8_destroy(&fifo);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/fifo8/pushpop", test_fifo8_pushpop);
> +    g_test_add_func("/fifo8/peek", test_fifo8_peek);
> +    g_test_add_func("/fifo8/peek_buf", test_fifo8_peek_buf);
> +    g_test_add_func("/fifo8/peek_buf_wrap", test_fifo8_peek_buf_wrap);
> +    g_test_add_func("/fifo8/pop_buf", test_fifo8_pop_buf);
> +    g_test_add_func("/fifo8/pop_buf_wrap", test_fifo8_pop_buf_wrap);
> +    g_test_add_func("/fifo8/peek_bufptr", test_fifo8_peek_bufptr);
> +    g_test_add_func("/fifo8/peek_bufptr_wrap", test_fifo8_peek_bufptr_wr=
ap);
> +    g_test_add_func("/fifo8/pop_bufptr", test_fifo8_pop_bufptr);
> +    g_test_add_func("/fifo8/pop_bufptr_wrap", test_fifo8_pop_bufptr_wrap=
);
> +    return g_test_run();
> +}
> --
> 2.39.2
>

