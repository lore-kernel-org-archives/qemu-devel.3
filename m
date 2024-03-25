Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04037C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roj47-0003pN-Na; Mon, 25 Mar 2024 08:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1roj46-0003pE-Bo
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1roj44-00074R-B8
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711368271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrLeHG4BRyr5TQ1X9S3Va5SqhciaH9t+AHeMHfeZUWs=;
 b=JxJipGn2fF0wDhtuWb84VbfTqzgVkug3q6q1nGfi9IWccmbpqIzaQUqRIxuZMvnNMRomdv
 43Yr7t2Ixu7moK8xK7yM7VJOSr+OA533ZM7JiAu35lgLDxE6pBd7+M46wceg8cHUpgcZS/
 h02xEhzhomzauICsGR0Mf8IRtyNLLq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-sZGRnfW0PjK3j06YHtOZ0Q-1; Mon, 25 Mar 2024 08:04:29 -0400
X-MC-Unique: sZGRnfW0PjK3j06YHtOZ0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4148a697e35so2560215e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711368268; x=1711973068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrLeHG4BRyr5TQ1X9S3Va5SqhciaH9t+AHeMHfeZUWs=;
 b=fM42eZ0JUaKRJcDkqH1nKLT01IsVq0xPEaS5pANgqZ73t81Qa/Z8p6JMlbrTi/05wx
 XrXhM53cRt6/GgmP6LyTUd7/jGIegfBohshyp+wcF3g8KT3KgK1j8lsC0tCq16AMb10D
 XCAIM//g7Fv1E1A/GPg/x8lLMEnM7OuMVn3zC3uFynAjm3BCdU/8QvegkxoHImbat3Pf
 Ddct8aaRd4ZjX6bO3TuZ1I/TfmQN0Rs2f2tjGtJZ3cL21Q3GLD/Jr09FnBG7pmucRHm4
 G4fpwPeq1pO7GzZGn7M6dWreh8okrdN7TkLhLleE4/ECISCn0klAqi1NdyuvrxpOg8TZ
 3mKw==
X-Gm-Message-State: AOJu0YyCYuJFoesTs8dJkgFG5jc90X7+c4MPvVRoz9e3ViLBWSoz45zW
 G8v1GTKiL4xDkXq9u/boqXmn4xYFyv5iLvQdN9UhlWSvvJghpiSFUhkk0hE1Gtj105sBW8cn4mV
 hOU+ylGcufnP67M37sA6qNzbcPrg8DQRDv3R0fDzTsY3hzXkdlNJ+Lzbarrehe1aqD6jCwuZ02P
 Kxj9xrNKQVlMrueNhg1YNdTDjoiM0=
X-Received: by 2002:a05:6000:dcd:b0:33e:c9ce:23fe with SMTP id
 dw13-20020a0560000dcd00b0033ec9ce23femr4214626wrb.25.1711368268153; 
 Mon, 25 Mar 2024 05:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBIn1hu2gdl5Ae1sDQVYpUxvvmBEpHoJdzumch0fG7x+KyV8YApvzSafKGt4h/PB4WsszSRPgCmHuYyMD+qx4=
X-Received: by 2002:a05:6000:dcd:b0:33e:c9ce:23fe with SMTP id
 dw13-20020a0560000dcd00b0033ec9ce23femr4214612wrb.25.1711368267850; Mon, 25
 Mar 2024 05:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240325104502.1358693-1-pbonzini@redhat.com>
 <87o7b2mtki.fsf@pond.sub.org>
In-Reply-To: <87o7b2mtki.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 13:04:14 +0100
Message-ID: <CABgObfbDa57=+tJ_t=nFWY=CnZJq2Kkx7Wdc=PL93NB6yFVBEA@mail.gmail.com>
Subject: Re: [PATCH] qapi: document leftover members in qapi/run-state.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000af7b5406147af907"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000af7b5406147af907
Content-Type: text/plain; charset="UTF-8"

Il lun 25 mar 2024, 12:36 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  qapi/run-state.json | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > index 789fc34559a..cb4a2b43293 100644
> > --- a/qapi/run-state.json
> > +++ b/qapi/run-state.json
> > @@ -377,9 +377,17 @@
> >  ##
> >  # @watchdog-set-action:
> >  #
> > -# Set watchdog action
> > +# Set watchdog action.
> > +#
> > +# @action: @WatchdogAction action taken when watchdog timer expires.
> >  #
> >  # Since: 2.11
> > +#
> > +# Example:
> > +#
> > +#     -> { "execute": "watchdog-set-action",
> > +#          "arguments": { "action": "inject-nmi" } }
> > +#     <- { "return": {} }
> >  ##
> >  { 'command': 'watchdog-set-action', 'data' : {'action':
> 'WatchdogAction'} }
> >
>
> Appreciate the example!
>

It may even be worth deprecating the command, since action-set is a clean
superset. But I didn't check if libvirt knows about action-set and it's
cheap enough to implement watchdog-set-action as well.

> @@ -505,6 +513,22 @@
> >  #
> >  # Hyper-V specific guest panic information (HV crash MSRs)
> >  #
> > +# @arg1: for Windows, STOP code for the guest crash.  For Linux,
> > +#        an error code.
> > +#
> > +# @arg2: for Windows, first argument of the STOP.  For Linux, the
> > +#        guest OS id, which has the kernel version in bits 16-47
>
> Mind if I capitalize ID?
>

Go ahead if you are going to queue it.

Paolo


> > +#        and 0x8100 in bits 48-63.
> > +#
> > +# @arg3: for Windows, second argument of the STOP.  For Linux, the
> > +#        program counter of the guest.
> > +#
> > +# @arg4: for Windows, third argument of the STOP.  For Linux, the
> > +#        RAX register (x86) or the stack pointer (aarch64) of the guest.
> > +#
> > +# @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
> > +#        stack pointer of the guest.
> > +#
> >  # Since: 2.9
> >  ##
> >  {'struct': 'GuestPanicInformationHyperV',
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000af7b5406147af907
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 25 mar 2024, 12:36 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Paolo Bonzini &lt;<a href=3D"mailto:pbonz=
ini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a=
>&gt; writes:<br>
<br>
&gt; Suggested-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/run-state.json | 26 +++++++++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 25 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/qapi/run-state.json b/qapi/run-state.json<br>
&gt; index 789fc34559a..cb4a2b43293 100644<br>
&gt; --- a/qapi/run-state.json<br>
&gt; +++ b/qapi/run-state.json<br>
&gt; @@ -377,9 +377,17 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @watchdog-set-action:<br>
&gt;=C2=A0 #<br>
&gt; -# Set watchdog action<br>
&gt; +# Set watchdog action.<br>
&gt; +#<br>
&gt; +# @action: @WatchdogAction action taken when watchdog timer expires.<=
br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 2.11<br>
&gt; +#<br>
&gt; +# Example:<br>
&gt; +#<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;watchdog-set-=
action&quot;,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &quot;ac=
tion&quot;: &quot;inject-nmi&quot; } }<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;watchdog-set-action&#39;, &#39;data&#3=
9; : {&#39;action&#39;: &#39;WatchdogAction&#39;} }<br>
&gt;=C2=A0 <br>
<br>
Appreciate the example!<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">It may even be worth deprecating the command, since =
action-set is a clean superset. But I didn&#39;t check if libvirt knows abo=
ut action-set and it&#39;s cheap enough to implement watchdog-set-action as=
 well.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">&gt; @@ -505,6 +513,22 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Hyper-V specific guest panic information (HV crash MSRs)<br>
&gt;=C2=A0 #<br>
&gt; +# @arg1: for Windows, STOP code for the guest crash.=C2=A0 For Linux,=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 an error code.<br>
&gt; +#<br>
&gt; +# @arg2: for Windows, first argument of the STOP.=C2=A0 For Linux, th=
e<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest OS id, which has the kernel versio=
n in bits 16-47<br>
<br>
Mind if I capitalize ID?<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Go ahead if you are going to queue it.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 and 0x8100 in bits 48-63.<br>
&gt; +#<br>
&gt; +# @arg3: for Windows, second argument of the STOP.=C2=A0 For Linux, t=
he<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 program counter of the guest.<br>
&gt; +#<br>
&gt; +# @arg4: for Windows, third argument of the STOP.=C2=A0 For Linux, th=
e<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 RAX register (x86) or the stack pointer =
(aarch64) of the guest.<br>
&gt; +#<br>
&gt; +# @arg5: for Windows, fourth argument of the STOP.=C2=A0 For x86 Linu=
x, the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 stack pointer of the guest.<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.9<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 {&#39;struct&#39;: &#39;GuestPanicInformationHyperV&#39;,<br>
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000af7b5406147af907--


