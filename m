Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC648CA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 10:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skhmC-0002hV-La; Sun, 01 Sep 2024 06:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1skhm9-0002dn-A4; Sun, 01 Sep 2024 06:25:41 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1skhm7-0000r9-CX; Sun, 01 Sep 2024 06:25:40 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D242520057.AA565
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:144:242:ac11:2e])
 by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id D242520057;
 Sun,  1 Sep 2024 12:25:27 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:da25:11b6:eb0b:9b9d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id B08C3D4F7A333; 
 Sun,  1 Sep 2024 12:25:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by flutterbat.volkihar.be (Postfix) with ESMTP id 6C62B1AB112;
 Sun, 01 Sep 2024 12:25:27 +0200 (CEST)
Message-ID: <9e85f24f-c9ce-4495-8731-66226249b2d3@volkihar.be>
Date: Sun, 1 Sep 2024 12:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] block: allow commit to unmap zero blocks
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
 <20240713215644.742244-4-libvirt-e6954efa@volkihar.be>
 <9a4ad6af-d222-4d7a-9446-2ea090954731@yandex-team.ru>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Content-Language: nl, en-GB
In-Reply-To: <9a4ad6af-d222-4d7a-9446-2ea090954731@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:132;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-1.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/08/2024 12:58, Vladimir Sementsov-Ogievskiy wrote:
> On 14.07.24 00:56, Vincent Vanlaer wrote:
>> Non-active block commits do not discard blocks only containing zeros,
>> causing images to lose sparseness after the commit. This commit fixes
>> that by writing zero blocks using blk_co_pwrite_zeroes rather than
>> writing them out as any other arbitrary data.
>>
>> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
>> ---
>>   block/commit.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index fb54fc9560..6ce30927ac 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -130,6 +130,7 @@ static void commit_clean(Job *job)
>>     typedef enum CommitMethod {
>>       COMMIT_METHOD_COPY,
>> +    COMMIT_METHOD_ZERO,
>>       COMMIT_METHOD_IGNORE,
>>   } CommitMethod;
>>   @@ -185,6 +186,18 @@ static int coroutine_fn commit_run(Job *job, 
>> Error **errp)
>>           if (ret >= 0) {
>>               if (!(ret & BDRV_BLOCK_ALLOCATED)) {
>>                   commit_method = COMMIT_METHOD_IGNORE;
>> +            } else if (ret & BDRV_BLOCK_ZERO) {
>> +                int64_t target_offset;
>> +                int64_t target_bytes;
>> +                WITH_GRAPH_RDLOCK_GUARD() {
>> +                    bdrv_round_to_subclusters(s->base_bs, offset, n,
>> +                                           &target_offset, 
>> &target_bytes);
>
> indentation broken
>
>> +                }
>> +
>> +                if (target_offset == offset &&
>> +                    target_bytes == n) {
>> +                    commit_method = COMMIT_METHOD_ZERO;
>
> Why this is needed? Could we blindly do write-zeroes at original 
> (offset, n)? Underlying logic would use any possiblity to write zeroes 
> effectively, and unaligned tails (if any) would be written as data.
>
This originates from the mirroring code. I did some testing and it 
indeed is not necessary in this case. Letting it the underlying code 
handle it also simplifies this code quite a bit.

>> +                }
>>               }
>>                 switch (commit_method) {
>> @@ -198,6 +211,11 @@ static int coroutine_fn commit_run(Job *job, 
>> Error **errp)
>>                       }
>>                   }
>>                   break;
>> +            case COMMIT_METHOD_ZERO:
>> +                ret = blk_co_pwrite_zeroes(s->base, offset, n,
>> +                    BDRV_REQ_MAY_UNMAP);
>> +                error_in_source = false;
>> +                break;
>>               case COMMIT_METHOD_IGNORE:
>>                   break;
>>               default:
>> @@ -216,6 +234,7 @@ static int coroutine_fn commit_run(Job *job, 
>> Error **errp)
>>                   continue;
>>               }
>>           }
>> +
>
> extra unrelated hunk for style, I'd drop it
>
>>           /* Publish progress */
>>           job_progress_update(&s->common.job, n);
>


