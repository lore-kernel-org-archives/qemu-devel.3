Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1404FC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcSV-0000oZ-8o; Sun, 16 Aug 2026 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcSU-0000oA-0j
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:07:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcSS-0003sk-NJ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:07:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkuPB3631485
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 13y+9o1Ozcn7mPTCBn6QY2ifzE584n+Fjq917jZBqVw=; b=Zag9elMoTEiNSOUT
 iONfWdK8X/LrswW9aaNogkgQtrGAMzhAR7hKqTxSmFJoKAuEkuXcDPWLRaEptt00
 4r8Fz3XKUUYTAyxtQStVWjryRaNpwj+UJ0/3cHbshb38Meg+lUtierCQa25FLJiV
 0niKR1P9CRZIy7hVZJdqgvO9QJjBWW6TFZqOXQxlN43nCbQIb5QZ6uoMyKXhJtF5
 35HyJmhqMxiVLnELo0Q29nam4YIKThzM8wFgcSbyYU0sX5V8IWd59MhPie42SUhk
 8sd8XL8VDnRfYhFpbKXTHj3/n/0HmpiARwBb6N6X/8eeGn71akMvoC+HgNS+SXc4
 XH/0dQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekr8u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:07:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930b571432fso247482085a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892851; x=1787497651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=13y+9o1Ozcn7mPTCBn6QY2ifzE584n+Fjq917jZBqVw=;
 b=jgUwn2sw7tetoT4hystJiGamWNgz7H9N7/2tBXNX31nLx1XbL4qUzd4cc5mBKS5Ubm
 nED1dFWGsSnEcKaIVMGjQ3UWywKvYAsBg2PfNG76QPCD8Q2yzW0oKgt482lrvQZcmXiY
 3LEAgHE/qV9Np8XZHcChHR3SMPaW0Q0JRTxN0os0yxZd9v1ba7AA5c50unRXdM1yrqoy
 RjSmZtW32EFV+3l9vkETodam07Y4Eb/AaL+13YAjFmGCJPTgMrqZcYTEJCzwD/q5HVFe
 XWS13LkvVIVfPs14VTDblKki0l6Jw3Tce4Q4MDBYhvDxqO63mNsVXNjro4SsitqNWy+X
 jvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892851; x=1787497651;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13y+9o1Ozcn7mPTCBn6QY2ifzE584n+Fjq917jZBqVw=;
 b=ULlreXUsbOjsgloT3zVQRWOKGFXElhrueGxfqzDqShZNLnokJwariOAu9uzjvVeFXd
 p23Vs+4E+YSThmqNpwEukvofMk2oJLK0XablgfhAYbCFZbw0Ly4O4IwMd3n8n83IaCpn
 ErtEKofn9V/txzLgaFM6K30hAKpdFC35XMYgMkjPqkpOxxkJaIjCBl1QKj+l0c3Ucgcd
 9QIDxEKU/LlI8mEZeBAtH2NffLHAlytynmAGq6b1m26ssEp8NS/+oUWbl61KuAHgjpiR
 /z3/n4Apj8y3x/KAZX0IE8DsR/qnQ8hMRiHHbQH9fPzPvEx5EQpGFn5kh9Q3LkUILKVb
 dGhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+78/eJhsZFf1WF3ziFYZ5jatXH0ror6Ux8MyYJ6bd5EfTSYU2IvwIJT6VFQZFy3+68HIW5Wi05Ek9@nongnu.org
X-Gm-Message-State: AOJu0YwoTlSLMbijpJBtiFKcy6hSX9IiWv02mtIdUQYaZB3Pr4GXPg2B
 eRVTCybK+mutC1klp6sr55rae/Nz/pvjB7sNrASROugARMkU2IkiEs0MG4CXoJrVQq4gn6sRZN+
 P10tGgt7Z1LrXKnHdMay4x0QLMesL5DZEPAm9IWCSqnFkZr8kCg3b8jEEBA==
X-Gm-Gg: AR+sD13pVM6qrAD1aPMSnnmKbvgcIh3ca7TRwTGUmNvodZin47WfQehQglhLm3fcTX9
 jzV6EJEnMO073rKRiXhGF6Ca5reHbMfRP5UcnN89uP5QesNKDQt6wKRJ9Mtspfp5Ybt3uGEzI+l
 w/2EQ5PfhPDdJlZDew3NRdFJvgam/9mLu/vkfJVslnKIIsM4P4tik3B5+OKZ2bYjZcW211fpSJo
 ZRBLC2+KCTvm/sqEaSuWJ1N3YsyOmMmdC9WREVFskbfbDAXofplvF8eNUkbPuYvk2XtSPFvPjes
 rLspC470aSf8n6A5EsQEKHc9lY3o51MRD6bQi3Erm9W0iBuhi5UGIw9b2WIG3DQDGXoc6txCO0o
 LEc3H9ezeyHWnHAwa96BN+HI9oJ8bhG/W0aE=
X-Received: by 2002:a05:620a:4013:b0:932:db03:4da3 with SMTP id
 af79cd13be357-936c079414emr2669848085a.19.1786892850842; 
 Sun, 16 Aug 2026 08:07:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4013:b0:932:db03:4da3 with SMTP id
 af79cd13be357-936c079414emr2669842085a.19.1786892850474; 
 Sun, 16 Aug 2026 08:07:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100073sm67837245e9.3.2026.08.16.08.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 08:07:29 -0700 (PDT)
Message-ID: <e283cca3-2e53-4cea-9154-2796797ca25e@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 17:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] hw/arm: sabrelite: Store boot info in the
 machine state
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-19-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816131300.51799-19-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81d233 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=P5mgNStSnDlmL_58Bq4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDEyMSBTYWx0ZWRfXxM6aDcVlqqqB
 bC075hP15k+UR342HdNX24x/lL7y78OgZh+h4CpGGwf2Xj6fH0E+sjNktvRfsk7KWcCgEJrYuVS
 SpFuWCuKOBm0QEElYStx2MOSb5MKxl4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDEyMSBTYWx0ZWRfXyIy2syVoeuxP
 aA8mACUzxdPImJf56jSGLMdTjVmEA4GHdp3HzRdP7iGdDwiEHCISNukPMIVHB80tZ8FQ9WK017O
 3uPgk9J+ZrkHttddVtI/4eVPMGWktd/u3O8GHkKUjmYNohvx8qYSQJ1jB3I+GQ9R1xr9A7xHcn/
 gJRbHVksMOB/Y2ZKt4LFzwAdHjdzvPbMa2+AYa37NeMl2ovAJ+hQ/itfxz3np5lnziL8IsgpapF
 9+J+lScpxzRApPGPTPEWT+tNk/PTZt8R3p0qZE8NB3uuVDNrwYbXWLzDCrpxmbsApHV1BpP3Nj9
 EfSK7u9jCgu3BHoQWLYipdOhFgmE+mq/4uDP+w9M1UV7IXw3MJKVlzgTQjGSs88IVcG+FUbznqM
 RvbcA5ZCtm9DGZVi8Sa74ajzrwg6Hqz6d36RaVyA27OPKnAtXgcWCmdfpq/CB0TrSCabUYBEhEr
 CPm52Gzj0K4kc1VSi/g==
X-Proofpoint-GUID: h9N_Y05xcmA1rCiKjsuxrO0vTe0EuW3w
X-Proofpoint-ORIG-GUID: h9N_Y05xcmA1rCiKjsuxrO0vTe0EuW3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160121
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

On 16/8/26 15:12, Bin Meng wrote:
> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
> 
> Move the boot info into the existing SabreliteMachineState.
> 
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
> 
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/arm/sabrelite.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

