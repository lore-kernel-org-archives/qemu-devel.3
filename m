Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E5C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBHU-0006FZ-Fn; Thu, 06 Mar 2025 08:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqBGn-00069u-KM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqBGi-0003tV-3D
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741267677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjQ/NbiUE+LGUOD8WauZX81xXrfE8k/1CDdmdy1Irsw=;
 b=drTISwbspAiCj1imSL1NLIyIuKNWxwSwvb1vOidybaUyCFU2JmY6eblU/9LAJLnDlBifQv
 FazWgNkGsv9h68T8kX7YZMgbrBwM2Yo4sD0t3E8zT8P0pgk6/h8XlVawmgGebJdHCA0h2Q
 qOASc1ymfFRIxw4GEpvbf8AYKX4S2Ns=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-6O9D65gTNm2yuAhg8sqe0Q-1; Thu, 06 Mar 2025 08:27:51 -0500
X-MC-Unique: 6O9D65gTNm2yuAhg8sqe0Q-1
X-Mimecast-MFC-AGG-ID: 6O9D65gTNm2yuAhg8sqe0Q_1741267670
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2234dddbd6fso15752895ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741267670; x=1741872470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjQ/NbiUE+LGUOD8WauZX81xXrfE8k/1CDdmdy1Irsw=;
 b=q9mU0q0nk+LKRX1kikRFS3oBAro/BbYLBc6XPdvbn7fJtTi8l5OPyvTS7+DdfPq8/f
 m5SqoxSsO9MYT20tSgWVBPfF/2+erGEGZ93Da+TkU9NoiLgNdp98lDah2SQ0ZXLkSn7q
 dU9yumGctkcfYfJJs/+1qPSonBr/q6tHcooWtx2dp0WpokCAAF/zyc6I+HpWMMwe/FnG
 QkN0UpJMJ2VeHCbf+AzS8KA3NslC9s0MCA1BxDRJY3KzG3j9ZeaRkMiTdA/NEnQS75db
 ozCDT9dRNyS50fXEub1ub5/1BYR+u9LL2SDt9xyIbpqvGvVaVyjyqCW8qZkL2t/3RnCh
 JjlA==
X-Gm-Message-State: AOJu0YwjwNI1o7S04l5n8GzSu7Ath1SNUFl8E6xO6xLlO8w79J2qids6
 Db6gndwweypaylIhaG1BzQQZBZYvaidk9CNTKyRqz5q0F1MwZKDRDmRHTDVXleswMKX9kwk8e9C
 F3RqWLQSlaTDTQPlA2LzJHPSZjRw3mSyDBaCBdF/NIC6vHG1nGS4HIFjqnIbSLXTCnOny9FDDr3
 4LJpWTR5pYavJgVQBEP4EBUNPwCqE=
X-Gm-Gg: ASbGncvd+83gUpotALfd5lWPXitN2JuJaBztt2HZtKtelFBb5WzmfBhuxmMZaF0lDYF
 L2FMwiqEbcnPDk2abB7LEljeVWP04kcTDuCyt2Fk2iNrb9KIxGZJR7A6zEGiSnqxUNvEMx2mBvy
 PzvMrorINeDVKjin+03OX5LoySmaB4
X-Received: by 2002:a17:90b:3ec5:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-2ff617b5145mr5139775a91.15.1741267670103; 
 Thu, 06 Mar 2025 05:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDTlQe3Hc2VpC0EAs0iK4egDPfV3MFOK53uKiMrb5uw4hbz7RLtlgWU06Zb4WtUBMXP9lkbHwy+ptMwj6lWzw=
X-Received: by 2002:a17:90b:3ec5:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-2ff617b5145mr5139735a91.15.1741267669613; Thu, 06 Mar 2025
 05:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <87wmd272wo.fsf@pond.sub.org>
In-Reply-To: <87wmd272wo.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 6 Mar 2025 08:27:36 -0500
X-Gm-Features: AQ5f1JqnzhYd_zk7vx8DX9hErnu75ISQ309uRAI7TpzR2zq3Nt7MCDkCODkGOOU
Message-ID: <CAFn=p-ZcFT6nnm+jOf=5QsLmpR4K+PJYJ3VPN_wfdx8BL_q_WA@mail.gmail.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e826d8062fac7854"
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

--000000000000e826d8062fac7854
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025, 7:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> When I eyeballed the previous iteration, I made a few observations[1].
> Let's see what has changed.
>
> } New table of contents shows one level, old two.  No objection; the
> } navigation thingie on the left is more useful anyway.
>
> No change.  Okay.
>

This is configured in the .rst file, not in code. I just happened to use a
different level in my test document.

For initial merge, I'll probably enable the new generator on QMP only while
I work on namespace support.


> } The new generator elides unreferenced types.  Generally good, but two
> } observations:
> }
> } * QapiErrorClass is unreferenced, but its members are mentioned in
> }   Errors sections.  QapiErrorClass serves as better than nothing error
> }   code documentation, but it's gone in the new doc.  So this is a minor
> }   regression.  We can figure out what to do about it later.
> }
> } * Section "QMP errors" is empty in the new doc, because its entire
> }   contents is elided.  I guess we should elide the section as well, but
> }   it's fine to leave that for later.
>
> Unreferenced types are back.  Okay; we can elide them later.
>

Yep, it will come along with the inliner later.


> } Old doc shows a definition's since information like any other section.
> } New doc has it in the heading box.  Looks prettier and uses much less
> } space.  Not sure the heading box is the best place, but it'll do for
> } now, we can always move it around later.
>
> No change.
>

Always happy to take HTML/CSS patches from someone with a strong opinion.
For now, though, ...


> } The new doc's headings use "Struct" or "Union" where the old one uses
> } just "Object".  Let's keep "Object", please.
>
> Fixed.
>
> } In the new doc, some member references are no longer rendered as such,
> } e.g. @on-source-error and @on-target-error in BackupCommon's note.
> } Another small regression.
>
> Fixed.
>
> } Union branches are busted in the new generator's output.  I know they
> } used to work, so I'm not worried about it.
>
> Fixed: "When TAG-MEMBER is VALUE; The members of BRANCH-TYPE."
>
> The semicolon feels odd.  I'd use a colon there.  Or put the when at the
> end like the old generator does: "The members of BRANCH-TYPE when
> TAG-MEMBER is VALUE".
>

Easy to change!


> Side effects, I think:
>
> * Members of explicit base types are no longer inlined.  Instead: "The
>   members of BASE-TYPE."
>
> * Members of explicit command / event argument types are no longer
>   inlined.  Instead: "The members of ARG-TYPE."
>
> Both fine for the initial version.
>

Yeah, inliner is all or nothing.


> } The new doc shows the return type, the old doc doesn't.  Showing it is
> } definitely an improvement, but we need to adjust the doc text to avoid
> } silliness like "Returns: SnapshotInfo =E2=80=93 SnapshotInfo".
>
> No change.  Can polish on top.
>

I have a patch for this in my kvm forum branch, along with "convert
everything into actual cross-references". Will send afterwards.


> } The new doc shows Arguments / Members, Returns, and Errors in two-colum=
n
> } format.  Looks nice.  But for some reason, the two columns don't align
> } horizontally for Errors like they do for the others.  Certainly not a
> } blocker of anything, but we should try to fix it at some point.
>
> No change.  Fine to leave for later.
>

Yes, but I did figure out why and I do have a solution planned now. It's
something I had to work around for "The members of..." pointers.


> } The new doc doesn't show non-definition conditionals, as mentioned in
> } the cover letter.  It shows definition conditionals twice.  Once should
> } suffice.
>
> No change.  You asked for advice, and I gave some[2].
>

D'oh!


> } There's probably more, but this is it for now.
>
> Again, this is it for now.
>
>
>
> [1] Message-ID: <87wmds4tpk.fsf@pond.sub.org>
> https://lore.kernel.org/qemu-devel/87wmds4tpk.fsf@pond.sub.org/
>
> [2] Message-ID: <87zfhya0is.fsf@pond.sub.org>
> https://lore.kernel.org/qemu-devel/87zfhya0is.fsf@pond.sub.org/
>
>

--000000000000e826d8062fac7854
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 6, 2025, 7:35=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When I eyeba=
lled the previous iteration, I made a few observations[1].<br>
Let&#39;s see what has changed.<br>
<br>
} New table of contents shows one level, old two.=C2=A0 No objection; the<b=
r>
} navigation thingie on the left is more useful anyway.<br>
<br>
No change.=C2=A0 Okay.<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">This is configured in the .rst file, not in code. I j=
ust happened to use a different level in my test document.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">For initial merge, I&#39;ll probably ena=
ble the new generator on QMP only while I work on namespace support.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmai=
l_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
} The new generator elides unreferenced types.=C2=A0 Generally good, but tw=
o<br>
} observations:<br>
} <br>
} * QapiErrorClass is unreferenced, but its members are mentioned in<br>
}=C2=A0 =C2=A0Errors sections.=C2=A0 QapiErrorClass serves as better than n=
othing error<br>
}=C2=A0 =C2=A0code documentation, but it&#39;s gone in the new doc.=C2=A0 S=
o this is a minor<br>
}=C2=A0 =C2=A0regression.=C2=A0 We can figure out what to do about it later=
.<br>
} <br>
} * Section &quot;QMP errors&quot; is empty in the new doc, because its ent=
ire<br>
}=C2=A0 =C2=A0contents is elided.=C2=A0 I guess we should elide the section=
 as well, but<br>
}=C2=A0 =C2=A0it&#39;s fine to leave that for later.<br>
<br>
Unreferenced types are back.=C2=A0 Okay; we can elide them later.<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yep, it wi=
ll come along with the inliner later.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
} Old doc shows a definition&#39;s since information like any other section=
.<br>
} New doc has it in the heading box.=C2=A0 Looks prettier and uses much les=
s<br>
} space.=C2=A0 Not sure the heading box is the best place, but it&#39;ll do=
 for<br>
} now, we can always move it around later.<br>
<br>
No change.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Always happy to take HTML/CSS patches from someone with a strong =
opinion. For now, though, ...</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
} The new doc&#39;s headings use &quot;Struct&quot; or &quot;Union&quot; wh=
ere the old one uses<br>
} just &quot;Object&quot;.=C2=A0 Let&#39;s keep &quot;Object&quot;, please.=
<br>
<br>
Fixed.<br>
<br>
} In the new doc, some member references are no longer rendered as such,<br=
>
} e.g. @on-source-error and @on-target-error in BackupCommon&#39;s note.<br=
>
} Another small regression.<br>
<br>
Fixed.<br>
<br>
} Union branches are busted in the new generator&#39;s output.=C2=A0 I know=
 they<br>
} used to work, so I&#39;m not worried about it.<br>
<br>
Fixed: &quot;When TAG-MEMBER is VALUE; The members of BRANCH-TYPE.&quot;<br=
>
<br>
The semicolon feels odd.=C2=A0 I&#39;d use a colon there.=C2=A0 Or put the =
when at the<br>
end like the old generator does: &quot;The members of BRANCH-TYPE when<br>
TAG-MEMBER is VALUE&quot;.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Easy to change!</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
Side effects, I think:<br>
<br>
* Members of explicit base types are no longer inlined.=C2=A0 Instead: &quo=
t;The<br>
=C2=A0 members of BASE-TYPE.&quot;<br>
<br>
* Members of explicit command / event argument types are no longer<br>
=C2=A0 inlined.=C2=A0 Instead: &quot;The members of ARG-TYPE.&quot;<br>
<br>
Both fine for the initial version.<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Yeah, inliner is all or nothing.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
} The new doc shows the return type, the old doc doesn&#39;t.=C2=A0 Showing=
 it is<br>
} definitely an improvement, but we need to adjust the doc text to avoid<br=
>
} silliness like &quot;Returns: SnapshotInfo =E2=80=93 SnapshotInfo&quot;.<=
br>
<br>
No change.=C2=A0 Can polish on top.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I have a patch for this in my kvm forum =
branch, along with &quot;convert everything into actual cross-references&qu=
ot;. Will send afterwards.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
} The new doc shows Arguments / Members, Returns, and Errors in two-column<=
br>
} format.=C2=A0 Looks nice.=C2=A0 But for some reason, the two columns don&=
#39;t align<br>
} horizontally for Errors like they do for the others.=C2=A0 Certainly not =
a<br>
} blocker of anything, but we should try to fix it at some point.<br>
<br>
No change.=C2=A0 Fine to leave for later.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Yes, but I did figure out why and =
I do have a solution planned now. It&#39;s something I had to work around f=
or &quot;The members of...&quot; pointers.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
} The new doc doesn&#39;t show non-definition conditionals, as mentioned in=
<br>
} the cover letter.=C2=A0 It shows definition conditionals twice.=C2=A0 Onc=
e should<br>
} suffice.<br>
<br>
No change.=C2=A0 You asked for advice, and I gave some[2].<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">D&#39;oh!</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
} There&#39;s probably more, but this is it for now.<br>
<br>
Again, this is it for now.<br>
<br>
<br>
<br>
[1] Message-ID: &lt;<a href=3D"mailto:87wmds4tpk.fsf@pond.sub.org" target=
=3D"_blank" rel=3D"noreferrer">87wmds4tpk.fsf@pond.sub.org</a>&gt;<br>
<a href=3D"https://lore.kernel.org/qemu-devel/87wmds4tpk.fsf@pond.sub.org/"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.org/qe=
mu-devel/87wmds4tpk.fsf@pond.sub.org/</a><br>
<br>
[2] Message-ID: &lt;<a href=3D"mailto:87zfhya0is.fsf@pond.sub.org" target=
=3D"_blank" rel=3D"noreferrer">87zfhya0is.fsf@pond.sub.org</a>&gt;<br>
<a href=3D"https://lore.kernel.org/qemu-devel/87zfhya0is.fsf@pond.sub.org/"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.org/qe=
mu-devel/87zfhya0is.fsf@pond.sub.org/</a><br>
<br>
</blockquote></div></div></div>

--000000000000e826d8062fac7854--


