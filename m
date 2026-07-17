Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65575C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkian-00010w-Lt; Fri, 17 Jul 2026 09:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiah-0000wF-TL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:26:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkiaf-0007Dw-0n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:26:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCTKj01755170
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +0YU1T0vWzgT8jlDIM8QTFYOwuPUiM0KOIQe0NdqIQU=; b=XWS/GdFXewkWeWcn
 phT8t+EfRidhNbseOorg56BtiHYD/w38xyQkGR24wKV7amdc2QrOneo9kZ79gKB/
 oOQJbCv3jK36pzHF/+32yX1pJEEv6uWxPiTAf/MaPpACGF24SO4H+I7wgOFFOkUR
 fZgOnH7lr7gvAE5u6KQxOyBek/j9RH3Y6daAMt/5k2W6J+LevU6xBp8NqO70ordz
 PsFTELOIhiOOTq36KqBs1S4LP/bNWaVJlsLP3WUFoe5AN2npz3wGi2pCFXs6feO9
 3WTAV0tXZsyD0SbqNhzKb3j06YVHJlwP/EOnS207AeNWbwMRvXNjItOU4kD6Id/5
 AKgJcQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2vd2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 13:26:55 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7f5b54da461so82088397b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784294815; x=1784899615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+0YU1T0vWzgT8jlDIM8QTFYOwuPUiM0KOIQe0NdqIQU=;
 b=Zi2fWshzucRGvmV9HtAonCF5bIzbXzDs6XXqFpr7TbhnMFbFSwRo5kRykRS5ijCj91
 dZnmZ+CRJd/dFSoF8+1GeYKFslIf+MB4HvicyF1kncJi+EvRYE8GD6s+8Ud56bI+H5+B
 yRDvKjFiMJN4gpx0jOhJjdUN2MyGG/1GfgiP4kOhfXgeRLwyNWrwa8mjaJ1+SQz4qfHD
 /x9ILavUAiHN3oxw9QI75H3Tm3V4hnJ+SdT/qo+hzEukGXmFqLwbe8UKOo6E3m82+8ZX
 JYYsgUdUW3eVBcP9B0jmhG29kI2fQiZkCtDc6iQm6Nz2iGZ7tOXuVFO8G1tzlU1H2/ke
 WLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294815; x=1784899615;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0YU1T0vWzgT8jlDIM8QTFYOwuPUiM0KOIQe0NdqIQU=;
 b=DV85vjCPl4HsQ0eymK4Ld5pFHIiOj3deTMSx8ojr2v66x3iDHcny1tuSPIIw9SKXg9
 rjv3UYJAC+Rl1OaLWER/EUUA+fgdP+IsWSBG17plx6hQsU9l3s7stEM5B3H1POfgrJL8
 KR6n00ENweAy5ROmtpkzBGNVFgOdwX6P06b5yX/7bOxbcWlZTsuvnTryCoVVCXNVdzBW
 5KkwvsZzGnN5nYmTSchHAmeqKbnuQ8nrIFVwpFCxGzElR2wjKVx3Xts0OcefnXcRVUv3
 qCiLHNDTBrrC9CzOEmZHlcrBzRaCpvQ5rATEy5hvXmKuivs4Ws8IqrenejRI41PcajEu
 QcAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/aAuRyL/CH9ByG49l2S+/vQzwxLYnT/N/xDm1muXNqunzyaSYYDnRX+G/7ezI9NDKA82I9HLrG63q@nongnu.org
X-Gm-Message-State: AOJu0YyOh+/NRwMXtajmMDNorGWyL1qDzE8nJ+EfXd1CHRvJ1xJGfIjm
 TfzHq9isnVt656XZO1++j3CfzoBvU44dTJOwSNcgtsKkm/Wwo8DeTGZtebhutDrEsOy4mhMpNGE
 oV+592qIeFDNtEOrvmrj5kGZZrM2B44XC2zzETsBzcpBO+vhAJFAH0pY3Eg==
X-Gm-Gg: AfdE7ckxnXomAVvQcrfL/CK8/cuyADZaVFNqLgKz4GYad37ZAMwKjjBXW6l+0jdW+zV
 6CKNbUMsCCfVbbUdmBqngTUWvIv0OQypXpEtfRIHaaNK9Nf4pcQsZW0i3ZlSnC9DpTZ2G04g7hL
 ttqCWYblkyCeshlz+yJU98b5Ip+xl2XfgxL671bBbFonOK/RvVRvhLDJLWwjHpEUg6SCMrkwn3v
 /PNRCjkoeKbuFHgD1FrWUq7eVPifw/OuQtiyOT6EAx6ccy/zBX/3TLv5BphMcq1PA+oEFxyxNi0
 ETQ9R032IG3WbLDHpv76VmpV+7ym1wo6T8gY88y9IGcXODfAC0Ra3veB6ZkHIbKypZHCTDAuYs0
 bADlGvw8lKM/xocczA34qbBwJsKgNgiUKA/azqQ==
X-Received: by 2002:a05:690e:4399:b0:667:a683:9990 with SMTP id
 956f58d0204a3-6683bd4eb7emr524360d50.78.1784294815369; 
 Fri, 17 Jul 2026 06:26:55 -0700 (PDT)
X-Received: by 2002:a05:690e:4399:b0:667:a683:9990 with SMTP id
 956f58d0204a3-6683bd4eb7emr524348d50.78.1784294814763; 
 Fri, 17 Jul 2026 06:26:54 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b80eb54sm1333142d50.13.2026.07.17.06.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:26:54 -0700 (PDT)
Message-ID: <8e5b44e3-9054-4e81-ab76-89d853221299@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 10:26:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] docs/system/riscv: document initial virt RPMI
 support
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-9-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-9-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nupsd8Mj_uwM4wbp1hhGJvre_0qzz_EE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNiBTYWx0ZWRfX6KgOHIwjqb4u
 fWOyCswOhQ4IJ//4u6sQnls6L3ryvFodIkJmRpzZ+/64ra5dt2xuvlN2FOMIHCb1o63O85EJbXO
 b21nn4xDWSJbpUSbyy4dUuF3tSiuif0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNiBTYWx0ZWRfXzrgVQRR4szcI
 Vb50xyXZozeFGqsfJKClou0smNY90XC1LStiIa/RcQi8m9cW5E/0WWsuX2rqkOpjjpK2gXdOgzl
 b/eKRlYzbZFnobk/3UrbyufVB+LsixAZZDtuvIhOAgljYvhvt0IxWHhuPHJjPi9+mMJT/1OlYm5
 iy/oA6Milcxu+yBei/6CfQt5wEjtLiNx9fKEVTGtTals0FuPbfXnwiVQOkx7HBVDtO01TtUQCK+
 oqPfImQe/yLHtMOPxlAHC87r6k6wUuan0I+wZ8nZoc906bjvacspc9Sd6jg5mvjj027fxlB6Ydz
 dUFqFiuFZM7K+A1X+RO4YpVcvTOOrDvZwMx+xOX2ZjvlByargO3HSJi/WsyFeL3NN33ANyD6eo8
 1cbgPDrDhwohjI7SV+FrzYGWIGTWq4cyIz69thGJXjz2Lb9e5/xGom0mkqHej7Pna2v7FFQAHhl
 ctwzTsBH8LzZC+Z441w==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a5a2d9f cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=xqlBBKlOt2JiA3_xaBgA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: nupsd8Mj_uwM4wbp1hhGJvre_0qzz_EE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170136
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Document the opt-in virt RPMI transport and the initial HSM, system
> reset, and system suspend service groups.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   docs/system/riscv/virt.rst | 65 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 60850970ce..31cd945a3b 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -146,6 +146,71 @@ The following machine-specific options are supported:
>   
>     Enables the riscv-iommu-sys platform device. Defaults to 'off'.
>   
> +- rpmi=[on|off]
> +
> +  Enables the RISC-V RPMI shared-memory transport. This option defaults to
> +  "off", is TCG-only, and is available only when QEMU is built with librpmi
> +  support. This support targets the RISC-V Platform Management Interface
> +  (RPMI) Specification v1.0 Ratified (`RPMI v1.0 specification`_). The initial
> +  ``virt`` implementation exposes RPMI system reset, system suspend, and HSM
> +  service groups. System reset can request shutdown or cold reboot through
> +  RPMI. HSM uses the ``virt`` hart IDs and supports hart discovery, status,
> +  start, stop, and suspend commands. System suspend uses QEMU's suspend and
> +  wakeup path. Migration is currently blocked while RPMI transport and service
> +  VMState support is being designed.
> +
> +  The build dependency is provided by `librpmi`_. QEMU requires librpmi 1.0.0
> +  or newer. If the host distribution does not provide a librpmi development
> +  package, build and install it from the upstream source tree so that
> +  ``pkg-config`` can find ``librpmi.pc``:
> +
> +  .. code-block:: bash
> +
> +    $ git clone https://github.com/riscv-software-src/librpmi.git
> +    $ cd librpmi
> +    $ make
> +    $ make install I=/usr/local
> +    $ export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
> +    $ pkg-config --modversion librpmi
> +
> +  The librpmi repository can also generate installable ``librpmi-dev`` Debian
> +  packages with ``make deb-pkg`` and ``librpmi-devel`` RPM packages with
> +  ``make rpm-pkg``. After installing librpmi, configure QEMU with
> +  ``--enable-librpmi`` or ``-Dlibrpmi=enabled``.
> +
> +.. _RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
> +.. _librpmi: https://github.com/riscv-software-src/librpmi
> +
> +RPMI firmware and guest smoke
> +-----------------------------
> +
> +A firmware-level RPMI smoke test can be run with OpenSBI, a Linux kernel, and a
> +RISC-V disk image:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 \
> +      -machine virt,rpmi=on \
> +      -cpu rv64 -smp 4 -m 4G -nographic \
> +      -bios /path/to/fw_jump.bin \
> +      -kernel /path/to/Image \
> +      -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
> +      -drive file=/path/to/rootfs.img,format=raw,if=virtio,snapshot=on
> +
> +The OpenSBI banner should report RPMI-backed HSM and system suspend support.
> +After the guest reaches a shell, normal guest reboot/poweroff commands exercise
> +the RPMI system reset path.
> +
> +RPMI device tree policy
> +-----------------------
> +
> +RPMI is currently described through FDT only; no ACPI representation is emitted
> +for the RPMI transport or service groups. The ``virt`` machine uses the
> +``riscv,rpmi-shmem-mbox`` shared-memory mailbox node plus child service nodes
> +with ``riscv,rpmi-*`` compatible strings. These binding names are part of the
> +RPMI RFC surface and may be revised if the RISC-V RPMI bindings change during
> +review.
> +
>   Running Linux kernel
>   --------------------
>   


