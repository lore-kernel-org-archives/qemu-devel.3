Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01F0CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVDIq-0006V5-CC; Thu, 04 Jun 2026 15:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVDIj-0006TM-TK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:00:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVDIh-0001u4-6v
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 15:00:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HfjRA3221208
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=p5PdWoMH+g83tq71Dt1mQVUY
 AtvvAle43wig45GZNkk=; b=VkHqcMshbNkSc5dXken7tWh3POPbB4CbrEdD/wvL
 Te2RfjdkRPG3FzaDRo5vb8N+Ljdbg2zsSEKxb28eAOiqlQs/qRtKATNczvSjfNOq
 rEvTisSLWTiJ2C14hNkhsRXcebdr5IHI5rTLkN7Bzm+GITeeNh9dhbYD8HnaPaGv
 dZaHUlvK4Dgt6lSQDsOT+jSos2H8KSNtvoi6KpRFoweqo0fRywvbXz8BfmrGu7FY
 mBKNKS0MT6uaDov8+2W6ihDCtevI/45lKQ2VROwX3XWl2dUJvcJDsoYB4atlcif7
 XIskP9aPHsrNTqcu2c79ZCp0bmQ578izPIaGku8ux31cVw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95ua262-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 19:00:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2864576eec.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780599616; x=1781204416; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p5PdWoMH+g83tq71Dt1mQVUYAtvvAle43wig45GZNkk=;
 b=VhZtqL5AzNfdKpT5liY0Spc6/I2uGUN2zUIl5xFfgsfiooCR0QqUrehBsh/Xh4VM9e
 S3pNhS25ueLF2xjw+LOtkwFq1URA2n+f8J32S2KFAHEyzRv2MAxHxtMgWwdC+MRkPsBq
 D66rvqLyLxOHRNq5N/TVh4ZbtCnG+AHSiZN+IQ3zSG17yGARIbOehloWhqbj0KcUYDby
 EIVuyYguJSd1XsWO8n/JK1/94d7aS+ZfG7j4u3LGo02ql4S/Lo1FD47/viNzveDP8c1h
 m3lz955/UF8vI3TMM7iRDHWADlS0Xh5gOdAFno5vqbRccKw5RELUmv6pFnR/HiK/hYFF
 VD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780599616; x=1781204416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5PdWoMH+g83tq71Dt1mQVUYAtvvAle43wig45GZNkk=;
 b=kYe7Vc/r471ZCSht9gd3KzJ9fcyppxLCjgHHBPiYy7/HXfVl7kiP+5PvAXdJrZuJOq
 GQaf69GuL3HeUqiWqwXXEo4G76mw3zXfoNREK7fWx1noE14CzlXOW5aUb63zjdX14kx6
 xJpCxk9HHXqDToAOMH8EUvB8P7mLpM2ucPj2ej2FrwQ/GfxKYxVW4/daGJzcCULQnhyr
 uv5DDW9emlkaayPW6k5WiBDk31zrcEaH4EhzuLNCqk+ju/IHg1ncXFjacP5zVA6ODMPV
 EQVCAp306EFXSHPCWBzNtMju2/i5wZb4L6kDuI94b3ElOqeSaNlckAYtbnqgl4hn0MIP
 OOpA==
X-Gm-Message-State: AOJu0YxnOB0dvrDKw3nsZhQS/q95PDz4cBds/jkCZcuhxhkhKv3GQkHR
 i6Yn4ZnHTZG/O/7wOkJVa5gT2q9c8Xqs95IRW8EceA+kwjBEfanxHqtviYHtiTTEDxeS/IKoAar
 tu/DKxVVZhhuVRLKoiIOk4jrWhOBXHS1ineGgz1S1d08IbLTg+wxqTESUpQ==
X-Gm-Gg: Acq92OGyFmx554K/1VWe5+fpEasbykyF/eEbJRQmXRKY+k1loytImMGR4oNRPtIan8e
 WJ01HbGE4f4GsvxwHGlPeELclHUmzzm6kBwxgd9gCONdEW6jn1OZFKF4ZuQa4HPv46rulCLS7yR
 fFrn6bqez7Q7VlII8PYvvC4clTK6nUgOL61MRJWdYagAg5LKGrphNx2DwCLINco2wrUhm3XRLcv
 OFupWqV1LNvo1kSojnzS6SU03vLPecRwqQZl/UFwzQyQdwNmH3oRdFt69O79q0Q/6C7B2oDY6j2
 srcn+dS6DshTZvL2AYUGbtT4yTn+qZsu1sKBLIdIWNxGHL+Y/nDdMP9HU/NABhWaksBkpZtsVBD
 EhvccGX5PtcgbYrzeLxN90UrV3XX88E4d8WywLZj4Ag==
X-Received: by 2002:a05:7300:dc14:b0:2c5:b23e:48a9 with SMTP id
 5a478bee46e88-3077b7d2fd5mr1580eec.25.1780599615844; 
 Thu, 04 Jun 2026 12:00:15 -0700 (PDT)
X-Received: by 2002:a05:7300:dc14:b0:2c5:b23e:48a9 with SMTP id
 5a478bee46e88-3077b7d2fd5mr1532eec.25.1780599614858; 
 Thu, 04 Jun 2026 12:00:14 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm6055146eec.29.2026.06.04.12.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 12:00:14 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:00:13 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 5/5] docs: add riscv-server-ref.rst
Message-ID: <6zbbuwhkns2v2nigvwsd2qpwp6pmtyayybrrar67xgma7tf5tk@gpif5wvll63p>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604095244.3313259-6-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a21cb40 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vSOAtRhCdQdn2PWJxbAA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4NiBTYWx0ZWRfXxh5AYUZz5X5n
 I9ivFZO9xCEVVHCrw8gFWTiqKH+6GK/M8L1ZLkQtgu0K9T2Aue4ELiMYsOALGjwows/Oxy74CCe
 h1LjEVIIHP/DrnlPfB+deU+jLnm5pNAtYdDmctIErpGbgkvDCS3/KRYxgb5fsE25Pg9SHd60sye
 a9GghHbJLFpd6TI58/EHS05qTq3GJ4pM58KYChEcssxQv9TzM9I03h2mo0TWH+jpTscc+hq8Qw+
 lHhaZem+0mn3bdJ/OcjrmFh5kUSM3vUgcqEEBxr8nbepSt9CmH/D9hiXBqhfol0YyIZb6ELu0k5
 X3hkD1CNmyrgVSUUkbCaHPxOjlD8QzdP2Ef8XUwxhgK+yNACNDP2C+A1b0gelczmuUBJSeX2yIM
 yjrOUVsPOBqqigY6YXdAoj0l6z7H8bo8QmBRLgDN/SEU8Mm1l3CYA/Y13dUkL8O0oLjUiNzXXfw
 YG0ipCSJ8DEW59zi2GA==
X-Proofpoint-GUID: ZtHcDEzVK3ktjhpps8sII7h8qYUObGDS
X-Proofpoint-ORIG-GUID: ZtHcDEzVK3ktjhpps8sII7h8qYUObGDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Jun 04, 2026 at 06:52:44AM -0300, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 52 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
> 
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
> new file mode 100644
> index 0000000000..379b7ef76e
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +RISC-V Server Platform Reference board (``riscv-server-ref``)
> +=============================================================
> +
> +The RISC-V Server Platform specification `spec`_ defines a standardized
> +set of hardware and software capabilities that portable system software,
> +such as OS and hypervisors, can rely on being present in a RISC-V server
> +platform.  This machine aims to emulate this specification, providing
> +an environment for firmware/OS development and testing.
> +
> +`spec`_ is version 1.0 at the introduction of this board.  New spec versions
> +might trigger a revision of the emulation itself, which will strive to always
> +match the latest version available.  In case the emulation changes aren't
> +backwards compatible we'll introduce a versioning scheme, probably via

Even in the case the changes are backwards compatible we'll introduce a
versioning scheme. Because...

> +a machine property, to allow older SW to run with older spec versions.

...we aren't as worried about older SW running on something than we are
about new SW being tested on older machine models in order to allow OS
developers to ensure changes to the OS to support newer spec versions
don't regress support for older spec versions.

(And I think we're currently leaning towards a global property instead of
a machine property in order to cover the cpu model too.)

> +
> +The main features included in the riscv-server-ref board are:
> +
> +* IOMMU platform device (riscv-iommu-sys)
> +* AIA
> +* PCIe AHCI
> +* PCIe NIC
> +* No virtio mmio bus
> +* No fw_cfg device
> +* No ACPI table
> +* Minimal device tree nodes
> +
> +There are multiple ways of using this reference board, some of them being:
> +
> +* BIOS: u-boot-spl.bin; SD-CARD: <disk_containing_FIT>; NVME: <distro_disk>
> +* BIOS: fw_dynamic.bin; KERNEL: u-boot.bin; NVME: <distro_disk>
> +* BIOS: fw_dynamic.bin; KERNEL: EDK2.fd; NVME: <distro_disk>
> +* BIOS: fw_dynamic.bin; KERNEL: <linux_image>; INITRD: <busybox_initrd>

Maybe we need to point out that a firmware that generates ACPI tables and
supports EFI runtime services is required for a completely spec conforming
platform. I think that's only the 3rd bullet above.

> +
> +Here's an usage example with a recent (June 2026) ``Image`` and ``rootfs.ext2``
> +files from buildroot:
> +
> +.. code-block:: bash
> +
> + qemu-system-riscv64 -M riscv-server-ref \
> +     -kernel ./buildroot/Image -append "rw rootwait root=/dev/vda" \
> +     -drive file=./buildroot/rootfs.ext2,format=raw,id=hd0,if=virtio \
> +     -nographic

This example does not generate a server platform that conforms to the spec
since there are no ACPI tables and no EFI support for the OS/hypervisor.
Also, how is the disk configured? It should be a PCIe device.

Thanks,
drew


> +
> +The images QEMU is using for selftests of the riscv-server-ref machine can
> +be found below:
> +
> +https://github.com/danielhb/qemu-machine-boot/tree/master/riscv/images/virt64/buildroot
> +
> +
> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index afd86ca2ba..b2aeb39a8e 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -73,6 +73,7 @@ undocumented; you can get a complete list by running
>     riscv/sifive_u
>     riscv/virt
>     riscv/xiangshan-kunminghu
> +   riscv/riscv-server-ref
>  
>  RISC-V CPU firmware
>  -------------------
> -- 
> 2.43.0
> 

