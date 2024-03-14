Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE1FC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmKD-0003PR-Da; Thu, 14 Mar 2024 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkmK8-0003P3-F8
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkmJt-0004Zh-58
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710427471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=79PsWsn7rwnMKGuP1yDZdYnVLUWXZxNeCrkm8xc2mM8=;
 b=Q+cS/rxgLRQqTl0TCpW8Qrb1uQJJhltTunFFq41c/KsGSU7TfIBpimKTnpurkb5+UpTzwo
 ohLpb1sq4taRK/JxGTJzR3rDWF71N/02rPTZZcnyVjcxXvQuJ+6zmjZV1gjk+ytttAfw3V
 p90uqqN93Mvtv+Yq6zIUFYuuBFSiN/A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Zh4uSE6HNZaAsg2q8iIEkA-1; Thu, 14 Mar 2024 10:44:29 -0400
X-MC-Unique: Zh4uSE6HNZaAsg2q8iIEkA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dd916d7d55so8955625ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710427468; x=1711032268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79PsWsn7rwnMKGuP1yDZdYnVLUWXZxNeCrkm8xc2mM8=;
 b=bR0MwtwRzwrq+gSK70CwjOQ7YnTli6hW2/vQ+fGngulVbv8SNrehJjSwXanS9er5mz
 B6RmkBoYKcbBMiSiQ7rnamoy9LTs0Fv4FL91IS7j9E+iK4L2R7LiLC6YWzmYuu4r7wTy
 IpFOGQZfBiaP1oszh7Lol63fgcpyThs1d9KKll/6KLIUTQ/PEAKzgUOPrUlnKEcPz+eD
 fpfG+r0S6w8Z8/VNqehqs9f0fkl/ERosHxhJYP+coD9pOSX7VH6mFhOUG8CAoiNJrFz+
 XNOFrcjV4ACr1Nf5Ye51vjMfnCTYHYEDObMX4WjQnfLiQmZGctsNUvNpv76Weg4lomEa
 LUjw==
X-Gm-Message-State: AOJu0YxGURUoAH3W2uZ/jiTUe402zsNW6dtgzi4JAvJqvuYX3nTzKY29
 5BkcSTcBmg8b+txEsmW0WMDKeu3horK03f5IPvQnH9BP5/hGLVnD9TeSU8281cWiZTaezRuNNNr
 T4UeC8XqMPQ42TZ9d7QWUSUs068XTM30lukpBmQ1KQenjnfkOGapE8+wvAxd1+uyCU/QrHXcFLk
 Z4IhiMvMSloAcwrTZk+owKBuOAIAk=
X-Received: by 2002:a17:903:1112:b0:1dd:da9d:940d with SMTP id
 n18-20020a170903111200b001ddda9d940dmr2398846plh.38.1710427468090; 
 Thu, 14 Mar 2024 07:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+tlW8axk3m7NiPcx4OAfFaim84kwLXOSjxjJN+v3RRd3SAlwzxWxQAeZ3OBZwakIKCO+ayGOOaj9N6oGoGGI=
X-Received: by 2002:a17:903:1112:b0:1dd:da9d:940d with SMTP id
 n18-20020a170903111200b001ddda9d940dmr2398832plh.38.1710427467859; Thu, 14
 Mar 2024 07:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240313044127.49089-1-jsnow@redhat.com>
 <874jd898ne.fsf@pond.sub.org>
In-Reply-To: <874jd898ne.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Mar 2024 10:44:16 -0400
Message-ID: <CAFn=p-b-fdPaJjECXwL7_cwgxVHgjoMAGoPiRWMkiYFewKUtBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] qapi: statically type schema.py
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000a2dcb706139fed66"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000a2dcb706139fed66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024, 10:43=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is *v4*, for some definitions of "version" and "four".
>
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I'll replace PATCH 12, not because it's wrong, just because I like my
> replacement better.  I'll post this and two follow-up patches as v5.
> I will not let the two follow-up patches delay queuing, though.
>
> Thanks!
>

Sounds good! I'll divert efforts to improving sphinx docs next unless you
have a higher priority to suggest.

--000000000000a2dcb706139fed66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 14, 2024, 10:43=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:j=
snow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&=
gt; writes:<br>
<br>
&gt; This is *v4*, for some definitions of &quot;version&quot; and &quot;fo=
ur&quot;.<br>
<br>
Series<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
I&#39;ll replace PATCH 12, not because it&#39;s wrong, just because I like =
my<br>
replacement better.=C2=A0 I&#39;ll post this and two follow-up patches as v=
5.<br>
I will not let the two follow-up patches delay queuing, though.<br>
<br>
Thanks!<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Sounds good! I&#39;ll divert efforts to improving sphinx docs next u=
nless you have a higher priority to suggest.=C2=A0</div></div>

--000000000000a2dcb706139fed66--


