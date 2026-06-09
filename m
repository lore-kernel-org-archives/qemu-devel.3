Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7D3CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4hs-00012Z-C1; Tue, 09 Jun 2026 18:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4hp-000128-Hr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:13:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4ho-00062x-0v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:13:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4Z303567432
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 22:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zFiRSyJrdjwLdTkREUo0jczWyLC2ebvhkA0PYhq+X9s=; b=n0RcRk22VNCI+NG/
 XX6nbJhVKe6CzErrfxG/18KIrmYjoZX/RSpR7gPxxfKgRB6bYjlIApN8EbWoGU0h
 p8wUJNO61i7wMx0+J99/4Ux73DzBwPYRX+jbRWpo9PaoxDA1a42Ub7K6IUnkoJ3G
 uHUCy/m2IjJvelggaWuYYlJiLGLkYx5gFRtrlXIbHEBIMnHIIfeINeZNFapTiSSD
 PcIY99AlJjJ7Rz7lxVNSZdE96Scnso4QEvptMtTXU9bq5e1YvIBw19hsRgMMi5/L
 22i//VMxxI7+n4bJ38Kn5QTVl2xlj+0rYmDGRQpeaDMMK8gVOEpMb+Th4297KoIX
 P1O8cQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4m2kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 22:13:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e4636205so1619759eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781043233; x=1781648033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFiRSyJrdjwLdTkREUo0jczWyLC2ebvhkA0PYhq+X9s=;
 b=iOt7pXvlX6gsd1uF79sr2mkybn8PjdXlg5xG9yMbO9gOked0v6ODlaxYuBx34nVR7Y
 SVO+85vSQ4oZb9+s6a2KjW0sVmOD6XlCwpVtJURmL4GB9e0yeAH/PcEUP4HFAXjjhpdv
 ZdP7a4XyhJoi64dWYDecEILru7gy4N5cPYOazOw0SpiZeA/zUuioWZCAVvH1zOvlJLOs
 UIuqG8ps0QoF2Y3PbLVI6PJ4PRAhk91W1n3ZHBhChrWUl1lOZndbe0GJfxkBjdS4a6K5
 BJHlhl2AKInC9892AEEnJ7vVpCLpJPqO6nXHQDpZ1i5ybFJDYyQ1ugOnrp6ah6Pc+dx2
 bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781043233; x=1781648033;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFiRSyJrdjwLdTkREUo0jczWyLC2ebvhkA0PYhq+X9s=;
 b=dQkRgimozsgu7l0JX/XM7jydcP2/BqOeY3cMpDpHlWzaZPD7klFcJ1wFf7ZLo8Vf2d
 zjxlw4ZW7P79duWfXpKe0xN9xys/SblkEIFRaNZQW6Hxl1PlXwnLJnC3NP4j4jZKCMq3
 DH4pFOUaxFHqkxM281DrKhcXtgke/RkpcMwDL8VNUM5TTKdgpTizABZmQBwWhIIdBZGV
 CzpEsQH5zhRb6dsrPjZqbyVChtzbNeq98sK7TdH4fQtkEb70nOPlmFXdhpLQx4xkbCqm
 XVWtjeC/WyJNCN8EI4CZPZrD/7SDduoGzYoVCUGsAoy/8800nUTZezRLMSphV+ehVgHW
 RaQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+10l6dhGEQn/Rvw2sUDP1dVDnh5Dd07u1DX7Q3T1IR/WF4MCNqVxHcViMM+5sWtHyumNKjtdj2Ozun@nongnu.org
X-Gm-Message-State: AOJu0YxzxFqNLsHrPAaGP8Fy+AmjkxBdOF8i0j3X5Ig9ClNTd+nek2Aa
 AKMLr3FK0UWVbnq/Tw1YTwv/J/Bkyqt/N2SFyDbRT+TSLUZXfdBHhSQ7Ds1fazzIk6gZ+jIB/y/
 PEHust1o2P5TQPYxYuR00sbIqbthKHKLmLr0/ObVx1XpTqtHUnR7mxLwxdX3KiHD0tZSv
X-Gm-Gg: Acq92OFYJktLp8nrej/zMHHBASaEMFslg9CUhVLxF2TszGzq+6WO9Va/Ezue+h+G9Z4
 XHpSHyAst9CKOz4v3jYAXRhufeBBEPMycssnKs/FIhs/1jCCJ8+dL3I2wmeOk8i935TbEPMDlUJ
 Oj6YLr4A4OB4aEIMbWDudBZlaZAbLw/YfIpERwe+vPidJ+6ujLM/LmwamRlArMbbbUMYe54AsCm
 O/ecSh0vTwrEqTWWcnofHoLvHgISz8JqCS8EQ9MVGtVRQWvcRxDxnhVLy+f8oaYuALQR9wTxc37
 rLpXoKYXtr9bpZtLa8Tye2cYf/dsWj0wFaIoUlOjcy78lOOumvPDzPJD5ImVzBAfkO5sMION2gb
 bowZu2g3GrSJVVMpYKEWxpTJBSiK2rWoe1Ov3QBt7cCttfcDM107t2y1iNOBlAaDlLtQ56Nqh6j
 TIB/TEwrb09n2qyTQi1v7A2CEq
X-Received: by 2002:a05:7300:3216:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3077af39140mr14008855eec.8.1781043233229; 
 Tue, 09 Jun 2026 15:13:53 -0700 (PDT)
X-Received: by 2002:a05:7300:3216:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3077af39140mr14008824eec.8.1781043232745; 
 Tue, 09 Jun 2026 15:13:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcb98aasm22410612eec.12.2026.06.09.15.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 15:13:52 -0700 (PDT)
Message-ID: <4a8ea786-547a-489f-a5c0-3c2826e2a80e@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement /proc/cpuinfo for ppc cpus
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, qemu-ppc@nongnu.org
References: <20260609220929.83951-1-deller@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609220929.83951-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a289022 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=RMNLA0iz8zyDGWqB0-cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: pmX31ESYgiAtfrsfLt4PcBJBMrTWfMh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwOSBTYWx0ZWRfX+PMM8GWJCQOa
 DQ3mHOSTYSVJWrLVTekvH9EJta8N58kUYomM9jnZ7GGYXYDUxTZzBz5H2pCaM+BvuvHLc9OsII0
 5Ei60yq1i6hZqYB0HbC8CeyZjp7C7XKS1wEH3dLkGn23KMYf8AiJc7SzBm5/v91PazW+rt3aUYY
 f08aaL7K/Vo/G2GmdoBu3rKg7jvfIO7sa6IgbUKr1As5jJin0xCd5QbjacJW/4uvcHPIffHsQvy
 GgHX81ALyPkspA6vfmOV26sdE0zt0rKA4MlF7LGXXNq/5GveyCJPniDYGR62OKC1y5yMrgdyZIV
 m72Leeu8SHT3RxUvpv+r/yiP0wmb/ryj59LCkL67ZmmtEHPuudY22PS7ZUhitS+8SzojLxCNg8s
 N5+cO0mi5jOTY9b+kTnovqunDdgWlyTrfyOTwvsB8S8d2GeNYReVg4Tty12lmUXGWFEHVJBHpVW
 p4y2Ef7Vp5oejmb/hdw==
X-Proofpoint-ORIG-GUID: pmX31ESYgiAtfrsfLt4PcBJBMrTWfMh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090209
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/9/2026 3:09 PM, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I've tried to mimic what I've seen on two debian porterboxes (ppc64 and
> ppc64le), which are running via KVM/QEMU. I assume the model type of
> pSeries and such doesn't make much sense for some older ppc chips, so
> any better suggestions here are welcome.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: qemu-ppc@nongnu.org
> ---
>  linux-user/ppc/target_proc.h | 38 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 

Looks good to me.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

