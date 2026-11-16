Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E6606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pz/Xx4Ua;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TOiDFeRP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSlyZ-0005js-Vz; Sun, 15 Nov 2026 20:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSlyQ-0005jc-QX
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 20:57:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSlyO-0001MN-CV
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 20:57:34 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG1Kn8D073224
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i3MZ2uus/5Codv5K2DQgIrHsFztnt3cTBUXqJs1ht2k=; b=pz/Xx4UafN9m162j
 rk6wXvB/muuYo7RC88ESaohCzaf/qptQEYUuilwTEFmjqZB/fi8shPHdAPicP0V0
 08gdviRVw+kQy7iUaP29P09qJrhU36Xy2qZOJ8giqvKQO/HqZvodGr4AJfsn8s1Y
 BRiyjknnVPfKZue/HIIg8OpHSEm5mpeEw7iEgHfWq+B9KB2dOfOJNacWe8qHCeR2
 TkZ9dEfgrt2eKineAS+cizYSChT7ZjCkMh5vu/MTpVC7K8yw3fyFMFX0HUfIH0No
 y+ngIwgMjWaaohoCaqPyGZhq6bVZDruPycvDfoJ+SNE1gt6f1chWMrR7Rtpe+Z3y
 tlonvA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjvbx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:57:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8b7cc3f8a4aso1732999b3a.3
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794794248; x=1795399048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3MZ2uus/5Codv5K2DQgIrHsFztnt3cTBUXqJs1ht2k=;
 b=TOiDFeRP8XGJKSup1q3vpmnu8HOJFi8QBGMhmXb6eeiMeKViXk1kSwvviO4WtnFrB+
 9rpogQF7eXhDJgZU4cYRpzf5wquv+uv09R5yAnPx6j7fXg7078HuhziKxUsa6WUZPcYH
 hRk1avS7BT1wT2AO+Cv7ocB2O+WfaYHFDYxxTsMlEA+QjwdUSzhopvR7Iz692jf/En/T
 w08F0Pe+VHwivLA1LK7/2l0spgewmVQ0fokgnV80Lk28eQqyXuIgWZlP2Omyro8LwB/Z
 TRZM7G67cCMa8+JB/YF5FoehBNwoCQdRUczpm3y69GmVydR3laGjQB1L4XmakkBGoGCm
 d+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794794248; x=1795399048;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3MZ2uus/5Codv5K2DQgIrHsFztnt3cTBUXqJs1ht2k=;
 b=K0BVWZuBlOfHXb6uykXur4NetBZj6trw2FlhbqvhK8SG6Q+dsknw6+JJinO7MJivEX
 S4g7tTo4qxUb2/9syZqZ5Ly5YbfsY34sUksvQF7aMM+ITkP7ZG0/1HfFEtquCc2tRvWt
 BMRfuxp8j0kAgVhI2jDkmToAOpGF1YOO9czK0WmsfHMPWunYolQbAQe+GV8ijO2Um8wq
 uUtZhvnbL5IcZCk2SQEq3tgaCaBDDA4HYEL8OBVuOOjT6JTSaG5VfecyqnEUBrLpgA9T
 nCLcpBQgqseNkDwNxxpVRy151YyOTrMjt92X4AqMSnREfG41CScRV7G2MRFrcSaEjjMo
 dwbg==
X-Forwarded-Encrypted: i=1;
 AL+hErE9TDFYCRUD8OzoFe1SdW7V8oSMHqK6qsJCpW4ykm41sPGIpXIAJhIiB2YSI4Bz972tY6RyKLEG9Ej/@nongnu.org
X-Gm-Message-State: APuU4Z9+ACPk/JbG5guvctJbCI6NymZKIVOreY7Red6uYRFiiqkJ3o9+
 13qkiAVYA/as9Lfn9xjIZh5mhKv4WAhnjr1vwRNZbD4ZICADzfhDQjsA4TkY2s5FYvf/v298na4
 HssN5ovfL4F4TJufiVD8XW4YkJ6OuP2nl/F0z3/nv6B6rSxmwHRY5P5ZFwg==
X-Gm-Gg: AYBFou244pSiDVRJlMf8UMI2K22YOudVfFqxNqEQnEP8TZoeCEDQ9ZXtPoE8gkatdpO
 2VbIXN5nRZ+4OfBjAt/L6T5HN3o4EwZ+jqoyvTKmLX7bMCHy5EcNdh97LAC9X2iZ41xFaUljhe6
 m0wppE5+gA5Na61yImgOjlBZpcKY6ju+UDUUKqqOiu1yzm51keE+va40FGp2UVFdpsXHKYs/xMu
 J0chIf9Zc5Ok1V2oVgSiy5pb0Ol/jLqUvkMflHmZRPuQsKg4VRMW0GUzpKIpazbcMzHOSNxy3ru
 msAmvGk7CAJ5y0oss5WfV3y+dGbtkuwLejXvBLcJxPNzJnwM7Cv2rGEyajTVs+hBNpH9JXLQMpU
 swpakGhXNl25iTAS/K9zbzOyF/0nqL8Clv1IEBBLQIEtJPlGlRKq9i85amEQmSvDmNMVcZbF6FX
 RqSKGZ73e/8Vsq4stBRP6C8eSHZmdlEQ==
X-Received: by 2002:a05:6a00:1a92:b0:8a0:5dd9:7983 with SMTP id
 d2e1a72fcca58-8beb52e444fmr9095030b3a.12.1794794248380; 
 Sun, 15 Nov 2026 17:57:28 -0800 (PST)
X-Received: by 2002:a05:6a00:1a92:b0:8a0:5dd9:7983 with SMTP id
 d2e1a72fcca58-8beb52e444fmr9095014b3a.12.1794794247788; 
 Sun, 15 Nov 2026 17:57:27 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bececcca19sm2999452b3a.4.2026.11.15.17.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 17:57:27 -0800 (PST)
Message-ID: <2fa1fa40-2bc5-42f8-8b45-6a3ffb8f953b@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 18:57:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/48] hw: resolve QOM type conflicts in multi-target
 builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAwNyBTYWx0ZWRfX2y21V6O193oA
 qo8PILiqpaRI3okjz8N63QHMibyhjcWnk+XwVz9NI6g2CfhJnw3cFMNQV5CToBsAGHSWRKXJLs9
 ahzkeoxw/pUTOatdQxHhLGE8tFDZKXWzO35g4g7X/gk+IOefP3oHXivEmiUWrm5IgtnfSiDxHyd
 8B6hEitpbXFlTrGLA2xgxhnqieNsCvt1TF9kagF++c/waHlsBhExLhT9wYA0ypFUmRSTTUptSpr
 U6/22pkqrjDRNf3ir2qVG/7y6kn0DmQ1yYSVuQWH3X+97DMJyhT1wWCfjHb0b2gAjBPGumVJrJh
 eG7My+t7xuzM3RuszsFcJRqxBAs7r05aupjtN5ZJ9fN1in9EsY3RpJ+mzS7kyRQ+NIomNNj5thl
 FD870wjtd3bRTkdlpflm2IM1lY7ZdXbkbIbOVinFt5WF110k0976u4BDse/uWz/i2yFM2k+1I+l
 kNpggN3vbUQ3hX5tQXg==
X-Proofpoint-ORIG-GUID: 1kxMl6B5zSfL1JuI1gJf2iPzRHoUrk_h
X-Proofpoint-GUID: 1kxMl6B5zSfL1JuI1gJf2iPzRHoUrk_h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAwNyBTYWx0ZWRfX4do3h61auVqa
 RoPszBh+70WoSD1no55lX02vKYgREzJLwWLIgcH6KGIplN6gMyj6P2s5cdlKdiwbhtV3/H5s/fw
 Q2gs2cdCsr492B204U86CpUn1+9ttY8=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afa6309 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EbLiUymd3bQCAbbpmOgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 6:30 AM, Daniel P. Berrangé wrote:
> When building a multi-target binary, QOM types from multiple targets
> will be linked together. QOM types are required to have unique names
> when registered, so linking multiple targets in turn requires QOM type
> names to be unique across the QEMU codebase.
> 
> Global QOM type name uniqueness is a desirable property for QEMU
> regardless of multi-target work, so that QEMU presents a non-ambiguous
> object model to applications regardless of context.
> 
> In a multi-target binary, it is desirable to applications are able to
> introspect all types linked into QEMU, when launching with '-machine
> none'. Dynamic filtering of registered classes at runtime, to resolving
> QOM naming conflicts is undesirable, as it requires introspection
> to be repeated for each available target in order to discover the full
> set of available types in a binary.
> 
> Introspection is a fairly heavy weight process due to QEMU's vast size,
> so enabling introspection to be done once only for all targets will be a
> very significant benefit for management applications with a multi-target
> binary.
> 
> The glaring problem is that our historical design has led to multiple
> targets all providing a 'virt' machine type, which leads to multiple QOM
> types call 'virt-machine' which are all different.
> 
> Having a common short name "virt" is a useful characteristic for users,
> but this does not imply we need to use that as the basis for primary QOM
> typename. It is sufficient to have an alias called 'virt'.
> 
> In terms of implementation there are two core pieces
> 
>   * An 'Aliased' interface which can be implemented by QOM types which
>     want to support type aliases.
> 
>   * A 'TargetSpecific' interface which can be implemented by QOM types
>     which want to declare  they can only be used with a subset of targets.
> 
> With those foundational pieces
> 
>   * Machine implements Aliased and TargetSpecific
> 
>   * query-machines reports multiple aliases and declared supported
>     targets per machine for introspection
> 
>   * All the 'virt' machines are renamed to $target-virt, and aliases
>     added for the shorter 'virt' names to retain compatibility and
>     convenience when a target is selected
> 
>   * All the machines which have 'is_available' set now report their
>     targets via the TargetSpecific  interface
> 
>   * Creating machines validates declared targets from TargetSpecific
> 
> An apparent design mistake in TYPE_ACCEL_CPU is resolved which allows
> removal of the is_available hooks from target specific CPU impls, which
> were working around the bug.
> 
> The original proposed patches to unconditionally register some object
> properties is pulled in.
> 
> Overall this brings us closer to having a single unified object model
> across all targets, without having to make runtime variations of what
> is exposed/reported by a given QOM class name.
> 
> Daniel P. Berrangé (43):
>    iotests: better heuristics to find I/O tests build/source dirs
>    qom: define a TargetSpecific interface
>    qom: define an Aliased interface
>    hw: tweak approach to setting alias in machine macros
>    hw/core: implement TYPE_ALIASED interface in machines
>    qapi: report multiple aliases in MachineInfo
>    system: report multiple machine aliases in help output
>    system: increase space for machine name in '-machine help'
>    system: resolve multiple aliases when creating machines
>    qapi: deprecate 'alias' field in MachineInfo
>    hw/arm: convert machines to use AliasedClass interface
>    hw/avr: convert machines to use AliasedClass interface
>    hw/hexagon: convert machines to use AliasedClass interface
>    hw/i386: convert machines to use AliasedClass interface
>    hw/loongarch: convert machines to use AliasedClass interface
>    hw/m68k: convert machines to use AliasedClass interface
>    hw/ppc: convert machines to use AliasedClass interface
>    hw/s390x: convert machines to use AliasedClass interface
>    include/hw: convert machine docs to use AliasedClass interface
>    hw: drop 'alias' field from MachineClass
>    hw/arm: rename the 'virt' machines to 'arm-virt'
>    hw/riscv: rename the 'virt' machines to 'riscv-virt'
>    hw/hexagon: rename the 'virt' machine to 'hexagon-virt'
>    hw/loongarch: rename the 'virt' machine to 'loongarch-virt'
>    hw/m68k: rename the 'virt' machine to 'm68k-virt'
>    hw/or1k: rename the 'virt' machine to 'or1k-virt'
>    hw/xtensa: rename the 'virt' machine to 'xtensa-virt'
>    system: stop sorting machine names based on 'family'
>    system: put machine aliases in alphbetical order
>    system: filter machine type list if a target is selected
>    hw/core: filter machine type list if a target is selected
>    system: filter machines based on target during creation
>    hw/core: implement TYPE_TARGET_SPECIFIC for machine
>    qapi: report target compatibility for machine types
>    hw/arm: declare arm machine targets
>    hw/hexagon: declare hexagon machine target
>    hw/m68k: declare m68k machine target
>    hw/or1k: declare or1k machine target
>    hw/riscv: declare riscv machine target
>    accel: make TYPE_ACCEL_CPU name target independent
>    Revert "multi-target: restrict whpx-accel-*-cpu to matching target"
>    Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
>      targets"
>    qom: drop the 'is_available' callback from TypeInfo
> 
> Pierrick Bouvier (1):
>    Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
>      targets"
> 
> Yonggang Luo (4):
>    target-info: add target_mask_selected()
>    hw/pci: unconditionally expose the 'loadparm' property
>    hw/scsi: unconditionally expose the 'loadparm' property
>    hw/virtio/virtio-mem: unconditionally expose 'unplugged-inaccessible'
> 
>   accel/accel-common.c             |   3 +-
>   accel/whpx/whpx-common.c         |   8 --
>   docs/about/deprecated.rst        |   7 ++
>   hw/arm/aspeed_ast27x0-fc.c       |   5 +-
>   hw/arm/aspeed_ast27x0_evb.c      |  14 ++-
>   hw/arm/raspi.c                   |   9 +-
>   hw/arm/raspi4b.c                 |   6 +-
>   hw/arm/virt.c                    |  43 +++++++--
>   hw/arm/xlnx-versal-virt.c        |   7 +-
>   hw/avr/arduino.c                 |  30 +++++-
>   hw/core/machine-qmp-cmds.c       |  52 ++++++++++-
>   hw/core/machine.c                |   5 +
>   hw/hexagon/hexagon_dsp.c         |   7 +-
>   hw/hexagon/virt.c                |  11 ++-
>   hw/i386/pc_piix.c                |  25 ++++-
>   hw/i386/pc_q35.c                 |  20 +++-
>   hw/loongarch/virt.c              |  39 ++++++--
>   hw/m68k/virt.c                   |  46 +++++++---
>   hw/or1k/virt.c                   |  14 ++-
>   hw/pci/pci.c                     |  18 ++--
>   hw/ppc/pnv.c                     |   7 +-
>   hw/ppc/spapr.c                   |  31 ++++---
>   hw/riscv/virt.c                  |  14 ++-
>   hw/s390x/s390-virtio-ccw.c       |  24 +++--
>   hw/scsi/scsi-disk.c              |  18 ++--
>   hw/virtio/virtio-mem.c           |  12 +--
>   hw/xtensa/virt.c                 |   9 +-
>   include/accel/accel-cpu-target.h |   3 +-
>   include/accel/accel-cpu.h        |   2 +
>   include/hw/arm/virt.h            |   2 +-
>   include/hw/core/boards.h         |  29 ++++--
>   include/hw/hexagon/virt.h        |   2 +-
>   include/hw/i386/pc.h             |   5 +-
>   include/hw/loongarch/virt.h      |   2 +-
>   include/hw/riscv/virt.h          |   2 +-
>   include/qemu/target-info-init.h  |  15 ++-
>   include/qemu/target-info.h       |   9 ++
>   include/qom/object.h             |   3 -
>   include/qom/object_interfaces.h  | 152 +++++++++++++++++++++++++++++++
>   meson.build                      |   1 +
>   qapi/machine.json                |  19 +++-
>   qom/object.c                     |   4 -
>   qom/object_interfaces.c          |  88 ++++++++++++++++++
>   rust/qom/src/qom.rs              |   1 -
>   stubs/meson.build                |   1 +
>   stubs/target-mask-selected.c     |  13 +++
>   system/vl.c                      | 115 ++++++++++++-----------
>   target-info-def.c                |   3 +
>   target-info-qom.c                |  10 ++
>   target/riscv/kvm/kvm-cpu.c       |   2 -
>   target/riscv/tcg/tcg-cpu.c       |   1 -
>   tests/qemu-iotests/check         |  52 ++++++++---
>   52 files changed, 804 insertions(+), 216 deletions(-)
>   create mode 100644 stubs/target-mask-selected.c
> 

Hi Daniel,

thanks for taking a look at the whole problem, and sending this great 
series. I was busy for KVM Forum this week, and I'll be happy to take a 
look at it this week. Overall, it looks clean and the right thing to do.

By the way, I noticed one configuration is not building: oss-fuzz.

../tests/qtest/fuzz/qos_fuzz.c:49:62: error: too few arguments to 
function call, expected 5, have 3
    49 |     mach_info = qmp_query_machines(false, false, &error_abort);
       |                 ~~~~~~~~~~~~~~~~~~                           ^
./qapi/qapi-commands-machine.h:22:18: note: 'qmp_query_machines' 
declared here
    22 | MachineInfoList *qmp_query_machines(bool has_compat_props, bool 
compat_props, bool has_all_targets, bool all_targets, Error **errp);
       |

It's a very small nit issue, and not worth respinning for that right 
now, just mentioning it.

Regards,
Pierrick

