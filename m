Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BA5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 11:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7ZJU-0002uh-8V; Thu, 16 May 2024 07:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1s7ZJT-0002uS-2L
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:30:19 -0400
Received: from sonic312-23.consmr.mail.ne1.yahoo.com ([66.163.191.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric_devolder@yahoo.com>)
 id 1s7ZJQ-0000VG-5F
 for qemu-devel@nongnu.org; Thu, 16 May 2024 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1715859003; bh=JsZ2SPoDxWywu01mqeKScRkkXjpT5GCqFkLpKuSXmEQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=pTlGz12csDDriQVk3OuL7H8Qb6Cc2jIjw9WM/sB2bFTk51/U4kaIPUSbntA0SI3kWZzLJupWKY+PdIcJMWgc972SIBhslkc9cItrPutezSe79wTQu6CD4oFN9i8SQpT3wkSpZ6vK8xjU3pGwFSXg/lFQY/G/5mBr+wPhAjrZp7lKE+VFYXNULdI3ZDHCxwjQ7fGQHRuvzzfHZdFsIgMHy2FriDRgQvHiGgC98e7GFrzawXo4gqIO69MdhKPkw7p0P/kp1Ma36+YGrWywXCLStHRBUzz/4WdZXxvHslx1DgALSGD9JI/aiI7/UsGZeIv1cqkPQaNlFYLJb2PZuB548g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1715859003; bh=D+Je/NLyiHElDFZMkGbExkx46dMVnNBilyUrqgDOjeP=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=svfG4IfsTsR2CrskHe8sZUdfkVtswmxCznp6V4LAmXvQKCXko8HFujfpZeJSkGhaofVQiC7qhRoeBi14OMlYZxkHpHFGvwrc1yPepICYmkuFaoKqq3ldw0cr4nHkeWQX1nbY+lLrj0exrBVxgAE0XYK4kp0WaTAQXvSshrZXhkt2AKRdpHEB0AjKH7oMla0RIXhG87cGWck5TPlALGFYJTJWNJES0lYTvp7xuXNbbswBj+srtKMy+lThBEW0VdSSDDA7xJyetLvS/1bJfqI7Mja1A2vWLfFRfTtXgNF+5clEGnpr7qJjdOmHuJUIrkBUU5rW6r3OOzxKgiuHTsIuHA==
X-YMail-OSG: P.ZnqaMVM1mmAQgxhztAuzsRgait702T23ywoAcBqwMhfFeFq8v13_7l4qKJ9mj
 BN3N8dC7YAJID3UA2Vzqc5s04gZofHZpV9giqPHZuLujplGdvAKqBmnVqE931fD1vsUoQnl58mDi
 kpCApH.BvFEHCVMFjjmijzGlwSsrsC.q1T5TSy9rHJkVQaj0mIEBWvmWPrnnrDdBis_hIlTgt5v2
 DYoU9e6B7A5kfuggZ5F4hDsIHzOnXlHWw2VWLCjEp5e83XfG70_uty.rBHCVwj8AHZfNoiU5.jDs
 R6rrcMtaP_MDXnD7pM9GlH6HnpXelOK5tNcCe2Tk3gX__dlIP6d7rhsoAKpr5ddWXX8QI_m5TXGi
 KxzuiA84DUYr0c2HItE_oZ2wBiKZbQHm6PNIOpC8X0nboQeLLdiOrAVkGSupxctiVFo0DUzTe2Km
 7Ve25osyr.WShYkrMuJYfOmyLtMwCx8HhkTXVpLIXk4qBL9D_liuhG9tPDuM4eRGkZtwr6Dc_K_r
 OnD.9SbbwTCe9iSqJGmwtJXLHdpjgcKi77aFnlj5b.RGtvl_2sJTA5wH2XkDCURcFICD6zYbEbxx
 BrZ5Lidyd2Fqp7FKj3M6ZHj0xVstSeCEwdX2LJ0O8pbj3fn9M_uxnxMBb2u3ZdnMdaUjB9I8Zb84
 IxQZk5ELX3Rc_7Tae0WyxRxg0VjJFBCSDco.E1XtQd1Eqr58M1eOy3QkmFaS3NdaeXmGYoG2_H1R
 EqYSuQNhJfh1pcmSdYn1caQjq.nNR.Z4b2BV0LgxAZK3hyncbXAIMpt7K6P1lPRRCC2R.Y.Nh4Jw
 5EEjww2khyV4peqDSk7g0T9oqOo_EpnF4FRo6DKlkhJUXFmA5k8n_WgrCn5UVPO_NbeOJ69ejjfV
 9FxIZspGOBnjeVUIVD0p07uPHRr_ixdQtede7LlXLq_j5ArdzDae1gWMf1npSrQlf1NkMoKFAstD
 jvlNeLZvBUtBBQc2eUDg23md.5LS2_gQSRjGb_fIUZLaBt2.Sk._yWfRglTFm8j168baaE5lbJjV
 nV303H4q6bhAI0wSxo6Ww1qDTvK01_b2cv5Hdd0cjdCY6mbJpG.y03iMHv01paBxIhCSchkmD.B3
 F8_oiw_p3V04mL1EFwS4mqT9MiGIV2bObAIpJEQ_i5wb3mfUaXByBB7hb3IoEJ__P8eKJrsLf3k0
 JB3rBZjDLkEjd4qhrhlBmB7i4EKVB30JthMx2p565QY3SDaN_lwkI5el7FHe8H8F7qA79oEsGA7j
 orCHlnz74EVX7O16C3xf3wbSK57lFz7zt63mMnBDcKhQ3HHtsB2mqhZQKMKyzDFWIo57Ma0EKVzk
 0Y2I7tND7VX5jlCkNQN2JVH.aaATDa1_fhFN4ZhdAlKULHDXlt3JAbsZ8UTe8c2wN23WMyYWwzp4
 I6jbJwomYRksV201DbLG87ZpybEZDGhBPaYCLCCKo9VOjAUR1lrwj2Oei4eEKjxlZ6EYZsXqxxkv
 4KqEJ0I0M6qcgrs_zsHL14MXKAmkbxrlkjJRHHLwJFzph9LOxYmEed2t3UIQO0_KNBePy8oF0R8O
 5eNDVDERHoWr2n9gWXXGoLubmhdVZhoXvf2W14eAP5tlSSrw3VaM521H0EcSFb7tnsTTtFK89Vdn
 wGjCcPeDh8nKUMVGCvBCKqx9a8tvXZGHYSko2nr0y9cLe04ZyOAVviCewghO0CL5530H1qlr8vGJ
 6m7UN6L0V8PAJBVD5pBxSLh8DggT9VA.piEkHoOVSV34Qe_Frpz_.J3QZ2xSV1Loez82HZeUIH2a
 UP._dnoo6lCOsaHW8qqvY8.gpeTugoo5pULTtUfdG0jLujEIW0a5GOipsVgLJfv2iGn5Af8D19wU
 a4E5nmkU2HsAeUzkF.aXdyqjSkMEU4aUwJ4UUu4t5QJqYVDv1oaAoYyAe1aoCe7xqQkBVz9UDNtU
 _D84Eqvmhtd2tVaFOuUM0dofWS.rF1sgbsV1gUG8.8qacku9HkOABIl9mYMbkPBWM1b9NFhDz9jH
 OktblHwgg_iK2hdT2HbLe.7Rn16A3VgK_DFlatgmbG3HXnrgvqU.fYraOAThc2kX7Q80i5rLMPkQ
 C3EILVkxMDx9jhBDP4VYh.yVRUHb403F9UK12LmSSi7.pbC_I6N0zGT1mCClJSgJLKtoMCcaKMrI
 lOwZCN88fEZWMYxFXp.ZpBUgBsxqH0n4swk71t8oSXiDfc9k06UOumCNYZf2rZiB.sgJdjQyqOZF
 V_EPIUlDcC6.K0jCML9bT_FwJF4S1IZNA5AZXJWeiEpUVdHiYFMBN
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 640c01e7-e9aa-4a89-9b18-24c97b8bd562
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 May 2024 11:30:03 +0000
Date: Thu, 16 May 2024 11:30:02 +0000 (UTC)
From: Eric DeVolder <eric_devolder@yahoo.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <1193080064.748753.1715859002637@mail.yahoo.com>
In-Reply-To: <CAKmqyKO_opF60yo-MVyyq8speR7A5Ugs5Y6iMxd5Ju2Jos7rxQ@mail.gmail.com>
References: <183897139.5301881.1712168206289.ref@mail.yahoo.com>
 <183897139.5301881.1712168206289@mail.yahoo.com>
 <CAKmqyKO_opF60yo-MVyyq8speR7A5Ugs5Y6iMxd5Ju2Jos7rxQ@mail.gmail.com>
Subject: Re: riscv disassembler error with pmpcfg0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22356 YMailNorrin
Received-SPF: pass client-ip=66.163.191.204;
 envelope-from=eric_devolder@yahoo.com;
 helo=sonic312-23.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Thank you!
Eric






On Tuesday, May 14, 2024 at 12:19:55 AM CDT, Alistair Francis <alistair23@g=
mail.com> wrote:=20





On Thu, Apr 4, 2024 at 5:02=E2=80=AFAM Eric DeVolder <eric_devolder@yahoo.c=
om> wrote:
>
> I've been using QEMU8 to collect instruction information on U-Boot + Open=
SBI.
>
> I'm running QEMU in this fashion to collect the information:
>
> # qemu-system-riscv64 -plugin file=3Dqemu/build/contrib/plugins/libexeclo=
g.so -singlestep -d plugin,nochain -D execlog.txt ...
>
> When examining the instruction trace in execlog, I've noticed that the di=
sassembly for pmpcfg0 is erroneous, for example:
>
> 0, 0x5456, 0x3a002573, "csrrs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 a0,pmpcfg3,zero"
>
> the CSR encoded in the instruction above is 0x3a0, which is pmpcfg0 (whic=
h also matches the code I'm examining).
>
> For the Uboot+OpenSBI code I'm examining, pmpcfg0/3 is the only one that =
appears to have a problem.
>
> I also checked QEMU9 and it behaves as described above as well.
>
> I'm willing to provide a fix if I can get some advice/pointers on how thi=
s disassembly statement is generated...I did take a quick look but it didn'=
t appear obvious how...

Thanks for pointing this out. This should fix the issue for you:
https://patchew.org/QEMU/20240514051615.330979-1-alistair.francis@wdc.com/

Alistair


>
> Thanks,
> eric
>

