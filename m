Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD3EC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 06:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXyES-0006pZ-2x; Thu, 08 Feb 2024 01:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyEQ-0006p9-R5
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyEO-0006sZ-H1
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707374994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UV1r7Rn0aUKw+aJZrRa5CPVYD+darbNK9L9WZLMBMeg=;
 b=OXs9LMkklqlsGd7Q8Z/oKbYhLkHbkV7gwdVdpKFA6ySZYB/1jpd5VJOlhIQU1UyRz4OQl+
 XziuFriiDQIC2tHKmSMGuOLjTvfFObFAHtBL6M7JlGirwWuWxe2SyEsFuu70Y3pcjHwMWA
 IzudklqRq+hR+zZOpm4y4bZqA4xJngM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-E5-eGU_7PQqTAMr-gk6SjQ-1; Thu,
 08 Feb 2024 01:49:50 -0500
X-MC-Unique: E5-eGU_7PQqTAMr-gk6SjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E8943C0C487;
 Thu,  8 Feb 2024 06:49:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C7C1121313;
 Thu,  8 Feb 2024 06:49:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62F0821E6767; Thu,  8 Feb 2024 07:49:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com,  eblake@redhat.com,
 eduardo@habkost.net,  fan.ni@samsung.com,  farosas@suse.de,
 hreitz@redhat.com,  jasowang@redhat.com,  jiri@resnulli.us,
 jonathan.cameron@huawei.com,  kkostiuk@redhat.com,  kraxel@redhat.com,
 kwolf@redhat.com,  lukasstraub2@web.de,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  michael.roth@amd.com,  mst@redhat.com,
 pbonzini@redhat.com,  peter.maydell@linaro.org,  peterx@redhat.com,
 philmd@linaro.org,  pizhenwei@bytedance.com,  qemu-block@nongnu.org,
 stefanb@linux.ibm.com,  wangyanan55@huawei.com
Subject: Re: [PATCH 09/15] qga/qapi-schema: Plug trivial documentation holes
In-Reply-To: <ZcNArSxXqMIVNPNk@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 7 Feb 2024 08:34:53 +0000")
References: <20240205074709.3613229-1-armbru@redhat.com>
 <20240205074709.3613229-10-armbru@redhat.com>
 <ZcNArSxXqMIVNPNk@redhat.com>
Date: Thu, 08 Feb 2024 07:49:47 +0100
Message-ID: <87a5objvqs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Feb 05, 2024 at 08:47:03AM +0100, Markus Armbruster wrote:
>> Add missing return member documentation of guest-get-disks,
>> guest-get-devices, guest-get-diskstats, and guest-get-cpustats.
>>=20
>> The NVMe SMART information returned by guest-getdisks remains
>> undocumented.  Add a TODO there.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qga/qapi-schema.json | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>> @@ -978,7 +974,7 @@
>>  #
>>  # Disk type related smart information.
>>  #
>> -# - @nvme: NVMe disk smart
>> +# @type: disk bus type
>>  #
>>  # Since: 7.1
>>  ##
>
> Fun, so not only were the fields that exist not documented,
> but we've documented fields which don't exist.

I think the @nvme line tried to document the branch.  Not useful; the
doc generator takes care of that:

    GuestDiskSmart (Object)
    -----------------------

    Disk type related smart information.

    * nvme: NVMe disk smart

    Members
    ~~~~~~~

    "type": "GuestDiskBusType"
        Not documented

--> The members of "GuestNVMeSmart" when "type" is "nvme"

>> @@ -1780,7 +1784,7 @@
>>  #
>>  # Get statistics of each CPU in millisecond.
>>  #
>> -# - @linux: Linux style CPU statistics
>> +# @type: guest operating system
>>  #
>>  # Since: 7.1
>>  ##
>
> And more things which don't exist !

Likewise.


