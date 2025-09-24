Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8622CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1VdK-0006v6-CF; Wed, 24 Sep 2025 15:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1VdI-0006ub-Cc
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Vd7-0006sa-R4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758743898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAOSlxTQkjyrJ0Fs9t2AwUeUxyQ/63d0m4/Sy32r4gs=;
 b=UjhrJ8J6MaZYT/e1DJ4GzokXCXa1XJixlz4mRxOsmSeeLkDKJb3BF42Bo5d+aAmBm95DNx
 iDIA9boIt0LKkcOqT4qn9NnChDvt8MXMkNRxAbJC/boqOzuxizuuqOspqnjNwkNZAZuF7c
 1OIqcWmaWLCJQyjFYippAg5/Tlun9Cs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ngo-BYAuO2yaJFxEbpT2WA-1; Wed, 24 Sep 2025 15:58:16 -0400
X-MC-Unique: ngo-BYAuO2yaJFxEbpT2WA-1
X-Mimecast-MFC-AGG-ID: ngo-BYAuO2yaJFxEbpT2WA_1758743895
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso175082f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758743895; x=1759348695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WAOSlxTQkjyrJ0Fs9t2AwUeUxyQ/63d0m4/Sy32r4gs=;
 b=c1JAXFRNVBXgYABfPzzTa5honV6FPNcYMleAFGHz9vE71ubth6PTDeFLJ1oHFGJgUT
 vYEiXceGg3Pn3a7KquDqcq8vbOH6YKreTySVPJ/f8Tt0pXvVspm+5Rhn//YAMO2QxrLT
 BN/ZDeF5OvLg5GKr8/Dv/i9DAUYE7t21QwoeCzTel35Uc2S3090a2k4HjXqpVU1r3exu
 NLEsw2R1aZfoaBp6lXa3j0C3abVmhMuNgejmZ6ZRR67E+Kqs5MjT3sh/P4wDWVqThV6u
 tc/1c0J56hZoTUYvcaf48HHz9mStLHe48GETi/Fh8uFCxkNLYmz1hoLlpkjNOmFwHTQr
 Qvhg==
X-Gm-Message-State: AOJu0YwmiuRqbEMepSxrQ2J20ECUcpqAvb6xMuaR+z5agXyLioTU2X0U
 0RYlxrjzgB/vVx0/WSvyZr6oZ9/+HUc43cmUp0GKv4hN+Ceyz3kX122nAy3GbZK2VPwPqz+JHco
 Fs0Wl9yymLk8OuuB/q6WwsFNrUnzCeO9Cf0b8hJ0NtFEol2t3SXkkbCrRjt+YzZ3Gk6Wrd868qa
 q/VK5NCBCxAccMcI97G8mtvAZOdPydr+8=
X-Gm-Gg: ASbGnct+CLJOKSSF9TQCevZ0vVkLH2Jq/VqnBTPFKP3LlDxZbpXRum94rSStH3oviC6
 lnYAahJ7nGwdrwKiTZdFjbOFxzru/vC9VvBaCvTrTiu/8IZpQtxqfBUFuGwQYbe8/TVo/F3rW+C
 E4RyTv77kHG9dy8MX0UBw51fMPPCjX0RvERiAj32lrkQj4lGQaJVVE0cCDpbST2qvadCP2xOVGc
 3ccjflOzoR+qTOdOzH434ZeFEs=
X-Received: by 2002:a05:6000:400b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-40e44498167mr1251578f8f.14.1758743895236; 
 Wed, 24 Sep 2025 12:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9SZ/jO1fexO1ExwDhEEO7im+Qutmvn57EQ+xLXBZqLUme3C2bglpVsZQN2Yba5y2xmccZJc7/H3wlXF+ys8=
X-Received: by 2002:a05:6000:400b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-40e44498167mr1251563f8f.14.1758743894895; Wed, 24 Sep 2025
 12:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
In-Reply-To: <20250924181024.GB6015@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Sep 2025 21:58:04 +0200
X-Gm-Features: AS18NWDLxZTXQzXwD2hp2VT_2a17Nh9o9G-59AuMhj0Q_QQP2pFFIDu-5kkIYQA
Message-ID: <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="0000000000001b3ebb063f9179b1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001b3ebb063f9179b1
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 24, 2025, 20:10 Stefan Hajnoczi <stefanha@redhat.com> wrote:

> > fn trace_event_state_is_enabled(dstate: u16) -> bool {
> >      unsafe { trace_events_enabled_count } != 0 && dstate != 0
> > }
>
> The generated code is missing DTrace's SDT semaphore (see
> generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). The
> conditional must be taken when a tool like SystemTap or GDB sets the SDT
> semaphore. Right now it will not be taken because the conditional only
> looks at _ ## id ## _DSTATE and not the SDT semaphore.
>

This is private code to trace-*.rs, for use within the tracepoint functions
only; it's not a public "is the tracepoint active" API. The public side in
C does look at the semaphore.

Paolo

--0000000000001b3ebb063f9179b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24, 2025, 20:10 Stefan Hajno=
czi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; fn t=
race_event_state_is_enabled(dstate: u16) -&gt; bool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsafe { trace_events_enabled_count } !=3D 0 &amp;=
&amp; dstate !=3D 0<br>
&gt; }<br>
<br>
The generated code is missing DTrace&#39;s SDT semaphore (see<br>
generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). The<br=
>
conditional must be taken when a tool like SystemTap or GDB sets the SDT<br=
>
semaphore. Right now it will not be taken because the conditional only<br>
looks at _ ## id ## _DSTATE and not the SDT semaphore.<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">This is private code =
to trace-*.rs, for use within the tracepoint functions only; it&#39;s not a=
 public &quot;is the tracepoint active&quot; API. The public side in C does=
 look at the semaphore.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Paolo</div></div>

--0000000000001b3ebb063f9179b1--


