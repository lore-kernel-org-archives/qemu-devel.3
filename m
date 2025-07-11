Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD3FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6Ni-0000WZ-GI; Fri, 11 Jul 2025 01:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Ng-0000P3-L3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6Nd-0006XU-VP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752211984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BtO/ck079/6DHbiQZCw9opQLCI78fBKU3CtVeGZH7xU=;
 b=eAcRmjFlkcmnnAeMLbT+OaLEziTpYKfUuyhG89F0IrRLvD2IwAQ6uKzMiWpcruefps1sYY
 C1SfnQrupvE3qXfucHq+RIlNyxeEHpQ0ZQ74jRb3+cYe4nPzxrp0z1YRTRzfge4kmiSIIU
 sg14wbtR0bN/XoZ09G+rysp9gMQONzg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-KYQ54VWGMwCMpOB_zt56eg-1; Fri, 11 Jul 2025 01:33:01 -0400
X-MC-Unique: KYQ54VWGMwCMpOB_zt56eg-1
X-Mimecast-MFC-AGG-ID: KYQ54VWGMwCMpOB_zt56eg_1752211981
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b39280167fdso1482921a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 22:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752211981; x=1752816781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtO/ck079/6DHbiQZCw9opQLCI78fBKU3CtVeGZH7xU=;
 b=aoe5LXlzqbooVepUnSgMEiMj0/7cFA1cDfwzxoJ2bezed1A87VNPu1MY7psujMkitY
 JObXzh0UCFKA42Q2gKYCBbE4na4ObmGV+d47MZFweQaQNiMI32lyHQIqDyHbVcaeEYcw
 xou6VbNWvJbtzgPR8RAl79JwsO+buvxnnJPbME2ZdYKpRXVqYaxRGFxlMHqu/2fUHkWA
 HmnHkQ6zd0ZEWPVia11p8Of83X3QXg3fhgJYfWhj/DaE9sdHaBgLsccSq/y5m5RIauZ/
 n0phWMhgqJrnk5+Ioks5GsbSwj4SsHlAOX9g0NlMnLgI/+dripqhF7Lz7l79C8Pnwqib
 XFbw==
X-Gm-Message-State: AOJu0Yz25QvuESCq+XJAXhqlsWG/ULW0xoj4KD8o0OZs57ut1wpgtl65
 72FS1CtH8cI3D4Ek7w2cEcYiDfPkwE/RNdN7dIsd0x7dZGVA6HVCBKSAtzYUoXQ0UNyH9mU/mKP
 FK5Wp1L0AoTnp8RHi+MXCl+RrwauDprI1rhkoVOR6mKokOz5YTJreVmIcbJfakyX2WIKsyEztFO
 tNvKMiLgtHi9KiAEQkm3qr9mffFD83cyI=
X-Gm-Gg: ASbGncuw6xgMaIY3Y0T4gtcesavpeFOzrOv/wrO6x7PO6MUu73nY9Bto08Yk7oYloE7
 tjViNhZdqSGmaiKdFQnfKJhf2RSmfJd68ly4dmGdp/9jmZzbfxWGDOQhIuthoH0VA389beDCXVw
 8FtXOrWR8Fz5J/MDWmSboAq7xO8pl9Br5C9gqLYBVtZES2LAIRkk+j
X-Received: by 2002:a17:90b:2b88:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-31c50e4661cmr1588766a91.33.1752211980760; 
 Thu, 10 Jul 2025 22:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ0ZiQ6+liwShKB1Rp9IvyiL20O7wzIQGbX4PXL93uwfk+7+KmbFnl/BMas7AtEfzclnVMSsfz8MzyDOdcvFU=
X-Received: by 2002:a17:90b:2b88:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-31c50e4661cmr1588703a91.33.1752211980259; Thu, 10 Jul 2025
 22:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-9-jsnow@redhat.com>
 <87zfdnow6f.fsf@pond.sub.org>
In-Reply-To: <87zfdnow6f.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 Jul 2025 01:32:48 -0400
X-Gm-Features: Ac12FXzyLIrqmGT3j4fjmP1myyw2orXCKojWoSbuDvegetJQowA-aMZ7MX4iZgk
Message-ID: <CAFn=p-YDQ8T_ukjZiwo=tQEYU0Nm3cvdVsOApxWRdXPRcAOKNQ@mail.gmail.com>
Subject: Re: [PATCH 08/18] qapi: add cross-references to migration.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 2, 2025 at 4:04=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/migration.json | 62 ++++++++++++++++++++++-----------------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index d7c5047462e..fec6479a23e 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
>
> [...]
>
> > @@ -646,10 +646,10 @@
> >  #     memory-backend-epc is not supported.  The VM must be started
> >  #     with the '-machine aux-ram-share=3Don' option.
> >  #
> > -#     When using -incoming defer, you must issue the migrate command
> > +#     When using -incoming defer, you must issue the `migrate` command
> >  #     to old QEMU before issuing any monitor commands to new QEMU.
> >  #     However, new QEMU does not open and read the migration stream
> > -#     until you issue the migrate incoming command.
> > +#     until you issue the `migrate` incoming command.
>
> I suspect this should be `migrate-incoming`.
>
> >  #
> >  #     (since 10.0)
> >  ##
>
> [...]
>
> > @@ -1733,8 +1733,8 @@
> >  #     list connected to a destination interface endpoint.
> >  #
> >  # @exit-on-error: Exit on incoming migration failure.  Default true.
> > -#     When set to false, the failure triggers a MIGRATION event, and
> > -#     error details could be retrieved with query-migrate.
> > +#     When set to false, the failure triggers a :qapi:event:`MIGRATION=
`
>
> When and why do we need :qapi:event:?

/home/jsnow/src/qemu/qapi/migration.json:1737: WARNING: more than one
target found for 'any' cross-reference 'MIGRATION': could be
:std:ref:`Migration framework` or
:qapi:event:`QMP:migration.MIGRATION` [ref.any]

>
> > +#     event, and error details could be retrieved with `query-migrate`=
.
> >  #     (since 9.1)
> >  #
> >  # Since: 2.3
>
> [...]
>


