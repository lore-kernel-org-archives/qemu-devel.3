Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D94C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYDg-0006Kx-Cr; Wed, 19 Aug 2026 00:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYDd-0006KK-6o
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYDb-0003wv-Eg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:48:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lOss3165674
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 64scJ1fc/xJBOSLi6cTYshkTo+LoalLzTKb8lxfzxRU=; b=bFOLYl7x7Wg8l+w3
 NVEWsdEAIy8Yjuf+NKQB59F9Nep4h/G6ZLpx7vV9qbgNe7Ce0VBloQWf+Xt+1edT
 XIhwMZ1PmJZQBAf2KpFMT/5b+LCYaPESBNH+B2KV8WuApShH3DTPI3Mpe6+mQPJN
 NEaF15/oJ6tVFUDlv5yWkBT5IW6v4Po8J3eUtxWri8GW3gTCJrLR5VV+BqtVU8JZ
 8QBp3WDZOZfnvPzfw/akJjuhgqVLaL2Qq08keVBoLh21vFZTLkEIt1C2P41XJh8E
 c7JbXKbNSWghP/XtIjKD227dxzv7A3azlyXi4ec+oK/AiOhDYBfYDcHaD+QIc566
 tEaPjw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yftsc85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:48:01 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-73761f92dd1so6658137.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787114880; cv=none;
 d=google.com; s=arc-20260327;
 b=UHWU+DfPAXik0LUG5rh4AwdiVPVAfhI0NQ/KNtrLsr1TU1gJTQeqdTR0iDH0LDeKL1
 PVJYH4YQeRDdJkpKgtwfzp4sq+r+zi2kjuwjgThFFh6kF8tjIAFJyzqq5Vir+DJ91ESH
 chO6vsRXKcp5r5FPDf5R/HfEbw6imYZLp2Z11vZ2Qu2Vw95aaqh1OLA99+Bh2hFlNNsS
 pVT3sdsI8UI5Gm/f7sDMWuzKmBG9W4g/JjnMki81vsW8zZ7yKZLxZzGm75AJrc5UirZ7
 ziQCrgBLAUrfD4vlSDy1xIPu58fAcM7i4R819GFmex8zALtpugejSxRYKWL0bGsQ/GmX
 CnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=64scJ1fc/xJBOSLi6cTYshkTo+LoalLzTKb8lxfzxRU=;
 fh=IANSbjLrlp22k+B1svCG8esEbovDd/OUnInJ6GKNA88=;
 b=WzTzUGQq3wsaigJkKGl9kwsTRjWxHi221dnrZttOrxvqEmEIulM57osk9kfAxlxMGB
 PQMUOcsUyo6evUyD6DkAoRvmx/1ojNbSg5c67749pauEw62MOk8z9+ZFo4ZhFbDGhM4f
 n81UuqZ8EQQ0lIiiBDUa3Pjso1XpY6weGm8hdnztZFz6SMIc0Fac/W+eicairrW5uk3D
 QgWihTvBpMyfVprV4e7q+Lh8SZ1DKaM69gz5LAtvggK5z1z8Bu2Q4I1byFMrvAq+VtCR
 D786AMZeINfh9DzP10+TKZjTE0l0A5Ag6EIxOZv30wOTtHx0Rtbrn+PK0Ct76ShA44Fu
 zvEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787114880; x=1787719680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=64scJ1fc/xJBOSLi6cTYshkTo+LoalLzTKb8lxfzxRU=;
 b=gmJ4Y3qwxSBFo4JgaBkYVehS5X24e4Ewq48tRAnhW2NnV6jqBRFbOBK5Wgv0hgNMUM
 Al3mozxrACoU2I9T82qPhCgr+GxNLxOarntvnqb4XEnDEsujbysIUhRz3HMD7X0unc0p
 Zctf6UBUUrPzqQkezvKr0Q7ijemocHejkeVM12O9FOZBoZsf33y3hb4uJnKsxuTh7oe4
 pYawb05vBCbu9GRhmiuI5FSTlieBKJ+M0NtiYhnmeengBjyhUDXD166Czm8Yklb9L5hy
 YZsNP62GhX/1XncwFU1CAkHo4ceVjlsDO47Z2eWiOCZIgQROJ0xPvoqwWXk6ROtBvNua
 sM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787114880; x=1787719680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64scJ1fc/xJBOSLi6cTYshkTo+LoalLzTKb8lxfzxRU=;
 b=YKnsxQ2gIYNC5nVCT/XxrkGdUbeVwIXQSBDo0VTsAYdatgZMC2y21RbkGSEKSq68t4
 NO9pS9IdJTCVPTh+Tr8cT3aD5bUgGvD/r3zXOaCcnCOq18abHIgPGxOhDXGN8Kzho7TJ
 W2I6rSHuXZ9d4uCBGDTLZeP+cHYF2RmNjXwvSIKpO4dXJuLPZXbzgQX2CLCFn4Q8gGNT
 T0zd1cm4tH6TAlF16I0X1+66eg1fAIGaaXzswYlQtc4ayf4uYcTkR+oqGcfc04qW9XI2
 +cZPdPVhFp7A7mZyLe7048C/shnWhkDSUMpIAnxGyRoM8Uo0GERAwijAB9pdJQ9+GPjf
 vdzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUKByzDGrExsP4SezioStCe3fmDwaLYRHe+gnJfpzd0H9Ain9RfAgLJ92mMHSurl1p1w0YBcsmNpQq@nongnu.org
X-Gm-Message-State: AOJu0Ywo6W1YCCamyBF8cbPC63NV7PkCBvLCwLWkgI/CQxeRA0lTQERS
 i9UY/k2QNxECOIm6t99+aIqTSV2FEFw5EdyyDRv1L1G5LVjNlt1WFbQJQ8FZL9iQFy64JhBK1uS
 iAAel3xY68XO67ihRd9dOVF22VYGUKvkYXH2dgRNRomTJhJdVny7EZ7iCKPdk0JoMZ3xiwpjur8
 Daz4YiXtSmBo9eBlfuyAu1CcC3Fj242Q3s
X-Gm-Gg: AR+sD12ukUquyaVsJWFpComPTzVI/SXMU0nP+qA/ezf0MJTOn+k6cnAdJIeEaLPmsgL
 soQ2XFrhbngzf4bHUDC4gQWAmGI6TEEkzMLEfX0GlWhUdOEC76zQs9qF3aZKThGYw5paa1OrG7m
 a2nrXznbEVjorxO/yFtZDUnzlj+YP4HBV5xRrZBNgWnvniza0IfjO+cTytcs4=
X-Received: by 2002:a05:6102:2c15:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-777faba447cmr188598137.1.1787114880376; 
 Tue, 18 Aug 2026 21:48:00 -0700 (PDT)
X-Received: by 2002:a05:6102:2c15:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-777faba447cmr188592137.1.1787114879990; Tue, 18 Aug 2026
 21:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-5-subrahmanya.lingappa@oss.qualcomm.com>
 <CAB19ukGHNA7KwDpgeucPoy0h2OThHGL7LqESDeY8f_moxPGyUQ@mail.gmail.com>
In-Reply-To: <CAB19ukGHNA7KwDpgeucPoy0h2OThHGL7LqESDeY8f_moxPGyUQ@mail.gmail.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 10:17:49 +0530
X-Gm-Features: AcwNN1WurUbtvHsXOe7_ghZyear-8vUGiyeWd-Uroi8UDPl2GPRI1P9LvazQZTw
Message-ID: <CAPxK-6dwyzkCV8VUTD+dyMqKd0WeAPB6E4zh2w5dEGGFJudVrg@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] hw/riscv/virt: add opt-in RPMI base support
To: sunilvl@oss.qualcomm.com
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a853581 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=Ak59p1GQuooY577Z0c0A:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfXxtcRQ2Ba23B7
 PG+sdWUZ8q32BoObID2XGT8gUG//C72NaqkMyk8JqDeKcnT9/8LwCH4T2M+eOEh8spm6OGX8bqb
 KGKHdToclpjyHWoPAGQfSa2gRCxOUss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfX0TeIO6s1I/WG
 wfzzNvhl6fpNS6RbeLKWB+qblgZ0f46iR/oWrJ0i8sgDfbuDy3/rxn32N+lBR0uhUGsVgfOfOwV
 m3sHClOx4CKIaltK/W9/jC5MPFFFOjylw8g6ZubcZjMZGoxmoS85wgDeyKZ2AI+7dSoKx43Yh8h
 XBS97Y/EmZjoJGuJlj0TIKupmB6+V103IJ3l9sDgh0tlrQyLkR4IEOtsKvP+OTtGtoPnOx+AdPW
 865RYuJ4TP398/HaU7WJVrnqIpRZFqLNI/vC9Yzgyt2RRRfIYmuLYQfp0w9UIVXmhOIf984YPM9
 fHQnnMUB3Kl1f8pT/FxxlwcYo08Y+YJ5thXvywOCO5wZP7yq1/JSWRzGdqZf6Pspp0w+41+au9s
 Mn+3uqMsaYszdhQOaThMUKK6AeGpByQkMvHzgDqvzg1XYxOBxLY9b2X3izhAm2Tl60vEAmYs8gW
 l90KxNdRxPb9oZBZKXA==
X-Proofpoint-GUID: Z7duLaZ2CfN6uz9zJ-uIHhJVA5zsvZbV
X-Proofpoint-ORIG-GUID: Z7duLaZ2CfN6uz9zJ-uIHhJVA5zsvZbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sunil,

On Mon, Aug 17, 2026 at 2:07=E2=80=AFPM Sunil V L <sunilvl@oss.qualcomm.com=
> wrote:
>
> On Fri, Aug 14, 2026 at 10:25=E2=80=AFAM Subrahmanya Lingappa
> <subrahmanya.lingappa@oss.qualcomm.com> wrote:
> >
> > Add the virt machine rpmi=3Don/off option and wire the initial RPMI Bas=
e
> > transport into machine realization.
> >
> > The option remains disabled by default and requires TCG plus librpmi.
> > Invalid accelerator/build combinations fail during machine
> > initialization. When enabled, virt allocates the RPMI shared-memory
> > transport, creates the RPMI device, configures Base service metadata,
> > and emits the corresponding device-tree nodes for firmware discovery.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >  hw/misc/meson.build       |  2 +-
> >  hw/misc/riscv_rpmi-stub.c | 16 +++++++
> >  hw/riscv/Kconfig          |  1 +
> >  hw/riscv/meson.build      |  4 +-
> >  hw/riscv/rpmi-fdt-stub.c  | 37 +++++++++++++++
> >  hw/riscv/virt.c           | 96 +++++++++++++++++++++++++++++++++++++++
> >  include/hw/riscv/virt.h   |  3 ++
> >  7 files changed, 157 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/misc/riscv_rpmi-stub.c
> >  create mode 100644 hw/riscv/rpmi-fdt-stub.c
> >
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index e7c2ebe28f..92c9cd6064 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -170,4 +170,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: fil=
es('sbsa_ec.c'))
> >  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> >  system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
> >    'riscv_rpmi.c',
> > -), librpmi])
> > +), librpmi], if_false: files('riscv_rpmi-stub.c'))
> > diff --git a/hw/misc/riscv_rpmi-stub.c b/hw/misc/riscv_rpmi-stub.c
> > new file mode 100644
> > index 0000000000..dc32b43227
> > --- /dev/null
> > +++ b/hw/misc/riscv_rpmi-stub.c
> > @@ -0,0 +1,16 @@
> > +/*
> > + * RISC-V RPMI stubs.
> >
> Shouldn't these changes which are outside of the virt, be in a separate p=
atch?
>
  Agreed. I will move the generic RPMI stubs out of the virt machine patch:
  riscv_rpmi-stub.c will be introduced with the RPMI misc/framework support=
,
  and rpmi-fdt-stub.c will be introduced with the RPMI FDT helper patch.

Thanks,

> Thanks,
> Sunil

