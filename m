Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F52AC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6ye-0005Qx-Ec; Tue, 10 Jun 2025 17:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uP6yX-0005Qf-Eq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uP6yV-0003Z3-SQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749592654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2viyUmSs3Yx+NQSGnI2dupgr1dw19hCT+jqPJI9fNEY=;
 b=E7ABbmH7vr3+q9jnE01ipgElUQszwxCU39OLzG11nypoF0pqM1RwQF7Sfx6Ess+Bo8Q943
 laDIjmz5xuFOqrB7Ez2V3bx6TskeqA1YfikXWnxn1VwR0i6hMoSp/QRcG1tfTIqQKPbKkp
 iEdL+cjyTEvIxxMogXLlRBG6aXWU5dk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-wqHzbmEBNtyvWD-i0G66iQ-1; Tue, 10 Jun 2025 17:54:42 -0400
X-MC-Unique: wqHzbmEBNtyvWD-i0G66iQ-1
X-Mimecast-MFC-AGG-ID: wqHzbmEBNtyvWD-i0G66iQ_1749592481
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2350804a43eso93346695ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749592479; x=1750197279;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2viyUmSs3Yx+NQSGnI2dupgr1dw19hCT+jqPJI9fNEY=;
 b=o4+HHRKA06qjDdM3hiQzPFRWVeIsRoYY4sFEVrZDWkXNeHf29OY/eS4sVN9yUENYNK
 luTZgWM+jfIEf3o95Q/HFf8/CLAgAh0+wsBNH9DQHwsvwqD6TIqfXj0kBVaSi/rBTOq3
 eVejoCxv7S2TvTR+NlN++7gO4buu5SkNoa9ByjuucfeMHKuN6+ME3DcbWGxd6qfwKdO+
 T6i2R8bAWKqvfEv7VN7GfGIztjl0wjlGsR5iRv2XXZD4y+bgbXbEwnfgxUmiV2QqfnOr
 iT5alCsslSeuDkGmknmP5FgwHAammgI/RtY6WWzub0K/p2IAFN7rV/R0FJTpLl3UdNgB
 /thg==
X-Gm-Message-State: AOJu0Yzb3SzLbyZuiPh2u3whqXP1/7TGwVp8W4VVdXo3baXJBdBv3jeA
 o7OyLHkdCyMoEzrVupmJSzXQBeKTKpDe0wgSKu7Fij00qjXbFkBZmTP/3HjdRAK0LGTUeW1XWUh
 5xxwrXUhPEKSzzbGsqvElLNmldLmBDXSfQXr3BxN8B6q8/xZWve+P7fJEHJPJSUDwAUzUcWoja5
 o8WNjLETN31SAXJEhtZUWGo8o9kmxYzr+Oal45UJg=
X-Gm-Gg: ASbGncumml5yhI57YjV4SBUxFfBQ0cT6HRWzN9mw/zyQ09eYbodgs638ns3Me0x4Znc
 4EiTvyEqj178QSdnZJHtGbom5Pq0B2H2TONhH4xb5Haq9XMO3worGmYce1lspkvY3voodNOg85Q
 iPWpRa1es6eeIjFlw4H0zXi6c6rjth4hOCyFo=
X-Received: by 2002:a17:903:1448:b0:234:d292:be83 with SMTP id
 d9443c01a7336-23641a8ba75mr13973585ad.10.1749592479374; 
 Tue, 10 Jun 2025 14:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJTDjHLfHm2fwo1DmEhHZGNP4/Gct6Wn9Im+cGikDMHArCstdaOtpqlP5dGjcA+mnynnTgHAhsVrZhQ5b5B50=
X-Received: by 2002:a17:903:1448:b0:234:d292:be83 with SMTP id
 d9443c01a7336-23641a8ba75mr13973375ad.10.1749592479061; Tue, 10 Jun 2025
 14:54:39 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Jun 2025 17:54:27 -0400
X-Gm-Features: AX0GCFvnnEv3KLyY34V8ordlu6ALSbnkWxZyOzOY9IKGov-9MaQs4m0oKcNV_AI
Message-ID: <CAFn=p-b4YEg+kaO5LMGQSFozJwEkAwngfJFHP8u6pALqURxPqg@mail.gmail.com>
Subject: Fixing my email inbox
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037790306373ebe2e"
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

--00000000000037790306373ebe2e
Content-Type: text/plain; charset="UTF-8"

My employer, er, switched to a certain mail host some number of years ago
and I never really actually acclimated properly. As a result of that and,
uh, my laziness, I've accumulated ... quite a backlog of mail I have not
really read or dealt with. It's become unmanageable.

I'm trying to fix that. Unfortunately, it requires me to clear out the
cobwebs and the easiest way to do that right now is a bulk "mark as read,
archive" to get a fresh start and try new programs, filtering and
organizational systems.

My apologies for my absenteeism responding to maintenance requests. I am
working on fixing it. I will be using a custom console script to monitor
Patchew for the time-being (to highlight any series patchew believes I was
copied on or am otherwise the maintainer for), but if there are any
non-patch-related requests you have been hoping for an answer on, I humbly
ask you re-send it and I thank you for your patience and understanding.

With love (from the bottom of a mountain of mail),
--J. Snow

--00000000000037790306373ebe2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>My employer, er, switched to a certain mail host some=
 number of years ago and I never really actually acclimated properly. As a =
result of that and, uh, my laziness, I&#39;ve accumulated ... quite a backl=
og of mail I have not really read or dealt with. It&#39;s become unmanageab=
le.</div><div><br></div><div>I&#39;m trying to fix that. Unfortunately, it =
requires me to clear out the cobwebs and the easiest way to do that right n=
ow is a bulk &quot;mark as read, archive&quot; to get a fresh start and try=
 new programs, filtering and organizational systems.</div><div><br></div><d=
iv>My apologies for my absenteeism responding to maintenance requests. I am=
 working on fixing it. I will be using a custom console script to monitor P=
atchew for the time-being (to highlight any series patchew believes I was c=
opied on or am otherwise the maintainer for), but if there are any non-patc=
h-related requests you have been hoping for an answer on, I humbly ask you =
re-send it and I thank you for your patience and understanding.</div><div><=
br></div><div>With love (from the bottom of a mountain of mail),</div><div>=
--J. Snow</div></div>

--00000000000037790306373ebe2e--


