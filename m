Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BCBC5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtG4P-0000uy-9f; Sun, 09 Aug 2026 22:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG4F-0000ts-WE
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:48:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG4C-0003zK-UU
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:48:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L6iWm3777820
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GmsQ2SvKIPze/iyyndazYIMLA4wGsLZWz8B+Cf4r/gM=; b=n6dipVC64f2qstcy
 rXvDTPJrazhOnf0B+zdDtR9/1IfGJ6lt4IdNTzb/PXstJWXB8jWe114tJn5SAzGb
 TkLJ1L64KEY/D4sdOtFmAUYJVtZF53tlJyQ0+ZDC4/Tg6tagFRmIldmnPCkqVnRV
 UQpZMJUSTnLDvjlFLzx5H1Kt42x0Jm4IzQNq1hx+xe91a3/yzWZv8Es5ADPsxoVW
 OtpaKuMaHBKCteGzTY9l+bRyQzLoR+ZiWqLoq5sYjTBaHIGY/v2Q8AgMm/Pkdsgp
 fpU1tDvcl8CN17Aa5l7b7x+zY36WGyihL71aa07QyZkDbZg2Q3wCurRp1xLw++0T
 cvctzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhvc2hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:48:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso28516811cf.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330123; x=1786934923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GmsQ2SvKIPze/iyyndazYIMLA4wGsLZWz8B+Cf4r/gM=;
 b=Jmc4aLpWUo80taZ3u+7L3fts4MUAivUoGZWOzsg/6recj/1duXKkZXeRfAQjxWmeQZ
 DCxhhc+D7nNMBCjvCIxm3RkTs8DfupiBrh1OFWAAi4t1/zR9g/eNGhz/HpF4mCzkCC61
 DU/ql9KdJyKIflVTc6s5X4ZMfDht+udeR0IED9PsjLfYoNrtHhacjz9q9MXKU5b17GRw
 WJMWvBX9mQR5bhbtdFMFR7p79/BE4vgxO1YU93n25LDZ/c4L2SmiFWrbSl1ww6a+Uyo7
 pvuOz+H4hQDOMle2MKkb/9ErHsYMBKTRIo3AjiCSAD7H/CswX5+TjQ3B0bPDeMWphF/n
 p0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330123; x=1786934923;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmsQ2SvKIPze/iyyndazYIMLA4wGsLZWz8B+Cf4r/gM=;
 b=CSysz8D9H9dLx6Of7aJvjPQ9GKajzMbvOWw1GPPuCU1KQczLof9TxGAO6o863hD3BE
 5qLBN05JXWwd4ANmhWATNU1qJNgzxpKfPs7fSiZUJdZhOldYfYhvUrc5ikfEqT2zveeF
 6fEO0wsJVrX0Z6y8yPGngJYoBbPKzRyrfEwShoWoooCVhwgWnO3BmJF9NKySuOS117SD
 Tf6qaCfyixHniEEsmPd6qrvhYXDoKf2yUhZtjimXvotA1gGE12xqe+Vu6EQoQJ4ZGFai
 FOItpgiIG8suTsyCPIs2lQOhB8TK7rHMvjfxnQv+0JyLFOFQWukdix9vChqaZu2VLQi+
 8dcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+wOeRUJ3l+MeYJsC5s5cAYdGYmmk9LmVAA3f1lEdCEXi/ueegWvgB/XKu4Cdrlck2n2DRhc/UDUsT@nongnu.org
X-Gm-Message-State: AOJu0YxUjrtLmTzfbF6+4hmIW9psUiCS9vXOoJSjYmcjdI5FpJYxMdg3
 Aov3SCaVGAw61YoNC46OWNp9Qo5NDHEHgJugoIO57SdMjhJwPq9vETzj39lM55jp0abjCd4pi1I
 vjURPrOgqTN5ekXcAhnGakNWeVqhJVa4jvqy48vQzqq45r0MBKUSBlL3tnmnGC7lAkQ==
X-Gm-Gg: AR+sD13fcIOasA6ZZxbPH22MDuZg1P/+nVbQzyI5XvyIEf1A5Onhjj6i9bQzTIqIu1H
 vCjYMRGTxPE/OongXghH5U21ra+O6Vwb7YYp310k28vq+tnw+tSqHAYW/Xgio59g5+XiNt7L6xC
 1jZfqTYXbXUjSAsTzFluAPIaa/F6EC01V1kvJp2EKBygvJe362WoSPah9mMV9Yze0eTmyP+9ZnG
 yH5YZzoKu5QTaWPBqWKHfbGi2wbXicdbIbbT2e7fw0YzZpxD/lFdt8pleYBg6bjdSLYLJMjzV4D
 yblW7geozrANQdvAuaFRiSRSiLk8xIrF47RTasru7JogMrGQAaHhXEF4JHqZulxZvvjXSY/LeQx
 Fw5aZX6ysogWLh5oyOX06bDDUEiysnMM6l3o=
X-Received: by 2002:a05:622a:e110:20b0:52d:2b8b:a138 with SMTP id
 d75a77b69052e-52d2b8ba282mr83503181cf.26.1786330122994; 
 Sun, 09 Aug 2026 19:48:42 -0700 (PDT)
X-Received: by 2002:a05:622a:e110:20b0:52d:2b8b:a138 with SMTP id
 d75a77b69052e-52d2b8ba282mr83503001cf.26.1786330122620; 
 Sun, 09 Aug 2026 19:48:42 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2dc4esm285766505e9.13.2026.08.09.19.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:48:41 -0700 (PDT)
Message-ID: <bd582515-1a7d-487d-8811-7b036f3352fa@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] disas/capstone: Allow for cap_insn_unit > length
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a793c0b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yFUdkD62FiMLwpdkEd-E-FbAcyY7dFhL
X-Proofpoint-GUID: yFUdkD62FiMLwpdkEd-E-FbAcyY7dFhL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfX6Bk2FOR53RZr
 D4RCFiSIyEt7GDz7pRpS9nVhmqD3AtSbsLP8T2dh8XoWXqSFsKATZ2byrE6iy3uvlmLoija3c6n
 T1Cp1xZImLIB2g0GQiSU+FPjP9bWWZIUv4a4JRy9iRQ8d2FNNdQy0fvZlDrceqBnHMB1CfwHW6x
 Ubd5JkLNQUWdx8vYtjsvuupUkcx3mvXRtBuridRQN7gFPQ3uxw5SboZc6MunQ1U9Cuk9j+ULJ8K
 chHen9lmAJ0vVlABnjHSksz6VGCAt3g+cSVjk1e9jqqpZn1q2XisPIn7PZYxYWUNmh3gLrv6Vs9
 dv+0gTLSnjmjKtaXwABvqC1Yq+FGjMaFUMkcrsDJcmI4J2yLHR+7yZFrSz4+I9YenRG1jKnqoKX
 6H8EjWxg7PAIMK/9DacoVCnl6CxydxtRe70h9fohsPKVXDteooOh+X1NMSog+dNOml+kkQsZM7C
 5JLo+hVylHPxFQ9OfOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMiBTYWx0ZWRfX/TCI1ky9SmZM
 GM9xfi4p2adbjghzDYQdGa6lmesC0g5vLJX5HmFaLDuep6XcRxpVzLYGNYwCkoYTGjkx3FUbZkd
 TJeNF/xuDA1dpK/GPqXF3bdvbb1f8nw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100022
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

On 9/8/26 03:33, Richard Henderson wrote:
> cap_insn_unit is designed for targets like arm thumb2
> and s390x where 4 and 6-byte insns are displayed in
> 2-byte chunks.
> 
> For riscv, we prefer 4-byte insns to display as one
> 4-byte unit, rather than 2x 2-byte units.  So we will
> want to set cap_insn_unit to 4, but allow for insns
> that are smaller than 4.  Emit padding to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/capstone.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

