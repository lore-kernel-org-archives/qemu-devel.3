Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B4606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hcGBStxD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RegXTwLQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRps-0005iC-S8; Thu, 29 Oct 2026 11:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpb-0005Of-3D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRpZ-00030G-3p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:14:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TDaDLn3521391
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M0yWeTM3tJ7bvf+ZrbqduyFmuCUEtAi6dYtkCl7tFLU=; b=hcGBStxDKCki5ZMh
 RXxIKD777FDH3FBhQ94hh4+ylnC5AOJDjiEauFujuggWMEdldz2xivQm3t4xSiAT
 bFJlaJHV8THLFx8NVZsYix+xado6fDj2csKqRGxubrFe9mw8WUvduIkkAETSJf9J
 Vx7cVaXsv2eTlgMd6BnMPT//pnHq5Su3tGzaOi28NeuC0KSbQXAAtEkuw6hJrVhN
 PTTMjekfENXfZQAlMk0u3rjtURlqIKkzEX/L17gLszPrmjvVylDigrIdrXh3N0vV
 lBFaRxAzOnLFRSWo3r//Il2cPrrgo+MhgRYyCTPaECjoB2iMGJpn0HJTyX7i2nRw
 1vpHYA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm7620dt5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:14:15 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8ace1d95f5eso18059537b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286854; x=1793891654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M0yWeTM3tJ7bvf+ZrbqduyFmuCUEtAi6dYtkCl7tFLU=;
 b=RegXTwLQph7/6LVc4/2J/byiVwiUl3ouE1a0gZwfgXIrE2GPDSJV67GfYS3jH8dCh2
 94AxVZMpvl+6qlI/ETvNwElKWXHNBrJjZl3zYvo1l53DoUVtboifIIsRk0F2Bgr12TNO
 yHA3cJZ7fL6NGJvGc0RC34vA5eW2G2cUyyqLKoixyyXR9VHzOxJWI087pd8pgDB9OB4U
 RN3QZ4OGslNKIHppb+sbloAQqHbj2LiK65lSH8IEfsYqQ6XRWO+j5IEiUYpYpfk4uhis
 oZ8y4pp6Q2FmnvQsxfQQ8TpQP14DN0QnZrJiJD0mtOUTRlzdnGUrLXZWRC5mrbi8iKEx
 oNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286854; x=1793891654;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M0yWeTM3tJ7bvf+ZrbqduyFmuCUEtAi6dYtkCl7tFLU=;
 b=OmAOo0Scg2Aqs4T6VJotu1ybpVqesPfwHurHEbGLF+ZElk+lgfcKpR9NTI84bhVtku
 z154/lVZnCyK6mwtsmIRZxtMHJGf6Zalu9vXJ1Reg1g4QUMpUPQ/8UovjoDW4shrRefF
 MVxSgzwNN94+lbFhcKTLY+PZmnq+G5jOVxZ6LQz0T4GTDYeIdZgqQ/GscjvwbGj+0Es+
 Btq/Nc/syy1J9sbeEe2YcVVvDRQOMX9MaOzZk63wocS9KCdxt2SRuytTiScNkxxQ2W9H
 reWZ4xE8IT0tVSqP7NdilyMVNPuhx+bfL6TaobeLe8IIAdJsMS8ygJrFrq4+vtBOriU2
 4upQ==
X-Gm-Message-State: AFq9FYJZaqtTBFC86CXULSJplcXddytkMBz7/H+9LSaK+Jz6YG7R3TtX
 ++uYqfgCo3uRaIyTSDgUSkVcjTW/Jbx4BFudnjhLGnWS4AOrzMg8sCQ1w7aozGW+i6yCaUuB8Br
 nobrz1hwFW/Z3WaO6+ivucw4OMbf/AbjeRPK8zPkiXCt56w9soULFFAM+no7Uk0eVvIUL
X-Gm-Gg: AYBFou2u6jXwx78Uh+ys2Hwy4xKA1/Wkm/7tFwPbNfhBvtOembW6uABWKLemMct181r
 D9BXqXl2QKQ89E1fwypKW0E9CwDsaJIcyZsFN63i4nVv0RZ5R+BgvWMyGJwNL2MJXtwEHHFiK2P
 SCno3/Ksqh29uv3c7sq3rQus/cPpj4NcRlcTbLC7kP6ME70PpsFN9uoAth0fP5aGLZoOkgHAwI5
 dahzgAD+hg6sE+yivh3Y7uN4ZiRk9dy9recDPtK3A/PPlf0tJ7QvilSC1v9A+Ny0QbEgZKvR+FU
 nkMmz4jiu3lZuwf7tcn6Mc/HZbqKuSvolTavAjVgL86oHmEwkAC2xDLveqsI9t/dkePIJJhfJxv
 gNL/U8Zd9iZ7ib36XfOv3ZQoyjIKOakLXE96VIMHFkV4dVYkmNPFuCOxIZk1b5FKQn0louUWViK
 OT9YERIL7w1FTgRa7AXAjFmLYCj/lZTA==
X-Received: by 2002:a05:690e:43cf:b0:671:1b72:bd0f with SMTP id
 956f58d0204a3-67a7bc8610dmr3724648d50.58.1793286854335; 
 Thu, 29 Oct 2026 08:14:14 -0700 (PDT)
X-Received: by 2002:a05:690e:43cf:b0:671:1b72:bd0f with SMTP id
 956f58d0204a3-67a7bc8610dmr3724627d50.58.1793286853691; 
 Thu, 29 Oct 2026 08:14:13 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb9cesm36921816f8f.27.2026.10.29.08.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:14:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 6/6] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Date: Thu, 29 Oct 2026 16:13:16 +0100
Message-ID: <20261029151317.19170-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2PDSBSCzoxtNe_PDfy6C7tEcC73uGYzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX92H+ey+s6frk
 mLVWHTQNR6/Iru2wMUU6Ju2pu0W1HvTZBrIb4D9PqYRiRtQFbJPnUGEpVVzDPeYvT4r2cWvEbor
 eqmMpw959kS96J7pi4ux2vs9hqvxz12wZJ+9DHPfxV5IhYeAd/48vhRJsIuqjqz6wEEkwJFaCG4
 OyNN7g88bgzUNB/5nBPTghAHbpI/Db7XMtKrjEFdSp8rFuqo8UWAj6RjxsLzyJjkrszntZ5dfQT
 VACk78H2pPuU5U+xuQpEk5caBSoDMS4s0rXHv89DgQEMYFjm8aK9bG/D8pbHONBuH6DjkR49wZo
 FVd9f748NJ30N6b3fMeQUZhwzbecDGBr1qbM5+pzyYPM+Fx2xfBUn52AG45VWwNe2tRZR0XAtKj
 reQgWdORpamWMWm6W+IbEeUkS52Nt4qghm8kxnggv4dw5BZUHB0l0LnlHVoe8uZ0ZOHDaCv/nBb
 N9bbd5gPJEHUyttLPsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfXxa7ATGx1x1pn
 DAwR8v0UT+OLk42b0FQf1YiUGcJnFRxvIuCICIHh6A9jgXauyCD8Bu7GF4Y5wWRvKT5cdbPdxyZ
 6WXB79koO0A+POhX5nugBXSzXpV8n5k=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae362c7 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XTilkJpsIER5Kj8Md9AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2PDSBSCzoxtNe_PDfy6C7tEcC73uGYzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/devel/loads-stores.rst  | 18 +++++++-------
 include/accel/tcg/cpu-ldst.h | 48 ------------------------------------
 2 files changed, 9 insertions(+), 57 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 3aeb8bbe8ba6..eeef55347857 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -150,13 +150,13 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
  - ``q`` : 64 bits
 
 ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
  - ``_be`` : big endian
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_mmuidx_ra\>``
 
 ``cpu_{ld,st}*_data_ra``
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -188,13 +188,13 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
  - ``q`` : 64 bits
 
 ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
  - ``_be`` : big endian
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data_ra\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data_ra\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data_ra\>``
 
 ``cpu_{ld,st}*_data``
 ~~~~~~~~~~~~~~~~~~~~~
@@ -227,13 +227,13 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
  - ``q`` : 64 bits
 
 ``end``
- - (empty) : for target endian, or 8 bit sizes
+ - (empty) : for 8 bit sizes
  - ``_be`` : big endian
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
- - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
+ - ``\<cpu_ld[us]\?\(b\|[wlq]\(_[bl]e\)\)_data\>``
+ - ``\<cpu_st\(b\|[wlq]\(_[bl]e\)\)_data\+\>``
 
 ``cpu_ld*_code_mmu``
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 1facabccb23a..bde3bd0425c9 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -423,52 +423,4 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
-#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_data        cpu_lduw_be_data
-# define cpu_ldsw_data        cpu_ldsw_be_data
-# define cpu_ldl_data         cpu_ldl_be_data
-# define cpu_ldq_data         cpu_ldq_be_data
-# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_stw_data         cpu_stw_be_data
-# define cpu_stl_data         cpu_stl_be_data
-# define cpu_stq_data         cpu_stq_be_data
-# define cpu_stw_data_ra      cpu_stw_be_data_ra
-# define cpu_stl_data_ra      cpu_stl_be_data_ra
-# define cpu_stq_data_ra      cpu_stq_be_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-#else
-# define cpu_lduw_data        cpu_lduw_le_data
-# define cpu_ldsw_data        cpu_ldsw_le_data
-# define cpu_ldl_data         cpu_ldl_le_data
-# define cpu_ldq_data         cpu_ldq_le_data
-# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_stw_data         cpu_stw_le_data
-# define cpu_stl_data         cpu_stl_le_data
-# define cpu_stq_data         cpu_stq_le_data
-# define cpu_stw_data_ra      cpu_stw_le_data_ra
-# define cpu_stl_data_ra      cpu_stl_le_data_ra
-# define cpu_stq_data_ra      cpu_stq_le_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-#endif
-#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.55.0


