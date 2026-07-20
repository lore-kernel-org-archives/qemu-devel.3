Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C47BC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmmI-00085w-KD; Mon, 20 Jul 2026 08:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlmmG-00084E-Hf
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:07:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlmmE-0005r2-I4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:07:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAw2pW2377635
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8M/iB3BYcAwU+sx5HK7Ou6wNWTkxnYicJonW/GF/nAo=; b=NLVZq3gwt2k/HOvK
 YAjfqgqg+dWi+6h1zLvCMIXSUkyJ5YFr/j79OBSQof9MZA5EwyzdzW8wXbCYN+UV
 ulAu66//AbcdEuJmkcXibvh30tDzRDXOuC5tGQkWfF+3utP4R6gidlbLM3PdNb1b
 xxweC9rLEsQZGKzORXRysw9XtuOKV+TgfhxTTtjCiwWki3uUwOxagKBN8+aPmzTE
 igTbeULfLd4t4mP8Ifo3WrDfclZUYdyjw1OZBk6siuo7CWjZYi7PjWR99mAcXnpA
 LVaVwXXGBPRMCKeuSQrYVwylZlEzKxoObg27MNDr6y/z4VMUvf6QyRceT6PluBdb
 iZl+dQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre8s0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:07:16 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81ee2f3ff06so6512527b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784549236; cv=none;
 d=google.com; s=arc-20260327;
 b=s0vyvlSdnFhbxraIX1UQiK3URQ7L8yfH8b3SBUqVA5BKHz5/L/IGu2wu6C3J6lPLfy
 cE7RaUBtLxIBBqHZ5cUnmXwlW6fTekMomRhykRHXwEibl+yrumYwc1RUKziMyF9S9Ots
 ivI71h1huZp26bXFR3i9ye5qD557ceF3lR3WYmnM8LMNBL1pr8CSSq1OLt/hdJ/lsGUd
 vS2fyS6WSiMBiZ6M+jt16C0truIgY53UkxWZb11I0akXPBA9F1sjitFKpKXXcOsuMZCx
 T1bkUWUBH/fK2piG/KriDp5WaTXALbpK+qQpHN6d76yTmQZ1miUoUXmXDdcI49pWehC1
 AB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8M/iB3BYcAwU+sx5HK7Ou6wNWTkxnYicJonW/GF/nAo=;
 fh=/tL3h7vxZmiHj/cDG4sYXtl5Vatj6avJsZPFg1nfaec=;
 b=mMdyIqB7PkhhEvO4PZF3uBad3E96qYjUwp0ppONiYXLvShc4iYh8mzrlHcauT/5tzu
 PUFqlvwaPVYF78S1Mr7Lf2e0A/IVOYAUvO+ruw4NWTJKyv89AbX+ZgaZ47i6jLrwOpIP
 fUisGbhxM4QjF4ZU2Kvzfw/WuMM6CggL6aw2U6cjYRhnpie9CIip+Hy/r9A7AKYCETT+
 F6RDubj3AVhuElVzcJgPDuMUCpdcF/Ai0E86VbIwE9RxvoceCsV3TfOGu61tlCLcYJ2W
 faMjOVLEMbnQyebpZ3+PhA8S4HCBlC3wIaB1r7W8ngWrqg8BCSOeRPoSgrA1l2Cs45mB
 8Hcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784549236; x=1785154036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8M/iB3BYcAwU+sx5HK7Ou6wNWTkxnYicJonW/GF/nAo=;
 b=CuAAAAOCZtyd/8qHB0awITEJEMivdtDHbsx4C4SsqYorjHW67QkbMpVD1im+lN7/0h
 S8pNcvsxX5Maed6YBxtfoiRRZbKs5V/AqC/PCYvqL+5eGJOeU5ICZELvr0PYKBRdtAyA
 q2JmUwQ+lGYLg1rc87sPuX8lzLCDa7i+6ZDXqwg68Ef5/IQ7ktIiEJlzuE0Jyagy+j/U
 UgYIEf//oimWsxOS97cXu1UW1YfLZt6kHoKOGxYqgX7im1hDLfAJ4II2xYrHERVip/8v
 QLV+AozOZmG9kEdFzFeZ+bjPmS169K514jE9tPjU8r7ecHDNFKJr3BG//BsOBfys54Ps
 XKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549236; x=1785154036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8M/iB3BYcAwU+sx5HK7Ou6wNWTkxnYicJonW/GF/nAo=;
 b=V3CKBAR+kOXbuO9q3w1+6xzRn+zTsrjxxObuer/nARM70/d/zgvOqY+w6Sq7QV3/9P
 7ZS35Vx1MzkX/330zuXIYZOqGMcl8Xo6f5dV3hI+euvh9XMkjOB8ZSVIxv4EP46zle5b
 P9rYSo06kXmmvPwoWWeRdeIk/xNPA9v9zIzmlnR4ylSPn2zkjl6NyV/uXd26KocsxQNu
 Tn2vhuzNy1OQ8jaun7RqLn6r0ISeYSE9J6kg1iceZrDcRfg2os7s3jOjAbGuXrk417q/
 kDXN+gK3yUTyZAOnrihiDlbkqbMz5ku2XsfpHCUWPIPPMBmqdPK8/DcZuMMZlWCeqa01
 pdYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rprv3fhV4JbYgNfBM31rLXcY/i1GGmcy/opSaNBUReSNReeDrsvosREdF4PJYrubUnBkLq1RW/O1QJB@nongnu.org
X-Gm-Message-State: AOJu0Yw0iHxNoQ/hI45FONoBFf0YCtEMBCVtwhdkCTqmOe9XvlbIgC7p
 tEySiDha7xW/iMZ2N+cJ+MoWq6bsc39/SKklpao9ex5wn8r39NE6MvTK8wtC648DIGjA/69gjoz
 oQEM1mDUpybSveIOy9VLdLdnUETZQ70RxNcEmxCFSkHul/J++ECuzCEg+UwZKuKxnYIjsGPk+TT
 wnPZEqstn4Ypb/8AgZ+LWFw6RUFcIErzuh
X-Gm-Gg: AR+sD13tSBekzKclNPrmewkiVGx3naT6v9GZm3L2Yr2LJ4I2yBpMWqx7HeI+dJcZy8+
 OqTERJJ9L3SQuHzmV8o2bNDDijIyCCi8n5k0VFJUJQjb6MZgcRvdXADO5Gy4w7DUBXmKDqWRcGj
 w17VSC1K7B6Mb3ZixXZPcC2UjUrGopJy8AmeOBZNH9thIbz3Km1EIZKeotVq0=
X-Received: by 2002:a05:690c:c4fa:b0:81d:745d:6815 with SMTP id
 00721157ae682-81f20f76a26mr1114027b3.7.1784549236430; 
 Mon, 20 Jul 2026 05:07:16 -0700 (PDT)
X-Received: by 2002:a05:690c:c4fa:b0:81d:745d:6815 with SMTP id
 00721157ae682-81f20f76a26mr1113907b3.7.1784549235978; Mon, 20 Jul 2026
 05:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-6-subrahmanya.lingappa@oss.qualcomm.com>
 <a3eea16c-9d47-400e-83ca-b59b02dca5b7@oss.qualcomm.com>
In-Reply-To: <a3eea16c-9d47-400e-83ca-b59b02dca5b7@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 17:37:04 +0530
X-Gm-Features: AUfX_mx3fC2WjCsKKv3ewVYeiDJCfpeD4pWhavdoniB1dYPSuSMFzxe7jTjCpHA
Message-ID: <CAPxK-6dpA5BHEtNL4wd0EY65tA1Wpg2aAeM7ESEAwLwma6sASA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] riscv: add RPMI system reset service
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzNSBTYWx0ZWRfX8GAmiBylB+nU
 EwAws3Jw71GH9gfvSYJQlvZECAEGpL7ly/oBx39Kmka0z9Jx+7OtFiUgyetBNCJe1dXE873Rwb2
 7AwbFli5wjaMAll4fFOdw+Ndn04QtF8=
X-Proofpoint-GUID: qX_FUA4LLjtu8gzpU_PVGjAEk7DwEtyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzNSBTYWx0ZWRfX96QkFQs1Beb1
 gMb1bvnWvZ/aueWLnP5cRE4WTy45VxLPNePRBk/YVYDK3vuo5DBT1ZG17wfl5QEc/yweMpB9Dc/
 6i95Qxo73dG94mtA1kj2p0HOvZKvmzTrZzCOHdys7ds0XvuRz62wLFLBiBWMhweLvBO9NpICuyT
 G8e3qpP5PS7qu6FulEQ2w2S6xj2XmoK0LAWGb7kwiyD3k01HaioW2yZCPzzmqZU9zj1vasTFMaO
 RkuMROa21I1sVPLzIQ2GxJ++Gf1OYOFrj78t0yX1q/+aycdOfFCGFUmsB+snc6G7Iml7aIZOFmf
 zG2a4Nn60ALLesJPzufOVIr2Xg6NtglLzoGYIQZGEqy82UUHmQAuN8F0vUuoZCV4zJHPVERap+W
 A3BpVDQT70VyTz9SrwQNSvdNG2bE3lxeRSOlGwh3/3WNF+hfshUgy5sbi4CnEzFwPjl+oCBjn6/
 mJZGSfCIsiG02C6+hrA==
X-Proofpoint-ORIG-GUID: qX_FUA4LLjtu8gzpU_PVGjAEk7DwEtyr
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e0f74 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=0-kEWU25KoZTyFKMV0YA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200135
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe,

On Mon, Jul 20, 2026 at 4:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> > Add a QEMU implementation of the RPMI System Reset service group.
> >
> > The service advertises shutdown and cold reboot reset types, validates
> > guest requests, and dispatches accepted requests through the machine
> > reset and shutdown callbacks. This lets firmware use RPMI reset command=
s
> > while keeping the board-specific reset policy in the RISC-V virt machin=
e.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >   hw/misc/meson.build           |   1 +
> >   hw/misc/riscv_rpmi.c          |  38 ++++++-
> >   hw/misc/riscv_rpmi_internal.h |   9 ++
> >   hw/misc/riscv_rpmi_sysreset.c | 206 +++++++++++++++++++++++++++++++++=
+
> >   hw/riscv/virt.c               |  40 +++++++
> >   include/hw/misc/riscv_rpmi.h  |  13 ++-
> >   include/hw/riscv/rpmi-fdt.h   |  11 ++
> >   7 files changed, 313 insertions(+), 5 deletions(-)
> >   create mode 100644 hw/misc/riscv_rpmi_sysreset.c
>
>
> > diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.=
h
> > index b5d8a32f9b..d11db87731 100644
> > --- a/include/hw/misc/riscv_rpmi.h
> > +++ b/include/hw/misc/riscv_rpmi.h
>
>
> > +typedef struct RiscvRpmiMachineOps {
> > +    void (*system_reset)(void *opaque);
> > +    void (*system_shutdown)(void *opaque);
>
> What is the plan for this @opaque argument?
>
 The opaque argument was only future-proofing and is not needed by
  the current virt machine callbacks, so I'll remove it instead of
keeping unused
  callback state. in v5

Thanks,
subbu

> > +} RiscvRpmiMachineOps;
> >   typedef struct RiscvRpmiServiceConfig {
> >       RiscvRpmiServiceKind kind;
> >       const char *node_name;
> > @@ -56,7 +62,8 @@ typedef struct RiscvRpmiConfig {
> >       uint32_t a2p_req_size;
> >       uint32_t p2a_req_size;
> >       const char *platform_info;
> > -
> > +    const RiscvRpmiMachineOps *machine_ops;
> > +    void *machine_opaque;
> >       const uint32_t *hart_ids;
> >       uint32_t hart_count;
> >       const RiscvRpmiServiceConfig *services;
> > @@ -73,7 +80,9 @@ struct RiscvRpmiState {
> >       uint32_t a2p_req_size;
> >       uint32_t p2a_req_size;
> >       char *platform_info;
> > -
> > +    const RiscvRpmiMachineOps *machine_ops;
> > +    void *machine_opaque;
> > +    struct rpmi_service_group *sysreset_group;
> >       uint32_t *hart_ids;
> >       uint32_t hart_count;
> >       const RiscvRpmiServiceConfig *services;
>

