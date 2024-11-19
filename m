Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED7D60074
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 08:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDJIr-0008HK-NG; Tue, 19 Nov 2024 03:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDJIq-0008Gw-Bi
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDJIn-0007DH-On
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732003776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R90awFZ/TdjbV4ut00d+9tZAWVRuZqxr92tLxeBJOZc=;
 b=W1H38rNxf7PkC6t6pj3S9LUo5m8oY/JfPdqe0vx9kIGSHDi1byhlfDvIkygPUlKiarV+bL
 nrrqen6oIOBSbRavMxgxjk7nQApQchJ1vvMjLT9NVHCtWzNMHrPGQt2ahpJYrYOjNwhPq6
 rDwEUueNUDaOwsWVRoIPkU3/+Itpu6s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-SyCah5YQOwqRbJy-NH7tfA-1; Tue, 19 Nov 2024 03:09:29 -0500
X-MC-Unique: SyCah5YQOwqRbJy-NH7tfA-1
X-Mimecast-MFC-AGG-ID: SyCah5YQOwqRbJy-NH7tfA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38242a78f3eso388792f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 00:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732003768; x=1732608568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R90awFZ/TdjbV4ut00d+9tZAWVRuZqxr92tLxeBJOZc=;
 b=pQhkN4rPYtJonSs+uV2J/qph2+mUurG6kXfH0jKRLHRAnzCBLXOR9PGunxK2KzEOlG
 Bc83UBpR38qgM2HYYMQ4aGwnYbfAlx/diU7xNke5Lk7kSmnESGth3wQK1SXZlj9aZtcB
 8u86uz4ZD1cuXvA9o+uJ2g4lSSxN3QDo9jxah7zgL81bsCuBd8JkSN/kmMH4ONFvhDZ1
 7pPxReZh1LxWhve6C3/1/Zw1V8E1/CGNFKcC/3yrCy3aPoJTy+K75EquR220F8GqYeT2
 162H6ado6xy47tntlQPoJoU1BznzZkQRCdirRTEnZf+L+s1YX/TBJn/KUsS/5XC9kgWN
 4hpg==
X-Gm-Message-State: AOJu0YwJhScgVUhW2ERmLgODvWa230mtoAAQVggh/pHEF2wEz0uLj3Jh
 nsO3yWtXc9X476MAj7GWzDxUG2dAn08off9+HvzkvxW1m32PuR3ujp96vI+j9kj+EsfIBO08UNS
 /4RxFN6WuTuH3Sk5R+X+a1RyOPv3PCrULVP6cZa4eFOwHX3TMNhiifEm2hBVi5iCGdYOQI1aabK
 veBcZlpBr/UWYlYXlLxKo5zK9pkRI=
X-Received: by 2002:a05:6000:1fad:b0:382:3816:f50e with SMTP id
 ffacd0b85a97d-3823816f8c4mr9667022f8f.34.1732003768444; 
 Tue, 19 Nov 2024 00:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX099c8zGBu1R99OcXRF+fZ1gSlEWx4q4Gt94QS+RucivBQZLsKRcIn/wZSHR8g+q0fGiE0oUaUDef86eKGzY=
X-Received: by 2002:a05:6000:1fad:b0:382:3816:f50e with SMTP id
 ffacd0b85a97d-3823816f8c4mr9666998f8f.34.1732003768094; Tue, 19 Nov 2024
 00:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
In-Reply-To: <ZzvIZ4EL92hEk4wC@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Nov 2024 09:09:16 +0100
Message-ID: <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058e3e206273f8dd8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

--00000000000058e3e206273f8dd8
Content-Type: text/plain; charset="UTF-8"

Il mar 19 nov 2024, 00:06 Peter Xu <peterx@redhat.com> ha scritto:

> On Mon, Nov 18, 2024 at 05:13:30PM -0500, Peter Xu wrote:
> > When used incorrectly, container_get() can silently create containers
> even
> > if the caller may not intend to do so.  Add a rich document describing
> the
> > helper, as container_get() should only be used in path lookups.
> >
> > Add one object_dynamic_cast() check to make sure whatever objects the
> > helper walks will be a container object (including the one to be
> returned).
> > It is a programming error otherwise, hence assert that.
> >
> > It may make container_get() tiny slower than before, but the hope is the
> > change is neglictable, as object_class_dynamic_cast() has a fast path
> just
> > for similar leaf use case.
>
> Just a heads up: out of curiosity, I tried to see whether the fast path hit
> that I mentioned here (mostly, commit 793c96b54032 of Paolo's), and it
> didn't..
>
> It's fundamentally because all TypeImpl was allocated dynamically from
> heap, including its type->name.


Ah, that was supposed to be the difference between type_register() and
type_register_static().

Perhaps type->name could be allocated with g_intern_string()? And then if
object_dynamic_cast() is changed into a macro, with something like

#define qemu_cache_interned_string(s) \
  (__builtin_constant_p(s) \
   ? ({ static const char *interned; \
        interned = interned ?: g_intern_static_string(s); }) \
   : g_intern_string(s))

as the third parameter. This allows object_dynamic_cast() to use a simple
pointer equality for type name comparison, and the same can be applied to
object_class_dynamic_cast().

Whatever we do, we should do it before Rust code starts using
object_dynamic_cast!

Paolo

--00000000000058e3e206273f8dd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 19 nov 2024, 00:06 Peter Xu &lt;<a href=3D"mail=
to:peterx@redhat.com">peterx@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Mon, Nov 18, 2024 at 05:13:3=
0PM -0500, Peter Xu wrote:<br>
&gt; When used incorrectly, container_get() can silently create containers =
even<br>
&gt; if the caller may not intend to do so.=C2=A0 Add a rich document descr=
ibing the<br>
&gt; helper, as container_get() should only be used in path lookups.<br>
&gt; <br>
&gt; Add one object_dynamic_cast() check to make sure whatever objects the<=
br>
&gt; helper walks will be a container object (including the one to be retur=
ned).<br>
&gt; It is a programming error otherwise, hence assert that.<br>
&gt; <br>
&gt; It may make container_get() tiny slower than before, but the hope is t=
he<br>
&gt; change is neglictable, as object_class_dynamic_cast() has a fast path =
just<br>
&gt; for similar leaf use case.<br>
<br>
Just a heads up: out of curiosity, I tried to see whether the fast path hit=
<br>
that I mentioned here (mostly, commit 793c96b54032 of Paolo&#39;s), and it<=
br>
didn&#39;t..<br>
<br>
It&#39;s fundamentally because all TypeImpl was allocated dynamically from<=
br>
heap, including its type-&gt;name.</blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Ah, that was supposed to be the difference be=
tween type_register() and type_register_static().</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Perhaps type-&gt;name could be allocated with g_i=
ntern_string()? And then if object_dynamic_cast() is changed into a macro, =
with something like</div><div dir=3D"auto"><br></div><div dir=3D"auto">#def=
ine qemu_cache_interned_string(s) \</div><div dir=3D"auto">=C2=A0 (__builti=
n_constant_p(s) \</div><div dir=3D"auto">=C2=A0 =C2=A0? ({ static const cha=
r *interned; \</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 interned =
=3D interned ?: g_intern_static_string(s); }) \</div><div dir=3D"auto">=C2=
=A0 =C2=A0: g_intern_string(s))</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">as the third parameter. This allows object_dynamic_cast() to use =
a simple pointer equality for type name comparison, and the same can be app=
lied to object_class_dynamic_cast().</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Whatever we do, we should do it before Rust code starts using =
object_dynamic_cast!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div></div>

--00000000000058e3e206273f8dd8--


