Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EE606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OEy6eupq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKM90-0007ja-N6; Fri, 23 Oct 2026 16:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xKM8t-0007ii-JO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:45:36 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xKM8q-0001VK-Ru
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:45:34 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so2108508eec.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792788331; cv=none;
 d=google.com; s=arc-20260327;
 b=YUJai4yM5OTIpjwmlvXeXrZfQzHbslEmxHJw4YWLMsDmE7grgL8aE0n8ayGzXg5KgK
 Da5xOom2xemkF4FU9DKHj9fhm9X51chXvLRGeR7Ao6eaCHZeR4NuQ+1/eEgkMo+ayacb
 cFfNg06dtQdSOC7VB1kzSg6JZ+E134DJ8pun4EeDQxcqPNT7DqrkCXubVNEvsjXYg114
 lyK64R/+5ObvNBMt50P/e9INH7SDAU/wOMM+hcbpRbRUbMDIPoN1hT8jBubEy4oMb8Py
 g4De9k9be3M4flIId2Bdshy9OINK3Y/Jh18brGOp6b+EB9bDQGJgJ4XyEkaB+SrMQqo+
 Il1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3wgv4a/torst+KqBEV6aXmXBAE8cRB+9LNTkry3U9CM=;
 fh=UBfF3zsm4+P0iLA0tb/s/OqZGFADWa2MmaEPU0B3dUE=;
 b=IDYca8ILExnhMp3T23l/KLXOt/0fcWSplYGHFbwZLNQz7OBxAp3WHORXPEYZ9mbO8s
 ASen3cZjd8D030i+qzuR26KADkBBTK0QTfdu85ORRNpKc6rXvE52QNHS2Rh1JxfEobfe
 j9lJW6eHFasqqEgWbonY0kqvVN4/MlC9gIV5+aLpPtFul0o8UWu/hKlq6bfkTVTDsUaC
 WreGOGWmyih5G8kv0MtJ875fXsNB8KB76lERbmwrBMpqsOoc9hHQSUi5L4veo2gMMo9k
 WyIvWW0MFTeJbhgGLceoxL/90vIjtdF/2pBRMj7doxrhs+ZRt0gdYuaD6lQwDHyiSmLl
 T6SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792788331; x=1793393131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3wgv4a/torst+KqBEV6aXmXBAE8cRB+9LNTkry3U9CM=;
 b=OEy6eupqsMzfcQ30DAAJHAe893OauStK4S677S588TvLbLaQ54ZVaSpOEc7Mu2RICx
 pKAsjyAk2SGULFbhX1GEtoWbw8WZsyWLgxF0mA0AbmzkWB4RJYRZb50rM6BdIrzjjnKS
 fEEOJ6e1mPrRnwmgXWGCHD3x/qxE8k6mFVr75geNhSR80NvCi33KgbL5nm4gdQgqHjai
 l1X6yZzEU80uy1CrauUdJtJxQ3IJEK31uAjn7mIAcR9UUf/nDVRX3ry7gfy/tpaKi+J1
 Pw87RmxNnDXG8TA23hQf36UhG7f+F9bR/UtIOCHT90+P840qFy2asHSsCsNph6uPjbe8
 dWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792788331; x=1793393131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wgv4a/torst+KqBEV6aXmXBAE8cRB+9LNTkry3U9CM=;
 b=LhtbwSo7pB0D60HGAzVbCMqfPC6FhbXBXSOPtRKXXKsF8RgI7tagN3FtTYzp+NgWWI
 J/dUmS/T/QHVSLOVvKFsx5H1Fve2pnSGWAS5v8Hdrpo5dI+M2dbNGU3eDtlAg+izD5OO
 qdqra09NQQ4arSvZq9K9+Fuyp3FSF62S2h4Yk/kSppEVBx2dJa5+RINDMcR0hA84T7a7
 WS+KOC7NSq74+dGJMiNufBvrYd8pijeAu+5JxLJZTAzVEGOQJCuxtbphnqRwDu4QROFV
 9bT0xgEmoYOJxai0PjYEAl+GsZEgJRjfr1wCt1rkgXI9u3/CCjh7GTPiw4GNhV43QNOA
 EwtA==
X-Gm-Message-State: AFq9FYIxvEHE8Cjj5Dca3hsnB9aaJELu2u2CKCpYiHaCpJdObhOXClCK
 m+7vcUB+ZIGL5KWXVulSVjc2iQMxv0nFkSCbLEhjprn105CigBUdO82Q0eqU/4POWCL5buCsZxU
 nLG6rmDr8cF9cEYHsJ1inJ4vBPQo1DK0=
X-Gm-Gg: AYBFou1vseKpbzhQI/7nlB/2n1JK7S2eKTBRNPyj4F0okoGYwyzBHqcJ9WX2he233mF
 3BcMj4KfqSFc7e+H+xZxJY25udL83TSV3VmSkDxroizoZ+MSV2EjtntXfJIez3YR2uCmeglHE1D
 /g5v4TjZp2ozQmwsdDtJFn+OQGuY9iQBowKfnQE3xPsw6QlI+TQhMUCOqQceg5IFjD3al3Cn5Di
 Ng2Mu+dcvO0lrW6RXD/jF8qyJvRYXzATZMZ7uXTbALZiq4RcLeNVkzw7mqHZv1pEQNhNHqOCtVP
 1DStjDOAI+tHwon9nif610bw14JrR20vfmHT5GBpthB/YoRK9qThI9EvkGjwB15HNSZMrhtn9hE
 9+2OvV955BzURG4PmIUgT2ozqu/PHJvIsH7KtgOQm1s3g568RpR6F7xlR9vbJrMD5zKfB
X-Received: by 2002:a05:693c:2804:b0:368:40c6:3a01 with SMTP id
 5a478bee46e88-369e8362dcbmr586622eec.2.1792788330921; Fri, 23 Oct 2026
 13:45:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-11-7ad902b9a7cf@redhat.com>
 <atqdgESEVhYYsz5e@gallifrey>
In-Reply-To: <atqdgESEVhYYsz5e@gallifrey>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 24 Oct 2026 00:45:18 +0400
X-Gm-Features: AclHuK_Ipiep31aDNKnrUUTrB3mz8eljqFakdlFzfUKaQf9-NiLk5TF7SMOnTC4
Message-ID: <CAJ+F1CJvkXiBLWrRvWOeG7+qBLOovsZ8xOhoBtxd26CVor=DgQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] target/i386: drop HMP $pc
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Oct 23, 2026 at 3:35=E2=80=AFAM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > The to be deprecated MonitorDef provided a synthetic $pc alias on
> > x86 (which begin as an $eip alias). Preserving it requires x86-specific
> > semantics (CPUClass::get_pc() omits the historical truncation).
> > Use $eip or $rip instead, adding $cs.base as required.
> >
> > It was never a documented feature, HMP is not a stable API, x86-only,
> > and the replacement ($rip/$eip + $cs.base) is arguably more correct.
> > Nobody asked for a deprecation window on ML either.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> <snip>
>
> > diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> > index a523dbb446ce..b3f8fd58612d 100644
> > --- a/tests/qtest/test-hmp.c
> > +++ b/tests/qtest/test-hmp.c
> > @@ -58,7 +58,6 @@ static const char *hmp_cmds[] =3D {
> >      "object_del mem1",
> >      "one-insn-per-tb on",
> >      "pmemsave 0 4096 \"/dev/null\"",
> > -    "p $pc + 8",
>
> That leaves us with no test of the 'p' command, and no test of reading
> a register.
> Given how much you're changing accessing the registers you
> should still have a basic test by the end.

The existing test doesn't really do much though, it just checks we
don't crash basically. I can try addressing this as a followup

>
> How does this test work on S390 where 'info registers' shows
> NIP but 'p $pc' works but 'p $nip' doesn't?

I assume you are talking about gdb, since $pc doesn't work with HMP-S390.

>
> I assume gdb also has some concept of a 'pc' at it's end?

GDB has extra synthetic pseudo-registers. We have a bunch in QEMU (and
this series add more). We can add extra as necessary. But $pc for x86
is currently ill-defined, so we decided to drop it earlier.

> Dave
>
>
> >      "qom-list /",
> >      "qom-set /machine initrd test",
> >      "qom-get /machine initrd",
> >
> > --
> > 2.56.0.116.g6de20f6092dc
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
>

