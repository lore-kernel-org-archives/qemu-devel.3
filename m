Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218AC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ckT-0005qU-GQ; Wed, 02 Sep 2026 00:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckS-0005qD-E7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckQ-0008DA-VV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68202NV01013564
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LUoGW0tpeQwL14K46s3nu//v6mVqyEZRrPoqO5sAFJc=; b=MyCcQ2qtBpL7Evqf
 M0iB4BW7TF2UhEqrafJuaW7/rjvdo35m5QEbky3e11fVjQOwLLqX6ojdCEuvVUhm
 Y4lp5jrbi6khBV3femDfOR365xPtmsr+jbSwDd2dV6WYSd3A9N3ASPGi3MHrYzps
 0YgNcYILbYiiR2zM5H8NWU5YDgq5OWhfh64LNz26sT+u1FYASbBHRTmVWj36nBAH
 /EbBqcKGmRN63n2ET/1jesPVpo44+YmSNooKAtXhwWRM9Bj0n+Fwt/6yKQ2pbU4D
 cNLCbvx18PRJhP64BBc2HXflsC/mI5MWsCTd8glvy5vDe0EgWhWt528cVXVJU9qx
 ErXNkQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge8whgs7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:38:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ef13b61bcso166074685a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323932; x=1788928732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LUoGW0tpeQwL14K46s3nu//v6mVqyEZRrPoqO5sAFJc=;
 b=H1GMu5eRLM/3LSUBQ0IbPHLIVT9qUIBGEoZZ2s9Di4qPCvhfiZ62M+Ht/fmEcOhcil
 fzZ/QipvT0dJCn7FuiUIe6rZJ7kRrP/BRWaR41btugCZuZmhCNJMc2ZeebgKPep6J9zJ
 iB3SyAz+LbUlgyd5nZS0zN4wKbNLINExe2KFAQ522WUEwTISA93ieqBl/VsoxbPYF540
 3JF5BH5+Ewp+8M6xPxPo2C+gOaS0KvVYX4IGP1AvsvWQ/ZanX+p0GMXHMKfQt7gRfy2P
 PRDT04bYj7JRrNDhEUYrV9p3TltlzXG4porcDFNhc4+o8Zm6xd05w+Y6yqrO1Sk5aRK7
 Cw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323932; x=1788928732;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LUoGW0tpeQwL14K46s3nu//v6mVqyEZRrPoqO5sAFJc=;
 b=hO0qtdM3cDGp1u/ZQCJpKdP+G7jtCVyF0lrbFNyCWoyZLPjEmXiZ1+EleESaQyr6qB
 vtxiTiult6n/IcdYAAh3j7YLTFc/56jdQBiMOKVMTHr6r/+4yRORbxsSBz6mCT7qqlGw
 t9aihyVeicHmXGl5hAZRNkYDHchzPsUo0Ya1gYQIDfaWIuzom9fv4D8mNSFGR6Ql9GhY
 TgexlRbM7dVC8wWPcr5xU+dRd0ADp1I1K4AMBEcothkCen7IErjPGuNcsLeTv43bC94G
 djyTHcdHiQy5ozgZJUXVBDyLcKW0lTpZ3Ukfl7jffNJ4yuG08XLJJH0sQtqmUBI1bLng
 p8jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqR55xg6rWueeiFxor8JfNrOjHs5BLi70JB5PEeFk9zrxReHoyKtqxzmMPTjR7k4uzeomGyJbTsYYSW@nongnu.org
X-Gm-Message-State: AFuF++l2WsW4uSAwQZUfl/8ydZ/5C1g6fH8Dt3ziNNHz2q1vqxVeUVqm
 4CbSrobBlXOF3t0L7ynmSEhD0Gvkg8wpgR6OWPfdGw0ImOltPAC9Wf9MK0H9d354tMZhx1P/jGu
 C+TKKhM+80x3tAsJiMaUbwcnd19uelq2Idxw9xbpH7eIsEXqXknBGKDSP7w==
X-Gm-Gg: AR+sD1182kdvbx+zQYYwSWm0qFfR+BYVVhGU46epyg+XqdAB3vN/INp9hbE48eHaDqx
 IiMh2GA7Eak0sFIgQ2bFBFM28wvQTwSHAGbGgrCOgSLk2RB+S4DOWMyuYYO4vMdv/FN8RSiexm3
 SsI0pNpRTxsYX6NvbHbQHjCaAgMjfrNs4wGfPxc5D1ti5vaORBQGmTV8c0hofAGsVUtkoeTQfgZ
 taNEuvom/ZRdPmp5kA3eu1Crz9QElSzFROdRhRxwSIMxbWh9rEXLz46T77IgjI8JEJGZ7zHiXEE
 rfjzZhDOoGfu+zWhNy7Fiybtw3DriNboahVlgr/1N7c/TyM/8BBeBm37zHi0Kvu1tB483icZVqH
 FB0fWBkIfQh0Tm7a6OKuq623lkdWdCH0mSA==
X-Received: by 2002:a05:620a:630d:10b0:92b:8a7c:f71e with SMTP id
 af79cd13be357-93960df1bc4mr211462185a.15.1788323932526; 
 Tue, 01 Sep 2026 21:38:52 -0700 (PDT)
X-Received: by 2002:a05:620a:630d:10b0:92b:8a7c:f71e with SMTP id
 af79cd13be357-93960df1bc4mr211460685a.15.1788323932150; 
 Tue, 01 Sep 2026 21:38:52 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm3452501f8f.3.2026.09.01.21.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:38:51 -0700 (PDT)
Message-ID: <fe23cd89-cfa0-4b77-9ed2-9d7bccd9dcbe@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] hw/riscv: remove
 TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-12-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-12-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a97a85d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IExGF1WZWrXNFEij07y7msMTUvt-fi1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfXzvP1Bl35fxFt
 rxsM2gUjrzGPTrpMkdsK2EtOmU+MIDD4dvHegU774zMDstVpLCt3hOmmiU3iT47v/UqO9ZUfVyq
 LE9xZf2naInE63kIFtoJnyec32I4JhzGaV/up+uGkW+Mv8FHrt/kGb6YwecPmT9j1ZVN297FDac
 gwKx493ipICMG4AAywV8u0mkQ64i92AqUq1D/IVFC3C4ZRzmnxC5iCTE43vPcVQSFavFftY20CY
 jYkP2PuNy/kFxOe90UBTUZIGSaodfJf+xfcGBKBtmBcQBvbx470v+qDJe+ejS3Mdi44g8S5EAoj
 GdOv7oRcKG/QpEGqzTxGD/AG+eklQAZQmRfIe/+TglL5+osuSd/X19iWCDj3FGLTmbe4f3WkP6/
 hO9dHtdT/gksOOaoek4CVkA0IHCioguPAPRdA2wnUKEG56sw40nxkDMtN/64RHK8wZzEHBD2qnK
 zTbu06B8oBOtdGsAThg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfXyd1+qQeFVNKW
 kQkngENJNBOB9Eycco5nKbvSgLVPj/RXqj2JL/bCVzuX+6TXidWUiaslaCw6yv46lTDlmtYcXs4
 ppc8wl8xywL2O5z0OHZseJjOblHVoak=
X-Proofpoint-GUID: IExGF1WZWrXNFEij07y7msMTUvt-fi1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/null-machine.c          |  5 +----
>   hw/riscv/virt.c                 |  2 --
>   include/hw/riscv/machines-qom.h |  6 ------
>   target-info-qom.c               | 13 -------------
>   target/riscv/machine.c          |  4 ----
>   5 files changed, 1 insertion(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

