Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A1606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=KZMzW617;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=01ekFTaf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz0s-00075f-4X; Tue, 10 Nov 2026 22:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz0q-00074l-If
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:28:40 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz0p-0007kj-17
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:28:40 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 315CB1D00232
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:28:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 22:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794367717; x=1794454117; bh=fs2v43kuftd0FQiRDGeiKfPqzOb0gA+m
 iSMJcF0DqP8=; b=KZMzW617yL4mvFpsLoUeVKDecTkuh+0o+f1RYW6vMXGRYUvr
 B5xIEG6DjPxaQ4Laz9CEYsTLR0EXrh4YyzvzxKtDq+n6BmFVoYB3yVI26H3gZx+z
 7N/MCz9r0Skn11inU160Bu2wvjsWvZ6f7BiWEhwn96A7rivMvk1Djf9ydMBqNM1v
 yKXJeHXa/Bg0PCNRDUGCJG83dQYFkrjHEPVnk+zfJL5J8X61S+rD+Uvw7SaX2qBO
 ZygQ/ilDy3J/0GhokGdYxbdriM8QTl6WnzcsQzRCeyGszyLZD5XhzVlZd4OyGCh9
 IGFJzlZh99L3TcMAc+Bq/YlSXTCAFI+xNaWC/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794367717; x=
 1794454117; bh=fs2v43kuftd0FQiRDGeiKfPqzOb0gA+miSMJcF0DqP8=; b=0
 1ekFTafORQT2FK09GwhzLyW23NX6M0Xk3fM0L3qT3ktsydjiq6WIVR0+uy/DoWp4
 zrbS3/Rp0+PyQRLEFA5gdHu3Hv7Ro4nSSdaaKWpmYPRpGsP5mupi1iLhGT4UqMfL
 wuLuVkrYlck53RtDp1SXQrCXTfOBBEstTjBmCX5k2a3gwksaOW+yNdXD68BILyvN
 piObM0B4nVh7TjyClofmqRtfflqxyI+CPHviFUKCFwPNUDKMyXXSxjFvCzZU4CPs
 5mnBMlMXvCq7KLmAr4o36FlIpn8ruzx0yMtRBjqDNhUxY42gglxwTP0Gah9urY51
 VWd7zf6pRS0QyY+19q8mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794367717; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:gi1qVqAE62MT/qnCGPAdvrkSkFDv7bjuuzp30IZM8p9EW0Y
 kkC0Xq2EjGqt6ssmrQ1wBGNqC2RJmb9Y/ZDhtcg4Cwe/kPxn0XuJvifzyYrqP4a+
 AZCO7/aya3rATQ8+8ksWhPADE1MeSaS9iN7fjUM8/3eM06bTEDqaW8qoELp2HnIP
 HN+OUmRh5yo+IyFvE4YOCZkQ7PnO9YnyEZkOjnEMystzkKiCkMFkHuhS/EQlwHus
 3ftQA3ec2lKHiftIWX/vsM2NuA6WmJJVFBeRGityi7vVZiz5x4RJvSRqs2zcxSTx
 To1/OBaCa8eu1f/cBqIVdRaAgMdWZGBeElgZUIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:donFgEyraBnPKYzxItLpR4oUf3lj69F44wYMVvRGHTA=:fs2v43kuftd0FQiRDGeiKfPqzOb0gA+miSMJcF0DqP8=;
X-ME-Sender: <xms:5eDzaqhsDhsH1zXqTLCmrIqE9SlP5iXm3GEeF1nthJGqykzWbcMtFQ>
 <xme:5eDzalGT8KdaRX66KsUgwSkioiTOD0DUhkW8RiVHcuLDTmAg-pI2SSpm7yvEwzLcL
 ky9qDNfahpBNIwHZ3jYiShN2f7rGhPvMM54bCFvnD4r24AxYS0EMO4>
X-ME-Received: <xmr:5eDzah_bTybbc6DDMXIaJmEZkDTz1Pi3GfhDaGicl1ZSkwAj1eT16MZD-C3y3IvJnr1TlOB74r7ex6W5mLYZ_txw39U>
X-ME-Proxy-Cause: dmFkZTEa8c6FDBppr/q5ebq0aoIUN284cstTqPm3bmylL6ehN7YhdonrN2YQk4t5XfeIu4
 P4Y9nIRxY4COUBsfqjupCuZih5azBUMCC5Jf5wpoln+vnlnWqXyTs+lrd6bd+8Yl0t2LV8
 tPTCl5x5HKYTgtdS3PJOHcNNlqDpMun4EP1pcWwciQ4y5Rdx0HgcQ10+1Don/+DZZnm21U
 SnWrIQYaL9UQoB0iGyuyubnmzMFPMATt+/+HveXZNK826Nj7nr8ujvuXFqL7hhJyunqCfx
 eGYP36F4tyNoTjKHTaYNDLjzbkpi5YrDNwwq8mG/iAOjvQ3kjfVegoCXtjdrpJjtx71xjz
 hJyYD96Rs1OVQSN0mnuCL558FDG81a6ZIM+/OczR1cDrTFnxqwY6OwHimu2jVJ32S28uj+
 inB8euJAZVweVvH3htt5Mz6/3l25cm9KRDl9IqXdqpG7D9WMIRkuk6RQyhzDIxoiNuiqvB
 QpMLJUwTpTlOjEZR7tfD+mYDhUKi5x0EKnkBPelMrllXEE7W0/p1yr4EhDuYRxemm+egnx
 AmgzTZFfCguQG4OiiLY+h4v+HTXcclraXG9zh/rS17R/kNffC5op07RGGKnLi3go/5Ng7B
 jpc0o3Mmztz5/EnC6rVQs3rBXq4CYbV/0SwfJsqkFrbTABzjkVid4lsaEQuw
X-ME-Proxy: <xmx:5eDzakwh23-1QfR5d5uHLspH7Z9BbKUpjv1vu55GVzLn2wqAHyXCgw>
 <xmx:5eDzalMz1H2oGsty8VCF81cglFHSCw8ThhcUV-LkeyD0U9LlMbaukw>
 <xmx:5eDzah-K4_haI5B78WzNwg8ECG-3GLWrvle_vNWAlqdScw0YztWmXQ>
 <xmx:5eDzaq43zMX7akgWMW2FGCGCBbbDSX0Pz_Ei-lCBLXzEboC39_uZDA>
 <xmx:5eDzahFHuONlOiVuYUoKRNUW-tZN6uf11n0lGgUYkbde691rdmshjXxV>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 22:28:35 -0500 (EST)
Message-ID: <36d51effcc6ebfbcaf6d0134f7d4ff8956b75430.camel@alistair23.me>
Subject: Re: [PATCH 4/6] hw/dma/xilinx_axidma: Reset both channels on
 DMACR_RESET
From: Alistair <alistair@alistair23.me>
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell	
 <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>, Frank Chang
 <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Date: Wed, 11 Nov 2026 13:28:33 +1000
In-Reply-To: <20261015033733.35116-5-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
 <20261015033733.35116-5-jay.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=alistair@alistair23.me; helo=fout-b7-smtp.messagingengine.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-15 at 11:37 +0800, Jay Chang wrote:
> Spec says setting either MM2S_DMACR.Reset =3D 1 or
> S2MM_DMACR.Reset =3D 1 resets the entire AXI DMA engine.
>=20
> Also replace magic number '1' with DMACR_RUNSTOP for clarity.
>=20
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/dma/xilinx_axidma.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 6892d494c0..687b5080e0 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -554,10 +554,11 @@ static void axidma_writel(XilinxAXIDMA *d,
> struct Stream *s, hwaddr addr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[R_DMACR] =3D val=
ue;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (value & DMACR_RESET)=
 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strea=
m_reset(s);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strea=
m_reset(&d->streams[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strea=
m_reset(&d->streams[1]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((value & 1) && !stream_re=
setting(s)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((value & DMACR_RUNSTOP) &=
& !stream_resetting(s)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* Start processing.=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
s->regs[R_DMASR] &=3D ~DMASR_HALTED;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

