Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0CCCFB44F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxry3-0005ir-VZ; Mon, 07 Oct 2024 13:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxry1-0005id-Sv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:56:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sxrxx-0001Mf-Rx
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:56:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EbqhY015152;
 Mon, 7 Oct 2024 17:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TlRcZe0CO52qOP0aWNQd31hDxSjITrldtkPTii9+nI=; b=EK9Yzw/uSju4T+0G
 amplZpLYGD4wtJwsD+PhahyVh8/30dg+Oqniluyl+b8KYZvUYmAksPj4iC8VtmaG
 GBVNTLlekESJgeeqZyevhIuTxTgye/43sNEiWsn+hJa75aTyjhdlmmvI3TT/d5Rg
 NKUK2/KYh3ZPUsOcgNeJDDS+OqWx9vWm26ssnWy+LJGpR2d1YkwUYbajYTOwsXLm
 bqEQqpoqTM2hqLFNzr85kssfWDQUsZFvB+KhP5MCOiGJvzoAJ1gTLIgjgPWgRtWv
 wG6+7Ki7ab+vzManAAi4YvmwULdXf+Az5aAyIdtOSUe46F7bUS2QLwbE+VFI+q8Y
 3wo8/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs74xn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 17:56:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497HuBFR025069
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 7 Oct 2024 17:56:11 GMT
Received: from [10.111.168.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 10:56:10 -0700
Message-ID: <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
Date: Mon, 7 Oct 2024 12:56:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
CC: <manos.pitsidianakis@linaro.org>, <zhao1.liu@intel.com>,
 <junjie.mao@intel.com>, <pierrick.bouvier@linaro.org>,
 <alex.bennee@linaro.org>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: UoDoAeo32V9Amx7iSHqdqTM2JgK_-au4
X-Proofpoint-GUID: UoDoAeo32V9Amx7iSHqdqTM2JgK_-au4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/7/2024 6:03 AM, Paolo Bonzini wrote:
> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to dec4b629fc17fedcd2172066071f99ec8dcc8d8d:
>
>    meson: ensure -mcx16 is passed when detecting ATOMIC128 (2024-10-07 13:01:06 +0200)
>
> ----------------------------------------------------------------
> * first commit for Rust support

Aside: Paolo, thanks for your work here!  So far I think the focus for 
Rust support has been on device models.  But is there any interest in 
being able to write TCG plugins in Rust?


This project https://github.com/novafacing/qemu-rs seems to explore this 
space - maybe it would be good to incorporate something like this inside 
of QEMU?

> * fix detection of ATOMIC128 on x86_64
>
> ----------------------------------------------------------------
> Manos Pitsidianakis (7):
>        build-sys: Add rust feature option
>        rust: add bindgen step as a meson dependency
>        .gitattributes: add Rust diff and merge attributes
>        meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
>        rust: add crate to expose bindings and interfaces
>        rust: add utility procedural macro crate
>        rust: add PL011 device model
>
> Paolo Bonzini (4):
>        Require meson version 1.5.0
>        configure, meson: detect Rust toolchain
>        meson: define qemu_isa_flags
>        meson: ensure -mcx16 is passed when detecting ATOMIC128
>
> Pierrick Bouvier (1):
>        meson: fix machine option for x86_version
>
>   MAINTAINERS                                        |  21 +
>   configure                                          | 170 +++++-
>   meson.build                                        | 158 +++++-
>   rust/wrapper.h                                     |  47 ++
>   .gitattributes                                     |   3 +
>   Kconfig                                            |   1 +
>   Kconfig.host                                       |   3 +
>   hw/arm/Kconfig                                     |  30 +-
>   meson_options.txt                                  |   3 +
>   python/scripts/vendor.py                           |   4 +-
>   python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0 bytes
>   python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846 bytes
>   pythondeps.toml                                    |   2 +-
>   rust/.gitignore                                    |   3 +
>   rust/Kconfig                                       |   1 +
>   rust/hw/Kconfig                                    |   2 +
>   rust/hw/char/Kconfig                               |   3 +
>   rust/hw/char/meson.build                           |   1 +
>   rust/hw/char/pl011/.gitignore                      |   2 +
>   rust/hw/char/pl011/Cargo.lock                      | 134 +++++
>   rust/hw/char/pl011/Cargo.toml                      |  26 +
>   rust/hw/char/pl011/README.md                       |  31 ++
>   rust/hw/char/pl011/meson.build                     |  26 +
>   rust/hw/char/pl011/src/device.rs                   | 599 +++++++++++++++++++++
>   rust/hw/char/pl011/src/device_class.rs             |  70 +++
>   rust/hw/char/pl011/src/lib.rs                      | 586 ++++++++++++++++++++
>   rust/hw/char/pl011/src/memory_ops.rs               |  59 ++
>   rust/hw/meson.build                                |   1 +
>   rust/meson.build                                   |   4 +
>   rust/qemu-api-macros/Cargo.lock                    |  47 ++
>   rust/qemu-api-macros/Cargo.toml                    |  25 +
>   rust/qemu-api-macros/README.md                     |   1 +
>   rust/qemu-api-macros/meson.build                   |  25 +
>   rust/qemu-api-macros/src/lib.rs                    |  43 ++
>   rust/qemu-api/.gitignore                           |   2 +
>   rust/qemu-api/Cargo.lock                           |   7 +
>   rust/qemu-api/Cargo.toml                           |  26 +
>   rust/qemu-api/README.md                            |  17 +
>   rust/qemu-api/build.rs                             |  14 +
>   rust/qemu-api/meson.build                          |  24 +
>   rust/qemu-api/src/definitions.rs                   |  97 ++++
>   rust/qemu-api/src/device_class.rs                  | 128 +++++
>   rust/qemu-api/src/lib.rs                           | 166 ++++++
>   rust/qemu-api/src/tests.rs                         |  49 ++
>   rust/rustfmt.toml                                  |   7 +
>   scripts/archive-source.sh                          |   6 +-
>   scripts/make-release                               |   5 +-
>   scripts/meson-buildoptions.sh                      |   3 +
>   scripts/rust/rust_root_crate.sh                    |  13 +
>   scripts/rust/rustc_args.py                         |  84 +++
>   subprojects/.gitignore                             |  11 +
>   subprojects/arbitrary-int-1-rs.wrap                |   7 +
>   subprojects/bilge-0.2-rs.wrap                      |   7 +
>   subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
>   subprojects/either-1-rs.wrap                       |   7 +
>   subprojects/itertools-0.11-rs.wrap                 |   7 +
>   .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
>   subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
>   .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
>   subprojects/packagefiles/either-1-rs/meson.build   |  24 +
>   .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
>   .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
>   .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
>   .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
>   subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
>   subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
>   .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
>   subprojects/proc-macro-error-1-rs.wrap             |   7 +
>   subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
>   subprojects/proc-macro2-1-rs.wrap                  |   7 +
>   subprojects/quote-1-rs.wrap                        |   7 +
>   subprojects/syn-2-rs.wrap                          |   7 +
>   subprojects/unicode-ident-1-rs.wrap                |   7 +
>   subprojects/unicode-ident-1-rs/meson.build         |  20 +
>   tests/lcitool/mappings.yml                         |   2 +-
>   75 files changed, 3194 insertions(+), 34 deletions(-)
>   create mode 100644 rust/wrapper.h
>   delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
>   create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
>   create mode 100644 rust/.gitignore
>   create mode 100644 rust/Kconfig
>   create mode 100644 rust/hw/Kconfig
>   create mode 100644 rust/hw/char/Kconfig
>   create mode 100644 rust/hw/char/meson.build
>   create mode 100644 rust/hw/char/pl011/.gitignore
>   create mode 100644 rust/hw/char/pl011/Cargo.lock
>   create mode 100644 rust/hw/char/pl011/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/README.md
>   create mode 100644 rust/hw/char/pl011/meson.build
>   create mode 100644 rust/hw/char/pl011/src/device.rs
>   create mode 100644 rust/hw/char/pl011/src/device_class.rs
>   create mode 100644 rust/hw/char/pl011/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>   create mode 100644 rust/hw/meson.build
>   create mode 100644 rust/meson.build
>   create mode 100644 rust/qemu-api-macros/Cargo.lock
>   create mode 100644 rust/qemu-api-macros/Cargo.toml
>   create mode 100644 rust/qemu-api-macros/README.md
>   create mode 100644 rust/qemu-api-macros/meson.build
>   create mode 100644 rust/qemu-api-macros/src/lib.rs
>   create mode 100644 rust/qemu-api/.gitignore
>   create mode 100644 rust/qemu-api/Cargo.lock
>   create mode 100644 rust/qemu-api/Cargo.toml
>   create mode 100644 rust/qemu-api/README.md
>   create mode 100644 rust/qemu-api/build.rs
>   create mode 100644 rust/qemu-api/meson.build
>   create mode 100644 rust/qemu-api/src/definitions.rs
>   create mode 100644 rust/qemu-api/src/device_class.rs
>   create mode 100644 rust/qemu-api/src/lib.rs
>   create mode 100644 rust/qemu-api/src/tests.rs
>   create mode 100644 rust/rustfmt.toml
>   create mode 100755 scripts/rust/rust_root_crate.sh
>   create mode 100644 scripts/rust/rustc_args.py
>   create mode 100644 subprojects/arbitrary-int-1-rs.wrap
>   create mode 100644 subprojects/bilge-0.2-rs.wrap
>   create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
>   create mode 100644 subprojects/either-1-rs.wrap
>   create mode 100644 subprojects/itertools-0.11-rs.wrap
>   create mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
>   create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
>   create mode 100644 subprojects/packagefiles/either-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
>   create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
>   create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
>   create mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build
>   create mode 100644 subprojects/proc-macro-error-1-rs.wrap
>   create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
>   create mode 100644 subprojects/proc-macro2-1-rs.wrap
>   create mode 100644 subprojects/quote-1-rs.wrap
>   create mode 100644 subprojects/syn-2-rs.wrap
>   create mode 100644 subprojects/unicode-ident-1-rs.wrap
>   create mode 100644 subprojects/unicode-ident-1-rs/meson.build

