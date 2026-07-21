Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACF3C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFsg-00010o-2h; Tue, 21 Jul 2026 15:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wmFsf-00010V-1d; Tue, 21 Jul 2026 15:11:53 -0400
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wmFsd-0001Ti-8n; Tue, 21 Jul 2026 15:11:52 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.stl.internal (Postfix) with ESMTP id C4240130024B;
 Tue, 21 Jul 2026 15:11:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 21 Jul 2026 15:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1784661108; x=1784668308; bh=NO/Bf4Hy+riUTl2qe/TbgQ7CWxbCHlQJ
 5TwBNd0+lN8=; b=RNL1jnOKrhjM917Qf60Bnp0vytJub9B6oaKxWAAOTzNymNuU
 +ubRKVHZw2+HqRcQJWfanw0EQupJcmTkDOBa23Fqb9B6aa3FZIaipGSjo4AkIK9Y
 hBNx+k6f+p+9ieLcLVx5oZ2+DRdGqV500VmcvhBrNAOeEASzdlKC5eoA42K+PoIt
 0m1NBhNb+jlxQXtqfiTdqc4pkYnlryYsVv9GJ7srwEl7E7Lp40MBRnarjXhAg/Hb
 uAq/+SB/TmMWtoJkn1PmihS5EtVxh5rJQ6iMCN/ASGsHT04pUAMTzH5y+EQGD6/H
 l7wQ8CF92uxnfJgnp0rK52Qim9IPiGCzXMf8iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784661108; x=
 1784668308; bh=NO/Bf4Hy+riUTl2qe/TbgQ7CWxbCHlQJ5TwBNd0+lN8=; b=a
 O+FGUW+XfHKQxMtNuuSHrpbbpuddEhOJlKK6LheCH7tuWi+pH8hw9vENJJpbId2I
 D4SHvC1U08VxYfYNKHUSu1skbTCWJJg9R4k0pgX/QEC1tVy1o+dtCN8ybLF9bqgi
 Qmri8rJ3/boiPDDNafbTjWzZOtgPXGjowAV4pe5XpcU7oPoMwAdFAMqtnh5AWhNf
 XP7NBzJDU+WRvjmrp8C1vDMk5oOoxYm2H1qsDoQcJFm+j60r9B/x8lM7S7hlO/vP
 DN+MnY9OXo5y3peBPZG8HW1V+jYeQUCO7kr7BXoJvTxY1HigGAoTExePI6pfgIzq
 ZBT+ikdxNsvHTmlZeaHhQ==
X-ME-Sender: <xms:dMRfasWdwwZ7zM2aHhDTczo8SjLXQfHEhpWVJKxY-xMH3xEugZeQWw>
 <xme:dMRfahSZVHcahTqVEiDs4CMJBZpyuODGdQzDBTRlDQmbG6KpC6jNrCVm3lly5aFpO
 OXd07cJgtiWYjJ5HFvVQUn3cEtpuGiDc4bRtZlDN7htS7Wl-ph9Jw>
X-ME-Received: <xmr:dMRfaun5sY7qv34raHEoxKfTGuv1a3HL3gU0yZ6tnM4yfRv1C4ciBuW7mudh63MYggwPgRSMql5H0FR2KjiZnnLTWrqJ2rAOrsqO4TtwvTdkcClYZ8zq>
X-ME-Proxy-Cause: dmFkZTGDu7H/ySR8IrV9f0/NN4Nt1zS6GSOHhNpq6s+dLsH+eTaIhgfsq7Hlq6TR8mVXen
 +IY5HkfX2erXSZs3qi5dVJ+hpT3SzUm8HRPHRyMhcpDLDaW1aXZSF6sdsfzXzyFDpMfwm4
 JyzKki2h0hZQdaLvZ9bcNakoIvdcVH0BjSxctHZlmkH3XONi9D4DmnyyeBp30dgsCf5J+D
 hC1y9alDAOJ1jcXvmBjumzIr7nOplErO6CLmhJovxd3XcNsyQClAYtM3AvpkW13EUgkyx6
 YFIkoKrUvHhcw7TM5m6HeHnSLIiMhblD5EnvjyeuLzv1Jlzxe0YqQg1fwVETx7x+susxdr
 IK3EtuMZ8dp8QFZIPilINBOUu1IIYIMjeFUY+3AU6h2uRHXErTg0Ee+tZKxFWuZPnqJsse
 8Q17Q1AjsgN4Hpt8gYOSInT/ZjMdmNSvVtIkBqWOGxtHMAoKaM4AN8gG1LcS/iKcpSC6G2
 X+82RA0QKBSfyK0Y4avQAmgegF+DcJM9SAXeBElFUQonaAbNo3p/fzJtrVh9+lMxWymIMC
 y/8mIbVSX2BFGEkU5xgze0vP5oLVmITZ+NJQV6ZBiiRdzuJm/KCQZDlrueCuoK1W1E1qks
 iJtYRu3sqmBuESCN5JR0UMXtlolgjP0t10/ukNPdRtNEotMvcNrRZxvbPWiA
X-ME-Proxy: <xmx:dMRfav4daGsgEs6vH3alKYzeRWSXTLXmgiQ4-bUjWqcEFFGbzDIACg>
 <xmx:dMRfashUSaREn91mmrbFJ4Dj8VOMlDAOQOnn4GEbQQCqfndU6b_yAQ>
 <xmx:dMRfakHELfyy28rr-vzyNcicPhnv_uKLzX2RaeSTaQSOk5S5rtJ0ug>
 <xmx:dMRfaqSzR1vJCtuy-5VsLuNKjOBxo6FfuWJLAqmYuVHiYSoEr4zxgg>
 <xmx:dMRfaifHRYQ1_wr6ArCzs627ebxyQv4orDohrFIaD0SGtpjvEzKrYkN7>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:11:48 -0400 (EDT)
Message-ID: <28c36627407ccdfb548f4410dc2e798cb1c25bfd.camel@alistair23.me>
Subject: Re: riscv & qemu-stable (was: [PULL 0/4] riscv-to-apply queue)
From: Alistair <alistair@alistair23.me>
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis	
 <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, 
 "qemu-devel@nongnu.org"	 <qemu-devel@nongnu.org>, QEMU RISC-V TCG CPUs
 <qemu-riscv@nongnu.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, qemu-stable
 <qemu-stable@nongnu.org>
Date: Wed, 22 Jul 2026 05:11:47 +1000
In-Reply-To: <e375775e-9450-4725-b124-e5a6d3b50ac9@tls.msk.ru>
References: <20260714040758.28332-1-alistair.francis@wdc.com>
 <a6c5b847faea8793440e4e0aa7334e7b02b838b3.camel@wdc.com>
 <e375775e-9450-4725-b124-e5a6d3b50ac9@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.137;
 envelope-from=alistair@alistair23.me; helo=flow-b2-smtp.messagingengine.com
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

On Wed, 2026-07-15 at 15:30 +0300, Michael Tokarev wrote:
> On 7/14/26 07:19, Alistair Francis wrote:
> [..]
> > Assuming that we don't backport plugin fixes then nothing in this
> > PR
> > should be backported to stable.
>=20
> I was afraid you might feel uncomfortable, after recent my emails
> about qemu-stable in context of riscv.=C2=A0 But everything I'm trying
> to do are attempts to make things easier, not more complicated :)

Not at all!

I just feel guilty that you are picking up the slack and trying to make
things easier/clearer

> Maybe I wanted too much, asking if there's something for stable
> in every riscv pullreq in the past :)

I felt that was just because I was doing a bad job of indicating what
should be backproted.

>=20
> I learned about the riscv pull requests - everything with Fixes and
> Resolves should be picked up.=C2=A0 That's okay with me.=C2=A0 I think I'=
ll

That seems like a good starting place. I can CC qemu-stable on anything
else that stands out.

Do others not do something similar? Fixes and Resolves seems like the
perfect indicator for backporting.

> take it easier - pick things up for the most recent stable series
> (currently 11.0.x), and for older/LTS series, I'll take just what
> can be easily applied - to avoid losing everyone's time and patience
> in long discussions about what needs to be picked up and what should
> not.=C2=A0 As long as riscv don't have versioned machines in qemu, I
> assume it is a fast-moving target, so older qemu is not very relevant
> for it anymore (because besides fixes, older versions don't have many
> required features too, developed later), and there's no need to spend
> significant resources in that area.

That all seems reasonable to me. It's tricky as it is moving fast and
we have things like draft extensions, which makes more complex.

Alistair

>=20
> Hopefully this roadmap will work :)
>=20
> Thanks,
>=20
> /mjt

