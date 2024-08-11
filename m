Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96436C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 08:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd3Xb-0001ss-47; Sun, 11 Aug 2024 04:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sd3XY-0001p1-32; Sun, 11 Aug 2024 04:03:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sd3XV-0001iH-E6; Sun, 11 Aug 2024 04:02:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C543383CA1;
 Sun, 11 Aug 2024 11:02:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D510F123755;
 Sun, 11 Aug 2024 11:02:52 +0300 (MSK)
Message-ID: <27a348fb-830d-47ec-b2db-0c354711f6f6@tls.msk.ru>
Date: Sun, 11 Aug 2024 11:02:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 5/5] nbd/server: CVE-2024-7409: Close stray clients at
 server-stop
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20240808215529.1065336-7-eblake@redhat.com>
 <20240808215529.1065336-12-eblake@redhat.com>
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
In-Reply-To: <20240808215529.1065336-12-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

09.08.2024 00:53, Eric Blake wrote:
> A malicious client can attempt to connect to an NBD server, and then
> intentionally delay progress in the handshake, including if it does
> not know the TLS secrets.  Although the previous two patches reduce
> this behavior by capping the default max-connections parameter and
> killing slow clients, they did not eliminate the possibility of a
> client waiting to close the socket until after the QMP nbd-server-stop
> command is executed, at which point qemu would SEGV when trying to
> dereference the NULL nbd_server global which is no longer present.
> This amounts to a denial of service attack.  Worse, if another NBD
> server is started before the malicious client disconnects, I cannot
> rule out additional adverse effects when the old client interferes
> with the connection count of the new server (although the most likely
> is a crash due to an assertion failure when checking
> nbd_server->connections > 0).
> 
> For environments without this patch, the CVE can be mitigated by
> ensuring (such as via a firewall) that only trusted clients can
> connect to an NBD server.  Note that using frameworks like libvirt
> that ensure that TLS is used and that nbd-server-stop is not executed
> while any trusted clients are still connected will only help if there
> is also no possibility for an untrusted client to open a connection
> but then stall on the NBD handshake.
> 
> Given the previous patches, it would be possible to guarantee that no
> clients remain connected by having nbd-server-stop sleep for longer
> than the default handshake deadline before finally freeing the global
> nbd_server object, but that could make QMP non-responsive for a long
> time.  So intead, this patch fixes the problem by tracking all client
> sockets opened while the server is running, and forcefully closing any
> such sockets remaining without a completed handshake at the time of
> nbd-server-stop, then waiting until the coroutines servicing those
> sockets notice the state change.  nbd-server-stop now has a second
> AIO_WAIT_WHILE_UNLOCKED (the first is indirectly through the
> blk_exp_close_all_type() that disconnects all clients that completed
> handshakes), but forced socket shutdown is enough to progress the
> coroutines and quickly tear down all clients before the server is
> freed, thus finally fixing the CVE.
> 
> This patch relies heavily on the fact that nbd/server.c guarantees
> that it only calls nbd_blockdev_client_closed() from the main loop
> (see the assertion in nbd_client_put() and the hoops used in
> nbd_client_put_nonzero() to achieve that); if we did not have that
> guarantee, we would also need a mutex protecting our accesses of the
> list of connections to survive re-entrancy from independent iothreads.
> 
> Although I did not actually try to test old builds, it looks like this
> problem has existed since at least commit 862172f45c (v2.12.0, 2017) -
> even back when that patch started using a QIONetListener to handle
> listening on multiple sockets, nbd_server_free() was already unaware
> that the nbd_blockdev_client_closed callback can be reached later by a
> client thread that has not completed handshakes (and therefore the
> client's socket never got added to the list closed in
> nbd_export_close_all), despite that patch intentionally tearing down
> the QIONetListener to prevent new clients.

Eric, from the 5-patch series, only this last patch is Cc'd for stable,
but it obviously does not work without all 4 previous patches.  Do you
mean whole series should be applied to -stable?

I picked up patches 2-5 for 7.2 and 9.0.

Thanks,

/mjt

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


