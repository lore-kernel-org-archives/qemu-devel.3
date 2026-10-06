Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC816CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5L-0006Ab-H9; Wed, 07 Oct 2026 04:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHtP-0007aF-Vt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:00:41 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1xEHtH-0006bJ-6k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:00:27 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 72F111D000F1
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 12:02:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 12:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302558; x=1791388958; bh=MgC1Xt9XFFFkiebHCYydmvPFVkwsyZgh
 5ubiBZEKcEg=; b=mnk6QgjsF7dM/4DjmKypaoHn4S1mJ5ffKkGfD0o/ZwaCSxbN
 YNaAEZdQsGZpNaFt3YTVLeMtDs/XhRdYHk8HuUw41fTAOhhwzbUEQUwsdkgCzcLY
 jJVxRvh3o5bgrWgMs1VffIgJhApXRcPX1MbO4uNP9/+naEUKDKVPJOX/ePsW49Gl
 SEByh/uLQeL/YIgOmuodGbu0BNylNPtlj1UNM4K2eJuhVt1JtRZdSBo5dPTPzS1o
 Ueyq0HZUG3GORdY1a3c4C7yV+2Jzjw4NufG+PCJSwrmE1pPPZzFh2CQY5PB508y+
 C4S4M2FhOa+y/IJ5TbHQ06gRpCzgOs4Uqb2ABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302558; x=
 1791388958; bh=MgC1Xt9XFFFkiebHCYydmvPFVkwsyZgh5ubiBZEKcEg=; b=E
 6UkkSUaiX6atAlJ+24ypO6qVgOMXLUxbxH1d6OIUejIs6Uf5rvdbY+9inYhpFn31
 BYTq454w8ZoQGN6NtS1DDLfoZOUUavrC7YAxEsj4jTRpZQiTmaFput05nX6cq8fg
 IcQBXWcaBpdKFN4EJKaTi5Bkm3ZwVyQER7SUQA9neYfF423tfgV5jhXUSU5yb2bu
 KmKIF/UoIHt1MuVyxUlaaArJcdbpimJd1q4kVCVeU7orA+w1sOsZbLEdfwSn74AP
 bq9K3YkobsE7bqJPTpsGydA02vFDF0eHgXMARqMC9Ijto1Ck1MRKrVn8Kry1Gg08
 83C+EQnYa2uAp6jWjD3cA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302558; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:sQFxRi769L20F6ZJNstWI/lzSQI9NURZJq2YH0o3lHs4j1z
 oyhFpA2oFDFHgAXbXcR95zwd1GEgckr9Kd6IONiUf6TQPvsEoy5VN587EZiceGDH
 ktvOmJkU6HOIRoR2Jmfqva9fVlb8zo0b2Zy+lg6pE48JyRp/CkXZ7gVhPw9GzNaP
 9VT/fWOP2Bb+mXNnSs4Law0QdBfWBOyK/IAP4Nn5mYKMYvpq7XNt2upxD1DzPEUO
 /jBgcqsnRUk5qZi68EUXOJenW203ksVNXUutmHyR0kYaD2/4XJ2jlOwf93HHUry7
 iVrEJ8htQ0sKBlL9KXyBg3M2WKgpugshioYfiAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:96+KaWRX584EOThj6hUpgidJ5fuKS7OStez5EpFkbpQ=:MgC1Xt9XFFFkiebHCYydmvPFVkwsyZgh5ubiBZEKcEg=;
X-ME-Sender: <xms:nhvFanCnIaFVPzb5__0g_P95m8dj0uBZQm0_fD7QlBteAARuSXSP_g>
 <xme:nhvFah3WmvB0jPdSSFXGACEXl8HzQtVTd7BpTk1jBIMvyUkyb7RJIlo3SznjMKdKj
 zsX0O_iv_axm_G6sOkQGH_Hk6rbNj2hXcNxIg6BevjXTmv7nbqAsWed>
X-ME-Received: <xmr:nhvFahvrm_KOJaBEpvMJ8Ed2NO5UAV9RuxRdQXcFMixp39j91WtlUqUVGZofvhl9OYPCqkYoP5i-S1AjMvwglOM>
X-ME-Proxy-Cause: dmFkZTFw1gHQeph3+U0iVbTgmpkrjOplMu53RIX24qMa8tkDrzBv3YyuWv8IG9k0OKI8bE
 Xlyb0GlafGiXlCnDW0OuAM649lnf1jSFTp4oz8WDdYOqVTpsTxiBavypRMvgPcJ98YfBds
 TeS3vFh19ee3iy7xsS10Tnnthg355PvqrqwC4OrM5Ul/s//p08j0oKyYxZCuw1HChSxnVV
 5fgGmBEovbQcqZ2r1Z3D1c1uM/wPap+evUgAEGdaFfC8ZJpZjfho9HaOLQPd4SZ1JXTqOP
 3TFkjN8RDiXqAUj82tJ68HAW2DnlgNl9GQcnCMb0G7ZB4M4PEWXrDx0JyMe6jaNz+AuAkI
 FvYYg4rw3bx4CArRd5OLs9IN+x+3As91KMGpvRgDvL1G8R6rzAbDUqIfUaaozb8o4COnnO
 kvSEwkCvP+srAXgcVYui8Q8mODqNeFO4/3tkVd9wFljmZg8iWmI3g1JsMzkUQtpOyTU0ZD
 hDl0vZ9G9pfHfI8/eG5P7nKb77kRg7V8MtmUIFIyPpYI2eq9oMY7I/zDfE7bdednYwIu8+
 Q54WbehcJnaMW/44rnhANW9rJ8Iw7s3Gxxjd3PrAglW8AmirGTFHmmJcjw9zSwcGg500aJ
 5rF0tylFiZsz4y6P8ve+mCuFhVRIzvLxWkjcQvwKmMb3yXUMgrh7NAMNlPTQ
X-ME-Proxy: <xmx:nhvFah5UUzrsUQZoq98iNJEAap0C29zCochmyL0mdKHIySEPeaZ1Lw>
 <xmx:nhvFaiLNM3euMifVyHXn-2cXrh22p7aZYv4jrggRLHPjFYyPdhDsmg>
 <xmx:nhvFah5nfcstoA7F6Jehdw60aHHR4tipboyRnDBBeNT6ZMBxBa7SCw>
 <xmx:nhvFalxXE82tmoS-_-dIhhDwIG1YsPhM7lnCiMCzXUMjJ80LZGT-LQ>
 <xmx:nhvFakW-chuY8ROKnaRDsGK3vk-OevE48Bfn0ztU02TcKck6f6xQjQTz>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 12:02:37 -0400 (EDT)
Message-ID: <ece1d936a974013f305b4b3c976316686b0fdfd3.camel@alistair23.me>
Subject: Re: [PATCH v2 16/23] target/riscv: Build MemOpIdx to vext_ldff
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 02:02:36 +1000
In-Reply-To: <20260821040404.268123-17-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 2026-08-20 at 21:03 -0700, Richard Henderson wrote:
> Use mmu data passed in with VDATA.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0target/riscv/tcg/vector_helper.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/tcg/vector_helper.c
> b/target/riscv/tcg/vector_helper.c
> index 9b0c3f70c2..98a0a5d025 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -711,7 +711,8 @@ vext_ldff(void *vd, void *v0, target_ulong base,
> CPURISCVState *env,
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t msize =3D nf * esz;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t vma =3D vext_vma(desc);
> =C2=A0=C2=A0=C2=A0=C2=A0 target_ulong addr, last, last_in_page, page_spli=
t, elems;
> -=C2=A0=C2=A0=C2=A0 int mmu_index =3D riscv_env_mmu_index(env, false);
> +=C2=A0=C2=A0=C2=A0 MemOpIdx oi =3D vext_oi(desc, log2_esz);
> +=C2=A0=C2=A0=C2=A0 int mmu_index =3D get_mmuidx(oi);
> =C2=A0=C2=A0=C2=A0=C2=A0 bool first_active;
> =C2=A0=C2=A0=C2=A0=C2=A0 int flags;
> =C2=A0=C2=A0=C2=A0=C2=A0 void *host;

