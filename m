Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D204606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6l8VyRC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LdbZmH6n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLE5A-0004nP-2v; Mon, 26 Oct 2026 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLE57-0004ml-8C
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:21:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLE55-00050C-Fp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:21:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4as1N3303642
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GNAVyZ6P17QNJ0BN2RK9Xr7zP1Ls34awkpI3WNmJTgI=; b=W6l8VyRCctIKTPG2
 ZX+OPk89Ql9woHZqnJgvNsFrPC/SkgZUY/afCsSuF+ZlYGTnTPet56IEkYjrK6IZ
 tZ6NXWko5FlfoWpRQFnlSiNJURZcgHRkNSaGimCieUii4EqkZ9O6SgHz3Z9QTS7F
 sN/WM/Qz3w/vuoq//yzqtRAjvI1wfeQmGYYRVuPFh4xBuoItuqA5i0ZQrCFWiEji
 Iu3gIcbKpy3zPmlz0vViyoDjot1GHItR2oC6ylYTSAoEQQ0hCYu7malYJFD1JLXJ
 ArFBtGs8/TuDWvMyTM5OjHmKZemhkRs9uoNhsiKki7PLKPMd74XlZF2xS6rswK50
 c2KXWg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsd4pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:21:10 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-988b530df14so78571241.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 23:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792995670; cv=none;
 d=google.com; s=arc-20260327;
 b=rjaRRxcVLN3A2qToIXOJGflaSBY1Uyp7hvNFEvRaS9DOr54PEOTT7UEt6RAjnm8MWl
 eLtT4YyKpNAQ0jyNs0BZbk6Bnlw/JgpLp8FuMsMIJcSyenaNuxVW40aMhLCN4hexT7Vl
 zPIWwWkgSjhSdi7SjtA4JpWsWvvfnS5y6FhD5rH8PrcjOdLlU78k4RICIa8Oxo4MARQg
 0On8xHdUcbYXtqWlsAvjwB6ROOaJkdPyMK1GIErhmpgjP8JALucqOCGplMq3yHQ1NvK4
 qJnRNuEUcfDUe5D7s7AgY5qyNzKh9syBsnZEoSwKmk8dXxmXUu4BSzYme9QxejLMkA/h
 BzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GNAVyZ6P17QNJ0BN2RK9Xr7zP1Ls34awkpI3WNmJTgI=;
 fh=3BhWrYxU+t/Re/+31lRRSxlz5rsOln134oNs/GQoxbo=;
 b=moMw8TZ8XPkKqOcXpqle6aKZvufg4cJ9lYn/xBfbyEEzl/VbgToqg6IafMGUIit/jA
 H9dPuwvPT63/A5xBV3gf7ytRM1uHUgyUbOjOo1ahy5ccIZDfgHTfVKXZan3g6VoVt858
 xzgoQn9p72CxMDzvLMcl0XiJDXGxneq5saYJUKUd0gnC4VhzoLTc7u7+nkcBxXRt+pH8
 h1HydiZuDpho+pf2wCpBasy9GkJN568t2s0GXZ93u8POe7KTcY8HH5ZBvhSBxwn8HlvJ
 AjhHt77CRi8ajAyUEaU3cRBqawEt7GLfR3GchsFbWnSu2CmlpkgDx1sQMzU4wmCn0GaL
 t8bQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995670; x=1793600470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GNAVyZ6P17QNJ0BN2RK9Xr7zP1Ls34awkpI3WNmJTgI=;
 b=LdbZmH6neYpSkzwYRGlddq5K3fs6LNsbEUtnWML6RND3FvDlSY3UuyKSEdQIKj0i4h
 3sSNWXr23+1vfY7s43dStOGmUfUuLP8GDYweX+ok64WBl6A4gaD+TIByJ6/7l4f3LDXM
 mXJ4BDqsQDrOt4FGDLDnBqLpjqYvxQrw7Nci5hBPkM0HBN6K921IFx9klMtTJ8HeNYTJ
 HTr3tWEU+xH18rmUo/yyFYZ/f6/JbSsSY8ahUHqqMilsH7heIyWcG81b11+ptreQpnDz
 Ghp1KYj+PnNqk8Fuk1p9XAz4Z5wMTE6C7+vWMlSwcq67BHcjsFhJCbifcdj6Zg+ToA72
 G+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995670; x=1793600470;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GNAVyZ6P17QNJ0BN2RK9Xr7zP1Ls34awkpI3WNmJTgI=;
 b=Q84A3spUcV3tBKL4LlYEM6wvFFuYbAYdq3IvyQRK9EKNDL0ABOaDCe3SwwLLXe6G83
 swuekDopOJYZfyqZa3RnTCLo0cK/geitvEdPN5ki279LxeezOzf+bZ4StJ3C3ack4Jp5
 Uq4vVCrMM1rkBe0t/fs6sVRptVWh6SyW3Tj2C77sLwACeISkFKjqdvf9iHq9RevSHGk3
 /95jZ+HW/iqH405XOXPQ5h8ZEXAUglTpykeojsegWn7wtj7cWIneypoRdusBB6naR/u8
 JfDHr2boDIY+nmNbGo0mlzjOTBHB1mDIAlTyIlG+L8chPwHEcEUYWWzNxAzUnl1JJoY+
 K/Cg==
X-Gm-Message-State: AFq9FYKwkfqME1JBheMaXqcDhDV6u6nlVERV5ykwv1wyQvkhKP6201R8
 tjO6FPB8hRnNjyG4BWVLdAbHZYrw8eCyuidwVbwzUca9jPz7sdQiJvuzB3po5yeJzu4ET11+fxJ
 9nWrfIBIsg7Eofn7a2Ay9j2bIuywFhTvBjm+I8y9LehrgvZj7gD+cA7C6/CUljxyyTPwN0I2jhc
 WwY9y8joXkSmUqh1DNsPUcO36MwDJPSYfW
X-Gm-Gg: AYBFou1P8HFtP8lHAbC8Tn8Tutt3Y+yKcOKzztiWyXzp85Cva1n5r7TI2+dJUN/6cVX
 aQyo2ySgCT2brkmO226aNgqGeFzo4rKcxpcNdxcLyEjRsMHoqIWB2x3t6fNSIfc9d4J3tjgHtNa
 40xN5nqM0HvYXb07KthTZNyZ7hAkpYUwQ/ygqrASKg55qbfrWMXJ1406zYhoI=
X-Received: by 2002:a05:6123:4201:20b0:5ea:b7b5:454 with SMTP id
 71dfb90a1353d-5ec230af32bmr1070721e0c.1.1792995669663; 
 Sun, 25 Oct 2026 23:21:09 -0700 (PDT)
X-Received: by 2002:a05:6123:4201:20b0:5ea:b7b5:454 with SMTP id
 71dfb90a1353d-5ec230af32bmr1070715e0c.1.1792995669220; Sun, 25 Oct 2026
 23:21:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260917052250.1041262-4-subrahmanya.lingappa@oss.qualcomm.com>
 <as50cyb5yWynlBVc@MON-LT-C78453.mchp-main.com>
In-Reply-To: <as50cyb5yWynlBVc@MON-LT-C78453.mchp-main.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:50:58 +0530
X-Gm-Features: AclHuK_RSvEZIwGavAaSY6Iu02RIGwfWMRC6mkrId8ncSwBEC_wsWyP_VXqxhmY
Message-ID: <CAPxK-6ePz9nL0m3jDmVYZYKr27Wbg=UWc7Ar03TuX9MFC4=RVQ@mail.gmail.com>
Subject: Re: [PATCH v11 03/10] hw/riscv: add RPMI FDT helpers
To: Charles Perry <charles.perry@microchip.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LgHY5va1ri3KwYyscmAbW7ER6_lOLHxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+g7tH+kplC0q
 UuX94cyD+2LOLGs0PZznjn64xU+xBeZ+84k/ZumaQA1UNqfMOurOV/rVvjL7w7XtEhVEt0KzDpZ
 Ro5ABSnWlqsvUehGV9yHWsYf4I4bDAeoIOtGr6xxJJ/wCWCvM/eqZGeS946tWQN+NQkO7z6GLNz
 2c24h2xPDEkYjQjqSCpt9Rxj76iPJPv11aY7ZO126HRl0Ik2x+/HNN9aP+sFOXj01v7ZqsoBapp
 2dNaIqRKohxLCfkXnbyY9ChKuCJgLmSRC9Iow5RaueY0iZE0aunu+E/nESdRCKDtGXgyigdldVP
 O0k9FERHnWjWAEsW5F8zwCY8C8R+q4b9S1THbqOLWLZFKsCjcqxiTomZQKzev7ZtJ1BLEp1NeQV
 +z+f5pdM0QDY0caqvFahqvjNJNPGK21wNpXqmn4BuAtJzEn8DJDb0amIVpk8vHYDy8pQ+BKVFy1
 61hi6TRJpDeRCHFwBvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXzOK6aoMoW93A
 Z+7lHUVnNvFAG6N0/jK2UXVDmlmHm3b2kTVNBon4FWxQ8QQmG9tK9+WHBrik279Ba5vDzjklYBX
 eko161XZ+R/jX1FT51l/PbbL02Mp+8A=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adef156 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8 a=XYAwZIGsAAAA:8
 a=zSspsWrCrnI3V3ylwmgA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: LgHY5va1ri3KwYyscmAbW7ER6_lOLHxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Charles,

On Tue, Oct 13, 2026 at 11:42=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> On Thu, Sep 17, 2026 at 10:52:42AM +0530, Subrahmanya Lingappa wrote:
> > Add helper routines for describing RPMI shared-memory mailbox transport=
s
> > and service child nodes in the RISC-V virt device tree.
> >
> > The helpers keep RPMI node construction in one place so the virt machin=
e
> > can add service groups without open-coding compatible strings, channel
> > IDs, interrupts, and shared-memory references at each call site.
> >
>
> Hello Subrahmanya,
>
> I'm wondering if the services should be siblings of the mailbox nodes
> rather than child. i.e., should we use:
>
> ```
>         rpmi: mailbox@10200000 {
>                 reg =3D <0x00 0x10200000 0x00 0x400 0x00 0x10200400 0x00 =
0x400 0x00 0x10230000 0x00 0x1000>;
>                 reg-names =3D "a2p-req", "p2a-ack", "a2p-doorbell";
>                 #mbox-cells =3D <0x01>;
>                 riscv,slot-size =3D <0x40>;
>                 compatible =3D "riscv,rpmi-shmem-mbox";
>         };
>
>         suspend {
>                 mboxes =3D <&rpmi 0x04>;
>                 compatible =3D "riscv,rpmi-system-suspend";
>         };
> ```
>
> instead of what is currently done in this series:
>
> ```
>         rpmi: mailbox@10200000 {
>                 reg =3D <0x00 0x10200000 0x00 0x400 0x00 0x10200400 0x00 =
0x400 0x00 0x10230000 0x00 0x1000>;
>                 reg-names =3D "a2p-req", "p2a-ack", "a2p-doorbell";
>                 #mbox-cells =3D <0x01>;
>                 riscv,slot-size =3D <0x40>;
>                 compatible =3D "riscv,rpmi-shmem-mbox";
>
>                 suspend {
>                         mboxes =3D <&rpmi 0x04>;
>                         compatible =3D "riscv,rpmi-system-suspend";
>                 };
>         };
> ```
>
> It's not clear to me what the correct way of doing this is. I've noted th=
at
> `make CHECK_DTBS=3D1` yields one more error when the services are child t=
han
> when they are siblings:
>
> virt.dtb: mailbox@10200000 (riscv,rpmi-shmem-mbox): 'hsm', 'suspend', 'sy=
sreset' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/mailbox/riscv,rpmi=
-shmem-mbox.yaml
>
> Thanks,
> Charles
>

Thanks, you are right. RPMI service groups are mailbox clients rather
than child nodes of the mailbox controller.

The current child-node layout also violates the mailbox binding=E2=80=99s
additionalProperties: false rule.
 We will emit the service nodes as siblings of the mailbox node,
retain their mboxes references,
 and update the documentation and tests accordingly.

Thanks,
subrahmanya

