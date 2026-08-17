Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D378AC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsqc-0005Yn-9c; Mon, 17 Aug 2026 04:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvsqa-0005VV-Pr
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:37:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvsqZ-0005LR-6r
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:37:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H6wHuh1386269
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=lxtxCOms/qw4ckxVhbvPV81LeBCTu10QqoCU1NXaTQQ=; b=U1
 tsot9kLH0mzbBEYBEW5mkzPYg5DE60s/jboeF/uXqmdsFFrH7Zd9fbrG4DZKb9Kr
 UwHiW38ZS7o72VAwD9SFDovhlxRjfD0KWr/VUFW1qEjy36MCdqJQ78SpEfWcIi7b
 Klqld5ObVrnAsAuAEet7GHrZ8IXNRqrOdPJspIfWDvLrqXwOXdJ8ju+2+580JOZq
 4Afxo3XCTcj7weEIXcXAtfWFfJ5De2sHx9l7fIRQweh3rbvSbKwIi8xc9wcSpeqi
 yNGKN7/0WvCpiU44SFipjdp4ukMWDBpsjAAGSvAWvBt3GTz5NSxIwnN9kvDiiygu
 adHEa7+nuS5QKPd+GN4A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3mx4sptx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:37:28 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66c70f4b830so7772215d50.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 01:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786955848; cv=none;
 d=google.com; s=arc-20260327;
 b=KsBKWrb9TBSjUTl551fcu4bT2pME5p5Nh7uxiwPfolSd3TOrIqMYdKCwiGY0BPHai3
 x3Ognw7XqBZAzQsB/8IxFSqabWOq5UXfoMhXvVy/8WmBEId3g0ukMq39EkRyvZIETpv+
 7TmZ5KYs+t9HXUk39u1xWJbL2AtSPTf5yGAv6Ueh+MZ6/3lMCLA4CRYWavWJfbxDAbpi
 FY6kKvi4w/oYXXxFl3NRa3gXnhcjHGtIBNj63NbEUGPtl5+vvAtoNgEHVnLjhFmYa/Nl
 VbajeMdCNzcQK5udutOV4TBiB+ajHqtxjaeverwoUXQ/jX6u0gd64g5enoJErx7m0xxz
 5Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=lxtxCOms/qw4ckxVhbvPV81LeBCTu10QqoCU1NXaTQQ=;
 fh=Epza5gLQlpBTythoycb376yGxJ+M0R8zAkmRRW0crpY=;
 b=mUr52WlLMiJLxYA6K3mFglmCseAbBQH6i89F11xJrvekdpYrQ2H/F2w0AeJbkX0KUW
 kwvIEk/0/RpZQ+UfgBZh9HWYYda9IigNXyeJnNiRG1w9F/WfOAAjEJ99B50yok2ogSg4
 3gvLPmgf7lpbpnJHcvBI4ppU8daD87OCaXJekZL+MdT682Xu5WD5ko6R5SeKbOZxlvA0
 +tqUVdftApTw2I+jRT9Fmf9CS5KMiOmE09SrqJxeF2oqOtyzAtoUkcp1GiQkmZNFt3mE
 Lpe+L+7sNdZqzq/32zudWruuWq/22gIPdCnHQ/Xtkjgc9ecire4MbVvAGiybwT12qSGs
 Vd3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786955848; x=1787560648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lxtxCOms/qw4ckxVhbvPV81LeBCTu10QqoCU1NXaTQQ=;
 b=GxSn+Hr6ITuEPpgfrCrwzyjyAZcWXa0zlCanksQbH/at+/PnFFY7ggiGxs/C6qPLPW
 YJZku+tB05ApbV1pfSerDytux2dospeuysxGNjYbCVYL9YePAZ8UY6JT/GfQfvMghrre
 5T/H1z4k4+WNdTK72rPIQK/gq9WC3rUUAzsEBOag8XLX0+D2ZHu7jKOFmZ8ApeNAeGQT
 Pri5RdLOeU7DFWsmriR0HXYDLb/TZBR2c+ffxdZXfGT+R3CX9kkj364oFarhRunjC6Nn
 vyQi5l5aX5V+vpMZ761OiePqZtAjiVWQHLXy4bqdbRP8fO9ZN03uSV8SA8qqd/8IF7l8
 U26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786955848; x=1787560648;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxtxCOms/qw4ckxVhbvPV81LeBCTu10QqoCU1NXaTQQ=;
 b=nHg4Pv1nltMMZrsD3+26RBBYBQhRc+8dVCCjBrJTAbI0txS+CY4k1eBsmje1CVr8fz
 6el8uGF5ipz3hvH+SOJvYiMNs9rMqiGeFc6JiHxpsRj2sRFswgOy/yZG5Pax/xH45I7u
 E7WGM1NdyY3Km669Z/b/gSuX6nnz61+iChB5Nj5jorank6nasBvCYMwjXQVLuFyYg5EW
 Ln51T1yEv5yeDC90iW/MUNg6qwzafMqjfpp/oYwY+JkELSgbvRBaJ3ufTFoOsw0tXTgl
 N9nRkcD5UZYXMs+3oeiGOmFTE6e8rDB+C6mldhh1Zdq1q0kFkMi9+XJ0KyMyixnmeeGh
 +Bjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoorUWToLLbDnfFsuc+HnO3e+sUGu8Fbp6NSeUNK/hf6sDczvSoyVoKD7jYLU3M462xJRDWgwUAz8Yy@nongnu.org
X-Gm-Message-State: AOJu0Yx32FN0hmtMViD+TDRhrGMXylkyw11dFvLsxGMyx+O0bgN7Tyyb
 WXp8VjkjuYgQxwX2FhQGFrAkqHYpuEH4TE1CVb+TBIDpksg0CZYVixuvdJMoagM3VwpAmjPk/KJ
 uP7oqYMhCvmxRliv5lp/QMsx+LUjk0HZXPmPkzerCc+hvwSnE4KNpkYeoytMZPC5V5NDTUBdukx
 fDPbxAK0hvEplxtXbYcCRvuuvsi+/sLq6s
X-Gm-Gg: AR+sD11V+Td5tDYL/0yFoCraOOJf46++metJKZdUC1wbPMZkA1NbbWqBHrmD+ZV52K7
 w78OglRz+AI56Y5x6wUYz+uPk3eR6DJ+Iw/+sQ9MNC/0I+3pEBOujFsZjtO9jFb3r4KwegBmhYQ
 U0LWi3NzjMTkyvnO0Su0bvR/nChIpDcH8CCTNbP9qF1uSxhUTHKC7SqaBpkvo=
X-Received: by 2002:a05:690e:169a:b0:667:e04a:8a42 with SMTP id
 956f58d0204a3-66c72d0449cmr8634676d50.46.1786955847684; 
 Mon, 17 Aug 2026 01:37:27 -0700 (PDT)
X-Received: by 2002:a05:690e:169a:b0:667:e04a:8a42 with SMTP id
 956f58d0204a3-66c72d0449cmr8634663d50.46.1786955847336; Mon, 17 Aug 2026
 01:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-5-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260814045315.3416169-5-subrahmanya.lingappa@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:07:15 +0530
X-Gm-Features: AcwNN1WLKMQAnaxCiqTkvSkvqRqJyAj8ou0hWj5nypmLFHzPHFDs5efWjE2LKws
Message-ID: <CAB19ukGHNA7KwDpgeucPoy0h2OThHGL7LqESDeY8f_moxPGyUQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] hw/riscv/virt: add opt-in RPMI base support
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: wDfDlqpo5D3pBv3PFUU8waoq0pt68RzS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfXzmULDlE8k82q
 M9lrMCAVewupFjQnyF3GsmZ4cgmmt3qw9yzMAGTZhLe87Yw3xdoJjSQW/0NXBRvZbwvKmauAoXb
 HmiA1pahnA+rj3UaczNlEHuSgbSWpLc=
X-Proofpoint-GUID: wDfDlqpo5D3pBv3PFUU8waoq0pt68RzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NCBTYWx0ZWRfX/10iTFoLcW2I
 OTqm9MJ08Ij+kZAJf9BRTeiiY695Ggpje3OEcLvhqbWMjwQ5qDJdZXgBHg4sTJ36qhmicByJirL
 q0xSbZ0tUYhPVVLxcdbAYU5MPfirfsOaGnCjEqePYXfYttGCnE8D7MYGA8bAJ60dC9RIBnOVcMZ
 4A3tfHVz4g1t/9ECFsW+5utuviG3yOzkO1qNTgpLVzFE/im0Gkb+jjbV0QYAlAfHnA4tciKJbmt
 o5sHyquZlz3ShMshbvGl6OsBQzMswPznVl7YNeSHs1wb88JTQM125VSzCDOgkuxF6XEsOAVkl5M
 fDFo4nGmZmvn+OA9eCAlJgsN9HAxkypbeTdushf0sKJV4LotbaZOcbf8IbdV20LmR/1AWpFiURk
 1/y5w6Yy9zV59ZNk5TJr2kOj35/6o/MP4Q2GMVHQ0PEbOq3LJ0CanWGAjL0jGB4bH9E+wwAzHRb
 pxQHnoggfOq0erA+jng==
X-Authority-Analysis: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=6a82c848 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=JmizWh1dmgbBdfpdsmoA:9
 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 14, 2026 at 10:25=E2=80=AFAM Subrahmanya Lingappa
<subrahmanya.lingappa@oss.qualcomm.com> wrote:
>
> Add the virt machine rpmi=3Don/off option and wire the initial RPMI Base
> transport into machine realization.
>
> The option remains disabled by default and requires TCG plus librpmi.
> Invalid accelerator/build combinations fail during machine
> initialization. When enabled, virt allocates the RPMI shared-memory
> transport, creates the RPMI device, configures Base service metadata,
> and emits the corresponding device-tree nodes for firmware discovery.
>
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.co=
m>
> ---
>  hw/misc/meson.build       |  2 +-
>  hw/misc/riscv_rpmi-stub.c | 16 +++++++
>  hw/riscv/Kconfig          |  1 +
>  hw/riscv/meson.build      |  4 +-
>  hw/riscv/rpmi-fdt-stub.c  | 37 +++++++++++++++
>  hw/riscv/virt.c           | 96 +++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h   |  3 ++
>  7 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 hw/misc/riscv_rpmi-stub.c
>  create mode 100644 hw/riscv/rpmi-fdt-stub.c
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e7c2ebe28f..92c9cd6064 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -170,4 +170,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files=
('sbsa_ec.c'))
>  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
>  system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
>    'riscv_rpmi.c',
> -), librpmi])
> +), librpmi], if_false: files('riscv_rpmi-stub.c'))
> diff --git a/hw/misc/riscv_rpmi-stub.c b/hw/misc/riscv_rpmi-stub.c
> new file mode 100644
> index 0000000000..dc32b43227
> --- /dev/null
> +++ b/hw/misc/riscv_rpmi-stub.c
> @@ -0,0 +1,16 @@
> +/*
> + * RISC-V RPMI stubs.
>
Shouldn't these changes which are outside of the virt, be in a separate pat=
ch?

Thanks,
Sunil

