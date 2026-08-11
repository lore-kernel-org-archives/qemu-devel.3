Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB88C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrdJ-0007yc-Jw; Tue, 11 Aug 2026 14:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrdD-0007uh-3p; Tue, 11 Aug 2026 14:55:23 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrd5-0006w0-PJ; Tue, 11 Aug 2026 14:55:22 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5DCF31400074;
 Tue, 11 Aug 2026 14:55:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 14:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786474513; x=1786560913; bh=vhQoxLGt+oLkyO8rEIasdHXzQ/bCWntt
 L41he0TzBm0=; b=WCCbO9zf5zKMJsTzztnzkPX8eCZXmrefsYRHoUxkeS4Ebr2N
 HkNR45dYIgaUhA641CwtY91iPIvD7C/YATFATrZH+4S/FajyRWql2NjZT8hHbWDl
 /J5epC5mTubVz5cEM0PLiCAHuScTVjJmi7Y4DoIdXedT4LD+qLUByWFvstOZGczi
 5NkfDJr8IhOaC11Xt6RNOlIsd7Ayz6dbePAb9EnPmAqFoR+ekegqD5QZtQlpG+jt
 y3gT5kgd4+wH/b9QL/3OFm3+QnWA8k1FRPB7ItVq/NInsdrLVtasAWGbVC1s2WZE
 9sOa/nMdfC1kH6qGUFdjtZpArOQbBTlQ9KKSlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786474513; x=
 1786560913; bh=vhQoxLGt+oLkyO8rEIasdHXzQ/bCWnttL41he0TzBm0=; b=Y
 bNh26c6eA//iX8JyDDnvEhFTtGHpvw/diFRpxBwy9RZJ4vESp/TWGwGAhV7kNGsD
 SfpOlqBeS20YA+Nlp3oOLc/3QGoXch8cIpxpBdWDINSMMFcT9Lh08nX+Jye/GnIa
 h7rcsKj1YnFPi02r23NaJYbs3N64wXVwqYbfKY1n76BgO4mqjmshbWx0YcX7QsFE
 W2tz55jpDKGgJGKaKGYXk04+6EgHqhHeTSHeR0hXfjiX3yVVmwVq7h4JRxp9g5oK
 kaYyMlUhC7iuUZbd822/i67H2teWT1yN0a6GxQpv7VbtskJryJGMsW6vuw3rb6sR
 2z+oDPG2MsN7mzy+6VZ/Q==
X-ME-Sender: <xms:EHB7ak1OGmuridH21VoUpT4wrgVbp0cEPWtwJDdIk3d4iTnEgCIF3Q>
 <xme:EHB7aq9XbSges8aUFo1o7o2j0jDUP-_IIOBVuUk_y7jvDu6gV_Z35LT8BhuWEtkUE
 hBcuzwCUOCPhkbSUrqgFJ2DwfhfsHjja7MY1ynecY8May20jm1YdMg>
X-ME-Received: <xmr:EHB7ap6qdNqje-ruiuJwuLOM0hE8lYhb2Tl0nDXj6Rjv5hh4IPYqYDyAf-3U1d-8guc58g>
X-ME-Proxy-Cause: dmFkZTF7rlekoM20D+hW9PlrTtvLQon6Nu0GfMOx8d4Soz6WfdbAYxDMB5N6kxMQZtk8xK
 5+LrkOYEdk0NEctTsC6fSqSssv1X9sxH+HvdHrdZ1CXVjc+Xkhn6xEgEDOzvO606q0P9AI
 NhhwCqPXAXinwQmBngHbmxQr3uKf3eWWdme6Ypeh5ljpp91Zj7fpe0EOVXSTEeZ3gHI7U9
 3HUxSkBMCIxUZrJ4XrCvlMGEPfEDr2Tq1Z+51mLLMY3cZrLuFY6w6KA2XM/vtsTVegC7M/
 ZlSgTzhbiMDGxPDseWaojK0c+wjBm2g4Oo07tpxatFPaBYHJJSUVBggUwjXNEviwHTswA0
 /TdzGZpe4AgEAqzTnx9ge3YbY1QK43otE96NC9y5/vRfEwdJP8InPvy4cVdeycPKQFwCmG
 H1l7MRkuyClTiEpi2IanpYKcL9pLNiq7OXyhTFWfpQ/1MXnAIft1+uhk54pQeJ8MtkdR8Z
 ys1EAgBgurTGspwp8yxylIAL8RHUwLmxp6W9zmhp5cOZbCbkX4f/23iPqohjKtMQ5dxEXN
 eVlu8QBJqXX4dd1Udw3U5bnpdwzQWZ1owo2PiUl4JTWHY2yRMTm/78ZV2WAou8U1uxMBEE
 +Tu9EXD9u8FKGWD1LUcytf2MrGPo3NqOAVco8EiOqWHrOj0tSbx9L57IYYJQ
X-ME-Proxy: <xmx:EHB7aisE0N_vOUkZGSmVCfrMyq-BW_mtz95Vm0GQoRwVz8NICmvG7g>
 <xmx:EHB7ar2hRRnEL15Xe3HsqWpK5lwycS8ZtXrJOkMiDs73_vg2wdgwFw>
 <xmx:EHB7arro34SEAyem8JwqgOkUdykIxEJSu1lQ-uWH6Cm4V6VW5sJn-A>
 <xmx:EHB7arLJb9z9GOprE7o81NL4VfViaJ_ptaQuo81xHER0csvFQu-Myw>
 <xmx:EXB7alid77D-YRWFhZRTzQKE7bBV_cFU-YtVIOpdXRsMcv7qtf16btgh>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:55:12 -0400 (EDT)
Message-ID: <0f8b9bb9579fbfba978d3ae5854b15dc3a0a4f50.camel@alistair23.me>
Subject: Re: [PATCH v2] target/riscv: Fix memory leak in
 riscv_trigger_unrealize()
From: Alistair <alistair@alistair23.me>
To: Zeng Chi <zeng_chi911@163.com>, philmd@oss.qualcomm.com, 
 alistair.francis@wdc.com, chao.liu@processmission.com, 
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, palmer@dabbelt.com, 
 zhiwei_liu@linux.alibaba.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zengchi@kylinos.cn
Date: Wed, 12 Aug 2026 04:55:11 +1000
In-Reply-To: <20260724063927.3360599-1-zeng_chi911@163.com>
References: <9882f9e7-5c05-4a76-95f0-eb8ae8366f62@oss.qualcomm.com>
 <20260724063927.3360599-1-zeng_chi911@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Fri, 2026-07-24 at 14:39 +0800, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
>=20
> In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
> created in riscv_trigger_realize() using timer_new_ns().=C2=A0 However,
> unrealize only calls timer_del() to cancel them, but never frees the
> timer objects themselves. This results in a memory leak every time a
> CPU instance is unrealized (e.g., during hot-unplug or machine
> teardown).
>=20
> Fix it by replacing timer_del() with timer_free(), which internally
> cancels the timer and frees its memory.=C2=A0 The separate timer_del()
> call
> is no longer needed.
>=20
> Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger
> arrays")
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> =C2=A0target/riscv/tcg/debug.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 3c0fe70101..5ab29f6945 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -1080,7 +1080,7 @@ void riscv_trigger_unrealize(CPURISCVState
> *env)
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(env->cpu_watchpoint);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < env->num_triggers; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_del(env->itrigger_timer=
[i]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_free(env->itrigger_time=
r[i]);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(env->itrigger_timer);
> =C2=A0}

