Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9BBC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB21P-0001OX-VQ; Sun, 27 Sep 2026 23:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xB21H-0001Nk-3z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:27:12 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xB21F-0004yw-Cz
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:27:10 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 3A03B1D00064;
 Sun, 27 Sep 2026 23:27:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sun, 27 Sep 2026 23:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1790566026; x=1790652426; bh=IqXMom0iDYyIV6KKsurBj8ZQTxTAlDtS
 DlD5I9th+MA=; b=GPWW7kZy9WU7wNdP5GQiP6jWYO/dGPOA5nRGzq2eUoINw4FN
 1xTyOpEL3FhJ2WrUlGxhhuTUKlRACLyR0S0gE1n/YyEMWBuOjUefMExcItJrIY8Q
 4ha53XHEGAd2Hsn9nyUCEir56ledekgN1QEg7G/Bfwp3mXpp/tY7Cqptr4pEEwIY
 dLKazoOIgdgbmzPchTkqMAke/U1UswSTWqxBJXLNCyrNBpLc2lx8w8aSw2G52Lhm
 i39LMRvz5wDMu5PiD1pKN9l9hQk6iei3cIW2UiFRMZzknQ9MTJ6/ACDUX/ZV0qQa
 7TcHvp/lLAVxBvBoKGgMaDjBDJ56gWiwd1MHVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790566026; x=
 1790652426; bh=IqXMom0iDYyIV6KKsurBj8ZQTxTAlDtSDlD5I9th+MA=; b=t
 kqJke2IHbGb1VKaB/VZ/LBXrgrOpSGxkMofaaoE3cz4sIXsTeCI1jiJPuuyJXAIK
 EO8hglLNc04RXPOw1Vn6fYX3vsE/hx93ZgLLrS5LZRWNM16Ieq/dUlVNS1LXB4Ad
 gP3ccJeUwQXVLAcLoIvtk2BoYxd4uJ8e/GE3Za00gvvFFXdxZ+FehOeKH/YJL6K3
 lW05o5hWgCfmkVhpeHwzHk34uNFPWa5JpQzD1lTUkwx9Fckgvz5ZQS2Ieh9vz9RD
 6ZdMW4PjLj9bp2E100BThydwoz0vbFJW2t26E/1XOMXLbQEIlWwQD05IbmV33XCB
 c69dOf+nvSsHwzeMb6FLQ==
X-ME-Sender: <xms:id65aotPCY6Is0xLMgsodmZhJYi6dewFHTpXjYasm0qdm1GJ6IgvpQ>
 <xme:id65amIuQUQryaGxVpjjfLnDwiis7DZbOMjnRpBSgWB30YIiPNXvLhBAuLDLi4DsE
 08SU9vgSGCBlUmklJjYgAmCwk12f896ZHlqZMSYENuaejt_ljPKpm5E>
X-ME-Received: <xmr:id65ah-geaXeCKynmBGBXnFh004XMivPO197vfKD4Y4AdooeOYf9F6KdyTlJow3TdZ8DkmrAsm5XG7PvYhxS3bd_hnc>
X-ME-Proxy-Cause: dmFkZTFnx+GzeknM+4CmBe8J+0eYmUUUISEGEvEDyZbBOaVC1wQbGJknVys/TFYcp/CnNT
 sweuP7KV2zWeWZ2t5B4w7buZiiXJmtwg6oUMm1jGJkM7jMdTlqpz8Tiis75qb+OVPIG/D+
 l8H1Jq0BEDNwIVOWUulPJTuQOUeMqgQlD2fpeUeTuDo9cL3O0H3GRyLn/QLNuNI78FkdM8
 OaERM6iLDCYa9oROzNqPIceo0f6ZWP1upXdcvgs4fSfQixhOZlgLv/9tEkJUYROeKs0KzE
 dEeVmC3DJCJZoeqqIR7QL82chXhMvvT5hdP+8qA53I8LIrLG4wbV4AjhCfGoGumcxCjOI3
 MtClKRd0S2h0Rcr3iKpTvBCqCGdsujxKGnH81QYGuGjcws3f+Y0zsEFqXuLApeGCceW5ny
 /hwvgcb4hl+bgxEizp/IM08FlOJd9cn1ARPQwfXLJokqgjU1QSJr4GbSi/WqCHU0qvZIB9
 lWkA+0hkEWNHfTUanILby2lfjf3xplNpTZFbuu5KxMKU5GiJ5Sp0XNGg/IulhKzJprIUdw
 2teQTGb4qV0j4hlqAIgk6WVsZ83Sf8/Ypfsr1F4c/iCSyrBMvjrIau4t2ASFZQMNlFCntQ
 PL8TaE+HpNwozzJh7hC9mUhmZCJsS2UHhtIyrseDD8XOzsnWV7WkVdMnVgeg
X-ME-Proxy: <xmx:id65avxmhosNtCpGROTNNspWDJSkSSpYAHyAylk1vKy9ksz_SF0SlA>
 <xmx:id65au6c6hSkmBWZSQqStGa7pso0DvmvfIXhPErUJSpCm0eOI9V9xg>
 <xmx:id65am-gs04DYD0yFVBH-qIH8jhk05dLV7FJCekXSoFuny8gBlcUhA>
 <xmx:id65ajrHf6Am0ooVELFQfwKgQu6wLVdGtGXavigRkDWwjpp5D-6aIA>
 <xmx:it65avbo5Nqtbm38VR0evwI769aPWMn0uVRVa7Vcepqe6pfLEw8FflQg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 23:27:02 -0400 (EDT)
Message-ID: <fa0a483457c6fe97dddb1c671065dbc9583473e5.camel@alistair23.me>
Subject: Re: [PATCH 3/3] linux-user/riscv: copy the executable's e_flags
 into core dumps
From: Alistair <alistair@alistair23.me>
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@oss.qualcomm.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Date: Mon, 28 Sep 2026 13:27:00 +1000
In-Reply-To: <20260926040812.725493-3-mattst88@gmail.com>
References: <20260926040812.725493-1-mattst88@gmail.com>
 <20260926040812.725493-3-mattst88@gmail.com>
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

On Sat, 2026-09-26 at 00:08 -0400, Matt Turner wrote:
> Since commit 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags
> for core dumps"), Linux writes the main executable's e_flags into
> RISC-V
> core files, so debuggers can see the float ABI and RVC. QEMU wrote 0.

You are missing a Signed-off-by line

Alistair

> ---
> =C2=A0linux-user/riscv/target_elf.h | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git ./linux-user/riscv/target_elf.h ./linux-
> user/riscv/target_elf.h
> index 185b81a2db..e99a9d92ca 100644
> --- ./linux-user/riscv/target_elf.h
> +++ ./linux-user/riscv/target_elf.h
> @@ -21,6 +21,9 @@
> =C2=A0#define HAVE_ELF_HWCAP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1
> =C2=A0#define HAVE_ELF_CORE_DUMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> =C2=A0
> +/* See linux kernel: ARCH_HAS_ELF_CORE_EFLAGS.=C2=A0 */
> +#define elf_core_eflags(info)=C2=A0=C2=A0 ((info)->elf_flags)
> +
> =C2=A0/* Mirrors struct user_regs_struct: pc followed by x1 (ra) .. x31
> (t6). */
> =C2=A0typedef struct target_elf_gregset_t {
> =C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong pc;

