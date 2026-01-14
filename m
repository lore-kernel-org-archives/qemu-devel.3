Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D04CD37E32
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0q1-0006UU-7K; Wed, 14 Jan 2026 08:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0pg-0006Sj-Ek
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:22:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0pd-0005vY-GY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768396959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQ/S7l0C/1Cq1EmWdEpjdcsLK7qnLtjfq1B8tIYG+nI=;
 b=UkyNi2933Mz6gay1K4K5uqEvR8mcHY9qPGVvKs8FOeFI71Rn43rmVumrkBWRqiOwvOL1vY
 nOBqrE3GpHjZvcFMiSkjOIHyc/3tBvwMataq2qNNXGzFpu+2VUx+6dfHJTSYOAVRVi/xEJ
 /w552Dmg85n6YzEPKOt0Adp0UJrMhvI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-HCsTvgaANgOJZXgR_-rTEw-1; Wed,
 14 Jan 2026 08:22:37 -0500
X-MC-Unique: HCsTvgaANgOJZXgR_-rTEw-1
X-Mimecast-MFC-AGG-ID: HCsTvgaANgOJZXgR_-rTEw_1768396957
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB03B1956080; Wed, 14 Jan 2026 13:22:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 664D91800240; Wed, 14 Jan 2026 13:22:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDE0821E692D; Wed, 14 Jan 2026 14:22:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org
Subject: Re: [PATCH 3/3] qemu-print: Document qemu_fprintf(),
 qemu_vfprintf() failure
In-Reply-To: <aWeU3soopEhPEQxN@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 14 Jan 2026 13:06:38 +0000")
References: <20260114124713.3308719-1-armbru@redhat.com>
 <20260114124713.3308719-4-armbru@redhat.com>
 <aWeS5wvUBU5FCKSI@redhat.com> <aWeU3soopEhPEQxN@redhat.com>
Date: Wed, 14 Jan 2026 14:22:33 +0100
Message-ID: <87o6mw1g86.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jan 14, 2026 at 12:58:15PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jan 14, 2026 at 01:47:13PM +0100, Markus Armbruster wrote:
>> > These functions fail when @stream is null and the current monitor
>> > isn't HMP.
>> >=20
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  util/qemu-print.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >=20
>> > diff --git a/util/qemu-print.c b/util/qemu-print.c
>> > index 4a30cd1a8e..bbf8c1823e 100644
>> > --- a/util/qemu-print.c
>> > +++ b/util/qemu-print.c
>> > @@ -45,6 +45,7 @@ int qemu_printf(const char *fmt, ...)
>> >  /*
>> >   * Print like vfprintf()
>> >   * Print to @stream if non-null, else to current monitor.
>> > + * Beware: the latter fails unless we have one and it is HMP.
>>=20
>> This leaves me curious what 'fails' means. In this case no
>> output is printed and the func returns -1.
>>=20
>> How about we rephrase to match the other method docs better
>>=20
>>  * Print to current HMP monitor if we have one, else to @stream
>>    if non-null, else returns -1
>
> Opps, no, wrong semantics.
>
>   * Print to @stream if non-null, else to current HMP monitor if
>     we have one, else returns -1

Yes, that's better.  What about:

    * Print to @stream if non-null, else to current HMP monitor if we
    * have one, else fail without printing anything.
    * Return number of characters printed on success, negative value on
    * error.

>> >   */
>> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>> >  {
>> > @@ -57,6 +58,7 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_=
list ap)
>> >  /*
>> >   * Print like fprintf().
>> >   * Print to @stream if non-null, else to current monitor.
>> > + * Beware: the latter fails unless we have one and it is HMP.
>> >   */
>> >  int qemu_fprintf(FILE *stream, const char *fmt, ...)
>> >  {
>> > --=20
>> > 2.52.0
>> >=20
>>=20
>> With regards,
>> Daniel
>> --=20
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>=20
>>=20
>
> With regards,
> Daniel


