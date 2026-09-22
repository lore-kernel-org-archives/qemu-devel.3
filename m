Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6A7C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8uko-0007BY-6r; Tue, 22 Sep 2026 03:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8ukj-0007B3-4Y
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 03:17:21 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8ukh-0000wr-F0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 03:17:20 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso53815235e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790061438; x=1790666238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LtpFaprIJbE5lud7P9rdRXmKqWACPbXQVY1+W2J+5eA=;
 b=oB49GdzN3c3xDeAbd0jqYwODW4LDX3j1DuDq9eXVSv3lFWWqs/33wet/QCkubnSUn1
 6TZfCX26leV4G5O6aSTLnWlGzNg3HY07etNELrVoVZ5n7y2iyz4qx1vY/CDDea+/7uj+
 9+Ru/LlM5RMqEkLUN0bDs4zslBE5H4ao6qnwo7rEQbqsZ59gjiNqCkaMJT7rLckEEeQ3
 rUK6Zp2mX9Pzws3+j+qzMioc8aiD+YIxzpMNDHCfXaSkrAjAnM8Y2Ty1CUEFe4t8NTXE
 5BbqN/mCCrxswyfc5ujkFORFhncxzTnXjfrhWZ4jPBR089dN2sdzNEMcrDZnnUuf0CZ8
 j5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790061438; x=1790666238;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LtpFaprIJbE5lud7P9rdRXmKqWACPbXQVY1+W2J+5eA=;
 b=Yb2zFJ3uwVDQJJlYvZds7wDvcyt2NyeQOu9Bv0mGvQuhb1C40IcIx8Nsu/7v5skB6n
 3GDKVQp3N+eemi32R01h/NkPPSC98dkpejxigA13Avoic1Fzv8KW5rE/vK5E+dbmNMy3
 JJGksFFf0n0MEUsZ/UX/qvPR2OOQ2KUi7aA4ifXlts/O0/t2gDptnOAy5nA14SOwlFGF
 NPetm/OMCsnuUIB+rfpwzP0KsQOFM7OxZeiCxlfdmD3eoHnQiMaAUWJSwG2o112z8xUP
 wWRxPGR3MLQdSXkH8OXJIoAD/YvKAF88LPBdTrV24TCVZQWXTdrx8JbSbPUHtF1P6xQ6
 fCnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQhRmm+CuK9rUZ6tIrdGvJnWaSDiyyirTnz1Y+zDviINeyYZovC+0QDeqFzeHlvZrwSrwchDzir+qB@nongnu.org
X-Gm-Message-State: AFuF++kYS+/hYyEBMrpq0EMuAVmBC/D6hCBLDPLSd4u2LzoT9VdwuX4e
 TK1PF89v/gIRdMNrYDxPyI/8jyugQPTvH0gfBDe9SeGIopnQL0jVvX8qlm1kj7SCJqE=
X-Gm-Gg: AYBFou2XP1LcNcdJ5APqpA1n5cdsGgdym/ImTGWYuKw0HsaZBHm8uDSknPd9JfYCBn6
 iCK7D7HGvpnLwee1QkKXif1LuJq5hr81Qy41IrBkPHcaZ6m9rbUzhODvVS06sE67Zl2IwBZtNzV
 5H4AAvSIyKQqkPEqATFzMHFsC6h/B2nnAkGqDZ+dUpJewiJapSeUV0bpG/yl+oPUBnFQvnLElEv
 9+gt+gksMeVQ/BGYTDxp40v7hNSoHplAzWi7D6lN0/O5esIQvcaAwgB7HkK2830K9KjxTWLoTLS
 BAZGZoFOKal4Z5RM+JmyqG2oVjsVKwMZ897k9Ohww1MXFQ1Hdo7vaopB/ZZWzVYQ4xaB5VayAQ6
 4W9MSAfH8nvqEJqpo2iouXyAxxLwWCchv6E9GAVFfCLaAlRWgI76+Dnx4iEBQHEtx5vMvB2lMK6
 FRsMMrK8WPZFGZASWHAnH8LCVtAvoIYnsop28lbaeeYn/AmpaI7BXTdgg41JODJiuqhpuqbA==
X-Received: by 2002:a05:600c:3b29:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49fc566e6e0mr181145125e9.5.1790061437562; 
 Tue, 22 Sep 2026 00:17:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862774882sm2812191f8f.13.2026.09.22.00.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 00:17:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A3C35F8F3;
 Tue, 22 Sep 2026 08:17:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Weiwei Li
 <liwei1518@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Chao
 Liu <chao.liu@processmission.com>,  Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,  Michael Ellerman
 <mpe@kernel.org>,  Portia Stephens <portias@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 08/12] tests/tcg/aarch64: Don't leak memory-sve CFLAGS
In-Reply-To: <20260827050953.67184-9-joel@jms.id.au> (Joel Stanley's message
 of "Thu, 27 Aug 2026 14:39:47 +0930")
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-9-joel@jms.id.au>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Tue, 22 Sep 2026 08:17:15 +0100
Message-ID: <8733v121s4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Joel Stanley <joel@jms.id.au> writes:

> The CFLAGS are added to prerequisites, so if memory-sve causes a build
> of printf.o and boot.o, they will be compiled with -march=3Darmv8.1-a+sve
> -O3, and the executables that link printf.o and boot.o after that will
> also get SVE instructions.
>
> https://www.gnu.org/software/make/manual/html_node/Suppressing-Inheritanc=
e.html
>
> By marking the rule 'private' printf.o and boot.o won't be built with
> SVE, which avoids SVE for other binaries, and is okay for the memory-sve
> case.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch6=
4/Makefile.softmmu-target
> index 3f30be6c5d63..196a2afa50ee 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -51,7 +51,7 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>  memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
>  	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
>=20=20
> -memory-sve: CFLAGS+=3D-DCHECK_UNALIGNED=3D1 -march=3Darmv8.1-a+sve -O3
> +memory-sve: private CFLAGS+=3D-DCHECK_UNALIGNED=3D1 -march=3Darmv8.1-a+s=
ve
> -O3

Good catch. You will need to port this to meson now it is merged though.

>=20=20
>  gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
>  	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

