Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CC4F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVgT-0002LW-2V; Fri, 06 Mar 2026 08:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vyVgO-0002Kx-1E; Fri, 06 Mar 2026 08:57:36 -0500
Received: from mailcow.dlhnet.de ([2a01:b1c0::44ca:22ff:fe9b:798c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vyVgL-0008Ui-9q; Fri, 06 Mar 2026 08:57:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D70E846A99A; Fri,  6 Mar 2026 14:57:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlhnet.de; s=dkim;
 t=1772805441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=wkOfC7AbRpYstbRRSiNT1+wb8iojjgJOrafc0QhCKSk=;
 b=f8D6Mrs+gkgxOoo2CPrKR95T8Kh0e0DKWh9Tgj/tYQXM7Th5oqiUg2547VoCvGGnFRJwVz
 gAL6NFRT+iSWKAHZTiBKWqtLoo+BJGYRcOpHQFsjaojjGFh2z+oK6EOWLwnuzhfyvzRNeR
 eAyPIW293lu2sMZ0JniPd6kHcPpY1kC7IsjzNI84bCWJdCk0OIl9/UmkZ71YJXCUNR3+03
 O1r1PGiOkFkR/ilnOqZy9enY7uaGFoQP0yOAGjhg4seZuddli9VD89CnCQnNv/emU85Oos
 WRGAAJ/+YtYjlMLIE7lBusNAp1XlLqBd2PWfz5klqUThb0EYC9RAMvvotbS4TQ==
From: Peter Lieven <pl@dlhnet.de>
Message-Id: <D366BE0D-C606-4DE1-9BC6-6DE522616F0C@dlhnet.de>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6DD238CA-E45C-444E-BE8B-30DD378DF767"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH_v2_04/19=5D_nfs=3A_Run_co_BH_CB_in_the_c?=
 =?utf-8?Q?oroutine=E2=80=99s_AioContext?=
Date: Fri, 6 Mar 2026 14:57:09 +0100
In-Reply-To: <1d11486a-f592-49ff-837a-346f7c493ca7@redhat.com>
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
 <1d11486a-f592-49ff-837a-346f7c493ca7@redhat.com>
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


--Apple-Mail=_6DD238CA-E45C-444E-BE8B-30DD378DF767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> Am 06.03.2026 um 14:41 schrieb Hanna Czenczek <hreitz@redhat.com>:
>=20
> On 03.03.26 20:24, Peter Lieven wrote:
>>=20
>>=20
>>> Am 10.11.2025 um 16:48 schrieb Hanna Czenczek <hreitz@redhat.com> =
<mailto:hreitz@redhat.com>:
>>>=20
>>> Like in =E2=80=9Crbd: Run co BH CB in the coroutine=E2=80=99s =
AioContext=E2=80=9D, drop the
>>> completion flag, yield exactly once, and run the BH in the =
coroutine=E2=80=99s
>>> AioContext.
>>>=20
>>> (Can be reproduced with multiqueue by adding a usleep(100000) before =
the
>>> `while (!task.complete)` loops.)
>>>=20
>>> Like in =E2=80=9Ciscsi: Run co BH CB in the coroutine=E2=80=99s =
AioContext=E2=80=9D, this makes
>>> nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
>>> calling aio_co_wake() directly.
>>>=20
>>> Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com> =
<mailto:hreitz@redhat.com>
>>> ---
>>> block/nfs.c | 41 ++++++++++++++++-------------------------
>>> 1 file changed, 16 insertions(+), 25 deletions(-)
>>>=20
>>> diff --git a/block/nfs.c b/block/nfs.c
>>> index 0a7d38db09..1d3a34a30c 100644
>>> --- a/block/nfs.c
>>> +++ b/block/nfs.c
>>> @@ -69,7 +69,6 @@ typedef struct NFSClient {
>>> typedef struct NFSRPC {
>>>     BlockDriverState *bs;
>>>     int ret;
>>> -    int complete;
>>>     QEMUIOVector *iov;
>>>     struct stat *st;
>>>     Coroutine *co;
>>> @@ -230,14 +229,6 @@ static void coroutine_fn =
nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
>>>     };
>>> }
>>>=20
>>> -static void nfs_co_generic_bh_cb(void *opaque)
>>> -{
>>> -    NFSRPC *task =3D opaque;
>>> -
>>> -    task->complete =3D 1;
>>> -    aio_co_wake(task->co);
>>> -}
>>> -
>>> /* Called (via nfs_service) with QemuMutex held.  */
>>> static void
>>> nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
>>> @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context =
*nfs, void *data,
>>>     if (task->ret < 0) {
>>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>>     }
>>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>>> -                                     nfs_co_generic_bh_cb, task);
>>> +
>>> +    /*
>>> +     * Safe to call: nfs_service(), which called us, is only run =
from the FD
>>> +     * handlers, never from the request coroutine.  The request =
coroutine in
>>> +     * turn will yield unconditionally.
>>> +     * No need to release the lock, even if we directly enter the =
coroutine, as
>>> +     * the lock is never re-taken after yielding.  (Note: If we do =
enter the
>>> +     * coroutine, @task will probably be dangling once =
aio_co_wake() returns.)
>>> +     */
>>> +    aio_co_wake(task->co);
>>> }
>>>=20
>>> static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t =
offset,
>>> @@ -278,9 +277,7 @@ static int coroutine_fn =
nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>>>=20
>>>         nfs_set_events(client);
>>>     }
>>> -    while (!task.complete) {
>>> -        qemu_coroutine_yield();
>>> -    }
>>> +    qemu_coroutine_yield();
>>>=20
>>>     if (task.ret < 0) {
>>>         return task.ret;
>>> @@ -328,9 +325,7 @@ static int coroutine_fn =
nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
>>>=20
>>>         nfs_set_events(client);
>>>     }
>>> -    while (!task.complete) {
>>> -        qemu_coroutine_yield();
>>> -    }
>>> +    qemu_coroutine_yield();
>>>=20
>>>     if (my_buffer) {
>>>         g_free(buf);
>>> @@ -358,9 +353,7 @@ static int coroutine_fn =
nfs_co_flush(BlockDriverState *bs)
>>>=20
>>>         nfs_set_events(client);
>>>     }
>>> -    while (!task.complete) {
>>> -        qemu_coroutine_yield();
>>> -    }
>>> +    qemu_coroutine_yield();
>>>=20
>>>     return task.ret;
>>> }
>>> @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct =
nfs_context *nfs, void *data,
>>>     if (task->ret < 0) {
>>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>>     }
>>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>>> -                                     nfs_co_generic_bh_cb, task);
>>> +    /* Safe to call, see nfs_co_generic_cb() */
>>> +    aio_co_wake(task->co);
>>> }
>>>=20
>>> static int64_t coroutine_fn =
nfs_co_get_allocated_file_size(BlockDriverState *bs)
>>> @@ -748,9 +741,7 @@ static int64_t coroutine_fn =
nfs_co_get_allocated_file_size(BlockDriverState *bs)
>>>=20
>>>         nfs_set_events(client);
>>>     }
>>> -    while (!task.complete) {
>>> -        qemu_coroutine_yield();
>>> -    }
>>> +    qemu_coroutine_yield();
>>>=20
>>>     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>>> }
>>> --=20
>>> 2.51.1
>>>=20
>>=20
>> Hallo Hanna,
>>=20
>> it has been a long time where I was inactive in Qemu development and =
I should have checked this earlier, but it seems that this patch =
accidentally broke libnfs usage with at least qemu cmdline tools like =
qemu-img. Again, sorry for not testing this earlier, but I have only =
recently entered the Qemu show again.
>>=20
>> I found this glitch while working on a patch to include libnfs v6 =
support in qemu to avoid dropping libnfs support.
>>=20
>> A simple call like:
>>=20
>> qemu-img create -f qcow2 nfs://nfsserver/image.qcow2 10G
>>=20
>> hangs forever in the second write request.
>=20
> I sent a patch for this, which is basically the same as yours below: =
https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.html

Thanks, I will rebase by NFS patches for libnfs v6 on top of that.

Do we need the same fix for iSCSI?

Peter


--Apple-Mail=_6DD238CA-E45C-444E-BE8B-30DD378DF767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>Am 06.03.2026 um 14:41 schrieb Hanna Czenczek =
&lt;hreitz@redhat.com&gt;:</div><br =
class=3D"Apple-interchange-newline"><div>

 =20
    <meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3DUTF-8">
 =20
  <div>
    <div class=3D"moz-cite-prefix">On 03.03.26 20:24, Peter Lieven =
wrote:<br>
    </div>
    <blockquote type=3D"cite" =
cite=3D"mid:EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de">
      <meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3DUTF-8">
      <br id=3D"lineBreakAtBeginningOfMessage">
      <div><br>
        <blockquote type=3D"cite">
          <div>Am 10.11.2025 um 16:48 schrieb Hanna Czenczek
            <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>:</div>
          <br class=3D"Apple-interchange-newline">
          <div>
            <div>Like in =E2=80=9Crbd: Run co BH CB in the coroutine=E2=80=
=99s
              AioContext=E2=80=9D, drop the<br>
              completion flag, yield exactly once, and run the BH in the
              coroutine=E2=80=99s<br>
              AioContext.<br>
              <br>
              (Can be reproduced with multiqueue by adding a
              usleep(100000) before the<br>
              `while (!task.complete)` loops.)<br>
              <br>
              Like in =E2=80=9Ciscsi: Run co BH CB in the coroutine=E2=80=99=
s
              AioContext=E2=80=9D, this makes<br>
              nfs_co_generic_bh_cb() trivial, so we can drop it in favor
              of just<br>
              calling aio_co_wake() directly.<br>
              <br>
              Cc: <a class=3D"moz-txt-link-abbreviated" =
href=3D"mailto:qemu-stable@nongnu.org">qemu-stable@nongnu.org</a><br>
              Signed-off-by: Hanna Czenczek <a =
class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a><br>
              ---<br>
              block/nfs.c | 41 =
++++++++++++++++-------------------------<br>
              1 file changed, 16 insertions(+), 25 deletions(-)<br>
              <br>
              diff --git a/block/nfs.c b/block/nfs.c<br>
              index 0a7d38db09..1d3a34a30c 100644<br>
              --- a/block/nfs.c<br>
              +++ b/block/nfs.c<br>
              @@ -69,7 +69,6 @@ typedef struct NFSClient {<br>
              typedef struct NFSRPC {<br>
              &nbsp;&nbsp;&nbsp;&nbsp;BlockDriverState *bs;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>
              - &nbsp;&nbsp;&nbsp;int complete;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;QEMUIOVector *iov;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;struct stat *st;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;Coroutine *co;<br>
              @@ -230,14 +229,6 @@ static void coroutine_fn
              nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)<br>
              &nbsp;&nbsp;&nbsp;&nbsp;};<br>
              }<br>
              <br>
              -static void nfs_co_generic_bh_cb(void *opaque)<br>
              -{<br>
              - &nbsp;&nbsp;&nbsp;NFSRPC *task =3D opaque;<br>
              -<br>
              - &nbsp;&nbsp;&nbsp;task-&gt;complete =3D 1;<br>
              - &nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br>
              -}<br>
              -<br>
              /* Called (via nfs_service) with QemuMutex held. =
&nbsp;*/<br>
              static void<br>
              nfs_co_generic_cb(int ret, struct nfs_context *nfs, void
              *data,<br>
              @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct
              nfs_context *nfs, void *data,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;if (task-&gt;ret &lt; 0) {<br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("NFS Error: =
%s", nfs_get_error(nfs));<br>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              -
              =
&nbsp;&nbsp;&nbsp;replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio=
_context,<br>
              -
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_co=
_generic_bh_cb,
              task);<br>
              +<br>
              + &nbsp;&nbsp;&nbsp;/*<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* Safe to call: nfs_service(), =
which called us, is
              only run from the FD<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* handlers, never from the =
request coroutine. &nbsp;The
              request coroutine in<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* turn will yield =
unconditionally.<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* No need to release the lock, =
even if we directly
              enter the coroutine, as<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* the lock is never re-taken =
after yielding. &nbsp;(Note:
              If we do enter the<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;* coroutine, @task will probably =
be dangling once
              aio_co_wake() returns.)<br>
              + &nbsp;&nbsp;&nbsp;&nbsp;*/<br>
              + &nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br>
              }<br>
              <br>
              static int coroutine_fn nfs_co_preadv(BlockDriverState
              *bs, int64_t offset,<br>
              @@ -278,9 +277,7 @@ static int coroutine_fn
              nfs_co_preadv(BlockDriverState *bs, int64_t offset,<br>
              <br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              - &nbsp;&nbsp;&nbsp;while (!task.complete) {<br>
              - =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              - &nbsp;&nbsp;&nbsp;}<br>
              + &nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;if (task.ret &lt; 0) {<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
task.ret;<br>
              @@ -328,9 +325,7 @@ static int coroutine_fn
              nfs_co_pwritev(BlockDriverState *bs, int64_t offset,<br>
              <br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              - &nbsp;&nbsp;&nbsp;while (!task.complete) {<br>
              - =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              - &nbsp;&nbsp;&nbsp;}<br>
              + &nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;if (my_buffer) {<br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(buf);<br>
              @@ -358,9 +353,7 @@ static int coroutine_fn
              nfs_co_flush(BlockDriverState *bs)<br>
              <br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              - &nbsp;&nbsp;&nbsp;while (!task.complete) {<br>
              - =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              - &nbsp;&nbsp;&nbsp;}<br>
              + &nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;return task.ret;<br>
              }<br>
              @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int
              ret, struct nfs_context *nfs, void *data,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;if (task-&gt;ret &lt; 0) {<br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("NFS Error: =
%s", nfs_get_error(nfs));<br>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              -
              =
&nbsp;&nbsp;&nbsp;replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio=
_context,<br>
              -
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_co=
_generic_bh_cb,
              task);<br>
              + &nbsp;&nbsp;&nbsp;/* Safe to call, see =
nfs_co_generic_cb() */<br>
              + &nbsp;&nbsp;&nbsp;aio_co_wake(task-&gt;co);<br>
              }<br>
              <br>
              static int64_t coroutine_fn
              nfs_co_get_allocated_file_size(BlockDriverState *bs)<br>
              @@ -748,9 +741,7 @@ static int64_t coroutine_fn
              nfs_co_get_allocated_file_size(BlockDriverState *bs)<br>
              <br>
              =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br=
>
              &nbsp;&nbsp;&nbsp;&nbsp;}<br>
              - &nbsp;&nbsp;&nbsp;while (!task.complete) {<br>
              - =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              - &nbsp;&nbsp;&nbsp;}<br>
              + &nbsp;&nbsp;&nbsp;qemu_coroutine_yield();<br>
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;return (task.ret &lt; 0 ? task.ret =
: st.st_blocks *
              512);<br>
              }<br>
              -- <br>
              2.51.1<br>
              <br>
            </div>
          </div>
        </blockquote>
        <br>
      </div>
      <div>Hallo Hanna,</div>
      <div><br>
      </div>
      <div>it has been a long time where I was inactive in Qemu
        development and I should have checked this earlier, but it seems
        that this patch accidentally broke libnfs usage with at least
        qemu cmdline tools like qemu-img. Again, sorry for not testing
        this earlier, but I have only recently entered the Qemu show
        again.</div>
      <div><br>
      </div>
      <div>I found this glitch while working on a patch to include
        libnfs v6 support in qemu to avoid dropping libnfs =
support.</div>
      <div><br>
      </div>
      <div>A simple call like:</div>
      <div><br>
      </div>
      <div>qemu-img create -f qcow2 <a =
href=3D"nfs://nfsserver/image.qcow2" moz-do-not-send=3D"true" =
class=3D"moz-txt-link-freetext">nfs://nfsserver/image.qcow2</a>&nbsp;10G</=
div>
      <div><br>
      </div>
      <div>hangs forever in the second write request.</div>
    </blockquote>
    <br>
    I sent a patch for this, which is basically the same as yours below:
<a class=3D"moz-txt-link-freetext" =
href=3D"https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.=
html">https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.ht=
ml</a></div></div></blockquote><br></div><div>Thanks, I will rebase by =
NFS patches for libnfs v6 on top of that.</div><div><br></div><div>Do we =
need the same fix for =
iSCSI?</div><div><br></div><div>Peter</div><div><br></div></body></html>=

--Apple-Mail=_6DD238CA-E45C-444E-BE8B-30DD378DF767--

