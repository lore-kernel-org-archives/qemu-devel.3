Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022E6D7497D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64BU-0006GD-4e; Wed, 30 Oct 2024 04:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t64BS-0006G2-6l
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t64BP-0000th-QA
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730277360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1lwP6jZ//D1Bl9KVKkhgwZ/9P2m79ydfG2aUgpdwqw=;
 b=DRykLfJ93vwTgCFqZYF+fTjPxH7NKl/cJbhuJ0gqvflv9niHJNsEVKg6Zp6kmCnZUjIyeU
 X8ClBnAfl9ah7lm75YyZvfEhIBPMCLo0VG0xkmtbiSUDACPIhvyMEBkxnZaudaCh/P+2yo
 YAdA6d/GDwQ6AcPsJUjjf8KlrsYS1us=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-053XDMlZNaCSKXSR9CQmXQ-1; Wed, 30 Oct 2024 04:35:58 -0400
X-MC-Unique: 053XDMlZNaCSKXSR9CQmXQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so3261552f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 01:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730277357; x=1730882157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1lwP6jZ//D1Bl9KVKkhgwZ/9P2m79ydfG2aUgpdwqw=;
 b=PtSOhmdAluLLolC2cShKCfkhGnlLuoPMUAh+cReYtQxC1kp3pG+c/gl+BLDmjefh/k
 4wLgRPiCyOchd4AyO30ewVcoP+DohGPiYtRHlroSOSy2G6MKd4ZtZ8OAl6Gt9plIEP96
 SLQjno9gOSABqNS5OgUVtuu8QJm2Agtp433YWx87k7D8JAbPvRbPNEysU0WnR2/auVJ5
 rYi0LYiVf3VD63MsDpC0gsuqOGKf8V23VUv2s2hzGGcvawHu/JHK05AfmrkMAC79Gaws
 zRN0FwVcvq+UsxX0ZKFF0ttYcoK97aS5EzdxzrNC0Fpc2M0Q4TJQaCgoMxw5RwaWmppU
 2FJQ==
X-Gm-Message-State: AOJu0YynO8mhtmwne3HyJLfGE1oZ+37tPJrGWXbngCWY8F4lhxSPkLg2
 oKLZ6/IoTuyD9WS3fhAQfM/CTmWAphRycuMvqqA4Tf8TmWD3X/DsV2fwsdk3U/P3ESQs2CZjEUa
 z2LfIWgbSN5siH0HatBf1BAl580prCIrIJ2z/+iqfiOBAPT7uWKMphERiPfMLEFnUHFVSa49vis
 F8LCBkL/9g00s/4tCykpwiURNrtZ8=
X-Received: by 2002:adf:ea81:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-3806121fad6mr10450782f8f.48.1730277356754; 
 Wed, 30 Oct 2024 01:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPV3MSh9pfRoYZbBrxA1uLf+TXo754S+fpVzjKVKmIaw7M/dnE52/RVWdBIZYpUwVTiTBCctApol9N9HsScfs=
X-Received: by 2002:adf:ea81:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-3806121fad6mr10450769f8f.48.1730277356462; Wed, 30 Oct 2024
 01:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <ZyGlhjFULPac5hpi@linux.bj.intel.com>
In-Reply-To: <ZyGlhjFULPac5hpi@linux.bj.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Oct 2024 09:35:43 +0100
Message-ID: <CABgObfbrKz1=bqdRYfZB7t5e8_Azr8Y0j_Jr1Sw__7-EA-OzMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add AVX10.1 CPUID support and GraniteRapids-v2
 model
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: multipart/alternative; boundary="00000000000032050c0625ad9723"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000032050c0625ad9723
Content-Type: text/plain; charset="UTF-8"

Il mer 30 ott 2024, 04:23 Tao Su <tao1.su@linux.intel.com> ha scritto:

> > I don't have a Granite Rapids machine, so please test! :)
>
> I test it on Granite Rapids and all meet expection with my minor changes on
> patch4 :)
>

Thanks, can you send v3?

Paolo

>
> > Paolo
> >
> > Paolo Bonzini (3):
> >   target/i386: cpu: set correct supported XCR0 features for TCG
> >   target/i386: do not rely on ExtSaveArea for accelerator-supported XCR0
> bits
> >   target/i386: return bool from x86_cpu_filter_features
> >
> > Tao Su (5):
> >   target/i386: add AVX10 feature and AVX10 version property
> >   target/i386: add CPUID.24 features for AVX10
> >   target/i386: Add feature dependencies for AVX10
> >   target/i386: Add AVX512 state when AVX10 is supported
> >   target/i386: Introduce GraniteRapids-v2 model
> >
> >  target/i386/cpu.h         |  16 ++++
> >  target/i386/cpu.c         | 175 ++++++++++++++++++++++++++++++++++----
> >  target/i386/kvm/kvm-cpu.c |   8 --
> >  target/i386/kvm/kvm.c     |   3 +-
> >  4 files changed, 175 insertions(+), 27 deletions(-)
> >
> > --
> > 2.47.0
> >
>
>

--00000000000032050c0625ad9723
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 30 ott 2024, 04:23 Tao Su &lt;<a href=3D"mailto=
:tao1.su@linux.intel.com">tao1.su@linux.intel.com</a>&gt; ha scritto:</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I don&#39;t have a Granite Rapids machine, so please test! :)<br>
<br>
I test it on Granite Rapids and all meet expection with my minor changes on=
<br>
patch4 :)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks, can you send v3?</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt; Paolo Bonzini (3):<br>
&gt;=C2=A0 =C2=A0target/i386: cpu: set correct supported XCR0 features for =
TCG<br>
&gt;=C2=A0 =C2=A0target/i386: do not rely on ExtSaveArea for accelerator-su=
pported XCR0 bits<br>
&gt;=C2=A0 =C2=A0target/i386: return bool from x86_cpu_filter_features<br>
&gt; <br>
&gt; Tao Su (5):<br>
&gt;=C2=A0 =C2=A0target/i386: add AVX10 feature and AVX10 version property<=
br>
&gt;=C2=A0 =C2=A0target/i386: add CPUID.24 features for AVX10<br>
&gt;=C2=A0 =C2=A0target/i386: Add feature dependencies for AVX10<br>
&gt;=C2=A0 =C2=A0target/i386: Add AVX512 state when AVX10 is supported<br>
&gt;=C2=A0 =C2=A0target/i386: Introduce GraniteRapids-v2 model<br>
&gt; <br>
&gt;=C2=A0 target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 ++=
++<br>
&gt;=C2=A0 target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 175 +++++++=
+++++++++++++++++++++++++++----<br>
&gt;=C2=A0 target/i386/kvm/kvm-cpu.c |=C2=A0 =C2=A08 --<br>
&gt;=C2=A0 target/i386/kvm/kvm.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 4 files changed, 175 insertions(+), 27 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.47.0<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000032050c0625ad9723--


