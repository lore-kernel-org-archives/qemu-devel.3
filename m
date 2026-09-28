Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677AACA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBE90-0001db-1R; Mon, 28 Sep 2026 12:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBE8x-0001dO-Qo
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:23:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBE8w-0000dG-Ar
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:23:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEe5hd2143319
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7gwaNceJFaEwY2aWgYK5A4lrN824j3bCZrxzRCxrAmM=; b=LhrbWT07onf+vUpG
 3f7VqT54stsO3djEYDl7+XcZswW9dvT5NamX6Y32fnqSZ18tg2D/fXqpRJwST+5d
 lWyUkvBp6k03KNMgHsH2BYT+t+RVrx4O/x0HszFK+p3/AoWfObIE+wyQkeE79e/B
 3cyJW+x7hmgl4W6TfbgovfLtGR6Qbk2phM6NggVGZnY/6g+GCv4ghl9I1TyFo0Q+
 xvoN5RklZctm/PH4/iFHzc/HRv+xQzXR/dH12WtcRGvZ3EE+1UNbxg7M7S6YYOLk
 xgsKvFMEd5a5v+LUso1jRocgWLKZLbJLjlw8YZzj8whlUR3bjstRyjfK/Pmf++4R
 ALIx/Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfksngt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:23:52 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7b777d15693so828986137.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790612632; x=1791217432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7gwaNceJFaEwY2aWgYK5A4lrN824j3bCZrxzRCxrAmM=;
 b=WNvAYCNMj72MkM0CufC8BuRvpNzm95P62PRZOCjELia54rpfbqDmdsShCBRFOXgGGM
 a0jfsEjC7SQoL8JSGgLVWen3y6DfqxirC0tOC1k1yzrDxcxgVobOGU1+zCZon9/lzer+
 wjV0HAHaR4QO3Mx/Mbevx+xermuwrZw3swqmTBvEPxOx1MLPgJD7RUX81QPbKMPSjB92
 Lv+8nUrJYm6CTX+SeW22ayc1KhGTGyE2Pi5/9lwBOBXJoVb6Rr9roWYe6kH4ZlhHx0yJ
 O1IhW6QGqwmkKMWcUzfjCym/d/DOm2izunE/iE+FGvdK6oVCRWOvuKzQDheHO0WN5Tsw
 Pf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612632; x=1791217432;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7gwaNceJFaEwY2aWgYK5A4lrN824j3bCZrxzRCxrAmM=;
 b=RsCHAEbEbEJ7zCXNysP2etVSIUZgu0TbDmjoBF6vd8CVc/KK4crpsfaeA8qcRbW7m2
 py3gSKlUA1vOvVbTAvLvHox0e+QgEra+gJuK85KPIso9z+1O5o1X37CoBOvoR00ivfWQ
 w/x1pKEiXg7TtZmxOm4ypQ0q/g+64ZNz9Zus9mqgVAnrUua9Z/d6X1pSFw+C5qcz2ZpP
 fNri/znL9nPJtXL6blFfx5deaqOE5MflKYPdra8x1u++2qPw5bIpJGZvmfZ+2leyBk3f
 KJbKII5oLE9slx3e4TetqhN7TkPqwDpM2+JJHhM+AAzmr8chmdnV+MrqKGc0Gimm1AgX
 8/6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuCeSDXmr2bpTCNr5JCIpBm9vO3IGV93yUis/Q1nRSGh/FrUP+x84uDGqrIBDr5Mr2jorkUIb8zhH4@nongnu.org
X-Gm-Message-State: AFq9FYIG8Nut/kfP0dKMc3KMtvRVtwBQjCJOrWaOFWDXeBhOVb/KP10N
 nEJlKtjiXF4+64zNs9EPJq97hJXN98TTk46Hg4oyvg18aVpg3MuwvFgJnLcDqfKtJcDLIYN3yrc
 OcVTM/NTmWOKsI89A8BRuQ/E6zAweiw58pBxB97YGnO/6TnkWda93IhZ1jA==
X-Gm-Gg: AYBFou30DhbG+UzR0qquCQdw2yPuJilHJ5GXKDNBqyJ1vmHK1GywlZZvbj0a41Mr98y
 p9yh49RVZgiDy++G74X+W3WjC9ctnF3xnPbRTp++dkkdi9jbe8Er9OUmwe/fjJJtj6CJM/Kksmj
 KOqYxLBGWQMwkQzG0Git/O+pwTOXr06rUNcg4F2MmII2BHGm1d1pLLH4pgX7xXWVxJ0gpZoRxg8
 q3uDwPCIm3VR6XhfURg+yaQ4iC2FKsMvlY/3lO1dnRgR7AtPj/TzKb+0NfdV7oYdyEPmg4RPRGc
 wxSkLAOMzy+ftZ+PNSNoglv+o/sWUF451dg1U/9W09rTkdnLJVtgMp+6A2Mkj+7C7mbu76NDdV4
 3TF/TNDK/rtG4UPnTAViiVNqdZLZmYVIxUw==
X-Received: by 2002:a05:6102:5346:b0:7a4:da60:acfb with SMTP id
 ada2fe7eead31-7af1c58fa5bmr5212622137.8.1790612631938; 
 Mon, 28 Sep 2026 09:23:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7a4:da60:acfb with SMTP id
 ada2fe7eead31-7af1c58fa5bmr5212606137.8.1790612631616; 
 Mon, 28 Sep 2026 09:23:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b72fsm4818835e9.9.2026.09.28.09.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:23:50 -0700 (PDT)
Message-ID: <6fba7ddd-d3d6-4ab7-b650-4c9bbc197067@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 033/101] tcg: Drop division helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfXyECXBzfdnzLO
 0z1lYoMh4H2RbNALYJxgfxtlPjnmP2A9DvIcy1ldGXOsxISkDPfweZvTSqzSw7CHxEl20BlubE1
 s/n+/RCGtKolnfJsLdWkIGsgVJcKyMWNFfRquCN2B/GBr1HBjbPq252PjUUiak5tNrh32sp/XWf
 HnoMdIZ5LKiVFq1o++qhAUabeeXGls/NFKeLOZdWoKTrcpy5bF6DYbSi1uA8jp6uLxy2LLcoMJb
 YlOCLoII5BQ3Ys4Q+NDsXIvbKyYmJSc1vzh0y+yydYomn0hK7LdjwteiFo+JDRfsG+TPxvqHn1r
 NuYwtlb8Hf6Suv12nn1iWE6zNTavv4IGK+SIhkqtT6nZC8assk1Sy718XMZ25CBSeQUFTxA7j9a
 TPGp2+xuAxrc4AaR4bo8MTmEW+KjGpxz0VBafdPtLAfkwhBcuKSKZY7JpO60Mu5bbKjcQ9R7llo
 Lk+OVfo3dWesPSOX/JQ==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba9498 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: p8Hw3glKyBXCrzaAbRucM8hecQ39EmuS
X-Proofpoint-ORIG-GUID: p8Hw3glKyBXCrzaAbRucM8hecQ39EmuS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfX+OwZWhsqw9UF
 oWDt6+1hikUCFPSMpnEg8PiRXpVD49k2vB16XFW/ff98ZahazMJO+v5fXUnCNxU03xdw8xgUKnM
 n4WYS0tE20zNY6CGONiIVKKIvusCwLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280065
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

On 27/9/26 10:59, Richard Henderson wrote:
> All current tcg hosts support division, so the helpers
> are no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h | 10 ----------
>   accel/tcg/tcg-runtime.c | 44 -----------------------------------------
>   tcg/tcg-op.c            | 16 +++++++--------
>   3 files changed, 8 insertions(+), 62 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

