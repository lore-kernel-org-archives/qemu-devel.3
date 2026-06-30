Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B191C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec1r-0000Nq-61; Tue, 30 Jun 2026 13:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wec1p-0000NW-H4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:13:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wec1o-0003FF-5h
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:13:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UG3wl72481551
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Ne++MIg4SYmvqIRdlRvBbq6MOLqeIW9s+AHlHEXSx4=; b=DgrOmGh86KAISbNR
 ybn2EL25O5983WVOCrjYXB8nG5x3oNRq+/ckQ4pD2/JUuCdloXRGpsnh3hEU8Jqa
 eg8HHesW29jeXs43mofVkcs2NEngrQRDDdpjt5pbFJ5aD1SkjJ+xevo8z36rQuD2
 b+Rohy2ROODW9/ArD9ONwKLVH/ASWP6f3r5zdvpKRc9m80xa7QRKxYySL/8Y/fk8
 EwNiIdlS2FjTAoJpqVpnNtjCf9f1+YlexOwRmuZrJfTw4FBOFQ+hbzTduqiyXpSr
 2362wc0VoKM81jFJTQ3XQWiv9G9xpMKIQxV76dBn28Qj5gANAUCBW/6nQmRl1sG6
 tlNfZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0arbf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:13:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e56b2b350so594511485a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782839621; x=1783444421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ne++MIg4SYmvqIRdlRvBbq6MOLqeIW9s+AHlHEXSx4=;
 b=e76BhKwa3P2Fz4bLGK12v4W1PPboBebYwQJJmiEIBYNeZtnAtkCzQgFD0mCImaHw8t
 SV4l0UsIbQ3US8z9yKHJ8AggM5Osf5q/M0g2dT3y6HQU1ABIGA5/31Al5R8bIhNFGCF6
 28NqoGZV1IqEbMmxLnqAowT59jR0U5s4W1V3q9xeU+fZQGVUnARPf9cHlDO0MhrgZkK+
 AvXU+YrzVq5vgUKw68eXRBkN63pFME/F9Y6SFUZ9tP9xDf6mpUWIAkVIM1YD81icH1hv
 LZ+IzMhlIhxg3wDFfXbAJYuLiJCEDUxXOlnYPGLAFQ2WQeLFiUTOwKo/nAsEpsHnem1r
 ijPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782839621; x=1783444421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ne++MIg4SYmvqIRdlRvBbq6MOLqeIW9s+AHlHEXSx4=;
 b=DCAr38ZOHyFjI6eBtGFiqgV3cja/c5j/5lxLV14KM97IkK18N9rPMftR4WXBieFE0Q
 TajUmaKfrw2DmUJV8b2tfmGmqRynOyWo/YfoJ+Lp1AfDgI9T+i+U6C0mvTJcTi1ea4NE
 yrv6LeXspvDPHN8aMtdjwlDhYZAQIoZESDgnbbX8FC3kF9JZzwSLvZsKI9Gz/4y5q1NW
 lQy+LShlHTBczD8JKQsMBqBuOpdtcRbOSMMTN8d9VRxOOOrcYVFTv2fBaWJHrCfswaTg
 hmzAelu7FTmcDdZ71zGlqBWdAsZ5ApnNmdcxIte3WRgkXawfrbEp3cHebj4C1wIzwxIQ
 GyCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fzfvA/NqlvO52zjVrF/xhE/YPeJ2AqlTkLoianJlKAyvfB9IOGdcbfPLZHMIypYw1o1a4G2fRpGb5@nongnu.org
X-Gm-Message-State: AOJu0YzPitOJeYZYxo1bambr45wwVjCL4Ggc4Dso+O4+e0ova5DawqfS
 tzE46FwG4Y3xrnvzbjpfXg1OFXN3Uuyp8sbIS7zUJjRuGUajM3yWdqKaKe4Tl0CuGbNtmQVGQrY
 EXp37d2B8cfMNmMl1iOgbpWBBDW/NQpOr+u7UcLLin4aqCmiG85ydsJuQGg==
X-Gm-Gg: AfdE7cmLZ49Dgbnwdqedxo08uH+OSOdZFSfxTBwr69eOuKzuLdtGw+aHee1Gos4yDXh
 hSusbteQfn5TIDyAxF8wDj/DuXXJkAWtC5KLYogjKdQMtdUxLPEfu5yM7MXFg3fvLEwFMFNMec5
 rzXQWNfT+C95YdZKTRpDCr1dir4q2jKpt37WM107UYxg9x/sgOawCDrQt2Xoj/jiixr4qsFJgL1
 5IuN57Rs4X2gfM2C4PSnFbyyFO3Kw091BIXYurYZXdOX7maZXNWxQo4EhKiJzmuMhulA9yaHil2
 dKXd0PZD4grPSY5pLXqXobqxou2DR6dhxmMHBbnHMGm8oxAT02fCXDVdH2feOJ/znUHL6nSn//Q
 dJYMYqDoin9vjwBv6nRmvJAgTHJ4Yp81U8j49jbpmYt6QJ+ATsIfDhuYdjUh4bA==
X-Received: by 2002:a05:620a:4387:b0:92e:62d8:1faa with SMTP id
 af79cd13be357-92e6d858f52mr246002085a.46.1782839620718; 
 Tue, 30 Jun 2026 10:13:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4387:b0:92e:62d8:1faa with SMTP id
 af79cd13be357-92e6d858f52mr245992485a.46.1782839620100; 
 Tue, 30 Jun 2026 10:13:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567979eafsm9178570f8f.34.2026.06.30.10.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:13:39 -0700 (PDT)
Message-ID: <5d292049-7d76-4118-9e55-66caf2799fc7@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 19:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xtensa: replace calloc with g_new0 in mx_pic
Content-Language: en-US
To: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ajinkya Udgirkar <audgirka@redhat.com>,
 jcmvbkbc@gmail.com
References: <20260604162849.199541-1-audgirka@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260604162849.199541-1-audgirka@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a43f945 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=w1a5SNonieEqtlb6S-wA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: dxjqsO0C4tzjzf44CPgKBdgbb7E36lu-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2NCBTYWx0ZWRfX2L7UtlMITOCp
 4US3vCWTJkNWf9ZjMk981nol2ekp/XlVKL9fNN6Y88ycIr6MrXsk8jAd3hr76Wpm8g7Pjk+iqCr
 H7Ym9rr2o/HUnmJR/DtnSWLiUUybWfc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2NCBTYWx0ZWRfX+dT46JxDIbKq
 1m8q9Y2jwGCwtS+6egujiamiROe1vjCKa3n9aszHTzNgxfVceXAWjtgtvq3bZTlt3BbTa9uXyxH
 LdcVCUg7bXMKLOdCF7a9JD3e7S56V0wcwMiSIiBogRKx+C2s5WHIGbZVL44ZH40FtTOiB0zb63T
 cImYHAzN6SEd24n1raaIjilFFUPoIUaTXRV/1aYFmVd1/kCcPLRW26kxKdErVPyqHwlNt5zRoqF
 zT/WlBY64+CwFL5ip1kRRzTF1boBNdaV1lItHYU+1F9nc27KLaEJBwT94wki/L4xl1uprGjwm2l
 K19TKf1V8J1Y1B7Uxd2oeVfrnYkaEny/EsABtRAV/QbySWyfqS6GAAFQrTCMr4ZpxB8NQXcDOE4
 1L0kB6ncjUFuex26HBPrGSC2CgmTs987q0SITYygMtnt4wR+lO2tC5rTFSnmhbb5AQgVwg6mVks
 me7Vgfkmy59UuGxAN8A==
X-Proofpoint-GUID: dxjqsO0C4tzjzf44CPgKBdgbb7E36lu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300164
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

On 4/6/26 18:28, Ajinkya Udgirkar wrote:
> Replace libc calloc() with GLib g_new0() for consistency with the
> rest of the QEMU codebase. g_new0() aborts on allocation failure
> rather than returning NULL, which matches QEMU's allocation policy.
> 
> Signed-off-by: Ajinkya Udgirkar <audgirka@redhat.com>
> ---
>   hw/xtensa/mx_pic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Merged as commit 19bb5635a0c37435b7897abb2810665acc8c2f1f.

