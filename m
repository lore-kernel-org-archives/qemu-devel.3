Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7630DC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3siQ-0002Pc-En; Tue, 08 Sep 2026 06:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3siO-0002PA-Qt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:06:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3siJ-0006fa-E1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:06:08 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Liuu950259
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 10:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XDuazRtZb7js9s2s9w00zibO
 jPpf7qRhb7cOuOybBl0=; b=Izg/2hfivbf4+fgSkpZyoEKEI6+tsoFknHb4tqBw
 gZxuYo45Sms6U3lF5FY5TeTVuFr96LQ8zAE1b24h1Cj+Sl8HVHAgi036uHn5fNXb
 7AlA5Cl+aba4qJqX00jKh7eT1GJMYZhBwCf4wBHuv9/CD13fI3kQ5rrdX+VAE82l
 Wu9PPMrOEZfSthHcFPHplpK5AZ5uzvg3uVJ8JiM6ZoJ2A5weLKVaM43rK8GoreCZ
 Dj5fe3rvGakXYN7Kaq36yJarZWmtKCmu7yWg8B42MlTtMRL19YCxDJLNul/wuQJK
 VluHMkLcrsKcMy6g4YbE+oAvXtPXMy2FWN6a/TpmG0ii/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp8yg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 10:06:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so849618485a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788861961; x=1789466761; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XDuazRtZb7js9s2s9w00zibOjPpf7qRhb7cOuOybBl0=;
 b=LoId291Lvzvk7bmryyb2FB93ePL2rPHuwPw/lv2WZNqS5rCd9hB5mX7bpzexcyRz/k
 faTiIw+uanAO92eHQUypU9vuWrQlqx0LoACn7UJpyu9VwNqXXxjHokacc8Qz0AYRBEbT
 1TSk3Gh7jqgVFTLHhgzgzxI8eh3SLx1o3QEGHTYifE4oOgoj2f0Ds8hLuQxxEUYgyldL
 2s/Y1ybqakSEsJwdCJMoDdXkYjOWA/Gjc/yp187Lxw1vnL1IWW045JiJ7Bdg2g+dKr3n
 Q388Sz7pJLmRyIFVhWuA1a69EdLj0geW8uT/ACtkQSDwDztaSf70fgCCMihby/C+yC5s
 ZNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788861961; x=1789466761;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XDuazRtZb7js9s2s9w00zibOjPpf7qRhb7cOuOybBl0=;
 b=KEPuGrBuzQujDhQ+LpO6z09g6iT9W/dvsnjkhrOgU9jLMtGvL+2kR71ZqgjxR/68gQ
 SBM56NfAFwpcSL/WfDjkRs86OQZKup86K46Ev6m1OJrBqc4vXHmJtCHgzC0AnjkBVBL/
 UTvHiFvPXmpwnmGBLHUIQvPHveu5oqAIMifpUV/9Zl4Q5V2h71FT0fZeqbHZa3/d41i6
 vgYdajIK6OtJ+T4m641pRPws9z9vEb9NcQl/kn2EkVp0ocEYxzRuQjpTzNVg+ch5ngbS
 w9otd9d0tFC9f9aGeLNa8RZXXnyvf00B+KUtka5UnYUy9U3fY+Cm3pOxznhr17bgJ5I2
 falA==
X-Gm-Message-State: AFuF++nNyFYvcNIKS1wPJo9R8DOwlNdH00PVG65hieCUhuCtqHK3Gn5f
 tvt4zBMbn/smUxOgJdAEaHHMwDJ1HQFWIo7fI/LUTlUNzUQt6DmMXSs6y6CDGAaVwG5bFRhVJIC
 yeIjXShzexBmjETNv+Os9d4itKUaEvnFdDxTnTD9FnaEC3b8MFPfgkn6QBg==
X-Gm-Gg: AYBFou0h+og6BPpDzkp3VoqZKAhOS2avfozGDvMPXDep9BjfpFk6qAJwE+npaCb3iAe
 nq+kXyFSHBYmtEfPKoQd9U7lerl+aM/58msDVMeb8gfwMGiOypw1aF+HedV6MvwBbMTKSiBGHAo
 6wmmiEmHt+8y6vg6WcbzQnIJh7qBPjqVkkdBmTl46oJsjj4Mx7hf6nlSo8hEEnyJVjfXAe5R2Fz
 E75luY0oc4sRT1lhG2qFy3a2z2NcHGypW159m12g51WBQ4Emspabias9Z87gHuU4X6HvPPzrdTD
 A2QtanUA2k7oYr2hPHkTJTGcjM0gIcbIHGKGjobyqoHumUPW8zxX3ocRpi9VKgiD310DFuVh/mQ
 RuK0mHlQ3z7d1QNkuyhqC3yJnyl3jwe0GRMSXxQ==
X-Received: by 2002:a05:620a:4686:b0:939:9d8f:cb50 with SMTP id
 af79cd13be357-9399d8fcc8dmr1861095785a.44.1788861960777; 
 Tue, 08 Sep 2026 03:06:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4686:b0:939:9d8f:cb50 with SMTP id
 af79cd13be357-9399d8fcc8dmr1861090085a.44.1788861960310; 
 Tue, 08 Sep 2026 03:06:00 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c26263cb042sm457498066b.47.2026.09.08.03.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:05:59 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:05:58 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v10 5/5] docs: add riscv-server-ref.rst
Message-ID: <wbr4q627iwaqltkrqds2qoz5jnupjhmf3x3eb5bf2o3orf35fr@dpjs2pzvkten>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904195610.964829-6-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fde09 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8
 a=FRSEYCzRAAAA:8 a=_-0T5nacJPHRRYsZgRYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=F9tHCgz3TLBaZgltkx5D:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: A4p-A21Spi4YH4fg1AJ8Kg56-9roAlWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfXyEQmZ3vgYZOa
 3cxQ15ShweRPgj2+V7GJEOJGvB7ze2RXTLqE/vvhbk3E9dxNxMsNpwX7xx8SVENdpFWOPch0Rxk
 +Y1DlGrALCgjDwVyHrN1oqcMH5DOaHqpNXinl6GtvKMZLj1/yJrb5fPU+ZiD/GYcsPtQ4BGAk0I
 4NRfhfox/mmRLayXudmHGfwrEpWD7Ajkt8UXKYVumI1+suAnMwhFrjW/p+S46BCQr1EK2d7kiii
 KzskUPABNEobqApV9O7NLPGfJPVm45DfSiJAcPmPlRWg1EbwQrL733Pl5PRAVzT/9V/upo4xnvw
 hYhyfYveY/P/t6+dvVJVxQt+uNM7FsYJfmWNKlY9EnTkr4r3QR6enFiGzxrP5Pusxxc3aZAsI4t
 i1IftHahEuy4Ej8FfrhUeKLlu+ofma9vp7RG/rr+JmfTl5RMI5Rc36jUlTjqlW4z4f1CDJ7pyjd
 9RDV2IOUc9iVbdJ3LsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfXyuVwQF11AA8m
 vtELvH79a3LecOQ/VKebbmcuzxHX/mA+tSRkBJz4bRFXBuyfp/5Dgpmqfe4LXXQtxHfmakzbYsu
 EZkAbiJpTWxpBeIe4i0uuE3DHhkBK7w=
X-Proofpoint-GUID: A4p-A21Spi4YH4fg1AJ8Kg56-9roAlWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080106
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Fri, Sep 04, 2026 at 04:56:10PM -0300, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
> 
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
> new file mode 100644
> index 0000000000..0573b4e07c
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,62 @@
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
> +a machine property, to allow older SW to run with older spec versions.

We'll want a versioning scheme even if the new spec versions are backwards
compatible because users will want to be able to test their software on
strictly the older spec reference models, not just compatible later
models. That allows them to be sure that the software isn't using anything
provided by the later models which is not provided by the older.

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
> +There are multiple ways of using this reference board.  The spec compliant way
> +is using an EDK2 image and a TPM device.  The board was tested with the TPM
> +device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
> +to use this device can be found in `tpm`_.
> +
> +To use this board coupled with the tpm-tis device, first start the ``swtpm``
> +process in a shell (the ``log`` parameter is optional):
> +
> +.. code-block:: bash
> +
> +    $ mkdir /tmp/mytpm1
> +    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
> +            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> +            --tpm2 \
> +            --log level=20
> +
> +And then start QEMU with:
> +
> +.. code-block:: bash
> +
> + qemu-system-riscv64 -M riscv-server-ref \
> +     -bios fw_dynamic.bin \
> +     -kernel EDK2.fd \
> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
> +     -device ahci,id=ahci \
> +     -device ide-hd,drive=hd0,bus=ahci.0 \
> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +     -device tpm-tis-device,tpmdev=tpm0 \
> +     -nographic
> +
> +
> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> +.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 2639866a3e..74e23fa64c 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
>     riscv/microblaze-v-generic
>     riscv/microchip-icicle-kit
>     riscv/mips
> +   riscv/riscv-server-ref
>     riscv/shakti-c
>     riscv/sifive_u
>     riscv/tt_atlantis
> -- 
> 2.43.0
> 

