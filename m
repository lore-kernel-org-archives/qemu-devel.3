Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DBAD25B64
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 13:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl5Yu-0000Mb-Hi; Wed, 28 Jan 2026 08:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1vl5Ys-0000Kj-Ee; Wed, 28 Jan 2026 08:26:22 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1vl5Yp-0002Ae-TZ; Wed, 28 Jan 2026 08:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=date:from:to:cc:message-id:in-reply-to:references:
 subject:mime-version:content-transfer-encoding;
 bh=pjNEKOTw4utayRi0uxYr6wmBE4hKeSMSxSXP5CzWvvQ=;
 b=S/+uV4STl1Tm8lKO5PJFvpIcbSE6q7AZf+UjvTAna1boMKXN9vFPGGQE
 gfpPViU/X6Xx7RnJwN7ozddjxz8VNwzvDkjrrtsjLexfqW/X0tPzSiaJP
 OAt+hJuLRn9VLqBSMQagKT/NKVb8DNNKCORxDLwSx4FvcyWTV6LsA912n E=;
X-CSE-ConnectionGUID: dslud/ONSeeMXp5onSRBuw==
X-CSE-MsgGUID: pLZnMkaUSo+yaJwLCtd9Qg==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=Pass smtp.mailfrom=sebastien.michelland@inria.fr;
 spf=None smtp.helo=postmaster@zcs2-store8.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
 sebastien.michelland@inria.fr designates 128.93.142.6 as
 permitted sender) identity=mailfrom; client-ip=128.93.142.6;
 receiver=mail2-relais-roc.national.inria.fr;
 envelope-from="sebastien.michelland@inria.fr";
 x-sender="sebastien.michelland@inria.fr";
 x-conformance=spf_only; x-record-type="v=spf1";
 x-record-text="v=spf1 include:mailout.safebrands.com
 a:basic-mail.safebrands.com a:basic-mail01.safebrands.com
 a:basic-mail02.safebrands.com ip4:128.93.142.0/24
 ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:128.93.162.3
 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
 authenticity information available from domain of
 postmaster@zcs2-store8.inria.fr) identity=helo;
 client-ip=128.93.142.6;
 receiver=mail2-relais-roc.national.inria.fr;
 envelope-from="sebastien.michelland@inria.fr";
 x-sender="postmaster@zcs2-store8.inria.fr";
 x-conformance=spf_only
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.21,258,1763420400"; d="scan'208";a="260750798"
X-MGA-submission: =?us-ascii?q?MDFaOtRUWEtmNN8YbU3Jiv069P2TNyiBojP9l8?=
 =?us-ascii?q?jdpeNABG8lviUA7Mr2bPS4Tn0xiMGC9UEe7+Jmuf/HAG4DeDXiTw5uWC?=
 =?us-ascii?q?bog4YUB7sqSIU0uFP6sAzEt9RE6Fpbmr7wKgkvIbFcce5ofPnynihwAf?=
 =?us-ascii?q?/4O6OI5V9sQ9d+VzKwya9yyA=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
 by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2026 14:26:14 +0100
Date: Wed, 28 Jan 2026 14:26:14 +0100 (CET)
From: Sebastien Michelland <sebastien.michelland@inria.fr>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Message-ID: <2132391437.15681684.1769606774227.JavaMail.zimbra@inria.fr>
In-Reply-To: <81d962d8-52fb-4203-a3fc-f3980b8a93bb@ventanamicro.com>
References: <20260126172246.2521444-1-sebastien.michelland@inria.fr>
 <81d962d8-52fb-4203-a3fc-f3980b8a93bb@ventanamicro.com>
Subject: Re: [PATCH] target/riscv: fix vs*r.v missing SIGILL check
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [131.254.16.132]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraWebClient - FF146
 (Linux)/10.1.14_GA_4838)
Thread-Topic: target/riscv: fix vs*r.v missing SIGILL check
Thread-Index: STpY8YtIHzdjUsJXQtVn2pPvNj2rLA==
Received-SPF: pass client-ip=192.134.164.83;
 envelope-from=sebastien.michelland@inria.fr;
 helo=mail2-relais-roc.national.inria.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


>> GEN_LDST_WHOLE_TRANS checks for require_rvv but it's always true, even w=
ith
>> e.g. -cpu=3Drv32,v=3Dfalse.
>=20
> hmmm that really shouldn't happen hehe I wonder if there's more bugs
> lurking in the shadows somewhere (spoiler: always) ...

I did wonder about the semantics of require_rvv. I assumed originally that
mstatus_vs would be equal to EXT_STATUS_DISABLED (thus require_rvv() =3D 0)=
 with
v=3Dfalse in -cpu.

The comment for vext_check_isa_ill says VILL is indeed intended to work as =
an
"RVV OK to use" check:

/*
 * In cpu_get_tb_cpu_state(), set VILL if RVV was not present.
 * So RVV is also be checked in this function.
 */
static bool vext_check_isa_ill(DisasContext *s)
{
    return !s->vill;
}

But then I'm unclear why instructions do require_rvv(s) && vext_check_isa_i=
ll(s)
compared to just vext_check_isa_ill(s).

riscv_get_tb_cpu_state sets VILL based on whether Zve32x (the minimal level=
 of
RVV support) is enabled. Maybe the different levels of support are involved=
 and
-cpu=3Drv32,v=3Dfalse doesn't disable everything?

AFAICT riscv_get_tb_cpu_state is also the one setting VS to EXT_STATUS_DIRT=
Y
instead of EXT_STATUS_DISABLED, in my case because I run into a CONFIG_USER=
_ONLY
check (target/riscv/tcg-cpu.c:154):

#ifdef CONFIG_USER_ONLY
    fs =3D EXT_STATUS_DIRTY;
    vs =3D EXT_STATUS_DIRTY;
#else
    // non-trivial logic
#endif

That's about as much as I can decipher from a quick dive. If anyone knows h=
ow
these pieces are intended to work, that'd be helpful.

(In the meantime, patch below should still be relevant.)

S=E9bastien

>> Instead the illegal signal for all vector instructions
>> (except vset{i}vl{i}) is generated by vext_check_isa_ill, which checks t=
he
>> context-dependent DisasContext->vill that conditionally makes vector
>> instructions illegal depending on the state of vl.
>>=20
>> Currently, vs*r.v runs even when RVV is disabled or when vl has not been=
 set.
>> Adding the missing vext_check_isa_ill brings it in line with all other v=
ector
>> instructions, raising SIGILL in these situations.
>>=20
>> Signed-off-by: S=E9bastien Michelland <sebastien.michelland@inria.fr>
>> ---
>=20
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>=20
>=20
>> v[zs]ext_vf[248] is also suspiciously missing the check, but doesn't fai=
l in
>> such an obvious manner. If it's also a bug then it might be worth fixing=
 at
>> the same time.
>>=20
>>   target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc
>> b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 4df9a40b44..1e99c35988 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -1235,6 +1235,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t=
 rs1,
>> uint32_t nf,
>>   static bool trans_##NAME(DisasContext *s, arg_##NAME * a)             =
      \
>>   {                                                                     =
      \
>>       if (require_rvv(s) &&                                             =
      \
>> +        vext_check_isa_ill(s) &&                                       =
     \
>>           QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                             =
      \
>>           return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETY=
PE)), \
> >                                   gen_helper_##NAME, s, IS_LOAD);      =
       \

