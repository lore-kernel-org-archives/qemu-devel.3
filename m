Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E2C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgko1-0004nv-Bz; Fri, 16 Jan 2026 09:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgknn-0004b7-Bi
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgkng-0000hy-Ey
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768573646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tjqai45VtIpB+TC9hvLPc4FA8nk6wgFyh94OWo+MqPs=;
 b=iF83XWj2GgWNr+5y/V701FlVgthx/udr0nY4kuAqZ0B4CpgHEjddvESw72ziaM9iVB2tz3
 c9/LJ0fTf7rlWve1bPrBLTIH0gJPxhah189ifAPURH8pKbiCtM85k5ZOXi8+k9d5FXSStw
 nIIzHb+rNTKU6Nu0KJgl51Q+aefUFRo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-0DuN0OjXPCG341ywFxvuFQ-1; Fri,
 16 Jan 2026 09:27:24 -0500
X-MC-Unique: 0DuN0OjXPCG341ywFxvuFQ-1
X-Mimecast-MFC-AGG-ID: 0DuN0OjXPCG341ywFxvuFQ_1768573643
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B03719560B2; Fri, 16 Jan 2026 14:27:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 218C81955F22; Fri, 16 Jan 2026 14:27:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6ECE21E692D; Fri, 16 Jan 2026 15:27:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/6] scripts/clean-includes: Give the args in git
 commit messages
In-Reply-To: <CAFEAcA80HGxbESO8FwrHy967yXtVG1KMas=mWekaS436rrSamA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 16 Jan 2026 13:32:53 +0000")
References: <20260116124005.925382-1-peter.maydell@linaro.org>
 <20260116124005.925382-6-peter.maydell@linaro.org>
 <87a4ydwuty.fsf@pond.sub.org>
 <CAFEAcA80HGxbESO8FwrHy967yXtVG1KMas=mWekaS436rrSamA@mail.gmail.com>
Date: Fri, 16 Jan 2026 15:27:20 +0100
Message-ID: <87qzrpvdiv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Fri, 16 Jan 2026 at 13:28, Markus Armbruster <armbru@redhat.com> wrote:
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
>> >  scripts/clean-includes | 25 ++++++++++++++++++++++++-
>> >  1 file changed, 24 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/clean-includes b/scripts/clean-includes
>> > index a45421d2ff..b16eec0a5c 100755
>> > --- a/scripts/clean-includes
>> > +++ b/scripts/clean-includes
>> > @@ -42,6 +42,28 @@
>> >  GIT=no
>> >  DUPHEAD=no
>> >
>> > +# Save the original arguments in case we want to put them in
>> > +# a git commit message, quoted for the shell so that we handle
>> > +# args with spaces/metacharacters correctly.
>> > +# The quote_sh() function is the same one we use in configure.
>>
>> Not quite, configure's is
>>
>>    quote_sh() {
>>        printf "%s" "$1" | sed "s,','\\\\'',g; s,.*,'&',"
>>    }
>>
>> > +
>> > +quote_sh() {
>> > +    for arg in "$@"; do
>> > +        printf "%s" "$arg" | sed "s,','\\\\'',g; s,.*,'&',"
>> > +    done
>> > +}
>>
>> Is the loop intentional?  We seem to always call the function with
>> exactly one argument.
>
> Whoops, no -- I was iterating around trying to get something
> working and didn't notice that I'd left that loop in place.
> The quote_sh() function should match the configure one.

Got it.

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


