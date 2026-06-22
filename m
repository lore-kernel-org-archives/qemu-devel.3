Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79345CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbli0-0005qR-M0; Mon, 22 Jun 2026 16:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblhz-0005pk-49
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:57:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblhx-0008Lj-Dc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:57:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaDXA2101410
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6sEmIGDxcjrioEYZQnPayUyo0QDkLrrQAM7DU9PKdk=; b=M81SE30bUlGz17yt
 vfO7e8IxUQgNWo/WZfFz/JlRgToFSzawnBXVFhuPSfArWenBtcSafBTySHfJoytB
 JI9AfK5mwxMPgtb2S8MouATSB53y2PuFV02qlQlcO4GTTPDsM7uOPhNYUIgDMrg9
 FyThrkPJImeC7DctInAgRg91vPnSFucbvQFo6MYrcnAXSbHbSYlKxrORXVcV1VTa
 hPUtdW4D++IGxlxZRZ4+UK5J6Dfiy+2q45V3dMCOVUEmpbQPq4NhEWKhjyMZ6byZ
 Ic/qcRS7KF88QgvqtCd0CintRJ4amAApkjf1jI/FHQumiFCA2Et+HCmXn4oSa2OF
 mnmbQg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eba6ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:57:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e3ae05d649so7360016d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161847; x=1782766647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l6sEmIGDxcjrioEYZQnPayUyo0QDkLrrQAM7DU9PKdk=;
 b=kVtyDEvRpOxzaVSgxZ1P6pEObxRbTNGW2TMln6khKSojEKNg5D+4ENbQcCV7djFOxT
 d/KUg1PD0TxmoLpETOzSGeyPhUsi5+p8HZiicmtKxIjcq64DeyVK6FrQkb2I//MGEUHZ
 D5AM+rZww/4l8pUR1Wy0s6QQRIxCSp5CTqQpjAFXzhHV951XoCWsCjqs5ziqlpehXnHW
 WfWeavrREKKuAQ7XUszEzCLTCxudPJFJ64ePGbuvv+B1LDx6vX2y/sha0NKliBQOjola
 tD3BSa2OkHz2ikecNms3M/pta4r8TDAs61OtGSFTPqrZ+L+7BzsMbbwa1og8rr4AMjyr
 8WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161847; x=1782766647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l6sEmIGDxcjrioEYZQnPayUyo0QDkLrrQAM7DU9PKdk=;
 b=Knurl24dNdM9YbQ5o1v8CzX34Z7hpcazfWG/FhXeENzZeLeqESv9aYDypDR74EWHFQ
 pT8MuBTwEyIr7m23uPBoVp9B82UPVqUeiNna9u6i3ca22dqPBLuyf2Q85NvCZH7BzURn
 cM3tRPrqNpuYsgO1rb1SUtnQYMTW/p/wfKQDlD5VLHNVhDiGFJSurfIhZwOYzEPzfRai
 pwzg38stgEBlIkcfaPfUXdEkwPh2kiEyRwX0eu+4Fwv4FAErxE1BM3ma+Bu9bIJbSh6G
 dKTQl1QZ5rchkZwa1hkIkZ5KClrGDDM102xlY0qFNhGMHzUeh07knmf3DfuYAaCaBua9
 uOlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zoHpH3qApkfKR/vMD9g9DI0+GGuIGqXRcToraVEMB4Dg1thM+LoPeLme1SHU+Vdzg++B0nHlmmoNL@nongnu.org
X-Gm-Message-State: AOJu0Ywc3S0keFULbSqN0Fh2s+gVJuv65d7ttQ8fm3WE9J2xbp6FNXo+
 MNNynmpsPyGq6TTnbxYYpk/vlESY/DW1eRjBencdHfJZ7qLohvkkcC8gPLbiqnP87JOv66KMOdd
 nOBE9eSSkxa4ZZKybF1T0CkKairTpnV32f53VXhhMpkruRTZZ/nqlL8Buog==
X-Gm-Gg: AfdE7cllSLbDNk+3dTvr7GBRlEmjqbVsDg+FxcmuBXcGC9sYY/VIQW2oiOy4qbflQsM
 DhhnvR3TkepShXzg21lgBfabSPIRL8hEFEYjhhl2q8b/YyXICk9eLKEn5tteR93d+QacENNqCZt
 f5j5z0gUQMMYvuQFweTdb+t67psQltPnlX51nypE6x7MguBfc1ttUmH5fZWqM+KjNV6tD1J6K/p
 Y7BHWIJpCHfGlOdg2CKuPxMfrcZQlu376ek4GTJosNcsxWH6v1uQrxAtRNza953od41jCZw9sJc
 anZ9YHUeprEoVhff+R2uXcfjCNY/ZBBhEHSYelP5gD/VwXXiRPCpKpyEDE0/aScYCo+B36oc2Yt
 AW5WZwWINMgfBZZtEn5gyRRusPh1XBlfzx21mlpFoaTCpq836eyrvMS4grHZscg==
X-Received: by 2002:a05:620a:4116:b0:915:cf88:1e41 with SMTP id
 af79cd13be357-926482d491bmr19720385a.45.1782161846780; 
 Mon, 22 Jun 2026 13:57:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4116:b0:915:cf88:1e41 with SMTP id
 af79cd13be357-926482d491bmr19714985a.45.1782161846320; 
 Mon, 22 Jun 2026 13:57:26 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238bfbsm253475405e9.5.2026.06.22.13.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:57:25 -0700 (PDT)
Message-ID: <a0e26bdf-80aa-48d4-bc3f-75dfd35094c1@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] target/riscv: remove csr.h from kvm-cpu.c
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-9-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-9-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfXz2Rq2a2qNH17
 xuqT6bKL9VGs5iriuaP21jvMu3aBW5jkuYllFThB3nGJDR0hx/yfvUodajPLsDw8BoIfBMnrRRE
 pHBuOzXAswlpuocytHEqOv3X6eMuKNs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMiBTYWx0ZWRfXzxDkRyPRkh7R
 5wSU2urnQxXIyhPI5Q8BByTIR6dHPnUapVf4W6t9NF+/3JTVkT1bYJYXSxtmBA+KI8JmrJdM6pf
 jItw4/zKDz4eas4mjYMMLWI+GgNeLVv1pxirll5wU5mpF7YypVTChCTKh/N9S4MT3KzPh7B5Xgt
 +QxGe2lvxwC1VB2PxdWqAFnS9z2jpSsqSy9a22Eptif8yOCtFcjKxC100E16Gk8Mir4endI3LZb
 qc9kR7NR8GtHxy1PuYGOUUE1zu/Lmjk7PV0iFAFKE2/h0pAIv1nd9dE46WjCMC2sMxDbU8EVeB8
 XWlXCBZ3uCC5yboEUDHSJrLC3t+xy0pGEvKt8rbAOZ+fh6ydKiHTwIY24V2gW9Sg3+5/dRNF+qL
 65cgatHGRWomGbT2EzCTd7wJOuuJBv4I3pUQNIOHbv0UsTNvhZs1ewkcCT+cIpFs7djtqXPXq1R
 uOUZIjFHp0ZDwieHxKQ==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39a1b7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: EqPjNFvQ_qLnDPPesyjcUN_V56Czz3bj
X-Proofpoint-ORIG-GUID: EqPjNFvQ_qLnDPPesyjcUN_V56Czz3bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220202
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> Move riscv_new_csr_seed from csr.c to cpu.c since this function is
> shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
>   target/riscv/cpu.h         |  3 ++-
>   target/riscv/csr.h         |  3 ---
>   target/riscv/kvm/kvm-cpu.c |  1 -
>   target/riscv/tcg/csr.c     | 29 -----------------------------
>   5 files changed, 32 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

