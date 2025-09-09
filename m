Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9167CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzFT-0004vv-2p; Tue, 09 Sep 2025 10:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uvzFP-0004uO-QU
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1uvzFL-00018M-B2
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757427772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZOb+p4tUw29SwrY1OqmW5iHJzlFWWKI3/kek90oSN8I=;
 b=Fd6565GmhMMovyamMKTJ1NOIwX6lFmysh91888yvL26K+bmCC1YfXCluElHqaG2QalneC3
 hbZtSBT8ScMd4AQlow6Oi3RrMfcq+9neBsFoaIoglGKXcrW+pRv4/8DbXVutV9ev1RQLVK
 rqG3iSEHXE1I9DADaDKhTHKr2B2R/Ug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-T3GgY5YYMfqAlFQwD012fQ-1; Tue,
 09 Sep 2025 10:22:49 -0400
X-MC-Unique: T3GgY5YYMfqAlFQwD012fQ-1
X-Mimecast-MFC-AGG-ID: T3GgY5YYMfqAlFQwD012fQ_1757427768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB8F180034C; Tue,  9 Sep 2025 14:21:06 +0000 (UTC)
Received: from fedora (unknown [10.44.33.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC15E1956095; Tue,  9 Sep 2025 14:21:01 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:20:55 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Message-ID: <aMA3x0V_AHrlwP2o@fedora>
References: <20250905142006.2230345-1-vsementsov@yandex-team.ru>
 <aL7tdmmT0ZEVZ1qb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJjZRSDyTa0+B+I3"
Content-Disposition: inline
In-Reply-To: <aL7tdmmT0ZEVZ1qb@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--fJjZRSDyTa0+B+I3
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Monday in 2025, Daniel P. Berrang=E9 wrote:
>On Fri, Sep 05, 2025 at 05:20:06PM +0300, Vladimir Sementsov-Ogievskiy wro=
te:
>> QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
>> qemu_hexdump_line(). This leads to last line of the dump (when
>> length is not multiply of 16) has badly aligned ASCII part.
>>
>> Let's calculate length the same way.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>  util/hexdump.c | 38 ++++++++++++++++++++++++--------------
>>  1 file changed, 24 insertions(+), 14 deletions(-)
>
>Would you mind also adding a test to tests/unit/test-cutils.c
>to show the correctness, as this is a nice standalone func
>we ought to be unit testing.
>
>>
>> diff --git a/util/hexdump.c b/util/hexdump.c
>> index f29ffceb74..7cfc547261 100644
>> --- a/util/hexdump.c
>> +++ b/util/hexdump.c
>> @@ -30,14 +43,8 @@ GString *qemu_hexdump_line(GString *str, const void *=
vbuf, size_t len,
>>
>>      if (str =3D=3D NULL) {
>>          /* Estimate the length of the output to avoid reallocs. */
>> -        size_t est =3D len * 2;
>> -        if (unit_len) {
>> -            est +=3D len / unit_len;
>> -        }
>> -        if (block_len) {
>> -            est +=3D len / block_len;
>> -        }
>> -        str =3D g_string_sized_new(est + 1);
>> +        str =3D g_string_sized_new(hexdump_line_length(len, unit_len, b=
lock_len)
>> +                                 + 1);

Fun fact: with new enough glib, this will allocate a buffer of 128 bytes (n=
earest
power of 64+1) anyway:
https://gitlab.gnome.org/GNOME/glib/-/commit/7fc7c57b6fd470bbee267471a61c71=
4f3a0d281c

Jano

>>      }
>>
>>      for (u =3D 0, b =3D 0; len; u++, b++, len--, buf++) {

--fJjZRSDyTa0+B+I3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaMA3vAAKCRAU0rOr/y4P
vPFiAQDqlyTY4j8k6NX5azV4Hc29EbJ6BI1kM79KyhPwV0xwtAEAwr0iy9SSlF6D
7qTqCUKhijdzBobTSb/5qThkuBjaFwI=
=2aq0
-----END PGP SIGNATURE-----

--fJjZRSDyTa0+B+I3--


