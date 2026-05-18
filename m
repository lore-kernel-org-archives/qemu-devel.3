Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D91CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 06:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOreQ-0006fF-QA; Mon, 18 May 2026 02:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOreN-0006ef-Qo
 for qemu-devel@nongnu.org; Mon, 18 May 2026 02:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOre4-0003V4-82
 for qemu-devel@nongnu.org; Mon, 18 May 2026 02:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779086400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=PX6/XkKjK4+guhhPh0a2/jCpNtC4rep4d1Xk4WHnYwc=;
 b=TwwaHgUT+dwFs58uWBMnuCPOIqTUQoKu3L1SKNX1TlG3AjvqFrafrn0rzrvZ+q26zhxb9E
 eDdFGbZglbPQBu5tSSrULdsUme6Q3s6Yg5g7ykbN+TRtCS/PBLWryM5GXQSIRjOMSCMAV/
 F6IZCmBW5q3zKw4truQBufUYmf861co=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-kl7otoTOMRWPC5qRd54lfA-1; Mon,
 18 May 2026 02:39:56 -0400
X-MC-Unique: kl7otoTOMRWPC5qRd54lfA-1
X-Mimecast-MFC-AGG-ID: kl7otoTOMRWPC5qRd54lfA_1779086395
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 296711956096; Mon, 18 May 2026 06:39:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8FB518004A3; Mon, 18 May 2026 06:39:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 547D321E6A01; Mon, 18 May 2026 08:39:52 +0200 (CEST)
Resent-To: Emily.Deng@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com,
 Victor.Zhao@amd.com, guoqing.zhang@amd.com, lizhijian@fujitsu.com,
 qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 18 May 2026 08:39:52 +0200
Resent-Message-ID: <87v7clxltz.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "berrange@redhat.com" <berrange@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,  "farosas@suse.de"
 <farosas@suse.de>,  "eblake@redhat.com" <eblake@redhat.com>,
 "Emily.Deng@amd.com" <Emily.Deng@amd.com>,  "Victor.Zhao@amd.com"
 <Victor.Zhao@amd.com>,  "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>,
 "Qing.Ma@amd.com" <Qing.Ma@amd.com>
Subject: Re: [PATCH] migration/rdma: change default rdma chunk size to 64MiB
In-Reply-To: <eadfa566-9f75-408b-971f-986315b49476@fujitsu.com> (Zhijian Li's
 message of "Mon, 18 May 2026 02:17:58 +0000")
References: <20260514031848.2422203-1-guoqing.zhang@amd.com>
 <eadfa566-9f75-408b-971f-986315b49476@fujitsu.com>
Date: Mon, 18 May 2026 06:33:04 +0200
Message-ID: <87wlx1jq0v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> Samuel,
>
>
> Thanks for the patch.
>
> On 14/05/2026 11:18, Samuel Zhang wrote:
>> The 1MiB default dates back to the original RDMA implementation in
>> 2013 (commit 2da776db48), and is too conservative for modern hardware.
>> 
>> 64MiB captures most of the throughput gain (~10x over 1MiB) while
>> keeping transferred data low.  Larger chunks cause more data to be
>> retransferred per dirty page, so the largest chunk size is not
>> necessarily optimal (see 1024MiB row).  The x-rdma-chunk-size
>> parameter remains available for user tuning.
>> 
>> Test config: BlueField-3 ConnectX-7, 8GB VM RAM, pin-all off,
>>    `stress-ng --vm 4 --vm-bytes 1G --vm-method rand-set`
>> 
>> chunk_size  total(ms)  down(ms)  Throughput(Mbps)  transferred
>> 1m            45,156    1,166          1,252.50     6.46 GiB
>> 32m           15,034    1,864          3,401.26     5.57 GiB
>> 64m            4,492    1,554         13,637.46     5.75 GiB
>> 128m           3,940    1,662         16,860.59     6.06 GiB
>> 1024m          3,665    2,238         24,676.59     8.04 GiB
>> 
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>  migration/options.c | 2 +-
>>  qapi/migration.json | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 5cbfd29099..ea2137372c 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -91,7 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>>   
>>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>> -#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB
>> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (64 * MiB)
>
>
> I have a concern about backward compatibility.

@x-rdma-chunk-size is marked unstable, thus doesn't come with
compatibility promises.

Does unstable still make sense?

> AFAIK, changing the default chunk size could break RDMA migration between hosts running different QEMU versions.
> If this happens, the error message is not clear enough for a user to understand that the failure
> is due to a mismatch in 'x-rdma-chunk-size'?
>
> [1] https://lore.kernel.org/qemu-devel/6f1df732-5c2c-4f1b-a59a-aa6af5566505@fujitsu.com/
>
> Thanks
> Zhijian


