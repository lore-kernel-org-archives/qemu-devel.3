Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19950606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=DfbV/qdW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UrLlql/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOOm8-000673-IQ; Tue, 03 Nov 2026 19:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xOOm7-00066o-1i
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:22:47 -0500
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xOOm4-0003Ie-Rb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 19:22:46 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EBC93140011E
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 19:22:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 19:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1793751762; x=1793838162; bh=QIRWLhhWb3iYxQfcmBc4wuukxhCxvqGz
 F4GlKuDwH/0=; b=DfbV/qdW7l3DxkjALexkcyWOquE/BCBMoU1KtxET9kUnGKs5
 cIxNaK/o5hgXz3d/hTxC2uUdN1pjlsaLhbWE768sQRti1kLWmfgPYEYKJk4ZOQLq
 qyD21w0dF/YfLxBEb1Ue8AKidOvUaLWTTtgYbTveA/30Atch7+zsB4zMzxAUb8bZ
 UiXMfVvxDTrldYyFrt/ikFbqjyQVdr4oNohqokm6m9k5JYXLNcGoHkjWB03bsM9R
 XR/V2V4lCwFv0jGSq/n/fTIGh8wcphDq9e/o9YLVeijnYy0i5lQ9WdidGfzxWOGH
 RMDoz+2NcLW9AfO3QLi2LPkzpNKKWoUyV5zpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793751762; x=
 1793838162; bh=QIRWLhhWb3iYxQfcmBc4wuukxhCxvqGzF4GlKuDwH/0=; b=U
 rLlql/gSxFahyyM951lluTwudF/1U5+f7ZPg3pLUBClro8L1OKRdeqvO3XQLBVaC
 kViyAhhwKvfzdKyAa+vTM9XVZDfvpXNCFwheLbdWmgGDZP7y31aVkspzGCyuZyP6
 CmKyOUNxRmL2hxEYK284QfVgU5vm3jLCnoMTPSQIKu+W04UsSRiK1Q0jCkxvNCKv
 wQDYfY6nNwcqOiWkc0cXZLKBrTSdEHuxl8AXCfx/1Q7gLLdXqx6/ZydIWAmppBqb
 ZUMQWWlxME+1EK1ZJ3V6jcejSjUqMeoqqOe2kvJ7KmBJPji2k9gv6bI8X8/lb69I
 WgWw50mo8xBXKkJZqSmrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793751762; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:kOM4gUUK0iN4C42/JWWBh/XODMWD2GYgXJOkS3qdP1bvGjk
 v4QzeRMxCLXFhYlqAwONPWCY2WERwKny7SxEiYjDmVMWR/4PSAnNLujVRTb9zJDj
 6R7z7uxFIQIRQcd/B42vlOAQdhnbp1krypnMoJffyDiNIs2nRXFZY39pA25sTCAA
 ocUN+y2pAAOy4KHLABTdDC3RhyCjFliQq45gPvGwrjM2xmlFayJrs9JoY2PCvjsj
 tzwah5MJGhZ2naGQ1udjIx2ml3ZjkjYEkAFCuHusBspPwEAnyTycCCdXLPu0NrVv
 BN9/6ZyrpCg0lwBAIkHDfza3H4paBmURkpZLlcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:C0z8m/DPRo9AMXLXr7bOs0zY46nf3GApaVRtvCsEeAo=:BVkFxZGlHd82jkKJqvgRf2Ie0mbfSkxjdZ3oOQ1TZ+8=;
X-ME-Sender: <xms:0nrqagb3VU3yVesnKhN09Z5c_cCsEyUgYmrt9dyGkg9kQ8i9sNlJUA>
 <xme:0nrqam3fp2VQXxkuSAhzhMhamMZYW15PUd7F7fHzhyt4LJ3hMufinMc3Nb0UpxgA8
 r_0Li79GdDxFTYjsHRnClfwCRypQfu5H4kKAwysuYzZdFqWfOgebN-T>
X-ME-Received: <xmr:0nrqaucinSEWVmYQ4aQtcrN8KNbeUoYpmw6OKcKC8AlMJNYVidH4EbveWaKkBvcNw28_NlD4A1Yx0I6Fq4WFqn7O0ws>
X-ME-Proxy-Cause: dmFkZTEEf/yQQ6QUh9FMQ+yxPWwsiSPzJueB90psY1qd+cdT+C+5Dt6+5d3TbK5YySLd7G
 dUmAIt4xW+6szeIv6bcigBkVkrPiYjJwEJ4W4S+EyM4ZmM5uh8aZPl05mr6uJsRdBASf/8
 ZNl8Au1wwbJ/fvUUJut7X0Gybkvi8ebIEQ5G+CCzU65Oj66VP1Wb7ngkGBulTci/Q74ZlN
 tm11KOUM5tOK1z+iOI75x/RmJm86KLpbcC8HwTLVDOWVMmgVR3NwdoINYyELpyjxNxmohm
 NPibAaJO1YOC5cc1RFQk4RTNo8x9+QvpaW5h+B8b+ZgtnVFyIHjcwYpJIR0Fx4Mvu/CDWH
 ZtkVdyusz9XyL7U1C3NT9QWV2wJm2DXV7PsUfIRPlZOXlgFUGUFwka6ZAgKXA7WGSuj4/M
 28Tz8RKeR/LYmMYeBQyvrQ44uhYiPvvyAZJM0HrbYkwPysQVkhqZvq0OD+wTws6AtSeFt7
 kmB/sChfQi2t4oT9TCaYJ272bGBR2SQJxD7pXhkkXf19tIp1v54APSuNW9mGFMlt+sy2Tc
 +GPtPQSYxKHoD/imnOIJ/7C+1p1fBPooBWBpW9j9juPHXAKu7Xy5lG3CNztSHM7ZVt12f2
 Xdyzg61LSFiAUQjXn0ZLMerB9PrNHdplFffwHKaQfC9eLNUbkWj6YKfbjnJg
X-ME-Proxy: <xmx:0nrqavFMZBdqE0m9GE4lCvOnB6UKLhGu_VHFiJklZNtJqEJtkvEs2A>
 <xmx:0nrqan3bE6LmIjSmnaw82V1YIaqNj7CxGI59jp8wDdYGzEeO1Yqh8Q>
 <xmx:0nrqannsgxz6iJd_guo_yR-urM_kBoxKtUxZ3vnTTtp9R0pzm2Xr4w>
 <xmx:0nrqan8iQs3l0B-5JrZ6ngtl9xq3nSLXX8zZNnT0t6h_6LAOh-SXTw>
 <xmx:0nrqat6za8B8eEublmDXsZncX9aY8zqi1yjQeSrtBg36KNi7uTKVfLRm>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 19:22:40 -0500 (EST)
Message-ID: <bda2ee49d8c37860b0665c7ef4b8bfa4b5272750.camel@alistair23.me>
Subject: Re: [PATCH 0/2] target/riscv: fix mtinst/htinst for G-stage faults
 on VS-stage A/D updates
From: Alistair <alistair@alistair23.me>
To: tewaro <tewaro@theorem.dev>, qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>, imaginos32@gmail.com
Date: Wed, 04 Nov 2026 10:22:38 +1000
In-Reply-To: <cover.1793677944.git.tewaro@theorem.dev>
References: <20260705140508.17692-1-imaginos32@gmail.com>
 <cover.1793677944.git.tewaro@theorem.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-02 at 23:29 -0800, tewaro wrote:
> Hi,
>=20
> This series is about the traps taken when the G-stage refuses one of
> the
> implicit accesses that VS-stage address translation makes. It follows
> up on
> commit 366b4fba0fae ("target/riscv: check G-stage write permission
> for
> VS-stage A/D updates"), which made the A/D write respect G-stage
> permission,
> and fixes what is still reported wrong on such a trap.
>=20
> Patch 2 adds a test, test-gstage-tinst (19 cases), master fails 8.
> Built for
> Spike's HTIF console instead of semihosting, all 19 cases pass on
> upstream
> Spike.
>=20
> Patch 1 fixes the read/write pseudoinstruction in mtinst/htinst
> (0x3000 or
> 0x3020) [1]. 366b4fba0fae sets the write bit when the trap cause is a
> store
> guest-page fault, but the cause is the original access type [2],
> while the
> pseudoinstruction describes the implicit access that failed:
>=20
> =C2=A0 original access, what failed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=
pike=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 master
> =C2=A0 load or fetch, A/D write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x3020=C2=A0=C2=A0=C2=A0=C2=A0 0x3000
> =C2=A0 store, A/D write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3020=C2=A0=
=C2=A0=C2=A0=C2=A0 0x3020
> =C2=A0 store, read of a non-leaf PTE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3000=
=C2=A0=C2=A0=C2=A0=C2=A0 0x3020
>=20
> The commit was checked against Spike for the store case, where both
> agree.
> Patch 1 fixes all 8 failures of test-gstage-tinst.
>=20
> Results on master (1c1f512972), with make check-tcg for riscv64-
> softmmu:
>=20
> =C2=A0 applied=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test-gstage-tins=
t=C2=A0=C2=A0 check-tcg
> =C2=A0 patch 2 only=C2=A0=C2=A0 8 of 19 fail=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 29/37
> =C2=A0 patches 1-2=C2=A0=C2=A0=C2=A0 all pass=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 37/37
>=20
> The test is last so that every commit passes check-tcg.
>=20
> This bug was found during formal verification of a sandbox on top of
> the xv6
> OS where tests passed on qemu but verification against Sail failed.
> Claude
> was used to diagnose the issue. All commits were human written.
>=20
> [1] Privileged ISA v1.12, 8.6.3, Table 8.12
> [2] Privileged ISA v1.12, 8.5.1 "Guest Physical Address Translation"
> https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
>=20
> tewaro (2):
> =C2=A0 target/riscv: report the write pseudoinstruction for a failed VS-
> stage
> =C2=A0=C2=A0=C2=A0 A/D update
> =C2=A0 tests/tcg/riscv64: test faults on implicit VS-stage page-table
> =C2=A0=C2=A0=C2=A0 accesses

Can you please use the `./scripts/get_maintainer.pl` script on your
patches to find the  complete list of email addresses to send this to

Alistair

>=20
> =C2=A0target/riscv/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> =C2=A0target/riscv/tcg/cpu_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0tests/tcg/riscv64/hyp-guest.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 110 +++++++++++++++++++++
> =C2=A0tests/tcg/riscv64/hyp-guest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 71 ++++++++++++++
> =C2=A0tests/tcg/riscv64/system/meson.build=C2=A0 |=C2=A0 77 +++++++++++++=
++
> =C2=A0tests/tcg/riscv64/test-gstage-tinst.S | 135
> ++++++++++++++++++++++++++
> =C2=A06 files changed, 401 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tests/tcg/riscv64/hyp-guest.S
> =C2=A0create mode 100644 tests/tcg/riscv64/hyp-guest.h
> =C2=A0create mode 100644 tests/tcg/riscv64/test-gstage-tinst.S

