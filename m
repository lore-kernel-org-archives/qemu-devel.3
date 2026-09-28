Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD6C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8tb-0003y8-Mg; Mon, 28 Sep 2026 06:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8tW-0003ve-Ul
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xB8tV-0005Pl-7C
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:47:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M91c246082
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5CbzSh57V9netNcg1XapNPpH
 IEUR0BGvLm/6aAFLKvI=; b=j5HiuiH29BKHowh3CFJnmQ9NC/LwuNPYaF0hp6uk
 3/8rIONIierogkG0haWShvyj5CLYyQABODUie6/7shHhnvR5uUUPz62F8ZcrX+Ck
 n5Rd9K24NGiikdv6UTXh9iKQsJpWNVNnwZpPSaV5PuJ61VRGIjyeBJnX/HAofQ0M
 Kt5lvDAO+lDPsr4DgRC/wD8qhF/BHHh5CU8flDG1WazVXL+IeTZtBKJ7niOci5Wf
 G/djLovT6bJe5/qcREDHnUv6A4GYfMPhr2ASl9LwGEzsfeP1XC24admC741r0r/P
 zJDvBNAY6Gc04HDnYkAE3yqY5irjZkqhW28gjxBlU/MSsg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt110gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:47:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c77c0d96eso107399385a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592455; x=1791197255; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5CbzSh57V9netNcg1XapNPpHIEUR0BGvLm/6aAFLKvI=;
 b=LDFDUtVdw0cwTAbpl9tTH2po9mkcA+sIlpuo4Drt/GaiXpd5lGvF1htfpIinsrSzha
 VNV0uu3zlGDzV/xvlxfTsV7PZjGjLdD7yd30s7N7kpm/1uBjzMcZALR4bdr0i5TJLwfs
 gfK1LYDE6n47/O59XCkppBvIc3yAZJnNuwDR/JYsKzu5Hpu+EDm2FqtxCETH6Km9WKQ6
 rYY/qic8jlPhTo1hBFQQKZMYVLp+heIskznoK9hAKjl6iTOULaY/zuH5bZTd8m63dz6n
 BgexzhOg0RHRlyyprUQvHNOymOsGDZX9SHUkAExkwul6y8FF0GVpWpYbth1Cyf0V+Ybn
 fxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592455; x=1791197255;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5CbzSh57V9netNcg1XapNPpHIEUR0BGvLm/6aAFLKvI=;
 b=X6xtqfyDhlwhvLJPjpUYfrWMsD8PVEvwtEiP6nArcAFVGfKySgpt1/EXlmPRpG3UGN
 IuCFIYQA+h5oS2jcupxMphAes/nxs8Caoz7O+WOOpEPkn8iP4JlGwzTzQPucydY7Ihoa
 Sc070Iy4vlXLVsN4EHq81lBv0EQpbH1f3WZpaT1dQ0V5lac8/T+NNZ1AneEW7PhJT7am
 lPz+jEhTfZtbX2ljyesoIL+ymcCuMj8RxVwFiexM844pP3Lva5MSpBwkmpUgu6nST3LU
 5Qr17jUWPKPEYUFbiPLqTBxwHeyfkQ4fILoSy1YrtIPOywWM1vFuj6co5Kgj6sqCMJNV
 Aozw==
X-Gm-Message-State: AFuF++lWkNg919lc6SkoyMmiAX0oMpjjZqg+VVv5JlU3UCKf/ENt9zwM
 Yw4BtwDRC+8ckPVqwnP9zSphZFXqflEoK1Dm6aqbicANQLKrX5yGKTIohiU9EbS9qioAUlI+TGy
 7vblxZSA9J8XtowaD6NBWe0wM65pp3/hBzdycEB7NaoJ7V0f/l8gyVVBqpA==
X-Gm-Gg: AYBFou1iR/FLwJkQVKzrb3b2XGX7hSN9ZI8vHWTLFiOIRlAHTOgD//S6jWRBKFVkM0e
 GGYL7JTYB2+waD/viOvWzLAP44LijMEWwisOsD+gJcOYD9Az5869Qy01Lso/xJFFMAty3171B4v
 xuac6XR481VmvZ+pLp7L4z6TlZk69b9CeXCaJce1EHL8xamIaQ9w/bhmEQZsOvcWTDEjEQsYbEF
 xgF75xUf507zjit3fuVyC/EXciUfnOEHiJ13t6v74yvRepW7zptJSVlo52BD0BfFxtquzO0Iwje
 1sb+vsxlsYyHXYW93bQn+qa/K4MUWDrzywHZoaPIr5Xo9pPksslbamuw+mmvSx/WKeueQq4Kd2e
 RXoWyWDs1shpDKpu2QsZ/dMuK82TGLQc3O6D4Xw==
X-Received: by 2002:a05:620a:4512:b0:939:f513:cc3b with SMTP id
 af79cd13be357-93c43c9dd61mr1953951185a.42.1790592455195; 
 Mon, 28 Sep 2026 03:47:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4512:b0:939:f513:cc3b with SMTP id
 af79cd13be357-93c43c9dd61mr1953948585a.42.1790592454714; 
 Mon, 28 Sep 2026 03:47:34 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a2acb4dsm26425246f8f.0.2026.09.28.03.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:47:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:47:33 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v12 5/5] docs: add riscv-server-ref.rst
Message-ID: <spgwi4uj47tgyscqpda2xpvrndgtydejudicqwdcltabxiyjje@bgv52z7nhuf7>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
 <20260917174405.3471736-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917174405.3471736-6-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX3NE6w/bipWmL
 8BJZzIKGi98zgw5cJrKEVmjeNQSySRDzT1dZ5ws6Kac6wfynCHUQoz3s6RQYJ50Nr0PDeIGk2yM
 0Gx1LZIUStXJn8MjggZDXvGkM5Dj/gFyaWywgDFlEbfQf14ZuIWLQH6YBodE5cSD4DQ9m2C0iO/
 O7cqykjZirB20hjRgNh8cwoqllQmVtpDyPRrrr/6lnTEoomF+W1LFx/x3NuxWYr3aK521gfG8MV
 w5H0+659JbDwzl+yR/G2C+oR8sI69OxGLG8B9luQkpQp+30GSE4msu77doSDaeBgBQuL7DYEj3j
 F/K69aAax6pPJtAHtGmnS0TEjdqTgmDuGTSjGgNrfmYqQQiY8VWuoOxveqgrnbNaWBgg4csEKzE
 BKxP67O8H64Ef/fn1fcuuqMJXT55vBeo8NCD4Q3SBEZQz7TcOYIAJMdUjvI3QVHuhrPb+4tn2Eb
 rMsnDPo2slGRwTDlEPg==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba45c7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=acypBfbJLT_Bn9_HBn8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: lqCBRyWFfr5hbIOfOELWMukyXeThNoR8
X-Proofpoint-GUID: lqCBRyWFfr5hbIOfOELWMukyXeThNoR8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX0sRAh23OCPXz
 j6uFkZ+XAB07JkLut9s1ZVTjCn84cGnL/+kjo2yB9KWkxHveNCMcvXBcnvtl8tCxg6XtReJoyBD
 LqY9vsMc0YPJo4HobnqrZC7vD6J8wFg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 17, 2026 at 02:44:04PM -0300, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 64 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
> 
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
> new file mode 100644
> index 0000000000..5b23122f19
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,64 @@
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
> +`spec`_ is version 1.0 at the introduction of this board.  For each new
> +supported spec version a new versioned board will be added, keeping
> +"riscv-server-ref" as an alias for the newest version supported.  E.g.
> +for spec version 2.0:
> +
> +* riscv-server-ref-1.0 - board that complies with spec version 1.0
> +* riscv-server-ref-2.0 - board that complies with spec version 2.0
> +* riscv-server-ref - alias for riscv-server-ref-2.0
> +
> +The main features included in the riscv-server-ref board are:
> +
> +* IOMMU platform device (riscv-iommu-sys)
> +* AIA
> +* No AHCI (can be added via command line)
> +* No NIC (can be added via command line)
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
> +     -device nvme,drive=hd0,serial=ddaaddaa \
> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +     -device tpm-tis-device,tpmdev=tpm0 \
> +     -nographic

Should we add the e1000e to this example command line?

Thanks,
drew

