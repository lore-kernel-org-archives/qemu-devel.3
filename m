Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F65C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgGC-0001BV-99; Tue, 11 Aug 2026 02:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgG8-00016t-CY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgG6-0005M9-To
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B6e8NZ2995721
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G9UdHJ+8suzK5KA9ilwPkOD9cH5gd3knmz7Hu3iKUmU=; b=bQrUQES4rTnXuuXP
 DJqXEo+mjaFvlUpyDP62+lrVjTsGt+wY1r1cKATxzjvPTw9v47Ky7Z3fVJGEBg0i
 uaPdJiprkr097GZ9VZWpaYWBzqbRJbzOF+s5x6HHi01xeTjaKYxFep3A/pfk1Tq+
 pwD7Eo6PcAHy3xIv7u6U+uXfApPmiik6BbBObqhu5Vhf2LLGJ1MVlEcSwRFUtuje
 ZLOLwkS8zruRf+SXyT3dJNFHK2Qq0cuzX2tf4MS5q3P5GEH6Oed53JZc7+Vp8nds
 9qVpzCD9ImexMmx8z3OjKLUhTHZ0VQFPKnXHjDRlzYddd1EVtn8xG0KZY47UOk8e
 ++3j9Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf2nx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:46:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso46871281cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430805; x=1787035605; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G9UdHJ+8suzK5KA9ilwPkOD9cH5gd3knmz7Hu3iKUmU=;
 b=gsO9hhk2cy5TNd0LntKI1QYopsPFobU5QgMaCYp377JdgGZPTNW/FUqLBzZ/14B61I
 /d4Yw390RjcxN5fcFNPiECResncPtE5pz+QPL01TfyGRFi+mOIHEXJ/ybH1u+rOqxzsj
 cdc6Vz/u4PmMwBC8dPscOoD9LgWIP28TTjNgPCiVH3QZTjEdCtS0T5lyVh0e6iB/xmp8
 hSVszUxT01ZXqYyWO6OHm8dz0JPM6olf9scMxkDCUU8GVpEep0jC2ApEHVQazaXt68WU
 axoPwRuun4LZaGSuKTvNpKaet0VIER04AmkJ6MTmdsLVqWpNSrOruM+q2zofAYP2vLZT
 lb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430805; x=1787035605;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G9UdHJ+8suzK5KA9ilwPkOD9cH5gd3knmz7Hu3iKUmU=;
 b=EmzvtHjz+f2gQyhXgcX4LjQ0WHzdyMNztoYR4yOx5B1CQg4mvQ4QoSZW0+gOAXKQlb
 rBA9O2LcU96ye4oY7rZbVU3lse7wYw3/HifXlzTk07lBnN7AAagkN8vQo1PNIag5yw2u
 CLJb7pUBzaNvWccuvCbgqAoqB6ACPhi4+BZIRDt82lsg18xPYNtHfFId5PFuswc0Pems
 4EYkiFPIHodKjs216BoNsDcoAiJIiE9TKbAp3eGXVMGB2GFTjxSl2v5VqIR6gT7nXMvs
 86FrFfAAS5V9w93PVtzfRAzDQQACbIqj7g9qK527IRGa0tlNsvDSuM49xhrGdNRUL/TG
 81fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGBjfZk6/2t28TGyrs6rguzJW9McC1MKqfhtY18vlRmaSYOMKxto3YUgs1wnroXcH6NMlO8ReqhRzw@nongnu.org
X-Gm-Message-State: AOJu0Yxm24giN4/evCGMGuM5uTCvb0gc7rkGs+eXYMhiihugF83wnyAH
 F2VmjYDpeSMzIMxvBENp+4O24WEA+t52j3HgDv56Byn7Zl8s2CioGTBnxFqLdx3G5AQM/HKoEIG
 Id+lwRT0CgJVtXM0OixppEWY92d8iVQwhnguOp/AaoRYsch/1y0qHEOwG8g==
X-Gm-Gg: AR+sD12MDqHV1D7/jLnWgV+5Jf5DjFwyKI4mTh257a8UpPJOeEmStDQYNIE7aW0jnkr
 doOoI/wHTUyGGkCNyDFDQmi5a6VYdN8MKl2t9Aswog20gv5Pr4zGO/cgQ4dvpAnw6vCZqK0bwVn
 3Ak2TrCT6I6fa7+cw8FX4GtvAbNHp9gv8hXc0ildMUE8gDJYNAqwnHjLH+K8YCI27HRhWBPSOA6
 63Osoc/dW4TnrsQXftHbLnbtUUlEnanq7e8T94d/YSa7OobCxm6fJRh6gl66KzNqNhHaxMbOG0k
 ef6aOqRS7fedBCi68N5W4956KfhNECus3HeZWuI9Q7R6/BTzumcn+zTshDOQDC2nU2bG1sJAxPX
 zKioy6bIVp1vqetlNqkZBw7Ou07nfl5I/ySND4XB/
X-Received: by 2002:a05:622a:2447:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d585be373mr9890121cf.25.1786430805030; 
 Mon, 10 Aug 2026 23:46:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2447:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d585be373mr9889461cf.25.1786430804520; 
 Mon, 10 Aug 2026 23:46:44 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499740a6e84sm50798845e9.1.2026.08.10.23.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:46:43 -0700 (PDT)
Message-ID: <73fb7b44-ecce-49d2-95c2-0e38c5bf1c4e@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] target/riscv: Use generic tcg_gen_revbit8
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lUbMev2GayaApTvHsG0WdA13OTpAlkve
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NSBTYWx0ZWRfX1xhuWBx6F9bg
 w82Dl9zIiymDX4sHXJwsMtr5kDbIyKKn4vm4ee+eKPBE3Bjlb2IBdDCTu3Fsj0wKvAmktckOXKj
 BEiirZv9NltMhBKxYTU+Bik4rpOZNgs=
X-Proofpoint-GUID: lUbMev2GayaApTvHsG0WdA13OTpAlkve
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7ac555 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NSBTYWx0ZWRfX+O6aKJhC40vD
 oZtwq7YD3ilzdRvtGjMWMop9dWK9zmFNvokqRpJ/FHdWZqx7YvvmciCtEE0QUp54jphoXCNQ9bR
 Xxcm+5S9F/kx/UE+7bnqiLVDK6n0ixfOML1wMUl4xhL41o+TZLvMoy9hWAjarV1p6zboBE8a1Ql
 u9TVr3nyaNJFQkl8/t+xSfIDkdBSVmnEir/5Og/5iuJdRZIDs8Pkf78LVH+YntYVzTG9yvargZc
 udLuL2pBnFyu658/VZwn1VwT6KIja8ZzBH5nqqVJ/Uxf2xZ/16UhL98SyKYHzuoAp4Itd6F5Qt3
 vuXf8dL5/uEzI47NoEmaoUBeQZ6+vVxBw74G7i72g2mLijn1YJkW2EVW/oEISIfsj0vEJfA3vOJ
 7JaXfvEhxtZ4jiUgArrNWtyIRZ6p2StLs0gdH3HiXqSuTac/l3GufLUVgl9RV7Ki5MUirnAs3wk
 u2/sxjRwzVYdHQgJKrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 06:55, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/helper.h                       |  1 -
>   target/riscv/tcg/bitmanip_helper.c          | 15 ---------------
>   target/riscv/tcg/insn_trans/trans_rvb.c.inc |  2 +-
>   3 files changed, 1 insertion(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

