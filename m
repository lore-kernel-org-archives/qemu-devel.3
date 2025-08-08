Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9745C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 18:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRqu-0006Tm-3X; Fri, 08 Aug 2025 14:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukRqr-0006TI-PA
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:30:02 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukRqp-00033K-FZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:30:01 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-617d43a5fd3so2591614a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754677797; x=1755282597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiqQNJGRVIABq87XutzBDroaQVmvh+1x1UVuGnyeJcw=;
 b=ZRGcHY4qdPOEn2SRME3Fao/MPp/YwlXlaWZj6EMMYVLr93YsxXEqKCdBey2sfiSxOm
 uyklG5uWjHJneTEdI6yYeSufOKBVExavUYUhuVSEKsIZYRuNesA93+aLXICzT0qDsBRN
 8jsX4lFsgYe2AEUigD7ye5T5Pe7XWmniWqZfPzd4GxvXJSlgzFX2bmAGBzcpP6CZnbXR
 ckkiI/03KN+shptyrv2Ci6dpooGb5RCqFOyTjRjH2b2htZQJMmxlkFeqOwpXRvIyz1hT
 oqzg4NwhGqDIybaWdclR1v4WEXhI8vVCUBhWCj4T43QW5nQo/bR6J4NMBZIQvW3a/F/1
 Enhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677797; x=1755282597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiqQNJGRVIABq87XutzBDroaQVmvh+1x1UVuGnyeJcw=;
 b=dv8DmjnHlNmW9zhjwMLRTLa/G82Ez3xpD7ibO5CWwdne7fSPD0ADkGza19XtdWYtJt
 EpaJ5n7z1bwGeTT9CfDBami58t19mfpktFR09yBqgTssvAdDNN7XPKouw92ewxBJTu2s
 nht6z7zVz2gNzTMV82kMfHzf0RasNNdYs9WcQnC9SWMqOf5VG3WVNlhPlVwkNtsaJecZ
 9klUSYQ75Er4LMMk5E+gdlvbt3sOoNygy32+Y4KZ0NmvQJuGT76kyEiB5D05fysF2P0Z
 BTS93vudfgeuOoENzZb9WvMEh82rRLCpfqlhgpJqi8fy9JlU1jTupwLmnPzWoYmGkc9B
 Al/w==
X-Gm-Message-State: AOJu0Ywi6AQc33UQI5sSNVAWW2hJFN3w9U+mPq2WLUiMSZnf3BewmnP9
 /xGeLNX8fLT5tw8OVZp2Sp3cp7udwGE7ylWiWcIlzaL0z9w9fg75Y24T08GpVHQ5cOOySME6/4Q
 yibUcFcKBbEusExMLdnqDi0Y2IiUiSn1JTegXubqKHw==
X-Gm-Gg: ASbGncucu5LizbSWNDcTlS0//6Pm3uMfUxLeWJN0Mul+v3t5pCLkmBnGDkYoZyyR5rW
 Y6wII+55KFcm/vNrNz+XuhJPUaSDnjEW4ADVylMZBj86E5aJNToWVrC9++9b7Gjz0oozozrVbMC
 TxyifwCBjivIjaCQXsPMnZhEoj5WTBWgfoHlNS0YS5viXRQTf80Q8dJ74CpnnJtWKebr1hmxHFU
 h6YPjtu7ZizUN9tcVo=
X-Google-Smtp-Source: AGHT+IEalXPmE9FlqxxW0jAlPZljbYZujXgOv9wk//NuARxiNvT0RcZEU17e8kWpq798+85vhkJONNKmzeZUA8jliBI=
X-Received: by 2002:a05:6402:1e89:b0:609:9115:60f1 with SMTP id
 4fb4d7f45d1cf-617e2c4c6bamr3243286a12.16.1754677796725; Fri, 08 Aug 2025
 11:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
 <401440fc-c25b-4abc-94d2-4b21593c6eac@linaro.org>
 <CAAjaMXbM_7rt_2dSjmZixcPs7=g3HU2yfJ-ZMvUJOtCeEaJZ9A@mail.gmail.com>
 <a26e72e7-aa29-4f44-97b9-f9d2ed9d47d5@linaro.org>
In-Reply-To: <a26e72e7-aa29-4f44-97b9-f9d2ed9d47d5@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Aug 2025 21:29:29 +0300
X-Gm-Features: Ac12FXwn4uusaIgxyP7AgQhYEe8YOxU7DKB1LFUA8sKK9H_yc63QbVwT22tt2Kg
Message-ID: <CAAjaMXaaoQX48+r5_WTQCPSmDc=3SU2dcf8EESf5inimdh6mOg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, Aug 8, 2025 at 9:23=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/8/25 11:13 AM, Manos Pitsidianakis wrote:
> > On Fri, Aug 8, 2025 at 9:03=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
> >>> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.=
org> wrote:
> >>>> We implement tracing, following uftrace format.
> >>>> Trace is flushed every 32 MB, so file operations don't impact
> >>>> performance at runtime.
> >>>>
> >>>> A different trace is generated per cpu, and we ensure they have a un=
ique
> >>>> name, based on vcpu_index, while keeping room for privilege level co=
ming
> >>>> in next commit.
> >>>
> >>> Suggestion (not a request): put some kind of documentation about the
> >>> format this patch implements, maybe a commit sha & URL to a header fi=
le
> >>> from upstream uftrace.
> >>>
> >>>>
> >>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>>> ---
> >>>> contrib/plugins/uftrace.c | 149 ++++++++++++++++++++++++++++++++++++=
+-
> >>>> 1 file changed, 148 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> >>>> index d51faceb344..402a242433e 100644
> >>>> --- a/contrib/plugins/uftrace.c
> >>>> +++ b/contrib/plugins/uftrace.c
> >>>> @@ -12,6 +12,13 @@
> >>>> #include <qemu-plugin.h>
> >>>> #include <glib.h>
> >>>> #include <stdio.h>
> >>>> +#include <sys/stat.h>
> >>>> +#include <sys/time.h>
> >>>> +#include <time.h>
> >>>> +#include <unistd.h>
> >>>> +
> >>>> +#define MiB     (INT64_C(1) << 20)
> >>>> +#define NANOSECONDS_PER_SECOND 1000000000LL
> >>>>
> >>>> QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> >>>>
> >>>> @@ -24,6 +31,13 @@ typedef struct {
> >>>>       uint64_t frame_pointer;
> >>>> } CallstackEntry;
> >>>>
> >>>> +typedef struct {
> >>>> +    GArray *t;
> >>>> +    GString *path;
> >>>> +    GString *name;
> >>>> +    uint32_t id;
> >>>> +} Trace;
> >>>> +
> >>>> typedef struct Cpu Cpu;
> >>>>
> >>>> typedef struct {
> >>>> @@ -34,6 +48,7 @@ typedef struct {
> >>>> } CpuOps;
> >>>>
> >>>> typedef struct Cpu {
> >>>> +    Trace *trace;
> >>>>       Callstack *cs;
> >>>>       GByteArray *buf;
> >>>>       CpuOps ops;
> >>>> @@ -44,9 +59,41 @@ typedef struct {
> >>>>       struct qemu_plugin_register *reg_fp;
> >>>> } Aarch64Cpu;
> >>>>
> >>>> +typedef struct {
> >>>> +    uint64_t timestamp;
> >>>> +    uint64_t data;
> >>>> +} UftraceEntry;
> >>>> +
> >>>> +typedef enum {
> >>>> +    UFTRACE_ENTRY,
> >>>> +    UFTRACE_EXIT,
> >>>> +    UFTRACE_LOST,
> >>>> +    UFTRACE_EVENT
> >>>> +} UftraceRecordType;
> >>>> +
> >>>> static struct qemu_plugin_scoreboard *score;
> >>>> static CpuOps arch_ops;
> >>>>
> >>>> +static uint64_t gettime_ns(void)
> >>>> +{
> >>>> +#ifdef _WIN32
> >>>> +    /*
> >>>> +     * On Windows, timespec_get is available only with UCRT, but no=
t with
> >>>> +     * MinGW64 environment. Simplify by using only gettimeofday on =
this
> >>>> +     * platform. This may result in a precision loss.
> >>>> +     */
> >>>> +    struct timeval tv;
> >>>> +    gettimeofday(&tv, NULL);
> >>>> +    uint64_t now_ns =3D tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_=
usec * 1000;
> >>>> +#else
> >>>> +    /* We need nanosecond precision for short lived functions. */
> >>>> +    struct timespec ts;
> >>>> +    timespec_get(&ts, TIME_UTC);
> >>>> +    uint64_t now_ns =3D ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_=
nsec;
> >>>> +#endif
> >>>> +    return now_ns;
> >>>> +}
> >>>> +
> >>>> static Callstack *callstack_new(void)
> >>>> {
> >>>>       Callstack *cs =3D g_new0(Callstack, 1);
> >>>> @@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *=
cs)
> >>>>       return e;
> >>>> }
> >>>>
> >>>> +static Trace *trace_new(uint32_t id, GString *name)
> >>>> +{
> >>>> +    Trace *t =3D g_new0(Trace, 1);
> >>>> +    t->t =3D g_array_new(false, false, sizeof(UftraceEntry));
> >>>> +    t->path =3D g_string_new(NULL);
> >>>> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat",=
 id);
> >>>> +    t->name =3D g_string_new(name->str);
> >>>> +    t->id =3D id;
> >>>> +    return t;
> >>>> +}
> >>>> +
> >>>> +static void trace_free(Trace *t)
> >>>> +{
> >>>> +    g_assert(t->t->len =3D=3D 0);
> >>>> +    g_array_free(t->t, true);
> >>>> +    t->t =3D NULL;
> >>>> +    g_string_free(t->path, true);
> >>>> +    t->path =3D NULL;
> >>>> +    g_string_free(t->name, true);
> >>>> +    t->name =3D NULL;
> >>>> +    g_free(t);
> >>>> +}
> >>>> +
> >>>> +static void trace_flush(Trace *t, bool append)
> >>>> +{
> >>>> +    int create_dir =3D g_mkdir_with_parents("./uftrace.data",
> >>>> +                                          S_IRWXU | S_IRWXG | S_IRW=
XO);
> >>>> +    g_assert(create_dir =3D=3D 0);
> >>>> +    FILE *dat =3D fopen(t->path->str, append ? "a" : "w");
> >>>> +    g_assert(dat);
> >>>> +    GArray *data =3D t->t;
> >>>> +    if (data->len) {
> >>>> +        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
> >>>
> >>> fwrite might not write all bytes, how about using the
> >>> g_file_set_contents() wrapper?
> >>>
> >>
> >> If I see correctly, g_file_set_contents does not allow to append data,
> >> which is what we need to do here (that's the point of flushing every
> >> 32MB).
> >
> > Ah you're right, my bad. It might be because it renames a temporary
> > file to the destination filename in order to make the operation
> > atomic.
> >
> >> I can add an assert on fwrite return to make sure we wrote
> >> everything.
> >
> > Or a while loop with a bytes_written counter.
> >
>
> fwrite guarantees all data will be written (to the opposite or raw write
> calls), including if syscall is interrupted, doing a proper write loop
> until all data is written.

Right, as the manpage says:

> RETURN VALUE
>      On success, fread() and fwrite() return the number of items read or =
written.  This number equals the number of bytes transferred only when size=
 is 1.  If an error occurs, or the
>      end of the file is reached, the return value is a short item count (=
or zero).

I thought it meant that "on error" included EAGAIN/EINTR, that's why I
suggested a loop. But the manpage doesn't list error values or even
mention whether it sets errno at all so I was mistaken.

> You can check glibc source if in doubt.
> Thus, the only situation where it might fail is if disk space is full.
> In this case, I think that an assert (similar to a panic!) is good
> enough because we can't really do anything to solve the problem.
>
> > Or keep it all in memory and write it on exit? Your call
>
> That was the first version, but it does not scale on long executions,
> where traces can reach several gb.
>
> By the way, adding the assert caught a bug, size and num_elems were
> reversed, so definitely thanks for pointing this out.

