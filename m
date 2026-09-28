Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8937ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDBY-0000LZ-89; Mon, 28 Sep 2026 11:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBDBR-0000Jr-SX
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:22:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBDBQ-0002dB-44
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:22:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEe2iN1498447
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vqeueA5Dwdg+0bPoxFwzCulXHUqlvv8BKEZ0XdYkxOE=; b=didemMwdE77M6p0q
 WtiwDYc/HmaKD1X/Ke7/EsYHZEMrJLsN/eLI0TGjaE0q5iY19tYM8/bx2E/Praep
 d2YebbHuIxR9eniZw3EX8+4I99Lq2+cSDOj7tBE7ix+kVWWCG60ZFM2jY5r9y+KD
 W0iF8RzpPmO7V9MDWk9pSSJqrEUXxh/Wf3JxHT+jArih/JwE3ord26rlolDoVa68
 qSVbQF8C90YChxQIUOzELa1LY+dH6w65rXiOtFxBYrejEY1Aw6HNkCtpuShEjxL5
 7uLlL0guMJp44FLsz4zTfiqe7A5z72cmyxbCPfAS+H0TkatlmNpagY/AGuhcRKgG
 jXiRpA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5msykf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:22:20 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8a77e58a8ccso44501967b3.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790608940; x=1791213740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vqeueA5Dwdg+0bPoxFwzCulXHUqlvv8BKEZ0XdYkxOE=;
 b=OFicUQf+D2YK2eB872Cb7h3UXExqNLNV/y11iaIJXxqxWRQCgRpZ8Mngbt6BIbHAfE
 s2tA7R0F7iUSKlRyAl24PR8E9TaG/GKyBD8AbexPLc9Ga7Q9skwg4l8P63Z1rYgcGMNn
 gKBznkFOMGpX43pRyjjF3d2IkK47MLSfPyeKMHY8aRopnlSceuoG0pur5HrRdzZ+0s+x
 Cnpjp2MxgHMKS7umXjE+zdwm4XCzecC4uusv2H6e/lZQQlaXmMu9J31+ods2DD1JC/NQ
 Y4zvvqWNEFiB2hWVH/5TizZeUaFjTMHf7hYq4VRhZ4KgiUjU3n0ja5PJfdC/5w3qyxlS
 7ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608940; x=1791213740;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vqeueA5Dwdg+0bPoxFwzCulXHUqlvv8BKEZ0XdYkxOE=;
 b=yissSoF3KEqvIlB2VhT+LKjU8YMVHDqmxu3LqDTXXAXWxv8MA2KXNS0XGDrSHKgKY+
 Ke0vy+k7DVdCzMfFn5m/2M7mFDgn5DamutFcRPeqvwe1+YrHgRP549gfTmhgBO/lCpXw
 dSPruaEs+3R9jIyH/iucHi150JPt20Yq7uba2tI8EKmjA5Wf1ttGIr/WgWYO+9sicJT4
 fvNnIxT7oiEZFjNfAtRoH5xS3AEGxQiEdW0StaENPLRu8d0+FrUnDYbAz388iais4ict
 jp0ho93cnyFQM/ZGgTvtC9ywgipS+f75H6uNAYzIJcrCpUYRzHEwouOrU3R4vN1tgPUm
 eUlg==
X-Gm-Message-State: AFq9FYJ2jXfOFiV5FN7ZIC2CWT478Dx7uK8S3EVGyAmbLebtuOG4rQP+
 nViQWt9gDKCKIjVCwDGxKIa1AJPwH/mOAI5FDcBCqCrYy2seYQaF+h+SShSKQKVv1UHadXRSM6E
 QnfXeuafd4KFBHs8CmJ+yCHDCo+9rx8g6GPijDbyULeB6tPCruLNuJqOaWw==
X-Gm-Gg: AYBFou1gAfQ15l94Utc57LlHNqxIvHVHOTVu0v3tsKNVallkDnLJ97kACCpCcjCWcRs
 ulAXwlav9J6pJSMZId0USkM0PruRxyxJZhQMT1Hqmuqs9Q9/jKL3A3xsLvj3WXqP0mk8iDFnR8l
 /DtFMFLye9iO8awm4A83dw/RycU+IFzbytJFPvTExeQfI4P7a1ytIkbsvRb/SpNq3xh4ZKyF5QV
 Tf3xwTDVCbQCYcXqZdS+wgN9sdVk3p7P0RfLS7TKhBQSpuw+yQ8s9bhnhwBWnJrX37Dqe7nm82Q
 UeeecvdHDjNJWtt7EKY2KZnI8vK/fiRIdalcAPaNMJrCLDTV2AEC9yw2GtPR/dftkWdu0sVDB56
 UTpwLSWKbR95HZcuXYKZ02mR419mV8pvMDg==
X-Received: by 2002:a05:690c:83:b0:87f:bf8d:3377 with SMTP id
 00721157ae682-8a64e4b9525mr64414877b3.63.1790608940097; 
 Mon, 28 Sep 2026 08:22:20 -0700 (PDT)
X-Received: by 2002:a05:690c:83:b0:87f:bf8d:3377 with SMTP id
 00721157ae682-8a64e4b9525mr64414597b3.63.1790608939607; 
 Mon, 28 Sep 2026 08:22:19 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8ab391acfb0sm2879967b3.48.2026.09.28.08.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 08:22:19 -0700 (PDT)
Message-ID: <2e837af6-720c-4ac5-9e5b-5750f45f23e8@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:22:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] docs: add riscv-server-ref.rst
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
 <20260917174405.3471736-6-daniel.barboza@oss.qualcomm.com>
 <spgwi4uj47tgyscqpda2xpvrndgtydejudicqwdcltabxiyjje@bgv52z7nhuf7>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <spgwi4uj47tgyscqpda2xpvrndgtydejudicqwdcltabxiyjje@bgv52z7nhuf7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IVQlduXIF-1qj2jJYTFIzymtIlE4ovj1
X-Proofpoint-GUID: IVQlduXIF-1qj2jJYTFIzymtIlE4ovj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX/9xiVvbndjYd
 JFvY68HsDhNX2HOU6dRluhzUH6J9An/4CHGKYBf0O5yLLRQWYEiGQ3Iczf1RkkzHB6XRg8x+M1s
 qfX22oocJW+R9A2QNL0F/sqgriw9KhnyN++i3y0z44ZMmE+A/CZLCofUBEuQnRCm7ENN6JLPijL
 sQTlZOlSh6l3+dxpMoYozlbGri62C7V738Kz3LaDAwlVjVWb17Yapb/jNfsjzutC/xPGTexbCnR
 aZx4Sw8weBTjlLWFKCYYoaALDtaee3CUvTxPISA2AMxALCr7Pgb/OxLLHWfKtG0IDMTSFUFAqrZ
 53GGihk9ECJ5dyTMSPUWzOMP1Jo+79JzzFIrjX8eFkyBOvXJiD1FtBfV7KHlVe/vEbnJkjpOUKU
 Lt3yAzvw+ioC1x+dpoR7HSxq4TNSM6wm0a35v20+hlY/kYe6kc3jYmlmLTzAhCw02Ay5bR7v1JQ
 oO6WYvpeOVkU+hCQNJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX0/d9azh+Rlw2
 iGSwZhrD9zrBJTCk+y1EpeHySJ3pw3YWIRjJG7ljip5/Lc+vIqAULD7mS+6wDTVoBwpws6y74lp
 S9PEx+ncw8bgv3MzybF5+DgMxG93LnQ=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba862c cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=AbjpwKpZfJmGdCkLGqQA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/28/2026 7:47 AM, Andrew Jones wrote:
> On Thu, Sep 17, 2026 at 02:44:04PM -0300, Daniel Henrique Barboza wrote:
>> Add documentation for the new riscv-server-ref board.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
>> ---
>>   docs/system/riscv/riscv-server-ref.rst | 64 ++++++++++++++++++++++++++
>>   docs/system/target-riscv.rst           |  1 +
>>   2 files changed, 65 insertions(+)
>>   create mode 100644 docs/system/riscv/riscv-server-ref.rst
>>
>> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
>> new file mode 100644
>> index 0000000000..5b23122f19
>> --- /dev/null
>> +++ b/docs/system/riscv/riscv-server-ref.rst
>> @@ -0,0 +1,64 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +RISC-V Server Platform Reference board (``riscv-server-ref``)
>> +=============================================================
>> +
>> +The RISC-V Server Platform specification `spec`_ defines a standardized
>> +set of hardware and software capabilities that portable system software,
>> +such as OS and hypervisors, can rely on being present in a RISC-V server
>> +platform.  This machine aims to emulate this specification, providing
>> +an environment for firmware/OS development and testing.
>> +
>> +`spec`_ is version 1.0 at the introduction of this board.  For each new
>> +supported spec version a new versioned board will be added, keeping
>> +"riscv-server-ref" as an alias for the newest version supported.  E.g.
>> +for spec version 2.0:
>> +
>> +* riscv-server-ref-1.0 - board that complies with spec version 1.0
>> +* riscv-server-ref-2.0 - board that complies with spec version 2.0
>> +* riscv-server-ref - alias for riscv-server-ref-2.0
>> +
>> +The main features included in the riscv-server-ref board are:
>> +
>> +* IOMMU platform device (riscv-iommu-sys)
>> +* AIA
>> +* No AHCI (can be added via command line)
>> +* No NIC (can be added via command line)
>> +* No virtio mmio bus
>> +* No fw_cfg device
>> +* No ACPI table
>> +* Minimal device tree nodes
>> +
>> +There are multiple ways of using this reference board.  The spec compliant way
>> +is using an EDK2 image and a TPM device.  The board was tested with the TPM
>> +device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
>> +to use this device can be found in `tpm`_.
>> +
>> +To use this board coupled with the tpm-tis device, first start the ``swtpm``
>> +process in a shell (the ``log`` parameter is optional):
>> +
>> +.. code-block:: bash
>> +
>> +    $ mkdir /tmp/mytpm1
>> +    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>> +            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>> +            --tpm2 \
>> +            --log level=20
>> +
>> +And then start QEMU with:
>> +
>> +.. code-block:: bash
>> +
>> + qemu-system-riscv64 -M riscv-server-ref \
>> +     -bios fw_dynamic.bin \
>> +     -kernel EDK2.fd \
>> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
>> +     -device nvme,drive=hd0,serial=ddaaddaa \
>> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +     -device tpm-tis-device,tpmdev=tpm0 \
>> +     -nographic
> 
> Should we add the e1000e to this example command line?

I'll have to re-send sdext, which will imply in another rebase and re-test of these patches,
so might as well add an e1000e example in these docs.  I.e. I'll send a v13.


Thanks,
Daniel

> 
> Thanks,
> drew


