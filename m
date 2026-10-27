Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1E606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cZ75Blnz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLbU7-0002xM-Ho; Tue, 27 Oct 2026 03:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xLbTu-0002tT-T6; Tue, 27 Oct 2026 03:20:26 -0400
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xLbTq-0004fl-8a; Tue, 27 Oct 2026 03:20:25 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5MiLxi/fhssl8di2WPQivdrblWjmsUA7fYbFmQkX20s=;
 b=cZ75BlnzIpiHJzTmGNUbfNPbLq0UJYmAs3TgYCsAT7BOpVtpi1LHmRTYw8agpO8UPMy7khHq0
 0JFL+W/5wW40Xqm9FzkhOcj2YvDF+Dbrv3hmYSyucowH2A1LBmC5zbPDvxpqYZqlcvPXMHJegND
 cN29txbZ1oJOSSaO6x8vTuw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jDMMM1hmqzpSt7;
 Tue, 27 Oct 2026 15:19:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id D4FA54058E;
 Tue, 27 Oct 2026 15:20:09 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 15:20:09 +0800
Message-ID: <a3331da7-2e8b-44e4-bbc1-9572ab4bfdcc@huawei.com>
Date: Tue, 27 Oct 2026 15:20:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/37] qapi: Add MPAM cache introspection schema and stub
To: Markus Armbruster <armbru@redhat.com>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_E9186FE529AD6EC21F51EF364CEA6426EF05@qq.com>
 <87fqxs1uj6.fsf@pond.sub.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87fqxs1uj6.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.218;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout03.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/26 21:05, Markus Armbruster 写道:
> Jinjie Ruan <2118537295@qq.com> writes:
> 
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Add the query-mpam-cache QMP command schema: the MpamBm bitmap
>> type, the per-RIS MpamRegs state and the MpamCacheInfo summary of
>> a cache MSC, plus an optional cache level filter.  The command is
>> stubbed to return NULL so the generated marshal links; the real
>> implementation walks the device tree in the next patch.
>>
>> Based on an RFC series by Jonathan Cameron, adapted to the current
>> qapi documentation rules.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]
> 
>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index a46269b..c6663e5 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -42,6 +42,7 @@ qapi_all_modules = [
>>    'machine-s390x',
>>    'migration',
>>    'misc',
>> +  'mpam',
>>    'net',
>>    'pragma',
>>    'qom',
>> diff --git a/qapi/mpam.json b/qapi/mpam.json
>> new file mode 100644
>> index 0000000..ff476a1
>> --- /dev/null
>> +++ b/qapi/mpam.json
>> @@ -0,0 +1,120 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +##
>> +# = ARM MPAM State Introspection
>> +##
> 
> Special QAPI doc markup that hasn't been recognized in more than a year.
> Please build with --enable-docs, and examine
> docs/manual/interop/qemu-qmp-ref.html to guard against such mishaps.
> 
> Use standard reST markup instead:

Hi Markus,

Will fix it in v2 and build with --enable-docs.

> 
>    ##
>    # ****************************
>    # ARM MPAM State Introspection
>    # ****************************
>    ##
> 
> Are you *sure* this ought to be between "Miscellanea" and "Audio" and at
> the same heading level?  Or should it be deeper and/or elsewhere?

Yes, it should be placed in arm64 related chapter.

> 
>> +
>> +##
>> +# @MpamBm:
>> +#
>> +# A bitmap control value, as used by MPAM cache-portion (CPBM) and
>> +# memory-bandwidth-portion (MBW_PBM) controls.  The value is
>> +# carried as an array of 32-bit words, least significant first.
>> +#
> 
> Anti-pattern: the introduction (above) discusses the value of a member
> (below).
> 
>> +# @words: The bitmap, one element per 32-bits of the control
>> +#
>> +# Since: 10.1
> 
> 11.2 now.  Same elsewhere, not noting it again.

Will update it.

> 
>> +##
>> +{ 'struct': 'MpamBm',
>> +  'data' : { 'words' : [ 'int' ]
> 
> The description says it's 32 bit words.  Shouldn't you use 'uint32'
> then?
> 
>> +           }
>> +}
>> +
>> +##
>> +# @MpamRegs:
>> +#
>> +# Per RIS register state of an emulated MPAM Memory System Component.
> 
> Please use the current syntax for introductions:

Ok, will update it.

> 
>    ##
>    # @name: introduction, best to keep it brief, but you may continue it
>    #     like this if necessary.  If your text need to refer to
>    #     arguments, it's almost certainly not brief introduction
>    #     anymore.
> 
> Same elsewhere, not noting it again.

Ok, will update all the same comment.

> 
>> +#
>> +# @idr: MPAMF_IDR, the MPAM features identification register
>> +#
>> +# @iidr: MPAMF_IIDR, the MPAM implementer identification register
>> +#
>> +# @aidr: MPAMF_AIDR, the MPAM architecture identification register
>> +#
>> +# @cpor-idr: MPAMF_CPOR_IDR, cache-portion feature register
>> +#
>> +# @ccap-idr: MPAMF_CCAP_IDR, cache-capacity feature register
>> +#
>> +# @mbw-idr: MPAMF_MBW_IDR, memory-bandwidth feature register
>> +#
>> +# @pri-idr: MPAMF_PRI_IDR, priority feature register
>> +#
>> +# @partid-nrw-idr: MPAMF_PARTID_NRW_IDR, PARTID narrowing register
>> +#
>> +# @msmon-idr: MPAMF_MSMON_IDR, monitor feature register
>> +#
>> +# @csumon-idr: MPAMF_CSUMON_IDR, cache-usage monitor register
>> +#
>> +# @mbwumon-idr: MPAMF_MBWUMON_IDR, memory-bandwidth monitor register
>> +#
>> +# @ecr: MPAMF_ECR, the error control register
>> +#
>> +# @esr: MPAMF_ESR, the error status register
>> +#
>> +# @cfg-part-sel: MPAMCFG_PART_SEL, the partition-selection register
>> +#
>> +# @cfg-cpbm: The configured cache-portion bitmaps, one per
>> +#     internal PARTID
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct' : 'MpamRegs',
>> +  'data' : { 'idr' : 'int',
>> +             'iidr' : 'int',
>> +             'aidr' : 'int',
>> +             'cpor-idr': 'int',
>> +             'ccap-idr': 'int',
>> +             'mbw-idr': 'int',
>> +             'pri-idr': 'int',
>> +             'partid-nrw-idr': 'int',
>> +             'msmon-idr': 'int',
>> +             'csumon-idr': 'int',
>> +             'mbwumon-idr': 'int',
>> +             'ecr': 'int',
>> +             'esr': 'int',
>> +             'cfg-part-sel': 'int',
>> +             'cfg-cpbm': ['MpamBm']#lazy
> 
> Is the comment an accident?
> 
> How wide are these registers?  Is 'int' the appropriate type?
> 
>> +          }
>> +}
>> +
>> +##
>> +# @MpamCacheInfo:
>> +#
>> +# Information about an MPAM cache Memory System Component.
>> +#
>> +# @cpu: First CPU of the set associated with the cache
>> +#
>> +# @level: Level of cache
>> +#
>> +# @type: Type of cache
>> +#
>> +# @regs: The per RIS register state
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'MpamCacheInfo',
>> +  'data' : { 'cpu' : 'int',
>> +             'level' : 'int',
>> +             'type' : 'int',
>> +             'regs' : ['MpamRegs']
>> +           }
>> +}
>> +
>> +##
>> +# @query-mpam-cache:
>> +#
>> +# Get a list of MpamCacheInfo for all Cache related MSC
>> +#
>> +# @level: Provide a cache level to filter against
> 
> What exactly does this argument filter out?
> 
> Is it really needed?  How large can unfiltered output become?
> 
>> +#
>> +# Returns: a list of @MpamCacheInfo describing all
>> +#   the MPAM cache MSC instances
> 
> This gets rendered like
> 
>     Return: [MpamCacheInfo] – a list of MpamCacheInfo describing all the
>             MPAM cache MSC instances
> 
> As is, the description is mostly redundant.  Do you need a description?
> Try building without it, and see how it comes out.
> 
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'command': 'query-mpam-cache',
>> +  'data': { '*level': 'int' },
>> +  'returns' : ['MpamCacheInfo'],
>> +  'allow-preconfig': true }
>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>> index b93dd68..cef175d 100644
>> --- a/qapi/qapi-schema.json
>> +++ b/qapi/qapi-schema.json
>> @@ -64,6 +64,7 @@
>>  { 'include': 'replay.json' }
>>  { 'include': 'yank.json' }
>>  { 'include': 'misc.json' }
>> +{ 'include': 'mpam.json' }
>>  { 'include': 'misc-arm.json' }
>>  { 'include': 'misc-i386.json' }
>>  { 'include': 'audio.json' }
> 

-- 
Best regards,
Jinjie


