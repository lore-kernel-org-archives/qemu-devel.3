Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9B2EF5862
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvhU-0003Ym-5L; Tue, 24 Feb 2026 11:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vuvhR-0003WV-EF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:55:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vuvhP-0003xw-2p
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:55:53 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OAFW1o2006522
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 16:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NEPn+wDF01mUFIQGB6xn1q3m1bV42mvYKIOBN1bkve0=; b=asZR/9iWBO2m7ddJ
 h5/F0HudAyLIRY/I/Q1/VKHWVhx9a8F5oK3UbJj1NFjyOVnkUCpMNnNUVj30ucsC
 ySfSFeCFeQEudqeROQChCZYa/ltYusKUARQDUlS5YkT1w7UR5qNA7Ct03BE92tnb
 kGTrX6fpV7AbU6lC/KO1Gjzul9stlL9v4sf6nhP5XFIYUS22Ow39WZnfe6fSQzMz
 lq9ht+gMVLKuyuBK0w265x6Xe4E9Wmikf+194NGib4uwa8x5qsLdcE6f8znrxDKy
 34e/gjCoi5KP/VwBmV3psYsl1jVuJu/sPlH1pWn943f5rbrOob/MNgoPyRHldwxu
 e1nQ6A==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch456a9w0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 16:55:46 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64c98481d1eso2707455d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952146; cv=none;
 d=google.com; s=arc-20240605;
 b=euh5qwpJj7RriDqULqY6wSNv5HEaXakem3TLy6ZfG1sxx6rNt0Jvon5awnzDemqE+3
 VsJG/b9qjOedyzcbJ9Gd3na7VwYzuXXYwwYrAe55p6OyRiGatQc5r8LOPEXEQuJH1hTt
 8DEP35/qX8LXB7U//CB73ST/l5kkpweO/osP7TlmPoRRs/oFNFNg0Kea8odvtkG676ai
 +nVlNDmTFZb1q3oN+kGlcWSJz4HiIOFEsp8kEQj8yzbcnasru6eEp/jtHn2qaoZBIpb7
 gLdMAu2C2Vtx5/slDcAM3N7CyMpo+nrx/9loQpZ7CS2VI//F5pm+MbL1kHpUTPX/ayT7
 cTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NEPn+wDF01mUFIQGB6xn1q3m1bV42mvYKIOBN1bkve0=;
 fh=krIEA+xDwFQaR3gc6xzKeRwd19HxWDxvyJahVPml2KU=;
 b=bejI4fxh2N6ejVisToPgT2ZdF2PhoWRrInkNXMlW7U08qb6GBruern27nhT5xWKI+R
 ZuUgURpA1YNzWtFM4QF81E1EbjDRnmj6sFFXwwT9mC0ytP9juf+hCLO5p09s7ezmz3hs
 Txlo2ABHOrnKL85FfFfK7DLv2f9sJr8pB7RYBGVjSuj9FDAyZQqKaBgT8tQq4Vd/spEH
 CCeV9fcibBs3gJ03bGL0mAw4/BaAcwalPnc1nCc6TgbKUNMVDv9lnctdRTvF9PBZNek4
 zmTPwIeyQw3udhxTuUfZm//H1UmKX7WIwSjrY1yhsqNif0uvCo7Kcu3Tt9YlA7ieGN3C
 G6Fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771952146; x=1772556946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEPn+wDF01mUFIQGB6xn1q3m1bV42mvYKIOBN1bkve0=;
 b=WW8CVBQGaLBEm+i86906gz842RWhM8rQZEYKcay54vHP6h4Q1wGA9rhn6HBQZTVhUv
 YAIztsTpFQJUYgNI1ftFSsLVLORzhSkMuxF85Cd9PyYVIAiU6YL6s+Y+OLc9a9gvI/wW
 1FvQ9XYJ+yp4NadPpGYBsFhAVFOhONU8E0l5LIMYpkRIkpfKRr2eR5ny0/wtInNDpOuB
 u8jBIWEKnZpeZ73Lwuomf0XeQc4iLhgaL2alezZdhtlf7Bg/t38TsRkZ1mwqBjjenztI
 8S58HXKphnhbvRcjVos37rRLPAO/CRaqH5jLguPOMhjiVhYYpnzYF0rDL77VBX/sia1G
 UE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952146; x=1772556946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEPn+wDF01mUFIQGB6xn1q3m1bV42mvYKIOBN1bkve0=;
 b=PhhlyQTz7kXJnChCN848YEiS1pf8/pZ9YjYbBt/3+WG7b9NNZ6Szp5GlhNXZs2Qd5e
 ShyISQm3S5OiG+cm10Q6A1/cdOaQERD3RpiZndkgyTiK0sWvrLWBSMb0rAOiXlaTdDQ1
 SIdruEN6jz9IQnvDolbrAHIxLDDT99Ua1+nfENIhKYfmj/cG2haTeCpsPbrz8vH1MLC/
 /ypVUjaASUHL4j5rwcitTPVzts0/CDWVLxwBtsaQh8SDBhbpqmmr4D/r0jl73hKIN2Q/
 RBJjlh1qe3YZDcPVoWBdk2qrOTWFfV7H8L5QzefgnMJSYHcWtoKxExXIOtOiGng4t3Gy
 uJgg==
X-Gm-Message-State: AOJu0Yw5hkkTzQd67duQBBDhhQyzpQUY/DFmrkSbccymwYquU4iviwII
 xXHGQaIUlhy9AsULXB++k1VlyXVeO8cosd//sQUZuKKZ9FR2Z8HxL5dM4okgpFr405hVsPbcLcJ
 983KOBxri6GY+IILlXFs6C9KvutqnJAPIU8ta9WjQY1gYxZk7qbR+bZRmuK6sk+XbJ0hrSuYNgz
 JOWQGbqYX2+nSro7wHJVJhMUkVHPbEkNDI/x7P6ywA
X-Gm-Gg: ATEYQzyMEsEqBuj1a4AHMeumk5If/8dbI6r1a9sCv4GVRotwd7rK7sgwHNFGLSlw9CE
 m/EGY2Q8JD8dskPlL3os4LPjqcJZiOK9y5bsdjEmXm0lQkWRDhMXtFN9sUlxF9ErI0LnaKyqZ1l
 HU6xgTRs4b5M4nwd7sShSHDtp/jRjmKs4vC2dWu+ELIJFk0gUYiWBPdqqBwXSJd5X7nj3NOcM9M
 sRZ2ooL
X-Received: by 2002:a53:ec04:0:b0:64a:d0cd:bd11 with SMTP id
 956f58d0204a3-64c78f66194mr8006292d50.80.1771952146175; 
 Tue, 24 Feb 2026 08:55:46 -0800 (PST)
X-Received: by 2002:a53:ec04:0:b0:64a:d0cd:bd11 with SMTP id
 956f58d0204a3-64c78f66194mr8006255d50.80.1771952145361; Tue, 24 Feb 2026
 08:55:45 -0800 (PST)
MIME-Version: 1.0
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
In-Reply-To: <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:55:29 -0600
X-Gm-Features: AaiRm53IZPc2mZsvvA621Q9llWBlpXxZi4vPQCPHCRD6d9N2KoRcSpKxNjLjACs
Message-ID: <CAEqNhNYVhKGzUsr2XWiav5VoPiM+iOP3V98AbSCtXm2W=rAvKQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Mttj1xiFHMSaPDyM2TrvP3b_qJR3VSAe
X-Proofpoint-ORIG-GUID: Mttj1xiFHMSaPDyM2TrvP3b_qJR3VSAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0MCBTYWx0ZWRfX9p/6dbIs+2PM
 j5OMvc3rXJwKlWlQeQLoIa8cAcbsTvAExSjd8wGhJJg9CeHUZynONEV29o0iItgQpYmoGdJgn7m
 jIJDcYrWCnjJBdcFtHjGBxeceLzdT/ytCuM72p90WIRxppgaxSi/viu723NDu2kqK0uXUYFzmAB
 BUyHq1vb8+MFVXM0geERTPGfjXCPb/T0k2VmlF/4hmSAkIV9PmC+ak7yp1a2FHZiwqTcEtfLhiB
 sYpOvxhDaXGrDOCVS96ny/LP6lcn3mnz64XhoVe/wrk9AZR7GpWjxvBAWno/qm/MzOaKjzb/UUg
 tYmNsNPsaReCluTb+MfNz2msqWlluNkIQlFxGM1bXmnNBKXcrh3P3ChzSItSO00Nprt+mTD4jeL
 Nuu5cjPBgodRKZXI5m7KGAZ6GUVIMxqUTp/DNT109TtK6b4vblyNFfVsgF8u8dSb0U/ugAiqLEY
 Y41hNI4CNt5HUSWA+Bw==
X-Authority-Analysis: v=2.4 cv=J8enLQnS c=1 sm=1 tr=0 ts=699dd813 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=VxNz4sPly1W9MLrQJcMA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 10:01=E2=80=AFAM Florian Hofhammer
<florian.hofhammer@epfl.ch> wrote:
>
> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the architecture-specific Makefiles
> require setting specific compiler and linker flags in some cases.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---

for hexagon:

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  tests/tcg/arm/Makefile.target                 |  6 +++++
>  tests/tcg/hexagon/Makefile.target             |  7 +++++
>  tests/tcg/mips/Makefile.target                |  6 ++++-
>  tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>  tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>  tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>  tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>  .../{ =3D> plugin}/check-plugin-output.sh       |  0
>  .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>  .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>  tests/tcg/plugins/syscall.c                   |  6 +++++
>  tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>  12 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/mips64/Makefile.target
>  create mode 100644 tests/tcg/mips64el/Makefile.target
>  create mode 100644 tests/tcg/mipsel/Makefile.target
>  rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%)
>  rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (100%=
)
>  create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.=
c
>  create mode 100644 tests/tcg/sparc64/Makefile.target
>
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.targe=
t
> index 6189d7a0e2..0d8be9cd80 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
>
>  ARM_TESTS +=3D sha512-vector
>
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require emitting arm32 instructions, otherwise the vCPU might accident=
ally
> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_=
pc()
> +test-plugin-skip-syscalls: CFLAGS+=3D-marm
> +endif
> +
>  TESTS +=3D $(ARM_TESTS)
> diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefi=
le.target
> index f86f02bb31..111dc405fa 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -126,3 +126,10 @@ v73_scalar: CFLAGS +=3D -Wno-unused-function
>
>  hvx_histogram: hvx_histogram.c hvx_histogram_row.S
>         $(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# hexagon uses clang/lld which does not support -Ttext-segment but GNU l=
d does
> +# not generally support --image-base. Therefore, the multiarch Makefile =
uses
> +# the GNU ld flag and we special-case here for hexagon.
> +override LDFLAG_TEXT_BASE =3D -Wl,--image-base=3D0x40000
> +endif
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.tar=
get
> index 5d17c1706e..d08138f17b 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -9,11 +9,15 @@ MIPS_SRC=3D$(SRC_PATH)/tests/tcg/mips
>  VPATH          +=3D $(MIPS_SRC)
>
>  # hello-mips is 32 bit only
> -ifeq ($(findstring 64,$(TARGET_NAME)),)
>  MIPS_TESTS=3Dhello-mips
>
>  TESTS +=3D $(MIPS_TESTS)
>
>  hello-mips: CFLAGS+=3D-mno-abicalls -fno-PIC -fno-stack-protector -mabi=
=3D32
>  hello-mips: LDFLAGS+=3D-nostdlib
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbac=
ks
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +       $(call skip-test, $<, "qemu-mips does not execute invalid syscall=
s")
>  endif
> diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile=
.target
> new file mode 100644
> index 0000000000..5386855efc
> --- /dev/null
> +++ b/tests/tcg/mips64/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS64 - included from tests/tcg/Makefile.target
> +#
> +
> +MIPS64_SRC=3D$(SRC_PATH)/tests/tcg/mips64
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPS64_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require no ABI calls to avoid $t9-relative .got address calculation on=
 MIPS64
> +test-plugin-skip-syscalls: CFLAGS+=3D-mno-abicalls -fno-pie
> +test-plugin-skip-syscalls: LDFLAGS+=3D-no-pie
> +endif
> diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Make=
file.target
> new file mode 100644
> index 0000000000..77ac8815fe
> --- /dev/null
> +++ b/tests/tcg/mips64el/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS64EL - included from tests/tcg/Makefile.target
> +#
> +
> +MIPS64EL_SRC=3D$(SRC_PATH)/tests/tcg/mips64el
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPS64EL_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require no ABI calls to avoid $t9-relative .got address calculation on=
 MIPS64
> +test-plugin-skip-syscalls: CFLAGS+=3D-mno-abicalls -fno-pie
> +test-plugin-skip-syscalls: LDFLAGS+=3D-no-pie
> +endif
> diff --git a/tests/tcg/mipsel/Makefile.target b/tests/tcg/mipsel/Makefile=
.target
> new file mode 100644
> index 0000000000..bf1bdb56b3
> --- /dev/null
> +++ b/tests/tcg/mipsel/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPSEL - included from tests/tcg/Makefile.target
> +#
> +
> +MIPSEL_SRC=3D$(SRC_PATH)/tests/tcg/mipsel
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPSEL_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbac=
ks
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +       $(call skip-test, $<, "qemu-mipsel does not execute invalid sysca=
lls")
> +endif
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 07d0b27bdd..2e2dcda425 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
>  VPATH         +=3D $(MULTIARCH_SRC)/linux
>  MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
>  endif
> +ifeq ($(CONFIG_PLUGIN),y)
> +VPATH         +=3D $(MULTIARCH_SRC)/plugin
> +MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
> +endif
>  MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)
>
>  #
> @@ -200,13 +204,27 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>         CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> -       $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> +       $(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>         $(QEMU) $<
>  run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>
>  EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-libme=
m.so \
>                           run-plugin-test-plugin-syscall-filter-with-libs=
yscall.so
> -else
> +
> +# Test plugin control flow redirection by skipping system calls
> +# (similar functionality to syscall filter but different mechanism)
> +LDFLAG_TEXT_BASE =3D -Wl,-Ttext-segment=3D0x40000
> +test-plugin-skip-syscalls: LDFLAGS +=3D $(LDFLAG_TEXT_BASE)
> +test-plugin-skip-syscalls: LDFLAGS +=3D -Wl,--section-start,.redirect=3D=
0x20000
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +
> +EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-skip-syscalls-with-li=
bsyscall.so
> +
> +else # CONFIG_PLUGIN=3Dn
> +# Do not build the syscall skipping test if it's not tested with a plugi=
n
> +# because it will simply return an error and fail the test.
> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-skip-syscalls, $(MULTIARCH=
_TESTS))
> +
>  # test-plugin-syscall-filter needs syscall plugin to succeed
>  test-plugin-syscall-filter: CFLAGS+=3D-DSKIP
>  endif
> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multi=
arch/plugin/check-plugin-output.sh
> similarity index 100%
> rename from tests/tcg/multiarch/check-plugin-output.sh
> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/mul=
tiarch/plugin/test-plugin-mem-access.c
> similarity index 100%
> rename from tests/tcg/multiarch/test-plugin-mem-access.c
> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
> diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/tes=
ts/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> new file mode 100644
> index 0000000000..1f5cbc3851
> --- /dev/null
> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute an invalid syscall. The syscall test pl=
ugin
> + * should intercept this.
> + */
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +void exit_success(void) __attribute__((section(".redirect"), noinline,
> +                                       noreturn, used));
> +
> +void exit_success(void) {
> +    _exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char *argv[]) {
> +    long ret =3D syscall(0xc0deUL);
> +    if (ret !=3D 0L) {
> +        perror("");
> +    }
> +    /* We should never get here */
> +    return EXIT_FAILURE;
> +}
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f83087..b68e3cadf4 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsign=
ed int vcpu_index,
>              fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n=
", a2);
>          }
>      }
> +
> +    if (num =3D=3D 0xc0deUL) {
> +        /* Special syscall to test the control flow redirection function=
ality. */
> +        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n"=
);
> +        qemu_plugin_set_pc(0x20000);
> +    }
>  }
>
>  static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
> diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefi=
le.target
> new file mode 100644
> index 0000000000..516927a3fc
> --- /dev/null
> +++ b/tests/tcg/sparc64/Makefile.target
> @@ -0,0 +1,16 @@
> +# -*- Mode: makefile -*-
> +#
> +# Sparc64 - included from tests/tcg/Makefile.target
> +#
> +
> +SPARC64_SRC=3D$(SRC_PATH)/tests/tcg/sparc64
> +
> +# Set search path for all sources
> +VPATH +=3D $(SPARC64_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# The defined addresses for the binary are not aligned correctly for spa=
rc64
> +# but adjusting them breaks other architectures, so just skip it on spar=
c64.
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +       $(call skip-test, $<, "qemu-sparc64 does not allow mapping at our=
 given fixed address")
> +endif
> --
> 2.53.0
>

