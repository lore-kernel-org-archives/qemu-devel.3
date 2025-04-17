Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20611C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SEE-0002Zs-RZ; Thu, 17 Apr 2025 12:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5SEC-0002Zc-Vt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1u5SEA-0000kE-SZ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744907796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mfqexr1lIsjOjErOfef5CBITb7GIZpU5qfknGo4xyQo=;
 b=WA9LlznqUgQZfmij07k4qL5Y2Ux9xKFlWFjaMcgASiiaHU2NoNORQ+fruAjkwRbFr3WbKc
 H5ZXaFqCNHIy/5DsYJa9GlmhfzVw3l7X/WxL1aY5ngcwIAMDcc4uQtLrFOdq5hIrAp9Rpf
 hn9kZB/g7Wa3XAepo4ZIJw/PNd1jr4w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2_bY7nUHNy2sn3Unmz_1eQ-1; Thu, 17 Apr 2025 12:35:23 -0400
X-MC-Unique: 2_bY7nUHNy2sn3Unmz_1eQ-1
X-Mimecast-MFC-AGG-ID: 2_bY7nUHNy2sn3Unmz_1eQ_1744907723
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3054210ce06so1275459a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907721; x=1745512521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mfqexr1lIsjOjErOfef5CBITb7GIZpU5qfknGo4xyQo=;
 b=jg5vazH033cj89zojgzaJJPMDV1eRZ3YjHfLnlIHBGIOpPycY7+HccMAHSGADHTccF
 XfJG+a5U2PFHEDvaXf2WSpPbLEBjlrpKGebcNrTQ1R5JsRHj8ujbPKHA3GcCBNJyHooI
 QLblhAFwulOhj5XS8MqKw3wRNlmKPx5zhirpXWQo1VyA77qn2sLaGoavnw0GVvUTNAYs
 IIIJzwx8MZAo0R5JVJ08sMy1liSWr/3uC8DweIR5lkT/rmdKHEJGypYGKSkIVBFh3VFP
 sMk4kSPn5uG+CiFsx0FdlOAi71598PffnDxGiiDYEgBztq8OZsJkKIv+vZQ+ylodPeU1
 IUoA==
X-Gm-Message-State: AOJu0Yx/L3kLRSUC6cwrKVXfR07yhBaY8cnrpUxRQlIoe/HdMS2Ln+EU
 akVAF5P44xw1Tx01R7VQj30jVE0jdSdGN1ynlizEtloL/3Eb0uu1AkgfTrRy6lypeI7QLEZIbcJ
 XiHwGETbQX5V572sCVbMIxBnovNx9q+v84yTqIhxFeAO/1NRVzeOo/rgJiM8XFR8Io8C4y0zdS3
 o9OYLneFLu1Fb1EO8d6H07TEvowbB/T6itjKA=
X-Gm-Gg: ASbGncst/nAKqnVN+DADicToQ7J1C9DIWlxaBtb0DVIFcKIjZcDOywRCvkZPynLlN4K
 rTf6iWKGqsIhv2k8TYz7AQfSWCpGK+fdSlgmHvTOFOxSab329+L+hUQpRzdqNQbNCX2B7w5j3d9
 OcqEqUPyx8X+MGjHyNmm4MDrCv
X-Received: by 2002:a17:90b:268b:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-30863f18415mr12717725a91.12.1744907721301; 
 Thu, 17 Apr 2025 09:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx1VMuMveeYuxTuOgMUKfVDgU1s0DlCx980M4zqV1LErq2Apwqfhjq3fyJyVCAcHfj4NVIV6H4JSntkVKhU2g=
X-Received: by 2002:a17:90b:268b:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-30863f18415mr12717688a91.12.1744907720911; Thu, 17 Apr 2025
 09:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <f14e4ca7-63ff-4dfd-85d9-8ebde2a0c840@archlinux.org>
In-Reply-To: <f14e4ca7-63ff-4dfd-85d9-8ebde2a0c840@archlinux.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Apr 2025 12:35:08 -0400
X-Gm-Features: ATxdqUE4BKHK_9lCCZAsrqoxk8b7Zl24vxAijn_H-fUBFXnh8hf1GlryNah033E
Message-ID: <CAFn=p-Zc1F6GUx3aAueHcoX4HcVgJ+XEE8WayN_KnWJZnpJG1w@mail.gmail.com>
Subject: Re: CRITICAL Unexpected bottom half exception
To: Anton Hvornum <torxed@archlinux.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000df07410632fbfca5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000df07410632fbfca5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How exciting! Can you give me some more information on what occurred?

- What is your operating system?
- What were you in the process of doing at the time? (It looks like it died
during the initial connection attempt)
- Did this happen inside of another application, or a script you wrote, or
in the/a Python REPL?
- Is this reproducible, or does it appear to be a race condition or
something that only triggers occasionally?

Thank you for reporting back!

--js

On Fri, Apr 4, 2025 at 6:11=E2=80=AFAM Anton Hvornum <torxed@archlinux.org>=
 wrote:

> 2025-04-04 12:07:59,172 archtest CRITICAL Unexpected bottom half
> exception. This is a bug in the QMP library. Please report it to
> <qemu-devel@nongnu.org> <qemu-devel@nongnu.org> and CC: John Snow
> <jsnow@redhat.com> <jsnow@redhat.com>.:
>   | Traceback (most recent call last):
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 462, in _session_guard
>   |     yield
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 417, in connect
>   |     await self._establish_session()
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
> line 297, in _establish_session
>   |     self._greeting =3D await self._get_greeting()
>   |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
> line 317, in _get_greeting
>   |     msg =3D await self._recv()
>   |           ^^^^^^^^^^^^^^^^^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 1046, in _recv
>   |     message =3D await self._do_recv()
>   |               ^^^^^^^^^^^^^^^^^^^^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
> line 449, in _do_recv
>   |     msg_bytes =3D await self._readline()
>   |                 ^^^^^^^^^^^^^^^^^^^^^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 1014, in _readline
>   |     raise EOFError
>   | EOFError
>   |
>   | During handling of the above exception, another exception occurred:
>   |
>   | Traceback (most recent call last):
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 468, in _session_guard
>   |     await self.disconnect()
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 436, in disconnect
>   |     await self._wait_disconnect()
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 758, in _wait_disconnect
>   |     self._cleanup()
>   |     ~~~~~~~~~~~~~^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
> line 385, in _cleanup
>   |     super()._cleanup()
>   |     ~~~~~~~~~~~~~~~~^^
>   |   File
> "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
> line 772, in _cleanup
>   |     assert self.runstate =3D=3D Runstate.DISCONNECTING
>   |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   | AssertionError
>
>
>

--000000000000df07410632fbfca5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>How exciting! Can you give me some more information o=
n what occurred?</div><div><br></div><div>- What is your operating system?<=
br></div><div>- What were you in the process of doing at the time? (It look=
s like it died during the initial connection attempt)</div><div>- Did this =
happen inside of another application, or a script you wrote, or in the/a Py=
thon REPL?</div><div>- Is this reproducible, or does it appear to be a race=
 condition or something that only triggers occasionally?</div><div><br></di=
v><div>Thank you for reporting back!</div><div><br></div><div>--js</div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Apr 4, 2025 at 6:11=E2=80=AFAM Anton Hvornum &lt;<a hr=
ef=3D"mailto:torxed@archlinux.org">torxed@archlinux.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20

   =20
 =20
  <div>
    <font face=3D"Hack">2025-04-04 12:07:59,172 archtest CRITICAL
      Unexpected bottom half exception. This is a bug in the QMP
      library. Please report it to <a href=3D"mailto:qemu-devel@nongnu.org"=
 target=3D"_blank">&lt;qemu-devel@nongnu.org&gt;</a> and CC:
      John Snow <a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">&lt;j=
snow@redhat.com&gt;</a>.:<br>
      =C2=A0 | Traceback (most recent call last):<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 462, in _session_guard<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 yield<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 417, in connect<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 await self._establish_session()<br>
      =C2=A0 |=C2=A0=C2=A0 File
&quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.p=
y&quot;,
      line 297, in _establish_session<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 self._greeting =3D await self._get_g=
reeting()<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^=
^^^^^^^^^^^^^^^^^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
&quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.p=
y&quot;,
      line 317, in _get_greeting<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 msg =3D await self._recv()<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
^^^^^^^^^^^^^^^^^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 1046, in _recv<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 message =3D await self._do_recv()<br=
>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
&quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.p=
y&quot;,
      line 449, in _do_recv<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 msg_bytes =3D await self._readline()=
<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 1014, in _readline<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 raise EOFError<br>
      =C2=A0 | EOFError<br>
      =C2=A0 |=C2=A0<br>
      =C2=A0 | During handling of the above exception, another exception
      occurred:<br>
      =C2=A0 |=C2=A0<br>
      =C2=A0 | Traceback (most recent call last):<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 468, in _session_guard<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 await self.disconnect()<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 436, in disconnect<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 await self._wait_disconnect()<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 758, in _wait_disconnect<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 self._cleanup()<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
&quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.p=
y&quot;,
      line 385, in _cleanup<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 super()._cleanup()<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~^^<br>
      =C2=A0 |=C2=A0=C2=A0 File
      &quot;/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protoc=
ol.py&quot;,
      line 772, in _cleanup<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 assert self.runstate =3D=3D Runstate=
.DISCONNECTING<br>
      =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
      =C2=A0 | AssertionError<br>
      <br>
      <br>
    </font>
  </div>

</blockquote></div></div>

--000000000000df07410632fbfca5--


