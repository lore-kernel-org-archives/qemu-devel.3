Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3246FF532E9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4w2w-000496-HS; Tue, 24 Mar 2026 03:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4w2v-00048R-6G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4w2t-0000pR-Dz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774336762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFxv3J8cG6JvPrhhfD18GAVirGlb+Rk7thwN1IVNkC4=;
 b=HErkRexNVMorneF9YJ+ouDD5OOS7o/TKhsmOSs2wwr3ydvbLIbiYKCizrsIfvfmwmBd5+v
 J9aeODR75mAi2HXZnO/FupRYhTBMfwCmvjd36+hHkEfLxjlVypwvOCKdAko00NQrQFK+Qq
 KCPYz6ewspbMhtHv/5+sILgHcWyBGuA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-yDS6wyKVPsSB0nIIekF4gA-1; Tue,
 24 Mar 2026 03:19:20 -0400
X-MC-Unique: yDS6wyKVPsSB0nIIekF4gA-1
X-Mimecast-MFC-AGG-ID: yDS6wyKVPsSB0nIIekF4gA_1774336759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6849619560A1; Tue, 24 Mar 2026 07:19:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 266571800361; Tue, 24 Mar 2026 07:19:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBEEC21E6937; Tue, 24 Mar 2026 08:19:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH-for-11.0] qapi: Remove deprecated
 SchemaInfoEnumMember::values field
In-Reply-To: <acIpLpMOTCwKwDQt@angien.pipo.sk> (Peter Krempa's message of
 "Tue, 24 Mar 2026 07:03:26 +0100")
References: <20260323152124.93051-1-philmd@linaro.org>
 <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
 <acIpLpMOTCwKwDQt@angien.pipo.sk>
Date: Tue, 24 Mar 2026 08:19:16 +0100
Message-ID: <87bjgdvgnf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Krempa <pkrempa@redhat.com> writes:

> On Mon, Mar 23, 2026 at 20:19:45 -0700, Pierrick Bouvier wrote:
>> On 3/23/26 8:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> > SchemaInfoEnumMember::values field has been deprecated for
>> > more than 5 years (see commit 75ecee72625 "qapi: Enable enum
>> > member introspection to show more than name"), it should be
>> > safe enough to remove.
>> >=20
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> > ---
>> >   docs/about/deprecated.rst       |  6 ------
>> >   docs/about/removed-features.rst |  7 +++++++
>> >   qapi/introspect.json            | 12 +-----------
>> >   scripts/qapi/introspect.py      |  3 +--
>> >   4 files changed, 9 insertions(+), 19 deletions(-)
>> >=20
>>=20
>> By curiosity, is this patch goal is simply to remove a deprecated
>> feature/code, or does it unlock something beyond it?
>> No judgment here, that's a genuine question, and both are valid reasons!
>
> This patch also shaves off a nice 1.3k lines of duplicate data from the
> prettified reply from query-qmp-schema.
>
> (In libvirt we capture dumps of the schema which we use for internal
> testing as well as validation that the monitor command handlers and
> commandline generators (by proxy) don't use deprecated and or
> non-existent members.)
>
>> Looks good to me, to the limit of my qapi knowledge :).
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> On behalf of libvirt (and since I didn't look at the code at all; just
> at the output):
>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>

Thank you, Peter!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


