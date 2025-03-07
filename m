Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AD8C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 23:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgmE-0001ER-6Y; Fri, 07 Mar 2025 18:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgmB-0001Dr-Ot
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgm9-00085l-DD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741388799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYw2ZnA0iV4COsRziVSNuHQD6OXjwNnfYBaB3+3Qo+E=;
 b=asg1FnbBJpT/NqytW4kKaMHZ4YFpg9l+kF0Y/gc1BMue2FaqElRegGHkCdXd1iLSnqeAG1
 4j9k6c0RNpBLxP7Q8D7KT8MFFk+dIDfe8Pwdx4YqER3i7YS9WpyHbBvzIJddPbXD6AbMY/
 /mu9WTdSHGD9jGGhtiDjF/u4bPwW/zc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-VAyM_Tu1OBOlhoC_Y9RWvA-1; Fri, 07 Mar 2025 18:06:35 -0500
X-MC-Unique: VAyM_Tu1OBOlhoC_Y9RWvA-1
X-Mimecast-MFC-AGG-ID: VAyM_Tu1OBOlhoC_Y9RWvA_1741388794
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2242f408320so12696855ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 15:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741388794; x=1741993594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYw2ZnA0iV4COsRziVSNuHQD6OXjwNnfYBaB3+3Qo+E=;
 b=VCcVErh7mwOmOQk3hLMxW+EFXFwbY9SA6g/e19P9pzICKZBmYjQDt+Jvo+NqUevm//
 qeYomhIQ38jQFhHmT5qCyswNuqKDDjKjuiXOiyFbAKwGcOeasHMDxIBYMX20QyFMAxzS
 LBwhvvONrF92vEJ5aJbaHj4ZAnVl5NFMCc/RuxZW6Dhuzrwopk8qI5WezLYlpv6wfr1j
 LcskAO7fPy+aapDL6ExIQNeSj7GQXRY0ZEWoR1u8yCYDNh55BPp4lR+AoTD5CPVgJI0K
 VgA9BAc5GL50ON3KyvjW5S8baM4EjxiPyx9bONL0Z7sidI1p75TUhi7ejtnBR9a1573G
 jF8w==
X-Gm-Message-State: AOJu0Yx/5LPxjM1/Hd+yvn+JCrAqs34hSqIcLZGemstDjcgO751lRhn6
 OwOU1IN62pOLTmx3wQTTxfkyAb8w490lVIE+JDnAl5B4FtkVScwh64/bRbEIMKwBfgr2QGTScEw
 F0+G92RgcK7rqB40z7Cbjjpeeptk0a8uKhwQegMY0YVXnRLXtmUMMRg15wkV3egm1Q6CLasa2hC
 p2RENxH7PQuLjFv3caIfItPebOkAY=
X-Gm-Gg: ASbGncv0xedujKCp2mYoZIYo6mtUOMg38oJnZE4YElsBxDGTAnM6ly7JkMp38GRbhjS
 zaSYUP6N6aiMiocHA6hPYnM/ucqH3ydjgHFyrahHKSHm3BUWTGp96tDAQePiJ+kYspowOoQ==
X-Received: by 2002:a17:902:ecc2:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22428899c47mr80651575ad.12.1741388794277; 
 Fri, 07 Mar 2025 15:06:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBogsCL8HyX7nSPDZWOBHF5d9oL4VGKRNIjFuv7cW32o5VIAeX0T9NpVMCpbz/gVxLOkA2jCbDjNY5bGh1l/A=
X-Received: by 2002:a17:902:ecc2:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22428899c47mr80651375ad.12.1741388794035; Fri, 07 Mar 2025
 15:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-20-jsnow@redhat.com>
 <87v7slm90e.fsf@pond.sub.org>
In-Reply-To: <87v7slm90e.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 18:06:21 -0500
X-Gm-Features: AQ5f1JrXi-gexGezpMgWgLotfttk0uLinip6x_aWhPyBDdbPZYEVxRHc0znBoVc
Message-ID: <CAFn=p-afzh0nDfRSx3a=yRPzTxyX=92_onSuKwZFUujArkH9Tw@mail.gmail.com>
Subject: Re: [PATCH 19/57] docs/qapi-domain: add qapi:event directive
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007c2649062fc8ac02"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000007c2649062fc8ac02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:26=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Adds the .. qapi:event:: directive, object, and :qapi:event:`name`
> > cross-referencing role.
> >
> > Adds the :memb type name: field list syntax for documenting event data
> > members. As this syntax and phrasing will be shared with Structs and
> > Unions as well, add the field list definition to a shared abstract
> > class.
>
> docs/devel/qapi-code-gen.rst calls it "event-specific data".  This is
> quite a mouthful, so the code usually calls it "arguments".  Not least
> because events are kind of like commands going in the other direction
> (client to server), and the code dealing with them is often similar.
>
> Both names make more sense to me than "member".  Hmm.  A rename could be
> done as a follow-up if that's more convenient for you.
>

Also wish you'd have said sooner :)

I might punt this one. At least, the next respin probably won't include
this.

I suppose I think about this in terms of "members of the event object."
Let's talk and fix later, changing the name outside of a gigantic series is
not difficult at all.


>
> > As per usual, QAPI cross-referencing for types in the member field list
> > will be added in a forthcoming commit.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--0000000000007c2649062fc8ac02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 5:26=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Adds the .. qapi:event:: directive, object, and :qapi:event:`name`<br>
&gt; cross-referencing role.<br>
&gt;<br>
&gt; Adds the :memb type name: field list syntax for documenting event data=
<br>
&gt; members. As this syntax and phrasing will be shared with Structs and<b=
r>
&gt; Unions as well, add the field list definition to a shared abstract<br>
&gt; class.<br>
<br>
docs/devel/qapi-code-gen.rst calls it &quot;event-specific data&quot;.=C2=
=A0 This is<br>
quite a mouthful, so the code usually calls it &quot;arguments&quot;.=C2=A0=
 Not least<br>
because events are kind of like commands going in the other direction<br>
(client to server), and the code dealing with them is often similar.<br>
<br>
Both names make more sense to me than &quot;member&quot;.=C2=A0 Hmm.=C2=A0 =
A rename could be<br>
done as a follow-up if that&#39;s more convenient for you.<br></blockquote>=
<div><br></div><div>Also wish you&#39;d have said sooner :)</div><div><br><=
/div><div>I might punt this one. At least, the next respin probably won&#39=
;t include this.</div><div><br></div><div>I suppose I think about this in t=
erms of &quot;members of the event object.&quot; Let&#39;s talk and fix lat=
er, changing the name outside of a gigantic series is not difficult at all.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; As per usual, QAPI cross-referencing for types in the member field lis=
t<br>
&gt; will be added in a forthcoming commit.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000007c2649062fc8ac02--


