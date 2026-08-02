Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA36C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWy3-00083G-H2; Sun, 02 Aug 2026 10:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWy1-00082k-R6
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:15:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWy0-0005rU-6u
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:15:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6k8g936600
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1feKRPzLuQvSk3voXKwmeUHZznGRdJGA49q5vNjZdfw=; b=oEjLOt3BL923EHSK
 Pof7GEGM/0pAvW9Y4hD9eVTioLknUTJe8ozLAj+RSV/GliqhBvNgA3nnfek2iaMl
 WyoYc8glB9mOFRa9d8f1rywHZqjO41hyebiayGyVLBLNQzGkXu31Qs2zstwaUuD+
 40GsYJBay87Hekfqy778ehveyc+yYmvDBCCNVncoCIzn2atkHfbmpIyhIvtKrNRH
 3k4dsxm4vaIZnwckFSPRCaCaIxeK/kTljWCcaj+vWVzZDZIkl59O1a2s2CprCuUc
 UMNNXFmav3JzVvS8a729aVMYow5W03nVLOEuq/SPH2jeKmonv6pjz1XUauL5VIJ2
 mgkAcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9ygjs2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:15:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso18781841cf.1
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680101; x=1786284901; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1feKRPzLuQvSk3voXKwmeUHZznGRdJGA49q5vNjZdfw=;
 b=QNK+GHJHuXdd9OyJRaMDiHb3XpTm6LDqAtouwwibEPhTswbjHdkm06xty/FUi+dXYd
 ApOWVdg503VmF7WbHmdZO62njxShgNpkVUKJh7yi3K7i/0C+HHr2jd8G7ofoGrYBiZOU
 rNTnZzV8cTnvSSe/O2/YPYGgv+Q62PoHyQGS7Y+kq9INQb5aeQ3COupDnI+UdPryeCnW
 gloehef7cnmC3MDpjBRixPm89z0s67gvSRY2hac3vFm3dj050yH4jUYEudkY0oRqFlP1
 /ss29kbA5q54LMOaXQYbSn6vu/KMZTyCQtCr1Zv1zRZxVN9r5LKFHvpsRhjV++BD1aRE
 VJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680101; x=1786284901;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1feKRPzLuQvSk3voXKwmeUHZznGRdJGA49q5vNjZdfw=;
 b=NecxsyNgsRBZFuP2CC9Xb4XTuGNhKboyf+4W2UqTEWxRNtYGHAUf5rwywwtLPV1O5i
 avbfTlCcppEQG+h9FvQJHTFHY+1itk1V3pOLugOXxgaByeSivnHt1LRlY207mpBs74pU
 OQrx7ee7QMQ4tY43rTDJa6oS4KeXOFuzij5/XXdI574iYjXDuSdPdlLjAWOrAtWJq5UO
 HHRHMaZ/1p6jtU8Mg65Lns7GGsuvlcnv/XxR9Sb0q0IHmY5z3Go4frUvNmMZGI3+aBTN
 nbJ8Os47fw8Z+xvLqoi/apCKdk953D2XFOo7Vo6dtC9LEVwqi4PvN3YshxZrXi8930cF
 nWWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFk7MvejdM1z3q2H18JSsJIqjrXDxm4j0RB3mo97aPclF9KLl5HOQG+PThguhJjpTGse/LtSfPPZVN@nongnu.org
X-Gm-Message-State: AOJu0YwPELxQb1/soQilDE1fGI3J1WGS/0WkyTQbChLlYd5Dfw9vJcAb
 ZYVHIXYvFc7fDVymFOV/XTEgKhoCLuWPCXHul9RMdtIMciIqhxAiw0irVpdaNA4rwRj/28chGuA
 Vn/hic9hDFy1+ao/p6Pfzx+TV48tr6Pl6MHJbVGFzxAd6frKpe+O61taqtA==
X-Gm-Gg: AR+sD1166g6LZ1RNUSJwaLnZI/IlwcS+D14eDxg68Y0su5ZjzQuAu8GI6kQecllGwkT
 KCWPEmePgTtru/sznILBLBSfje0NEdv4TxpJLDcIz+/v/LxRbRG1YWKl+WWelG7JqCUPNsaSgVR
 NGna7uaCFLXgULP9CIVGEc8m+xkkYQx9XIk+eXEB0mrV/LV3pAK7jkV6J6C5n8zipnuTFSPdUKR
 FHA+krWywKU1vmY3QwmivPpjVKrU9ctcCYbJ2bYsuki5di390Md0itLKve6e1umFFZvCic47KvZ
 SIevfQF65vAdfKpRy2pH0JbHyI/NaSBK1uR7htCypjsXR7tgu/DM629OVJfXQJAg3uJ7Mmzu+ih
 TNcQgnWmuU8mMmSXi/T4QTo7MxFGE4BQdwrY9fczxB5pmuOfibJA=
X-Received: by 2002:ac8:5f8e:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52b4c431726mr137465301cf.1.1785680101216; 
 Sun, 02 Aug 2026 07:15:01 -0700 (PDT)
X-Received: by 2002:ac8:5f8e:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52b4c431726mr137464571cf.1.1785680100793; 
 Sun, 02 Aug 2026 07:15:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm23431952f8f.4.2026.08.02.07.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:15:00 -0700 (PDT)
Message-ID: <e481f1cf-93c6-42a8-9f81-b94ab0a82e8a@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/s390x: Convert op_ld8s to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXy55djbPBCKTk
 SvEPKtHPcEPjvS4LAod0cf3aE7f3pPiosLtQWkELyAiGHREp7pe2Nj2nhZU8c7CWzpt/ZQqyWt0
 uF3prwpagQB+Qfr1fwiPC0vQdaxmdeU=
X-Proofpoint-GUID: qV9n15h8bfsT9B96eqb4NR_D35TcXxcN
X-Authority-Analysis: v=2.4 cv=Gu5yPE1C c=1 sm=1 tr=0 ts=6a6f50e6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qV9n15h8bfsT9B96eqb4NR_D35TcXxcN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX5dKbHWq8yIiU
 3bj5MPSMOyBrRm3HOALT9MM2RUWhtbjDy8kQ98GIJlbbjdRqYvF/xMIDdFhLuwIppBjob+ASQoC
 gfKmHZpyYoQmOumt5aROou84XXIVrOCPuS1T/hiXQjxeIcgafK4uoysR6gwWdy9X+ALi1ju8hRa
 YC/r/Gw0dnOF2UiE0WAgXJ7XxlXo1cc7b5KlnloJOORY4W60ufKJJdJ5DqybhBABsvSOWecnmHt
 zADZzdwWBGFXH/C94WDQZC9Hgnv2dqruRduyMlIpF2bDWcFrz1g0anlbg4Ii5W3QiN9dQyWZ9r1
 WaWvSe9w5FJbUYxFnWrbeLwhY3M4j32yqAZLNuZqTNh46uehz246ie/BWxG05hKxZz4cR2YpyP7
 Q1XS6/Lcn/GzoDd0O+HZ7RrAHo3kDc91jNepVnOGOu7EDj6l2kxQYSaTTJkx1xEUD2zsFnYWqqv
 ZM1a72ZG924y9jGV6TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020126
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 31/7/26 20:56, Richard Henderson wrote:
> Begin unifying load operations by storing MemOp in insn->data.
> Start with op_ld8s.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 4 ++--
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

