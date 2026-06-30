Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10093C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wefs1-0004dO-TC; Tue, 30 Jun 2026 17:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wefry-0004cb-BA; Tue, 30 Jun 2026 17:19:51 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wefrv-0000Fe-Pr; Tue, 30 Jun 2026 17:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782854377; bh=C9JU5nYmpNBq44scWx9gShXAN2m+5opKU2KoGCuFvyk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=C3q0sUJtI4f6lWNvKiFQBRy2LiOhW32+GeF58gPg/j2tN0FuaYYAcjvIn489JTw85
 T/DYNk+XHCR5gjdrAeM1kGwJrQM1TVvjQEqStDJ/akSDmin7ndRW78VK8j9Y6nCVn5
 Or4L68qnbicQv8jrXZZO/fdzwIH9WZqtrfXHPyAo=
Received: from [192.168.1.10] ([220.166.214.112])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 4E289658; Wed, 01 Jul 2026 05:19:34 +0800
X-QQ-mid: xmsmtpt1782854374tr4hy914i
Message-ID: <tencent_7F27F8BD919DB95B3CC8499DAEC9227DCD0A@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahXtGvXkf7zacvMTstsgmVIedma5m3VoZIk8VjssiokL2UHbRQp9
 sLoX5Zi1LdrRbnxEN1b/ZSxezWvRG5HKZQ22UXX/qo/3EzxwXr/BGq0f6QQEdtH8FCNTSKNUG6L5
 SQLe46Ws67nfEMwGUI3mM1d0H7q1ShDzsTUi24rawJIqXsTREhkRwPWQpO7a44F1cWdbzz63AjIz
 IUQFkQlVWVGdJ3KxCwMCh1rJFRnZ7xfIdZI8+C50GiMl9eBieTXSBi7+Vy2oNnAb2zQ3NSsHIvzc
 6GIlTxjvlc2L9qvrTIAzzfn96r8BogMFYQbaZH/ZpRTSZKdMpzuQJUC8G43XEyHy815luyD1a1hR
 OP9tlzE2ofrBGGLn4bJV9hR7HZNneJxIpOPJxN4b53jAV2yaPmWTg5RyLfc2VZbk7x0E4wi2ZH03
 UJERW+cNiWa1y9Gsjm+DLFlKs9mFD6JwdsuN0HvXjhws6p88Zwm71dXsybZgK52vHkZUCVLJiOlK
 +q6wqHRLeSZqxJfjcBAnMDrRBcD94L2NKXM9mabyQvHgAEkWWCXoMooQk1HWo8eGd+yV24GCC2bH
 590oGM4n89IhT6B/VsZ8b8CkJyAfjpJkJU+aTxSpfjWGoBPECHnc7mA/YARgPsrDiEsR3A+s+tFH
 mw/UvQl6ncx1WECqsXE2U6ArOvmBAr3f3XqKPb9FqrDnrbsjd9DXho7GnHY2YxV29CD8nYu+YZf3
 8UDMrYBDrICQ1U6EC5hM4I5H8DfQ2r4+N0hZiYk7bgpQTthJsZN76+M0GaDSfmhCWz0e51UCSE4I
 KfrSue5e6MVMOPA/L8uJcE/LUYpkr2ctLNEHPMHb+lG2iJg0fc/0QZTfxpvbXuDoCv3S1XRQKZ0J
 nBeFIncjHeloovuecUXknLhWl4LrYl80O/t12ioQCH4zHLJJK5z3U5BeLPrwi1UTPz7vbo5T+f/H
 DqfcccA82gezzkXSiHN//pbcIczsb6NhHPqbwNq2X8EvqZ5z2ysCet9wyoYkFz4yxf1QjP1HPt5P
 rtFj8L+Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <8cbc0b95a652cd34f40979c94cd7c2df9ef9fc45.camel@qq.com>
Subject: Re: [PATCH v1] riscv/virt: Add secondary UART
From: Yanfeng Liu <yfliu2008@qq.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com,  zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Date: Wed, 01 Jul 2026 05:19:34 +0800
In-Reply-To: <CAFEAcA9qpbF+hFpuYpqZrepozryA=ZuDhHLijYAZucumfAMkGQ@mail.gmail.com>
References: <tencent_AB4D09097B1EC06F8C6CD11DF2C14E8A6D05@qq.com>
 <CAFEAcA9qpbF+hFpuYpqZrepozryA=ZuDhHLijYAZucumfAMkGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.43; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Peter,

thanks a lot for the comments, will send v2 later.

Regards,
Yanfeng


On Mon, 2026-06-29 at 10:37 +0100, Peter Maydell wrote:
> On Sun, 28 Jun 2026 at 08:06, Yanfeng Liu <yfliu2008@qq.com> wrote:
> >=20
> > This adds secondary UART device to RiscV virt board to simplify
> > multi-core bare-metal development as Virtio needs comparably
> > more work.
> >=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
>=20
> Just a note that for other architectures we have seen the
> addition of an extra UART cause breakage for previously
> working guests, usually because they took the approach of
> "find the first UART node in the DTB" and/or because
> different software at different levels of the stack was
> looking for the UART in the DTB differently and so you
> ended up with e.g. UEFI outputting on one UART and the
> kernel on the other. A particular trap is that the order
> of nodes in the final DTB ends up being the reverse of the
> order in which they are added in the code in QEMU.
>=20
> Compare commit 5d8a250f9068 (openrisc) and e7100972f2 (arm)
> for descriptions of some of the things we've run into and
> the measures we've taken as a result. It's possible that
> not all of these will be relevant for riscv but it's quite
> likely that some will.
>=20
> thanks
> -- PMM


