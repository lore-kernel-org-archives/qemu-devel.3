Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA39606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zoXHYiQa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVfxu-00020M-Jq; Mon, 23 Nov 2026 21:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVfxm-0001zt-Vk
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:08:55 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVfxk-0008V0-1l
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:08:53 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-3866a784546so5155477eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795486130; cv=none;
 d=google.com; s=arc-20260327;
 b=P458pO2EAl45CiRMNUfIj0yDCwc6S8lYS+dK0YizXBrZEa51OR9yOL0tLsy9fAnt7E
 q3Z8hoD3rUQLU14p9ZeBDJjaJF7W/4rpAo+4EScQajwF6pxQaSXwZKZCwjdP8sSWwJGO
 Y2dAIU2LM7w6QvILRTdbvwqFzcifRJzuUMer/keXtd0NjwfoGd/liCiWWsW8Y79zD1To
 o1mHfLxsQKS0iR+ms4lzbQJQTyuyajSN1dLBPOMOI8A1gEQRhB6oFatkw4iUIuD9GWhP
 2CgxfVF8nWzfFwKRvd38nX/EQcO+A3Xi/6VNoZXuCJC9d0WgTD73q3/pf7ynenb96L+3
 Ftcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n8hG7CsGqfNwRlMqiwg/g4JA5KkICzLZwvoSyawS6N8=;
 fh=TzEchGrxOLMsWekIlWLdvGlr4DTrL6dxKNyyE8xAFTs=;
 b=AhjaoYRf2YVZ5mj0zabHqxxjnlE3HwnkJvwDd+9eAtGskasNN1Or1Fhygbh2Tf5yMU
 ZWeotN3oIUM+E7oOf7lQDqXYNDd4B2oGQ//o6BBHRrv9DIgH5XsJHQY/oHnqLFCSW5eO
 QG7cNIwHueHNGTZUekiT+kah/wr+Nz9xT/9Qiy0wUMbYcqeD4P1arBmXkigmFG1g886G
 jKQN8gMLD5jTG1JNqdnE7qW6XXCpuA7xM9unbaNXngtUkwkJxf0RKM804ZLa+GOhCWzd
 a5lRzP38HSlfXc93FME0vMz9KECTxxkBm+IkUnwoMZe99oTzgTfHkgWYM0uFpMsYdfHB
 cbZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795486130; x=1796090930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n8hG7CsGqfNwRlMqiwg/g4JA5KkICzLZwvoSyawS6N8=;
 b=zoXHYiQaWALeSvTZnJlX49HWbtXbqITN1AnduI5286mFNq9MELgTt60SeqHRGP6Whh
 JcGiCnaXQy8izQNf4kfdpmhMvb1ea1G3nHeBIOLTRF1W+LNaDrAW2YH2FxP3UOWTLF8j
 WMMHZoyI8q/W4eFcwyKxnYolJjNXEwJ3m8UOTxaLjgpPpuytRSVS5+2UkRstJYwE8HOG
 07DxZfXKZlYMlUB5OgwsYFer8AMedoOWHB/0hDwo+PGfvlNQv221ommOxb6RghovVPTK
 tWTNWSK0CyzVqXqk+DqAsyqS3sTn2iOGgYG+hwh9Wtxp6gKEDPMfpIQDz08beoGXrj+e
 ydeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795486130; x=1796090930;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n8hG7CsGqfNwRlMqiwg/g4JA5KkICzLZwvoSyawS6N8=;
 b=ExcFFgRkn48mwiIh3U6kjzB/zkpeKSsiPHdkazlrUOmCOsd/KgF8M2gu6lAym8+i/R
 V3olRjoGiqjQF4AKMwO1l9I9bP9HQ+w8qqRK33eskJrHMJIJY32lMRDod9uxldLYNp1N
 vLbjcsQBLneBF36qxe6c2pxu+FFmwtdxoSLZs8Jkd8kU8oOCJmTplqUACO6n54qD7Cw6
 szL/oCqPMm6AztH3B4mB/I1XEQCuOSAyGx1TLBJ5/C6vJIXrV0bojqBU5s4M5Wue24Bi
 QkQaMy9B/0h/v+QXHUyeqCPGFOQLLCsN999D5DWtnjm+cawPqJmscozc5yfDv92AVMfw
 OArQ==
X-Gm-Message-State: APuU4Z8exbjnlwezGTeV2+mP22566WqH3pHvevfqEVMcnVitUc9ILKXc
 Flrk6i1NzlG2Cs4MHRY2AzKACbv+5XQM6wHXW73VfRrnva4/lqlC2gDiLjv++EkRtn2xOiwcyhG
 hQWaeevPLfph4U2VBqddKmjoHrIKsv/M=
X-Gm-Gg: AZFdTZfndurLbA35D4hwmTBJeGM+7H+kQQe628iHCn3j6kOStpV/WCRm/biUb1uxmrt
 PUg50iu5mxOcpNY8uiY0wnhKKoPHAInmSyD9rXpe+PDurXvbn0FcekdTFze+NmHJd2gLEdaKqzK
 nflKbtCp9qXjLaOSYWUHDA7TwhVrjrdiH2e6a6fkhUkJw35h+E+sBvj0BM4JLx0G3v/cjgcf3ny
 UY8sz3tOsQ2zYsDdJ0HpRbmalHPjPM1+ebX/p52MPSnHqB/mij2z4QKePYqrHGGuHY9wU/YV+YE
 tK9YFaZjRYzK1r/Qm7dCfnhyP3gW9jS7qooF1wFM8b1PBib8niM6NEp5AQXqjyAsfQyvd/YJ8ZW
 s+I1HhzOrKR7HB82Vd4xLJkAfvGpAp+8gt+iRdHnzaqJXTT0jtcClqAJdCu8DIwQi2pFuhg==
X-Received: by 2002:a05:7022:171c:b0:1b2:6d3f:6305 with SMTP id
 a92af1059eb24-1b5567b3487mr10699179c88.1.1795486129544; Mon, 23 Nov 2026
 18:08:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
 <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
 <20261116220906.GA145716@shajnocz.csb>
In-Reply-To: <20261116220906.GA145716@shajnocz.csb>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 23 Nov 2026 23:08:36 -0300
X-Gm-Features: Aa3M54rHN_szndXyUKfH3ZbQNTe9eOMUVt8o5uGrItbgFqIM6gggPRteKzJ-ntw
Message-ID: <CAENf94Jo8c4SFBBzgRQo6jAd0zwd1hP1sjOM=Gjj8Qi_BMUBaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/dmg-lzfse: reject short LZFSE decodes
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 oxsignal <awo@kakao.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=jcfaracco@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Em seg., 16 de nov. de 2026 =C3=A0s 19:09, Stefan Hajnoczi
<stefanha@redhat.com> escreveu:
>
> On Thu, Nov 12, 2026 at 12:33:56PM -0300, Julio Faracco wrote:
> > dmg_uncompress_lzfse_do() treated any non-zero lzfse_decode_buffer()
> > return as success. A crafted DMG can declare a larger chunk output size
> > than its LZFSE stream decodes to, leaking the unzeroed tail of
> > uncompressed_chunk to the guest as sector data -- a heap disclosure.
> >
> > lzfse_decode_buffer() returns the destination capacity both for an
> > exact-size and a too-small destination, so decode with one extra byte o=
f
> > capacity (allocated in dmg_open()): an exact stream returns avail_out, =
a
> > short or oversized one does not. Require out_size =3D=3D avail_out. Dec=
oding
> > in place also avoids a per-chunk g_malloc()/memcpy() of up to 64 MiB in
> > the read path.
> >
> > zlib and bzip2 chunk paths already enforce this; LZFSE did not.
> >
> > Fixes: CVE-2026-116483
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4662
> > Reported-by: oxsignal <awo@kakao.com>
> > Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> > ---
> >  block/dmg-lzfse.c | 27 +++++++++++++++++++--------
> >  block/dmg.c       |  8 +++++++-
> >  2 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
> > index 4ea0b9b20d..b1acd87135 100644
> > --- a/block/dmg-lzfse.c
> > +++ b/block/dmg-lzfse.c
> > @@ -33,16 +33,27 @@
> >  static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_i=
n,
> >                                     char *next_out, unsigned int avail_=
out)
> >  {
>
> The +1 approach could cause bugs in the future. block/dmg.h does not
> document that avail_out + 1 bytes may be written to next_out:
>
>   typedef int BdrvDmgUncompressFunc(char *next_in, unsigned int avail_in,
>                                     char *next_out, unsigned int avail_ou=
t);
>
> I would rather avoid the dangerous +1 even if it means oversized
> compressed inputs are not detected. So how about only checking that the
> return value from lzfse_decode_buffer() is out_size and returning -1 if
> it is smaller?

IIRC, the original idea was that. I think during the discussions we went
the wrong way. Since oversized streams do not cause uninitialized
heap leaks, checking (out_size < avail_out) is much cleaner and addresses
the issue safely IMHO.

>
> Stefan
>

I will also address Kevin's comment. "Truncated" is much clearer and avoids=
 any
confusion with the input stream. I have updated the terminology throughout
the commit message and comments, and clarified the destination sizing
rationale.

I will update everything in a V2.

