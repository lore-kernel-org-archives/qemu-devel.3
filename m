Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3656C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7U4-0000Rq-04; Tue, 21 Jul 2026 06:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Tz-0000Lb-NR
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7Ty-0007yk-5H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L9XE4Y1389911
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Acu/XlYwxG7wdoC4q/yVs9kVVpvdwZ5KYASXb6TzgZU=; b=SHzsQzw8jv2+dmAM
 Dq+H7URLSCJIiJ06k3ag/Z4/QtIQbexTeHRuMed3FtQb+Hh4zooLxGtY2UznWYWD
 SJInNCKfdMxxQds9XEJ6bZE1YkjAEZ2tG+SvkuQMHIF0dwiLjpk+dT0ty0ppVr13
 xFrKY0KscsUDva8ZWVKKDkkANdLUzjpUdevqdsMUj5tDDe6DulNSne001m+muzMP
 mobZ+1RfZXeyGb6FI1yM81MQkUG9gJYaBN47rQaKpIHCVk8X8czEp0XRlMfbFNZe
 88isvE+L8xVsFo/Ue/vPq10i6D60gdIuPMUiz8ZM1hsd4+93o82bS4TVW52iQPrP
 iUyDPw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6860564-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:13:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso168629331cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628828; x=1785233628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Acu/XlYwxG7wdoC4q/yVs9kVVpvdwZ5KYASXb6TzgZU=;
 b=c4GcIdpN6Mi6SVlXV9vsvDY+78+aqaLTVduZq3LdD0PFJOn2XWdZhwRmeCZ+BRyW5w
 XxheHLN/mv9dDWNAOPzl+zHsUWNh3GKas2iu4p0OTPEOt7NunXqzeYQ+q3Qe8owUmuqv
 GNAAKdWZy0lLwaceZ726q+d7aEwImKfQxgnMx4atO+QHalcdV6ExHAUV4tIJVdmrB0tP
 EW9geZw1L1hvFwzCQhmM6mz7Q8UtnJYX2rqxmyLu/5oxvLAyL/9HARjo1NA+GXmxzpxM
 4z6dfRINBd7FDJvX7XeKYNXLft9cNRBMG/q7+fDz08vzeZreXhqGOSs6VFyqrAtCRKYD
 e3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628828; x=1785233628;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Acu/XlYwxG7wdoC4q/yVs9kVVpvdwZ5KYASXb6TzgZU=;
 b=VG5BnbV7bpcKnJagyDSxIWqneaQLxe5cQV7uayd1zUSqHdeZ3W+UiNi1H49B/Cyui7
 EBYT+lLcK3fpFdKVL/TOWcDHzvhXo9lPJtyaSjr9dzWMIUN3YcnY3cN+YYrM0uwNJAwB
 fdjGYIwoBMmQtck7HYKi4fZAQuUWlA0jNK0yN1B1hPmSfptdFe7JyZWotdFAMYvO1x+c
 f3pl3UuMI7wTWTsB9UFsiwvJtMtbmfOWSPJ09qGrfsJr6P7OBBlvnizkSYvbfUUvNyil
 RIlm0XgtDXAI8DUr4K0EECkH0SkEAIfQUnC0kalpTy30UrKi80mNvQ3LJlJUJxCitXda
 cMyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlvCAG8TZzhAKjJpG7eU/aBDFTBVXhGRn+GpfSP9k3e5HmFHdZKfRszevURZDEO0rgoIO5g7s19Ft4@nongnu.org
X-Gm-Message-State: AOJu0Yz7UGD66yBBBO8BQrH87KUSKtmzk4JBPCDgMIyspGkRYHD9TXDH
 HPqj1exBWLYJkTuY3VA89SfgtkRyJtxBqeCFgK4+8k/MfWWbhChkey0jXEUFJFn1FnyLjWCIndC
 UoE6kCB6kpJJQMkgC15Gzt8HtyDMrjnK2RXix95Dws9FuIOoOlmzq9qTtpg==
X-Gm-Gg: AfdE7cnLrTlvHgh0UK4KoXPp+rV5/Tna0JWv06p6vfo/qnF+KXR94v99GYgpdu2XyMS
 cidTISX8/RkdYp7u9mGuUdUMDbHmaaERmCwFWIBNDEFr/pgHdC/LyA35nwKXbt0Qiwou20tbWWZ
 sgzplEucnetkcp3o4u/EVJj6FKyJZsc1w6kO8wQdRwX8g0ryhyNMCexwfGR54v3kYpJD5o5HFVe
 9Wv7wHY75kB2xOs3x7Ha38d4R2WdFCl6jJy7Zf4n14AHCNeC1VVaVqTm7pYHsihu6GgSQVsmFA3
 03ol00bfj2DOsZIPUV+YctpUggD/dQmgQByAt7vdj99Ap+NrwZbvte6zwxqxn4qhU9R1N+snick
 hhAzYpOnaH2uhprhTtm09txNPlKCFGw2zSS8ISQPdI07voeF6DPs=
X-Received: by 2002:ac8:5845:0:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-5213e28fc9fmr165514051cf.43.1784628828564; 
 Tue, 21 Jul 2026 03:13:48 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:51c:1529:2c0 with SMTP id
 d75a77b69052e-5213e28fc9fmr165513921cf.43.1784628828120; 
 Tue, 21 Jul 2026 03:13:48 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f69e5eff1sm28377093f8f.19.2026.07.21.03.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:13:47 -0700 (PDT)
Message-ID: <7c6121b0-e216-4d90-8f9d-103c0ffc1a37@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] SD & SDHCI fixes for-11.1
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20260720201133.24796-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720201133.24796-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfXwK1+bdEQ24FL
 nEyw3tM5RScDbhKfP4piwNZQZ27dxXZpv1W7duZ1hO393ujty4uI4rbfNSR7E+hkZzH67LL/y60
 fbIrArYSa8/XN6nKy5Ilt77+cer9DAE=
X-Proofpoint-ORIG-GUID: mAsckdxXFzUEhZDlP8EgEchZOLp6SD0i
X-Proofpoint-GUID: mAsckdxXFzUEhZDlP8EgEchZOLp6SD0i
X-Authority-Analysis: v=2.4 cv=X75i7mTe c=1 sm=1 tr=0 ts=6a5f465d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=Y6DdwLsB6ktAy3xOtC4A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX9GU2IhXSBce8
 L8qN8AZhLVYLy7sPy86xnWQ8eTnFmopLnbMvKRexNY+kuBW0aDgbEHmPhM+h3AWFHEGwAzsZqcJ
 Pu4o58QyuTZafzHcVJACKfSEJjm8pgNOzj9729sYZJHsbVyQDCMY+JCNQc2ZvO4ChfUSlIIe1B0
 oh9vptz/ZWWnRkUgRdM6ZDwAVc09CMHJjEkJ9oZiz5Z6dEs1b8Y62supyDWZkcr/cnbws0TSa4l
 L/X5NspCpVRpXFY8qRxZdrAloIjL779WTTrS5+kUM0bFQL9fT+tD3RfV3+JjwHPGqdwWmszJ+6M
 KqP5YTVU4l+SdYtD69RzHpVs01LrVTbeZaRWe/3MYZOSLSUO7yw7GaUT/b5CnUukbjcQcKt+YXA
 SROJ+QiQ4qsShbkDsdgmDwaVRD0jmBVt7HgKtPFb4vHyXBsm5SM0WS5a//mt6wgTMB978ink8md
 rCRFVOUgmaQkmJbSYcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108
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

On 20/7/26 22:11, Bernhard Beschow wrote:
> This series fixes two issues in the SD subsystem. The first one could send QEMU
> into an endless loop or crash it (depending on whether assert() does something).
> The second patch fixes possible file system corruption in e500 and imx25-pdk
> machines, i.e. the ones using eSDHC rather than uSDHC, though I could only
> verify that with imx53 emulation on my imx53 branch [1].
> 
> v2:
> * Add missing R-b tag in first commit (Bin)
> * Fix typo in commit message of second commit (Bin)
> * Fix topic (fixes are intended for 11.1)
> 
> [1] https://github.com/shentok/qemu/tree/imx53
> 
> Supersedes: 20260719211923.1079282-1-shentey@gmail.com
> 
> Bernhard Beschow (2):
>    hw/sd/sd: Fix error case for CMD18

Patch #1 queued, thanks.


