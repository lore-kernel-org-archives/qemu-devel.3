Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8610C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woG7y-0007mz-8T; Mon, 27 Jul 2026 03:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woG7w-0007m7-SN
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:51:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woG7v-0000lz-Ii
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:51:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7S3YA2937493
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zfVroPym+mb6XrSxOsuSsRmDh02p30v+oiK7bSf8E1k=; b=DnbQ84dpsyk77Ung
 41/xcxU979HHFSAb0Rim/hW+Loe+WC4YV2eShybqH+2yJWVeTQW0+dbStAcew+CV
 r4YPe4gIACzsJrCUSLVVo2UbBlB4xT10qz87x5nN65voyDqYOuw/Fjp6EdaJU6yq
 UKYsEQaLYlb3CAqIckyLRl3eRnNs88K5eZmlaSTP3DDbs95AD9pOBaZ9dTFh55aJ
 8iGijRdbwODGmx7Bqd2b7KUYji4HZZFFrwGhAiVl1NCDuiHM/PpCSgXoxPsluNTv
 xtFZInMLQUZdTV/geMM4Qq0OvqxyZu4mj7xps3tBmfsdgdiinTKfouyKSVV6C+lf
 gKRAOw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnwevxwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:51:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso41947481cf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785138713; x=1785743513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zfVroPym+mb6XrSxOsuSsRmDh02p30v+oiK7bSf8E1k=;
 b=ZC81d7SUAfwL0xLubgwngQVaGYxaMaDUFELGNLkD8BV39TtLV7NX0a1SQdOV9pe4x0
 aeguRCjaXXYAR4t3ncB5OrX4vLcqV8R60dhY0Rwj6+9HTEf09Wh/E7BW5K6l4Wg4SgRp
 GnWUfadfAQIisaPiV0BDI5aYypbvvhjdwWF14aXEAINPQgafNzr4FDvjB+WTwoqocv5D
 A3TAJYtcQFgNKGSVqJix5tjIqReC81wah88rZbdIMh05A1ZJG+Fssap+Xouyzwo0IVNP
 zeDaDt5tjWa+3QIDJ/N/OOQsHQilnB4HX2v0xnQkoi+tbYcLDH0Oi6cR/SKaFLV+Tcwe
 7/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785138713; x=1785743513;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfVroPym+mb6XrSxOsuSsRmDh02p30v+oiK7bSf8E1k=;
 b=Uum4ChoAAImm9FnWMdXgerj7J7GEhXFXSoroHPuJqxTmZ4tCNqjK8cdsJMy/CXZlrv
 6CF3KKRjLT1UfZBHWCCZX3mNcdAzL8xr4NsK+hvYUPgOPJnuGEGCYNxDga4c6BdyUBSc
 ibihFHWBdBuxAPg2hqiYvG3EHDpZ4Waj1w60xCuwQSUmvIDNV3OeCafJsi9+JNqSbVRW
 3KvDLHxzDud6a2BRcuoN2xlASjEW2gh/ZtRYf5im4DD8hQQzZ056fq5BpBj/ppD5KJEG
 LGMX1mIv4xLAC4cyuMbPFWt/HdcVKKLPnv1X3iIG6v7+KkpDbo7b12MMRQ9V9DRQSFiA
 QbVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxfjhAbGf+2DI+as2rmJftfqPbIeeMQJY2QY9mXCcr7gjMIJmvT7DDH5UYfHbz47X52w1bbIKw6CK9@nongnu.org
X-Gm-Message-State: AOJu0Yx6R6hP3xWV5SMbsm2YlIqxVtKGYyuNVB45g1zcy+YkZDEF0uOr
 VXbrbpZVRNO4EknfKhTnMXI+i22T6n2wlS/ff4f0c7TzyeqX+eFQxxjJAoG85bsOubwU8vt8N9I
 05V5D5bxttq6T5laaAmZZCp8LIfOnBQ7gkSXQm5njdlE8dr081QYo01IMVQ==
X-Gm-Gg: AR+sD12recj4WJ75FBT38j0i/rQJcpLJ5p683ZQIWqHmaxZvgcZn+bV5ubBfFAZ9EhG
 IO1Sj6eOJyhDH8GkFrf4cbnclfnVJkK3l+pYj324L4EhVKGrX6lpEAMdAGfK9FTJxbXGVwr+jyU
 +FPVOy0zTMQ/eYx4mVSahbDHkH+wkDDVd3ltCFfx2g2kzJXu7rvLIWzcrHr3OaredSHYOuBEbW0
 WiwwW8QcjfCKt3L6NWMBRCt2kH0vgExXr9zmRG9x23qAifpYCflBSYLHChctrXNR4NVNOFLxVet
 V+djFgMjXeZy3XGHpUUzr+TGnTqFNoq2YgHcmSeZREl2AM7I6nKpam6v7Chn7TRfVPAqHjLmspt
 oHKMkcMcj5N1WYScAykjFIFWOv1rpT/6Z0rjHXAYIxy4Fl0MmnSo=
X-Received: by 2002:a05:622a:1906:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-529a86ed577mr76478451cf.62.1785138712925; 
 Mon, 27 Jul 2026 00:51:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1906:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-529a86ed577mr76478301cf.62.1785138712585; 
 Mon, 27 Jul 2026 00:51:52 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm47871932f8f.6.2026.07.27.00.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:51:51 -0700 (PDT)
Message-ID: <427b6460-3c87-4f1a-9266-e1450733f8c1@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] hw/hexagon/virt: connect pl011 UART interrupt
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
 <20260724183648.190531-9-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724183648.190531-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfXw2w0zlU5Nt49
 edALUlLJCeuJMqKPWifH/0DYMe8rZX+ZmBoi2Q4B6iW3d+zcjWwL1stesOf7x6hSV9DuGITZ0+i
 sb65u5bU0JkE4lIlxiNFymnF7+JZwT/Jj6sLcwtm/utfmzvNebhN4BoQS9OpcthjOHXLzFKWP8+
 bsbdidfOmZ7YJpArOQymTJEaEkwndbM/Jir8wiDVs/7HKR6fAIg3lnzBGW0+22nGXdNV1EeIVF7
 k0HZRcYBKXwNdXL4EZSFJoq55erWtq6C0v3QX1k41spm42006VbiR96wmTI2s5qvsmMrTlM3JA7
 qZMr+1VTC9U1QXNIgSscQvBDdy6vYPXr+dt07g5rKiecuxQeJjw3qbChkVyjPGfHMKyRiVdox6A
 mGyXdY/oj7wDYwKjOnKFDzQQxBJaTUe4/iRuJtTtNsHq38bPdZMgwP52fLzWbbzgkWOJ5YMQ7Uv
 aTjg+3fR2d94t1OSTBw==
X-Proofpoint-GUID: A4dIpz9GLdFpCoAUWOz_0nBkAQHEKt8r
X-Authority-Analysis: v=2.4 cv=S77pBosP c=1 sm=1 tr=0 ts=6a670e19 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: A4dIpz9GLdFpCoAUWOz_0nBkAQHEKt8r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NiBTYWx0ZWRfXwWj/+SSU1yK2
 2RvgNciGO5wAwN8JFZ1SNbKIk2b5dYVP2IG+ODBrrHZvGuqeDM+A5W0w0JnNcrPuva5XfSQKx+z
 Vl+euGw3GuoSY4/5S/lJKXjkvzSwKXs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270076
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

On 24/7/26 20:36, Brian Cain wrote:
> Wire pl011's sysbus IRQ into l2vic at IRQ 15.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/virt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

