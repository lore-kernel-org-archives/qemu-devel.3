Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hgL7rRjX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPak-0007FL-7z; Thu, 29 Oct 2026 08:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMPag-0007DS-Ib
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:50:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMPae-0003V4-Es
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:50:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1233871f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793278241; x=1793883041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d72OcSdNRsFw08tGF0RDqpbtQ6zhZgCv3XAaDygMJHg=;
 b=hgL7rRjX2eP4dvv2SQ5hPcGtiE2uKhzB9r1VyLGeru3QrlUi7/rftM4ZkO361+oyeQ
 52bMFj72r4bXwgHTZo1QyERgXIsx7l03t4nf5Y9k2sgYD1gpW+jOVz33dQeSA7VpPZmU
 vfDaOPPAMO2fepd8py/bT74UpXsofoRJzkFj5asdOJ/80E3NxE695hF/AqT0fh/ZOD+A
 6Rb3AQ0L8WhmGJl2IyN7Md7MVD4bxmg9FO6lWBaKOU3/lOfAnRJPbgluIQnVkFaYRYOY
 hnzP7UplhHZGYa2d2erG30d2iQllXdArIAk1teqx9N5PO9GkIka3T6d9v/wJoyylIadg
 Gzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793278241; x=1793883041;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d72OcSdNRsFw08tGF0RDqpbtQ6zhZgCv3XAaDygMJHg=;
 b=uDDGCvyO4hgoXX8apiX4x+BxD8VA16gNP1RrV/ZooPpEy7kTHDeP1hwt7AM5nNAe4o
 8YNUtv8bXpAlREHr3dR1Lg8TJK1h7uAX9/wKsiST6UZRcxZr3AwFaa/cKfvOTRW+maOs
 Ju8Ky83bupJiULp36dTo8aqhfWRk0px78euuU3GXj5EJtFVeR3gVwkexLrYKWFcyc3lA
 AX34jXEFgiPaF/wtRiWwbaBSGGfUOJkhoB/hnFPtffQAD922tEf0Wo/uaKr2l7p05IcT
 Ezw3DLedyoF/NoBHS03BBqDk+p0hdBWXI+yBRaCZvkOLjEtWdf8kwu8IcqsUfYGllXFh
 eYHw==
X-Gm-Message-State: AFq9FYJFiadj6YUHLl1cKtm5bhH2mTuG0+N72MybE2vdkRvTaiPwLCDI
 QuQWD5z5fUWZmtRNJqw+a+0335PoA7Ro7vOPCYDoVOANJdZQj7tOcLW0nURqjNgEWwc=
X-Gm-Gg: AYBFou39U15NRfth4jeKH75KcusUzNDVxO6pKxrBwQtx30K31d8bz0W0j/tRiBxu/l8
 iYsIQojpr+d44ACIHA+Pvz2BwCHpGpblQ5AxqM23xnOS13sAcTcvz3y6RyUe56hF7oWF+0DlV54
 1u0xX64MKUD35UZizjN0b56rg8OJUh6bEF2EWA5WJM+d/naInb5JjUUVR5vloDIfnzGa026dVs6
 U7oK5zPZyXCYdrljwsXMm7ccscyLbvvjiAr5OX0WUFed2/eRj75bJH0HBZixTI9Bynf19OP6IW1
 nr47ddxHlrC7NeGS/JFhLwBpInFNjvCQdqNaosOYiMz8lpT9asm6rCB2sMBF8vFGHcJNEZdWnP4
 TPxYDhSPM3pfywUq7oOpTGhR9ngWCckZtifapDkckX2iO+W7tZg+kxurKiqt3XoDx3myx93Nmoo
 Wq41AhQsvs2MBoGphwROiXRRVJgq4ww3I+bAUjFYKO2A2gc9W6WyPTi7D/ThdFRk4oQWtsW23tv
 sHGLrbn2o+9G5RdXyLqWbME7DqKDiUEX2Dvgt8w12yaixaye1BS+zcgaOFI3mYAfRMxxqRtYgJN
 oVsZTNVi/r7Uu5BhUm+N0F0GdNXt
X-Received: by 2002:a05:6000:2611:b0:48d:b650:69aa with SMTP id
 ffacd0b85a97d-48e5d5adf46mr14009173f8f.50.1793278241307; 
 Thu, 29 Oct 2026 05:50:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm33994621f8f.1.2026.10.29.05.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 05:50:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D20875F898;
 Thu, 29 Oct 2026 12:50:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, Ben Copeland <ben.copeland@linaro.org>
Subject: Re: QEMU Sashiko
In-Reply-To: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 (alistair@alistair23.me's message of "Thu, 29 Oct 2026 09:32:12
 +1000")
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 29 Oct 2026 12:50:39 +0000
Message-ID: <87ecd8acww.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alistair <alistair@alistair23.me> writes:

> Hey,
>
> Sashiko just merged initial support for QEMU [1].
>
> For those who don't know, Sashiko is a LLM powered review bot used for
> the Linux kernel. When people send patches to LKML Sashiko reviews the
> patches and responds to the mailing list with any issue that it finds.
>
> Like all LLM tools, it is both useful, but also verbose, prone to
> hallucinations and misses things (like humans do to though). The
> general consensus in the kernel community is that it's a useful and
> valuable tool.

Linaro has been experimenting with AI reviews as well with our
patchpilot tool. You can see an example of its output here:

  https://patchpilot.linaro.org/run/2749c6de82c1-2#stage=3Dreview=20=20

> Sashiko is just a Rust application and prompts, it doesn't include a
> LLM and you can use a range of different LLM backends.
>
> Google sponsors the development and runs a Linux instance. So you can
> see the hosted Linux instance here: https://sashiko.dev/ and it uses
> Gemini for the LLM which Google pays for. It seems like there is also a
> GCC one starting up.

I don't suppose anyone is interested in sponsoring the token cost? The
main reason we haven't deployed it beyond our engineers is the cost
implications. I assume the reason Google can afford to run it is a
vested interest in the kernel and owning their own inference
infrastructure.

> The cool thing about Sashiko though is you can run it locally as well,
> so you can use it to test your patches before sending them to LKML, as
> long as you have a LLM backend you can use.
>
> So, now that Sashiko also supports QEMU there are two exciting use
> cases:
>
> 1. Developers can run it locally to review their patches before sending
> them to the list. This can catch issues before sending patches
>
> 2. Maintainers can run an instance to review patches. How you set this
> up depends on the maintainer and how many tokens you have. Pointing it
> at the list directly and running it for all patches might be too much,
> but some combination of manually triggering it for certain patches
> seems to work well. The Settings.toml file can be setup based on what
> you want to do.

Be warned if you enable with an expensive model like Claude a moderate
patch review can very quickly add up to $20-$50 of tokens.=20

> The hope with this is to save maintainers time as Sashiko can catch
> issues without requiring much time from a maintainer.

It depends. Some times you end up reading quite a big wall of model
reasoning text and you end up none the wiser to what it actually found
wrong. On the other hand given engineers are expensive you don't need to
save much of their time to make the token cost worthwhile.

That said I personally feel one under explored area is using cheaper
models and a common code smells skill that could be useful in
identifying the obvious nits and mistakes that often come up in the
first pass review. That would leave maintainers free to spend more time
thinking about the actual logic and design of a patch.

If it was embedded in skills we could hopefully get contributors to run
reviews locally with their own agents before posting a series and
avoiding the normal RFC feedback of nits and fixes. It would be
effectively a slightly smarter checkpatch.

>
> QEMU support in Sashiko is very new, so it will take some tweaking to
> improve things, but it is at least a good starting place.
>
> 1:
> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e=
6c834d8176f70
>
> Alistair

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

