Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45973CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjXj-0004N5-1w; Fri, 16 Oct 2026 11:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjXe-0004MR-Rx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:08:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjXc-0003DN-37
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:08:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5ihD1910949
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6a4fdkVXMdvM+pndtBwJsLK8WYKo31r9J/xYO5cZW6o=; b=Cm5qATK3lbFsQe6K
 fvE5OjiSn+3w3el/Yel6CXppcFzcGReXUdK02ytHTou3UxTjjAUu4dmOzrGsgTkP
 0lO1G5tatwuoIqsfnPYunxKW7f5AxxiwprnfEqciyaCzTcWarANG0YMmuLHb59MG
 1WcR/GeXoIXkRqLeVDmBqWtLiLk97vDk8/EMXSMuAEKT3nBtzmJasvehVSGq51zN
 U6I0Y9eT/z/6Gfm68t+9+KL19ExwzAvwvfikVpqhIi9pOVeX+9blwPYksB+xsOl+
 FiwKl46aU1YSO9TPWg5CEA9zSVU8aozPp47a2sn/N2FpVwyLpO5bLN+FxlI/Kzrn
 hC1heg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf8wmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:08:05 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4c467e19391so140438b6e.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163285; cv=none;
 d=google.com; s=arc-20260327;
 b=HenHb/Ai9GWXbUnfFtyhdKzQVtXpcogiivPDEns02K8VGZNiHFE12OruEPeQhQ3fDV
 g6Q/+JWTJ4YTxMFmoV0zMxFelaeW9jkRg/F2DjOQYIrTQqoDvX5YS7Mb3TXDI8TV/fNS
 mtJ3x6RTtavVWcGRUZDAlqSkN2kXP88w2pcO2WD5zDgg4OMATNFQZb6yZetoEPPgefG9
 fqbTMXLd5kX4oQxfHzaQ6OnTKtAeCv+RqUA7h4af2Qc77Xz+yBrRmC0UWPx6yIuHkH2Y
 i9XVqvdaXjVWdXLdrf3Cp9KScC9rzj5Z8FMe+2ZfXRzTOJWMn4DUaHLgIowNsg2e7L4b
 VZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6a4fdkVXMdvM+pndtBwJsLK8WYKo31r9J/xYO5cZW6o=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=SdnBHlItub200gNtNxjnyzB1XNbKVDXM2lV1RnhQzFQvbSeShkxgZInRBQmnIQH0gF
 AWKdYFHndGTxw6iNPDmlM7I10hXZuWLdcSkD18nfmcJXkcgKBilaKGyTFiFmat5vxKEm
 eR3uREnz2dtz65tjx/kFuUb3fpiMrTajCMDnnaEfraF4aza5H0Rbjud1PvMguICBV89w
 MXzXYbEEc/dhOaFEXM2N4Jpz6wlmSgM0E3b6gS3ZqidkrixPtw3tHZ8msjKbvYbfyB3Z
 qK1s4z9f1Xpg+S07T00F2rCllwOmRdYG/gIzFGszeL2xwT7S5LuS3+G7I4GEhFaOT+jC
 hVLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792163285; x=1792768085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6a4fdkVXMdvM+pndtBwJsLK8WYKo31r9J/xYO5cZW6o=;
 b=W4vQoR8TQewwC//y48pTJcluKmH/rV1mxLCfNh+95QIMhf9lvsjvsFwHVGnNStW2IA
 KFUHJh6bPlyJTgAYtE0/2OcTre2gGvR6eheDUIdMTI3jNavppourA5Aoe+GsBpyuqjW7
 NvQGtUb6jMSkWvViaFTbjftiWxT7XWKXDfD9iYkfEa+fGS7bOPjZ7GZw00Hx/fnORDVN
 G77WJCThXmQn1qkxXiEf0RHQjrQ22d3ZzuXILd0NtlosmPjMig+N0IA2gaiCwuIoqVoi
 fYp393TG+z02PfpKpwcfxa/zMvT0AY6lnjlg6FErISu0Pz2e2Xz62PyuijGhSVhCOm7x
 jODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163285; x=1792768085;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6a4fdkVXMdvM+pndtBwJsLK8WYKo31r9J/xYO5cZW6o=;
 b=HjDA74321/RYW1e0RMYNaU+UhvGOZyEfUP+QFDW8c3HbKAeStCWVdVm1uUucCYwoW4
 HpSw2P7kYHEVwy04+HqefwmKWA32zYQplMn6gVKjiMjYa0TMFIqdskUqN/ZqnxAiog32
 4dSl2cGRAP/hMWwcwi1cMximUWsQnm8fEbeolk542b9OJacGW5gZQCVBF+CcoU9SNNG1
 fiU0TpvVIOWiMAUO6jRXvZqhP8mBOckr2AoBplqiXYyK6cGmt7GVkdnaeDSBI2D7hq9g
 B0cUbbd0zZjQxBhpOFmnoj0c0HhKOLsYO3/K6fUNc5ZsHRojvkZMZg/8f5NAnJ1j6J6m
 Pr0w==
X-Gm-Message-State: AFq9FYLex1+0SNjsOSVCZTUY+cl07TqEFP9NRZTcv5txsfHs9uIpAPsU
 5N6h4bhSKY2i2+2L2tlMwhUTTeDBNhJeCTKwcEnkd+r7tys4odD8JxzmZLou3AQAi531RaBBaEc
 yYnTB3a9GWfq3DwiCrP//9lq7hn/ZSt6esZciOgy22Y0Uz90IKC9tYQOzqEfNRMPJgL4H/179to
 WNZIO0CxGx/xajzLEbyUOMQw4sOzPkhFB3
X-Gm-Gg: AYBFou07ir836V0r/HTeBl5GEXSoqxFgFsU0FOag68fAYwyd/DbzfG9zSClwh6IrQHm
 sKqRz5qIrCPDdDIJoFdyDFEfqM8oH7WYuAge8eIwHDhLAtl2l+gfumVlwan1e8DgoS9r0BEaVaR
 Ee2WrxvwQ7U8Cd9yFa2xCSg4p9dphw1uCNNv48vjuZu9OWop6Cj2ZYwZf7YLaM7/WPmUDyDfH08
 EcicuolcebkzbVlBpo=
X-Received: by 2002:a05:6808:4fca:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-50c51bb6623mr19732681b6e.19.1792163284539; 
 Fri, 16 Oct 2026 08:08:04 -0700 (PDT)
X-Received: by 2002:a05:6808:4fca:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-50c51bb6623mr19732645b6e.19.1792163283893; Fri, 16 Oct 2026
 08:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:07:53 -0500
X-Gm-Features: AclHuK9p9jEWWVNfRICxU0t3fedVboIGOKyP8e91HEshAkHGfmxNXdE0gKy4giA
Message-ID: <CAJ+KCYPVSqTuh5zO=kw60Jh54xQ+eAXLA-U_p4ZmASf+8xjAug@mail.gmail.com>
Subject: Re: [PATCH 02/12] Hexagon: add v85 CPU model
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: n1SE2zaR4pV8HRmVkTaeGPcDdhe-9Ygh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX9Qpf0DphyFoB
 xCBd7vRzx39JJVcFOM0m1FKxM9RJYD3N5//XiTV59jMka/Vu5fmw6qFJom5CbLhWxyXsRTUT5fr
 xklUJGhnJGohAZzoMktT41Rbr5e3gAU=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad23dd5 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=wic7VUj_TNXuSK0r0zIA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: n1SE2zaR4pV8HRmVkTaeGPcDdhe-9Ygh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfXyzDqAMEeY9aL
 dl2KyQaZ6AYepllTWSuOwc6YMEH2dPpdWijYZLCEmSwpJehEBMBwPi6cf9p0R1YutCZdIRincB+
 YeJoQjCse52kk8N+PoQdcydUlwV3YwJCNjW/zF1UClxzKoBIz/JI2GNQGfCsJ1MGfTZRm0wiR7c
 5d1P0pyaXPTwUcNcdgkoWNQeCGBGMLNq88R3FSkd89OVGeYxi/it84PnRfuBtFenMtxRTmbcnmx
 7S/72asmKmyeWPW3jL1oRTcPRGL8S+8KeqWcJQM9qrRnECVpQj5lhNRS3viT+mHgD3ZQ66D0TYz
 UWfTxo2jYt0mIxsvTkzRDfIN2mMUpP2viMogBTEkoRGzdKzNLhNKJi4kPdVIIpyEQ+/fAbaupIz
 yik/IlFlykDAGkuTwn+lNWR2bIqxvgpXokPcn9TrNpc0aqFpP9tWWeS1ZgCvYnnrRn5XpqxqfI/
 VpLRmp/fch6nnvlk5gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 2 +-
>  target/hexagon/cpu-qom.h          | 4 ++++
>  linux-user/hexagon/elfload.c      | 4 ++++
>  target/hexagon/cpu.c              | 2 ++
>  4 files changed, 11 insertions(+), 1 deletion(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

