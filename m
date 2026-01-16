Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D255C982E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgoEA-0005JG-W6; Fri, 16 Jan 2026 13:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <radim.krcmar@oss.qualcomm.com>)
 id 1vgnUX-0001Pg-67
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:20:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <radim.krcmar@oss.qualcomm.com>)
 id 1vgnUU-0007me-UF
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:20:08 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60GGUpKX2819336
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 17:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W96UABtj7tcOoiAaRJiGlzodP+HrKtCOZfFbVkCsoIw=; b=LeirGg46QtJlFdjp
 bJ6XH9I+/JSXKShGMth/5xU6Ehn/A+XMuev/Hy8jie7gbhlA97PNqiEljQHw3XOy
 Jkvo98cD5aruY+aYHvK4YCYFg71eNUJ5lr4NIL+4g+9TbfdajOd5OdM3j2cp6s1n
 wlpQi3UWDeoTQHjD2Mo+hjS20dCVnZ4sNJz7iQSQHk4vzeoFsXW4O5R3VDT7Aq/E
 JwzNlXzTa0fE72kRdvLdCxPdrrEV0KbzvyMbp7quz8nymbJ1z8c/XZuvVkMtqjmg
 cvqldxap56HCcZCstkb4cnbL8RcAEA0ywGn36O8YalY+jVKMEjUF1xxBnNnhoYTM
 bL41UQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99ak0ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 17:20:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c2a3a614b5so563369185a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768584003; x=1769188803; darn=nongnu.org;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W96UABtj7tcOoiAaRJiGlzodP+HrKtCOZfFbVkCsoIw=;
 b=e87O9d3o1ZEuToQRxYhRID39QYYZPMB0QuDnyRerPl9MtQEGaZTYo+/J66I4lboJEU
 KJy+YalaE/HBgOlZI3YHcp91fpdst5oA4tPOZSmI2Z9t4tTLXMMFv22ecurzoDAw7sI4
 5ZJv05qT/8XIbqt2zbKLucvX0MxfO/kkGdOfYsRLflMAxa69tCxcb5Jj5tVCKj3Qx2VG
 xJcgD7/spAY/nTBmbQZSTHUmaGIpxssajn9OAgvyayD1iuuNB6SJ8wDJbRdM+8ypbyAr
 6nDLf4wPhPuiwUbbAjQ6YCuQAZEmsZuSpTPsSpfZH4CjXtf5DpXJt062F7gdRAXZQy2F
 vhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584003; x=1769188803;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W96UABtj7tcOoiAaRJiGlzodP+HrKtCOZfFbVkCsoIw=;
 b=un0F2yc6+VkdBNUCDs5C2O4idsNTnY3ceSj5huR9DngWxOUYcAy0JaZ5f3HSDVL0g6
 UKFf+JcRfA8O6W9kU+yZ3EjOkwQAybWkU+yr1cDpAGT5YehoDW9zH+n5trGv5XBRhNfa
 ZSnpYHdeDLDfknWVfd/QANPeBbSGTePeK0nTxRKwf8dvkj1hk44Ve34236BNfCQ7wFbQ
 L8bftkEorKUqf9cwqXcU1/ljWIe7qMmKMgvDqBr8zi3X635D+WDUqrQotXGSaC9UXQDG
 WMsu8colmU5R2g5hVIRy+lD7xe+mOZ/f9pqa2Jhvu3P0l3VFrR3KMjh156liHCIIY2dy
 EdVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuiok/wX/OV92g3j3hc5l/oSrXfOKD/vNVgI7Qr5CUZv2e+TR2XL870KaEwtj+TiHlM4ab0sJOtYUX@nongnu.org
X-Gm-Message-State: AOJu0Yy+KSif9afdQW+9UBwyKCBIiq/u0RIMoGYF+7nBqxiomtNQ1yZJ
 +2RfGQmOvV10nZ7erz9K+D4licZFx97MAWJB2ARo5EQShFM1TsIgOXWkMtGQbHJJacHH/LRrpb+
 OumbYBTKnhgtHDCC4M7qxJcf0/Wk+Cmf7he3jPfDXayE3qeM6DzJ/NkJwaQ==
X-Gm-Gg: AY/fxX6bFoxpL1OSOIWBAe77ppR9qp33nB84A+h7xDzLTzpOBNuRNVmoqhTTXhsZWh+
 K0nyFcs5kraegAtYSAJbyh1vxpacKcnyBLeW2Xr983rsjWLaFJEmVTNaWBzm8WPgWSpMah66lq3
 6qaMNsn2Y+aILL/mv9BIo4Oi9plG8BT3HQGp9qZSs1T1CnNw4BSTOznL2ISwPobO+JXhxpHEYgc
 w4MpxDAPluZvmpuVUVtwq9RCnMnVlM4EVP63fHTxLsZIdg501iZn0qZg4L9W9NmsYjsZcC5bVKg
 wqBHIXgtb2f/6FGDwxFUWaXtRfSNnFAG6II9buN4dw5c9OAbsZGfQhsh4blJ2iduMakj0HI4NrT
 NuB9AkKKYTlIzYedrIK5l01+9duYCIvKrJNFyMMzqSWTRtDwp
X-Received: by 2002:a05:620a:7103:b0:8c5:36be:7c20 with SMTP id
 af79cd13be357-8c589b84dadmr949656885a.3.1768584003369; 
 Fri, 16 Jan 2026 09:20:03 -0800 (PST)
X-Received: by 2002:a05:620a:7103:b0:8c5:36be:7c20 with SMTP id
 af79cd13be357-8c589b84dadmr949650585a.3.1768584002819; 
 Fri, 16 Jan 2026 09:20:02 -0800 (PST)
Received: from localhost (ip-86-49-253-11.bb.vodafone.cz. [86.49.253.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879bd278fdsm226646966b.28.2026.01.16.09.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:20:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 17:20:00 +0000
Message-Id: <DFQ6PDOR5QOS.6B2ASHZOJ0U7@oss.qualcomm.com>
To: "Drew Fustini" <fustini@kernel.org>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/6] hw/riscv: implement CBQRI capacity controller
Cc: <qemu-riscv@nongnu.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <Alistair.Francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Nicolas Pitre"
 <npitre@baylibre.com>, =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, "Atish Kumar Patra" <atishp@rivosinc.com>, "Atish
 Patra" <atish.patra@linux.dev>, "Vasudevan Srinivasan" <vasu@rivosinc.com>,
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, "yunhui
 cui" <cuiyunhui@bytedance.com>,
 "Chen Pei" <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
 <20260105-riscv-ssqosid-cbqri-v4-3-9ad7671dde78@kernel.org>
In-Reply-To: <20260105-riscv-ssqosid-cbqri-v4-3-9ad7671dde78@kernel.org>
X-Proofpoint-ORIG-GUID: 1HfQWNq0hGbbdbtRBORmzqSMbDey9KGT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyNiBTYWx0ZWRfX8Lw4MTLbNPme
 Hn/os06LWz9PwVKEPavIN/OVt5vZ0S9nQNli/V0WTebqouYmK+qhjEKFhbXjOmGXkiQEsexUg/i
 sPAo2dqQo0eXNp1zhlMsh9oLkXrZNLCBXAThj4mMOOnAz30NJXPo+2toEC9qMXPDV4yoIrto2Zg
 kWcr3DVjTIo4ju8XXDBEgSPO9T9r4IjkviJQaFw7s/Jl/nE4IlXDo7+AybZOTcT8IqB9tSctRJ6
 hvEUbVsMqeVbnBxBb1+qPFr9qfJc0jLGPNCWL9gzg4GF7jNWSiVOUlFSCqn4FtXWz8qmYJos6OI
 jXOJh2gKJz0z0aWXxoevnFBgKThjLCDXzB5T6Mvg3lsiS0b3fhHcgEET/AnZIWhcaKreqzCP/bg
 JNqgwU2DC4utVByL4V3xzW1dXsbUXzZVVmq6iujABWmald/iYYVTZxi46Y7838oJKDPM0fK7kqi
 0VoiC3GT12OaLkEI7ug==
X-Proofpoint-GUID: 1HfQWNq0hGbbdbtRBORmzqSMbDey9KGT
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=696a7344 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=HFCiZzTCIv7qJCpyeE1rag==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=81hn1SyCJ5XJsrGitE4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160126
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=radim.krcmar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Jan 2026 13:07:07 -0500
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

Sorry, I changed emails, and this series flew under my radar, since
qemu-riscv lore public inbox has been silent for a month and I was
happily oblivious that it's a bug on their side.

I'm addressing only the access size issue in this mail and I'll look at
the rest next week.

2026-01-05T13:54:21-08:00, Drew Fustini <fustini@kernel.org>:
> From: Nicolas Pitre <npitre@baylibre.com>
>
> Implement a capacity controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
>
>   - Number of access types: 2 (code and data)
>   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>   - Event IDs supported: None, Occupancy
>   - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
>
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> +static const MemoryRegionOps riscv_cbqri_cc_ops =3D {
> +    .read =3D riscv_cbqri_cc_read,
> +    .write =3D riscv_cbqri_cc_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 8,

The .impl.min_access_size should be 4, since access_with_adjusted_size
doesn't seem to do what we want.

> +    .impl.max_access_size =3D 8,

I think we can reuse the current 8 byte iplementation by adding
something like the following hack for 4 byte accesses:

  static uint64_t riscv_cbqri_cc_read_wrapper(void *opaque, hwaddr addr,
                                              unsigned size)
  {
      uint64_t value =3D riscv_cbqri_br_read(opaque, addr & ~0x7UL, 8);
      if (size =3D=3D 4) {
          if (addr & 0x7) {
              return value >> 32;
          } else {
              return value & 0xffffffff;
          }
      }
      return value;
  }

read has no side-effects, so the wrapper should be conceptually correct.


  static uint64_t riscv_cbqri_cc_write_wrapper(void *opaque, hwaddr addr,
                                               uint64_t value, unsigned siz=
e)
  {
      if (size =3D=3D 4) {
          uint64_t reg =3D riscv_cbqri_br_read(opaque, addr & ~0x7UL, 8);
          if (addr & 0x7) {
              value =3D value << 32 | reg & 0xffffffff;
          } else {
              value =3D value | reg & ~0xffffffffUL;
          }
      }

      riscv_cbqri_cc_write(opaque, addr & ~0x7UL, value, 8);
  }
=20
The control registers will execute an operation on a write to the upper
half as well, which doesn't seem desirable, but it's unspecified afaik.
The upper half of control registers has no fields that software would
ever want to write, so I think it's not really a practical issue,
especially since we're basically a skeleton implementation.

Another solution would be to implement just 4 byte registers, and handle
8 byte writes as a combination of two 4 byte -- the spec hints that this
is an expected implementation, but with all registers being defined as 8
byte, I think my hack would need "clarifications" to make it incorrect.

Thanks.

