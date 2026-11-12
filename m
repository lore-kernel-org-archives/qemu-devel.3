Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CA60A2607
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FZcrevoG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZub9p7+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRWdr-0000pm-DW; Thu, 12 Nov 2026 10:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRWdf-0000m1-Ka
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:22:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRWdd-0006Ow-Me
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:22:59 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAmk0f2555491
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 15:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r1qLo52+nAB2LUL/gFmcFz3qgX1m6/KOX87W0RRx4PE=; b=FZcrevoG41MAnquK
 sN8avjbZxgm2VSgrbmrYv1JX20wteHeQsaOibA27Tp4sBmMCTSFyMA2ELhCBmciL
 rSe0d0QE6W3fPnMyLuCbsncLcAm+mK9YJ+81RxGUCRqQORBHCILhXBaj6r+dlb/b
 YFw2hjyQkndAyC5ly6C94Ludd0Y0oHYgQj/lx9T3JrsqWkAglFEWxoGXvaDj96hc
 c2gxllS3kXg7RlHy5i+vTrDuD6TwC5hW5kzD2u80tP/t6bkr3dt1qR32OtCdu+Ew
 /d7TL21QjanjkPc64LCvuZXJqSzed++sCYS/ag69otzGkui6l1U3oP0CHBklP8Y3
 wDaHew==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j0y91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 15:22:55 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990c957f129so743209241.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 07:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794496974; x=1795101774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r1qLo52+nAB2LUL/gFmcFz3qgX1m6/KOX87W0RRx4PE=;
 b=HZub9p7+sLyuO2NBu8t773RsSKhOfhnUizFa+TaT7DF25ld9mi0XvKiigo/d+SctBv
 PprKYYQU5A3an0FXqFw+Seco7i2fB658NSw8zvfxwNUEb+ssPDnhGlJ00bbP3plEktv/
 iX7xV41jl2N90odaP1iDmM60lH95WAD0vyry0PJUxEBRCZyWk1g4o0QXS0h4vtSAGV+u
 w65TojMx2fa7m9UgNB+sU3ysAH7yKvkFvbgIB2sMFI7TPsZCW8pdo2fJUAfC5AVgmysM
 k8yB/ulMW7V1oyi3zyaoiwv2WWLrbHT/pasrB3YH0npxYPiCIiT2Q+5CuyNzzyHs7SSD
 xmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794496974; x=1795101774;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1qLo52+nAB2LUL/gFmcFz3qgX1m6/KOX87W0RRx4PE=;
 b=kSgUx2KZ6bLjxOwjNOkfrnUb3USFdPU01PrQnF6+KUA8MYlYYhC4QlNAQVR/S3ehjr
 1NXpSYlotLzE00D8VYDiuGyXYbZ1rTUjHZOvrW+t09E58cktjlXeaVI5XA25iXOFDcuI
 6mqHvXKeLcXMQP43OqOJove08hszSNhtqN28Er6CsxhfwOGY5TFbIPMr5fJuhCZ8a9YM
 EeGPKzwAkuNPaHG9rtY2Pq+Vg20XiV6S+D7PoasnLj0xBfKBtU1hhPJGyo9p1FyzN48k
 TWzDLecBFGyRsen2jyPBIiTgGiql6ug7V2MKsnC7ZPQQATS1rnEhyLFKCppTMLqVP0tQ
 5f8g==
X-Gm-Message-State: APuU4Z8Om2UtITli/Lwc/1uhaxzQlU+A6Pn9BjnyUUg1IqiPtpZWMv6L
 3WIoF6AdaUfm/SOJbGPoQD/pxFtZ8tsOnhRhOugegsCsquRUDVls/BLpALVOTubjnCKddqNqn8I
 vd41vq1vEFO6Kwn1rmKa7k6ul3mYtZrg/PWaAjHcxHMrVTvWRR7255K3WtbQATjpy9ebI
X-Gm-Gg: AYBFou00dm90WhhQJ42Zi4DncNwq2ZkPhu49M47irfsWKvxd3Xjv12QnTx6DBfBmKEU
 DMd+Cdu8yFjELl/wxQwYe6ijwi8Y5gVCvWzNxX97qh0+uV77xN/M6CaVLLmIlPGNOjBNPQ5i7x0
 Ba7u060T0JGAE9FpI5JoYzvTmyalEJhdYAROZebxji9AGUuQatoHakJHO7uFkswJDd8bsQXwSEW
 0TADbSjQUF3qf/JvMIv3LEFJC5zyKQFyKYViJD3eP7i3nCbkxfuAnV7Mnz3gx8ALLeVnwmW6OWu
 guxF4gSMcjWYgitDbz6fjw5L9+yQgD1GXCTnBY2ikIOPnZWuwkhRRS7YXCs4vroAKFwL5/aoQo3
 HAXdxI9L8lRnzshhR5GgxxuE9nvHsbdH/xSqDIKciLWVmnpqF4NnRAcgV443JxzfiknpK3DE=
X-Received: by 2002:a05:6102:50a8:b0:7af:efe6:2bbe with SMTP id
 ada2fe7eead31-7d631783cc6mr827281137.16.1794496974514; 
 Thu, 12 Nov 2026 07:22:54 -0800 (PST)
X-Received: by 2002:a05:6102:50a8:b0:7af:efe6:2bbe with SMTP id
 ada2fe7eead31-7d631783cc6mr827247137.16.1794496973650; 
 Thu, 12 Nov 2026 07:22:53 -0800 (PST)
Received: from [10.111.135.37] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba095200c4sm61661245e9.2.2026.11.12.07.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 07:22:51 -0800 (PST)
Message-ID: <4303752a-64ba-49a6-826b-ddaa89f6579b@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 16:22:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-12.0 8/8] linux-user/aarch64: Unify both byte orders
 under qemu-aarch64
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
 <20261112140343.61634-9-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112140343.61634-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MSBTYWx0ZWRfX2dHp/AwcKsBz
 lYH05y4ef+ZYbQ6DefLwVHSYL0tZjFuhB92brwtnrHp6ie7ctWoEzYPvDpjIcy7cCPG3swsDDA7
 ojmpgOjJNyb0IJN2+SLFL4psIksTngY=
X-Proofpoint-ORIG-GUID: HzsPUnK7cECsDv9nYM08cFKK0G1lUCZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MSBTYWx0ZWRfXw1UByEnYqIpE
 SIH7/ysJ92Zn0mINmO3QjdrY7QzHnCZunNFgrEivGhgD5IIal9fhGIVdkPIS/F19nrpYrr084JZ
 P3kx7NwU65jFcRt3KUhmso1CjsbWJ1QIJyBoUkqYeababvA83YagZBwFzseM3yochnRrAnZqufB
 SosAJAapIG3UiKGSzMddxceNaetyWuWjjvRn4vK/3e3hvgF+NuvP8nslzDpbubaiMx2YhNys5S6
 Hp23gUdtW8KAwFItf/DFqp3NzRhf40p509Q3yg68TWQuL8JZNew1BsGWmhqAc9AF+lDSgccaE6a
 77pdbguQmF+LVbnxAdsYVKfaHYmW52d9j5iN35GhyiFuEIyatTN0KkpNUsuKT0y2DsXdppXPqSS
 5KBJ+oHQQ+azYlpmcDHViVf2ihK4WkP7waWXWdE8RtORmet4aVPe+KhL41+vWwEjDvI676MGByN
 UuL6X9tmbI8Zx6ILCYA==
X-Proofpoint-GUID: HzsPUnK7cECsDv9nYM08cFKK0G1lUCZe
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af5d9cf cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xOLU9PFIos2kz-kKafUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12 15:03, Philippe Mathieu-Daudé wrote:
> Enable runtime byte-order selection for aarch64-linux-user
> and retain qemu-aarch64_be as a compatibility symlink.
> Deprecate the symlink since 12.0 and recommend qemu-aarch64
> for both ELF byte orders.
> Remove the separate aarch64_be-linux-user build target and
> obsolete CI exclusions.
> 
> Run the existing big-endian hello test through qemu-aarch64
> while retaining its big-endian fixture toolchain. Document
> that executable name compatibility does not preserve the
> removed target-list spelling.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   docs/about/deprecated.rst                 | 13 +++++++++++++
>   docs/user/main.rst                        |  7 +++++++
>   configs/targets/aarch64-linux-user.mak    |  2 ++
>   configs/targets/aarch64_be-linux-user.mak | 10 ----------
>   .gitlab-ci.d/buildtest.yml                |  2 +-
>   .gitlab-ci.d/crossbuild-template.yml      |  4 ++--
>   tests/tcg/aarch64_be/meson.build          |  4 ++--
>   7 files changed, 27 insertions(+), 15 deletions(-)
>   delete mode 100644 configs/targets/aarch64_be-linux-user.mak
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0891bbc44ded..20eb4268f640 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -438,6 +438,19 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
>   only with ``-cpu max`` (which does not guarantee migration compatibility
>   across versions).
>   
> +linux-user mode executables
> +---------------------------
> +
> +.. _deprecated-qemu-aarch64-be:
> +
> +``qemu-aarch64_be`` executable name (since 12.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``qemu-aarch64_be`` compatibility symlink is deprecated.
> +Use ``qemu-aarch64`` instead for both little- and big-endian
> +Linux ELF executables. The emulator selects the byte order from
> +the ELF header, regardless of the executable name used to invoke it.
> +
>   linux-user mode CPUs
>   --------------------
>   
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index a8ddf9142495..9dcea8dac4d0 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -65,6 +65,13 @@ emulator.
>   Linux User space emulator
>   -------------------------
>   
> +For AArch64, ``qemu-aarch64`` runs both little- and big-endian Linux ELF
> +executables, selecting the byte order from the ELF header. ``qemu-aarch64_be``
> +is a :ref:`deprecated compatibility symlink <deprecated-qemu-aarch64-be>`
> +to the same emulator; its name does not override the ELF byte order.
> +Build both names with ``--target-list=aarch64-linux-user``; the separate
> +``aarch64_be-linux-user`` build target is no longer supported.
> +

Squashing:

-- >8 --
diff --git a/configure b/configure
index af14a9c23e..821a887a31 100755
--- a/configure
+++ b/configure
@@ -1107,7 +1107,14 @@ else
              *" $target "*)
                  ;;
              *)
-                error_exit "Unknown target name '$target'"
+                case "$target" in
+                    aarch64_be-linux-user)
+                        error_exit "Target '$target' is no longer 
supported; use 'aarch64-linux-user' instead"
+                        ;;
+                    *)
+                        error_exit "Unknown target name '$target'"
+                        ;;
+                esac
                  ;;
          esac
      done
---

