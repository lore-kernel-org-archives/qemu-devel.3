Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839FC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 20:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUB1x-0004u1-81; Wed, 17 Jul 2024 16:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sUB1v-0004sr-RQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sUB1u-0008Su-Dt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721247217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+1dmBvNkj0l88BHTeVKjv+Qf1VqlPGOs5RJyAdzPB0=;
 b=ZtYWzn8FzyVMQvRSmxyJypj/Pi0TuR6459UUu/utH8gqLf4vj6qurb1JFG1DqhDdRimrX6
 GyQ6kSonSbw1nqTeWcoJs3CLn06vcepUuCWH6APRsefdPiIKmjSUBqJkfNQwRzPx1y50tt
 bdH/bsFuthnmZFpPave63wWeQkpd0rg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-5QBLN70NPYGamEj_IvOUwA-1; Wed, 17 Jul 2024 16:13:31 -0400
X-MC-Unique: 5QBLN70NPYGamEj_IvOUwA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-649731dd35bso31616a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 13:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721247210; x=1721852010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+1dmBvNkj0l88BHTeVKjv+Qf1VqlPGOs5RJyAdzPB0=;
 b=BJzYSBjL4zx73u9Qt2+LKJPGV+m3oDR6MdtxrTqWHlBptFDmwaEvNo7XwDUOwY1cTH
 Yg9KZX76C5v41oDmgJM9F7XghNq68Z4V+/4jytWlgwkTyMMiZ/RyxtlOpjwJ+e3iG3+1
 48PVFcZTZ2WkG6UDiBJ0eRHvoLFoIXph2QN0Yhkp9cb5g0MOe8980uuN+JnB6wp+PnYd
 A/tx6tzqgCx+brz394hKFruNTgRaMqEjZxaCrxOtglEgWOAjy6pPoZ7dSRxfZHnj/Uj0
 s6S7BW10eSmn5HNmmyaxsANXFfeCEX4MZbJcnQuWxFosX3yXYYfPcUvmmmVbjMBHjs/a
 vyZw==
X-Gm-Message-State: AOJu0YyuRtpYVS/IuGy/J/Rj5Ee/9ue3sG7AjjSJMdWAG6iECJeaD18P
 TgON+gh0GbT/KWqx1v7btkOPxpUObrgjMu0qXmebSrS75Fckgqd4mIFzfnDbGHx2x4TQogwMcVv
 NfSUE5Yh8ntuK8sczNkxRRzK6rmgyvp+DbsZPQsR4UbLAaWiet0CzY2xcqMVbvgXXdqpV+pfK62
 ad7V1kefwnFgoFsZG6s9y5LcvmsYM=
X-Received: by 2002:a05:6a21:7896:b0:1c2:8a69:338c with SMTP id
 adf61e73a8af0-1c3fddb3df1mr3808920637.39.1721247210527; 
 Wed, 17 Jul 2024 13:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBbjkYK/lFQjfcZiFd8iJbOiFs06oBJwTU9XMay7Suk626m59+pmfX9eqfYjyyK+FJeFkhOeY59uFhmQk2cak=
X-Received: by 2002:a05:6a21:7896:b0:1c2:8a69:338c with SMTP id
 adf61e73a8af0-1c3fddb3df1mr3808879637.39.1721247210163; Wed, 17 Jul 2024
 13:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240717021312.606116-1-jsnow@redhat.com>
 <871q3sgus6.fsf@pond.sub.org>
In-Reply-To: <871q3sgus6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 Jul 2024 16:13:17 -0400
Message-ID: <CAFn=p-b7KQkd5W8N3mRopsXPogtsYg9RcvLF2Cb0UKYy0dpFaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] qapi: convert example sections to qmp-example rST
 directives
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008867ac061d77182c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008867ac061d77182c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024, 6:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patchset focuses on converting example sections to rST directives
> > using a new `.. qmp-example::` directive.
>
> Queued, thanks!
>

Yay!

>

--0000000000008867ac061d77182c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 17, 2024, 6:47=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; This patchset focuses on converting example sections to rST directives=
<br>
&gt; using a new `.. qmp-example::` directive.<br>
<br>
Queued, thanks!<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Yay!</div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000008867ac061d77182c--


