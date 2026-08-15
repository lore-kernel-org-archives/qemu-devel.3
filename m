Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794ADC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFC4-00076z-CC; Sat, 15 Aug 2026 10:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFC0-00076P-5B
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:17:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFBx-0007yJ-Hf
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:16:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMIVt1712610
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRCnzRR8/NWxlAyLdSbGa3NplnN79DeCIhfYW8PDkNY=; b=CjP+W8W6LTuS6DWj
 TJuPuTHVRNAcsJEsTiiPzIxLEFO0cavwVgV55wyBur+so14xRYxsBJADlkSsS1ot
 UC3B0aMSB+k7PobdAvqkqpcc/jU9t44E2ZgKnOqz7tP6U8XnPduqDb51+uGgv2kG
 IQfQGGJ0Hu9P6zDMwtg868YqhxZ3MsSF6fZIIn8bdlMzPwAP+eoomSXSIZjzVtL8
 nJh7xhvUCw4J6IM5gBPixd+MgVzI+H0C5LEt95fnpC0GnCkJcTv6Hq6X6x573ErZ
 14xvu7lI6pA+5JtTAWgr1vCvoFllSc0n6yhntfnUGsldR15LDmXwwoA9PCAeXb7q
 dagWew==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf93dt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:16:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52827090cc5so26406631cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803414; x=1787408214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRCnzRR8/NWxlAyLdSbGa3NplnN79DeCIhfYW8PDkNY=;
 b=LbJUJZCEXUXWxFTDGHvZKTINwQeieHgtwMJDtcRdL/2Rj1UeEkgD1KKvbrmiSHEKxw
 vPbZxlXZYFxLi8ZGZukpmA6E0NtHn8lCaJnWCijbqC/0aq6Y8KnHKO2xRoMBZnDAB6rK
 A3L0j09AvaDcNVOqz5sQGGc6gbLi7+EpCO8PXV8phoD6idcqCOp0TjCQGHCceGJ3R87s
 K9WIiLqBd5Dgff1eYp4kAN3iuG97sa/dSlytZhvqqK5+u0JbBhz76zYrJZ9EiYhKY2Y3
 OnmXXKSnEg377wwltXuN41U1jG9DntRypETRtnyOKPOqJs4pXsWxvX1CPwiMC5ApcqJg
 w8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803414; x=1787408214;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRCnzRR8/NWxlAyLdSbGa3NplnN79DeCIhfYW8PDkNY=;
 b=NRWYLWoexS0U5sohBMku6QC4BolsEGwrbxdr+vO5PV4GZMpvPT39PRoPl3ehnntoqN
 t3mpJdr4GPoShnRoiEH+GD1kNNALT6o/UOKhn12K0XemAJLrln6LqHzeKJHhQVnIR98u
 o0bGJfJ4kx+ZEYsvXbNhqRsPvEEArCGjcYrwd6E7mRGTTjRNSlarwSW6KD409GVSw0ir
 2G17vKAAbFVAsetvLLt0SQD5eDH68yHNNIadW5Rt5jWeLQRlsFXNE9aJseUW5oMTzelR
 JkzrDvqpuGBgH0IZ1QuK4PCT38c4qyFvQPo/j4evPpkQKLpNpReSgrVxZ7DSoMc9hISF
 gRIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9zOJJ8p1ovRrziDcOQ10CxmquiX1bokqEsz9bZw5Xm6+953pPZdzIP7Si9vOHXi0U3UX4qZb7y4hi@nongnu.org
X-Gm-Message-State: AOJu0Ywu9ARvFxPsWfNyxda3paceFuc8Brez+XtQoqm0uq1f36thKtwX
 xbfa+AeOd0fWtnl8nw1Oeb/z7stDLcGOaYyPt5ZIzyxm/nEcOUwhYnIOOWfUHx98tRjHsvAKydm
 AZ6pOPBshCN9VCF+SCcp1KN87zR+AEyEoKD5CaE4s+FK96rwqYsVM++kmyvjxKv0Ng1uG
X-Gm-Gg: AR+sD13PkLmHvSk7yqpD3GTcE3UhcYPOemYho+li9WJlNl9uxBTxPxXiTV+tTDEwFNn
 0beEtnBqlctZpHZcKfAKrLhWhl8O0QX/Jtxx9mC8VyN46o2vhqJfRy7oquceQjeK8I3rmaGBcaQ
 ZrBu8FKTeVbbAeiUckFmNBbiAr72ugUWjgGvSeNEzwu093N9lsb5DuPAK749rRYoT1As5fXkndf
 Q8BWztYHwwvLkzOOzID5zDykqRacZLoGWHZ5E6ftfiLl2l01SOvCI755QW7oy6KG2/4FNUCiPIe
 3zHaoddmP5IokOELrFkzNmuntUIPbczqNlZ6Xq3959nxqhbtu7OQhfiKKe0ZbZ5JZpYy4Qxn5hu
 bHCCJ6Y26+zbPwbGiqbm6gArzy7oFH1aDLKI=
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-52d74a6f672mr206004521cf.7.1786803414449; 
 Sat, 15 Aug 2026 07:16:54 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-52d74a6f672mr206004101cf.7.1786803414094; 
 Sat, 15 Aug 2026 07:16:54 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998777a4bdsm108004105e9.0.2026.08.15.07.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:16:53 -0700 (PDT)
Message-ID: <1828bb67-42f2-4e82-94ca-188d52df5503@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/26] hw/sd: sdhci: Migrate the Host Control 2 register
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-8-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-8-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OZ6oyBTY c=1 sm=1 tr=0 ts=6a8074d7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=-1gOtglgg3aORyU6QAMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: H6GgcG0Qs5aKJ--yxDJAPmQWt44xz1Bg
X-Proofpoint-ORIG-GUID: H6GgcG0Qs5aKJ--yxDJAPmQWt44xz1Bg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfXzNLDeROpMZuK
 FLqB00rj5LZCcltLxaLpWbI5INaEU7cpDxf69MtQeqSDlD9qXJCgUPBdpTjbEJhkHG6zk20rVV1
 p8RXuF8AU99L5cUH7MbV+6VkehxqhJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX+RGn0m9bMQ+o
 7Hf17jyoEKRZ7a8WNNSAFNUQR/VEM50Eo3qwedygG7+GCNL6QTi9HP3SG0cY7U2UrGZxzjURpTF
 i4eooiaDZx+qyxvhXx+u7OjMW0LH1hRf24lOsb6uXJes7tmzFb+kA7ivOeuA48li7AMXOREjenO
 OZQxQsm5pBgN7pNKOqN6d0UL8KcwS501IbB15hIWm9mKOsy6Ks3ckohjYfXAUueLimDvkWuHKGs
 ZDXdRe4xwXPR3lp+sqh1sYbgmk3tXObdBLdnOOZrZvcrpLD8Ts1eNFpG8HKkhVo62EXQRQenb++
 lo61EvuFAMcgKFUQHOWKLIsV3MMFRve75qNH6bJRym4ck61ayiYeL477F5lg/qOuH6SlM3T5eb6
 mQxiEEAP7oY32TBy8tPnJfL8o7lukwbQBNKYbQQXkWDKlV2fBCsYoruRPRBpmZWSqIv/Z5CfgpO
 jItdVKOh9yTEZSp6fHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150103
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

On 23/7/26 17:18, Bin Meng wrote:
> The Host Control 2 register has been part of SDHCIState since its
> initial implementation, but it was omitted from sdhci_vmstate.
> Migration therefore resets the register to zero and can change tuning,
> voltage, or DMA behavior.
> 
> Migrate nonzero values in an optional subsection. Clear the register
> before loading so older streams retain the reset default without
> changing the main stream version.
> 
> Fixes: ea55a221bfc0 ("sdhci: implement the Host Control 2 register (tuning sequence)")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


