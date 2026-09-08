Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AE1C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3mTj-0002Ts-9Y; Mon, 07 Sep 2026 23:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3mTh-0002Tc-W3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 23:26:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3mTg-0001qE-7O
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 23:26:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687NlJGY2132525
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 03:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=9j0UveKfPew29zTgQY7NnDUBGQE0tK5aAFfrmn/neCY=; b=Vt
 CfLWPPRddgp0Y3b+vm4PZCwRtjemVfbNfaaktTduHh/m/od8J/MSQSk7Q9khWTxT
 dClJQs5jfJULsIaMDI/CoLPulK9I8tU0qe8Zq4jkSgpAs6/NDxh3wcdc7lamJEs/
 brRNUuinBXUzZnGoSjoTNTLWQ8BRTdSfgPQc154X7m6OdC6MmOwLSnwbVCNTWpTy
 F1335l9Guu8Q/faCFg/MkiPbHqoEt+rDAjjs3yxNmbHCpNDhVviHc/u5u7jgBIZK
 ZCSlG+pG/1khe6A41MndIHvGJMpjDuOdr4XN1pS3cqyVwpnxzcqGU5h4qVGeSAK1
 xLHgl63qwJxdeOfxgbYw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuykatm2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:26:30 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7f582244e9eso70634057b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 20:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788837990; cv=none;
 d=google.com; s=arc-20260327;
 b=QXsNkkuCzoTkEL7/7IHBpABW/3Swu5PygZTgDOJwrOQbH8OFTtdtU6jL1tA6tqj1f7
 RJ7VD+YctffLUpOmLCNYwF7ebkQ9wGhamOGUovOGzyIlil2ZJf4UjviR2UUtNlMdomyw
 VMn0SfQkzxlgezUnNIlvjuh5ecG1N1X2aKERSUW/LhFnL1AATwWhTpw0Rzt5z2FKMGEM
 HFk2Tz5c0z32R/kMlGlSEuuQmxrhTwnOXXIFdtuhF3klUjkxAQkkrNHFrUSQmDQRgvhT
 m9eMeFlpEbIPh1mjXohoNLNgPWszrF74fHmKushyK3vY0RSw+4oLIaVBTQGEGmpcQ5MH
 th8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=9j0UveKfPew29zTgQY7NnDUBGQE0tK5aAFfrmn/neCY=;
 fh=udlw/V55QqKjfrey8jkN1LY7rxVa/+AsZP6aV+N8N38=;
 b=dnH+4xm9hXxLNK9VG4YxPim/e1X0JeNmBnQbkvpj08ps4ovfzVjL0hlPzY5a+AnQA7
 gagDH9waC/pVaU6gI7giHDzSgHRCQ8yWpydRPgKdGkvzIzRsFDqGATI4iJ1X/KOtjPQz
 9UZeuCmu/IKanDqj1bq0yAhK9/mbrcFqaQFlPMC5cFnFdXio1902AKhalu9LnsRsAyae
 9ZPQyUw39oVZ6oG5uQZ03hv3ADXvx0vrxwOycINKj5ZGuFCt2ZTFlX4zYgRUmdCQtQJG
 0e3L89XM2nIxTqv9YzitraNrDXRmYi38uuFmYroDyZZBW9zvtU+orMizl9eP6tHAGQiC
 FvIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788837990; x=1789442790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9j0UveKfPew29zTgQY7NnDUBGQE0tK5aAFfrmn/neCY=;
 b=YgMkUwrAVMKMGzfkmCTSRbSuwn59PPkpv4gVdmzc3H2y4dT2LpJsu4OepmgqPdWymz
 BPjtV36ldmEZ6Kycfmv2QsXTx686S5Mr5rCEpEuRICdKGXnbLpdRCS8O2p6wr1ddY/gB
 vfkxD7UDjcMzoZNpAdzWyupv5cZIrefTackxIrZGDDpoizKyBPbknrkjYI+JPeukNgdC
 PYk+Dz0bTZYU5+74pY/nBROJClA8UhQ9axqt28NpiAA1GZpb+kPeEc0RJIHVKDl5T91E
 JS94844GyvdmgvkmaQWtJfpjyBzQO5lZ+4/9lpWhbd0Bo9d+1CrRi917cYiPfcJ+3Yqp
 Tx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788837990; x=1789442790;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9j0UveKfPew29zTgQY7NnDUBGQE0tK5aAFfrmn/neCY=;
 b=q1dtDSMcJ6hue6kbSNguESNWSGeC4GNYNNcN5DO4yVtl+Gv91kFfx4anaTi8Zj7fRy
 PZK6cGZ/0h5nFOquP7j8dQW/c9G6nYc0VyvZdX6/iBLKO6iYMobWtdE1PSgRZCYX8V5Q
 IFU2iLjUzBE+hch0RSy8p4osd5/mIjVZohaY8oV9dHlYDK1I5rQfuzQspCamdqFDQWH8
 ibfdPf1E/0E9IevjidnWWZQ0PNUUvxN4zRhoWUquqN9otYdMbflKjuoKVGrgmCIL4hwR
 vsSZ6V/FFzJ6wMU9keOE0zYi8veaP8rFOFbA+BAEQ5Cu2kVp8d/Y7GI+WtG3C5otVUnH
 +jqg==
X-Gm-Message-State: AFuF++ljuUK4Mf+RJTagIdaWcjVwQJ0zVZZ9pR2WyOax3hKSpRg/hO1e
 H3rXqoAkyIapEeAMP6LpmHsrpy/tekZeuwAhOPj99ZJlSwXlhx1BB8azdy6sAQyj8RCVGemdrMT
 NDjm2fLbXXjsyk3IxMtOG5Ow45XvSjb2u4dFw6pscjzHx4yAdI/Ete1vRJoex4EFNX/GaYcxtBf
 iZX6yVu+oHMlzO9hDG/5qlYjSwMB0FxFvq
X-Gm-Gg: AYBFou3Oi0Im1INQsf3FwMoPTUDPNVaUaP9BBdQuLPUlx4idcX2LhTA4EOuzrOuMUmO
 vitGvX/uWvtwxl0R/EVvbMsH7Kd3cT1ttyV2uula4XeRpEj0P3EGzusrPG5m9QD1GEdqH/7DeZS
 8kJu2UQ0cldR3NTbGUp7kGtcPB+M81QGT2oeYU+iOXNUWslSHbMaJ/612jg+E=
X-Received: by 2002:a05:690e:134a:b0:66f:cabb:d8eb with SMTP id
 956f58d0204a3-670f6f4148amr1054580d50.45.1788837989822; 
 Mon, 07 Sep 2026 20:26:29 -0700 (PDT)
X-Received: by 2002:a05:690e:134a:b0:66f:cabb:d8eb with SMTP id
 956f58d0204a3-670f6f4148amr1054566d50.45.1788837989459; Mon, 07 Sep 2026
 20:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260904195610.964829-2-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:56:18 +0530
X-Gm-Features: AcwNN1Vup0mya5WT3-kIqbNd3_cdkqNOWaM6V6w7wNdaDy6RE_Q0RKMFMMr3mPk
Message-ID: <CAB19ukEaJRKHqqW44L2_Ff8NYgcHh9oW1E1w8R9XmcoXsGBOwg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAzNCBTYWx0ZWRfXzZpYAsSiiMdv
 08bN+BXv1ZWXxF/WRyflPWjrRYae5Tw2ApuUfb8Y5F2vDnNey7wqKbf7ind8oh6cu/MLvhEb8R+
 FnMBbKPhV/AP7bQvkOTLKAMN34S9rnA=
X-Proofpoint-GUID: GHxtp92Am3uHmlGTNLgu3Sm9TOEfvCWY
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9f8066 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8
 a=f2ANdWxeLYQbYMvOFHIA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: GHxtp92Am3uHmlGTNLgu3Sm9TOEfvCWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAzNCBTYWx0ZWRfXyD1epoDSmRPl
 0yeAQR+G9gBwHoJlmN7BJRufsmSaBUZAyrPLQ3qsPHxpbnq8FXKPqxrKJGPJyFrJ2eie9eeZwi8
 1uMQ2MI8ze4ENCMwSEXCnKgocuImIxIk4oVHvmQbPjgcC+xKHPVB4opPAw2SHX9Z4PqXVg0AuHR
 Qb0DR3EQo9imGXMFRmfXCnaxJiP4SA9y3isZblpNMA/4EUliX23j9/ck4WXbgAFPPlEih5w+yYr
 HgVya3CHbvwWogbJQw/nctg0qHGTobn0LLcuQMCaZLzdTEIkQQeyZn+GlFMyJyXEYO6bo48kZV8
 vScyaXTd1+i+VGdaeNL6+nv7TxMM618A0zjckUj/7M/NXl0dfzp4BNhCIyBErePN89iL/nU9yIV
 6R+KnbPD5MzUr9FO34BItmO02gpp9irTGBtwoQjjbL93MI8UzQhRZyoJprwnGZbQouyDrSRLUaU
 mj+8FMeeoHC/8X7SKig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 5, 2026 at 1:27=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
>
> This means that a vendor CPU can set .profile=3Drva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 652311ddef..185474a8cf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3096,7 +3096,6 @@ static void riscv_cpu_class_base_init(ObjectClass *=
c, const void *data)
>          mcc->def->bare |=3D def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> -            assert(mcc->def->bare);
>              mcc->def->profile =3D def->profile;
>          }
>          if (def->misa_mxl_max) {
> --
> 2.43.0
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

