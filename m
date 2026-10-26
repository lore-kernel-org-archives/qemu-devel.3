Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD19606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wvsy0wCy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKOq-0007dr-JP; Mon, 26 Oct 2026 09:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLKOo-0007dH-Tg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLKOm-0003eR-SB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793019959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otbfljhxfYkYBtLne0TVo7GVkIqovKYL/MGWs9iy258=;
 b=Wvsy0wCyz1lf5+GSU7QWLrHqwdAGMN+nqca/KmXLIOWMV7nYI7BanEAoQ5nX6ahxcsvsFj
 a7fFmBg7gLMthgFYp4uZpllyDgndLsxNeeATWNFPHzdt2uWC+ty1QU+p2GW2VYUkHHf/J2
 It53bD6xQoCQyFQrmupslscS0RDcLHU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-NlqMtO8JMH29cHonN0shmg-1; Mon,
 26 Oct 2026 09:05:54 -0400
X-MC-Unique: NlqMtO8JMH29cHonN0shmg-1
X-Mimecast-MFC-AGG-ID: NlqMtO8JMH29cHonN0shmg_1793019953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F005E1955BF9; Mon, 26 Oct 2026 13:05:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E450F18004D2; Mon, 26 Oct 2026 13:05:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F58521E6A04; Mon, 26 Oct 2026 14:05:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com,  eblake@redhat.com,  imammedo@redhat.com,
 michael.roth@amd.com,  mst@redhat.com,  pbonzini@redhat.com,
 peter.maydell@linaro.org,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 ruanjinjie@huawei.com
Subject: Re: [PATCH 36/37] qapi: Add MPAM cache introspection schema and stub
In-Reply-To: <tencent_E9186FE529AD6EC21F51EF364CEA6426EF05@qq.com> (Jinjie
 Ruan's message of "Fri, 16 Oct 2026 18:10:56 +0800")
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_E9186FE529AD6EC21F51EF364CEA6426EF05@qq.com>
Date: Mon, 26 Oct 2026 14:05:49 +0100
Message-ID: <87fqxs1uj6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jinjie Ruan <2118537295@qq.com> writes:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Add the query-mpam-cache QMP command schema: the MpamBm bitmap
> type, the per-RIS MpamRegs state and the MpamCacheInfo summary of
> a cache MSC, plus an optional cache level filter.  The command is
> stubbed to return NULL so the generated marshal links; the real
> implementation walks the device tree in the next patch.
>
> Based on an RFC series by Jonathan Cameron, adapted to the current
> qapi documentation rules.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

[...]

> diff --git a/qapi/meson.build b/qapi/meson.build
> index a46269b..c6663e5 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -42,6 +42,7 @@ qapi_all_modules =3D [
>    'machine-s390x',
>    'migration',
>    'misc',
> +  'mpam',
>    'net',
>    'pragma',
>    'qom',
> diff --git a/qapi/mpam.json b/qapi/mpam.json
> new file mode 100644
> index 0000000..ff476a1
> --- /dev/null
> +++ b/qapi/mpam.json
> @@ -0,0 +1,120 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# =3D ARM MPAM State Introspection
> +##

Special QAPI doc markup that hasn't been recognized in more than a year.
Please build with --enable-docs, and examine
docs/manual/interop/qemu-qmp-ref.html to guard against such mishaps.

Use standard reST markup instead:

   ##
   # ****************************
   # ARM MPAM State Introspection
   # ****************************
   ##

Are you *sure* this ought to be between "Miscellanea" and "Audio" and at
the same heading level?  Or should it be deeper and/or elsewhere?

> +
> +##
> +# @MpamBm:
> +#
> +# A bitmap control value, as used by MPAM cache-portion (CPBM) and
> +# memory-bandwidth-portion (MBW_PBM) controls.  The value is
> +# carried as an array of 32-bit words, least significant first.
> +#

Anti-pattern: the introduction (above) discusses the value of a member
(below).

> +# @words: The bitmap, one element per 32-bits of the control
> +#
> +# Since: 10.1

11.2 now.  Same elsewhere, not noting it again.

> +##
> +{ 'struct': 'MpamBm',
> +  'data' : { 'words' : [ 'int' ]

The description says it's 32 bit words.  Shouldn't you use 'uint32'
then?

> +           }
> +}
> +
> +##
> +# @MpamRegs:
> +#
> +# Per RIS register state of an emulated MPAM Memory System Component.

Please use the current syntax for introductions:

   ##
   # @name: introduction, best to keep it brief, but you may continue it
   #     like this if necessary.  If your text need to refer to
   #     arguments, it's almost certainly not brief introduction
   #     anymore.

Same elsewhere, not noting it again.

> +#
> +# @idr: MPAMF_IDR, the MPAM features identification register
> +#
> +# @iidr: MPAMF_IIDR, the MPAM implementer identification register
> +#
> +# @aidr: MPAMF_AIDR, the MPAM architecture identification register
> +#
> +# @cpor-idr: MPAMF_CPOR_IDR, cache-portion feature register
> +#
> +# @ccap-idr: MPAMF_CCAP_IDR, cache-capacity feature register
> +#
> +# @mbw-idr: MPAMF_MBW_IDR, memory-bandwidth feature register
> +#
> +# @pri-idr: MPAMF_PRI_IDR, priority feature register
> +#
> +# @partid-nrw-idr: MPAMF_PARTID_NRW_IDR, PARTID narrowing register
> +#
> +# @msmon-idr: MPAMF_MSMON_IDR, monitor feature register
> +#
> +# @csumon-idr: MPAMF_CSUMON_IDR, cache-usage monitor register
> +#
> +# @mbwumon-idr: MPAMF_MBWUMON_IDR, memory-bandwidth monitor register
> +#
> +# @ecr: MPAMF_ECR, the error control register
> +#
> +# @esr: MPAMF_ESR, the error status register
> +#
> +# @cfg-part-sel: MPAMCFG_PART_SEL, the partition-selection register
> +#
> +# @cfg-cpbm: The configured cache-portion bitmaps, one per
> +#     internal PARTID
> +#
> +# Since: 10.1
> +##
> +{ 'struct' : 'MpamRegs',
> +  'data' : { 'idr' : 'int',
> +             'iidr' : 'int',
> +             'aidr' : 'int',
> +             'cpor-idr': 'int',
> +             'ccap-idr': 'int',
> +             'mbw-idr': 'int',
> +             'pri-idr': 'int',
> +             'partid-nrw-idr': 'int',
> +             'msmon-idr': 'int',
> +             'csumon-idr': 'int',
> +             'mbwumon-idr': 'int',
> +             'ecr': 'int',
> +             'esr': 'int',
> +             'cfg-part-sel': 'int',
> +             'cfg-cpbm': ['MpamBm']#lazy

Is the comment an accident?

How wide are these registers?  Is 'int' the appropriate type?

> +          }
> +}
> +
> +##
> +# @MpamCacheInfo:
> +#
> +# Information about an MPAM cache Memory System Component.
> +#
> +# @cpu: First CPU of the set associated with the cache
> +#
> +# @level: Level of cache
> +#
> +# @type: Type of cache
> +#
> +# @regs: The per RIS register state
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'MpamCacheInfo',
> +  'data' : { 'cpu' : 'int',
> +             'level' : 'int',
> +             'type' : 'int',
> +             'regs' : ['MpamRegs']
> +           }
> +}
> +
> +##
> +# @query-mpam-cache:
> +#
> +# Get a list of MpamCacheInfo for all Cache related MSC
> +#
> +# @level: Provide a cache level to filter against

What exactly does this argument filter out?

Is it really needed?  How large can unfiltered output become?

> +#
> +# Returns: a list of @MpamCacheInfo describing all
> +#   the MPAM cache MSC instances

This gets rendered like

    Return: [MpamCacheInfo] =E2=80=93 a list of MpamCacheInfo describing al=
l the
            MPAM cache MSC instances

As is, the description is mostly redundant.  Do you need a description?
Try building without it, and see how it comes out.

> +#
> +# Since: 10.1
> +##
> +{ 'command': 'query-mpam-cache',
> +  'data': { '*level': 'int' },
> +  'returns' : ['MpamCacheInfo'],
> +  'allow-preconfig': true }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b93dd68..cef175d 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -64,6 +64,7 @@
>  { 'include': 'replay.json' }
>  { 'include': 'yank.json' }
>  { 'include': 'misc.json' }
> +{ 'include': 'mpam.json' }
>  { 'include': 'misc-arm.json' }
>  { 'include': 'misc-i386.json' }
>  { 'include': 'audio.json' }


