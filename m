Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C538EC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qHj-00014s-P5; Tue, 08 Sep 2026 03:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qHc-00013B-RP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3qHa-0008Ci-V2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:30:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886M0tM2502557
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 07:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=fGPNIPCMK92NLMPG+emyq6u7k9/+jLH2qHU1vjFkODc=; b=IL
 83+jmgfikSa6fVCujhw0mYZj3sV4vGrzDxu264a0VhZwmu3t4PWUx0WSRst7lOcA
 BS8CpPaw3VQ7BCW0t65wEkPuO2bINRP5HRv8l/e3jeAqrq3pOZcLhRukAB/G3BqG
 eCCJ9FC0xebc2pxMqt24oAjIZfxynX5VURnLFu7uuemSxA3NDMJOdIRhowB9I4hE
 PERoWVPgSARefejziXDdaufge5jQaHlZf61OeqvJgdOqDt7gX3sZpMPD2/E2oy75
 uYzPBsAOOzhCgWt4oJK5VWxs9VXDrq11DdHocsc2MSd0XXHzKHA9lBlvdL7RQJJs
 pZcT7rf6D0PzFu6ht5aw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7gb34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:30:16 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8422f73d5caso71670777b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852616; cv=none;
 d=google.com; s=arc-20260327;
 b=RjSUpf8HiQpsA5TxCO88GHZyOJeRpXrWmXrzJzXqte7S9SUnQnJq3V/+I8ST0m86K+
 +UBkv80kyKzbE0Thw238t4iQ4pj8ehxES6xI4zt8G2fMGnYIBXPDbUqm3okKMCh9vZnn
 jQ5rGLmmqp3uJruBFThcfrH3b0eH+RiwMBE35Hv9LUCq6kougqtuY0HpouLHQD7GcDKq
 nzwfgq3kIBDatP81S1CBNr2NvlT8SPyUtgXvPUL2n5e5Au5n/3wOAMtM7xLND65AqViJ
 JdVduVAgBCjUzAVk/m3gEwjoWVjmrl5LPC5RrcV1vMYVhVqpz+9l6C41EoXdqmk486ue
 TS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fGPNIPCMK92NLMPG+emyq6u7k9/+jLH2qHU1vjFkODc=;
 fh=b7F7ZxPiF+QAItaeB75WOOXC6BMma+3K9gXJ3YoIxQ8=;
 b=cja49s9TARf+PMxeeRBV1Y0pG5RAaHE+mgJNxFJBjVuRKQrRY6ljhBAph3ClNjQbx+
 MCTMCF9VMlRnayY9UlZmLtK0DJfPzAmTK79Vs/xcObhEyA0/M4nFaJ2BQ60Od/EwfV5o
 TzjLUspDrh6jlidFYLJALNdstpvNi87Bh9lUhgzAXe3ODDBDu0WAMvTQEjWe0JtLeVKg
 iLOjx+llRN7rdubfBIisArMq/ki72kvuSALxKDQHdTJ7mfmvuuxxAvWfg/3N6P5XlSzl
 fMxcd7IF2ykIB0w5WNq1mo2+4E1ak9FFvs4QWSADYUwMN3esS3k1chReSfAWqrp9Pj1a
 9NfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788852616; x=1789457416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fGPNIPCMK92NLMPG+emyq6u7k9/+jLH2qHU1vjFkODc=;
 b=brr+K/MrJXPfbGG85Zfg6UrG4Vng1jzkjkg10me3Q1hKeTjJS3inAmsE9dD4jvrM9o
 03iYxLZT1MiRaj7EmRZeF/UpWUT3Snpo6nTZdXM5tQWBkd4x3Tv0gLKXfgZGBFh0TPbO
 2QisbtpshsBIwHSYPUpHPyFZOOoakcUOylGi0oeFCGN/yNGOta2NWyXm35RGf5gnlMg8
 yirtTBNDk51ARRdTvue+Os/h0EuUGMwuwPnVZoUDgnjG/SaCj+f5WXxN7JjxGSgY9JS4
 2AiILNvZ/Z3EQdNklpMdpBq9QPHkLumfWqNAXDpVyFj9oh9e8wux/Qclau9l+CaThE7H
 f8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852616; x=1789457416;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fGPNIPCMK92NLMPG+emyq6u7k9/+jLH2qHU1vjFkODc=;
 b=VL7o8XTZS/D8+2XvIuQjmTnZfClTsUthrv0b5pwe9yY5rn2gs/o8Gx4AWbtgW4BF5g
 5uU7YxHgRmRky5qdwdSu9y+UQSV1IW2PyZMKlzH6yt+O/g7hj6PO7Cpuhg9dimuoo4+O
 TGlaT9ar3fC30UsvuVlny56T03gcMEGidzAMhXYNOdCPJOC3hrzf278muKirbEJkBG7c
 6YTE1+DuoFxse5V5SCgqzAdgaPnKzF3Nurf8CZpbSu31OmctXCpqdokCDFhW5X6ZRw/5
 xu+QJ0Y7hUufTZFe297TetZIR1V4v7UDNs8/o/WLZxm7ycKk/7VH0fe/l6dnavKuzn4K
 V08w==
X-Gm-Message-State: AFuF++kkndvFlJPkkl/QABLVq229MX94tPsZ25tznJKQY7aC6g0Euiwb
 j62Y54g/mtUT09WyP47jHOxLS9hCd+BE3/MjkNO7TsN/PmX/hiULZN2cHhH9PuwcmVenDdEL8d4
 Oe+J08FQqNWutp7JFuu/Z2lwXOrhGTKvza79VzKJtCTWgXM6QegQHET1h/uPnWDTf3TqTGHkWDL
 uEq7KLR0wpGWELHovUNC5q0JVydEO6BuWY
X-Gm-Gg: AYBFou3X50MjBhHBQd+9OFM83Dg4eY+uA+PmZb/SipRYwpjLi05nj/oF7Pb9Ck3h1sD
 x49sc8NTGWOIUETGiCupOqMbNp2kPbYJJFT7TnQgabXcU0GYin0LUsoUB2rJsmQtf1wsO1TtBKg
 oqb+Uoi53+FHeHGjL3zn6839gQECp1UYQ46hAXEEgZTaHCu4SRh0HEr3xwNFA=
X-Received: by 2002:a53:ad49:0:b0:66f:c1be:3180 with SMTP id
 956f58d0204a3-66fc1be35c6mr4629647d50.87.1788852616289; 
 Tue, 08 Sep 2026 00:30:16 -0700 (PDT)
X-Received: by 2002:a53:ad49:0:b0:66f:c1be:3180 with SMTP id
 956f58d0204a3-66fc1be35c6mr4629643d50.87.1788852615909; Tue, 08 Sep 2026
 00:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:00:04 +0530
X-Gm-Features: AcwNN1VELcYQOP9X8V8mWL2uM8w-8UdhC-a7O9RGwWDLuCYLY3e9f1fQTwoJsXI
Message-ID: <CAB19ukERmbJF+dTQ6kW1FFuhxPBAPLuw2aJQo2bvkwH+D5dF4A@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] target/riscv: add riscv-server-ref CPU
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fb988 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8
 a=PXcuKL70AAAA:8 a=FRSEYCzRAAAA:8 a=j2afkqJCyIVXg8yJ22EA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfX8m/5HsvNbKuB
 H4y0M0pthYW/1SNYiteZKkDqcC0ny8lYYRv3dSQAxYVvQwIwufb+cltMVnUT9bbQiUYR41+uh+N
 uOgQILte1e2FTcLo+NvbFSlsnf9gkPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NiBTYWx0ZWRfX9Kjkx/P3T8Kl
 h2Kdnxc6Vj4h3rChCvuSC4q21UR1Hx67mhmBvg4lnUjmv0Jvc1JT3cC80kaSyln2/ExqjBaH4Ed
 RsFnilwU8lQN3s+Fo7hrU3/7RHrAH86kFkzsKS5O8qKNOfJHcwja314Y4fKHanSA8+wxfSSZvTW
 QvmQCRtEk1r36vYocsacGqjJGwgsLR7P/OhwfKQAxgBBVyaIZPgdrznkstswVBjhwhGmsFQwKue
 OQxuFtYIpBNhxjODYPCG/PbJ7GA0mumU2qaLhtlwtFRB7m7eQ8apPW922OqDle7cQhbjtJqG0M0
 qF1FpSI8Cmg0RyXG6MhAj2It2ppSVRCI/i7Yl/cl6E3nr+Oju1g4LY3siAw3tM0HLGUqEXIgwYx
 o4LHetSPtln3NhCIU9xooZarhr1m5Pds7vR7ssTN5DY+YER3OgIUFjhLtEh8nGi98O1tB9k0Co9
 moTlAM1EokAKIIoMdNg==
X-Proofpoint-ORIG-GUID: zobjOM0Upc_i7UbX29k0HzOvILTbuMxp
X-Proofpoint-GUID: zobjOM0Upc_i7UbX29k0HzOvILTbuMxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080076
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
>
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
>
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.
>
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount with:
>
> -cpu riscv-server-ref,trigger-count=3DN
>
> Note that N must be <=3D 128.
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/serv=
er_platform_requirements.adoc
>
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

