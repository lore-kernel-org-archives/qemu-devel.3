Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ED5C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlm31-0004QW-3p; Mon, 20 Jul 2026 07:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlm2z-0004P4-Ho
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:20:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wlm2x-0006DW-MP
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:20:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvv6F1910743
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QSYWmlbPl8jGvur0D30SZgMAigihbsNK0PCztApsFhg=; b=HDnODUF/AGd0BDm4
 b0u+GXcDIHLNfBShYaV59Pr0qOHn68rVfvy5H5L5zqG4kB0k/HseOHo00tMLLczj
 ups4rwCmfRHIAhddUrLj/8or6IqRDS4flFmHLuJ4pUc/SVqL2lxZrQmte+75hC00
 6KSIyHQ9zu4pslhq1cGMtUxsJ6qltGb6y5zxS38sLMIqJe6yuO9Zg91VTNNu74j2
 3RxkvYGm+UmbcCUvCdktAEVn/hKxsWk9+78NlH19wH5VOdyiG6mYM7ZTWBJPj18Z
 Qlra+8eRsXZN5JlphtR09UyB9M9WvoyQtEAF2lj7o5VzNS0yh4lIcKOFGF5j1/JP
 M0mGxw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs50jyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:20:30 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7d38b23d6cfso10716397b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784546429; cv=none;
 d=google.com; s=arc-20260327;
 b=pK+ZXPY2VFFyqa/VgDv7zxTCJMdPP5t73o/39b7fZTV2ALk3SAFA4Bj1QItuHM1ZKz
 Ib77V+UgvMoRNkbCw5la5n3kC/W9XeyWXGVV3zkQa4jhk5MndxTagAHEelFDAZTfO/6q
 JCns4AFaMtjrbCVqoHRh1Tvc6QgkObe5YmvQhQ3ghUbORfmIrjOlHm8BJnsHQudhX9lK
 TETzK585LoDOmxh8JTbgcm3hP6E40/78SEGOMBzr0hM4nN9FzMFtaJVgjg+l3wgaMNqI
 AVcPrnQbQV5RI/wBI6AbqqmByYo4whhS+YlzSrlRPfsA/QK84I1erzWC5oUa/NF3oLFG
 qqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QSYWmlbPl8jGvur0D30SZgMAigihbsNK0PCztApsFhg=;
 fh=Ykh1hinT4EwUNa6yKQbKGOhZrrfkasOwKf8D5y/arlc=;
 b=d2DG8cltDB5jp6yDzSSlTmpG0DDGane3YOHRTtn4rYOo5ihYxpQrwZ79HYv76+kzSB
 ZHjfOeVxWaAd6CwJ1/w+6awZqYQxKXdJlGNdN6fjfpFZvzz+AbtwktfQOmc0ySzB+BI4
 bVinzzZYgEFHwVwx6FWUU7q5hGKgf7PMWB6Odq0mzrHGWjlVbu3s1/LF7tCm8/I67OXf
 aSa3YzO7ivkIpJFzmgabY/AKz6dVXz0+r67YPQl5+ViZ2oFVJ2xRjw41gI/6EUzx3q68
 aMFC6GTt0et52TEC8eHS4zfXAwh1uEB91NAVpn/0iPzdU9zUDB/k2rN4iVLpe+ZqgqfM
 W7cg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784546429; x=1785151229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QSYWmlbPl8jGvur0D30SZgMAigihbsNK0PCztApsFhg=;
 b=VQMcmEeHKzO7hTAt+2H8JzCcXkHU7NJBZpE4OWXNUyb+ZgkoGNQwnWLTZXg5qEJiMl
 /++seupowPm86lFAUHqAATLesOGKuXVg1YRqjCYTxhXVfe0IEu2Y06lpA9zpHF9VnSeP
 b/jRJs0qouHDrpIxmb52IP1BIN1QsgB7WcVDAK6nk8azgMyAAWLFbtSEYVBVuvnKst/C
 tin5CoPQMkYlPFRpZSaidlDnREyKHj8ZCgVfmcZYnaaW3arXr37NGWaIYTqAULzMeC5m
 paGbDS2f7aO7g+8eecoaTPTIqwUlEWx4KbTqSmIzb2PVnieJ2RhYV9xUSC00+BiDGwyl
 mEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546429; x=1785151229;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSYWmlbPl8jGvur0D30SZgMAigihbsNK0PCztApsFhg=;
 b=StpNjpgOnhBfRYn4X3pKwz98j14s0cqjKvLUM2Who7tJfphjUS7TRwjQVplNLKDTmx
 ge6vfVt2CdMqtllEEcfz6Bwpzk9R9t15SUR+IivCQnINTbe21DPFE3R46SEhNp/6QfV7
 knaIuE4eLNu6Q73zTyW5IcHW7iXmwCMBl9YQUMC+a5tqZ3X9sBufRE0bwKryh5agbz2U
 nrjzgyhVC4ZFmmN10Mw56f5tCPR6DESpg/CQ2rmPKbzRx8IFYsU16VvkZ/U8mgdn6GHP
 hMK276p1M+eu3viebK7CBtqgwcAY6WPDaxeVeVpNzOBpL5GRjGHS0PYTUCMMR6s65YZb
 1lbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr80uQOZMso2gzfuCOYdJdqdCUm+9pBgAxwMx8jRc5eKbqj/0XEHmOnU3M+8fqU45tSCCcZtS/AXvdN@nongnu.org
X-Gm-Message-State: AOJu0Yz+xN1fe/IUvJW7zrondFSw/6g7IfOxR0lrYlI3E63Xi5ZGmbJ8
 W0GiPSoYA6WPnhGB31eFJuHEoDa2SzQ5bqY5qaiAPbb+TusV7VGVEHaSqcMFCMJymxLPfRHT5vD
 B+/wYMCoAOkQlab53jaeipce0zM34G4cJQH52DfPCaEInybk1Dd6pIk0wL52Miupg7eiRnTXixo
 m2CjjG/nheVulgNTYW21ayrYGHBRTJbhFY
X-Gm-Gg: AR+sD10DNkIu/7YHR/6aZaQzYI+fv99/3V3R6SsYSImcYYJQqTvHDLkDmwZpBOu/N7+
 oZiSX182eFFiM7I6sCn9XV0/9FZ6cOXWiN/PoXaI0Y7fLMr+FrJSFqVsZh4dWIkkZ/gHfFlohuR
 bXpVLwwzNA4o0n3LkwMzU7leMlpyE+7ddPue2I1AcOP9n45Db9aBGTTt9VYHM=
X-Received: by 2002:a05:690c:660b:b0:81e:c06e:58b1 with SMTP id
 00721157ae682-81f20de733bmr779537b3.1.1784546429161; 
 Mon, 20 Jul 2026 04:20:29 -0700 (PDT)
X-Received: by 2002:a05:690c:660b:b0:81e:c06e:58b1 with SMTP id
 00721157ae682-81f20de733bmr779407b3.1.1784546428623; Mon, 20 Jul 2026
 04:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-5-subrahmanya.lingappa@oss.qualcomm.com>
 <3118a11c-a5b5-4d03-8059-c8c66bd9b89a@oss.qualcomm.com>
In-Reply-To: <3118a11c-a5b5-4d03-8059-c8c66bd9b89a@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:50:17 +0530
X-Gm-Features: AUfX_mwGApTt9UtMqmqvyylwbUvw5qZOhQz0INZyv9CMH31l70zLl_60LD5UoLc
Message-ID: <CAPxK-6fLE87h-siwUXf5eqZiaZBZndsKD9YDe-60_ZXwxr8_Uw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] hw/riscv/virt: add opt-in RPMI base support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNiBTYWx0ZWRfX54r/uDRyc+wG
 ydSzd0q9YsszEpSdOBnIZo2uj9GYOWEEClrBcM2mKyPhvKfkgn0ocQCPZL/WYuNCHkOQIY6w+H7
 M1OjB6JHPTJWz/QGxPigMtkKemiU5AQ=
X-Proofpoint-GUID: m0vEPwFb4M-r1wg5yezca7UwUpU1cgYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNiBTYWx0ZWRfX6QDFSEjwctAP
 NAvFO+snx2J6Zzc86ZbZN15PTqtcLLPcbMSzpLlwzUFQSF0Vb6OonxU4Q4GlQzNDlQDz9ACb6P0
 /hzMsxJ6RUuSjGa+nTmWSbvUcwGM2C5LteK4QodSidAkEVRwwUDToqXqw5Ks1UheGvOb5AeT0Md
 SR1mt3RA5ANAI/obLzqMux2QvMc0ff48h5gpv5XbD7Qh2nTKhN4uWjA6jbI2A3K7n/k89MHxq/x
 XHEQ1vzS/nM9Ij3Samt8sBHYvsy2EDHfjcVhhCoiWHFFVyLcivJY17Xl1KI9l2sMZTdqA36Q5u+
 q3+Nk2EFuKrJHzmAsgA+5cu/fMQdMXSRYQQYT8vp5n7O1Hq/1+sHI5tqff9bLvZB2IpdUsWCRuL
 8Yyr+mLOv0w+Dx7WeUCKJTCP3HUQiOzmIXoJxbxUxYSz2f1OyGpxM3xf6dokyEqIAqTYL1gnWrI
 wmCz9+yzLBwzxF0gcBw==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e047e cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ItmM5VYfkUr9BNyn6ioA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: m0vEPwFb4M-r1wg5yezca7UwUpU1cgYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200126
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

Philippe,

On Mon, Jul 20, 2026 at 4:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 14/7/26 09:56, Subrahmanya Lingappa wrote:
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
> >   hw/riscv/Kconfig             |  1 +
> >   hw/riscv/virt.c              | 96 +++++++++++++++++++++++++++++++++++=
+
> >   include/hw/misc/riscv_rpmi.h | 10 ++++
> >   include/hw/riscv/virt.h      |  3 ++
> >   4 files changed, 110 insertions(+)
>
>
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 33775a61fd..e52ccfae1f 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
>
>
> > @@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *mach=
ine)
> >           exit(1);
> >       }
> >
> > +
> > +    if (s->have_rpmi) {
> > +#ifndef CONFIG_LIBRPMI
> > +        error_report("RISC-V RPMI support is not compiled in");
> > +        exit(1);
> > +#else
> > +        if (kvm_enabled()) {
> > +            error_report("RISC-V RPMI support is not available with KV=
M");
> > +            exit(1);
> > +        }
> > +#endif
> > +    }
>
>
> > diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.=
h
> > index cb2658e57e..b5d8a32f9b 100644
> > --- a/include/hw/misc/riscv_rpmi.h
> > +++ b/include/hw/misc/riscv_rpmi.h
> > @@ -85,6 +85,16 @@ struct RiscvRpmiState {
> >       bool has_shmem;
> >   };
> >
> > +#ifdef CONFIG_LIBRPMI
> >   DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **er=
rp);
> > +#else
> > +static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cf=
g,
> > +                                             Error **errp)
> > +{
> > +    (void)cfg;
> > +    (void)errp;
> > +    return NULL;
> > +}
> > +#endif
>
> Could we use a stub file instead?

  Thanks, agreed. v4 still keeps this as an inline fallback with
  G_GNUC_UNUSED, but I will move it to a dedicated stub source file in the
  next revision.

thanks,
Subbu

