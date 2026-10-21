Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA1606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mihalicyn.com header.i=@mihalicyn.com header.a=rsa-sha256 header.s=mihalicyn header.b=ICTVKv0Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYqL-0004HT-7i; Wed, 21 Oct 2026 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xJYqF-0004Gv-L1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:07:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xJYqD-0003eG-Kr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:07:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c3fd91337baso127479366b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792598819; cv=none;
 d=google.com; s=arc-20260327;
 b=kIhQUYBqfdXWvR4Amb7j9Yo2ns2cuB3oxOakTtwikExLC7zKILaL1Udiw5RhPMg3sg
 uOyr4lf+tvnkM+MTKmXPJUz5Z2/w7B5NM8z24Mw7yG0kkN6uGUNQr22r6N+osfTwKSrx
 H96nhF64gigcOMuzViSzsKSHlAz/a9gjKYgtqaV67hq6W/BX8brHz/6DRH+64VGcIWf0
 Zk2b4HOJR/QEDkMz2A+grpIFgK3TzmhzkqgOymO/Pe8elBcowWgVEqTqJLXq94dN/qzb
 2EvpdgpxIFg7piyzzlnuJ2nQazoQD+EXbPkg7yL9E5JpT3SiKW5ynAvi0uQVc77xfw6S
 LM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s3gDBPO/9Qpdd1DLQQtRw8dTJBa8J73lQQRdgqVZqHI=;
 fh=60IBsI5zbfb+SibUGK56atQTrZTwUy8nvU3u3pvtKEY=;
 b=UYG6ly7QkgWkvzURhz1TtI6+Vt6Ax/f2BMUqWPwuAWCviit34ws/Dvn6v0WGt+JS+5
 GgLYUisjNWilu0pNyh6ODWfEqylEKWwB/vwfncwaWIUZ0G7lcxM4q7hnBqmiBX2d1wLx
 iHWvEuCXkGppgjQ0lj2nH1Juc8H7qFDN+2ylSxTmkFDbOoAl0D73PqASLs2u+Z2c2KoZ
 odnx0I1NSnf62Hk1U0cvVRcM4kkCGdsOwT76lKWS+UwdCEP8TT6kwTE7w+2CoBmgwSRY
 /dSiFsp+HufDee2XNZwRWj5fYaKvTfU+macJdAp5noX2GH6dBv1fiz62O3RsamLpHG6g
 J1XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1792598819; x=1793203619; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s3gDBPO/9Qpdd1DLQQtRw8dTJBa8J73lQQRdgqVZqHI=;
 b=ICTVKv0YRy8T84VDdwS9anN2ACWwtnPyGeZE/uPswd6Iu+87wcvQb7uOig47uvHMjG
 vEUg39c/IOtZiPwJs+VdYYCD7O6qceKoPF+XN/Jnxhac7ETYpsbuKPkjKZFma0hJMYyi
 r2WvHVWxeJ/5jmvTdI7HZTAI+HumJF/rYhCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598819; x=1793203619;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s3gDBPO/9Qpdd1DLQQtRw8dTJBa8J73lQQRdgqVZqHI=;
 b=vOoFYE7U0KadsRVCm/YFQ2y9Swpay8FPOGcJ9FNaB+FgbYbm7IBKT6qdXWd1s8IYCj
 lfi7ia3OvFNqAfBmDLz6YBJLHJVorQSLKKh2y8TVJ7IR8UJuiviMOkDAOfX0TqTpeXvj
 9l6urnKbm0a74TqjlAH+JbcIuWPTMLPp2AjTm79PKozZLbD0LoDBNHHKj3WA30/JgeN/
 1Dc2AMIc1oUUZLpbt2wNhuJ5VXpBy6RaKqFlLWlKxxPNDgka89d05O7h5t3Ec+vwvL4K
 6HRRK+u0jagLvibXcUYotOAGvFHbeMutBxhXj0OfSVwutCVPngg4Q+YvRA21huTSH1PR
 Y2ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDZat8Z3ed8YonCGF4Q9Y4fgA7ks/tiiXBxrulXa4TZ30sss1KPwcvNhTSo2f+YY8aRgxMfVcj7q5r@nongnu.org
X-Gm-Message-State: AFq9FYKiMxgvJeKp31GP9fx2iFJG+bCgACDbnlYA7e04/pwu7siKbmY5
 4LbGoMBTBdZYz0nlKy/P5TbhY5SzUUzyxpTpOfYAuR9BfIHaNCo5viSPPc3hodo9sMz5vwMxNI4
 xV4Rdg1rX7JJL9Ez0wmA+GmIp+Mq+kfWs6SmWSgv5tg==
X-Gm-Gg: AYBFou2a9j73mfbWcNH9xPzlE5Yi8uP8kYAPIP/ZX2RPjED/gAc8ehv3o+wpbZw8OAn
 uxEsOljj4TLZYlufxn4iwW3atmKW4SHCEa8/4WJrjvbFUhDSO3F4kaYTlHUvVmgsA2JqDUmKC0w
 r052CawdPxRzixeIbFtYFaRiITBiNJaa3eBrG1C7csT5wtt2rbsOPGOOpWBX9ckLAY4myCWY2k/
 8JHD1nHD/TbseXZuUSAWcusSSnsKNppmXmTE8r/AUR6H3Io9zzWAKfvPlu4euunWBeBpKO9anmC
 JRtDImjJZjgLY7k1zLrkrDQJDLzN/Lq/joyEFUCYnrdh5pxAXpEztqNRgyEKTI7+GYVn3B7CQb/
 Le51F47S9JEh/P95wawLBX2keeHaSyG51mK4NQWOx618I/7GXTyaacgy98Cr0WqBcGHgM718CDb
 +aD15QpjnL3zeRxg==
X-Received: by 2002:a17:907:c22:b0:c34:83c0:b92b with SMTP id
 a640c23a62f3a-c46796819ccmr223946566b.23.1792598817948; Wed, 21 Oct 2026
 09:06:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
 <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 21 Oct 2026 18:06:46 +0200
X-Gm-Features: AclHuK8f618cHaN0zqlMuyWcDlFHm72y45jo5fiFjDdmmyOEAmv2EicSlJoWwHA
Message-ID: <CAJqdLrqxmTQeSUziBAtuhb94mVEjU1G_oEx1N1sLwKT3O=gDTA@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and pace
 nvme activity (HACK!)
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x635.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Mi., 14. Okt. 2026 um 22:51 Uhr schrieb Peter Xu <peterx@redhat.com>:
>
> On Wed, Oct 14, 2026 at 10:18:45AM +0200, Alexander Mikhalitsyn wrote:
> > > - for this test, should we remove snapshot=on but instead create an
> > >   explicit overlay that will be used on both src/dst qemu?
> >
> > This should solve the issue too, at the same time if test is R/O I'm
> > not sure if we really need this.
>

Dear Peter,

sorry for such a long delay with reply. Was busy plumbing some other stuff :-(

> Then.. maybe no need to bother. :)
>
> I think we should better remove snapshot=on no matter what, then whoever
> sends a patch add migration blocker for it won't fail this test.  Seems the
> /tmp mount is still needed then.

Yeah, if we really gonna make snapshot=on to be a migration blocker (which seems
like a clean way to protect users from doing weird stuff like I
accidentally did in my test :-D).

I need to look on the option you've earlier suggested with "explicit
overlay that will be used on both src/dst qemu".
I'll get back to you ;-)

Btw, does my fix with mounting tmpfs actually solves the problem for
you? I'm just curious,
because I wasn't able to reproduce the problem locally tho... And if
so, then probably we should
land this tmpfs-mount change for now, while we can prepare a better
and generic fix to get rid of snapshot=on,
add migration blocker for it and so on. WDYT?

>
> For speed control, IMHO it's not good setting bw either too high or too low
> (similar to downtime); too high means converging too fast, too low means it
> won't converge.  Maybe we can mimic what migration-test.c normally do in
> qtest?  that is, we do:
>
> - migrate_ensure_non_converge(),
> - allow a few rounds of migration precopy to happen (e.g. query-migrate
>   shows dirty-count >=2), then switch to,
> - migrate_ensure_converge().
>
> Then make it generic in migrate_vms().  I think it can be helpful too for
> future migration functional tests when it's not always idle?

yeah, sounds like a nice generic improvement. Let me try to look into this
and get back to you with some experimental/RFC patch for this.

But I guess this should be a separate from fixing this test, right?

Kind regards,
Alex

>
> Thanks,
>
> --
> Peter Xu
>

