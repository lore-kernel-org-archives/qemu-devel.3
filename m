Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B9C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBAp-000213-CU; Wed, 26 Aug 2026 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzBAn-00020n-VB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:48:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzBAm-0000yt-3c
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:48:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAGVZI3732388
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z4tRDHoOZLp0SlQS3YNScoriGEBUM0Wk0uFzt/ts72k=; b=kajymWGMKRjVPoEB
 zFmnPRWQidBFGkn/OzfdPhDK71UK4Cb4BdJYwE0XCZ944GMMaz5cbflPzy7jWkBq
 UwS9GrLOY0b9KX8dq11aoyQQBgbQbTytAFjYfk9eC4EczBRDF7Otbx5UMf19Fo/y
 Wkno067bJJjFMHDJM17QgeuiJGiN8Y26RfnEhdi8Z6ntkWH6XS/it4uU98XvP8MH
 qbb04uFiJtx8E6Z+E6SrGnYUg0OqFGdDnuayqbkJG/hleu3gOD2goIPxzSq6bsF8
 vIKFDNwZXPUQ9+PNdBlLloRyuDI2d/mL/FcopaiGCUQz4ze86ePhdfOrpGpd4aq1
 p5wxxw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqr96v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:47:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso14756691cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787741274; x=1788346074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z4tRDHoOZLp0SlQS3YNScoriGEBUM0Wk0uFzt/ts72k=;
 b=SQosMHxTdV3L1U+qBG/O+UudCVqvU1ojdKpZCuR96fGqfixsX+2SyNpIvJXAS+eOR+
 b1GSHqEXy7vkiewgGd6bf/BqNoRwjyEqYY+3AEjVyo5ltegSnAgorFqM3okvdmG4Y+GN
 zS+S5gABswKBfToUHy9NhsG2RZpT13ytQjluWgWTWPNe4mq746HefEsy56YGHjhc0/ss
 Ljz7Y75+sSkLXw3+JQiHYDfxmvcTN1A9V2MuvQor9+4dVYGmMZTjzespD+gHMjJ4L4mW
 TKjw8PFQX9OXllDbyypQKBx5O9cXX05RxUyTOvF7pvFvlX9Vyemy0W/5BAtpboWTKK7L
 CM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787741274; x=1788346074;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z4tRDHoOZLp0SlQS3YNScoriGEBUM0Wk0uFzt/ts72k=;
 b=Hatn3YZj/0akptlaiqWPiSDCG8jN14hqwrPHn9IzJKdl6zqxC14ZsnIr7adA7GnlK8
 y+GfcS+8OGBEGpM24cSiFPMNPwlvZTlrBch5WI2xZYGLePvtSEpP+JGpnKG1nMdLJQhO
 nuovi8JoR2/CNbmxu2huVkc5xC4kUeZ4//33LrXROy3je1wmXpyS1yWX5IsCJ3RAgDiT
 ZPfcycsQ/bbQNR9eDoZ6QrYFUvHrMOT2Lno8FxOUTVPgKH6NCduzFVAESSXu6DK1qdYB
 YSzd5dXD5D5vF2yZs6lx6rsqw84puTAjj5Nv7facKwAyycW2q8lJgzTzWZwcSjCikKpH
 er+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMc5hyGDxPeKY4iWN+D+2gUfbtrBCMguEWQ74qA0iyyxwjhB0oJZHIXsm0qFOXKjVJUyIKJgiSNcnG@nongnu.org
X-Gm-Message-State: AFuF++mqLnCXTmYDalnAhYUdRKFx/TOO8IdjgIzQF+4SZ8uHY8uQiOLP
 /TudQWw6gyxyC+xCUVkdFzcE/PnqvMrP05O0c0g+7tLJMSHm/oyJYJEh6cJUpHCZk6o7Ol9Kqxb
 NGIVcJ/H9Sn7744S9wc/Gx7qrQRIKQxBFBqKiaFP4vEiPSQoxptmjTZb7rQ==
X-Gm-Gg: AR+sD13T3gt2HmD8H1Qp45yrhem6Ifi+OD8XZKijy1pxue9C8BkVGGdlwQDhLyLa/zg
 ul9Xi/965SuxXkq5cwIC8fIaAUr2QWl9GNUGNFHvOOepFB+FE07qceBJeDiclmTLCtbQyT1jce/
 fcduWHIb4ufju9Nmfkc17n4ef4Za8evcPhkGZCM8tgM4Syx2SfG0h2ykgn755AMWwys6kdAwlFL
 3USwBb38BeC7IRwfiTcoJrgQ43W8bKspcH0BJvqxvQW/7lkajdsUwdqzXePiq8BmWtKfHFslZxc
 0HGBcqCGv65+953M0TRKU0BRZU+J46vUdmTaCKE+FGu4oDLOPcScfj4emMCToQnK9O/oNO6vEHe
 WIDfMsvdXAVKTp62+ojMIMi5oraH8VjllUONMTSQLw1h2MH0=
X-Received: by 2002:ac8:7f52:0:b0:52d:d0ec:1ba0 with SMTP id
 d75a77b69052e-52e423c91dcmr39565291cf.41.1787741273863; 
 Wed, 26 Aug 2026 03:47:53 -0700 (PDT)
X-Received: by 2002:ac8:7f52:0:b0:52d:d0ec:1ba0 with SMTP id
 d75a77b69052e-52e423c91dcmr39565091cf.41.1787741273453; 
 Wed, 26 Aug 2026 03:47:53 -0700 (PDT)
Received: from [10.254.188.74] (31.18.205.77.rev.sfr.net. [77.205.18.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dc960f24sm23875585e9.3.2026.08.26.03.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 03:47:51 -0700 (PDT)
Message-ID: <1f70abfb-b5e4-4c18-930c-851c24ff39b7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/qemu-iotests/qom-set-drive: replace with a
 differently sized node
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-5-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812121500.1034178-5-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX8vjBaXYXeM2y
 FngUcg3hbJXPWFjMKpIzBlP7pev9Ak1hFIaqMjYngSZrzPtZhEEFV7YgXEML6nV32BgDiIJxCqN
 wXjMGbJLJHbd6vnd+bIurq9XVsAWo9E=
X-Proofpoint-ORIG-GUID: Nc3jRQsIJkx2h5LYlZJ9_3qNiNfOz9NB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX8Jmo0EtIaxsU
 jUGWVAV/OKCfpZuxB2TtHTEjpKxkvEYfSAWh5klh1G4dyEuHQdx5DNJ+M7LBVG8Py5t1wUhLKu2
 AjIsr/UVMu45CUnacxKdVUpzIVekZUHghSx8VwPBUt0yVSdIG9xiyfY1iI+780eqqPJCatpLZbl
 Pq2CMHzWR6XjK43+J2s0Vzhyq3HP5B2xnFlxr5HWD1PDCcfzlXyI6BciYFel5x8jyrgaK259+qG
 9f2mucQkDhuD5RbXxvp8Sjx51ADKxLK1SecgMerZBIXWoZjXhQjwQUdc4ro6bIGxZJ/XfZHovvN
 tNBTf+SZ/aUb1dTZa/uB3SgmBTwJ07OsSrQr5i3Djf67r5CknygUUPO5NU/004Wff2DCQf9wzAr
 35NSwqarL4SSyUx91hgQGO0IImk0ZFOlMWDSurEXLpivz7h8aHXwlPRfh2yMtmIG5gHbfafl/5U
 qohxZkGv0U3soRiVnew==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8ec45a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=3lFKFk2zyOZBiYL4tutsoA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=nb7BjybgspFb9Ieew1EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-GUID: Nc3jRQsIJkx2h5LYlZJ9_3qNiNfOz9NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 12/8/26 14:15, Denis V. Lunev wrote:
> All images in this test have the same size, so the test never reaches
> the size change path of bdrv_replace_child_bs(). Add a node of a
> different size and point a device at it.
> 
> The notification itself is not visible over QMP, so this only covers the
> block layer side. What the device does with it is checked by
> tests/qtest/virtio-scsi-test.c.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/tests/qom-set-drive     | 14 +++++++++++---
>   tests/qemu-iotests/tests/qom-set-drive.out |  2 ++
>   2 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

