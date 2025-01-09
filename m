Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25F3E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVv0Q-00021f-P8; Thu, 09 Jan 2025 11:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVv0N-0001nH-Hf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:03:31 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tVv0L-0004Ek-Id
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:03:31 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so174851766b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736438608; x=1737043408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoY2b8WsTZRPOmUjN7uoWbg+XlOLeSqkGzU7IEKgQps=;
 b=FPGlYDPBT/du4uT/gTyZRxcyQKRAfHszywfiyoBLS/04IG5ANb5uvtz9lL92+FwwbR
 P0I+Mb5CxkF/qGoXsWNVHponFhPbZgxJbYx8Tu9GTTm8fSrFX7lesyW32r1rncdU7Vo2
 1sbKl5kS2vOKO7+Z8bC4OILxl1PSlMxF7CgwCdcyLiRo2Lb/U48LjK97nBpJLa6SnTcx
 r3UMOZm+cu+iKAj/nw4G68KPwElvu7461owj4mrV5qD+TtZmlR7oFNrwtPhNSBlIuD2M
 Bpkue9MqGgOrzJe2UY9AUbMeCp/KW+1g5a9gh9SV01Q5+3iT+9BLdqCH9YuXj7N+H3mB
 eeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736438608; x=1737043408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoY2b8WsTZRPOmUjN7uoWbg+XlOLeSqkGzU7IEKgQps=;
 b=hClZayNVDmxfW0eCV6zEoGXLQm0vZHTSzi/zgH9++N9rx6oXyHPOozaF0iFcFlOm3t
 zLkUogd7RxZw/FHxQm4OmL1O0DdseylynRCT7RJGE76FuZ+ccwivKHbf21tNJgYKnik0
 TX63JBTKA6RpygHk3J1K+TYQOGf0nQPt83XO7d/sPDQm2llUWW5kvhZ6NYWeRBhzwrf5
 kH7LCcEvpM7V1oD8Ly32rEhzmFSgY2y1rZSEyn0FEh1DQRLSShO/37FvX+k2umtG2rNS
 Ofd7G3lK96pgtbxMtr6WopmADN5zPl2hM6h4RoXwqIzJAVcNSZFo6uNpm6t8PdFRUxXW
 Z6Xw==
X-Gm-Message-State: AOJu0YzrC+D9w27tsKIYm2rrZ/Ud8lGdMBPJa7FezmuvLWgwnlScIxOz
 mXhlftKTHIGPyxkyM+QbSmbN2Jcw1vLLMB9cmMkPunXrXPXWojlzERY//XS7oy6aHPzSNdYKXqR
 dJ9cikmnIbYGt1p4r9Dth7kdniNXu4g==
X-Gm-Gg: ASbGncv+115qz5HDPmm/EFTkU9icNU5KhiLdnU8+3QFnBldIoK4bagHBsIfsXB4sAyq
 mgK8efvMAMEKCJLQMfhDGofqoBiqWBu5ziFt4
X-Google-Smtp-Source: AGHT+IGyurPTU1J4WWzaDuMtgP78pIAQoJGfL23ai6Njup+/WpifZHa9hWUi/DG1vx6ZPdkv1k6oykVtulku9phULgc=
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d972e00027mr15384634a12.5.1736438605820; Thu, 09 Jan 2025
 08:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20250108111023.156073-1-dwmw2@infradead.org>
 <CAJSP0QUyq6RfYPPV2EXthMaLr82Z9htEohaP4f+P=MLUF=JCWg@mail.gmail.com>
 <de33977443334962bf85d1f7968d2609ac35d6a5.camel@infradead.org>
 <CAJSP0QXmJ2RdYuwHWPjMSXrTKzLAu-sa_eDFOsuJhG9ztr_LyQ@mail.gmail.com>
 <86a600a818cd063397730848957cb2be3be783ae.camel@infradead.org>
In-Reply-To: <86a600a818cd063397730848957cb2be3be783ae.camel@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Jan 2025 11:03:13 -0500
X-Gm-Features: AbW1kvZzle_RYE2_4KpcHrB_lWFinKEuZbpEd6ZkB8SBr0RChfx1kZgRMUQAjFI
Message-ID: <CAJSP0QWph_F6_4z1bb-gS7maACfHbNDOitmzj54asQkXC=71EA@mail.gmail.com>
Subject: Re: [PULL 0/1] vmclock queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62b.google.com
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

On Thu, 9 Jan 2025 at 09:14, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2025-01-09 at 09:01 -0500, Stefan Hajnoczi wrote:
> > On Thu, 9 Jan 2025 at 08:18, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> > >
> > > On Thu, 2025-01-09 at 07:52 -0500, Stefan Hajnoczi wrote:
> > > > On Wed, 8 Jan 2025 at 06:11, David Woodhouse <dwmw2@infradead.org>
> > > > wrote:
> > > >
> > >
> > > > 2. Send pull requests with a GPG-signed tag (git tag --sign) and
> > > > ensure that the repo URL in the email is https:// (the tooling reje=
cts
> > > > unencrypted http:// and git:// repo URLs).
> > >
> > > You mean *or* rather than *and* in that sentence, right? Because if
> > > it's GPG-signed, then I can send it to you over carrier pigeon and yo=
u
> > > can validate it; the transport is irrelevant.
> > >
> > > If you really did mean 'and'... is this a new bug in the tooling? Las=
t
> > > time I used Peter's make-pullreq script, it worked fine=C2=B9.
> >
> > You're right, both are not required together for security. I still ask
> > for both because we historically had some submaintainers without GPG
> > keys and didn't want them to use unencrypted git:// or http:// URLs.
> > It's easier if everyone does both so I don't have to check whether
> > we've followed the right process depending on their GPG key status. I
> > think QEMU submaintainers have now fully transitioned to GPG keys, so
> > we could probably drop the https:// requirement.
> >
> > If it's not too much trouble to use https:// then that would be easiest=
.
>
> I tried the 'Advanced Web Server Setup' from
> https://git-scm.com/docs/gitweb  :
>
>   # make the front page an internal rewrite to the gitweb script
>   RewriteRule ^/$  /cgi-bin/gitweb.cgi
>
>   # make access for "dumb clients" work
>   RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ \
>                 /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
>
> But it seemed to break the gitweb access for URLs of the form
> https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenfv
> so for the *moment* I have reverted that and filed it in the 'too much
> trouble' bucket. I will take another look at some point though.

That's fine, I'll update my script to accept git://.

Thanks,
Stefan

