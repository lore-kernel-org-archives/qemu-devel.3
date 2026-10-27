Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50780606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RocFXlNn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NiypRJ40
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlj7-00010h-BK; Tue, 27 Oct 2026 14:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlhT-0007ua-M0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlhO-0003La-Cr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:15:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH02GR2463901
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zTHQAZF9Eh3ScdpJFBH3XJK63NvzNL6T+jF2gPsf7dM=; b=RocFXlNnfe6UV67d
 UzdqPm9Jx21Z27iM6zqNF/RTvRAsT3mJcEZjRm8pSbRXkev3Uv+OZLPaWlZg7l5G
 4sybIXODEq1p7sM9dTqqwfb7pTZYfLgN0Uw6MvykvypvjcwB4NRMV+jTQ/1Nm0An
 RYR3Be7o+O5xNpy9wMOtpadLpEK8Fm7EZG2RefIfiRuUeDy7jSwGejKYx5IOX6Bg
 K086sslCHhHGee0YMnzeW8AImJPze5lObZWh3cZp+tEqiH2lXkrvvFhPxGeFcja9
 hleOtmzJ6RzPXX5b+aUw1LKNK5z2BV91sdzR4SneG4euPkViB4JTA4XK7MiH0UKU
 CArRMA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5trkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:14:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3698bd5392cso77105eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793124899; x=1793729699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zTHQAZF9Eh3ScdpJFBH3XJK63NvzNL6T+jF2gPsf7dM=;
 b=NiypRJ40eGQAapgCoVT+1GSMsH4BxiEug+NVykiE21GZr34ipKmLF6OdRecQ9Pabh0
 alV8uCaLZuV/sBcbNiTx99IxDQjcOo3cilf6ryPVMeaCoVM84WlcP/j1v3ZCj4VcDQgn
 cEmMiFIEBwfzZELnFCZs+9y5SAiKTE2Lst5bnWUYeE+GAyiswrt+xmSUjdliIyornAJC
 Vwh7M+XUOjqX56eRzsc8bWD+oMJVyqlJl+HkmdYvZpK6ZqXGAXRbocboVl5Fz4Zj20u3
 2oyY3A4pJkTWXCIHCBtYG7ZGqcNrz9CcOBdmN4wTxpqjNRzJblXzpMaS0FLWVKICvUAI
 v6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124899; x=1793729699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zTHQAZF9Eh3ScdpJFBH3XJK63NvzNL6T+jF2gPsf7dM=;
 b=EB6DHhysybwp6CgDH7wZ16tSW3oKVxqx7iGCJUS6IfhJHaD865xbQ32ynbtfcRQF+4
 XEGllZfZKHp6p4a5FgryolFsFVXFlLTZG1DWo7ipY+hDfdCZQtISwfga8QArliFRoZIT
 Jlf4pAT6QGJopUlrYOA32qtLFNf+CmDcl8AbBZP/baSS4TedwVFody6TE1DNbFwfDzxN
 VHvLZmTCRlvMyjsEk0AiiBZYYmlvCz3cBmag9LJjCk5ZoUSFoXq5OWJn2xTDBCp+tai+
 sJONYOI3hC0xzFQ9VwpESWsN+WSPhIR138zg6Sr4q1KLn7FnaRr3JsL9lI3Sc4iZ69gZ
 SYBw==
X-Gm-Message-State: AFq9FYKct9hVsI3YsqBxYnsfV4GAd5orOsOVHxZP9apgbZe3tOco/fj9
 PVRBSEsWxuqfeoHMvGLnaRUIjsh1RV/eFCkCIxRpR80NFZYmiqiCWIXtOAeThwsBFn0sU/MIdE5
 Qs1ojWsahGzzNanOv/3HMFTfQ8TpohkCL8DYwRxsq6rpK3w599ufc31iPHvZv0erByg==
X-Gm-Gg: AYBFou0OTJn+cyr5fwQUXnO0Y/XP8luIWR+Hs2voQW5+fpA3hDIUyuLgHINAtCnGauV
 BO6Ca/JsP7Ne4M+ZQVoMDKgxPstod4sm/VJX03nRUGPxV68WeNxoak2CXZQNbrb2vlPM43iI8fX
 U5PMN+LqoVspFaDvEFUmOdrB4j1chIkiQvCkMfg0B8dl5GKyp4I74GKZezSUH3pNvPJi59Ge22r
 vXK9dnpfIplisg7FzbPDVKRzlAhUu7EvKzRxgSNoFW81B8TQUfW/mZm/i8kqtZWoiCxHKW49Fgn
 aDw4U0jvyI9Q5cEyf4pOKRJEU012InJHMe23I5/jBx2GdLOPFetU3MAMSixC2UrwfQBql0gJpbH
 SC03hfTMoNJIiclP1hHtMS7jlCafBCZLxrdQ4rutN6SrEmPwPNVSndoYkowNhJOnubGscEA==
X-Received: by 2002:a05:7300:e6c4:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36a0f804e83mr6393221eec.13.1793124898561; 
 Tue, 27 Oct 2026 11:14:58 -0700 (PDT)
X-Received: by 2002:a05:7300:e6c4:b0:36a:37:1404 with SMTP id
 5a478bee46e88-36a0f804e83mr6393186eec.13.1793124898021; 
 Tue, 27 Oct 2026 11:14:58 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a14383b02sm8799903eec.14.2026.10.27.11.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:14:57 -0700 (PDT)
Message-ID: <99e47e46-5ae5-443b-8231-7ce75ba06bc4@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:14:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] multi-target: prefix helpers with target prefix
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfXwy7UR4x5X28A
 jPYdOSC39UO7fIaApe7aXfn7aHoDF1eUV/GDnm7OFcian+L2PSjsMgnirj9EiZN2+mt/e3DG/QM
 nys7YsyYSpieVwVes8pObN34qtu/QVc=
X-Proofpoint-ORIG-GUID: Vrzs-gNWFZfm-LAOOv62GPNTNk6cwSzz
X-Proofpoint-GUID: Vrzs-gNWFZfm-LAOOv62GPNTNk6cwSzz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfXwrr7FlbjsjpW
 L2n7BWsHTmQkW8CnhmvfGIvZt+bCSUQqeMFoI5H7FeNBjeoO4KkOZPX9BN+m+N7oAaHRJLZWnDi
 gQTtUj6JCpdBXmYftLBOlAGTG/A1uu0pINGY/loC7pm656tI/2/BDGlNypMlPb5Wrn2S1BWCzqg
 1SQexqNRrTjMMG6QzGMmZv45JdEfq6mqFh3A/U2QuNx8M6daYJP83GLXTCWfVQeXZakFSb0PCVN
 4X3YUSujMVgwhBNnuFIylTpI8ZfnO8TJqURc6yJPPanUIdsmPbtpYfOXUsLruRq+cj51r+gCzeg
 sQqbsq4XqUCLaEw5WOR2r5alqSJoW7jMXsKd/fkfD9YYi7pHSjWyEJ6Z6F+3ILFNoPTyhbsza09
 laG09jwOS+D12MOWYK0qKOrCikfJO70HPi8Xh/r/6axDvi2L/EoSQiguduP4Sha9OZeTt8dyHL1
 4Lu7Wm+aQ6Yq5wLrBJA==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0ea23 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KDT6tUgf14y1PYgi-McA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 8:32 AM, Pierrick Bouvier wrote:
> When linking multiple targets together, we usually have conflicts with helper
> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
> would be better to have a general mechanism for it, so here it is.
> 
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
> but it was relying on (binary) symbol renaming, which is not a portable solution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.
> 
> Series follows these steps:
> 
> First, we make sure all helpers and definition are using HELPER() macro. A lot
> of helpers were already defined this way, we just make sure it's exhaustive.
> After that we don't have any 'helper_' left on any target code. This is a big
> change touching the whole codebase, but it's a simple mechanical change. As long
> as it compiles and links, we know it's correct.
> 
> Then, we introduce the prefix for target helpers. For this , we add a new define
> (from meson) that applies to all target related code. It could later be used to
> prefix other symbols also, that's why it's not named "TCG".
> 
> Finally, we cleanup the previous manual helpers prefix that were added in
> codebase.
> 
> v2
> --
> 
> - rebase on master (series partially merged + solved conflicts)
> - new sparc helpers not using HELPER macro
> 
> Pierrick Bouvier (11):
>   target/rx: define and call helpers using HELPER macro
>   tcg: introduce HELPER_INFO macro
>   target/sparc: define crypto helpers using HELPER macro
>   tcg: prefix helpers with target base architecture
>   target/alpha: remove explicit target specific prefix
>   target/hexagon: remove explicit target specific prefix
>   target/hppa: remove explicit target specific prefix
>   target/microblaze: remove explicit target specific prefix
>   target/or1k: remove explicit target specific prefix
>   target/rx: remove explicit target specific prefix
>   target/tricore: remove explicit target specific prefix
> 
>  include/exec/helper-gen-common.h   |  7 ++++
>  include/exec/helper-gen.h.inc      | 48 ++++++++++++------------
>  include/exec/helper-head.h.inc     |  8 +++-
>  include/exec/helper-info.c.inc     | 16 ++++----
>  include/exec/helper-proto-common.h |  7 ++++
>  meson.build                        |  2 +
>  target/alpha/fpu_helper.c          |  2 +-
>  target/alpha/helper.h              |  2 +-
>  target/alpha/translate.c           |  4 +-
>  target/hexagon/gen_tcg.h           |  2 +-
>  target/hexagon/gen_tcg_sys.h       |  2 +-
>  target/hexagon/helper.h            |  4 +-
>  target/hexagon/op_helper.c         |  4 +-
>  target/hexagon/translate.c         |  4 +-
>  target/hppa/helper.h               |  6 +--
>  target/hppa/op_helper.c            |  4 +-
>  target/hppa/sys_helper.c           |  8 ++--
>  target/hppa/translate.c            |  6 +--
>  target/microblaze/helper.h         | 10 ++---
>  target/microblaze/op_helper.c      | 10 ++---
>  target/microblaze/translate.c      | 10 ++---
>  target/or1k/helper.h               |  2 +-
>  target/or1k/interrupt_helper.c     |  2 +-
>  target/or1k/translate.c            |  2 +-
>  target/rx/helper.h                 | 12 +++---
>  target/rx/op_helper.c              | 60 +++++++++++++++---------------
>  target/rx/translate.c              | 14 +++----
>  target/sparc/crypto_helper.c       | 30 +++++++--------
>  target/tricore/fpu_helper.c        | 12 +++---
>  target/tricore/helper.h            | 14 +++----
>  target/tricore/translate.c         | 14 +++----
>  31 files changed, 175 insertions(+), 153 deletions(-)
> 

This was merged into master (2c0584588c9fedc2a8abc087c01a498ce80997d0).

Regards,
Pierrick

