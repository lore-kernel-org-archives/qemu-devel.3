Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA6FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOzY-00013y-Vi; Mon, 24 Aug 2026 03:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOzX-00010T-M4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:21:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOzW-0000or-5O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:21:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O6Skmu1982629
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PfFt6XSMdSSghaTOlSUqQaL/d+3rNMjtG6deRSZ8tiI=; b=IA+otzRm2YILuhj4
 DBkfV9D9Unu2W//iy0Sf6UvV4lqJhIvZMAjn+pofdIK28cirjV/EJvnpNWlnCSoK
 v+SEi7iRvxTlsC7UFFyMbOjSAIBrRBhA09P6nudKZ1EVlww3Osm532mbFfdIEHyS
 sDSTxZlKcav78dJopgtyjGMVYMz1JtRUCu2Vs6hXGINhmOmXSrkdYh/ndTpGDa8W
 fHEhNxfg9VJoUiTy8K+YW/5V/80o+H4lz/tFZ8H63YCMME3Vt788W+xXreedvlmF
 R9LSy+/Fk+rfVw1+orcd5yhCso9Gw2LFcpsvkHUQps23FgJA6/APj56IXLAzhgAE
 MN60og==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn88jc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:21:09 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97c3d88a3d1so2114795241.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787556065; x=1788160865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PfFt6XSMdSSghaTOlSUqQaL/d+3rNMjtG6deRSZ8tiI=;
 b=cdn+fYVx1+shnK3U+0CaS0TpXujw8Mr25cJoxUkMjeyU6ZXXzCLPvcbYWLJZe187mm
 MIraa/aMmmZ+05klevWtv45KGuxMdFEpyEd+/vbqkltnxjl8xV5ZJqe4UR7pXLKsN95k
 R1w07pkd20aMsQL+aoCtDgS/B+sTt3ohcTXxUdn6aaO/dZdWCsXmlmcOxdjZAz2s5wYf
 19GHCGt1RKL2voi7llSH6efH1XfxBaUODSWkXxO+uaUEXnBC1UzvUrjeCq1kecvx8PuE
 5c2OHWkfOtjzo7uCPdHxYnNb8GzRmFqsjwcF+ECTqdbC/+ARBCDb8WcCrtARVQJzhGNM
 H+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787556065; x=1788160865;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PfFt6XSMdSSghaTOlSUqQaL/d+3rNMjtG6deRSZ8tiI=;
 b=Wa79nK8hr16noyRTnfTboqBGUBd/h9Up5Ip/Uig3cOOnEP6O9Pc4XxKTF/wx8mLUpC
 nt2vj/hE8et94yqetJfXKZymTlm9Xm3dO44bcBWl06AdIhEGdZRjS7cufd2qI5j0Eo/w
 0ycjvMcqsUE4ihVRjtxLMlMWWFoNZB6wDjUxFMWDlq1gs+vmrfeYgfF73Sbyl5n5wTfw
 PvseNksYt0DHuDmZX176y5QhFqv0YqoO81nxSUrcHKxxzewrLs4E8UQDgoHtPdZpKAPY
 TQmp+TrctMn5A9QnzyH7DamgCIRWaNYuwrXxnMJHh/LOQ/SoU36F6jnwtKNYWOskaLJI
 +2Mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkEX2nsR8RfhlDG7Gf7aI1wyrjskyy3wp6X+xo6kc4tZeOZeESPqrBSSfhs7+tecFaU4HAZX5K7orY@nongnu.org
X-Gm-Message-State: AFuF++m1yww960ALNMo030/IT35l52agLM1aL1BhuWnsWdcGqaCnwDp+
 r++Ydzu2cXXLTht5jlbpzrKDOiWl37w+nwBusCppIiaPUEhFrEjp338Sveokhe8fuEHSIgy6lH8
 3trQxz0qg2CCXKoCpbm/Yzs1QpZh1L3ZShtpdBWrY9dOpEJ2KZCaQOvcgog==
X-Gm-Gg: AR+sD131CXy26q0Ckg+Zj3uEMYnkNvQ7yVdT3lqG+NLlcz1ZaELtGlUUVpDK1xEkH/d
 A3dJ7JuuXUNpSGT3vV1KhR47LU1h6Eiqmkoks1FoAl2YN58Txu/dNlkzianDVc8oE7z6m3s20Qu
 CWZsLrRjFzU4ffyCSNQJ8DkwaAIhR34SUNTHuHWU//pdk8n0feQZmDC8LkRLUNraAJW1RIobPrS
 oHzYLKBBcHextBfWexONyz/Dh1jnrKY9Sx+duymIw8OykZhWXwXUnpEUYjYc+8W5rhxQy97X+ie
 eI8J6LuVjNg3Sy8fZ+K+l2VnBEex3YPSzc4kTZSeqrp6yriKXRCcyM6o7OqRRtISwZ9gd3yuwVZ
 EmH1+8oPvbO/E1TcMyLzIZJKR4yS+D4GosaBR856gmiEm
X-Received: by 2002:a05:6102:304f:b0:77d:9fe9:1716 with SMTP id
 ada2fe7eead31-77d9fe93336mr2531191137.2.1787556064976; 
 Mon, 24 Aug 2026 00:21:04 -0700 (PDT)
X-Received: by 2002:a05:6102:304f:b0:77d:9fe9:1716 with SMTP id
 ada2fe7eead31-77d9fe93336mr2531172137.2.1787556064651; 
 Mon, 24 Aug 2026 00:21:04 -0700 (PDT)
Received: from [10.254.188.74] (132.170.88.92.rev.sfr.net. [92.88.170.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm6968310a12.31.2026.08.24.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 00:21:03 -0700 (PDT)
Message-ID: <1e4a2ee2-e3a2-4946-9a17-405e3b7575fb@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/loongarch/virt: prefix ACPI helper with
 loongarch_virt_
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-7-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260823150731.896-7-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfXw4TDRrGjnk3P
 F4pdxcpOJDznh/GQGuYNF+oZ2MsIbHPA/KGPX2rUklXjTeAr6wF7Tpl0KLWRl3KeDgeSr6i9GPW
 KWanAZMzWipc5X37Hes7VEohHEAQC0E=
X-Proofpoint-GUID: gxJ2TltnkCXzmhQsxyVZ8AQ_Sy9VPq-T
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8bf0e5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=k3i2zbviP8V9/5wfVjyM+Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dx8q7alXRdzxVYaSRZAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX7uwqBm2WYM6k
 HG1in4EylBabh3LWKouE6VUiDLrx4/koSYytfDs4kpYgCoaF6CGm2eGS3QU2727NkH3BfY1wlgi
 PQOI1VUIqTkBoBMCDsROf/RSiGwoE5iPMIxm+3FXtfNqrT4BYlIA7HMfPwugibEXiQ/SBqMd/og
 nQ/HUa2Dq6WEgPR7FFVaVViqikAwTkbcH/kH9m11SADKHlwAFcqJOPSsryhr7p8gBTJ53nt9AIS
 2IyujjPiGlxEWxl2exSmAjjqrG9+1QIGaHsneA37b8AdjJVl5POf82t0ZETQx5m8CgyGl+o17rD
 winMGfIAoKgGkZ9vpYKBcDmqqWowcfArs2aV+QQQJzO0ncMOp5Bta6ebefOnTf2RRAwXqXd+0nR
 KEyfxgqqCCOONzHs3DSg+brq8xLZs9I3c6DYlcvsx0yEsxb/5QKxp+WorfCxNHAMKVlwXcD8d+O
 BgGZXmEIWyNhgeszUKg==
X-Proofpoint-ORIG-GUID: gxJ2TltnkCXzmhQsxyVZ8AQ_Sy9VPq-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/8/26 17:07, Yonggang Luo wrote:
> - virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
>    Rename it now so a later combined binary does not need meson -D
>    prefixes for LoongArch.
> - Rename the file-local virt_is_acpi_enabled to
>    loongarch_virt_is_acpi_enabled to match.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   hw/loongarch/virt-acpi-build.c | 6 +++---
>   hw/loongarch/virt.c            | 2 +-
>   include/hw/loongarch/virt.h    | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

