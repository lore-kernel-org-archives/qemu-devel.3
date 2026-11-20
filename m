Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DA606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=Jq+6T1rs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM3H-0003a4-QX; Fri, 20 Nov 2026 05:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xUM3E-0003Zk-15
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:41:04 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xUM3C-0004RO-3i
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:41:03 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.54.196])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jWBhB1WVCz3wlV;
 Fri, 20 Nov 2026 10:40:58 +0000 (UTC)
Received: from [10.46.51.33] (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:40:57 +0100
Message-ID: <19df3dc3-86f9-4906-8434-a219c4320617@ovhcloud.com>
Date: Fri, 20 Nov 2026 11:40:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: Refresh the connection before block_resize
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
 <vsementsov@yandex-team.ru>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <stefanha@redhat.com>, <fam@euphon.net>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-3-guillaume.vincke@ovhcloud.com>
 <av91249yWhnS7Gri@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <av91249yWhnS7Gri@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 2574370138132922845
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGqV0SKyGRC6rpW8XZ5ZEgTKDMXK4MNFSdlqX5j44A+0op0a/+9GTtAT0tc8oKcC7jnDaq20tIfoZcN+WSoJEvao2T6R9Y2nQdQDrE1VHbn3ozLiPnXvUc1Rd68FnlaD4ctpxDC2RbAur5WVR4b1kfAVtsrDpDVtcNZsW6/ey1AAtrgDNRnqz2J+3velvEcLeZlKT0ox58xJeEDogU9vyZyLkz2etfFOQUiXp/4Tv2pt7ox0+Zvon5uCx1E3X87xcg7ewz2lBvuHd2FdNTJthHfSWS2mvEA2kcdKjIyZI1Sr3BZFYJvLwf6TVDbT1G2LSUk4nHZTWY8cS1zLJRA8798nzGCIVBSoKpVZ88YhNAA/NUR5MJpuXWtPFGDF194hUNu/i49i6o92jDH8p/8zYG11m1dnLL92JaWUkJKbCq7SlLhFdJ43YtzKeKvTzBXF53X1HEMAiO3owsewGm0CD84kDyVKIqJS0PX3hMoCTZB+0Vi2BTEsYhdqju9nayqQ3sZ7bGiCoV2FOqqFs40HPuVpi13L6as8P863jC4+h79+EzeGjq4AuVGoJ4RgwIjhv8A7M7thjqGSeb9Bv+JnR6Y+KUFqyz4e24XNmrSnqvIcqNxe/ydQlF7sIJhHe8DN60NPYeC6Ul5LqfhfmWaNdIwW5G4DBoobuTQxgBdVeRKUA
DKIM-Signature: a=rsa-sha256; bh=2KcGEPYj6UD86MM5P5ZAjXDMny0ZHt854EK/pgwYsPE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795171259; v=1; 
 b=Jq+6T1rs9nUCKCqx3N7I3RQUxRbfcz5roLD4JGTdU42Up3BjxFXykbAMFglnLACE+MRnhUHe
 V47TAFE+hywNKu/Inxl/LSewhVpcCUxDixTwzpBDs4RItwbLWosof8rj3eCMhzm7luVEByT0YEf
 Gz6gU339BNQagRcWYW6hQh8s=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 23:32, Eric Blake wrote:
>> +++ b/blockdev.c
>> @@ -2314,6 +2314,7 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
>>       BlockBackend *blk;
>>       BlockDriverState *bs;
>>       AioContext *old_ctx;
>> +    int ret;
>>   
>>       bs = bdrv_lookup_bs(device, node_name, &local_err);
>>       if (local_err) {
>> @@ -2338,6 +2339,14 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
>>           return;
>>       }
>>   
>> +    old_ctx = bdrv_co_enter(bs);
>> +    ret = blk_co_refresh_connection(blk, errp);
>> +    bdrv_co_leave(bs, old_ctx);
>> +    if (ret < 0) {
>> +        blk_co_unref(blk);
>> +        return;
>> +    }
>> +
>>       bdrv_drained_begin(bs);
>>   
>>       old_ctx = bdrv_co_enter(bs);
> 
> Am I missing a reason for why you add a separate bdrv_co_enter/leave
> critical section prior the bdrv_drained_begin, rather than reusing the
> critical section already present during the drained region?  Is it
> because you want to ensure the (re-)connection is in place before the
> drain can trigger IO traffic?
> 

There is no other reason than believing that this option is more
readable and that a purely additive diff is easier to review.  After
running the tests, I believe moving it into the same section is a valid
solution.  Will change this in v2.


