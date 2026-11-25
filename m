Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A81606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WSPronVi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QBuKYUFo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9vO-0003VU-2z; Wed, 25 Nov 2026 05:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9vM-0003VL-7u
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:08:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9vK-00027V-BS
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:08:23 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mihk3642178
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dHpVMKuh35I5tfPVoSAUXcH3IowCmfphkuZACzRzTqU=; b=WSPronViB6zWSKJg
 HpFVMetmnTJWwpl+7ZpehJNiGo6eraqTtU9mMXAVJjKdTXdxek1AKU/A4gvH5yEg
 ROIzmHNbGuEdjkppvn/vX/tzBGnCvhrLf53XP1CWXHciEhBSCyqNPaB/k4Z9uWHY
 TeDsJP72on5l1B/HLyDWuBqzdTzuD0aJBqN/vVNHgEQvdwXXrLZ27pIzTH9ENeJq
 klO9fLizR/o1SVlQOV/Fbt4UZmDDdRMhausvvt0maslG8iq/tyoJo7GrNKnQvfZ0
 FaLWUV6HpjkA0vZlmqvj/WPrEOm26gB0OoDNVYnsnDGp6cKXhik644GQXGZfbNQV
 l+i5LA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc2a9k2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:08:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9213730b07eso93628396d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795601300; x=1796206100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dHpVMKuh35I5tfPVoSAUXcH3IowCmfphkuZACzRzTqU=;
 b=QBuKYUFo516JHuyChHiQFPpkpSOZ7LLTVp6xDIufGNXkW653DA5UNoojWdndvQuHOv
 4yGMJlUOA5462cYnbdmMaaM2zGH3esHK+3I4z3tcpUyhK33ypOyqzgmlUBLPE8iNkcD6
 fXCKXf+0kLTLvj1a1KyIbaNuhvCm5EYd1oZU2j5qFWqBiD13bQ+fASW7QFxRWXLiX93a
 L7TB1QtAzuX/K2ET93KaQoIos0ZSXap9bzEEXq3JSn6FbToE/PpIlbHr3+Ztoe5nw5Ly
 ZUEPoq4mHC0xBGMhP19JKZMyuire1A2FXstPTB4MRh35SyB9qWzbNHrq7msQW5UFhqlF
 SSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601300; x=1796206100;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dHpVMKuh35I5tfPVoSAUXcH3IowCmfphkuZACzRzTqU=;
 b=JYHsYU0lXmDlU6pKxpUMq/6gsZWYhYTYlVVozStcpKxvnJZRJcLRhgnn5MJuy0NuHt
 ghBIGMDUl2OyllaWHDfr+EA9zJsgmdh0H4cGDtIXhcEQgjUdOGjfslXpsedgstZB/KZ2
 lDZh+P9qAx8OeowKXN/zJVIUpYvnhOPOJRWFjzcz7jH04KhhSpLGdSZrtnbQFJ2B5Ux4
 VBZHfiyvH1nJ14Cxafh45wEcXz4Rbk5mVciVKWvwfXdAuVTQhEeIc3TBg6ChGXlVNtWc
 p1RJe7D+mXMZjvG1zBrPGxJWUX9fYvcV5a4mku7gXcqnuzpLhJYmBQJ2J2z5V8kQxelS
 lskA==
X-Forwarded-Encrypted: i=1;
 AL+hErGWnoeawp9aRASPaSOWmb/VclwUaC/rKjEs6V1xgMPkvnIc290MM5yOD7eEayZe7baDABJKDfUbqabU@nongnu.org
X-Gm-Message-State: APuU4Z+Oue8Mc5pgUGCndiOe0c3QZnPy+L94GY9oV9S3Zd4eG/omXPzk
 Sr8KT2Hluhpje/kuMGkRAr2boDKqRTg3sadsZ+6UpfwIBWa8DrD5kA4bRrjTJt6b0c7enQt3sxx
 d2GTk+AVVPgV6Fpl9p1+wRbeMuNwdho3OXWomb3GlQxNrNI9W+sFB9WZHUA==
X-Gm-Gg: AZFdTZfUt6Vpcu2QO6tgGqWPW32M8p9sn/hUJ47j8STzCiTtpnm004roFBspUhpN9cP
 tlpfF6SSvORjnXsw6wMaRcISUBsV9Ok5usU7rmH70ws4nMIDds4/VrLlFsU9OkrcKl/VBhzXS2x
 IH4sfYZeU3T8K4ql9PCDXTHSrGYCSmgts5OAKcUlnwA3sjhmDrT1FH7LxevlQwUGxDxMDD35UjH
 H2iS34qkw2M+EyKkNaz1OYiZCynamqiykUeWsozpkskDq9t1LPT/4kNZNxaSlTxg3vJn34ntJN+
 dwvJU/R1mj55vUdnVCcA944qqwxhSfyeMnC4UsvlBS3JVGVwtu241BcYLAzIESbPbtJWno21hWe
 wyNNVN+gxk7+/4i/+P5sQGxG4UEp//I0YeeMiwnEJ4lUBQm6/1fUfufwxQt4RDhdThvRVhEekWb
 RVd9hzdlU=
X-Received: by 2002:a05:620a:f0f:b0:949:6c9f:1a29 with SMTP id
 af79cd13be357-949ba7cbc69mr3025681485a.6.1795601299738; 
 Wed, 25 Nov 2026 02:08:19 -0800 (PST)
X-Received: by 2002:a05:620a:f0f:b0:949:6c9f:1a29 with SMTP id
 af79cd13be357-949ba7cbc69mr3025677885a.6.1795601299297; 
 Wed, 25 Nov 2026 02:08:19 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a1e8bsm424267445e9.9.2026.11.25.02.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 02:08:18 -0800 (PST)
Message-ID: <62bebba4-38d4-49d2-8082-8eb95659949e@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:08:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/net/can/sja1000: fix receive FIFO corruption
Content-Language: en-US
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Jason Wang <jasowangio@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
 <20261125083350.331457-2-haseebashraf091@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261125083350.331457-2-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06b394 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=a_U1oVfrAAAA:8 a=CXJRVzT0RlOygCfBqsgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: VuN5qXIprBheLS22subGimdlIc1UrgkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX/p70a06VZOMK
 xcNgOa49GtlLrGASLVUZw6FT5trWEdAQhvBnnTeKlaTaRcROtN3ygK936TZkyQp/RBkB7+PLElU
 ao8i9OZ675tE8A1bX9cDrfl4wh0ZWUUOA/EIxNAR53lG8vNHUatsGeytapecMoRkVAebxsEtxWK
 1DlPC/SRhmTGp1/f2eoHV6gRc2LpW+/fZ7GSr9d340Pd065l2EstilegltFqXphQT3oRW81vbbE
 sSaNZrGiOmPy1/B6TQ/Lk+3LLrSIGipJyyh3rV2PMWoswOltjRtJnOMnM1CqReuoDoS8bfjpX52
 uxoWx1Wd1YbykgSp5TXwp0u45vUIhTqsp61a4rQONscz0sX3E7iz9jv5Cq4N/l1m1ERce3QHKT2
 37ww34xPsy3hh75KpGZ4rjhVu7ewVRPHu74KYW+SUw2BIkpOYOPCR+cxkEhmBywv7/vbnv9dCxX
 8cuoxwYqY3EnG5G+EHw==
X-Proofpoint-ORIG-GUID: VuN5qXIprBheLS22subGimdlIc1UrgkU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXxxQHC4hVzXp2
 ivR5zGZ0dBsEw0FUgQ+pv5eiWC2s4EojwhjO1ho/PApdTxIUM8DNOkr+F+p5btKXV+ijDbb6k26
 X0bFxfZ6qcFmJOk75rjrYOqJRZ6Zef8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250040
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 25/11/26 09:33, Haseeb Ashraf wrote:
> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> 
> Remote frames carry a DLC but no payload.  Do not enqueue payload bytes
> for RTR frames in PeliCAN mode, since the release operation consumes
> only the frame header and otherwise leaves the FIFO misaligned.
> 
> Reset the receive write pointer on both hardware and software reset so
> the byte and frame counts remain consistent.
> 
> Fixes: 733210e75465 ("hw/net/can: SJA1000 chip register level emulation for QEMU")
> Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> ---
>   hw/net/can/can_sja1000.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 922431effb..580266cb07 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -57,6 +57,7 @@ static void can_sja_software_reset(CanSJA1000State *s)
>       s->status_pel  |= 0x34;
>   
>       s->rxbuf_start = 0x00;
> +    s->rx_ptr      = 0x00;
>       s->rxmsg_cnt   = 0x00;
>       s->rx_cnt      = 0x00;
>   }
> @@ -69,6 +70,7 @@ void can_sja_hardware_reset(CanSJA1000State *s)
>       s->interrupt_pel = 0x00;
>       s->clock       = 0x00;
>       s->rxbuf_start = 0x00;
> +    s->rx_ptr      = 0x00;
>       s->rxmsg_cnt   = 0x00;
>       s->rx_cnt      = 0x00;
>   
> @@ -345,6 +347,8 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
>       buff[0] = 0x0f & frame->can_dlc; /* DLC */
>       if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
>           buff[0] |= (1 << 6);
> +        /* RTR DLC is the requested length, not payload stored in the FIFO. */
> +        dlen = 0;

Do we need the same fix in frame2buff_bas()?

>       }
>       if (frame->can_id & QEMU_CAN_EFF_FLAG) { /* EFF */
>           buff[0] |= (1 << 7);


