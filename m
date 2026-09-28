Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F08FCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB88z-0003j3-Lr; Mon, 28 Sep 2026 05:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88x-0003gJ-Bd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88v-0000Ju-Rd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M7dZ2168087
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 apZp77BImyWkFiSGUYXG1XrW/8Q/Whxs6ZT8XE5suk4=; b=bDDMDnYzLz13tpH5
 TDmxUbR/KNdn5m5ctQOP0z9m+Zft3TKYTVIhrYfbXjwkFE4GvKNzILhPDKDql+Fb
 fqd2I/tRYvvozlX53yFVPVEG9uFr7EV4d1ENrVVHjeCfLgFV0msSP6qyZTUhRLZ2
 FQ5ibgYg9+1yz9xcklpqbE2PKvEBP+uPTIhwh7OQd6hRNYU2p6KHLfWnC/zoLzgR
 tZqPod0AuTdCNjJ6ht1Vc/1msy7+0NVQ7k90BQCgG4/HFjFOZ5cxH6ytWpZEav9N
 onDu140ZjJiKBg65uFpolbpf2/RGzpJ1TOgWKKM5JQbH3OztXXrKVfgsvbSPY56K
 6fAzQA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1005-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so586311085a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589566; x=1791194366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=apZp77BImyWkFiSGUYXG1XrW/8Q/Whxs6ZT8XE5suk4=;
 b=QzsDcarYSLIhe3AtjbSCFoNHc6lMtx2LW+virB4lAS/fuoPAMgIaNom/sNY95oBzaK
 Bi7Qe/hNQOENsVqXhlFSfayQgUe9COg7amQysi+ZDSjFFu0MbW1HYVUWkJ+2YN0cWnIa
 qPuioBA5PVKU9Poj5/fU0hd0UjnzSla1ffodQRHFJkjmFqCXPgo7jV/UaF/ZjdzwvQbg
 lhHkGXE0p44QFX8758WoXfh9mLo88Glsk9D7WNDqwN7liZpQHRueGykD5Gc/dLRs2Oxs
 YZ9CvIlGFs11hgsImN7PAiGM8qarXjxApuVoIMxpOHzkWK6pbLSL2ikN4XQ2jP2jtkPQ
 oXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589566; x=1791194366;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apZp77BImyWkFiSGUYXG1XrW/8Q/Whxs6ZT8XE5suk4=;
 b=jRChV/KShw012HGncnHhQpGCu74jENDwK0QchDpb80z1jl6duv3OLkujQNUwe/2Jul
 VtRqj4+wMeCT//vHc3qQPGi2sjWUKB90Fj6WjA/HgEKhuUF0zGlvMm807545rXr/aXUi
 SoCdx0Iu0xdqq2j4/CM8qMTzi/ocE2AIPvVWaCv0hCrQ/9KGJ3gl9hxoJKihWr3TnQ8e
 4qvDQyByfGsaC7XTFEXe88GYfkLhARQpKMjtKRg/fpZDlfSCJ5Lv1Hhas6BneHfvDYsy
 zsN02zqV2kUTe2Qw2Zet0tzFtxsik0kK9tWPcRC7/iSTpywsEr1tMgwzRai6i/Nh0Z1L
 n4jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz59SVFj+ytCyn72WS9zUvV667hN33EXcMBS3pW7JMpIexeUa52/+YQbK53ya92b9lFp4VFnAsm+mLU@nongnu.org
X-Gm-Message-State: AFuF++mv4m8b4g8HmZsqD44KzIEacJNPppPgt09AkuSDk6q3E9pReDme
 lD9JyPJD9VxcQs1j4S/SIXAg/EYTBeSi3KruYgbGTM2AoBZXPEE1zp4BM+BkSs7fji5JCiAjW1W
 DyEWLN2hMXxekLgXRdvKCz8QtSifpnI940GgZuaQnr7j+1LRadPsl/VEReg==
X-Gm-Gg: AYBFou3sA/NVmclJlNI5SjcMbKdlgaiorGT45rMPnNbjdZBAShImzm1RxFkrseCoG/S
 mLfGOATYuElGN3+/Okl8WKuqbwqVDINQlev0upKAgRs1ULDsJPqzSv2ZrAT+41mPZcqfL93t5mI
 Ju+pwHRkrWXcBQFBCOFYzJIa2duJFX9yCDCucpJGMPpYa3zU4ZODbZBAJz7PFAA6OKyNzetFS9Y
 Q4a7CYY08S7daH5jwpysliUjEgOixxHaKix2tjR4mBXwxt68UqHvpv+F74KIXt4kp8zxCnBgSgu
 rJHVPfVvUi8dnz8WzqiSRNZwsQgxjocGD9Z8ouzMlYSurLIa6Se7w8Ff/w39a4ZMftU6x219vox
 KMkJdiSCPp9HglbOTn7n1kviz5FJdEK+kOQ==
X-Received: by 2002:a05:620a:199b:b0:93c:64e5:f6c8 with SMTP id
 af79cd13be357-93c64e65a97mr953997885a.49.1790589566554; 
 Mon, 28 Sep 2026 02:59:26 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:93c:64e5:f6c8 with SMTP id
 af79cd13be357-93c64e65a97mr953995385a.49.1790589566159; 
 Mon, 28 Sep 2026 02:59:26 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f3e68sm127647935e9.9.2026.09.28.02.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:59:25 -0700 (PDT)
Message-ID: <8a98db26-47f1-40a4-9eb0-d06d9bf495be@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 094/101] tcg: Generic expansion of tcg_gen_st8_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-95-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-95-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX0DAsvKj5ZSJS
 IgxZs/xtrdo1PxCAorP4Hwg76faiIRgi1x4nxlbT0ZdEk6k3knFBH8u93W7ChUW6IF/5kWSnWT6
 SvmIZ6BhOfwlLMBZaHJIaXPlGsFbsuKXcybGyHMvvpQ6tIqdTwMo2x/ePAZy9v7fWB+n7HzFY06
 ooJXt/XO8MulFwX9SBpSoRdM7pB+aJw4dNx4NQBQ1FjZ0NYC3EKLvDpiCAXt2wNge2sT6JLj8SS
 nH7pPTg+5/6c6iiueBLSBnkPVldJ3aOecVQ7XI8wIYHY0ToEkT9v34PHBz9QUQGQoKDuZf361C5
 q5F2MHJSTswf/Vdxf2myBtr18i5ZtykeVFoDWtv8TUVPsTMjfXgsD/LByGm1rMXYaMu4GIwMW0Y
 d/XlJQAbJhvcPNrT5Utm1nz8m/UmL0jvRA3uzOu01EiDQ+zdcgqE85a2XUCWW3d+YF0+ci+rbzJ
 Zqid0QbCCpyB+e/EyBQ==
X-Proofpoint-ORIG-GUID: gxULhjtSKaBgAgbgUYVKHIVkGvz5QYlB
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba3a80 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gxULhjtSKaBgAgbgUYVKHIVkGvz5QYlB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX2cIEFqG1IPiJ
 iEkOnTcppzJpk0GioepWHwXn/aeKNfXgat/4q7M48uCiRG/ixHQ9GHRe1KYuNpWcNGf66nhZ2nM
 BrrzLKdZ1krIrdOT7kInOB6tVRNYbUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

