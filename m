Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E06C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMmj-00069L-8H; Thu, 20 Jun 2024 14:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKMmb-00066H-6x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKMmY-0005Ky-MR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718909113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uJ1LPa8rRtDYoRlv3LZ8aeXl6uZRdjl+D9oS4ZCWl8=;
 b=ZGab1cSvNKa+GU280fjQ5kTHvwc6sswd62efWeI/q1pM4QWtyP0g+CxVNQ/o4JK+CKCOOF
 e8lN3IXTpTijFHbf87hXc/eRV7pEnzUTw8NlVcDh8mCqPPRg4ycunV82hYx3leMrZc5nIt
 R3LL50uE8gmmqU53SnWdHsZ/B8TvHjQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-HpOkTvZOOjGFLYQHLqqdww-1; Thu, 20 Jun 2024 14:45:12 -0400
X-MC-Unique: HpOkTvZOOjGFLYQHLqqdww-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-6e73d656bd0so1163926a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718909111; x=1719513911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uJ1LPa8rRtDYoRlv3LZ8aeXl6uZRdjl+D9oS4ZCWl8=;
 b=k5W+GPRmwMVOmXFjX0R7DBUMV3eSO0BiZUT07nk5LNsPSw7OW+sFC8Z00lyV+hHU+l
 i43rnZZqTQslKkbquNPA/MedsrpqAcls2nBEXguS8NQzznVw/QO5hEHYO8uiPIMPtFYL
 o1iXIV6MkltWPMSx2ZIVfiPPP/9SxsYOMVe2I/PyQDSDChYD1+ecD4A7ZwFJ1gBGpe3c
 84CY9rPM164oAz04YkZ/rZS3M512EfFOQ4YbyGTAvdNMtHrirbVzKa7Ub2/Tu9f6WuUm
 1zokVHh/M6gL2aQsboekmlHyG51NB0FaopK+e58HVXeF0u80/GZUmQqYogX+UWhvbgN5
 zKNQ==
X-Gm-Message-State: AOJu0YxrokD9fV7KXCUfnf6LRRGni3zRHzrQQmdkKHIKvuA0uaZuqtX/
 AHUd14pKmBwlCYwirU6bI7sX3HjM5z8MtrhWaIrCVyl8W6Fx3Pii2jgfpPUkQdZUq1ub7S2rCjQ
 +pHlpNNaNaDUZGQyALSZwQRGNjNdbsGlzql3ngO5pIxaQuVNxH2F4EQcdDBoJ32LbN8QGMu8N3R
 EhOJY/WVJ9lzdFzG5+OUb0Clby8RM=
X-Received: by 2002:a17:90b:378f:b0:2c2:d0cc:3b9e with SMTP id
 98e67ed59e1d1-2c7b5d95a9bmr5560752a91.46.1718909110889; 
 Thu, 20 Jun 2024 11:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvUe6mTCHzKn0e5uYz4RDWO6F0spQsMXhIToW6DZGJ+Bdlps0ctkz40gMPPpMpuz11uS+cOl2Ntj+VJB9BdF4=
X-Received: by 2002:a17:90b:378f:b0:2c2:d0cc:3b9e with SMTP id
 98e67ed59e1d1-2c7b5d95a9bmr5560703a91.46.1718909110339; Thu, 20 Jun 2024
 11:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org> <87iky3u47v.fsf@pond.sub.org>
 <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
In-Reply-To: <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 14:44:58 -0400
Message-ID: <CAFn=p-abtycUzRefg8hdAENtdKMeeyEe0sMCEXee2Grn9i8PDw@mail.gmail.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ec5d57061b56b6b8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000ec5d57061b56b6b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:46=E2=80=AFAM John Snow <jsnow@redhat.com> wrote=
:

>
>
> On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > John Snow <jsnow@redhat.com> writes:
>>
>> [...]
>>
>> >> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> >> index b3de1fb6b3a..57598331c5c 100644
>> >> --- a/qga/qapi-schema.json
>> >> +++ b/qga/qapi-schema.json
>>
>> [...]
>>
>> >> @@ -631,8 +632,8 @@
>> >>  # Errors:
>> >>  #     - If hybrid suspend is not supported, Unsupported
>> >>  #
>> >> -# Notes: It's strongly recommended to issue the guest-sync command
>> >> -#     before sending commands when the guest resumes
>> >> +# .. note:: It's strongly recommended to issue the guest-sync comman=
d
>> >> +#    before sending commands when the guest resumes.
>> >>  #
>> >>  # Since: 1.1
>> >>  ##
>> >> @@ -1461,16 +1462,15 @@
>> >>  #     * POSIX: as defined by os-release(5)
>> >>  #     * Windows: contains string "server" or "client"
>> >>  #
>> >> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>> >> -#     @version, @version-id, @variant and @variant-id follow the
>> >> -#     definition specified in os-release(5). Refer to the manual pag=
e
>> >> -#     for exact description of the fields.  Their values are taken
>> >> -#     from the os-release file.  If the file is not present in the
>> >> -#     system, or the values are not present in the file, the fields
>> >> -#     are not included.
>> >> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>> >> +#    @version, @version-id, @variant and @variant-id follow the
>> >> +#    definition specified in os-release(5). Refer to the manual page
>> for
>> >> +#    exact description of the fields.  Their values are taken from t=
he
>> >> +#    os-release file.  If the file is not present in the system, or
>> the
>> >> +#    values are not present in the file, the fields are not included=
.
>> >>  #
>> >> -#     On Windows the values are filled from information gathered fro=
m
>> >> -#     the system.
>> >> +#    On Windows the values are filled from information gathered from
>> >> +#    the system.
>> >
>> > Please don't change the indentation here.  I get the same output with
>> >
>> >   @@ -1461,7 +1462,7 @@
>> >    #     * POSIX: as defined by os-release(5)
>> >    #     * Windows: contains string "server" or "client"
>> >    #
>> >   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
>> >   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
>> >    #     @version, @version-id, @variant and @variant-id follow the
>> >    #     definition specified in os-release(5). Refer to the manual pa=
ge
>> >    #     for exact description of the fields.  Their values are taken
>>
>> I'm blind.  Actually, you change indentation of subsequent lines from 4
>> to 3 *everywhere*.  I guess you do that to make subsequent lines line up
>> with the directive, here "note".
>>
>> Everywhere else, we indent such lines by 4.  Hmm.  How terrible would it
>> be not to mess with the alignment?
>>
>> If we want to use 3 for directives, is it worth pointing out in the
>> commit message?
>>
>> [...]
>>
>
> Let me look up some conventions and see what's the most prominent... as
> well as testing what emacs does by default (or if emacs can be configured
> to do what we want with in-tree style config. Warning: I am functionally
> inept at emacs lisp. Warning 2x: [neo]vi[m] users, you're entirely on you=
r
> own. I'm sorry.)
>
> I use three myself by force of habit and have some mild reluctance to
> respin for that reason, but ... guess we ought to be consistent if we can=
.
>
> (No idea where my habit came from. Maybe it is just because it looks nice
> to me and no other reason.)
>
> ((I have no plans, nor desire, to write any kind of checker to enforce
> this, though - sorry.))
>

Sphinx doc uses three spaces:
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#dir=
ectives

... but it warns that it's arbitrary; but it seems common to align with the
directive.

*
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#footnote=
s
   footnotes require "at least 3" spaces

*
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#directiv=
es
  directives are only required to be "indented" but the amount isn't
specified. rst docs use three.

I'm happy with three; I don't believe we need to make it consistent with
e.g. our home-spun field list syntax (arguments, features) or with code
blocks. I think whatever looks good in the source is fine, and I think
three looks good for directives. I don't think we need to require this, but
I can mention in the commit message that I chose it for the sake of
aesthetics and for parity with what most rST docs appear to use.

Note: emacs behavior for wrapping paragraphs in our QAPI files does not
create an indent if there isn't already one. I think convincing emacs to
apply rST rules inside of a JSON file we lie and call a Python file might
be beyond my ability to do quickly.

The default behavior for my emacs (which I haven't customized very much, if
at all) in our source tree for *.rst files is to wrap directive lines with
a three space indent.

So, I'm happy saying this is a good way to do it.

--js

--000000000000ec5d57061b56b6b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 20, 2024 at 11:46=E2=80=
=AFAM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster &=
lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" rel=3D"noreferre=
r" target=3D"_blank">armbru@redhat.com</a>&gt; writes:<br>
<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer" t=
arget=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
[...]<br>
<br>
&gt;&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt;&gt; index b3de1fb6b3a..57598331c5c 100644<br>
&gt;&gt; --- a/qga/qapi-schema.json<br>
&gt;&gt; +++ b/qga/qapi-schema.json<br>
<br>
[...]<br>
<br>
&gt;&gt; @@ -631,8 +632,8 @@<br>
&gt;&gt;=C2=A0 # Errors:<br>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If hybrid suspend is not supported, U=
nsupported<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# Notes: It&#39;s strongly recommended to issue the guest-sync co=
mmand<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resum=
es<br>
&gt;&gt; +# .. note:: It&#39;s strongly recommended to issue the guest-sync=
 command<br>
&gt;&gt; +#=C2=A0 =C2=A0 before sending commands when the guest resumes.<br=
>
&gt;&gt;=C2=A0 #<br>
&gt;&gt;=C2=A0 # Since: 1.1<br>
&gt;&gt;=C2=A0 ##<br>
&gt;&gt; @@ -1461,16 +1462,15 @@<br>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)<br=
>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;server=
&quot; or &quot;client&quot;<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# Notes: On POSIX systems the fields @id, @name, @pretty-name,<br=
>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and @variant=
-id follow the<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5). Refer=
 to the manual page<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=C2=A0 T=
heir values are taken<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0from the os-release file.=C2=A0 If the file =
is not present in the<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0system, or the values are not present in the=
 file, the fields<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0are not included.<br>
&gt;&gt; +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,=
<br>
&gt;&gt; +#=C2=A0 =C2=A0 @version, @version-id, @variant and @variant-id fo=
llow the<br>
&gt;&gt; +#=C2=A0 =C2=A0 definition specified in os-release(5). Refer to th=
e manual page for<br>
&gt;&gt; +#=C2=A0 =C2=A0 exact description of the fields.=C2=A0 Their value=
s are taken from the<br>
&gt;&gt; +#=C2=A0 =C2=A0 os-release file.=C2=A0 If the file is not present =
in the system, or the<br>
&gt;&gt; +#=C2=A0 =C2=A0 values are not present in the file, the fields are=
 not included.<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0On Windows the values are filled from inform=
ation gathered from<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0the system.<br>
&gt;&gt; +#=C2=A0 =C2=A0 On Windows the values are filled from information =
gathered from<br>
&gt;&gt; +#=C2=A0 =C2=A0 the system.<br>
&gt;<br>
&gt; Please don&#39;t change the indentation here.=C2=A0 I get the same out=
put with<br>
&gt;<br>
&gt;=C2=A0 =C2=A0@@ -1461,7 +1462,7 @@<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)=
<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;ser=
ver&quot; or &quot;client&quot;<br>
&gt;=C2=A0 =C2=A0 #<br>
&gt;=C2=A0 =C2=A0-# Notes: On POSIX systems the fields @id, @name, @pretty-=
name,<br>
&gt;=C2=A0 =C2=A0+# .. note:: On POSIX systems the fields @id, @name, @pret=
ty-name,<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and =
@variant-id follow the<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5=
). Refer to the manual page<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=
=C2=A0 Their values are taken<br>
<br>
I&#39;m blind.=C2=A0 Actually, you change indentation of subsequent lines f=
rom 4<br>
to 3 *everywhere*.=C2=A0 I guess you do that to make subsequent lines line =
up<br>
with the directive, here &quot;note&quot;.<br>
<br>
Everywhere else, we indent such lines by 4.=C2=A0 Hmm.=C2=A0 How terrible w=
ould it<br>
be not to mess with the alignment?<br>
<br>
If we want to use 3 for directives, is it worth pointing out in the<br>
commit message?<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Let me look up some conventions and see what&#39;s the most prominent.=
.. as well as testing what emacs does by default (or if emacs can be config=
ured to do what we want with in-tree style config. Warning: I am functional=
ly inept at emacs lisp. Warning 2x: [neo]vi[m] users, you&#39;re entirely o=
n your own. I&#39;m sorry.)</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">I use three myself by force of habit and have some mild reluctance to r=
espin for that reason, but ... guess we ought to be consistent if we can.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">(No idea where my habit c=
ame from. Maybe it is just because it looks nice to me and no other reason.=
)</div><div dir=3D"auto"><br></div><div dir=3D"auto">((I have no plans, nor=
 desire, to write any kind of checker to enforce this, though - sorry.))</d=
iv></div></blockquote><div><br></div><div>Sphinx doc uses three spaces: <a =
href=3D"https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.=
html#directives">https://www.sphinx-doc.org/en/master/usage/restructuredtex=
t/basics.html#directives</a></div><div><br></div><div>... but it warns that=
 it&#39;s arbitrary; but it seems common to align with the directive.</div>=
<div><br></div><div>* <a href=3D"https://docutils.sourceforge.io/docs/ref/r=
st/restructuredtext.html#footnotes">https://docutils.sourceforge.io/docs/re=
f/rst/restructuredtext.html#footnotes</a></div><div>=C2=A0=C2=A0 footnotes =
require &quot;at least 3&quot; spaces</div><div><br></div><div>* <a href=3D=
"https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#directi=
ves">https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#dir=
ectives</a></div><div>=C2=A0 directives are only required to be &quot;inden=
ted&quot; but the amount isn&#39;t specified. rst docs use three.</div><div=
><br></div><div>I&#39;m happy with three; I don&#39;t believe we need to ma=
ke it consistent with e.g. our home-spun field list syntax (arguments, feat=
ures) or with code blocks. I think whatever looks good in the source is fin=
e, and I think three looks good for directives. I don&#39;t think we need t=
o require this, but I can mention in the commit message that I chose it for=
 the sake of aesthetics and for parity with what most rST docs appear to us=
e.</div><div><br></div><div>Note: emacs behavior for wrapping paragraphs in=
 our QAPI files does not create an indent if there isn&#39;t already one. I=
 think convincing emacs to apply rST rules inside of a JSON file we lie and=
 call a Python file might be beyond my ability to do quickly.</div><div><br=
></div><div>The default behavior for my emacs (which I haven&#39;t customiz=
ed very much, if at all) in our source tree for *.rst files is to wrap dire=
ctive lines with a three space indent.<br></div><div><br></div><div>So, I&#=
39;m happy saying this is a good way to do it.</div><div><br></div><div>--j=
s<br></div></div></div>

--000000000000ec5d57061b56b6b8--


