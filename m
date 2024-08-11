Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA3BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdCmy-0000Po-Nt; Sun, 11 Aug 2024 13:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sdCmv-0000Li-U5; Sun, 11 Aug 2024 13:55:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sdCmt-00022r-N7; Sun, 11 Aug 2024 13:55:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E7E4C83D1E;
 Sun, 11 Aug 2024 20:54:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6DA61239AA;
 Sun, 11 Aug 2024 20:55:22 +0300 (MSK)
Message-ID: <fb94e606-73be-4af9-8cb3-52c661fe320e@tls.msk.ru>
Date: Sun, 11 Aug 2024 20:55:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/reqlist: allow adding overlapping requests
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com
References: <20240712140716.517911-1-f.ebner@proxmox.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240712140716.517911-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

12.07.2024 17:07, Fiona Ebner wrote:
> Allow overlapping request by removing the assert that made it
> impossible. There are only two callers:
> 
> 1. block_copy_task_create()
> 
> It already asserts the very same condition before calling
> reqlist_init_req().
> 
> 2. cbw_snapshot_read_lock()
> 
> There is no need to have read requests be non-overlapping in
> copy-before-write when used for snapshot-access. In fact, there was no
> protection against two callers of cbw_snapshot_read_lock() calling
> reqlist_init_req() with overlapping ranges and this could lead to an
> assertion failure [1].
> 
> In particular, with the reproducer script below [0], two
> cbw_co_snapshot_block_status() callers could race, with the second
> calling reqlist_init_req() before the first one finishes and removes
> its conflicting request.
> 
> [0]:
> 
>> #!/bin/bash -e
>> dd if=/dev/urandom of=/tmp/disk.raw bs=1M count=1024
>> ./qemu-img create /tmp/fleecing.raw -f raw 1G
>> (
>> ./qemu-system-x86_64 --qmp stdio \
>> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
>> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.raw \
>> <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
>> {"execute": "nbd-server-start", "arguments": {"addr": { "type": "unix", "data": { "path": "/tmp/nbd.socket" } } } }
>> {"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "snap0", "type": "nbd", "name": "exp0"}}
>> EOF
>> ) &
>> sleep 5
>> while true; do
>> ./qemu-nbd -d /dev/nbd0
>> ./qemu-nbd -c /dev/nbd0 nbd:unix:/tmp/nbd.socket:exportname=exp0 -f raw -r
>> nbdinfo --map 'nbd+unix:///exp0?socket=/tmp/nbd.socket'
>> done
> 
> [1]:
> 
>> #5  0x000071e5f0088eb2 in __GI___assert_fail (...) at ./assert/assert.c:101
>> #6  0x0000615285438017 in reqlist_init_req (...) at ../block/reqlist.c:23
>> #7  0x00006152853e2d98 in cbw_snapshot_read_lock (...) at ../block/copy-before-write.c:237
>> #8  0x00006152853e3068 in cbw_co_snapshot_block_status (...) at ../block/copy-before-write.c:304
>> #9  0x00006152853f4d22 in bdrv_co_snapshot_block_status (...) at ../block/io.c:3726
>> #10 0x000061528543a63e in snapshot_access_co_block_status (...) at ../block/snapshot-access.c:48
>> #11 0x00006152853f1a0a in bdrv_co_do_block_status (...) at ../block/io.c:2474
>> #12 0x00006152853f2016 in bdrv_co_common_block_status_above (...) at ../block/io.c:2652
>> #13 0x00006152853f22cf in bdrv_co_block_status_above (...) at ../block/io.c:2732
>> #14 0x00006152853d9a86 in blk_co_block_status_above (...) at ../block/block-backend.c:1473
>> #15 0x000061528538da6c in blockstatus_to_extents (...) at ../nbd/server.c:2374
>> #16 0x000061528538deb1 in nbd_co_send_block_status (...) at ../nbd/server.c:2481
>> #17 0x000061528538f424 in nbd_handle_request (...) at ../nbd/server.c:2978
>> #18 0x000061528538f906 in nbd_trip (...) at ../nbd/server.c:3121
>> #19 0x00006152855a7caf in coroutine_trampoline (...) at ../util/coroutine-ucontext.c:175
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Hi!

Has this been forgotten or is it not needed for 9.1?

Thanks,

/mjt

> 
> Changes in v2:
> * different approach, allowing overlapping requests for
>    copy-before-write rather than waiting for them. block-copy already
>    asserts there are no conflicts before adding a request.
> 
>   block/copy-before-write.c | 3 ++-
>   block/reqlist.c           | 2 --
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index 853e01a1eb..28f6a096cd 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -66,7 +66,8 @@ typedef struct BDRVCopyBeforeWriteState {
>   
>       /*
>        * @frozen_read_reqs: current read requests for fleecing user in bs->file
> -     * node. These areas must not be rewritten by guest.
> +     * node. These areas must not be rewritten by guest. There can be multiple
> +     * overlapping read requests.
>        */
>       BlockReqList frozen_read_reqs;
>   
> diff --git a/block/reqlist.c b/block/reqlist.c
> index 08cb57cfa4..098e807378 100644
> --- a/block/reqlist.c
> +++ b/block/reqlist.c
> @@ -20,8 +20,6 @@
>   void reqlist_init_req(BlockReqList *reqs, BlockReq *req, int64_t offset,
>                         int64_t bytes)
>   {
> -    assert(!reqlist_find_conflict(reqs, offset, bytes));
> -
>       *req = (BlockReq) {
>           .offset = offset,
>           .bytes = bytes,

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


