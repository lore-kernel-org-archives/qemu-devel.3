Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB97C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGP1-0006oP-Rv; Tue, 21 Jul 2026 15:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGOx-0006nk-0V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:45:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGOu-00064u-BT
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:45:13 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2rIE2418748
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hTRf4hMidRx56AxL2y9t58Q/UDXR4zPSonxUdGzh4VQ=; b=nXV5wajgks47YQI/
 Uk9i6a1y1KujyKc1bO0TggSZXJHuUF1rkX1oDUDCa3lQxbX7Pe9TFRZvxtZ0yeg/
 3H7GablIG/945dgdMwxZqs9atqOW61vZo5WNieDZ47XSwG6uGClZTKM8pJo4M+AO
 paXenAEUgjBaBjNXmNqckBPIzUljPSGMhC4U90LBRGAVMLiiyryMMfQWsML5fnFx
 jIg8gz3rOPlxSOemW9QzQq7lnWDbIfNWvmrjLkyPwfEFS5DZZGbmqBeZSrL22jpa
 GLrtA/KOt/YHshOtfChkGplgAFZ7sOQBe9a4OzAkMcDJWbIVX5S7k9vHmqOWs5i2
 W9iktw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bs9wb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:45:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso21548761cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663108; x=1785267908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTRf4hMidRx56AxL2y9t58Q/UDXR4zPSonxUdGzh4VQ=;
 b=WK92uEEbaugQnPXR30RoE81ua4ZKrnx/0keNlmag04sAUaIcUUjxHH1evPQ8IjuW9t
 zsWGDVzdGr7kHYxhf2CAWMFjfbrUnVGb7uBJz19+jXyQndTyfXaKdsyVFeBC73BFe7sI
 z1Ah64F3SazpcHUR2GXvES3ry73h5vDb1uFhCwNuiu3tGr3TQAHBfKt9HLkLrv+rVe1o
 ja/ypeByxq+R+yuZPmGlznBvlx8Gifa8q+fGvW57DtbDaF7vbz4P0CAbbN+W6N82s0U6
 kMinhdH8zVCTjS0cpCHmTclT6VelJIgJ0fGxRy9VqR7p4FB9W+V+Qfzi1LhBfHzJYSij
 urLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663108; x=1785267908;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hTRf4hMidRx56AxL2y9t58Q/UDXR4zPSonxUdGzh4VQ=;
 b=AiIzj687V9129AByx6N0lnBG914fmgWglN2sZMB3ef8WgKRjV+DSIOlVPCg/4gz+lV
 Gfuk5ZXmDFsf3gdSRpaWCCI2jpP0T6msfqBmhvap65JaxKiW8M7MbZfLBu7KjhaTIxDO
 u9rQko8vkAhicFs9yN3nP/7T/sy5DwgjlCOz6aVD5A8WefCFM6iXKdC8KaMuFuwFfOx4
 VhUmluyf8THM6+TwpFJNQZKxmolqaXXT2FM3VfN8bXF0qMtjkOwkubmwOnnTRMm2OVyJ
 zC6HMcfkl/QeC9WlEE8kuJ3615XRufXED/Mm7iDJYXAbgSCveVzlqk+/MjFcErPrcEjC
 26/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJRJNy5OG24dq3gz9O2XlfdCrjFG1cY1OvE0gA7/6OEj2MbpLzKCLstPE9z1eQ6sJCK5riFVF/mws8@nongnu.org
X-Gm-Message-State: AOJu0YxtlpqSM/TqBlBfuYSlWcCySWdnmRGgb1Zg51sDspxx+96WjEwf
 Y5M1xMRZbYjHF/67zEaIi7vd4alqyy4lf3Xh9qlEaOvH/7VW2enLKQYyD/KgUBDk4xN8UdNg215
 dDcWBuFH3UNqalWNFZJowV9kTrtWMg//tP/lipC0KfjuBhyWOUZNk3nrt4Q==
X-Gm-Gg: AfdE7ckxNxF1THmEiDs+/oDdFZHkKJy5J0KwE6BXulp3C9YiBGB+vHHC5P9d2kty7sA
 ipvU2HEziRv49PkQM0AX9/QhfrjQT2RHwAjJOBulxNzG+BQs7imoE+0MRTNaIKqJVKCx81qEzDj
 hpDBpOXg7pGPxeXThH0R9G4kA6fb3x19/nth3Sj0DfjSr0YbUNFTSXmKwVkUUZDDYwKafKPcjaJ
 KRhGzC9kRpx4T2nNYXDc7eyRHlOHVYHCMHx0UIKAkrwpqwY4N8l2H3FTwuPIxr/q4d8L/FXz6cz
 ze9klS4hqJ3UwTreTjJOh+QC/JemwrLfhbHQ6pCaTH5RNoLe25UIZTapHe89hlb6dydXYFMBy6p
 8BSrJTbCGjaqoZ/FzSIavX9/6NhZfcUTOSALPbfnO7yx8VJI1pNg=
X-Received: by 2002:a05:622a:28a:b0:516:d955:ea2 with SMTP id
 d75a77b69052e-52138ec69b3mr181400641cf.0.1784663108002; 
 Tue, 21 Jul 2026 12:45:08 -0700 (PDT)
X-Received: by 2002:a05:622a:28a:b0:516:d955:ea2 with SMTP id
 d75a77b69052e-52138ec69b3mr181400111cf.0.1784663107496; 
 Tue, 21 Jul 2026 12:45:07 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edd7d3sm40178752f8f.25.2026.07.21.12.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:45:06 -0700 (PDT)
Message-ID: <0674d5d5-fdcb-466f-96b4-ec6d6a9f3fae@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi-disk: fix off by one in assertion
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260721161907.363392-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721161907.363392-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p13RdI65ELA4-bSKckintBnhmE0EavUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNSBTYWx0ZWRfX4tkmdr9g8iH3
 bOVLOmL0FLQT7INKGSmmfHvRYDVknVEjGznIcSpwStg66150bUYYC6ESU2FCi/KK+coWC5lyKYZ
 sHBoDww4hQJXdhIrRCvcwu1vmAS3KNXYtQqxywNLhC/TjOS44zAMlKW3eqweT7NuLCKenGeU9PN
 4YrdWRuaJPlfBaxu7qLFkea2ZGWdwoa9i0eLzTwZQ/k1VxmCczvvs7n+MLV0uHEzzWqnTr2WxM0
 bmSfuX1dp7zXt6U+uKoUAgEmo6SSfp+NwLE1O4+z4gcgkr6KqtRivuCbMM0LyP3BQEF2GmTbcCs
 bD7WxxhAQnv1dljOmYCNQ9kR+V9RnwR45Si+AX85i+ZdaxJkJ+uktPCOJ11YJXmDaMADSR4gTQG
 Q/q3926hBqJA8vdgeHuGoPbnaLJ1BS87+w3yKyN9YrO4aHenjtPLgr2UwPMx4TReeVxhbwtYnRs
 phIMHgtH+5vXM9QmieA==
X-Proofpoint-GUID: p13RdI65ELA4-bSKckintBnhmE0EavUw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNSBTYWx0ZWRfX+7FrgUZmLSO2
 kdH43VNHjan/SDNR35ofk5o1WmrgV/1SVsuYf2Dk/+rYVeniDzekRXjFIPV+zkUcuVCtryhCmOb
 zFoQX+iX7DFCZXdE3ClBSJfAjZj24WI=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5fcc45 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210205
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

On 21/7/26 18:19, Paolo Bonzini wrote:
> When documenting the invariant that mode pages need to fit the smallest
> output buffer of all callers (which is SCSI_MAX_MODE_LEN), the expression
> used by the assertion was incorrect.
> 
> Even though SCSI_MAX_MODE_LEN is indeed 256, using "length < 256" had
> two issues: 1) it used the wrong operator, since "length < ..." is more
> related to having room for extra data; 2) it missed the extra two bytes
> for page number and length.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

