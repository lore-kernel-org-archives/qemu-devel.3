Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A49C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx3d-0000wE-Jf; Mon, 21 Jul 2025 16:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1udx2a-00006U-Hs
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:23:23 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1udx2W-0002VX-P8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:23:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0a0cd709bso1062279766b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753129391; x=1753734191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogMFFYMusu5XRe92HjUn+LUZWun1FYTWN+9Ivw7xuwQ=;
 b=NM/U4G9R+wt1kXLODezH9fIn0xIetJhXdR16jOFBuo2CNGAcEk5/acOBrTknN9wPZ9
 IhfUdgZXtAQoQbCYTYBMsUly0YhVzeG+YjwPiteFGdMArpWRddnMD7nGLshLFj4hqkeG
 EQ+adc7NxE+DgHmgs/RQy2QL4bxqmbEERT6Q6DcHnFq0QttzE4A6Bu7xdV8hnVnY8gBz
 Ibq9OGsJ84Z66hViGdFE8J6w9Qo/95nEUaPy+V+nm1G7yue8VO5BCrU28qjAWPliEhGD
 q/6sCwZsHS18Mb4FQGgOPQ+Z2BH/JZvnejMJvl/o0jUqB69FloVp6qN8g26Sr5WUea8c
 re3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129391; x=1753734191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogMFFYMusu5XRe92HjUn+LUZWun1FYTWN+9Ivw7xuwQ=;
 b=Zt9N2LDYmQgcdydk+qn+6Do0JtZ6vdYqknVChmaGS2nDdnZQiWPoEgPpnZM7geNtEc
 UyzolO1fT7uI8ldpNQJA1VkquQVGLo0jFCYcYwX4TYPjyK5zlp7GFRZBHoqIb5gBbANU
 sr+PJbGdhu4YkTFVA/m0qGfB3/ba0d9zO1hQP+zkobiyDksyKXN4dTOZCRv0+Q4DHVAA
 4ZLR8PXOOErgzqOlBAHoiuAqqL4fnktPKNW427Nnx3XfGvk9wtAzuMHL7m2g45pS5OUf
 K2101hj+sXzANxTULWLcCoaFBLeaBMf821bGYq9p6z979NzWNzQIh/szbsyRWrqGKCUB
 oWMA==
X-Gm-Message-State: AOJu0YygYb2mbdMbeRO6gyFcey4u+QHy8pDKUuppRp5NDNESDLE/Wmbc
 0MY8JxBnuHw9KKKWTRReT/gwJfS785oLJAH+6l3zzjXXi+2RuiGvYNdOHKh/46WHElNbxY/Xya2
 bA9Ap9YnITIfME8TzLy0g48SUbxaE5rs=
X-Gm-Gg: ASbGncu9F08MKG1DRlnTrtSVOFMBYAcbevVZPkVEV160ldLJib75VZ8TC0rUfHiO9Vh
 N6gKE4igwvH5aPe+yEUN26QmNu7lYiYnlB9jMZjccyY6P2pGD1lvEN2dqX1DWsVDpYEnmde/SA1
 NBSJt2EVeUfFuG4fTzdkKqw4+3zszXV53RzNkrMA4mtqtP+gXJktbUpWEQKve1wjLTb7qUdNqBt
 we8Uq5X3hTvnf1i
X-Google-Smtp-Source: AGHT+IG7gaBt+YYY5fXF32Gh20Opflze2sqqKQs+lfJeEto5iIhp3wecCH6BKXwTvjSGh5a1Kp1JlOImhzbHf2070iw=
X-Received: by 2002:a17:907:7246:b0:ae0:7e95:fb with SMTP id
 a640c23a62f3a-af1523a411cmr84594866b.5.1753129390563; Mon, 21 Jul 2025
 13:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250721185452.3016488-1-berrange@redhat.com>
In-Reply-To: <20250721185452.3016488-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Jul 2025 16:22:58 -0400
X-Gm-Features: Ac12FXxmtxeVw9uBPKvuTLj6ShZHwaPBnLBX2d2YcuaTIsCLDgken36l6bLAhC0
Message-ID: <CAJSP0QURmoyn6oZFtMOaivs3rh82-zzQ5wxmtLEG5D3jfx+Kxw@mail.gmail.com>
Subject: Re: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x634.google.com
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

On Mon, Jul 21, 2025 at 2:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> Currently the tracing 'log' back emits special code to add timestamps
> to trace points sent via qemu_log(). This current impl is a bad design
> for a number of reasons.
>
>  * It changes the QEMU headers, such that 'error-report.h' content
>    is visible to all files using tracing, but only when the 'log'
>    backend is enabled. This has led to build failure bugs as devs
>    rarely test without the (default) 'log' backend enabled, and
>    CI can't cover every scenario for every trace backend.
>
>  * It bloats the trace points definitions which are inlined into
>    every probe location due to repeated inlining of timestamp
>    formatting code, adding MBs of overhead to QEMU.
>
>  * The tracing subsystem should not be treated any differently
>    from other users of qemu_log. They all would benefit from
>    having timestamps present.
>
>  * The timestamp emitted with the tracepoints is in a needlessly
>    different format to that used by error_report() in response
>    to '-msg timestamp=3Don'.
>
> This fixes all these issues simply by moving timestamp formatting
> into qemu_log, using the same approach as for error_report.
>
> The code before:
>
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           if (message_with_timestamp) {
>               struct timeval _now;
>               gettimeofday(&_now, NULL);
>               qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS cr=
eds path creds=3D%p filename=3D%s path=3D%s" "\n",
>                        qemu_get_thread_id(),
>                        (size_t)_now.tv_sec, (size_t)_now.tv_usec
>                        , creds, filename, path);
>           } else {
>               qemu_log("qcrypto_tls_creds_get_path " "TLS creds path cred=
s=3D%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>           }
>       }
>   }
>
> and after:
>
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=3D=
%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>       }
>   }
>
> The log and error messages before:
>
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 lo=
ad creds=3D0x55d925bd9490 dir=3D/var/home/berrange/tls
>   2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path cre=
ds=3D0x55d925bd9490 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>
> and after:
>
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 =
load creds=3D0x55bf5bf12380 dir=3D/var/home/berrange/tls
>   2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path c=
reds=3D0x55bf5bf12380 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory

This does what Vladimir's patch did but also reduces the binary size
and solves the #include pollution. I'll treat this as a replacement
for Vladimir's patch.

Vladimir: Please let me know if anything is missing from this patch.

>
> The binary size before:
>
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
>
> and after:
>
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/tracetool/backend/log.py | 14 +-------------
>  util/log.c                       | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index 17ba1cd90e..bd6739ae41 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -20,7 +20,6 @@
>
>  def generate_h_begin(events, group):
>      out('#include "qemu/log-for-trace.h"',
> -        '#include "qemu/error-report.h"',
>          '')
>
>
> @@ -36,20 +35,9 @@ def generate_h(event, group):
>          cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
>
>      out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> -        '        if (message_with_timestamp) {',
> -        '            struct timeval _now;',
> -        '            gettimeofday(&_now, NULL);',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",=
',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec'=
,
> -        '                     %(argnames)s);',
> +        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        } else {',
> -        '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> -        '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        }',
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
> diff --git a/util/log.c b/util/log.c
> index 58d24de48a..abdcb6b311 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
>
>  void qemu_log(const char *fmt, ...)
>  {
> -    FILE *f =3D qemu_log_trylock();
> +    FILE *f;
> +    g_autofree const char *timestr =3D NULL;
> +
> +    /*
> +     * Prepare the timestamp *outside* the logging
> +     * lock so it better reflects when the message
> +     * was emitted if we are delayed acquiring the
> +     * mutex
> +     */
> +    if (message_with_timestamp) {
> +        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
> +        timestr =3D g_date_time_format_iso8601(dt);
> +    }
> +
> +    f =3D qemu_log_trylock();
>      if (f) {
>          va_list ap;
>
> +        if (timestr) {
> +            fprintf(f, "%s ", timestr);
> +        }
> +
>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);
> --
> 2.50.1
>
>

