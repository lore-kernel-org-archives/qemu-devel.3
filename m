Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A42C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 18:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRbdt-0002Pc-Rl; Wed, 10 Jul 2024 14:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <morrell@alumni.ucsd.edu>)
 id 1sRbdr-0002IM-KO
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:02:11 -0400
Received: from sonic305-21.consmr.mail.ne1.yahoo.com ([66.163.185.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <morrell@alumni.ucsd.edu>)
 id 1sRbdp-0003WT-I2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1720634524; bh=2WHMXBixeCCG/d/ZNhHBOWZBxnobw8hbh+P8sq2KP/s=;
 h=Date:From:Reply-To:To:Subject:References:From:Subject:Reply-To;
 b=K1wHi6G4H/S7EQOxQg57jF36CJWuFVwhAftaJmNoU3UVZXyHq6RGG60SxHjzzktojB2SIyyjQnkL5Uo+HdSqk+gcSAnqUe39i5vFMFdIveg7Cvc+fKL0Zmlux3q/45QPsyVNKApK18y7EqSchmBtmd/ULcjayWTEpNDtvfC257f0sXlBcgiE9viKmdEb2aTVAAlFMY7bo0EDu34btbuE/DAKhlhGeUhnax+QaLqMFgnYuz0e2ZuDY+tk5RCJLxy0rG6YpPWqaO6hSh6JMDIsqjMoVr9QO5V0DMgs36pStw5tf4Et9lLtGMa+/F+Gykg36/g0OvsvHXfa/lC7td7Q+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1720634524; bh=sbXpXhNSb1B9oT+/kTvVeO0wwi1jnkxO99WUk2DNm3t=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=H1XBHu90vmQTjiJBxV0hQsaxYqLG+Xk24iFyEAsXn+dQpljRZFR2y3bvjdP+LfeWp1CXoiFlcBSKzXcKSYIrwEQhAKSeZ/rqPwKD8gymDAn3CjVzBabzKiRy0Zwtxow8Q9C6AuxE++67Rs4mH7VmlkdcMNWwwVZ4XPNUqUv9QwcbtqcKZE+cldk/PVFFn8VddkCBWmJUoDE6ZABbKzm6SXSsQb1VY9hJbcaBFoY9kKL4aqF45ENgX+FTMF5ubFjItOg/Z1WZvIkIA2bCymuExPthMesKLce6GWCP0gYq38C9ivbPRfPgIeMu1rAPC6+RSHttf+mXVf2nTj42M1/K1w==
X-YMail-OSG: hYYFQV4VM1kveOFh.497BFHnAV02u8xlmHLvFXPBLc5e36I52YI69dd_Ga9Vmiq
 yCSnfq.fs9c8zCC1mqD0kBev9ZCoBJg7b8gvJVXZeiUmxkvF1w0F_ewsHzjRowQre8fOBH.LY2B7
 hcxESRvFQnE6llFRZQmX5vaeYzTIT3NI6n4vQngzERC4vo3NxDk8yxoNds0UK6FjuXtwX8Gl_WfC
 aO.qwe07nth2lWp5DDwUj8.WZV4W7cBTJ3IwjWjZhoK0IucV1tY6RLBULPDYK1NAdHYHae4r4nA7
 yUTcx3rYlpw1J2YVVQxUS.i9cKh.JNdVOxfWUVUz4xLR9qeOrahH2PRpX3sqAqZU1N2YRu1SrF4Y
 t6vklmpLiLIotlWfNTERt6pDGUkixaJct1orOiZdErQBH2gUHDbjbc.HzEmAPpzag3Kc_6YsOlpZ
 VuztzdVyI1FSykfaPx.MMB1T5apsSK2r2PI1QNMMJ1hDIjoxR2kEUqYD5M7wl4qNCxsHiS0yeXux
 a0t85zpbt4RAf.ucNrBKrrkjgj.cEMqMsQ5_gzVo914aan4Ty4nz71eh7MJtU454iwzMWF7zS2dd
 RgDjBqNCEeM3_wkIdSHeuyOneekfqi8UYlOPvwLxbiKLf3zRbok.mV9_iqAdw6J_IUBFLv0Amz1q
 AzwHxQvGfECKoNe2PCSi.GL2eoN6Qnm2o7uzwgukqYEMwEnaw5mEGT46T2fXENLraTM6UPa2h9MM
 d35F67H7NC00xXQLa8waTEW.R8gYMtkF.8cEo6nBEI.Q6_q0VzzMVKZo2G6koMuCt4836jcT.GT1
 0vWSEHigIPJQS7tfQ13Fhgf5NSkLaZN.ASDK.3JMmScIWRwxnglSzDkG0QaQ_0VdaGLJWl93oUC8
 1.mricIyrV6kV4Dt.GTVMp3B339nRrS.pLPgaUXkU8fUx2KzhKWcvNrNseD27uP54yprHrmqR3ay
 VNB2mykUVOHJ.Jq8bY_sllzbWW5waLB93W7FDk70o1Ac5QY81PqUNIoDYmm6n8LwaQ9XhfCbk0Nv
 MkaIE5PktjuK2MOOadQOsVmP3.QD7ye6ktBnC5kNc_fTWAdDsAnVBstZFgPjgwFj4fwXG_AzfW70
 CH43nv1Q3VA1_uMzBiNvDohV7IHa7zP_sBNdaDgend9t05vRBGAN3PQytfzC07B61UI2JW7X1qIK
 x9CX6PUw4EvRaUXX.OIrovutSgYjpMCU3MoCdh67PI6TLYb5MaEioDSYxkTkOs7rX38oE2CQscZe
 Bd1bDqtLXheH6LvXX3oXn798bSUpLY1PT5SA5s6jmfZXgoC9BnMWdQ7l0blg00w.hkJrWnzTLxy3
 c1zwyAocdmSo8OKLYcgzakYz6V8tWmV9ga8VnAe92tyUE35sAPg1TfVg_eI0_xrZN8OHsN7UY5nf
 RBHIZ8AOaip8Ze_7_AW.Zt4gWKCBygLtioydkJoBwlN3OVN.gnA9vAjfRRsoGdHaWgm4ev3BK2Xx
 LgXLASmMrlW_LGAgcHXu4BcVO6W3BHxtnNyCShxQcO6G93BjLRa3uyRZ0tzmm8vCBvRetg9cHGOV
 YA9kSNuQ6p81D9S2y4N5fSMYizbSNDCIs5ORKNN0uKHG2s3SKghFeH8vF5Vu8FxGmAc8NwGi.1Ul
 xKJJVgI8VWNvmJV5oAdmRpNkEd.WKw0b6W3yd82MX2LKDbqnMBXKfifmYH9OD0v2Cd73dyL4PAjf
 a5XfbU9ZDX3izEzgROGSS2tW4Y.MUjMHmtlXzLUp9h4_0hVJnJEIB91Im.RHbUAlcJ40OYFuNROK
 3Ct9CRoRzaR2jvs4ockx1LeWP058GqsP__Xcmi7.RO8ttC7DIQcHGIhirMb5pFvorCrW_F8mfoVw
 xfNVHAYFVSP_X2q0OqbqpSgYvGzZG5rbkz6n_JOQ7rAvb7tuusFBQelosdeDOivD3iNhAS.6P_uP
 igK8pRdC67x9COHATYuU5FNt5K6il85omBpi1j30U4HKmQh.CqkPBVsKaDI2MHIYWdRgIWRKppfM
 dEwyX2CkcvQVXHOp.928t09IpiSuinAn.ORW3Bcvc10WHlXIRGVEQRgp._jgCu79i1V4p0oJsQOE
 9nP.jteDiJm4lZzjCF2mEztAKzAHQuebU5q.cLh75WCuDIgJxXflMERBoJq9zcwsI_eu9ITXCmTp
 w6BZsuP.uyq2D2X51Ce7_mzzwQGUmL6VL159x2OH5AZNPxVIQY9JSTeoxwKu5iJs9laL283sW5S8
 NfliCTFPfDQoLqZAqBzUK
X-Sonic-MF: <morrell@alumni.ucsd.edu>
X-Sonic-ID: 49c15867-be2b-4ea5-ba29-6d485cecc85d
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 18:02:04 +0000
Date: Wed, 10 Jul 2024 18:02:00 +0000 (UTC)
From: Michael Morrell <morrell@alumni.ucsd.edu>
To: qemu-devel@nongnu.org
Message-ID: <709543045.677058.1720634520917@mail.yahoo.com>
Subject: Disassembler location
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <709543045.677058.1720634520917.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22464 YMailNodin
Received-SPF: none client-ip=66.163.185.147;
 envelope-from=morrell@alumni.ucsd.edu;
 helo=sonic305-21.consmr.mail.ne1.yahoo.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, FREEMAIL_REPLYTO_END_DIGIT=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-To: mrm94040@yahoo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I'm working on a port to a new architecture and was noticing a discrepancy in where the disassembler code lives.  There is a file "target/<arch>/disas.c" for 4 architectures (avr, loongarch, openrisc, and rx), but a file "disas/<arch>.c" for 14 architectures (if I counted right).  It seems the 4 architectures using "target/<arch>/disas.c" are more recently added so I was wondering if that is now the preferred location.  I couldn't find information on this, but I wasn't sure where to look.

Any advice?

Thanks,

   Michael

