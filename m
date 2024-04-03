Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79418CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 19:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs5rm-0004UJ-SD; Wed, 03 Apr 2024 15:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1rs5AQ-0000ci-2x
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:17:03 -0400
Received: from sonic310-24.consmr.mail.ne1.yahoo.com ([66.163.186.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1rs5AJ-0005zJ-Vi
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1712168207; bh=g92yez4sSP8F6s1JfsJCe6SFMqyeuZxXQXgq9wq8Crc=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=kdM5rk2htUBlW+yQ4RVw2CsjIQyPpjeoiSoS0df6weQiEvbaiwKzqkncK/mBi0yKQ17NFSbOml/v50FPF3l11zz/9nqo4+V7hYpXQ3oxtZIHO/PLq0RPy4fN9NkunJSarluMajM6KVCP31QzPEyKzS+BOpkFVKKlmSdTUeQ/ogqYyOnRsJ2rn/uPMRS2rvjrBP8mFjKjK7RA8nXocsXcGwzuw49S8GWMYjW6vpbDAUaKEjV/7BCM5AYj+ATKmqnlGYf7P/FBzr+aCjqFX0aKDkq8tQUYDoOmC9bzpARGJAVmbBBCCxFfeATue7wckPs/2z1saOmWtp5kWGCj3K0bFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1712168207; bh=1NxqxeI/RTivCDkVzEZZ9rHEKsDbgILyDsj3FH68a48=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=U7o7movnYDh1xuLTMrXxPaOMmECtRrNkLCo7T3rvJnEBSsTCZA20Ywc3Rubdr+x8bDDS/os4HIRvISZbeu7dzpNz3rWJzWTycj9XCqQdBx2CSi7bKo540TupB4PYkTdB3H9GEnA4504uBFVBu5sgkSHXhihsy1GbOzyfj6jDH0ihv7tPgY29jKGGBg0cNJ8aaZJPiY1LNL7Y8RY+eVmDjq1T3ceqM8LvIGN2dGjbzud/ildvi+aYcnloj7nWpi3a+c2VZogMUrQ4PiUQRG/iBc4LNmCmBwCWgGAfr4A5D9jFX5z2oyes6ebmNhukkTLEM/QTGP2WXXT5mRm8ejKUNg==
X-YMail-OSG: wuwHcykVM1kyB7uipLZ7LdJtOexfOSFa7nX10FXpHyZa6joL2sRokUELVb4EmJI
 qsWZqO2c_dB51Lu5anCvTm37h3oJErpvrLtV3B7JnTK.3zrtdm7aSRiEJvBKxadDdqFWMRrpUH4i
 rB.Zx1u68Yohdy2zL3g9GnfL4L9wBS_2657KRgBefMJpbw9bZJsL61VjWl3HAYSK4o4XHyOPAGc4
 nFkxqNWdYlpYckiESDJmizPwM7FGyH.iQFnJCKL2eiOiXuYU6UMHydTECnTB.9cB2lp5VHb3e792
 EG6v6HoNklxLnuqGmFYnh7pSXZjAeLEvtwcGd3l64yRU3MLqFV9PVgb9Y8vk0Krm3l0u8jAN7GC8
 ODcaTev2BYdsARySpOSW7xEzV6i.17ebaJQlmmT7Qfc..cnJyPMP2T94NjdixHZkx3t4zj6QGYXo
 kMxNw.FZFlGPyBNNcNRPijsYAuJHWP6BLGJis4xE3Yi_HSs0yFF2M.C__5fZ3GkzAkDX7awuMbi1
 zQFh14fXeUha6QAJ8.g7bCg4LLekk16bCXjA7i3eGP519fPt1v6NXQ.oSUTZl1v6cWXBeU2rHCZo
 Dwess9MaomOSlBwS3_oZv70gJl_.jsIItbKsDZcB5hf0HqOfNDGF8XD9aGQIRu5mtHkwkBSWVsBm
 CO70oZQeJVT8ZL8ScfsuvUXsNYKqN26GWc0iGiVlSCW1U7TshnZIo7l2Hk8WCThIlFIBAGx4wJ6g
 BsAwEl5UqSu2SEegbc4d9JqqCIA4vE4dz11oD1e7a9xn0jXqZGJwv1S81YLNHQikpw01QvUyG5iP
 uHLbB5VF2aIMQICMAGYfS.2f50XZbfKkJdgw8h9D9_scDnVXJsX38__rP.9AOOBTA2ZjJgW5VxjE
 oa2rFhy5D3.ITsH23sg2OFHMIF6hAXhXy8eKNax1_KtqE4P.8afZc9A7dRZNFq3xkP99bMCcSESU
 O4Jif9UG37INbyrTPZ4bNKvNVjeAOVOxTIRwi45iMVzLlyosYzzdgTYVS0Jz70czPmr8K12isRCf
 d86zwLMZvLbdg12TNx9KxzuexihaopUCgnr1.139VEs64JydAcqJjdzoM8leC47L05_Onf5T7zo6
 tUFh6mNnm499JPOtMoZBthzFuTmU.yNyw2ELXfH0naQQwREWAZGPspFBxZDesge_zB9RX_vFS7SW
 FnMSZKHUJxC0uZPPJkGTDjaZYbwILGuNRDOlpq3nmQXqWRUdzjQ94TCtA_xpUz9Sf9FOfwRPyEDe
 g491f4gEqCtJckApXQBaX2YJgpfPz_UcMLda58GHcQDcd9aKT1yv9kmcF_NDR0VKgEKvwmZwoxb7
 XOGXTyidm_GK0Sy980ONX_CR0UpDAuDpYbhIsbim9p4BNFW7TK4dWWZwXhZDoKXz1wCdDh7RlyQq
 uULwAQS5OHOqWGY_hOvAEYUGYWT_cKKL_.hurB05RdrzEgrpP7auBUNeDFUUqwqhVVt19VvqlsNt
 aSzlT1_MFw6foms_GbValNc9.BrmDjtyafAawS.cOZBCzXXJmtM9lHmvuYOzOu9OdivIPpGLNJBc
 OR8p2rbVebPLrcV8u0K7BTsIH_3yCpEGmgmyZP0nedvGZCfrHTALMnA.cBS96pO6VSlsO6YZEt_x
 4EpenZP.bT2RAcZ9Fpi3NnzC2deVnHneh0ZX6HcF6nMGLeYP0oP6fMHSNLA.2VekMrX0dXrLCmLf
 XmMFXO_Xhxj7t1_7d0XvapqdPoY_SAqn1HPBF5lrNUxRVMy2L6PHYlrSW_d.JQCY4a04BU_eCpNo
 fneB9O2VTeQwmqCd9sfpyo5R92Nahg4ctpfxjUBf0rZhzi4k5J5wJC2.41abMojub51VHKYIwDCl
 PHWmrJ2KcLTrM9GW2.bRVhAa6otRixJH4MUqOsh74EO4gMdEa7AEQ7aZ45kO.Rz_f5Wshu78mRQ7
 gCjYw9nTbY9YQjyJ_0yZydD73AXaRDU5Lu5ds6gVqVtuordcca.NDPRQXvbvqKFh_jFg6ESEGHuO
 k9rJ3u0DLB45qdTuLZ4UpHzxyZuA3kWusZH5l28YplQIK2In.2tfbC5I58fMaSX66W6DCJAtTNoP
 JFLk0g1xKKMs8CvfxWNbeGStAOO9ZO58r8QkM066BV2s84pt4YSLEzOdm96CzN2PO85pIfLPUD_a
 Tk4pLYoDth1Ickhe6Vz8dytC5fpjAEpUpEY4lMzOzfh2.aJWgi03z59pqOGkdoJFlQ7YUPWX7g8O
 HDFmSSMtrIA--
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 4177442b-1257-4afb-9775-989bbb1cebb5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Apr 2024 18:16:47 +0000
Date: Wed, 3 Apr 2024 18:16:46 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <183897139.5301881.1712168206289@mail.yahoo.com>
Subject: riscv disassembler error with pmpcfg0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <183897139.5301881.1712168206289.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22205 YMailNorrin
Received-SPF: pass client-ip=66.163.186.205;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic310-24.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Apr 2024 15:01:41 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I've been using QEMU8 to collect instruction information on U-Boot + OpenSB=
I.

I'm running QEMU in this fashion to collect the information:

# qemu-system-riscv64 -plugin file=3Dqemu/build/contrib/plugins/libexeclog.=
so -singlestep -d plugin,nochain -D execlog.txt ...

When examining the instruction trace in execlog, I've noticed that the disa=
ssembly for pmpcfg0 is erroneous, for example:

0, 0x5456, 0x3a002573, "csrrs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0,pmpcfg3,=
zero"

the CSR encoded in the instruction above is 0x3a0, which is pmpcfg0 (which =
also matches the code I'm examining).

For the Uboot+OpenSBI code I'm examining, pmpcfg0/3 is the only one that ap=
pears to have a problem.

I also checked QEMU9 and it behaves as described above as well.

I'm willing to provide a fix if I can get some advice/pointers on how this =
disassembly statement is generated...I did take a quick look but it didn't =
appear obvious how...

Thanks,
eric

