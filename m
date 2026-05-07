Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AACCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL463-0003jA-Lg; Thu, 07 May 2026 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL462-0003ik-2U
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:09:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL460-0005cB-20
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:09:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647Gpj5U150864
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Pfd0lGHVayD4LF/bWIJWc3z8
 5rRm5Kr2bGBUIunD8iQ=; b=Gm/ueE2bBshn1beEalIVEui98xSmcVUE/ejNwlzM
 sDD1+VgBq78Zqt+YUEjlS68MHX/kRdP1ABt/6It+NS0NRspWdcCIveS5PkLnEioO
 +abXRawY8TiAVRzxfEP06V5jQQC1yOTViEjrmPf8opwErjL3obiqGNSnvyqd6EUr
 f6xwXAOEIZqFq/7DYGfgXQAS4QgI/rjHtHs774C0qXzKKRTBH2F6gbLihGA48NSg
 JKSZ9xr0BjhLvEi3VdI3FuWuAOONr9FRjM2MGIsSv68EnYUzkhuOC1PCVGMLu6E4
 qwSU3SxPvWvChMRCZ6RlyWvfKma3d6zQxD9ZxfZpfBwLLg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kctuese-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 19:09:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso1581436eec.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778180953; x=1778785753; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pfd0lGHVayD4LF/bWIJWc3z85rRm5Kr2bGBUIunD8iQ=;
 b=ABGtFZ203c8dO9IAaBI0INJrjfpFl2g1FBOjnAo7cUIQNGJKBlGWw7n2jz2eNNUXwh
 sB5xubfMjRlA6yo7UniutvOYeiUphRyq7V+aFsWA4+cIvd+gV5qXRsq/O2mn8XfSsaDC
 M5BlXltJJe2nTLBQTPdhUR/hF4pTXq20MNZlmBIpMuIo2lvgZ4JxhlHBHl6oJ3kUvsIs
 GNbNM2pqDRE1TWrjhpQGNFEBGbynHi12NcKjEXHc7G7+mdAvViK60QAC7qYmuuHrJszw
 /0CJrYZpHO0k1apzoUv7///ZzinERWI33IcyFVZ/z91LBeaMPyWQueGJQPtkhHNOb8pa
 fQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180953; x=1778785753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pfd0lGHVayD4LF/bWIJWc3z85rRm5Kr2bGBUIunD8iQ=;
 b=VC8+Cn4Am+d0GN+gKC1XRNvnqme7el41fpwMi6SKpQXsiwrImCD37uNdGjVzLAyHhv
 zBGN1offAMSoJPNKOOd1Rxhgvzql7D4ZiDn+kQRXLaTzQigWHwwW3uAH9tQIoua62OaB
 cR+NtgR0gqt4tYxY4fd0kVXRFkI74aIOhBoXEXzf5UyMllhAh0/d0b6+sr1D1jLOLvP8
 jOJq2Qk/yg8KyKro6vvchxRdpyJXN0RIpZGG4xD67nf78e8ikHNeXlKH3JyN2Ct7+Lq6
 kTXdjIgRjaUdHibYbhABjoZkd3Z7J3rnIWBZd+iTfAeLRBCkJXFdpUBGToMSzv7HeQDT
 YJzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xiECvrTbgtw1T8LK8YKr/FqWAOb1Uy0K0wQkoCCFREzZdTxGDwferq0UYbEdZ9knWBYAxocdsMxKJ@nongnu.org
X-Gm-Message-State: AOJu0Yw06E08R23hQhNT12c0afL4ZyLYnJYTivKSyIZCgzTqLxvizmYq
 scAw/870ksHVKohmBuXtFJKHFTNqMYl1KEfhB3QmfTIYg5dc4raza+Mj8mYImDQuoQaVWwjSZKH
 Fx2LSaAB+hMnNUJHuhIoRfx+Fbl8B0sJf3tFa7EpMpPtNeL/n3FDYoBbBZA==
X-Gm-Gg: AeBDietkm8vc2MgpsMM7nGFw0YFgZTmEgXyoIb2hLkQUKKWhqPxEdV7g8LWVu/LfIum
 UByVL8T2XUrNXiRE2XdpmOEIKQkgoNi2hfVgD2WBkFl0fAKYKkhTC3dSQUlCa6fp8OYzphATyoG
 6FMsZAIyWJTXgpDCRM9RjWlnQC+Lk5Qk2+1Qytw4MkaPQtq2sypXHAlVJIv0j5efb/BLPSWEy1d
 IpVRXREBkN0VaEe7WPurSWj0p7YIyGdR+qwaPvt0OZny/WyH5q6PYHR9id27EciEP8JiSlvrJJi
 DET3OhnZqc35bUo4tA80RAgmNKP/4Zib4IoP1xwiSaLwBuwpw3MnROqNeG+8mvF917x6eUh7QwW
 MOlM6IJjm0OuofaiXtHdghi1gw0zoYOczhqvqMf5wFA==
X-Received: by 2002:a05:7022:6990:b0:12c:6e85:505c with SMTP id
 a92af1059eb24-131967d531dmr4912044c88.4.1778180952823; 
 Thu, 07 May 2026 12:09:12 -0700 (PDT)
X-Received: by 2002:a05:7022:6990:b0:12c:6e85:505c with SMTP id
 a92af1059eb24-131967d531dmr4912012c88.4.1778180952211; 
 Thu, 07 May 2026 12:09:12 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1326bec95f8sm286489c88.6.2026.05.07.12.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:09:11 -0700 (PDT)
Date: Thu, 7 May 2026 14:09:10 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v5 2/4] target/riscv: Add server platform reference cpu
Message-ID: <rg62xr7os6vkemtqcaqw7kwahde5cdxhurjm6pvi2s6spewhaf@6nvg6fvjczp2>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-3-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKMmYewFC+nJtnwboapFZq_395kk9KeO3_zoC+WMpZfcyg@mail.gmail.com>
 <35d2eb78-f308-44da-9fd7-0a4ad48ab5db@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d2eb78-f308-44da-9fd7-0a4ad48ab5db@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fce359 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=M4c6O8H2SWyNJFVLud0A:9 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 7C0ElENFhtanGx9D4zhDa1C_2MPHDWga
X-Proofpoint-ORIG-GUID: 7C0ElENFhtanGx9D4zhDa1C_2MPHDWga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5MyBTYWx0ZWRfX6hFj5EvRwFM4
 CQPD9LRNsS4igvcYhgiIfjhyRqbB7R/4PdXVosbyE5o216l2OvIkk9wbosLFGiF98Oa9LG8J634
 3yvKjZeITOVREKboT6HazqjgYOJoyT0nowSU4GY+l6UW7+BIoEBQ9l0sM/DNO2/V+Ox9bN15ZTw
 vXduG5lP1NEEyUmxX+w2akZYJ+n9WZt9hCaQDxiEFSujCWaszOtujzZtjCu3OKjwwJScm/1RjxE
 kJLNmUmhwjJNA7glmiqrM1/3JUXj4zcyKe7XremYnopjGMKvSP+Lmq8DnbM2U/lT93vRSL3vscH
 nujD7CCmuqap96f0MGJyZfkFcwrYl9kzsze/+K1WkOZOHSxivuXFXYdqftRH00x8RMJdaWTLY0S
 CwkTn4W58R5FY/MirGhQZeqhUIkcv0nIay8/c3U3L976kLZciLwcHnJKCdwt9UEhx/m/2woVm7u
 sVWOOZLabzqSDGZB8LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070193
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Mon, May 04, 2026 at 03:43:30PM -0300, Daniel Henrique Barboza wrote:
...
> > > diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> > > index 30dcdcfaae..a150acd151 100644
> > > --- a/target/riscv/cpu-qom.h
> > > +++ b/target/riscv/cpu-qom.h
> > > @@ -42,6 +42,7 @@
> > >   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
> > >   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
> > >   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> > > +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
> > >   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
> > >   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
> > >   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 586683b28a..4b59dcabff 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
> > >   #endif
> > >       ),
> > > 
> > > +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> > > +        .misa_mxl_max = MXL_RV64,
> > > +        .profile = &RVA23S64,
> > > +
> > > +        .cfg.ext_zkr = true,
> > > +        .cfg.ext_svadu = true,
> > > +        .cfg.ext_sdext = true,
> > > +
> > > +        .cfg.max_satp_mode = VM_1_10_SV57,
> > 
> > Why not SV48?
> 
> I tried so hard to come up with a good explanation but failed :) from what I can
> tell in the version history we changed it from sv48 to sv57 starting on v3, and
> never looked back.  There's no apparent reason/discussion related to this change,
> therefore I'll assume that this was a fluke.
> 
> 
> I'll change it back to sv48 in v6. Thanks,
>

Yes, we want sv48 here for the default (base) for the same reason we set
the rva23 profile default/base to sv39 - it's the minimum mandate by the
spec. That allows users to test their software on the default model in
order to ensure compatibility with all conforming implementations. And,
in both the server platform and the profile spec cases, additional,
optional extension support is allowed, so -cpu riscv-server-ref,sv57=on
should also work.

Thanks,
drew

