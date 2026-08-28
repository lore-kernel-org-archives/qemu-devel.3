Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36144C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05eK-0001aJ-PT; Fri, 28 Aug 2026 19:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05eI-0001ZQ-Od
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:06:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05eG-0006UW-Be
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:06:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTIvA3756078
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fE5+FoZiKr2Sa5RCsVANMuI+3ptLbhtUFLS1svoTdA4=; b=EXXGVaICo/QVg9qY
 Y8cQYPhdHzYL5BLgpZq03XtypJQZDx+1byAixEIezaVjHPC0on9xSS0iRdfOwWcE
 2PzPgRZ7IS97KRGo+zo8qzQouPlDksKssXZN8O0qEziFYm8V4ru8nc7Lz2TdFel1
 SASeKXPcq1kaoajV93tD1kOaPxIHMzMFzD/FH8FQN/Kt7GA7c57vK067vnJcjiuD
 KYek0ADOPrDlSfDkNpe5tnBwLTErqkyy+QCGvQwGwkmXfgZaXtYkaT6vZwXa4mGg
 LGHybc26lIPpCC9dOYYApPo3aRcq7mZZSOwEI867yhd7VxEuZmllo/LHucsrzmHH
 dh+8Lg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42rbtj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:06:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso2793542a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958370; x=1788563170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fE5+FoZiKr2Sa5RCsVANMuI+3ptLbhtUFLS1svoTdA4=;
 b=hvIAHa4cC8duElMvfAe+ytXJz4FSz2mYOm2YNv/bXFezbW4K6PPtJZiFrCd6nbFhKL
 mdqvQjSVb/Npf5HZuTwgyF3wm2KBoq4/pzXSQejbCaDS6FDVDoA9DoB19ETtr9/Swt5t
 vQzIzr5BXFbBF1esMzAiLL2zW0Pp49MPRkSgarob/2eXA8YgjAAngwShTtrrTMGdZkI5
 wXRSQH0B1Tq5iZTLpMU7ag8pY+XpgR2uCi3mKQLNq/BoR4eS2Ak5VCu1YOmMMCfGBQDv
 OnIcqhHR/6syZjKO7IN95YLUInJ1tQf85/bk0uK4ICcHFYqXbQEEVnVxEghG8AxDBFJH
 wshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958370; x=1788563170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fE5+FoZiKr2Sa5RCsVANMuI+3ptLbhtUFLS1svoTdA4=;
 b=gZRDuK7lhsMmOufTGTr0niYtRoshMiCjGOkzwbJmMRYxdlb2ait8dZqIJ9q88hBl4O
 4ZIB0jpq0c06+DKGkP8nofPFA4Imf096eB6hzA3fQ6QBMu9/Qt0RPPEElvQUU7JR5aiW
 Uy1MeUEZKmDcYKI5ajkuwgMMYSuXWDPx7v5e+riaP55s3DQ8SRvVOoov0Xv1pvITu0zu
 NJDCP5av0DrFF57NoawD2qnWf/E8Q57dqSDDoQhVMAXqak7tIIqflikkY0wc5wYN/71X
 IYDQb3qzKf6/yVcAZpXa+Pd5CRAamqaUG2jKPXYptKvOvbblTA+l/u2EnPT5whbaKPeo
 +Cvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxev66TIfxQq/rf9ZDejlcVCNzSIEP5XRq8e0MjwlS5TE+SIRt64OGZ4jLbeTsK/ERwSvuvOo4FKgRM@nongnu.org
X-Gm-Message-State: AFuF++kYtuorQmcNxNLbBKxXOBFSqFMG1TotV8bcIpELxEzi/g2kBGxU
 vx/4B99V1XUHzW1ZFcCAMyi+f1dKl6MVzrCT6WjU1tffaYCV1iJXVQ4Sc/nN0PGwtq9dnMflhSQ
 gRMZQRKO+rKUb/X0hHwVFRLMm78rLflzAu7d4FroHE9a6HqCZajP9rja7uA==
X-Gm-Gg: AYBFou3xPoFQMxKcENM8zDQSRWZ3a8/KQFXCju95fdYf5kpKaTKxO+rJdLvXEMeqdIg
 hsR56bSwVqL6faqUBL1tFQGkaACZ3BsMhUft4gco59rgMtj9T3nV3cR/tOmPUeC6JtI2P4s763Y
 SHUevnfzlu19Eh8tGV7y9xG0+kzwgQpNXrfRutEIkJvHFTFdF9bxlWvRVIHb3i468D2MCtp0879
 LpFurGsBZB6kkIIgZ+6vrC8pV+nbKd2tS4HcCKYVQmsjwcv5CJtFl6x+z2zTU01XPsuuN/527Fe
 1Z2spGRa6fcZaHJkorZ6FfGwJQGOw84WZOAvm6+xqGJN3kdm+aAZxLcRligdgoCdoNc+g27RTjL
 7mjQsvUx4VHmZ00LCpkFg3DRhj3QX74y+9eeBU1PPj5EzM06HBnhhTNVN7ql8RlExaJpV
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-396d0f2391cmr17399759a91.7.1787958369917; 
 Fri, 28 Aug 2026 16:06:09 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-396d0f2391cmr17399719a91.7.1787958369403; 
 Fri, 28 Aug 2026 16:06:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d1abbdsm8506420c88.2.2026.08.28.16.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:06:08 -0700 (PDT)
Message-ID: <e62fd6e2-d5f2-4c2d-b4c6-d40ee17cbcf1@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:06:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] single-binary: link ARM and RISC-V into
 qemu-system
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bibo Mao <maobibo@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hsNSvFTh6b8NBwDEvO2MuZ_SvAHvnpPh
X-Proofpoint-ORIG-GUID: hsNSvFTh6b8NBwDEvO2MuZ_SvAHvnpPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1j9YI4p165E8
 eU75U+ORUHqZAfzhPLEzbKhX8qxK3VMqctcjyUESC1KshsysrSC5EPlU/vd23l+jAg65/vspBE2
 ts1gbUI6lzFWjJSuUdLpWOawWXsQakKS+VMnXXUp2t+JsNbIM0ou41iNE1BkBsyOTroPz9IgwHl
 c/zaQyp4LqzDHLBszHSoe6cNUK8e9pjyrYURYhQr3AttwT4GezBGb+m/TQacpRfvSUDWJVNHz7Z
 2H+7T21wAkWloTICove5mVUr01vWr4aNIhDbDMzvnBEvJ41wiAXEa3bltNB4MXPdQcn9ErZav1V
 eHHmvr1hJOggqLFUeZNM7/YWZOZX3Rvgc+bXHaPxdE6JJ5OTwxrapSE35XdvbGcZQzMzfdCDG5a
 I2eA1leZFM7odOEdYgENOE6yh+e0K4k4yCUP96XnC6Xf4FBOKtepxojLYLvONDofk/1yfwqTrFt
 NtmXanObdXaO+oufqZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX/Qd5jI1xLNhw
 5+Tzx4TXa/jXPEwFD5AN6tVIQJIAoP7wJm/Dk7nwFwRLFfbuhGQt1WnbutR3VewdN/sdg2Wb8GC
 kamZnglUAbVSyQbghtjT/Yy8ES7++E8=
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=6a921463 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=GaQpPoNlAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=wAUz5CRPtLaz9UZ5HuIA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/26/2026 11:42 AM, Yonggang Luo wrote:
> This series produces one qemu-system binary that can run ARM (32 and 64)
> and RISC-V (32 and 64). It follows Pierrick Bouvier's merged series
> "single-binary: implement dynamic filtering for machine types":
> 
>   https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com/
> 
> That work added TYPE_TARGET_SPECIFIC so machines can be filtered per
> target in one process. This series uniquifies remaining per-target C
> symbols and QOM names, selects TargetInfo at runtime, and links ARM
> plus RISC-V into qemu-system.
> 
> A combined link cannot keep C symbols or QOM type names that were unique
> only because each qemu-system-$arch was a separate binary. The first
> patches remove those collisions:
> 
> - TYPE_ACCEL_CPU is a single abstract accel-cpu parent, registered once
>   next to TYPE_ACCEL. Leaf names still encode the CPU type so
>   accel_init_cpu_interfaces() can look up "<accel>-accel-"
>   CPU_RESOLVING_TYPE.
> - ARM and RISC-V virt QOM names become arm-virt and riscv-virt. The
>   boards keep -machine virt via machine_class_set_name() after the
>   selected target is applied. Latest ARM virt still sets mc->alias.
> - virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an arch
>   prefix so the combined link does not need meson -D name mangling.
>   LoongArch virt_acpi_setup is renamed in the same pass.
> 
> Target selection then has to work with more than one TargetInfo in the
> process:
> 
> - Parse -target before TargetInfo is fixed. The token is target_name
>   (arm, aarch64, riscv32, riscv64). When -target is omitted, infer it
>   from the program basename (qemu-system-aarch64, strip .exe).
>   qemu-system with no arch suffix always requires -target; there is
>   no unique-TargetInfo fallback. Use -target ? to list names.
> - Combined binaries cannot keep one global C symbol per arch for
>   query-cpu-definitions, dump notes, or Angel semihosting. Those
>   handlers move onto a process-wide TargetCpuOps table.
> 
> The last patch still builds qemu-system-$TARGET. qemu-system is extra,
> from the union of ARM and RISC-V Kconfig plus aarch64/riscv64 arch
> objects. Do not replace the per-target binaries with symlinks to
> qemu-system. Do not add qemu-systemw on Windows: a GUI twin of the
> combined binary would keep QEMU exporting data from the .exe into
> DLLs, and those data exports cannot be delay-loaded (qdev_prop_array
> and other qdev_prop_*). That would block enabling modules globally
> on Windows.
> 
> Examples:
> 
>   qemu-system -target aarch64 -M virt ...
>   qemu-system-riscv64 -M virt ...
> 
> A combined binary named qemu-system with no arch suffix always
> requires -target. A missing or unknown name fails and points at
> -target ?.
> 
> Changes v1 -> v2:
> - Drop little- and big-endian TargetInfo variants from this series.
>   v1 registered target-info-<name>-le and -be, selected is_default from
>   TARGET_BIG_ENDIAN, and accepted -target tokens such as aarch64-le.
>   v2 keeps one TargetInfo per target_name. Endian variants are later
>   work, not required to link ARM and RISC-V into qemu-system.
> - -target help/? lists target_name only. Unknown names point at
>   -target ? rather than printing the list and exit(1).
> - qemu-system with no arch suffix always requires -target. v1 could
>   still pick a unique TargetInfo when only one was registered.
> - Keep qemu-system-$TARGET; qemu-system is an extra binary. v1
>   described installing per-arch names as symlinks to qemu-system.
> - Do not build qemu-systemw for the combined binary. A Windows GUI
>   twin would keep using exe symbols from DLLs, and data exports
>   cannot be delay-loaded (qdev_prop_array / qdev_prop_*), which
>   would block enabling modules globally on Windows.
> 
> Based-on: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
> 
> Yonggang Luo (13):
>   accel: use a shared TYPE_ACCEL_CPU parent
>   hw/riscv/virt: register TYPE_TARGET_SPECIFIC
>   hw/arm/virt: register TYPE_TARGET_SPECIFIC on the abstract parent
>   machine: allow -M name to differ from QOM type
>   hw/riscv/virt: use unique QOM name
>   hw/arm/virt: use unique QOM name
>   hw/arm/virt: prefix ACPI helpers with arm_virt_
>   hw/riscv/virt: prefix ACPI helpers with riscv_virt_
>   hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
>   target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
>   system/vl: add new option -target
>   target-info: dispatch CPU QMP, dump, and arm/riscv semihosting
>   meson: build single binary
> 
>  MAINTAINERS                                   |  1 -
>  accel/accel-common.c                          | 21 ++---
>  hw/arm/virt-acpi-build.c                      |  4 +-
>  hw/arm/virt.c                                 | 17 ++--
>  hw/core/cpu-system.c                          | 23 ++++++
>  hw/core/machine-qmp-cmds.c                    | 26 +++++++
>  hw/core/machine.c                             |  6 ++
>  hw/loongarch/virt-acpi-build.c                |  6 +-
>  hw/loongarch/virt.c                           |  2 +-
>  hw/riscv/virt-acpi-build.c                    |  2 +-
>  hw/riscv/virt.c                               | 12 ++-
>  include/accel/accel-cpu-target.h              |  3 +-
>  include/accel/accel-cpu.h                     |  2 +
>  include/hw/arm/virt.h                         |  6 +-
>  include/hw/core/boards.h                      | 12 ++-
>  include/hw/loongarch/virt.h                   |  2 +-
>  include/hw/riscv/virt.h                       |  6 +-
>  include/qemu/target-info-qom.h                | 42 +++++++++-
>  include/semihosting/common-semi.h             | 56 ++++++++++++--
>  meson.build                                   | 69 ++++++++++++++++-
>  meson_options.txt                             |  2 +
>  qemu-options.hx                               |  8 ++
>  scripts/meson-buildoptions.sh                 |  3 +
>  stubs/dump.c                                  | 27 -------
>  stubs/meson.build                             |  2 -
>  stubs/qmp-cpu.c                               | 21 -----
>  system/vl.c                                   | 44 ++++++++---
>  target-info-qom.c                             | 77 +++++++++++++++++--
>  target-info.c                                 | 32 ++++++++
>  target/arm/arch_dump.c                        |  8 +-
>  target/arm/arm-qmp-cmds.c                     | 15 +++-
>  target/arm/common-semi-target.c               | 23 ++++--
>  target/arm/meson.build                        |  7 +-
>  target/i386/arch_dump.c                       |  8 +-
>  target/i386/cpu-system.c                      | 12 ++-
>  target/i386/cpu.c                             |  6 +-
>  target/loongarch/arch_dump.c                  |  8 +-
>  target/loongarch/loongarch-qmp-cmds.c         | 15 +++-
>  target/mips/system/mips-qmp-cmds.c            | 15 ++--
>  target/ppc/arch_dump.c                        |  8 +-
>  target/ppc/ppc-qmp-cmds.c                     | 15 ++--
>  target/riscv/arch_dump.c                      |  8 +-
>  target/riscv/common-semi-target.c             | 25 ++++--
>  target/riscv/helper.h                         |  6 +-
>  target/riscv/meson.build                      |  4 +-
>  target/riscv/riscv-qmp-cmds.c                 | 15 +++-
>  target/riscv/tcg/bitmanip_helper.c            |  4 +-
>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +-
>  target/riscv/tcg/op_helper.c                  |  2 +-
>  target/s390x/arch_dump.c                      |  8 +-
>  target/s390x/cpu_models_system.c              | 15 +++-
>  tests/qtest/fuzz/fuzz.c                       |  2 +-
>  53 files changed, 562 insertions(+), 207 deletions(-)
>  delete mode 100644 stubs/dump.c
>  delete mode 100644 stubs/qmp-cpu.c
> 

This series iterates on v1, but still does not tackle filtering of
devices/cpus between the targets. This is a prerequisite before being to
mix multiple targets together.

I sent the following series to show how a full filtering would work, and
if it's a direction people here would be interested to follow:
https://lore.kernel.org/qemu-devel/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

