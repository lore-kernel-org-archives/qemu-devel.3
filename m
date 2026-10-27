Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CE606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm2 header.b=AxCWX3BL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mnJB0EcQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLYhl-0008Fh-5K; Tue, 27 Oct 2026 00:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xLYhj-0008Ej-Hh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:22:31 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xLYhh-0004op-KO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 00:22:31 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 334DA7A00B5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 00:22:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 00:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1793074946; x=1793161346; bh=OofOTQ7qTFIxaUTnsJ+h/KG/gz9OmhEv
 9PYhW8EGmYs=; b=AxCWX3BLkyaUBLsJJ9WHV/vCVEQsQJt4dAUSR+wRN9hnPdgv
 9/omMIwhF6GsoUEVNFJmsQmWZxD+ejPKaA16/sP4LrMy61R8LMHVCGx8zN7AOvOJ
 /abaMR+8mPBCJFC2SYOfA+OLbxj+W2zGMID6ot2PxEiXNF6u+b5vvypjvGkkCVJt
 iikuht/hgyr/p+KVbjTyIvW+OVuL8IQ0eOltthZue2qsX35S0Kis7cZ/q0YTXbNu
 v8FNFWWoPH6iZHzoOs93QQh/1zFheJCnTs+lNd/6b3fTOXniS1VpDHPn95WIvWjp
 DQuzq7+kPRK/7wehWLOvPxQ9cqSIGo0vwFkS+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793074946; x=
 1793161346; bh=OofOTQ7qTFIxaUTnsJ+h/KG/gz9OmhEv9PYhW8EGmYs=; b=m
 nJB0EcQpZIcGg+MPfQ5pOIoPCXz5kBP12N4uE9yRFhUwvtwwKfjGOBUSVK69zCjz
 sj7lTI3hXLvjxy57CysHIH+5M6C9oCUYURrTF32bujpYBwAjSqKr+LUGkrCiDKiY
 mh/NvhyZwJM9u6HrG+SyKIBVcuEN4/nxivKXBW3VUWm8ZM26IdY69CXGbp1LXTSJ
 kkocBehEFYDLKwiI+hdPFrJcMPakxzRZt6ZxMAxfA133z8JhZd8nB2ctUt6N2taQ
 +x/ADJZ2OXAJMlxnpX1+0cHqDth77LQGMUowaU/77zDPYDgYR9vlHHxyV4nVQsfl
 ReIMlPE8d4U1ZEad/bW6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793074946; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:puXpnvRg0Kis0et1dFLmzkuxWw9N1k4OPQ/fVNObqMpb3BU
 QfNy5tpsfixWL3+tNTosB/VNYgkwtmnOnWvv7Lr/A9zTxw/ZoU7y4fMqyVScWFJz
 Q8v87yidAHZ91sdydqPuyiVqGm+yUb6qmbYjLMw+5oewkQA4UTVqegElt4OsNPml
 iYoJ6DgaCS2YFcuALa854wA6rlugmY4cksAIuTxfIdOgJPQ7TzqO7HLfhEkBnz2B
 xGrPtWcQeso+v2yYZ9+K/ZR0KHWop023hufIOWvQtvhtxsSsFxweWwnIRdc3Un5z
 K2Hp4YnmjQ4r7ijzhL+xGUm+QWzW2xr3aHJZ3bA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:byzuXXWh/QTTkrUVbw+8qK/9mmnoTMZSf8yROaQ2vYU=:OofOTQ7qTFIxaUTnsJ+h/KG/gz9OmhEv9PYhW8EGmYs=;
X-ME-Sender: <xms:AifgagJ9Vr-1T7j3V3wr7OmqxUxA-fAOqvby2Hqm6TI-EObp6DDToQ>
 <xme:AifgagSHjDAkE4DzlnnWTsQN7hZ8nIQ9uxhOWzgcXDF5W6oebcU8G7JJIjvhf0gsN
 59dzX9KqgRumeIGXkXWh17vmPMbw4smI5CKJopFSBJcghfpbaG3fyM>
X-ME-Received: <xmr:AifgaooepkriKE-Y5KhpYW6FEgNDLuOZxyN4HMSbSx-rU7kl73xdhXRZlelCucqs96Ceo_TAMozHd82162qxpFlIsHE>
X-ME-Proxy-Cause: dmFkZTGVFAHz3eHVRIsPvdT+amZVDCSg/VwFgGsZE7FjK951QP9S1ZvUNVhOywRoJ/0k8k
 P1CzVP73jaDEDdx8Ml6MjRSLw2W+93tLbUo5XIH7bJVv9SMTxN0ZR/v7ICAAvOhdpGUTF+
 Ptv8+hd35FuYr3pQfXlg43Eo2y8j/UZ9RxsPkRb/VanCRLQCZk9Cj5CMm8X3g4bfMIu665
 jiy+0zc3+LTJLaLS5dqpL58kBMgMUB7wXYvHmNMIgLbzlwBmhKC9QiP+AxDM9cLebfYHgX
 cEikMjEvkVXTFcuCqCb9Rs3+T71AtdOvzIlZPqEBU4B1iMZ6qrp7RLETghB8sCw4Jlc/fb
 X56M71OTFei2XvXTqEBfIKxzqfY11nwk69aR1tg3dfXZ6XxaAbZukH1iHNS3KdCRU4bDwW
 gxm5fO5vZbKO5za5RJ0sV8eOafgV5p+8LE2WD/OYLj1vUf+nZVHrZ9eLPjgKq7y27Searu
 qhdztCsS2DN7hKpKGLVFOubHMZeTPU4/tA2qSH5iLjNp15u2lNzhmNFrhZXX43luWhXABN
 +K49U381o+RsBnJBIS9fSraOlGTp00hGUw9hbinxg9JR8C6AFo5gSFSsXbE+KWSwcoNcXn
 JYQCPjvNzXJHWCbd+TbEscDfpzo0qAGW5z5SxB2i+RemtnUna067P0NJvAsQ
X-ME-Proxy: <xmx:Aifgalq9kT6RCdpt-FV8yZTvTa4YzrLkQnnhhDNdEzDdUHqzSC5sGg>
 <xmx:AifgaiOJDp2DxMWs4AckkVuQ0dEKc2tH_XNh3Z3Zme0n4kaZLzpbdA>
 <xmx:AifgauzjyY16rcaQrG_4ySHFAxKlV55k9TiO8GftpKJyI1Aifcoz9w>
 <xmx:AifgajtJjTT8j17g8e3Drnvp1S60QTS2GDOYJcjZziZh-4agto7rbg>
 <xmx:Aifgapbz1muyMWGYJGHTX8_CDaxRUx4g4gu7rx9Pyrlq-8qTGJIvSAVW>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 00:22:24 -0400 (EDT)
Message-ID: <aa17d5924ea39fb40ed6fc0ecaa1803daeb819da.camel@alistair23.me>
Subject: Re: [PATCH] hw/display/xlnx_dp: Make assertions clearer
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 27 Oct 2026 14:22:22 +1000
In-Reply-To: <20261026152409.2869104-1-peter.maydell@linaro.org>
References: <20261026152409.2869104-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-b1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 15:24 +0000, Peter Maydell wrote:
> The xlnx_dp code has some assertions in its read and write functions
> guarding the fallback "read from core_registers[]" codepath.=C2=A0 The
> array can't be overrun because of the defined size of the memory
> region, but the read assert is confusingly written and the write
> assert seems to be completely garbled.
>=20
> Replace both with a simple check against the size the array, which
> makes it clear that we're asserting that we won't overflow it.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4586
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/display/xlnx_dp.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 06594980292..ad6c4952065 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -812,10 +812,10 @@ static uint64_t xlnx_dp_read(void *opaque,
> hwaddr offset, unsigned size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(offset <=3D (0x3AC >> =
2));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset =3D=3D (0x3A8=
 >> 2) || offset =3D=3D (0x3AC >> 2)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D s->core_registers[DP_INT_MASK];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asser=
t(offset < ARRAY_SIZE(s->core_registers));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D s->core_registers[offset];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> @@ -986,7 +986,7 @@ static void xlnx_dp_write(void *opaque, hwaddr
> offset, uint64_t value,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xlnx_dp_update_irq(s);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(offset <=3D (0x504C >>=
 2));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(offset < ARRAY_SIZE(s-=
>core_registers));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->core_registers[offset=
] =3D value;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 }

