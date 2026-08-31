Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737FEC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vBo-0003vz-9O; Mon, 31 Aug 2026 02:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBn-0003pT-0t
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:08:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBl-0005av-Az
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:08:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52m4l3679055
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GI6EGikUYrRD9JcXLTkjKJ481a7KAIpel7bglLYOYNs=; b=iahNQ1lXHRoQ8Lby
 ML7hYbld+0JH+Dee/r+ig1gDOyUsXO5VieRqSULLtQAjdrQBd2vsS6oBey7ivbUo
 ASO0Ulhjrs7Ug4fAbdhiYIXlaIcihp9+fKb3X+Ru0PhOB9FkY3NMrUyctROOQfxk
 8TSUcdyVU6HTMuDUqFgkb3Ptc+jvFHmVrv23tAb+NBUv7ovnGpkR+gBKbSpKUoFn
 n3rBQWgW95qwih3HR9ZsUD7nb1PEPRV9NAIFIIrj1CX7UzzQ4+D7dN60xCTdSCoX
 OeGAc5+PwKVAE9fZEiX1DiugUxrtF6VurkNtPqe64D2zVfOxQnWY3ydX1L2Y0YHi
 kyK99Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h135g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:08:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93922c75037so185484685a.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156491; x=1788761291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GI6EGikUYrRD9JcXLTkjKJ481a7KAIpel7bglLYOYNs=;
 b=YdeclPVqTlwnEKQQSlH5veCHmhyi6zmOOvTyQ2GxXIGvjOqXEjfcK0Aw3ImGuoBu+L
 sybvKCcvuqiai7s3ngrPYucrOI1ddXRjqx4Ryu+Tic9hC0pVmlpysR0DmZZMcujPfexD
 RDQi9kxdo6/RRim/0nC9/kJKcCLiVWgiFQcMjATLy/hix40XTd3M8dWMhbxoqu648+9w
 8MYWdsO9crTAi0SdBmN3YEJdwXFkFGByQNyd50LhBlr4Ulce+Dx73gXUKmssfH4MCnwE
 V6QvewET+62Q8VgGcCNhWzU71dLyflGUWxPYrqF7AUQUFvIKCkzyMR0n2Gegg1MZ1soQ
 hI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156491; x=1788761291;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GI6EGikUYrRD9JcXLTkjKJ481a7KAIpel7bglLYOYNs=;
 b=G8bPJKe7M4JWSOAgXR8ha3yHuzhbaaE2nDJHppbTfZBDAQkKemzRiu9ZK3J1cVrOix
 V8w9Xagu/lmlzh+1qAm86tAJBpxn1Bu8q3l7xxekKXumQ4oKMynLZmQ+I2uoxHFWtIy0
 OLO7r/v7BBHtHZu7p3rqXIsUXjvf9MsU8AOFESVRaKs7b53egMxBVo6+wJXl2eJTWVGJ
 LQysIA27juNSfXQ15niI1nBdup4rQhcznnKkcBdyJHhhMnJgIoXwqmt7TICbyxNxbgrn
 C9RHdDtb4Wi6fVytsC1Tgxy54dy9Z4ga0eHZAvklnKTPca4jKYop/1v8PLZOKZbZVWKM
 ofYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJiE9Ef12ZqFXUk60iIm2/zQghM0x0UNDQcbxgis8O/6bdBTQfg9Nb0virL/+fgBfDOoJFW5M8QTSU@nongnu.org
X-Gm-Message-State: AFuF++nf9EhgQgahynhOLyhM3bnevFlpvrcd4u5RnRDfRA0q4acw+0Fc
 vYNj6a84EhVQ8gkbvgJ7QnM/xsfqpyCcHfJapXGC0WVy1HBE9jZW7E1aJVd0UtiIPHuchhnnJNC
 QSuUXmduixWFJLp2rFnl3IEjIyrX9K7kD295v4mZiUHyoKNQDyaAMTx50ww==
X-Gm-Gg: AR+sD104bAjqXJAHs9zXcuipP78UCvROJ4GMKbsVOHUAq7GwbNSLLIdknKW0ypkSVwC
 cNvaipqXCu6U1Jj72rCwfTBQMvLm3SyLf+ILHe7m38sTjahRs2w5/7FrJlk/nLkeaYqLcoKwYdz
 wlA8XEoKRRmJZB2eFb+cEz6kI84wtIsF1JXWchG7+Qd8GbdNAKsx/M26k+i+Jqnr2eekW7StFXM
 P5CFTj8bBKO+9l5/IMZmOSyl5kVf0zcJ0BatgxFBBqKzCeHII6X/xSJdfZ9+h2w/x6CbU7FzhQJ
 9hGS8X/+YGOicX/h5haHMmcMl/r5btoAo/eZAa1x0ZRmxprV9FaXtgbMmMh5wIUJL/76b//Gs4D
 ke9Wqn4gkKXVxomfBYE1t9TvUs421xer5lA==
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id
 af79cd13be357-939138fc2a3mr2798606485a.30.1788156490818; 
 Sun, 30 Aug 2026 23:08:10 -0700 (PDT)
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id
 af79cd13be357-939138fc2a3mr2798568585a.30.1788156485575; 
 Sun, 30 Aug 2026 23:08:05 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd8148fbdsm26596075e9.3.2026.08.30.23.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:08:04 -0700 (PDT)
Message-ID: <97f31a99-7b24-439a-a93b-4bb145c85ffa@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] target/riscv: Use tcg_gen_lea_tl for SH*ADD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a951a4b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX65PoePPnAxnO
 O52N49RIUjfKXsQ28WbRcQXAu0PQkl6C0pVFdEm9q25qiOQaioO3Ziw1GPsITbrh8Xpm8K4mCUd
 rEFKVWyE0nXocy+S5b5HJrDcoAt9d4awGTfWfDWwegKE4fphij6p+5AF96+4VI9/yVTikUKlG+x
 9bd1ES6nTmPw7ZqCFHZX5dx/MuUYfG4cAYy+xnY5AsVDwtHh4soTjsbltzpVCPNWqkJvzq3+Ym6
 6PJLwtEZCd6Okpua4/fydB309NZR7/DM52H3jDJLFTQ26xnBUWE5fz89gEmFMpKNjauARp8Yjiw
 jlTr1qtdZ9RKs3lzo53n6bKPI8mGOfjj3KEuTteyMz27vua24eBghaL0PWp6xp1Q3ooQ6JghoWc
 8RJGZVbaSccVpvN4t5RoGMGZ0YCpFBEW3IPDDBzL6hRej8v90kaCyvaX8whiM2o5/fY+vqh3HU/
 BdiJp37F6z2aahMvojQ==
X-Proofpoint-ORIG-GUID: kaz9hOlStaJG6btiP8MCPYZ6UE67AvVS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX87kCrJV/5uDG
 M3Ks7Jm82gWm36BCXUBBBeLCB/017gs2+bngW4i6Bd1By5X5R/1sFGF6wQgtRyWxk7EoxWZ1cgI
 CmebQB7Arzt60qhdOh8od62LbsaaLu4=
X-Proofpoint-GUID: kaz9hOlStaJG6btiP8MCPYZ6UE67AvVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310051
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

On 29/8/26 00:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/insn_trans/trans_rvb.c.inc | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

