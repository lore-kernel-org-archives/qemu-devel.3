Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F0EF8FFB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxogZ-0003AX-PR; Wed, 04 Mar 2026 11:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vxogY-0003A3-9Q; Wed, 04 Mar 2026 11:02:54 -0500
Received: from mailcow.dlhnet.de ([2a01:b1c0::44ca:22ff:fe9b:798c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vxogV-0007yR-Fk; Wed, 04 Mar 2026 11:02:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 043F646AE10; Wed,  4 Mar 2026 17:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlhnet.de; s=dkim;
 t=1772640163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=JaKtsmyQx9pQOhTipEWLglahq/xd7Hac/SxoCQr8mNI=;
 b=bZER21HH+E/GGalzN8JSLFj/3HJQK7TFaQy8aCft8K5OVwPCXrNJ95feFCwLgAOe9cRABs
 dwdBc00cmvvr7Jpc+ML0ydZVb9ij6h5vOalyOqhUCeHQA+4jzZQSEl2u4Rm46d+mY/Mf6c
 kveaZvIYRLxQ7AQ7dL4U7sGCCFou83PxXy1l222Nl7n2BBsTq6tmGLNPivIjP8KnH27n4r
 wGIQDf0sKCNpbYWS9l+uo9OBWK9S5WRmsLCNGHUrwzsQNYhHQfh5FD+ifcWKm1e+6pvUvE
 odpYbaWpjszPXauwJg6g3fDtCLl1n6+UKeos/kMo7NMn3qNQbMs3qsxLzgeKiA==
From: Peter Lieven <pl@dlhnet.de>
Message-Id: <84D9FDAA-1F3C-460C-9548-2018580CEE4D@dlhnet.de>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_B7583B5B-169F-41D0-8CF8-BAD7555B9990"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH_v2_04/19=5D_nfs=3A_Run_co_BH_CB_in_the_c?=
 =?utf-8?Q?oroutine=E2=80=99s_AioContext?=
Date: Wed, 4 Mar 2026 17:02:30 +0100
In-Reply-To: <EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-5-hreitz@redhat.com>
 <EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Last-TLS-Session-Version: TLSv1.2
Received-SPF: pass client-ip=2a01:b1c0::44ca:22ff:fe9b:798c;
 envelope-from=pl@dlhnet.de; helo=mailcow.dlhnet.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_B7583B5B-169F-41D0-8CF8-BAD7555B9990
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> Am 03.03.2026 um 20:24 schrieb Peter Lieven <pl@dlhnet.de>:
>=20
>=20
>=20
>> Am 10.11.2025 um 16:48 schrieb Hanna Czenczek <hreitz@redhat.com>:
>>=20
>> Like in =E2=80=9Crbd: Run co BH CB in the coroutine=E2=80=99s =
AioContext=E2=80=9D, drop the
>> completion flag, yield exactly once, and run the BH in the =
coroutine=E2=80=99s
>> AioContext.
>>=20
>> (Can be reproduced with multiqueue by adding a usleep(100000) before =
the
>> `while (!task.complete)` loops.)
>>=20
>> Like in =E2=80=9Ciscsi: Run co BH CB in the coroutine=E2=80=99s =
AioContext=E2=80=9D, this makes
>> nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
>> calling aio_co_wake() directly.
>>=20
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>> block/nfs.c | 41 ++++++++++++++++-------------------------
>> 1 file changed, 16 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 0a7d38db09..1d3a34a30c 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -69,7 +69,6 @@ typedef struct NFSClient {
>> typedef struct NFSRPC {
>>     BlockDriverState *bs;
>>     int ret;
>> -    int complete;
>>     QEMUIOVector *iov;
>>     struct stat *st;
>>     Coroutine *co;
>> @@ -230,14 +229,6 @@ static void coroutine_fn =
nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
>>     };
>> }
>>=20
>> -static void nfs_co_generic_bh_cb(void *opaque)
>> -{
>> -    NFSRPC *task =3D opaque;
>> -
>> -    task->complete =3D 1;
>> -    aio_co_wake(task->co);
>> -}
>> -
>> /* Called (via nfs_service) with QemuMutex held.  */
>> static void
>> nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
>> @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context =
*nfs, void *data,
>>     if (task->ret < 0) {
>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>     }
>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>> -                                     nfs_co_generic_bh_cb, task);
>> +
>> +    /*
>> +     * Safe to call: nfs_service(), which called us, is only run =
from the FD
>> +     * handlers, never from the request coroutine.  The request =
coroutine in
>> +     * turn will yield unconditionally.
>> +     * No need to release the lock, even if we directly enter the =
coroutine, as
>> +     * the lock is never re-taken after yielding.  (Note: If we do =
enter the
>> +     * coroutine, @task will probably be dangling once aio_co_wake() =
returns.)
>> +     */
>> +    aio_co_wake(task->co);
>> }
>>=20
>> static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t =
offset,
>> @@ -278,9 +277,7 @@ static int coroutine_fn =
nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>>=20
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>=20
>>     if (task.ret < 0) {
>>         return task.ret;
>> @@ -328,9 +325,7 @@ static int coroutine_fn =
nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
>>=20
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>=20
>>     if (my_buffer) {
>>         g_free(buf);
>> @@ -358,9 +353,7 @@ static int coroutine_fn =
nfs_co_flush(BlockDriverState *bs)
>>=20
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>=20
>>     return task.ret;
>> }
>> @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct =
nfs_context *nfs, void *data,
>>     if (task->ret < 0) {
>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>     }
>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>> -                                     nfs_co_generic_bh_cb, task);
>> +    /* Safe to call, see nfs_co_generic_cb() */
>> +    aio_co_wake(task->co);
>> }
>>=20
>> static int64_t coroutine_fn =
nfs_co_get_allocated_file_size(BlockDriverState *bs)
>> @@ -748,9 +741,7 @@ static int64_t coroutine_fn =
nfs_co_get_allocated_file_size(BlockDriverState *bs)
>>=20
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>=20
>>     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>> }
>> --=20
>> 2.51.1
>>=20
>=20
> Hallo Hanna,
>=20
> it has been a long time where I was inactive in Qemu development and I =
should have checked this earlier, but it seems that this patch =
accidentally broke libnfs usage with at least qemu cmdline tools like =
qemu-img. Again, sorry for not testing this earlier, but I have only =
recently entered the Qemu show again.
>=20
> I found this glitch while working on a patch to include libnfs v6 =
support in qemu to avoid dropping libnfs support.
>=20
> A simple call like:
>=20
> qemu-img create -f qcow2 nfs://nfsserver/image.qcow2 10G
>=20
> hangs forever in the second write request.
>=20
> I have not confirmed, but this might also hold true for libiscsi which =
internally is quite identical (at least it was 3 years ago ;-))
>=20
> You are right, the coroutine can only yield once, but it seems that =
the bottom half logic is still needed.
> Maybe you have an idea why? I remember that we had this differently =
first and implemented it after Stefan pointed out that it might be =
needed.
> I will try to find the thread about this discussion.

The BH for the iscsi driver was actually introduced here:

commit 8b9dfe9098d91e06a3dd6376624307fe5fa13be8
Author: Peter Lieven <pl@kamp.de>
Date:   Sat Dec 14 17:31:40 2013 +0100

    block/iscsi: use a bh to schedule co reentrance

I am not 100% sure if the justification for this commit is still the =
same or if it was fixed by switching to aio_co_wake anyway.

I meanwhile tested libiscsi support and it seems not to hang, but it =
might still have a performance impact (maybe).

If someone has a clue I could go ahead and send the libnfs v6 support =
patches.
The hang happens also with older libnfs versions so it has nothing to do =
with libnfs v6.

Best
Peter



--Apple-Mail=_B7583B5B-169F-41D0-8CF8-BAD7555B9990
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>Am 03.03.2026 um 20:24 schrieb Peter Lieven =
&lt;pl@dlhnet.de&gt;:</div><br =
class=3D"Apple-interchange-newline"><div><meta http-equiv=3D"content-type"=
 content=3D"text/html; charset=3Dutf-8"><div style=3D"overflow-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: =
after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>Am 10.11.2025 um 16:48 schrieb Hanna Czenczek =
&lt;hreitz@redhat.com&gt;:</div><br =
class=3D"Apple-interchange-newline"><div><div>Like in =E2=80=9Crbd: Run =
co BH CB in the coroutine=E2=80=99s AioContext=E2=80=9D, drop =
the<br>completion flag, yield exactly once, and run the BH in the =
coroutine=E2=80=99s<br>AioContext.<br><br>(Can be reproduced with =
multiqueue by adding a usleep(100000) before the<br>`while =
(!task.complete)` loops.)<br><br>Like in =E2=80=9Ciscsi: Run co BH CB in =
the coroutine=E2=80=99s AioContext=E2=80=9D, this =
makes<br>nfs_co_generic_bh_cb() trivial, so we can drop it in favor of =
just<br>calling aio_co_wake() directly.<br><br>Cc: =
qemu-stable@nongnu.org<br>Signed-off-by: Hanna Czenczek =
&lt;hreitz@redhat.com&gt;<br>---<br> block/nfs.c | 41 =
++++++++++++++++-------------------------<br> 1 file changed, 16 =
insertions(+), 25 deletions(-)<br><br>diff --git a/block/nfs.c =
b/block/nfs.c<br>index 0a7d38db09..1d3a34a30c 100644<br>--- =
a/block/nfs.c<br>+++ b/block/nfs.c<br>@@ -69,7 +69,6 @@ typedef struct =
NFSClient {<br> typedef struct NFSRPC {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;BlockDriverState *bs;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>- &nbsp;&nbsp;&nbsp;int =
complete;<br> &nbsp;&nbsp;&nbsp;&nbsp;QEMUIOVector *iov;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;struct stat *st;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;Coroutine *co;<br>@@ -230,14 +229,6 @@ static =
void coroutine_fn nfs_co_init_task(BlockDriverState *bs, NFSRPC =
*task)<br> &nbsp;&nbsp;&nbsp;&nbsp;};<br> }<br><br>-static void =
nfs_co_generic_bh_cb(void *opaque)<br>-{<br>- &nbsp;&nbsp;&nbsp;NFSRPC =
*task =3D opaque;<br>-<br>- &nbsp;&nbsp;&nbsp;task-&gt;complete =3D =
1;<br>- &nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br>-}<br>-<br> /* =
Called (via nfs_service) with QemuMutex held. &nbsp;*/<br> static =
void<br> nfs_co_generic_cb(int ret, struct nfs_context *nfs, void =
*data,<br>@@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct =
nfs_context *nfs, void *data,<br> &nbsp;&nbsp;&nbsp;&nbsp;if =
(task-&gt;ret &lt; 0) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("NFS Error: =
%s", nfs_get_error(nfs));<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- =
&nbsp;&nbsp;&nbsp;replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio=
_context,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_co=
_generic_bh_cb, task);<br>+<br>+ &nbsp;&nbsp;&nbsp;/*<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* Safe to call: nfs_service(), which called us, =
is only run from the FD<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* handlers, never =
from the request coroutine. &nbsp;The request coroutine in<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* turn will yield unconditionally.<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* No need to release the lock, even if we =
directly enter the coroutine, as<br>+ &nbsp;&nbsp;&nbsp;&nbsp;* the lock =
is never re-taken after yielding. &nbsp;(Note: If we do enter the<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;* coroutine, @task will probably be dangling =
once aio_co_wake() returns.)<br>+ &nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br> }<br><br> static int =
coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,<br>@@ =
-278,9 +277,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState =
*bs, int64_t offset,<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;while =
(!task.complete) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;if (task.ret &lt; 0) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return task.ret;<br>@@ =
-328,9 +325,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState =
*bs, int64_t offset,<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;while =
(!task.complete) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;if (my_buffer) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(buf);<br>@@ =
-358,9 +353,7 @@ static int coroutine_fn nfs_co_flush(BlockDriverState =
*bs)<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;while =
(!task.complete) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;return task.ret;<br> }<br>@@ -723,8 +716,8 @@ =
nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void =
*data,<br> &nbsp;&nbsp;&nbsp;&nbsp;if (task-&gt;ret &lt; 0) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("NFS Error: =
%s", nfs_get_error(nfs));<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- =
&nbsp;&nbsp;&nbsp;replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio=
_context,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_co=
_generic_bh_cb, task);<br>+ &nbsp;&nbsp;&nbsp;/* Safe to call, see =
nfs_co_generic_cb() */<br>+ =
&nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br> }<br><br> static int64_t =
coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)<br>@@ =
-748,9 +741,7 @@ static int64_t coroutine_fn =
nfs_co_get_allocated_file_size(BlockDriverState *bs)<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
> &nbsp;&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;while =
(!task.complete) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;return (task.ret &lt; 0 ? task.ret : =
st.st_blocks * 512);<br> }<br>-- =
<br>2.51.1<br><br></div></div></blockquote><br></div><div>Hallo =
Hanna,</div><div><br></div><div>it has been a long time where I was =
inactive in Qemu development and I should have checked this earlier, but =
it seems that this patch accidentally broke libnfs usage with at least =
qemu cmdline tools like qemu-img. Again, sorry for not testing this =
earlier, but I have only recently entered the Qemu show =
again.</div><div><br></div><div>I found this glitch while working on a =
patch to include libnfs v6 support in qemu to avoid dropping libnfs =
support.</div><div><br></div><div>A simple call =
like:</div><div><br></div><div>qemu-img create -f qcow2 <a =
href=3D"nfs://nfsserver/image.qcow2">nfs://nfsserver/image.qcow2</a>&nbsp;=
10G</div><div><br></div><div>hangs forever in the second write =
request.</div><div><br></div><div>I have not confirmed, but this might =
also hold true for libiscsi which internally is quite identical (at =
least it was 3 years ago ;-))</div><div><br></div><div>You are right, =
the coroutine can only yield once, but it seems that the bottom half =
logic is still needed.</div><div>Maybe you have an idea why? I remember =
that we had this differently first and implemented it after Stefan =
pointed out that it might be needed.</div><div>I will try to find the =
thread about this =
discussion.</div></div></div></blockquote><div><br></div><div>The BH for =
the iscsi driver was actually introduced =
here:</div><div><br></div><div><p style=3D"margin: 0px; font-style: =
normal; font-variant-caps: normal; font-width: normal; font-size: 13px; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
font-size-adjust: none; font-kerning: auto; font-variant-alternates: =
normal; font-variant-ligatures: normal; font-variant-numeric: normal; =
font-variant-east-asian: normal; font-variant-position: normal; =
font-variant-emoji: normal; font-feature-settings: normal; =
font-optical-sizing: auto; font-variation-settings: normal;">commit =
8b9dfe9098d91e06a3dd6376624307fe5fa13be8</p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; font-size: 13px; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-variant-emoji: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal;">Author: Peter Lieven =
&lt;pl@kamp.de&gt;</p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; font-size: 13px; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-variant-emoji: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal;">Date: &nbsp; Sat Dec 14 17:31:40 2013 =
+0100</p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; font-size: 13px; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-variant-emoji: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal; min-height: 15px;"><br></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; =
font-width: normal; font-size: 13px; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;; font-size-adjust: none; font-kerning: auto; =
font-variant-alternates: normal; font-variant-ligatures: normal; =
font-variant-numeric: normal; font-variant-east-asian: normal; =
font-variant-position: normal; font-variant-emoji: normal; =
font-feature-settings: normal; font-optical-sizing: auto; =
font-variation-settings: normal;">&nbsp; &nbsp; block/iscsi: use a bh to =
schedule co reentrance</p><div><br></div><div>I am not 100% sure if the =
justification for this commit is still the same or if it was fixed by =
switching to aio_co_wake anyway.</div><div><br></div><div>I meanwhile =
tested libiscsi support and it seems not to hang, but it might still =
have a performance impact (maybe).</div><div><br></div><div>If someone =
has a clue I could go ahead and send the libnfs v6 support =
patches.</div><div>The hang happens also with older libnfs versions so =
it has nothing to do with libnfs =
v6.</div><div><br></div><div>Best</div><div>Peter</div><div><br></div><div=
><br></div></div></div></body></html>=

--Apple-Mail=_B7583B5B-169F-41D0-8CF8-BAD7555B9990--

