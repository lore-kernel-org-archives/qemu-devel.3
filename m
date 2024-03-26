Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12197C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp29x-0005Sh-OY; Tue, 26 Mar 2024 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp29w-0005SW-E2
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp29v-0007Ha-02
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711441669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54/K5Nf6UMsxw1XiSfhsRlDPT94F3Lu3eDWYDSVOjTI=;
 b=XXc1VLQeGNTIZNaV4/t6A53NI8Zge9BYQR+uksC9VTK5SHl/1jAWv/Woyohzj28paSougY
 HPxh8w0/DJnHXmAJvXhtMnLqC1iarKwDtI1Kqgburx3S6eRePzRe3k5b4FdD2UmMRLyB3P
 nvt2xBOETUc14eKZlIXNkqrRVOFf7qM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-rxSSa3bNNXapyD1QMGkKyQ-1; Tue, 26 Mar 2024 04:27:47 -0400
X-MC-Unique: rxSSa3bNNXapyD1QMGkKyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A51DB85A58B
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:27:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8518E112132A
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:27:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80BB321E668C; Tue, 26 Mar 2024 09:27:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: Re: Let's close member documentation gaps
In-Reply-To: <87il1aodow.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 25 Mar 2024 10:36:47 +0100")
References: <87il1aodow.fsf@pond.sub.org>
Date: Tue, 26 Mar 2024 09:27:41 +0100
Message-ID: <87r0fxs8hu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> If you're cc'ed, I have a bit of doc work for you.  Search for your
> name to find it.
>
> The QAPI generator forces you to document your stuff.  Except for
> commands, events, enum and object types listed in pragma
> documentation-exceptions, the generator silently defaults missing
> documentation to "Not documented".  Right now, we're using this loophole
> some 500 times.
>
> Most of the offenders are enumeration values.  Their meaning is perhaps
> easier to guess than the meaning of command arguments, member data, and
> object type members.  Ignoring enumerations leaves 62 offenders.  Let's
> examine them.

[...]

> = qapi/net.json
>
> * String
>
>   Lack of the @str: section produces an embarrassing "Not documented" in
>   the generated documentation.  I can post a patch to make it less
>   embarrassing.  I doubt we can make it actually good, as generic
>   wrapper types like this one have meaning only in the context they are
>   used.  Therefore, their meaning can be usefully explained only at
>   their uses, not their definition.

I decided not to.

String is used for NetdevUserOptions members @dnssearch, @hostfwd, and
@guestfwd.  NetdevUserOptions are the type-specific arguments of
netdev-add with type "user".

@dnssearch is documented tolerably well, although there's less
information than for the CLI equivalent in qemu-options.hx.

@hostfwd is not: the string format is not documented at all.  It's its
own mini-language.  The CLI equivalent in qemu-options.hx documents it.

Of course, encoding information in strings like that is bad practice in
QMP.  Probably not worth fixing now.

Same for @guestfwd.

These documentation deficiencies are more serious than the "Not
documented" for String.  Only fixing the latter seems not worthwhile.

Jason, thoughts?

[...]


