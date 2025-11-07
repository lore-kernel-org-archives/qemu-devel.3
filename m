Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C55CCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMlf-0003Mn-C0; Fri, 07 Nov 2025 08:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHMlc-0003Ma-Qo
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHMlb-0005iI-95
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762523078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thww8VqIuLD047w2QvjLTIlU/6D0ePGeE4jW7Rmjyy4=;
 b=buMhhAVvos095ZDJbNQ60ajVoyFtaxFrW7FZCNuFcxkgyy+4SO+7trEkhAEGijkBh8QOjd
 5ooEUQp6rnAA9MGS6ieE/VMROX5XZncrhmPye92YgN+J6dZ8cns2PT+8SYzrbL+16BBNvj
 m61YTy+SAWcrfLzrfQt5pFD91+cOjjA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-5e-mCjFNNKqed9KtHbs3xQ-1; Fri,
 07 Nov 2025 08:44:36 -0500
X-MC-Unique: 5e-mCjFNNKqed9KtHbs3xQ-1
X-Mimecast-MFC-AGG-ID: 5e-mCjFNNKqed9KtHbs3xQ_1762523075
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0945219560B3; Fri,  7 Nov 2025 13:44:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F04A19560B2; Fri,  7 Nov 2025 13:44:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7095A21E6A27; Fri, 07 Nov 2025 14:44:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>,  John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 5/9] scripts/clean-includes: Give the args in git commit
 messages
In-Reply-To: <CAFEAcA96NhaKQGWeMC0Gx9pM36cZfCD4g=xVW58_mWgKg1Qc8Q@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Nov 2025 13:14:12 +0000")
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-6-peter.maydell@linaro.org>
 <87zf8yaw06.fsf@pond.sub.org>
 <CAFEAcA96NhaKQGWeMC0Gx9pM36cZfCD4g=xVW58_mWgKg1Qc8Q@mail.gmail.com>
Date: Fri, 07 Nov 2025 14:44:31 +0100
Message-ID: <87jz027y9s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Nov 2025 at 12:05, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > If clean-includes is creating a git commit for its changes,
>> > currently it says only "created with scripts/clean-includes".
>> > Add the command line arguments the user passed us, as useful
>> > extra information.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> >  scripts/clean-includes | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/clean-includes b/scripts/clean-includes
>> > index a45421d2ff7..694e12f062c 100755
>> > --- a/scripts/clean-includes
>> > +++ b/scripts/clean-includes
>> > @@ -42,6 +42,9 @@
>> >  GIT=no
>> >  DUPHEAD=no
>> >
>> > +# Save the original arguments in case we want to put them in
>> > +# a git commit message
>> > +ORIGARGS="$*"
>> >
>> >  while true
>> >  do
>> > @@ -198,7 +201,8 @@ if [ "$GIT" = "yes" ]; then
>> >      git commit --signoff -F - <<EOF
>> >  $GITSUBJ: Clean up includes
>> >
>> > -This commit was created with scripts/clean-includes.
>> > +This commit was created with scripts/clean-includes:
>> > + ./scripts/clean-includes $ORIGARGS
>>
>> Consider
>>
>>     $ ./scripts/clean-includes --git 'a b c' a b c
>
> Yes. Do you have a way to deal with that that isn't
> more complex than justified by what we're doing here?
>
> thanks
> -- PMM

This doesn't feel too onerous:

    args=
    for i
    do args+=" '""$i""'"
    done

However, += is bash.


