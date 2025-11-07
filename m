Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6B0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHOc8-0004yR-5S; Fri, 07 Nov 2025 10:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHOc3-0004xB-H8
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHOc1-0006m1-BZ
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762530171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sbkir8UKlgguOZkIJp8ilmdEgoQdTbAWoFXpYKIF41U=;
 b=iRgd1g1dY/Ke2rYuR3KW5xeyLAfbAJ44DVga/0RRul4OIRLrm9CaSSQvybyL2wza2g9U0g
 ZGXfSMPoHMPOVOCrXZjvhVwxQV2bF8Km1lafKohEDVAKHHAgM1rdlSef5psF9gpAmxW2Mm
 pZbUqj1QMbANSZTfGRSYd8jj7CEKup8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-946mOuQFO46q-s4P7lQpfg-1; Fri,
 07 Nov 2025 10:42:48 -0500
X-MC-Unique: 946mOuQFO46q-s4P7lQpfg-1
X-Mimecast-MFC-AGG-ID: 946mOuQFO46q-s4P7lQpfg_1762530167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A750B18002CC; Fri,  7 Nov 2025 15:42:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6D431945110; Fri,  7 Nov 2025 15:42:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01BF921E6A27; Fri, 07 Nov 2025 16:42:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,  Fan Ni
 <fan.ni@samsung.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 5/9] scripts/clean-includes: Give the args in git commit
 messages
In-Reply-To: <87jz027y9s.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 07 Nov 2025 14:44:31 +0100")
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-6-peter.maydell@linaro.org>
 <87zf8yaw06.fsf@pond.sub.org>
 <CAFEAcA96NhaKQGWeMC0Gx9pM36cZfCD4g=xVW58_mWgKg1Qc8Q@mail.gmail.com>
 <87jz027y9s.fsf@pond.sub.org>
Date: Fri, 07 Nov 2025 16:42:42 +0100
Message-ID: <87seep7sst.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Fri, 7 Nov 2025 at 12:05, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>> > If clean-includes is creating a git commit for its changes,
>>> > currently it says only "created with scripts/clean-includes".
>>> > Add the command line arguments the user passed us, as useful
>>> > extra information.
>>> >
>>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> > ---
>>> >  scripts/clean-includes | 6 +++++-
>>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/scripts/clean-includes b/scripts/clean-includes
>>> > index a45421d2ff7..694e12f062c 100755
>>> > --- a/scripts/clean-includes
>>> > +++ b/scripts/clean-includes
>>> > @@ -42,6 +42,9 @@
>>> >  GIT=no
>>> >  DUPHEAD=no
>>> >
>>> > +# Save the original arguments in case we want to put them in
>>> > +# a git commit message
>>> > +ORIGARGS="$*"
>>> >
>>> >  while true
>>> >  do
>>> > @@ -198,7 +201,8 @@ if [ "$GIT" = "yes" ]; then
>>> >      git commit --signoff -F - <<EOF
>>> >  $GITSUBJ: Clean up includes
>>> >
>>> > -This commit was created with scripts/clean-includes.
>>> > +This commit was created with scripts/clean-includes:
>>> > + ./scripts/clean-includes $ORIGARGS
>>>
>>> Consider
>>>
>>>     $ ./scripts/clean-includes --git 'a b c' a b c
>>
>> Yes. Do you have a way to deal with that that isn't
>> more complex than justified by what we're doing here?
>>
>> thanks
>> -- PMM
>
> This doesn't feel too onerous:
>
>     args=
>     for i
>     do args+=" '""$i""'"
>     done
>
> However, += is bash.

Have a look at configure:

    printf "exec" >>config.status
    for i in "$0" "$@"; do
      test "$i" = --skip-meson || printf " %s" "$(quote_sh "$i")" >>config.status
    done

with shell function

    quote_sh() {
        printf "%s" "$1" | sed "s,','\\\\'',g; s,.*,'&',"
    }


