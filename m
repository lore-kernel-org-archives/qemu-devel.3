Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59349C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9c9g-0008It-D8; Thu, 24 Sep 2026 01:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9c9d-0008IZ-2h
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:37:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9c9b-0002qX-IL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:37:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O36ioi258753
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xe83XlnZ1j56xkZd+32EYPsiL+aMgV9mc5dVvYXxT18=; b=Y+xPbvkbOd9s11Gc
 FTVU0nxDpf1P4hAsQnBYtx0lnEgYsVJN9wXyrUv0Q4XVy9KSev/W6ksoyZ0ODEDQ
 kdOn7QnGB8gaJJfwn6aHE3ehXkrzlTt8V6/eKu050/6IkitIRmI5UUAiqrd6caiW
 I9G6nYJorWvxFSE/caaD9wIw59R8sKqpuzzmZXg4GuCSVtjFnPrJfziOtlAP+46T
 5cWPVLqz02+PnjmLhWQRCLxl7y6FgGuGyx3jdVOudbBRBJHtw68A99kk6CsSkRHX
 DCWh+IEc6HirOaQNeiWs1YnQLhjQtcQaAOclHWxxk8n7yjhdrn1GpYoxEOmb+/8q
 2CVcKg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwkdq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:37:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so347055885a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228272; x=1790833072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xe83XlnZ1j56xkZd+32EYPsiL+aMgV9mc5dVvYXxT18=;
 b=P4UXfZa7qNhWEpgBhYhKRgfLWRaECWsbBABedz4OHqQCW1a5ckavyoM8ATPnsV6gYG
 JErqyNBFF3tK+4WYzcupmpRmZ7KIkXv70KeG2MTZllojRH+Uw+dAVgfuB2fab9rb2xcm
 lXXuuWl0F1iVN0V+CbbXde0dC1nAjyA5sy2QCFo6wP0qtGMwDuJXLzWvEVu9CBhDt6gp
 Ci6eSG6aAHzQF2bcbVP4cxMeA6SVwRI/ByxEd9a+//34tXrliLRs3N9IMjEIimQx4/4Z
 CtFX2nEGn4qz3djExGfr4z+JDKOL0rIIlgGy4t1UOfVkaL6ndn3FXekgOhfPV0a72tFA
 qW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228272; x=1790833072;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xe83XlnZ1j56xkZd+32EYPsiL+aMgV9mc5dVvYXxT18=;
 b=qQsrOdFKl+5ryR0SJNoJgdqNRkeUdSPn2tKQ0PI4pU7JIo4ws6uVRm0E4S5IXyQb8G
 tZh7huyCQPx53e66q+WU9kGf6YHgU5UIZtE7xgKCTqg74KK0k7CDipDc24lwyTIx54Kx
 tOhFDbTt4GZW9TJ8BxBVUotkDJFrfVfdzOXkF0N4zP+JPUOAZRlOkVuRGvFELBPtvn8Z
 5Hqy7WOtCHQe7z5rZxnyH8cMA3PBvJBObnd53/m1E+qhb0Soo/NblMphAyZqgMamdUpb
 xNHSrSeKmAQtE98Ty1WtylN3yDAOUFAkxL6NsRiFSjmedDpKyIDshjhcZjom9iXeit1Y
 kipw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWbSyPBqnQxeaLJFbCo69W4mXruzv+Z5OWBXtKaBMfFa343erhCImucoa2VUxuInxqLXNH41Lr7Y0n@nongnu.org
X-Gm-Message-State: AFuF++n+wQ0JNLZ3I3qX14DVoQJR1pVAv+y3JynOCwPFU0vhWL8gptWs
 ZHWzrO1rq1uF/dZJ4697wzh1QHTiqSCl0eapEC3YLo0EDEceht4NbLUeX8yDyy2fkVUjqlMvFgD
 8kgRZElA87Tks0Bufhmyl7XAdNcHaezICAOujCVK7ksE7m6e1+8WBgjnxJg==
X-Gm-Gg: AYBFou01P20/IohzjKA5/3BCeuOlXHBZey6S2nG3RYnwEqSZstmuXS1w3wIYNmfnZ/z
 mAM3W6JehvkuNApbpFhQiE0dJO0U/QkRLxpDEQ6I24lNs3fjOo9yd8w2JdL9/YWeaDiaRbm3N25
 jrfz1MjDotImBYd2P5OCR8u86/M69PG90Ze0nm6n4m8T6swVItv9JYUIb9tWAIN5oDp3c7sDMRv
 CnDRl0UkThzkiZMiNHeNfmwbGXKxuNu9uA/UKFrPOn5/IvjMLUse73pLS7BpzvA3fkkGDiHPVLH
 4UPaM/MosBzVJ4ynHyNaklU3hwFTjYaltl5Q4+BigIz3IfK1MRA030ZYu97d0BVadyvvc2CWbZD
 YNo+o+9MJBn3u++ymOQHgSfJZlKdsVA4hrA==
X-Received: by 2002:a05:620a:6f04:b0:939:a45b:76ee with SMTP id
 af79cd13be357-93c3632047cmr148696685a.23.1790228272148; 
 Wed, 23 Sep 2026 22:37:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6f04:b0:939:a45b:76ee with SMTP id
 af79cd13be357-93c3632047cmr148694085a.23.1790228271696; 
 Wed, 23 Sep 2026 22:37:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5debbf4sm47130285e9.9.2026.09.23.22.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:37:50 -0700 (PDT)
Message-ID: <aecec630-f6b1-4e82-96c9-fbd51a5466b3@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu-palcode 2/3] console-low: Fix $8/$19 stack slot
 collision in entInt
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
References: <20260924022022.2414514-1-mattst88@gmail.com>
 <20260924022022.2414514-2-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260924022022.2414514-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX+61iDUqeUgRP
 GFqhLbP1wJMizKkDXPF4Ef9vogB0tkNt4cdkfcgN68v+lu+FAVVxrZfj/XCR2dP4ozzTVBr5wld
 egAAwqfmLpvfQ51v701P8hxShwFdTQQFCqVjtHhQGfJhKnmMPdSUa7Gqn1PMQwocIE7SYdibuzj
 n8AnUewM17ZKaEOViW25uvWtPZF/QngZ9CS2t7VjJpNzMDwn74Afj1JXHFfjaM3YREXbrYnsNEe
 yRYgepMp38E7jiOgbbPxr806Zl7TOk+FpmcQRyhBsQEJw+eouw+F6zPoEYYSfXH8l01IW/RP/7R
 +bCSKhrKIT9LKW7yOXjlFzxfgj4v/XVmhLuYFqNIKRyo5Tx1VW0u6tqp1/u33YfNC4sI9drDbz1
 zPuW0a5zOpNdufmX/qlBS5cLO1jEwxHH6ljcK0rGt2EuAx35C53d3WxgOFhlzBjzZzBw9ZURmV2
 ZN5/JbPrAq60OBt5a2Q==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab4b730 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfXy/pKufzY0UaJ
 gk3MzD3kXRQwF+9aNdMSLHzfHxZpr0uiTgTNGTT5tSrXWhGZINNqH3CEGf27Hu101wCCPlb8bNv
 9HYDT1/fa+BF1/OBOrOLCMhvRSdf+B4=
X-Proofpoint-ORIG-GUID: vKij5GhMKIYc0pe64PpiZ-vF5SQwCMl3
X-Proofpoint-GUID: vKij5GhMKIYc0pe64PpiZ-vF5SQwCMl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240024
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

On 24/9/26 04:20, Matt Turner wrote:
> $8 and $19 were both stored to 9*8($sp), so $19 overwrote $8's saved
> value and the interrupted context got $19's value back in $8.
> 
> Store $8 at 8*8($sp) instead, matching its .cfi_rel_offset.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   console-low.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

