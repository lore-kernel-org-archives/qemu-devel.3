Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BFC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsoS-0002U3-3M; Tue, 11 Aug 2026 16:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsoQ-0002T6-R6; Tue, 11 Aug 2026 16:11:02 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsoP-0002Nf-6I; Tue, 11 Aug 2026 16:11:02 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 73C87EC01C6;
 Tue, 11 Aug 2026 16:11:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 11 Aug 2026 16:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479060; x=1786565460; bh=7lvFjcfKJVvWzuMYwCiWJ8fL1PLfqsg6
 0tdy/Ew/5V8=; b=sLbURbwwlNoNFa2xzQbOIs4C/t6xEpVNf1NZpd6Cp3CBjzuF
 ARQaZFU3hbgLEGWsQYBzL3ue2Ina2v3s3MizlBfT5FeVAP4gTdqRB1rOaOqZnMf4
 r+Qxfy4n+QyvUsGEFB5xEZo/QF/R74K1S6uxVlRWb51e/zfeeUySqHtUkIb+x3/6
 kXKh5F+8jXUwVtPguL0f2ktK773hb6r4FLWoDoL9kKNhJgYyK/H4mUhfCE3g//BC
 G8qxgB68iRqic/XYGgbOXTz3AvHqFoisjRfSxZ2yhN8IPeFHy2tAVj/vY9NDhwjD
 06D3edNbxohb7TW49Br0J8+WxRBi1RnusBcK0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479060; x=
 1786565460; bh=7lvFjcfKJVvWzuMYwCiWJ8fL1PLfqsg60tdy/Ew/5V8=; b=N
 k+vIX5R8/W97JZH+EM+gblawasLCHw0Sh5lYhA0kptZBwil2Tv6dEZT/MyShMxao
 Xect20qNFSriT82EW75UUzxCsJitmOuX2qZYfV2n4dniPIgget7u0CsCFnAAHu6n
 bpaFB0IThnVtRYJYWXD4+/66yLPTrpvwINbY+xyM2yQMAUpalxdOpg9vLWVa0JPk
 OQTaKAbCFujlE5ttdZrwC1ZUUZl6jC1oFYRcG3Ssf3EgiB28Qtnhl0KwpVc84rop
 PTswNZyXai4Ii0LC8dATMEv7EmMwcBi0e35u1SlgO2R2DqjHZWUDhStCCEa94CZw
 bog18jwqpUj6Ue6Wbe9sA==
X-ME-Sender: <xms:1IF7aoXDbvLsEyKar-wwjf222wzJpAuqWHsWiHnCdN_Q4mYvWKfqag>
 <xme:1IF7ag6pBu-Sl9lK7HNSnoxtHdAnLd-73L6Hd7WN6iq3l3O4GIKhdkAEOYRKWRhu_
 OpbwtdCRdWkMbIf0kSzxwO_GeVNeiP-mxtsuEU8ZpBh0SQKT_Fmag>
X-ME-Received: <xmr:1IF7arhBNZpLJ9tgqZEjOjN4rdB8JerdsySCA7AGZSs6hm0jNWEYhj4NBRGUNrNHtZ0qWg>
X-ME-Proxy-Cause: dmFkZTGbz+5+BUm/EQ9W04qwYS0G/9XQKtkFe0bYdk+Orf7h/WKyqLlJpQuyuz5WsYsnLa
 vQf1tYJ96Ycx6dn/I5csxpoJzPux0isPGvZx7lG+IszruPHywOEk6XeMYz8tfWBYH8SVHX
 kIXgq4suAyLHzSmJki6BKpSHDXDVvZDPXdvrgsNY0BN7RSRjXX6O9ZaNETYrditjmKYHZ2
 crA9LwMW04A32jEdrWJwt54je3x+PSSaNoX99Sj/NU/QJAn7CPYH8nINOYU7aBrFac2S9b
 nBgtVMhlOUraOgio3yInr5zxep/PnbXe9MBQbQ13/qZcHsWMQ8xXKz5/o6rovSHZ6xgrZs
 8UKPMzX2WMCx6G3Vi3Q9elNcG8yWTEBys0vV6LFYJWLAWO4txvesuCEDH5mHv3QIIkDL7Z
 VZD6dqgnq87P8TYmhoJqJi5ipIbQp5sqF7AX1Q59vmJTuIs2pyZbJ3l/Qj0Mu/Soe0GKAo
 y6JhEF7t0xqWGREFoooPy4dMVMfW4bNn9zUDsQx8v+OsuwYzVImcPe74ptB970HY0u+brP
 0K/LYTQM8nGs8sTauknMNOh+oubR9ik9BmNfj9iOSJ4++Bip9NleiKcrJt7LMLJLeRXfP1
 wlyCsAPJw9T+6zhs9Y4i5NKI5Ade9Hs3/1/9nkBQie6q+3s9Tf4yGqgzgGfA
X-ME-Proxy: <xmx:1IF7avdCKlmfwfEy_95ozDm9tnXLLWA6ud4hu3n1nL6pyd7031hmyg>
 <xmx:1IF7aod1WhEzGPkYOHGtKnjDte-Lcemk2KHg8BJHLSZGL3lo8qH7IQ>
 <xmx:1IF7ah_YWfynHAR6p8g6Nts9dUYgF5a3pO68dG1RzlAkUawg_cAwMw>
 <xmx:1IF7aslaYrPEP-B-7jkts9ZL5CLCIpgq21sxRxRnM-0jN2UHJtHIhg>
 <xmx:1IF7aq4yG61LPyw1n4MVv0rK2Fw9J_wdfbdEFi3koNCiyAwO41UJRR_X>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:10:59 -0400 (EDT)
Message-ID: <bc0015570acf003ab7543a2b42a52e653d265ae0.camel@alistair23.me>
Subject: Re: [PATCH 16/56] disas/riscv: Drop useless const in structures
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:10:59 +1000
In-Reply-To: <20260809223545.730664-17-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> Individual fields should not be const, only full structures.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index eabe193b4f..3325b7b4ef 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -174,19 +174,19 @@ typedef enum {
> =C2=A0/* structures */
> =C2=A0
> =C2=A0typedef struct {
> -=C2=A0=C2=A0=C2=A0 const int op;
> +=C2=A0=C2=A0=C2=A0 int op;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rvc_constraint *constraints;
> =C2=A0} rv_comp_data;
> =C2=A0
> =C2=A0typedef struct {
> -=C2=A0=C2=A0=C2=A0 const char * const name;
> -=C2=A0=C2=A0=C2=A0 const rv_codec codec;
> -=C2=A0=C2=A0=C2=A0 const char * const format;
> +=C2=A0=C2=A0=C2=A0 const char *name;
> +=C2=A0=C2=A0=C2=A0 rv_codec codec;
> +=C2=A0=C2=A0=C2=A0 const char *format;
> =C2=A0=C2=A0=C2=A0=C2=A0 const rv_comp_data *pseudo;
> -=C2=A0=C2=A0=C2=A0 const short decomp_rv32;
> -=C2=A0=C2=A0=C2=A0 const short decomp_rv64;
> -=C2=A0=C2=A0=C2=A0 const short decomp_rv128;
> -=C2=A0=C2=A0=C2=A0 const short decomp_data;
> +=C2=A0=C2=A0=C2=A0 short decomp_rv32;
> +=C2=A0=C2=A0=C2=A0 short decomp_rv64;
> +=C2=A0=C2=A0=C2=A0 short decomp_rv128;
> +=C2=A0=C2=A0=C2=A0 short decomp_data;
> =C2=A0} rv_opcode_data;
> =C2=A0
> =C2=A0typedef struct {

