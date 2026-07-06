Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6367AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdQr-0001BF-30; Mon, 06 Jul 2026 03:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdQo-0001AN-Q2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:07:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdQn-0003fz-Bw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 03:07:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641ZpB3438169
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 07:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e2aI8LXPs/gb/+T3SjcdsDrlKg3JFhwiX90IU8c+aW0=; b=HPZpW6R515CPoF+E
 vDmbUAU5pseQ55qOA5mdSAyWyXgzMHgd5yIdQcvbn7iVhBvauIaAc3r2acWkFMLy
 WSLvqwt6fhMYRYRjCoUUh3XnIlqwWDk1r7x/ggVQpbVyWvsBntFFDVLhRWfVDtCa
 TkXxHczIlGvCNWHhJ5e8haHbbik7xP6MgeNHK1X2CbP8PIdtBe8z+jGSfX79LtlW
 aonHUIODY7V/8iaBMRb7h0MLqSg5T8jEV+A9jHVs95Jww1wXXr0gqPthMV848pOF
 WzsmXyjYwD2ZKTtZiJPY0Y47tIUiuGU0d07eTUc8LUOB/g+K24KoRQRYXdqPqQ1w
 XsliwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8n0x6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:07:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ac0a54110so294509685a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783321671; x=1783926471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2aI8LXPs/gb/+T3SjcdsDrlKg3JFhwiX90IU8c+aW0=;
 b=O9EhqsLu9mDMEpvyj3+4to8rWsiGUY37APQFXo8BB1oiTpVFbAi5kIY/UCmy/AtJ/p
 x9O95cn0yEJIK4I2M22dEiQ2oNZeGe9WmGtbJwHkDvrM/9zghmVVutSrB6hK+oE/RayR
 Jv5h9dJvuIhqWaEW7oRsc8TRmeYjYkuSSS14CxQR74qHVgYYdA07g+sWLhnczjxBuMdh
 ZplNDlVRAhfeGsUsElUkELiuYWOJ4D+x7t7A0j/VaGKZhsmEeHxaoiRoYdSy32OSGchF
 H3imu9KfG/Aq2dOH+2Iqq8H0i6vhB0SjSIc/x9n54Xn7MH2atX8Wis2V5J1105i9Pba2
 ui+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783321671; x=1783926471;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2aI8LXPs/gb/+T3SjcdsDrlKg3JFhwiX90IU8c+aW0=;
 b=c2H7BDYp7+vVGiVACxQUOauy9v6zYGMQNci7BxISyoYCJF6/0OMCioSm7PbVyRbk7J
 hAzKmrR4Kz7nuPYHwF9f5MDw++byUckBO5nVIsqkJqaMEgeMaV2GYYptdiMwf2kpVOmB
 vOX+JlXSuR+yp9Qa8tk8yVWJuXvNRpqtme1gURHq6NiSLsYkwJy/Ku6rQjtnYZLBBAcG
 un/R/J9+qBE+HyzYJwgLH0cMqdVbERU7bVoevunNJEcfsFxLuqMCXnQTVkjZvsBZlA+U
 agQmOU767hXakRT0Jk5e9CdmVAIVYR/rIRGm/PD2xqyY3eYnVOrh43JhPGAKeQ7vM0L1
 OIMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqzagvUqWvWd0qaGqT/ZMvGc4F3Jbs0MOg2uVkbx9TV05YyXL9ScKjPa1I8AsjgQm5bXGwcBZwS1/h@nongnu.org
X-Gm-Message-State: AOJu0Yy4qbhEm6idexf8i0lj0g+v6qTTJCEQCQGSpCFFEo5iQ1zqavkR
 7lRr9mrd+3HegXcUObKQ5f3s/KMKLi2PIhUmUbBdiPFcNL6HpxsDTiva2R1bopBPHE+Id3e5F3Y
 eQgJy6NCaBZeY0s5hwgmmPY+QT9yNA7SESnVyIcZJKfySc1SIn7UQaJhh4DakhSmrGQ==
X-Gm-Gg: AfdE7cm75F84/1Cw0dMdOQMQPq8WhHlVFIB4Agtrg2G5TrI+Ed2LSYHb80x+T65MeGu
 E/lpac0TkJS9hSLKsscyeYz+8WuNfIE94ZiMKjZpYJrccIgfztLknRohkWXnCMcf/4p4vi4O5X1
 EfOyZ/DWG8KOGoi3/AYc3AYwgCFK6yo+cgwSNdVZBT0U+3b1YeW0323GcLjA8Q2rbU3nreDASQc
 C+S49zmDsbWLad6MbzkNTXIIlt1wvjQNzLIU+6TEATjEykOQ45EA5cFuwE6q2KJF+grSC7gpB6x
 Y2TN0/OekhZOybVErCI7Dz27vfIxt1PS9Mt0iPkW4KBEgqbeXsQELBUj+urLHWLchx/CuuRq5nn
 xXbpnbMCbpl0hRR5HG9SB0ewCYsy6wu0XoRWa1OHo6DisNkEVvWwG9YLQE+qxhw==
X-Received: by 2002:a05:620a:460b:b0:92e:5610:e478 with SMTP id
 af79cd13be357-92e9a4c83acmr1220215285a.53.1783321671361; 
 Mon, 06 Jul 2026 00:07:51 -0700 (PDT)
X-Received: by 2002:a05:620a:460b:b0:92e:5610:e478 with SMTP id
 af79cd13be357-92e9a4c83acmr1220211985a.53.1783321670893; 
 Mon, 06 Jul 2026 00:07:50 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce0a7cfsm259083255e9.9.2026.07.06.00.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 00:07:50 -0700 (PDT)
Message-ID: <65ac06f1-079a-4bfe-8817-2f5aefa4c870@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via
 opaque for ACPI_PM_PROP_GPE0_BLK prop
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-9-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703135512.3213964-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MCBTYWx0ZWRfX1icKN9GJHvGT
 zlGzpkujyBIPYYjpMMMhdvdZnhnx23NL+SkS/nfEG/EZIdb8nt9rh11kjzchdJuQ6sl4rg0WLIj
 Hhngz1c1tUmXo2N2AYLKkdBHwsi9Rv5ueoDV7m041W/HBOdUD+87JPr4sEc+5/MEGVv4B2Ybeuz
 WcI4Wpv0lgP8i22QRbtEs2OhvMKhQwo8cCLO13WoTGbAy3Xzx+vkrgRY9P9/IO1Az+nOzRmRhCq
 y2y2HO3ulz6Ex6IAhf2QxQ0NSEyYrnNLLbSzONpSRNGr58GfhAgMjneuSbPaMmHcoJkJvSj4CjI
 hqljkitLjFxuCwkVCfDpPu+1f0fVE21IJy4wLB6+WSoxYJwIz8udIdrMNMglVhQnACgj899WTTL
 hJDXPCubNWn85vrMo1kYsN8j4xXJarYRonj/Zi3MAnQdlkk3mGqJyEHaQT6ok/VdUmqSjQcRZmC
 /tK8pyNZyN9YNiDC6uA==
X-Proofpoint-ORIG-GUID: rq8myBqfQYiKe1-uNtgKmlPq4UpTIpKj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MCBTYWx0ZWRfXw+rjeVna8Une
 oU+A128d/CIWHDXxqFvjHDj4eu/myqrW09g9ZuUfJIjtcM3cQA1hODFa4HYPcRL2IcNUYqzQKb4
 eYkNFiTssZn0RzxnklSFSnoWpMFxMP0=
X-Proofpoint-GUID: rq8myBqfQYiKe1-uNtgKmlPq4UpTIpKj
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4b5447 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060070
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

On 3/7/26 15:53, Mark Cave-Ayland wrote:
> In order to convert to a class property, the ICH9LPCPMRegs instance must be
> resolved by the getter/setter instead of being passed directly as an opaque.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/acpi/ich9.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

