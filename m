Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7EC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 00:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjp5W-00074L-3n; Thu, 29 Aug 2024 20:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp5V-000727-FN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:02:01 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp5T-0006ET-Eu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 20:02:01 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3df02c407c4so724084b6e.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724976118; x=1725580918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1BaBWLs63JASMpcu464rt7HrmmWkKycJew8ymBkc44=;
 b=L1zM1renrWF/Aewx2JNoameC17hanJluKq94iKyiSZpgsYvYtO3ca6k2GqN8qbjiBB
 EjVvRI5XUPTQvS21zRqHJOLJdb0nFVvSMRPGt0koBAm3a+rK/1CNNosyztx74rNp33OZ
 6aR/Ga02I+xvt3zIEXinnu2d1gVmk7WBHQSgqO49sKDZ3+0dmLTaQwpAgEoFXNot4eMq
 Uak8I21kxarLILur3ueEwB0iIILcFmMu9am3Y2vkZ//IeyYCONX8oztl2W4ypZotNbyJ
 x1LlBKwJLw4DFzCvfvm24hmHb167z+8+bHaQGurrFxoQ0wP//0RjHTJT6T2lAcU2o7Uy
 kIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724976118; x=1725580918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1BaBWLs63JASMpcu464rt7HrmmWkKycJew8ymBkc44=;
 b=xM5/loOHqUDLIZVgr3DHZxKIeGFu1CRYSUmgCOj1NwAo5GowvJLmuTl/xa5GmsuyrD
 5qSJMgzlhQnSIUuLbBi3QcOG9zWA+OAABzs6V0DdRzZHVqUiwvv+TH3pWfIomXvy+WkF
 whFYNdSAJ8WUatxh7PLBihsfi7sRQiIrhhjhXCI+W0o6BiGEAx3o6Za4bcgYIQOUd5lW
 iJg4VkUkld4VisWia1D6OwqvIpnmBWBjS85NZqdYoxM8Vfjtmz91ykWygGkGxYloAVM6
 FMuORrb0P7Jr2OIYz2fX/rwPPN7TsouWgV7FbTik70o78QKu8XpMQ+IbVoTFr3lBESBx
 cefg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxrJx2lDvpuCoy52U+fZ0yGVBruXk7LVS8E/e076iPaSyux1QVOX2Z+OUYaW9fMzuV+W7z8D6kCgY2@nongnu.org
X-Gm-Message-State: AOJu0Yyqpd4GtoKTFZDCyTGVU1yX4MDmOJr73qftYAmnUdoXv1ImyMp7
 YD0wL5fO+nHa7AjqT6THIzIbiDdoVc8ljUBtx7C8Wu2d5eemJOPlBoIHVtJXXE+Dc46aCi2Qld3
 UiqkKXWjooLHwz+IiqDZm0ePw5FdO+A==
X-Google-Smtp-Source: AGHT+IFj6bHmRS2fFAi54fOswoBpqCHwsLqq/C6Scin1axxZl14k8IOgMUr2W/n4o3CJl8oxS3KqR8/qopIzgNTAJ9Q=
X-Received: by 2002:a05:6808:11c4:b0:3d9:b33e:d3ef with SMTP id
 5614622812f47-3df05c1c94fmr4546589b6e.3.1724976117672; Thu, 29 Aug 2024
 17:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 10:01:31 +1000
Message-ID: <CAKmqyKOZw3AJLqQTAhPEQ+o4y8TAndO6_ty6W=0xmoUKd71d4A@mail.gmail.com>
Subject: Re: [PATCH 9/9] tests/unit: add test-fifo unit test
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 10:25=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> This tests the Fifo8 implementation for basic operations as well as testi=
ng for
> the correct *_bufptr() including handling wraparound of the internal FIFO=
 buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> +
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
>

