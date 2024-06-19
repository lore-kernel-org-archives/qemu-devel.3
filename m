Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzLb-0003AK-DX; Wed, 19 Jun 2024 13:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzLZ-00039v-SN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzLX-0006TY-KW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718819026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtValsoMsDBsbDkO2BGJgpt8cOh0br0FEgiE2dJ2Kck=;
 b=gQA+tGH7vKe0GmcfumNIne2R16+68OnzYIX1bh0s3+NwKxV+1TVQfNRqtkFzc+tf+bzOx+
 mS4BRSiahji1AtsRayCehzRSTCHC3nZbL/nYuyjyCyw05z+5yE0OUcHpanxTXv/Ty9mBsm
 vJKmSQaOZEJV3wYq+RRd48Nl4R7qaXo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-J2fPpQtwNzG5laBVL0EWTA-1; Wed, 19 Jun 2024 13:43:43 -0400
X-MC-Unique: J2fPpQtwNzG5laBVL0EWTA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b51042049eso683096d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718819022; x=1719423822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtValsoMsDBsbDkO2BGJgpt8cOh0br0FEgiE2dJ2Kck=;
 b=hWdORa1niTUskTFyPf28OejRDaCQZTwuT0qUhmNZ3WVVHMnAF/QtBcPJMDYlt0VflR
 4ixtezGHqeVaCIEOaDsIVaSHJfCrLeV4QFovdnC+BNy5HZh403ppFiha8FfpvAWHdsKP
 pdEFG29+of7HqeLDGNqWCV8jAULTfE/IumE3+Pp8m+dBU7et+LUf269yKMhnlW94unnP
 0FcRZSva52eDU5E/uNso2xcZnl16iVJPWt6peRI3zSL9691SBunsUql+FC7xgsxJ2Mep
 tVSQZ8R4kjizqipP5xc44kbnbuCryKDJwoP9BdtoyB7u2tUnwh8ZQ76KmC3eio0DKz8v
 lSUw==
X-Gm-Message-State: AOJu0YxMr3mgiEtYlveMPrpvgye0rwDZawQklXEmeqgZOM8PfpUYhc3Z
 2KL4dAYknA/DsobkXPcbzX7tWkN2WrCEamTuv9hpG9ZOUFC/VaavrMkrFJ0YYnAO2FhBH4v7t5I
 jxKVZqTY/XQZw0K6Vmz7L94p1t5DQ13P1jgTNuvHPH4s2NqzUyzOQ6UXI38Pv4pWTov05QrzJDP
 5A8+LOUZnZCMx7UK+dyp739YfF6SDOqvQ4olP10Q==
X-Received: by 2002:a0c:f38b:0:b0:6b4:ff8e:63f1 with SMTP id
 6a1803df08f44-6b501e4eecbmr29860496d6.34.1718819022399; 
 Wed, 19 Jun 2024 10:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXIaHavhalv8sdR7Ql4QjOShoBpYweFVDdg+IzEuvpgnNE0bywkMPVEH2UFsmC5USqWLVG0gyPZdsK2/Y9HMM=
X-Received: by 2002:a0c:f38b:0:b0:6b4:ff8e:63f1 with SMTP id
 6a1803df08f44-6b501e4eecbmr29860346d6.34.1718819022076; Wed, 19 Jun 2024
 10:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
In-Reply-To: <20240619174022.1298578-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 19 Jun 2024 20:43:25 +0300
Message-ID: <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003e98d5061b41bdd6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000003e98d5061b41bdd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested using:

$ cat test-unmap.sh
#!/bin/sh

qemu=3D${1:?Usage: $0 qemu-executable}
img=3D/tmp/test.raw

echo
echo "defaults - write zeroes"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -z 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
du -sh $img

echo
echo "defaults - write zeroes unmap"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
du -sh $img

echo
echo "defaults - write actual zeros"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
du -sh $img

echo
echo "discard=3Doff - write zeroes unmap"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Doff >/dev/null
du -sh $img

echo
echo "detect-zeros=3Don - write actual zeros"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,detect-zeroes=3Don >/dev/null
du -sh $img

echo
echo "detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' |  $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,detect-zeroes=3Dunmap,discard=
=3Dunmap
>/dev/null
du -sh $img

echo
echo "discard=3Dunmap - write zeroes"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -z 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null
du -sh $img

echo
echo "discard=3Dunmap - write zeroes unmap"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null
du -sh $img

rm $img


Before this change:

$ cat before.out

defaults - write zeroes
1.0M /tmp/test.raw

defaults - write zeroes unmap
0 /tmp/test.raw

defaults - write actual zeros
1.0M /tmp/test.raw

discard=3Doff - write zeroes unmap
0 /tmp/test.raw

detect-zeros=3Don - write actual zeros
1.0M /tmp/test.raw

detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros
0 /tmp/test.raw

discard=3Dunmap - write zeroes
1.0M /tmp/test.raw

discard=3Dunmap - write zeroes unmap
0 /tmp/test.raw
[nsoffer build (consider-discard-option)]$


After this change:

$ cat after.out

defaults - write zeroes
1.0M /tmp/test.raw

defaults - write zeroes unmap
1.0M /tmp/test.raw

defaults - write actual zeros
1.0M /tmp/test.raw

discard=3Doff - write zeroes unmap
1.0M /tmp/test.raw

detect-zeros=3Don - write actual zeros
1.0M /tmp/test.raw

detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros
0 /tmp/test.raw

discard=3Dunmap - write zeroes
1.0M /tmp/test.raw

discard=3Dunmap - write zeroes unmap
0 /tmp/test.raw


Differences:

$ diff -u before.out after.out
--- before.out 2024-06-19 20:24:09.234083713 +0300
+++ after.out 2024-06-19 20:24:20.526165573 +0300
@@ -3,13 +3,13 @@
 1.0M /tmp/test.raw

 defaults - write zeroes unmap
-0 /tmp/test.raw
+1.0M /tmp/test.raw

 defaults - write actual zeros
 1.0M /tmp/test.raw

 discard=3Doff - write zeroes unmap
-0 /tmp/test.raw
+1.0M /tmp/test.raw

On Wed, Jun 19, 2024 at 8:40=E2=80=AFPM Nir Soffer <nsoffer@redhat.com> wro=
te:

> When opening an image with discard=3Doff, we punch hole in the image when
> writing zeroes, making the image sparse. This breaks users that want to
> ensure that writes cannot fail with ENOSPACE by using fully allocated
> images.
>
> bdrv_co_pwrite_zeroes() correctly disable BDRV_REQ_MAY_UNMAP if we
> opened the child without discard=3Dunmap or discard=3Don. But we don't go
> through this function when accessing the top node. Move the check down
> to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.
>
> Issues:
> - We don't punch hole by default, so images are kept allocated. Before
>   this change we punched holes by default. I'm not sure this is a good
>   change in behavior.
> - Need to run all block tests
> - Not sure that we have tests covering unmapping, we may need new tests
> - We may need new tests to cover this change
>
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>
> Changes since v1:
> - Replace the incorrect has_discard change with the right fix
>
> v1 was here:
> https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00198.html
>
>  block/io.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index 7217cf811b..301514c880 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1860,10 +1860,15 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> int64_t offset, int64_t bytes,
>      /* By definition there is no user buffer so this flag doesn't make
> sense */
>      if (flags & BDRV_REQ_REGISTERED_BUF) {
>          return -EINVAL;
>      }
>
> +    /* If opened with discard=3Doff we should never unmap. */
> +    if (!(bs->open_flags & BDRV_O_UNMAP)) {
> +        flags &=3D ~BDRV_REQ_MAY_UNMAP;
> +    }
> +
>      /* Invalidate the cached block-status data range if this write
> overlaps */
>      bdrv_bsc_invalidate_range(bs, offset, bytes);
>
>      assert(alignment % bs->bl.request_alignment =3D=3D 0);
>      head =3D offset % alignment;
> @@ -2313,14 +2318,10 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild
> *child, int64_t offset,
>  {
>      IO_CODE();
>      trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
>      assert_bdrv_graph_readable();
>
> -    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
> -        flags &=3D ~BDRV_REQ_MAY_UNMAP;
> -    }
> -
>      return bdrv_co_pwritev(child, offset, bytes, NULL,
>                             BDRV_REQ_ZERO_WRITE | flags);
>  }
>
>  /*
> --
> 2.45.1
>
>

--0000000000003e98d5061b41bdd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested using:<div><br></div><div>$ cat test-unmap.sh <br>#=
!/bin/sh<br><br>qemu=3D${1:?Usage: $0 qemu-executable}<br>img=3D/tmp/test.r=
aw<br><br>echo<br>echo &quot;defaults - write zeroes&quot;<br>fallocate -l =
1m $img<br>echo -e &#39;qemu-io none0 &quot;write -z 0 1m&quot;\nquit&#39; =
| $qemu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,form=
at=3Draw &gt;/dev/null<br>du -sh $img<br><br>echo<br>echo &quot;defaults - =
write zeroes unmap&quot;<br>fallocate -l 1m $img<br>echo -e &#39;qemu-io no=
ne0 &quot;write -zu 0 1m&quot;\nquit&#39; | $qemu -monitor stdio \<br>=C2=
=A0 =C2=A0 -drive if=3Dnone,file=3D$img,format=3Draw &gt;/dev/null<br>du -s=
h $img<br><br>echo<br>echo &quot;defaults - write actual zeros&quot;<br>fal=
locate -l 1m $img<br>echo -e &#39;qemu-io none0 &quot;write -P 0 0 1m&quot;=
\nquit&#39; | $qemu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=
=3D$img,format=3Draw &gt;/dev/null<br>du -sh $img<br><br>echo<br>echo &quot=
;discard=3Doff - write zeroes unmap&quot;<br>fallocate -l 1m $img<br>echo -=
e &#39;qemu-io none0 &quot;write -zu 0 1m&quot;\nquit&#39; | $qemu -monitor=
 stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,format=3Draw,discard=
=3Doff &gt;/dev/null<br>du -sh $img<br><br>echo<br>echo &quot;detect-zeros=
=3Don - write actual zeros&quot;<br>fallocate -l 1m $img<br>echo -e &#39;qe=
mu-io none0 &quot;write -P 0 0 1m&quot;\nquit&#39; | $qemu -monitor stdio \=
<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,format=3Draw,detect-zeroes=
=3Don &gt;/dev/null<br>du -sh $img<br><br>echo<br>echo &quot;detect-zeros=
=3Dunmap,discard=3Dunmap - write actual zeros&quot;<br>fallocate -l 1m $img=
<br>echo -e &#39;qemu-io none0 &quot;write -P 0 0 1m&quot;\nquit&#39; | =C2=
=A0$qemu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,for=
mat=3Draw,detect-zeroes=3Dunmap,discard=3Dunmap &gt;/dev/null<br>du -sh $im=
g<br><br>echo<br>echo &quot;discard=3Dunmap - write zeroes&quot;<br>falloca=
te -l 1m $img<br>echo -e &#39;qemu-io none0 &quot;write -z 0 1m&quot;\nquit=
&#39; | $qemu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$im=
g,format=3Draw,discard=3Dunmap &gt;/dev/null<br>du -sh $img<br><br>echo<br>=
echo &quot;discard=3Dunmap - write zeroes unmap&quot;<br>fallocate -l 1m $i=
mg<br>echo -e &#39;qemu-io none0 &quot;write -zu 0 1m&quot;\nquit&#39; | $q=
emu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,format=
=3Draw,discard=3Dunmap &gt;/dev/null<br>du -sh $img<br><br>rm $img<br><div>=
<br></div><div><br></div><div>Before this change:</div><div><br></div><div>=
$ cat before.out <br><br>defaults - write zeroes<br>1.0M	/tmp/test.raw<br><=
br>defaults - write zeroes unmap<br>0	/tmp/test.raw<br><br>defaults - write=
 actual zeros<br>1.0M	/tmp/test.raw<br><br>discard=3Doff - write zeroes unm=
ap<br>0	/tmp/test.raw<br><br>detect-zeros=3Don - write actual zeros<br>1.0M=
	/tmp/test.raw<br><br>detect-zeros=3Dunmap,discard=3Dunmap - write actual z=
eros<br>0	/tmp/test.raw<br><br>discard=3Dunmap - write zeroes<br>1.0M	/tmp/=
test.raw<br><br>discard=3Dunmap - write zeroes unmap<br>0	/tmp/test.raw<br>=
[nsoffer build (consider-discard-option)]$ <br><br></div><div><br></div><di=
v>After this change:</div><div><br></div><div>$ cat after.out <br><br>defau=
lts - write zeroes<br>1.0M	/tmp/test.raw<br><br>defaults - write zeroes unm=
ap<br>1.0M	/tmp/test.raw<br><br>defaults - write actual zeros<br>1.0M	/tmp/=
test.raw<br><br>discard=3Doff - write zeroes unmap<br>1.0M	/tmp/test.raw<br=
><br>detect-zeros=3Don - write actual zeros<br>1.0M	/tmp/test.raw<br><br>de=
tect-zeros=3Dunmap,discard=3Dunmap - write actual zeros<br>0	/tmp/test.raw<=
br><br>discard=3Dunmap - write zeroes<br>1.0M	/tmp/test.raw<br><br>discard=
=3Dunmap - write zeroes unmap<br>0	/tmp/test.raw<br></div><div><br></div></=
div><div><br></div><div>Differences:</div><div><br></div><div>$ diff -u bef=
ore.out after.out <br>--- before.out	2024-06-19 20:24:09.234083713 +0300<br=
>+++ after.out	2024-06-19 20:24:20.526165573 +0300<br>@@ -3,13 +3,13 @@<br>=
=C2=A01.0M	/tmp/test.raw<br>=C2=A0<br>=C2=A0defaults - write zeroes unmap<b=
r>-0	/tmp/test.raw<br>+1.0M	/tmp/test.raw<br>=C2=A0<br>=C2=A0defaults - wri=
te actual zeros<br>=C2=A01.0M	/tmp/test.raw<br>=C2=A0<br>=C2=A0discard=3Dof=
f - write zeroes unmap<br>-0	/tmp/test.raw<br>+1.0M	/tmp/test.raw<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, Jun 19, 2024 at 8:40=E2=80=AFPM Nir Soffer &lt;<a href=3D"mailto:ns=
offer@redhat.com">nsoffer@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">When opening an image with discard=3Dof=
f, we punch hole in the image when<br>
writing zeroes, making the image sparse. This breaks users that want to<br>
ensure that writes cannot fail with ENOSPACE by using fully allocated<br>
images.<br>
<br>
bdrv_co_pwrite_zeroes() correctly disable BDRV_REQ_MAY_UNMAP if we<br>
opened the child without discard=3Dunmap or discard=3Don. But we don&#39;t =
go<br>
through this function when accessing the top node. Move the check down<br>
to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.<br>
<br>
Issues:<br>
- We don&#39;t punch hole by default, so images are kept allocated. Before<=
br>
=C2=A0 this change we punched holes by default. I&#39;m not sure this is a =
good<br>
=C2=A0 change in behavior.<br>
- Need to run all block tests<br>
- Not sure that we have tests covering unmapping, we may need new tests<br>
- We may need new tests to cover this change<br>
<br>
Signed-off-by: Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com" target=
=3D"_blank">nsoffer@redhat.com</a>&gt;<br>
---<br>
<br>
Changes since v1:<br>
- Replace the incorrect has_discard change with the right fix<br>
<br>
v1 was here:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg0019=
8.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-block/2024-06/msg00198.html</a><br>
<br>
=C2=A0block/io.c | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/block/io.c b/block/io.c<br>
index 7217cf811b..301514c880 100644<br>
--- a/block/io.c<br>
+++ b/block/io.c<br>
@@ -1860,10 +1860,15 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int6=
4_t offset, int64_t bytes,<br>
=C2=A0 =C2=A0 =C2=A0/* By definition there is no user buffer so this flag d=
oesn&#39;t make sense */<br>
=C2=A0 =C2=A0 =C2=A0if (flags &amp; BDRV_REQ_REGISTERED_BUF) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* If opened with discard=3Doff we should never unmap. */<br=
>
+=C2=A0 =C2=A0 if (!(bs-&gt;open_flags &amp; BDRV_O_UNMAP)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags &amp;=3D ~BDRV_REQ_MAY_UNMAP;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Invalidate the cached block-status data range if thi=
s write overlaps */<br>
=C2=A0 =C2=A0 =C2=A0bdrv_bsc_invalidate_range(bs, offset, bytes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(alignment % bs-&gt;bl.request_alignment =3D=3D 0=
);<br>
=C2=A0 =C2=A0 =C2=A0head =3D offset % alignment;<br>
@@ -2313,14 +2318,10 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *c=
hild, int64_t offset,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0IO_CODE();<br>
=C2=A0 =C2=A0 =C2=A0trace_bdrv_co_pwrite_zeroes(child-&gt;bs, offset, bytes=
, flags);<br>
=C2=A0 =C2=A0 =C2=A0assert_bdrv_graph_readable();<br>
<br>
-=C2=A0 =C2=A0 if (!(child-&gt;bs-&gt;open_flags &amp; BDRV_O_UNMAP)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags &amp;=3D ~BDRV_REQ_MAY_UNMAP;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return bdrv_co_pwritev(child, offset, bytes, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BDRV_REQ_ZERO_WRITE | flags);<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000003e98d5061b41bdd6--


