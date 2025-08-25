Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4B8CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRL1-0007ci-HD; Mon, 25 Aug 2025 03:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRKw-0007bc-Lb
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:09:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRKu-00008p-2d
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:09:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-618aea78f23so5785877a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756105784; x=1756710584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRBwrJo508bAhFQkiQPWTiu1r0zd77q9xRNxekkIhcs=;
 b=z7iOSK0wW1pE7+2189ManvAspgihmpfupxflKm+ZAA/PCPcszJy8qfNUInfUoL0Osu
 SOTQIGRHQ0Ww8hnaNGY2i9SjL5dMfyjXO40ZYnA+R//nu1tOwllI6gS2ai4IAAt4GdVV
 hc4uLJTYHDEi/YxG5jBoQOuIyLSW+ZR3eiSNadVIL5NRZfqhVJlRm31eItr27tu6KjG+
 d6TmBJBg4RCkWg52GYvIRA/81LoeAcaJFgSG9yHAeAgcwJX5NVmGD14+d7naBvGdaV9u
 yb+ngoL1nb0klAFmSNRezHxQ3cEbZwgKqC36ragjPkMDbS+DFr8jbIzblqZf0WIJY5Q9
 4M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756105784; x=1756710584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRBwrJo508bAhFQkiQPWTiu1r0zd77q9xRNxekkIhcs=;
 b=GrHKUVAKVSoSUvx6RSwXeCMb+K7FnNAwCRdMNSftXSHsWhRxUiD+bMIjCE1CzSqWM5
 m7qDvEyrOfYt3U8dl0mQt3Qi2r0v96WMeY0w1RIEHtChRWgMqXwvOsr0Ydr+ZQ+phQBn
 hy3WfpJM8DHepR2tKf5zZLqECm96a7DittcO1U/7B7tMKJFMISRn4Mm8y6zl6XyXbRxG
 CpHkWwjcox9Z400op7cjjb1Ax3+KWlk4L+YUIeCYFvhEC284QN460XJFwSedOv7SbTYV
 go+ce0nEm6xAhCK7Bqk2E3HjgZmvd/X+dKACLZv6IdquLUnwzh8bGsi4x9pjyRklzukS
 2gjQ==
X-Gm-Message-State: AOJu0Yxff5tjxu8NsysYyW4gxBlBzTC6J6AZpY8fxQduohgL74BODziL
 W6pyTBCbrXdFj+FavT53c1KfyGGr7n9HauctTSDMT2L1yjqRqyPyufjePlcnDPG2QmYucsW9qer
 wBGEk97rurh4ncncyN37EJpSNV0TPErfhs8A4qfKKFQ==
X-Gm-Gg: ASbGncvM94I59b98M9k1mLH1ceapBEbqQqOSW2D70uZueT0scaYvrRH3XTXn2A/7BY2
 kBHOmdLwPPmkhubI0tnFROCFoq6EDIPopCNI588xpF3mzwLCGAeVliuN4IjeFd6wY6yomZ38oWj
 sNms6r4F32DYRRIMmHNH7TQHbofxt1JkSvtU6FOH9RSPg2aN1ymQa07ji/TolFsqCRDnxx/cJN6
 daoGzoU
X-Google-Smtp-Source: AGHT+IEddX1Do0891/zexmfM/VMUBNVkDYQ0jVvSEMlwvtJA3taFfufw/QDcLMKDvk+maDPlNOlW0+kQSdrdJkh+m8E=
X-Received: by 2002:a05:6402:2688:b0:61c:35ff:ed87 with SMTP id
 4fb4d7f45d1cf-61c35fff0a1mr5356881a12.18.1756105782152; Mon, 25 Aug 2025
 00:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-4-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:09:16 +0300
X-Gm-Features: Ac12FXxitsH8-4SNQc2e-2zMfkYAhCoBunJKfL9sb084GrI3_KwXs0QGrsA_7GA
Message-ID: <CAAjaMXZnii96vfjZuGSVg69R01i1v3xidhb5sOTKheLDQEVpjQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, Aug 22, 2025 at 3:28=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This simplifies the Python code and reduces the size of the tracepoints.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Nice.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tests/tracetool/ftrace.h            | 28 ++++++----------------------
>  trace/ftrace.h                      |  1 +
>  trace/ftrace.c                      | 15 +++++++++++++++
>  scripts/tracetool/backend/ftrace.py | 12 ++----------
>  4 files changed, 24 insertions(+), 32 deletions(-)
>
> diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
> index fe22ea0f09f..1dfe4239413 100644
> --- a/tests/tracetool/ftrace.h
> +++ b/tests/tracetool/ftrace.h
> @@ -21,18 +21,10 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
>
>  static inline void trace_test_blah(void *context, const char *filename)
>  {
> -    {
> -        char ftrace_buf[MAX_TRACE_STRLEN];
> -        int unused __attribute__ ((unused));
> -        int trlen;
> -        if (trace_event_get_state(TRACE_TEST_BLAH)) {
> +    if (trace_event_get_state(TRACE_TEST_BLAH)) {
>  #line 4 "trace-events"
> -            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,
> -                             "test_blah " "Blah context=3D%p filename=3D=
%s" "\n" , context, filename);
> -#line 33 "ftrace.h"
> -            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);
> -            unused =3D write(trace_marker_fd, ftrace_buf, trlen);
> -        }
> +        ftrace_write("test_blah " "Blah context=3D%p filename=3D%s" "\n"=
 , context, filename);
> +#line 28 "ftrace.h"
>      }
>  }
>
> @@ -42,18 +34,10 @@ static inline void trace_test_blah(void *context, con=
st char *filename)
>
>  static inline void trace_test_wibble(void *context, int value)
>  {
> -    {
> -        char ftrace_buf[MAX_TRACE_STRLEN];
> -        int unused __attribute__ ((unused));
> -        int trlen;
> -        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
> +    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
>  #line 5 "trace-events"
> -            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,
> -                             "test_wibble " "Wibble context=3D%p value=
=3D%d" "\n" , context, value);
> -#line 54 "ftrace.h"
> -            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);
> -            unused =3D write(trace_marker_fd, ftrace_buf, trlen);
> -        }
> +        ftrace_write("test_wibble " "Wibble context=3D%p value=3D%d" "\n=
" , context, value);
> +#line 41 "ftrace.h"
>      }
>  }
>  #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
> diff --git a/trace/ftrace.h b/trace/ftrace.h
> index cb5e35d2171..16c122816d1 100644
> --- a/trace/ftrace.h
> +++ b/trace/ftrace.h
> @@ -8,5 +8,6 @@
>  extern int trace_marker_fd;
>
>  bool ftrace_init(void);
> +G_GNUC_PRINTF(1, 2) void ftrace_write(const char *fmt, ...);
>
>  #endif /* TRACE_FTRACE_H */
> diff --git a/trace/ftrace.c b/trace/ftrace.c
> index 9749543d9b2..6875faedb9c 100644
> --- a/trace/ftrace.c
> +++ b/trace/ftrace.c
> @@ -38,6 +38,21 @@ static int find_mount(char *mount_point, const char *f=
stype)
>      return ret;
>  }
>
> +void ftrace_write(const char *fmt, ...)
> +{
> +    char ftrace_buf[MAX_TRACE_STRLEN];
> +    int unused __attribute__ ((unused));
> +    int trlen;
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    trlen =3D vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
> +    va_end(ap);
> +
> +    trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);
> +    unused =3D write(trace_marker_fd, ftrace_buf, trlen);
> +}
> +
>  bool ftrace_init(void)
>  {
>      char mount_point[PATH_MAX];
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index 5fa30ccc08e..a07f8a9dfd8 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -28,18 +28,10 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
>
> -    out('    {',
> -        '        char ftrace_buf[MAX_TRACE_STRLEN];',
> -        '        int unused __attribute__ ((unused));',
> -        '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
> +    out('    if (trace_event_get_state(%(event_id)s)) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
> -        '                             "%(name)s " %(fmt)s "\\n" %(argnam=
es)s);',
> +        '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> -        '            unused =3D write(trace_marker_fd, ftrace_buf, trlen=
);',
> -        '        }',
>          '    }',
>          name=3Devent.name,
>          args=3Devent.args,
> --
> 2.50.1
>
>

