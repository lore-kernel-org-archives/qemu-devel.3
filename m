Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB99AC2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJt1e-00055m-JZ; Wed, 19 Jun 2024 06:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJt1c-00055d-SX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJt1a-0004Cs-03
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718794724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fYOc51VOSe4h0pD5iYgqcuggbLwePf+vThcJzQuo+s=;
 b=P9UnoXAHEogY3h1ICx8STDKEyZxraJq/ITtIOylYUmSj7E5Y6jagKCALI6YIrxgBcJU3SW
 S4vFiTVQkbou6HPJ51SIyPFsgAAHmAjM5zQFYZ+HwoNjy085WOWS1B7UnFdwH59Tn4HWUN
 vLjkY6//cF3SAYJwR5Q1eSe8OIjupO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-bYGMIp5MMcKLYuTnlqsnGg-1; Wed, 19 Jun 2024 06:58:42 -0400
X-MC-Unique: bYGMIp5MMcKLYuTnlqsnGg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421805fadadso47264535e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718794722; x=1719399522;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fYOc51VOSe4h0pD5iYgqcuggbLwePf+vThcJzQuo+s=;
 b=JaM5C+pDXzBpl8ioZ9shr+MYbpXurRG4f05r6BUFBU2xOBxAUh4sBUsVzu190ZNa43
 XKc4snhmADIvNaKeWLaXio4nXWZ4sT6IiRvxXbR3ur46pOagXa7SBCeVkEslBzWPlUdx
 D8vkNWwC1+A3m7A1R05flAwCZGQ4PpwGgKvWoizQ6MjURnCzt+F8vNpTPSQcxAHXdBck
 WpcrpZeXtKf4kobMZQW0fWJOHZ8kQfEW7JTL04GZk6lStqdwF2qwJqG6/ItwkD68rDgs
 11pYZzqNSZ0YF2zlMuKDyqQt0LvJDEiWJEow7OfRMAn2ASB7QKMtrXuxna6bngxx6ajm
 k5iA==
X-Gm-Message-State: AOJu0YyECTU7QKTzeyTR5jXzfHjXiObSKN7SE3FXmiNf/zGKqR4AmaAE
 CeJ3SGzW0wVUToiKV3C58fBU1dK9i0baVtjUM6pqSCUy55kSSUk2wMgp4XKUX7HQqXLZh97PHOb
 7wyIXqkon5MZJm8bIoxyCTlc9M3MtWMXPfuKEi/dGcakW8mNGnZ4p
X-Received: by 2002:a05:600c:2255:b0:421:aace:7aa9 with SMTP id
 5b1f17b1804b1-424751751b1mr13936805e9.9.1718794721742; 
 Wed, 19 Jun 2024 03:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5o9R/4/VjtbbtShGXjKeVwQqqfRgmksN6x9Z4BrvyUbDe1c1ui15d9UjnL6k4fHjjU4fUsA==
X-Received: by 2002:a05:600c:2255:b0:421:aace:7aa9 with SMTP id
 5b1f17b1804b1-424751751b1mr13936695e9.9.1718794721239; 
 Wed, 19 Jun 2024 03:58:41 -0700 (PDT)
Received: from smtpclient.apple (93-172-212-43.bb.netvision.net.il.
 [93.172.212.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f9e2b306sm224176125e9.16.2024.06.19.03.58.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:58:40 -0700 (PDT)
From: Nir Soffer <nsoffer@redhat.com>
Message-Id: <CA5B7F3C-1C85-4A65-BD10-7B7B913EDB2B@redhat.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_57382A6F-4468-4D23-9FF9-1CE82312A7E7"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] block/file-posix: Consider discard flag when opening
Date: Wed, 19 Jun 2024 13:58:28 +0300
In-Reply-To: <ZnKT8ECzHjpLGOm_@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
To: Kevin Wolf <kwolf@redhat.com>
References: <20240618212457.714456-1-nsoffer@redhat.com>
 <ZnKT8ECzHjpLGOm_@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--Apple-Mail=_57382A6F-4468-4D23-9FF9-1CE82312A7E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 19 Jun 2024, at 11:16, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 18.06.2024 um 23:24 hat Nir Soffer geschrieben:
>> Set has_discard only when BDRV_O_UNMAP is not set. With this users =
that
>> want to keep their images fully allocated can disable hole punching
>> when writing zeros or discarding using:
>>=20
>>   -drive file=3Dthick.img,discard=3Doff
>>=20
>> This change is not entirely correct since it changes the default =
discard
>> behavior.  Previously we always allowed punching holes, but now you =
have
>> must use discard=3Dunmap|on to enable it. We probably need to add the
>> BDDR_O_UNMAP flag by default.
>>=20
>> make check still works, so maybe we don't have tests for sparsifying
>> images, or maybe you need to run special tests that do not run by
>> default. We needs tests for keeping images non-sparse.
>>=20
>> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
>=20
> So first of all, I agree with you that this patch is wrong. ;-)
>=20
> At first, I failed to understand the problem this is trying to solve. =
I
> put a debug message in handle_aiocb_discard() and tried with which
> options it triggers. [1] To me, this looked exactly like it should be.
> We only try to discard blocks when discard=3Dunmap is given as an =
option.
>=20
> That leaves the case of write_zeroes. And while at the first sight, =
the
> code looked good, we do seem to have a problem there and it tried to
> unmap even with discard=3Doff.
>=20
>> block/file-posix.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index be25e35ff6..acac2abadc 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -738,11 +738,11 @@ static int raw_open_common(BlockDriverState =
*bs, QDict *options,
>>         ret =3D -EINVAL;
>>         goto fail;
>>     }
>> #endif /* !defined(CONFIG_LINUX_IO_URING) */
>>=20
>> -    s->has_discard =3D true;
>> +    s->has_discard =3D !!(bdrv_flags & BDRV_O_UNMAP);
>>     s->has_write_zeroes =3D true;
>>=20
>>     if (fstat(s->fd, &st) < 0) {
>>         ret =3D -errno;
>>         error_setg_errno(errp, errno, "Could not stat file");
>=20
> s->has_discard is about what the host supports, not about the =
semantics
> of the QEMU block node. So this doesn't feel right to me.
>=20
> So for the buggy case, write_zeroes, bdrv_co_pwrite_zeroes() has code
> that considers the case and clears the ~BDRV_REQ_MAY_UNMAP flags:
>=20
>    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
>        flags &=3D ~BDRV_REQ_MAY_UNMAP;
>    }
>=20
> But it turns out that we don't necessarily even go through this =
function
> for the top node which has discard=3Doff, so it can't take effect:
>=20
> (gdb) bt
> #0  0x00007ffff4f2f144 in __pthread_kill_implementation () at =
/lib64/libc.so <http://libc.so/>.6
> #1  0x00007ffff4ed765e in raise () at /lib64/libc.so =
<http://libc.so/>.6
> #2  0x00007ffff4ebf902 in abort () at /lib64/libc.so =
<http://libc.so/>.6
> #3  0x000055555615aff0 in raw_do_pwrite_zeroes (bs=3D0x555557f4bcf0, =
offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP, blkdev=3Dfalse) =
at ../block/file-posix.c:3643
> #4  0x000055555615557e in raw_co_pwrite_zeroes (bs=3D0x555557f4bcf0, =
offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/file-posix.c:3655
> #5  0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=3D0x555557f4bcf0,=
 offset=3D0, bytes=3D1048576, flags=3D6) at ../block/io.c:1901
> #6  0x00005555560c72f9 in bdrv_aligned_pwritev (child=3D0x555557f51460, =
req=3D0x7fffed5ff800, offset=3D0, bytes=3D1048576, align=3D1, qiov=3D0x0, =
qiov_offset=3D0, flags=3D6) at ../block/io.c:2100
> #7  0x00005555560c6b41 in bdrv_co_do_zero_pwritev =
(child=3D0x555557f51460, offset=3D0, bytes=3D1048576, flags=3D6, =
req=3D0x7fffed5ff800) at ../block/io.c:2183
> #8  0x00005555560c6647 in bdrv_co_pwritev_part (child=3D0x555557f51460, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/io.c:2283
> #9  0x00005555560c634f in bdrv_co_pwritev (child=3D0x555557f51460, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, flags=3D6) at =
../block/io.c:2216
> #10 0x00005555560c75b5 in bdrv_co_pwrite_zeroes (child=3D0x555557f51460,=
 offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/io.c:2322
> #11 0x0000555556117d24 in raw_co_pwrite_zeroes (bs=3D0x555557f44980, =
offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/raw-format.c:307
> #12 0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=3D0x555557f44980,=
 offset=3D0, bytes=3D1048576, flags=3D6) at ../block/io.c:1901
> #13 0x00005555560c72f9 in bdrv_aligned_pwritev (child=3D0x555557f513f0, =
req=3D0x7fffed5ffd90, offset=3D0, bytes=3D1048576, align=3D1, qiov=3D0x0, =
qiov_offset=3D0, flags=3D6) at ../block/io.c:2100
> #14 0x00005555560c6b41 in bdrv_co_do_zero_pwritev =
(child=3D0x555557f513f0, offset=3D0, bytes=3D1048576, flags=3D6, =
req=3D0x7fffed5ffd90) at ../block/io.c:2183
> #15 0x00005555560c6647 in bdrv_co_pwritev_part (child=3D0x555557f513f0, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/io.c:2283
> #16 0x00005555560ad741 in blk_co_do_pwritev_part (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/block-backend.c:1425
> #17 0x00005555560ad5f2 in blk_co_pwritev_part (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/block-backend.c:1440
> #18 0x00005555560ad8cf in blk_co_pwritev (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, flags=3D6) at =
../block/block-backend.c:1462
> #19 0x00005555560b0f79 in blk_co_pwrite_zeroes (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, flags=3D6) at ../block/block-backend.c:2590
> #20 0x000055555606d240 in blk_co_pwrite_zeroes_entry =
(opaque=3D0x7fffffffbc18) at block/block-gen.c:2162
> #21 0x00005555562c36ba in coroutine_trampoline (i0=3D1475685216, =
i1=3D21845) at ../util/coroutine-ucontext.c:175
> #22 0x00007ffff4ef1190 in ??? () at /lib64/libc.so <http://libc.so/>.6
> #23 0x00007fffffffc010 in ??? ()
> #24 0x0000000000000000 in ??? ()
>=20
> I haven't checked the details yet, but my first impression is that =
this
> check should probably move to bdrv_co_do_pwrite_zeroes().

Punching holes only if BDRV_REQ_MAY_UNMAP bit is set sounds like the =
right way.

>=20
> Kevin
>=20
>=20
> [1] Tests I did:
>=20
> # For discard
>=20
> $ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 =
-drive if=3Dnone,file=3D/tmp/test.raw,format=3Draw -monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "discard 0 1M"
> discard 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 00.00 sec (396.171 GiB/sec and 405679.5132 ops/sec)
> (qemu) quit
>=20
> $ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 =
-drive if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Dunmap =
-monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "discard 0 1M"
> handle_aiocb_discard
> discard 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 00.00 sec (6.623 GiB/sec and 6782.2820 ops/sec)
> (qemu) quit
>=20
> $ echo -e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 =
-drive if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Doff =
-monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "discard 0 1M"
> discard 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 00.00 sec (375.168 GiB/sec and 384172.1091 ops/sec)
> (qemu) quit
>=20
> # For write_zeroes
>=20
> $ echo -e 'qemu-io none0 "write -zu 0 1M"\nquit' | =
./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Dunmap -monitor =
stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "write -zu 0 1M"
> handle_aiocb_write_zeroes_unmap
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 00.00 sec (4.943 GiB/sec and 5061.5997 ops/sec)
> (qemu) quit
> $ echo -e 'qemu-io none0 "write -zu 0 1M"\nquit' | =
./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Doff -monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) qemu-io none0 "write -zu 0 1M"
> handle_aiocb_write_zeroes_unmap
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 00.00 sec (7.208 GiB/sec and 7381.4357 ops/sec)
> (qemu) quit

Looks like a good way to write tests for this, thanks for sharing.

Nir



--Apple-Mail=_57382A6F-4468-4D23-9FF9-1CE82312A7E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 19 Jun 2024, at 11:16, Kevin Wolf =
&lt;kwolf@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Am 18.06.2024 um 23:24 hat Nir Soffer =
geschrieben:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Set has_discard only when BDRV_O_UNMAP is not =
set. With this users that<br>want to keep their images fully allocated =
can disable hole punching<br>when writing zeros or discarding =
using:<br><br>&nbsp;&nbsp;-drive file=3Dthick.img,discard=3Doff<br><br>Thi=
s change is not entirely correct since it changes the default =
discard<br>behavior. &nbsp;Previously we always allowed punching holes, =
but now you have<br>must use discard=3Dunmap|on to enable it. We =
probably need to add the<br>BDDR_O_UNMAP flag by default.<br><br>make =
check still works, so maybe we don't have tests for =
sparsifying<br>images, or maybe you need to run special tests that do =
not run by<br>default. We needs tests for keeping images =
non-sparse.<br><br>Signed-off-by: Nir Soffer =
&lt;nsoffer@redhat.com&gt;<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">So =
first of all, I agree with you that this patch is wrong. ;-)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">At first, I failed to understand the =
problem this is trying to solve. I</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">put a =
debug message in handle_aiocb_discard() and tried with which</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">options it triggers. [1] To me, this looked =
exactly like it should be.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">We only =
try to discard blocks when discard=3Dunmap is given as an =
option.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">That leaves the case of =
write_zeroes. And while at the first sight, the</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">code looked good, we do seem to have a =
problem there and it tried to</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">unmap =
even with discard=3Doff.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">block/file-posix.c | 2 +-<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br>diff --git a/block/file-posix.c =
b/block/file-posix.c<br>index be25e35ff6..acac2abadc 100644<br>--- =
a/block/file-posix.c<br>+++ b/block/file-posix.c<br>@@ -738,11 +738,11 =
@@ static int raw_open_common(BlockDriverState *bs, QDict =
*options,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
-EINVAL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
fail;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>#endif /* =
!defined(CONFIG_LINUX_IO_URING) */<br><br>- =
&nbsp;&nbsp;&nbsp;s-&gt;has_discard =3D true;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;has_discard =3D !!(bdrv_flags &amp; =
BDRV_O_UNMAP);<br>&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;has_write_zeroes =3D =
true;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if (fstat(s-&gt;fd, &amp;st) &lt; =
0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
-errno;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg_errn=
o(errp, errno, "Could not stat file");<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">s-&gt;has_discard is about what the host =
supports, not about the semantics</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">of the =
QEMU block node. So this doesn't feel right to me.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">So for the buggy case, write_zeroes, =
bdrv_co_pwrite_zeroes() has code</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">that =
considers the case and clears the ~BDRV_REQ_MAY_UNMAP flags:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;&nbsp;&nbsp;if =
(!(child-&gt;bs-&gt;open_flags &amp; BDRV_O_UNMAP)) {</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flags &amp;=3D =
~BDRV_REQ_MAY_UNMAP;</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;}</span></div></blockquote><blockquote =
type=3D"cite"><div><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">But it turns out that we =
don't necessarily even go through this function</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">for the top node which has discard=3Doff, =
so it can't take effect:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(gdb) =
bt</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">#0 =
&nbsp;0x00007ffff4f2f144 in __pthread_kill_implementation () at =
/lib64/</span><a href=3D"http://libc.so/" style=3D"font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">libc.so</a><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">.6</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#1 &nbsp;0x00007ffff4ed765e in raise () at =
/lib64/</span><a href=3D"http://libc.so/" style=3D"font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">libc.so</a><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">.6</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#2 &nbsp;0x00007ffff4ebf902 in abort () at =
/lib64/</span><a href=3D"http://libc.so/" style=3D"font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">libc.so</a><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">.6</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#3 &nbsp;0x000055555615aff0 in =
raw_do_pwrite_zeroes (bs=3D0x555557f4bcf0, offset=3D0, bytes=3D1048576, =
flags=3DBDRV_REQ_MAY_UNMAP, blkdev=3Dfalse) at =
../block/file-posix.c:3643</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#4 =
&nbsp;0x000055555615557e in raw_co_pwrite_zeroes (bs=3D0x555557f4bcf0, =
offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/file-posix.c:3655</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#5 =
&nbsp;0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=3D0x555557f4bcf0,=
 offset=3D0, bytes=3D1048576, flags=3D6) at ../block/io.c:1901</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#6 &nbsp;0x00005555560c72f9 in =
bdrv_aligned_pwritev (child=3D0x555557f51460, req=3D0x7fffed5ff800, =
offset=3D0, bytes=3D1048576, align=3D1, qiov=3D0x0, qiov_offset=3D0, =
flags=3D6) at ../block/io.c:2100</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#7 =
&nbsp;0x00005555560c6b41 in bdrv_co_do_zero_pwritev =
(child=3D0x555557f51460, offset=3D0, bytes=3D1048576, flags=3D6, =
req=3D0x7fffed5ff800) at ../block/io.c:2183</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#8 &nbsp;0x00005555560c6647 in =
bdrv_co_pwritev_part (child=3D0x555557f51460, offset=3D0, bytes=3D1048576,=
 qiov=3D0x0, qiov_offset=3D0, flags=3D6) at ../block/io.c:2283</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#9 &nbsp;0x00005555560c634f in =
bdrv_co_pwritev (child=3D0x555557f51460, offset=3D0, bytes=3D1048576, =
qiov=3D0x0, flags=3D6) at ../block/io.c:2216</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#10 0x00005555560c75b5 in =
bdrv_co_pwrite_zeroes (child=3D0x555557f51460, offset=3D0, =
bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/io.c:2322</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#11 =
0x0000555556117d24 in raw_co_pwrite_zeroes (bs=3D0x555557f44980, =
offset=3D0, bytes=3D1048576, flags=3DBDRV_REQ_MAY_UNMAP) at =
../block/raw-format.c:307</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#12 =
0x00005555560cde2a in bdrv_co_do_pwrite_zeroes (bs=3D0x555557f44980, =
offset=3D0, bytes=3D1048576, flags=3D6) at ../block/io.c:1901</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">#13 0x00005555560c72f9 in =
bdrv_aligned_pwritev (child=3D0x555557f513f0, req=3D0x7fffed5ffd90, =
offset=3D0, bytes=3D1048576, align=3D1, qiov=3D0x0, qiov_offset=3D0, =
flags=3D6) at ../block/io.c:2100</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#14 =
0x00005555560c6b41 in bdrv_co_do_zero_pwritev (child=3D0x555557f513f0, =
offset=3D0, bytes=3D1048576, flags=3D6, req=3D0x7fffed5ffd90) at =
../block/io.c:2183</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#15 =
0x00005555560c6647 in bdrv_co_pwritev_part (child=3D0x555557f513f0, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/io.c:2283</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#16 =
0x00005555560ad741 in blk_co_do_pwritev_part (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/block-backend.c:1425</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#17 =
0x00005555560ad5f2 in blk_co_pwritev_part (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, qiov=3D0x0, qiov_offset=3D0, flags=3D6) at =
../block/block-backend.c:1440</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#18 =
0x00005555560ad8cf in blk_co_pwritev (blk=3D0x555557f51660, offset=3D0, =
bytes=3D1048576, qiov=3D0x0, flags=3D6) at =
../block/block-backend.c:1462</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#19 =
0x00005555560b0f79 in blk_co_pwrite_zeroes (blk=3D0x555557f51660, =
offset=3D0, bytes=3D1048576, flags=3D6) at =
../block/block-backend.c:2590</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#20 =
0x000055555606d240 in blk_co_pwrite_zeroes_entry (opaque=3D0x7fffffffbc18)=
 at block/block-gen.c:2162</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#21 =
0x00005555562c36ba in coroutine_trampoline (i0=3D1475685216, i1=3D21845) =
at ../util/coroutine-ucontext.c:175</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#22 =
0x00007ffff4ef1190 in ??? () at /lib64/</span><a href=3D"http://libc.so/" =
style=3D"font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">libc.so</a><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">.6</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#23 =
0x00007fffffffc010 in ??? ()</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">#24 =
0x0000000000000000 in ??? ()</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I =
haven't checked the details yet, but my first impression is that =
this</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">check should probably =
move to bdrv_co_do_pwrite_zeroes().</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote><div><br></div><div>Punching =
holes only if BDRV_REQ_MAY_UNMAP bit is set sounds like the right =
way.</div><div><br></div><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Kevin</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">[1] =
Tests I did:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;"># For discard</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">$ echo -e 'qemu-io none0 "discard 0 =
1M"\nquit' | ./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw -monitor stdio</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">QEMU 9.0.50 monitor - type 'help' for more =
information</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">(qemu) qemu-io none0 =
"discard 0 1M"</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">discard =
1048576/1048576 bytes at offset 0</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">1 MiB, =
1 ops; 00.00 sec (396.171 GiB/sec and 405679.5132 ops/sec)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">(qemu) quit</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">$ echo =
-e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Dunmap -monitor =
stdio</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">QEMU 9.0.50 monitor - =
type 'help' for more information</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
qemu-io none0 "discard 0 1M"</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">handle_aiocb_discard</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">discard =
1048576/1048576 bytes at offset 0</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">1 MiB, =
1 ops; 00.00 sec (6.623 GiB/sec and 6782.2820 ops/sec)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">(qemu) quit</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">$ echo =
-e 'qemu-io none0 "discard 0 1M"\nquit' | ./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Doff -monitor =
stdio</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">QEMU 9.0.50 monitor - =
type 'help' for more information</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
qemu-io none0 "discard 0 1M"</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">discard =
1048576/1048576 bytes at offset 0</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">1 MiB, =
1 ops; 00.00 sec (375.168 GiB/sec and 384172.1091 ops/sec)</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">(qemu) quit</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"># For =
write_zeroes</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">$ echo -e 'qemu-io none0 =
"write -zu 0 1M"\nquit' | ./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Dunmap -monitor =
stdio</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">QEMU 9.0.50 monitor - =
type 'help' for more information</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
qemu-io none0 "write -zu 0 1M"</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">handle_aiocb_write_zeroes_unmap</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">wrote 1048576/1048576 bytes at offset =
0</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">1 MiB, 1 ops; 00.00 sec =
(4.943 GiB/sec and 5061.5997 ops/sec)</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
quit</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">$ echo -e 'qemu-io none0 =
"write -zu 0 1M"\nquit' | ./qemu-system-x86_64 -drive =
if=3Dnone,file=3D/tmp/test.raw,format=3Draw,discard=3Doff -monitor =
stdio</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 13px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">QEMU 9.0.50 monitor - =
type 'help' for more information</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
qemu-io none0 "write -zu 0 1M"</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">handle_aiocb_write_zeroes_unmap</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
13px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">wrote 1048576/1048576 bytes at offset =
0</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">1 MiB, 1 ops; 00.00 sec =
(7.208 GiB/sec and 7381.4357 ops/sec)</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">(qemu) =
quit</span></div></blockquote><br></div><div>Looks like a good way to =
write tests for this, thanks for =
sharing.</div><div><br></div><div>Nir</div><div><br></div><br></body></htm=
l>=

--Apple-Mail=_57382A6F-4468-4D23-9FF9-1CE82312A7E7--


