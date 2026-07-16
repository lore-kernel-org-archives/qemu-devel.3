Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC9DC43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 04:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkDjt-0007Y9-2i; Thu, 16 Jul 2026 00:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkDjq-0007Rq-GR
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 00:30:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkDjn-00062P-Qg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 00:30:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wYpl1445206
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nffzmb4f0lNlevQ2+HoJd4K+Y5mqSRVv51+8YLqUd9I=; b=KzSealll/bgahPVX
 Jnf8IC9uNgfompnjyY9xdZXHZrejQZKvbeAeIv+sfsP9A+goDgKxIAFEB3pW8HJM
 zV5av8Yw5uaAZA9cbrxABVitoWy/54L7EHByEP14gy//3vgx2/ro7yRkLl1s2X46
 5Dx1dDHWi4tfoT8qPgQw3hGEWfvYAg6S/iIFXsAAu8HVjWoDgEyyCazwj4fiG6SX
 uXN1+sTluHH9baDHhNU17h3WA8Z2gaqh8kJUPDnMcejbYFVCCoYLxhBI5g5YXAPw
 3xgEbVWE1x8rANg5oiLl+6fS/xQbJUWiVNDXp/Yd0MvfPf8n8v727dmJsUis5L03
 tqbxuQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehv9yb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:30:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso2548059a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 21:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784176217; x=1784781017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nffzmb4f0lNlevQ2+HoJd4K+Y5mqSRVv51+8YLqUd9I=;
 b=NHOggwgInmP1OsnCeyJZ8B7FfEAlkyRTjFjSxXKvoRdqWGuig9SlaOE8yuQ44gxDvB
 2OvlewhzNJXKd8GHYBT5I00yMK8AqLjkgiswau1l9Kl++9yqdx5HQD+Y/sFntsm2w2Bq
 28hwl7H/Y9TPpS2Lpm05X0dOuSMkVlcZWQQG/IAzg9doxm1IcckW/8dXFMzeG/bgosTj
 DvSUb6Yfx7FoMFEnFQaki/JjDFt3NJKLdtLuGhDRT+AwaUImCWMjm230JF6ecH7v06rh
 AyYeshuRJNC2UM7b/8MEZQJLMz8m0XUKysIJN0tGZHcDZeKT5xNWWP4AVhHOaTi3KJGP
 LR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784176217; x=1784781017;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nffzmb4f0lNlevQ2+HoJd4K+Y5mqSRVv51+8YLqUd9I=;
 b=I50PwNl+jxM19f2tANgZ6ETjbIawh2oPeM+X4sQX0HlUMpvn8fYi6vWnp+Zlrf94yZ
 EQ5y7F2u+dnypJpwsAD4PPt67+uPEfUFEUOAtF45S5KvCTiH/lB6A3F7Lo9LQ8NSL4pl
 ZbPCP9/g85P1qBkHLlhFlUa8Z+CEH3hMUo5bIVj1K3p8dJeDEnrYODPnphQ4MBmh3J0g
 zkjBq/g0maNTXMFYdeC4DCLK4WkGntQKWaCxm3+O1saQMpIeV7C5ECa1gem5/+gh1oe1
 o9eo3ISNu94GXI8mBKmwJUf13VzjhAjDgn0Z2M/FTi1oeoQhYB9f3WyyzmV717cWvgo/
 bJ1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVD1aSNL8YvW0B/xQkpl727pUhn1wkilnMpqFhk0KQskFx/KVs4xEO7h5Qbiefkr4ZYvzZtdnc5etn@nongnu.org
X-Gm-Message-State: AOJu0YzcCt7N6HMx5nlKlMbiaKeyZh/BgP+fbHxS8B6WFNHgFWsVwYHS
 EQJtgUbfMWuxwExVvYz9+VkccGZu4BacoqCE60JsDgQdUlplVwEkylG0jwUs6UPfkWfkX1XgX4X
 J5gLkESAR3yMmGU1cYEpRNVaxOTDT8Fbto4fWu82Ylp4oLDhNW+QDMnwNig==
X-Gm-Gg: AfdE7cnmS5e2lAn/ejJgnD+v8/ueRXm7l2X/ad4ctqkdl0dkXwRIU3ujKLXbCe0Zc/U
 u38G5YZKCoEx0e4rQyWLSj0vG69hKr4js9yUMEjaEbiuD5aVyBK4BCrjLGjAxacSzo0IzGiQd6D
 xp9jEZRs/fYFk/fCKpeVyG2NacZn80rikngAM0KsiSeet5YP5M2u3d2HCQ6k8TVsagR9MnGTFbL
 Vgi2/LltRLfxuXOyTXBb5kPwXmXUAGh2Zx7hj6yzsjrxHUDh7kyHiiOFVbnglxgIW6p1ulxFKyh
 fAxm+9rdEZednKexQErKQnmGE/Gl++E3kHQoQI54ZTg9MXXsRWO++VJ/uLoxbsoGCHbVOGjLDd8
 9Vq5cxaM348wq8hp4+daKWW7RjqcwzYB+zJ+mjlY6S576MJIAKnTJSPrpPgO7rYHQHDuiHA6djZ
 ERdUtw
X-Received: by 2002:a05:6a20:d49a:b0:3bf:b0b8:58b5 with SMTP id
 adf61e73a8af0-3c110b1e40cmr22829405637.36.1784176216781; 
 Wed, 15 Jul 2026 21:30:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49a:b0:3bf:b0b8:58b5 with SMTP id
 adf61e73a8af0-3c110b1e40cmr22829369637.36.1784176216167; 
 Wed, 15 Jul 2026 21:30:16 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e500e8fsm7263108eec.6.2026.07.15.21.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 21:30:15 -0700 (PDT)
Message-ID: <ee5130cb-b321-47e1-85c9-3dabe67692cd@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 23:30:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 48/98] tests/tcg/hexagon: user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-49-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-49-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a585e59 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=6OU5NNBDY5kOYk7qdJEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA0MiBTYWx0ZWRfX2BN5i3rS/poV
 PkMR/C+FfZfmweh5Ze5YMPLw1iDjBU9kxv0oDfXxpYyKgkbCPXhuaip5WfBGob6gmn0KOCl02rs
 4yN8Wc/zEtvyrlu4BnDn24s9kHq4211ym6Ebp9oK1K7lp7V266i0HYKcPXb3Qiu/UzQuwr/XEEA
 oNNk2XoBwe0Noc9qXQnRJdyMkccforVkh2P57xeHqpbQXYiaMjZ6FnBPiBYP2K/euLquh6l66Ff
 zTiQrUFmgoTULp6K1ylbpFARQEy6DKnTWm19ROIzo2BOeb+nDCn5t+7jxhBCzjEiDzJsc4lxxfC
 DexX90IN0K/03nDGmtw/pbGSUmGHVUaOmftNUPtJZIOPUZZmNPCieju+Qcs0YP6JsCXb1sKkYX6
 Czh6mZH2lemODQ5g9ZIQ7EhBYulmlD8k7Sur4Zd8dMYOIz/KyICXq6+7OqGCXEXmOIjNxz2zHqw
 huEjoFMMEgIKM3lcXEA==
X-Proofpoint-GUID: 5qCUecaAGtCi545BeQrHTXfBiW4K7ljD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA0MiBTYWx0ZWRfX9YJpbUnlAcDO
 4TSMzVMtHEPTwwAyxxWwgUTW1/o//DB6Z06UxTL6j79X3uknezT7T1D+CTtMW6Y0JoJF2NLQ5JO
 T1gjIkTtdbbOoHV94TiN+kJe6TTDwD8=
X-Proofpoint-ORIG-GUID: 5qCUecaAGtCi545BeQrHTXfBiW4K7ljD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/10/2026 4:42 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   tests/tcg/hexagon/Makefile.target | 146 ------------------------------
>   tests/tcg/hexagon/meson.build     | 111 +++++++++++++++++++++++
>   tests/tcg/meson.build             |   1 +
>   3 files changed, 112 insertions(+), 146 deletions(-)
>   delete mode 100644 tests/tcg/hexagon/Makefile.target
>   create mode 100644 tests/tcg/hexagon/meson.build
>
> diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
> deleted file mode 100644
> index 70a8ec2e7fb..00000000000
> --- a/tests/tcg/hexagon/Makefile.target
> +++ /dev/null
> @@ -1,146 +0,0 @@
> -##
> -##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> -##
> -##  This program is free software; you can redistribute it and/or modify
> -##  it under the terms of the GNU General Public License as published by
> -##  the Free Software Foundation; either version 2 of the License, or
> -##  (at your option) any later version.
> -##
> -##  This program is distributed in the hope that it will be useful,
> -##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -##  GNU General Public License for more details.
> -##
> -##  You should have received a copy of the GNU General Public License
> -##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> -##
> -
> -# Hexagon doesn't support gdb, so skip the EXTRA_RUNS
> -EXTRA_RUNS =
> -
> -CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
> -CFLAGS += -fno-unroll-loops -fno-stack-protector
> -
> -HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
> -VPATH += $(HEX_SRC)
> -
> -%: $(HEX_SRC)/%.S $(HEX_SRC)/crt.S
> -	$(CC) -static -mv67 -nostdlib $^ -o $@
> -
> -HEX_TESTS = first
> -HEX_TESTS += hex_sigsegv
> -HEX_TESTS += misc
> -HEX_TESTS += usr
> -HEX_TESTS += preg_alias
> -HEX_TESTS += dual_stores
> -HEX_TESTS += multi_result
> -HEX_TESTS += mem_noshuf
> -HEX_TESTS += mem_noshuf_exception
> -HEX_TESTS += circ
> -HEX_TESTS += brev
> -HEX_TESTS += load_unpack
> -HEX_TESTS += load_align
> -HEX_TESTS += atomics
> -HEX_TESTS += fpstuff
> -HEX_TESTS += overflow
> -HEX_TESTS += signal_context
> -HEX_TESTS += reg_mut
> -HEX_TESTS += read_write_overlap
> -HEX_TESTS += vector_add_int
> -HEX_TESTS += scatter_gather
> -HEX_TESTS += hvx_misc
> -HEX_TESTS += hvx_histogram
> -HEX_TESTS += invalid-slots
> -HEX_TESTS += invalid-encoding
> -HEX_TESTS += multiple-writes
> -HEX_TESTS += unaligned_pc
> -
> -HEX_TESTS += test_abs
> -HEX_TESTS += test_bitcnt
> -HEX_TESTS += test_bitsplit
> -HEX_TESTS += test_call
> -HEX_TESTS += test_clobber
> -HEX_TESTS += test_cmp
> -HEX_TESTS += test_dotnew
> -HEX_TESTS += test_ext
> -HEX_TESTS += test_fibonacci
> -HEX_TESTS += test_hl
> -HEX_TESTS += test_hwloops
> -HEX_TESTS += test_jmp
> -HEX_TESTS += test_lsr
> -HEX_TESTS += test_mpyi
> -HEX_TESTS += test_packet
> -HEX_TESTS += test_reorder
> -HEX_TESTS += test_round
> -HEX_TESTS += test_vavgw
> -HEX_TESTS += test_vcmpb
> -HEX_TESTS += test_vcmpw
> -HEX_TESTS += test_vlsrw
> -HEX_TESTS += test_vmaxh
> -HEX_TESTS += test_vminh
> -HEX_TESTS += test_vpmpyh
> -HEX_TESTS += test_vspliceb
> -
> -HEX_TESTS += check_rev_gating
> -HEX_TESTS += test_pnew_jump_loads
> -
> -HEX_TESTS += v68_scalar
> -HEX_TESTS += v68_hvx
> -HEX_TESTS += v69_hvx
> -HEX_TESTS += v73_scalar
> -
> -TESTS += $(HEX_TESTS)
> -
> -atomics: atomics.c hex_test.h
> -brev: brev.c hex_test.h
> -circ: circ.c hex_test.h
> -dual_stores: dual_stores.c hex_test.h
> -fpstuff: fpstuff.c hex_test.h
> -hex_sigsegv: hex_sigsegv.c hex_test.h
> -load_align: load_align.c hex_test.h
> -load_unpack: load_unpack.c hex_test.h
> -mem_noshuf_exception: mem_noshuf_exception.c hex_test.h
> -mem_noshuf: mem_noshuf.c hex_test.h
> -misc: misc.c hex_test.h
> -multi_result: multi_result.c hex_test.h
> -overflow: overflow.c hex_test.h
> -preg_alias: preg_alias.c hex_test.h
> -read_write_overlap: read_write_overlap.c hex_test.h
> -reg_mut: reg_mut.c hex_test.h
> -test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
> -unaligned_pc: unaligned_pc.c
> -
> -# Compile for v66 so that the ELF selects a v66 CPU; the test then
> -# exercises revision gating by executing a v68 .word instruction.
> -run-check_rev_gating: QEMU_OPTS += -cpu v66
> -check_rev_gating: check_rev_gating.c
> -	$(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)
> -
> -# This test has to be compiled for the -mv67t target
> -usr: usr.c hex_test.h
> -	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
> -
> -# Build this test with -mv71 to exercise the CABAC instruction
> -misc: misc.c
> -	$(CC) $(CFLAGS) -mv71 -O2 $< -o $@ $(LDFLAGS)
> -scatter_gather: CFLAGS += -mhvx
> -vector_add_int: CFLAGS += -mhvx -fvectorize
> -hvx_misc: hvx_misc.c hvx_misc.h
> -hvx_misc: CFLAGS += -mhvx
> -hvx_histogram: CFLAGS += -mhvx -Wno-gnu-folding-constant
> -v68_hvx: v68_hvx.c hvx_misc.h v6mpy_ref.c.inc
> -v68_hvx: CFLAGS += -mhvx -Wno-unused-function
> -v69_hvx: v69_hvx.c hvx_misc.h
> -v69_hvx: CFLAGS += -mhvx -Wno-unused-function
> -v73_scalar: CFLAGS += -Wno-unused-function
> -
> -hvx_histogram: hvx_histogram.c hvx_histogram_row.S
> -	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
> -
> -ifeq ($(CONFIG_PLUGIN),y)
> -# LLVM is way too aggressive with inlining and dead code elimination even at
> -# -O0, which interferes with the test. What looks like dead code in this test
> -# to the compiler isn't actually dead code, so we need to disable all potential
> -# LLVM optimization passes.
> -test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
> -endif
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> new file mode 100644
> index 00000000000..423d125d2ae
> --- /dev/null
> +++ b/tests/tcg/hexagon/meson.build
> @@ -0,0 +1,111 @@
> +tests = []
> +
> +cflags = ['-Wno-incompatible-pointer-types', '-Wno-undefined-internal',
> +          '-fno-unroll-loops', '-fno-stack-protector']
> +asmflags = [cflags, '-nostdlib', '-mv67', files('crt.S')]
> +
> +multi_src = []
> +foreach t: tcg_tests['multiarch-linux-user']['tests']
> +  foreach src, setup: t
> +    if 'gdb_test' in setup
> +      # gdb does not support hexagon, ignore test
> +      continue
> +    endif
> +    new_cflags = []
> +    if 'cflags' in setup
> +      new_cflags += setup['cflags']
> +    endif
> +    new_cflags += cflags
> +    if src not in multi_src
> +      setup += {'cflags': [new_cflags]}
> +      multi_src += src
> +    endif
> +    tests += {src: setup}
> +  endforeach
> +endforeach
> +
> +tests += {
> +  'atomics.c': {'cflags': cflags},
> +  'brev.c': {'cflags': cflags},
> +  # Compile for v66 so that the ELF selects a v66 CPU; the test then
> +  # exercises revision gating by executing a v68 .word instruction.
> +  'check_rev_gating.c': {
> +    'cflags': [cflags, '-mv66', '-O2'],
> +    'qemu_args': ['-cpu', 'v66'],
> +  },
> +  'circ.c': {'cflags': cflags},
> +  'first.S': {'cflags': asmflags},
> +  'fpstuff.c': {'cflags': cflags},
> +  'hex_sigsegv.c': {'cflags': cflags},
> +  'hvx_misc.c': {'cflags': [cflags, '-mhvx', '-mv69']},
> +  'hvx_histogram.c': {
> +    'cflags': [cflags, '-mhvx', '-Wno-gnu-folding-constant',
> +               files('hvx_histogram_row.S')]
> +  },
> +  'invalid-encoding.c': {'cflags': cflags},
> +  'invalid-slots.c': {'cflags': cflags},
> +  'load_align.c': {'cflags': cflags},
> +  'load_unpack.c': {'cflags': cflags},
> +  # Build this test with -mv71 to exercise the CABAC instruction
> +  'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
> +  'multiple-writes.c': {'cflags': cflags},
> +  'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
> +  'preg_alias.c': {'cflags': cflags},
> +  'dual_stores.c': {'cflags': cflags},
> +  'multi_result.c': {'cflags': cflags},
> +  'mem_noshuf.c': {'cflags': cflags},
> +  'mem_noshuf_exception.c': {'cflags': cflags},
> +  'read_write_overlap.c': {'cflags': cflags},
> +  'reg_mut.c': {'cflags': cflags},
> +  'scatter_gather.c': {'cflags': [cflags, '-mhvx']},
> +  'signal_context.c': {'cflags': cflags},
> +  'test_abs.S': {'cflags': asmflags},
> +  'test_bitcnt.S': {'cflags': asmflags},
> +  'test_bitsplit.S': {'cflags': asmflags},
> +  'test_call.S': {'cflags': asmflags},
> +  'test_clobber.S': {'cflags': asmflags},
> +  'test_cmp.S': {'cflags': asmflags},
> +  'test_dotnew.S': {'cflags': asmflags},
> +  'test_ext.S': {'cflags': asmflags},
> +  'test_fibonacci.S': {'cflags': asmflags},
> +  'test_hl.S': {'cflags': asmflags},
> +  'test_hwloops.S': {'cflags': asmflags},
> +  'test_jmp.S': {'cflags': asmflags},
> +  'test_lsr.S': {'cflags': asmflags},
> +  'test_mpyi.S': {'cflags': asmflags},
> +  'test_packet.S': {'cflags': asmflags},
> +  'test_reorder.S': {'cflags': asmflags},
> +  'test_round.S': {'cflags': asmflags},
> +  'test_vavgw.S': {'cflags': asmflags},
> +  'test_vcmpb.S': {'cflags': asmflags},
> +  'test_vcmpw.S': {'cflags': asmflags},
> +  'test_vlsrw.S': {'cflags': asmflags},
> +  'test_vmaxh.S': {'cflags': asmflags},
> +  'test_vminh.S': {'cflags': asmflags},
> +  'test_vpmpyh.S': {'cflags': asmflags},
> +  'test_vspliceb.S': {'cflags': asmflags},
> +  'unaligned_pc.c': {'cflags': cflags},
> +  'usr.c': {
> +    'cflags': [cflags, '-mv67t', '-O2',
> +               '-Wno-inline-asm', '-Wno-expansion-to-defined']
> +  },
> +  'v68_scalar.c': {'cflags': [cflags, '-mv68']},
> +  'v68_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv68']},
> +  'v69_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv69']},
> +  'v73_scalar.c': {'cflags': [cflags, '-Wno-unused-function', '-mv73']},
> +  'vector_add_int.c': {'cflags': [cflags, '-mhvx', '-fvectorize']},
> +}
> +
> +if 'qemu-hexagon' in emulators
> +  tcg_tests += {
> +    'hexagon-linux-user': {
> +      'cc': 'hexagon-unknown-linux-musl-clang',
> +      'cc_dockerfile': 'debian-hexagon-cross',
> +      'cc_docker_host_arch': ['x86_64'],
> +      'folder': 'hexagon',
> +      'gdb_arch': 'hexagon_is_not_supported_by_gdb',
> +      'qemu': emulators['qemu-hexagon'],
> +      'tests': tests,
> +    }
> +  }
> +endif
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index e2bc582ab5b..e6206ae670a 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -137,6 +137,7 @@ subdir('aarch64')
>   subdir('aarch64_be')
>   subdir('alpha')
>   subdir('arm')
> +subdir('hexagon')
>   
>   image_targets = {}
>   exe_targets = []

