Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5FAC7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 18:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUrZe-0006DZ-Ld; Thu, 26 Jun 2025 14:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uUrZc-0006DA-7V
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uUrZX-0003Um-F9
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750963420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hM9iXESrITi5qXUgD0C966+7uVuon8MGl66zQpBrmXY=;
 b=fasW6xohqzsv4AhItMgcZw441ik6oOhi3q/FsOcFMcDlDdLXSTWEmjCKsd13S0sNK4CWBf
 U4uZRoVqMAOhJU13LvIoSMBTeXSJ9m0dQJ4DwDuK3G3TKfoS+Jbobwmdgn/WHo7RM9ZiRZ
 LoFoKZIqBV6G4rH1aVzKNb82GMustng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-Ujan1bDAN5qPzSK5Kl2T5g-1; Thu,
 26 Jun 2025 14:43:38 -0400
X-MC-Unique: Ujan1bDAN5qPzSK5Kl2T5g-1
X-Mimecast-MFC-AGG-ID: Ujan1bDAN5qPzSK5Kl2T5g_1750963417
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45ABC1944A8D; Thu, 26 Jun 2025 18:43:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.90])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97F5D30002C0; Thu, 26 Jun 2025 18:43:36 +0000 (UTC)
Date: Thu, 26 Jun 2025 14:43:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, pbonzini@redhat.com
Subject: Re: [PATCH v3] tracetool: generates conitional checks when needed
Message-ID: <20250626184335.GA152840@fedora>
References: <20250624190336.GA19307@fedora>
 <20250625123023.33428-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3n//5Zgar1wd4WYt"
Content-Disposition: inline
In-Reply-To: <20250625123023.33428-1-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--3n//5Zgar1wd4WYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 12:30:23PM +0000, Tanish Desai wrote:
> Adds generate_conditional, allowing backends to wrap generate()
> output in a trace_event_get_state(...) check if needed.
>=20
> Removes no_check by inlining its logic into trace_foo(...).
> Also ensures the generated code is formatted properly.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/ftrace.py   | 16 +++++++-------
>  scripts/tracetool/backend/log.py      | 26 +++++++++++++----------
>  scripts/tracetool/backend/simple.py   |  4 ++++
>  scripts/tracetool/backend/syslog.py   |  4 ++++
>  scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
>  6 files changed, 46 insertions(+), 37 deletions(-)

This patch does not apply to qemu.git/master. When posting new revisions
of patches, please resend the entire patch series that this belongs to
or send it as a separate patch with the Based-on: <message-id> trailer
to let people (and tools) know which unmerged patch series it depends
on.

>=20
> diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/ba=
ckend/__init__.py
> index c4456a5efd..dc0806f8d0 100644
> --- a/scripts/tracetool/backend/__init__.py
> +++ b/scripts/tracetool/backend/__init__.py
> @@ -118,6 +118,9 @@ def generate_begin(self, events, group):
>      def generate(self, event, group):
>          self._run_function("generate_%s", event, group)
> =20
> +    def generate_conditional(self, hasCondition):
> +        self._run_function("generate_%s_conditional", hasCondition)
> +   =20
>      def generate_unconditional(self, event, group):
>          self._run_function("generate_%s_unconditional", event, group)
>     =20
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index 2d6d608add..d579139532 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -30,17 +30,15 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
> =20
> -    out('    {',
> -        '        char ftrace_buf[MAX_TRACE_STRLEN];',
> +    out('        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
>          '        int trlen;',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
> -        '                             "%(name)s " %(fmt)s "\\n" %(argnam=
es)s);',
> +        '        trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
> +        '                         "%(name)s " %(fmt)s "\\n" %(argnames)s=
);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> -        '            unused =3D write(trace_marker_fd, ftrace_buf, trlen=
);',
> -        '    }',
> +        '        trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> +        '        unused =3D write(trace_marker_fd, ftrace_buf, trlen);',
>          name=3Devent.name,
>          args=3Devent.args,
>          event_lineno=3Devent.lineno,
> @@ -52,3 +50,7 @@ def generate_h(event, group):
>  def generate_h_backend_dstate(event, group):
>      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
>          event_id=3D"TRACE_" + event.name.upper())
> +
> +
> +def generate_h_conditional(hasCondition):
> +    hasCondition[0] =3D hasCondition[0] or True
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend=
/log.py
> index 35a3aeee55..119e24af04 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -31,22 +31,22 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
> =20
> -    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
> -        '        if (message_with_timestamp) {',
> -        '            struct timeval _now;',
> -        '            gettimeofday(&_now, NULL);',
> +    out('        if (qemu_loglevel_mask(LOG_TRACE)) {',
> +        '            if (message_with_timestamp) {',
> +        '                struct timeval _now;',
> +        '                gettimeofday(&_now, NULL);',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",=
',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> -        '                     %(argnames)s);',
> +        '                qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\=
\n",',
> +        '                         qemu_get_thread_id(),',
> +        '                         (size_t)_now.tv_sec, (size_t)_now.tv_u=
sec',
> +        '                         %(argnames)s);',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '        } else {',
> +        '            } else {',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
> +        '                qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s)=
;',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> +        '            }',
>          '        }',
> -        '    }',
>          event_lineno=3Devent.lineno,
>          event_filename=3Dos.path.relpath(event.filename),
>          name=3Devent.name,
> @@ -57,3 +57,7 @@ def generate_h(event, group):
>  def generate_h_backend_dstate(event, group):
>      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
>          event_id=3D"TRACE_" + event.name.upper())
> +
> +   =20
> +def generate_h_conditional(hasCondition):
> +    hasCondition[0] =3D hasCondition[0] or True
> diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/back=
end/simple.py
> index ce8036f5da..316f39727b 100644
> --- a/scripts/tracetool/backend/simple.py
> +++ b/scripts/tracetool/backend/simple.py
> @@ -97,3 +97,7 @@ def generate_c(event, group):
>      out('    trace_record_finish(&rec);',
>          '}',
>          '')
> +
> +
> +def generate_h_conditional(hasCondition):
> +    hasCondition[0] =3D hasCondition[0] or True
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index f84cec641c..a224bd1922 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -43,3 +43,7 @@ def generate_h(event, group):
>  def generate_h_backend_dstate(event, group):
>      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
>          event_id=3D"TRACE_" + event.name.upper())
> +
> +
> +def generate_h_conditional(hasCondition):
> +    hasCondition[0] =3D hasCondition[0] or True
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index 7bbe6d3148..7a5a32d518 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -59,21 +59,10 @@ def generate(events, backend, group):
> =20
>          out('    false)')
> =20
> -        # tracer without checks
> -        out('',
> -            'static inline void %(api)s(%(args)s)',
> -            '{',
> -            api=3De.api(e.QEMU_TRACE_NOCHECK),
> -            args=3De.args)
> -
> -        if "disable" not in e.properties:
> -            backend.generate(e, group)
> -
> -        out('}')
> -
>          event_id =3D 'TRACE_' + e.name.upper()
>          cond =3D "trace_event_get_state(%s)" % event_id
> -
> +        hasCondition =3D [False]
> +        backend.generate_conditional(hasCondition)
>          out('',
>              'static inline void %(api)s(%(args)s)',
>              '{',
> @@ -83,13 +72,16 @@ def generate(events, backend, group):
>          if "disable" not in e.properties:
>              backend.generate_unconditional(e, group)
> =20
> -        out('    if (%(cond)s) {',
> -            '        %(api_nocheck)s(%(names)s);',
> -            '    }',
> -            '}',
> -            api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> -            names=3D", ".join(e.args.names()),
> +        if hasCondition[0]:
> +            out('    if (%(cond)s) {',
>              cond=3Dcond)
> +       =20
> +        if "disable" not in e.properties:
> +            backend.generate(e, group)
> +
> +        if hasCondition[0]:
> +            out('    }')
> +        out('}')

This doesn't handle cases where some backends (like dtrace) do not want
trace_event_get_state() but some backends (like simple) do. You can test
that case with ./configure --enable-trace-backends=3Ddtrace,simple.

Both types of backends need to have their generate function
called separately:

   ...backends without the conditional...
   if (trace_event_get_state(...)) {
       ...backends with the conditional...
   }

The hasCondition list argument can be avoided by returning bool from
generate_h_conditional() instead of modifying the argument. That's a
little cleaner than the pass-by-reference trick where each backend has
to logical-or in their value.

The generate_h_conditional() function could also be replace with a
module variable like the existing PUBLIC variable. That way backends can
simply declare what they want instead of implementing a function:

  CHECK_TRACE_EVENT_GET_STATE =3D True # or False

And the code in h.py would know whether to call the generate function
inside the conditional or not. (I snuck in another suggestion: changing
the name from "conditional", which is a general term, to
"check_trace_event_get_state" to be more specific about what it does.)

Stefan

--3n//5Zgar1wd4WYt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhdlNcACgkQnKSrs4Gr
c8h8/QgAsFi0scHCffMnbpi3+H9Mykk64CkaB9OugmZJB+6UPt8lCvayLIZavu3r
DATAEdoeFqsGyRNhWpM73wsWCyJY+HopOBSMFNj8a7B+Vg6H0/Si3dTJNy2Ta4Vx
wUtHTuIY+HpriOoUoQtJiht0TRlrF7idlp8PqmQ52pXH1yCfKgUAvWh/J/eOUPBC
9z875shC6sg9E9kpTJIkyJ4dtiLHDmEhxa5pYRbNnM/iIXUD1lqn1irSGJFX0OqK
QACW4+NEUJ9aBXuHqBoqhKaEB5Ic3SOLM6C1Q099ikfR5xVVSWJpRlm/UxIZDjXZ
mH94Df5+jZyV2JgVjGm+AuC55ldXhw==
=gt4w
-----END PGP SIGNATURE-----

--3n//5Zgar1wd4WYt--


