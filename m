Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D431FCCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIceH-00076U-5P; Sun, 18 Oct 2026 21:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIceB-000762-83
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:58:44 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIce9-0007dl-Ek
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:58:42 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 12F327A0190
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 21:58:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 18 Oct 2026 21:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792375119; x=1792461519; bh=9BhPMI9MMmLcJzZAap+ipvJSNsCSDzCT
 Q90D34CN4RI=; b=IVTBcJe5RVs6Vf9Fd2N9F+h+cQj7ddT+p50CmxOrUP1CGrqE
 DfBkDLSZyM4e8sPYeGyyktzfldi0RDi3Vt4H4zWol1lHmGR0f73DzLG0GyGsaZft
 quz7h7toTRSEi+a+iNF1JNgdEtruBfDbxO3iZYCf8ykwDOq7GsOwGD/YzfZCXz0g
 PVl03Fs0sRRAop6LyLT20JSsg1vPv5h4YthE7NNWlouxMzjyStKUinLh5/uVBBVj
 nGb6EqjH1CznszSudaeqKDlUra1BwqXCvKblujQ3mUu34MkzAkZMAqBUesfC1V4A
 8QdON8e2GOe3/uUgkhwAZQaM+L1oiOKeIcxPXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792375119; x=
 1792461519; bh=9BhPMI9MMmLcJzZAap+ipvJSNsCSDzCTQ90D34CN4RI=; b=p
 jfCLKLqTqmccK/oZDFZJ9I1rf5p1lZvqWJHid6A6ACuwVQ5CU2efH/cwybAn5AWU
 KOglnjzGLMxxv0Hlv+J7keducWkDdU5Ax9rCstXBSzRZa1AZFhGOlARMYF4VU/tn
 iMHI6ldK4mYUscYQlFk5Ifc7xZKA8/Jc5nS+LCr3CzSsEH5UzTc/+P67YN4O8uKG
 r9FNgyNsdzupEZ6YWB2bvT32nTCdV+u2srhABJqeOug8IVM9cFTVBrB/4OfyX4n2
 OJKoiEgV241PKD0NBTJ4I5i3uoNxBXOxXO+3vSfWMDXQXHCRaBaho8BTaF6jbWGH
 6HspGz51NrXldjs3FYUng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792375119; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:aAHtgGi8H5UBqDIMvN6MwqclIZfNmXP8a9ajqGJ4P7XIpX2
 FOByvkKyG+ci71cdMU3YaUpkaCJWOPtJaQI3qd9glCNjIZVEgrU7u+ReEByzMkAu
 kB/xUc4+Cp6okuCJ1TeDlVQ9bPcQV6Mu5SSCuhR1uhNHuiNhKEHQWt/OFDHVYRAd
 nn7WZDGQgj72oE4wce8d/I+lLnLByQVtDt0dM2lS+Q8n8vewupwy2Rh3syGU+f31
 0mvvJCyMV3AW5B5Zpw9FHJeGDnWITAYATDHFjiet6ks43uPMJ3HNCVhZxUiGYPAf
 T+TzDPWDHoA2nlg8JdiB/pqQ0PgPRKKIdxrE5mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:Kmj6j0ZpzAz8tB2sajVvTCV7B+13r7kkJnq4otycZis=:9BhPMI9MMmLcJzZAap+ipvJSNsCSDzCTQ90D34CN4RI=;
X-ME-Sender: <xms:T3nVaj4SWPgBCyPPvy1XKHSY_PPXe2B6GWnTxesyDGvJf5baZiE90A>
 <xme:T3nVah3SB3f3vPk-NVAQrzhVW1PvTJgGiYT0oCFPD7v3ZsaJHPmFJy9T9z7INSvmF
 EarYXbYAzdzMPUr5LS4MV7gxvSQFY8wGFKfTBbLz2xlG-wZqBLj0R2T>
X-ME-Received: <xmr:T3nVamDMD-Ru-ZdH4htWfTWYPXWFEo6aXrQhxEzpuC7fYZFrEwEY5wTfEl1yOKbgnSSGDYv_AacVr_lzOD6E5MCvX54>
X-ME-Proxy-Cause: dmFkZTFX4wfXwZC4MkPHf8AxAoVgacCPqVnRTej8apYP66ZQDBKoNh81irJvnAwNA0NUG9
 aq0nd9p5/NH9YaeXxDY0upwATpbQayswhkg6CyGmuq5t7PrExSHraRcwh9V5Irh8/RlJ8c
 XwweX9w0QO1X/2ZI9tPWpehthie1GKGfz508Tf7jVlgMMdyH3PPwLvfWG7rzcrlDuGp9bC
 Gq8dMwzj8PttkiAWGeUW/susYQsDVrCYWbKeXINRhwoh4WXUEf5bmA1CxiUPfJvDoSTMNk
 ahjEdN53Lo1z9Z3gWmxVY6RIaPktG+qqEgo7FkGvXvkTel7uxLwzxHlruzSlTseqNs+wif
 DoiFjemp5HANmZBf3aaXQorVx92s44AW8/KziplRP8KpxX1CIi/rLlQN4IY3JV2nMMf+jj
 6AP8nyyyE939Tzqy67I2lWlTJnMMw3qfTrp7esytdcqQOgryWUT2ECoCiZiiWbYiYB+eHt
 C3gitw7MQUpJW+hNfzfPhyv87t2rfOajrt9lSl9IS6luXe2FNdAV2Okc2exeDM6q61rhbQ
 U+CZMHXtwF4NAA2/WlS/ov/WqLEnz4SQZVL4REES7St+19CHwYhNTvZMbQgWaP/CNWgzgx
 3750eZNmI2I1JWASzX2RSqHhyhG/BN2bU5bhoSjRnpzuPTfi/DUZlSYpcTYQ
X-ME-Proxy: <xmx:T3nVakOGSezOBFyLT4wzdZnea1dNP97yTIWF0yxs7b2SG9tAGIu2cQ>
 <xmx:T3nVaja3ddJdpOkrfq_sNYfRWJGEkYDnALz67vIEMChKFuHDrKXYrA>
 <xmx:T3nVarv1bvxiIGQxSiEDUaGZ6mVm1V55_1m15Mg98SC4O_UT7lLI-g>
 <xmx:T3nVatNx3kRYvfEwx2Mnbi8TYdoQm34axuq6cdoG5Zp5xMEtdpM2WQ>
 <xmx:T3nVavFHeFK9RcV5cIaGT3tIQj6gAFc9Uhbog_XisQ_V1TV49auMnJdh>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 21:58:37 -0400 (EDT)
Message-ID: <552426ab7df22d5d01079818663d7844405a6990.camel@alistair23.me>
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
From: Alistair <alistair@alistair23.me>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, devel@lists.libvirt.org, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:58:35 +1000
In-Reply-To: <20261018230741.6560-1-philmd@oss.qualcomm.com>
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.158;
 envelope-from=alistair@alistair23.me; helo=fhigh-b7-smtp.messagingengine.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2026-10-19 at 01:07 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
> for the release v10.1.0. Remove the stale comment.
>=20
> Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU
> properties")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0docs/about/deprecated.rst | 24 ------------------------
> =C2=A01 file changed, 24 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ccbc4219497..368fa1b4ed3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -349,30 +349,6 @@ the addition of volatile memory support, it is
> now necessary to distinguish
> =C2=A0between persistent and volatile memory backends.=C2=A0 As such, mem=
dev is
> deprecated
> =C2=A0in favor of persistent-memdev.
> =C2=A0
> -
> -RISC-V CPU properties which start with capital 'Z' (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -All RISC-V CPU properties which start with capital 'Z' are being
> deprecated
> -starting in 8.2. The reason is that they were wrongly added with
> capital 'Z'
> -in the past. CPU properties were later added with lower-case names,
> which
> -is the format we want to use from now on.
> -
> -Users which try to use these deprecated properties will receive a
> warning
> -recommending to switch to their stable counterparts:
> -
> -- "Zifencei" should be replaced with "zifencei"
> -- "Zicsr" should be replaced with "zicsr"
> -- "Zihintntl" should be replaced with "zihintntl"
> -- "Zihintpause" should be replaced with "zihintpause"
> -- "Zawrs" should be replaced with "zawrs"
> -- "Zfa" should be replaced with "zfa"
> -- "Zfh" should be replaced with "zfh"
> -- "Zfhmin" should be replaced with "zfhmin"
> -- "Zve32f" should be replaced with "zve32f"
> -- "Zve64f" should be replaced with "zve64f"
> -- "Zve64d" should be replaced with "zve64d"
> -
> =C2=A0Block device options
> =C2=A0''''''''''''''''''''
> =C2=A0

