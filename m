Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA654C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmtO-00052l-10; Mon, 06 Jul 2026 13:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgmtM-00051x-6N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:14:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgmtK-0008QB-Ix
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:13:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FF1YF980438
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 17:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VN/vcnKzW+VARZhIMFotAYFESbMpXEqXKN6UrmWIZZY=; b=ReGpco95/HubK5D7
 JT+/zaSgoD2Iwf/jbtMaA+K+ujIcSqgJfQD4NVyYMLNb68nvC5PoCFQxCBupSai5
 D30GlbGxOSDf0NMyqd7J9Pck9zfOD72ElEJtevEtGqJ2y80TvOMjwGNbPBW6TGHv
 zg7kHZ/tHoEGzQLPYBHGgK2mDet1V2W4LlHwOED3zp6tCISILXKz90HKmfy6hjC7
 H4KdQlDiA3UFfQ0hR8Qhh2YghdTF5RmxNn/IQ2urDrRz/wr8VzhgCmM3zKg3cXoP
 1zuzBx06/sgRzXYEDGOhBxam61e7oGQO6HZknHWYObJ5wUAfvb6fT1m4gdR11tZK
 7Qixcg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgt6e1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 17:13:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8efad04d884so69915696d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783358034; x=1783962834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VN/vcnKzW+VARZhIMFotAYFESbMpXEqXKN6UrmWIZZY=;
 b=iZVCRcoUkj1El28g6N41LPRv3E5diaLZ2JDHh0w4NUy7hNQM/2rGaJOCYQ3WE08i9n
 Wr1n94lcf/l+NiGJ335H3HO2+Td6S449B0T/lBLAzau+yoFi8P0TITT8iPHf/W4EUZfe
 9N4MrJyHdbTX6F0i5LU89CDI/t64/6fDXzfYs1YyLn/JKCTeA1PFhslr9fxFvrCaYB/d
 cmCS7xK1iGz4+rxHSjuyUj3Qm9bBddFPuKkCCeUZSlIBtKwRtcB8C0DvV3JVwVyE20Yg
 Fp9Fxw71ESiyL+xQaf/VNH4ElyYKilYb3zXGlJqIOllAPztOfAJN0r5cCj6J2J4O5TID
 5f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783358034; x=1783962834;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VN/vcnKzW+VARZhIMFotAYFESbMpXEqXKN6UrmWIZZY=;
 b=Td/WqM19GCH8ZZX7cs+0nigyBZzccDMkpoTfNQK1njUj9eDVaqIAnxvL+fAf3N7T92
 xzhZMDjq8+Vg4peUiz6nahkW8rAa3eERmUGTp1trYshuLX0s/D0icHO5LL/f2kjBZNBc
 Epxm8+ASzYyfPIGNfrY/NoWQJCydT4w6H5vQGn1JC0B56IPRRvHzJSjZ5HW2iCUVQ2g/
 bGtA1EJqgeGAAt+Di+lUU7VE5dqmnW5n+1pGhK8aqMqt78yctys/yu1wjbLdmsP2sDlg
 qY8jAoyKQP6Pk9qQg/oeGCudxaf3lVh0uZIsA32T/FyEO6/Xj2Clg+SCY46lhOu37jpc
 jv/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqogFV2iEKpaWGxS/W/Ai051x3AaySFW/gRBjwdsByeQiKB9oXUOsv0rXQiH/qBNcYi1/ytq4OIeIdO@nongnu.org
X-Gm-Message-State: AOJu0YzcJ2NuCdWPw7EmVVN7G8s7c+j3mAJQlf5DVek8iFGx2XRqFuSl
 7K3WPSqxYvaC2bt1hlDU4E6xJRZMQKynmCj5gkbcaxV/r6+QI01mzAMvy9bdR2eVsoEP+5GNINh
 HwzcJv/nEE2RruhFkFDxLV0BCkeOICDATsz6+QSrROn7EK+lZIGxO1EkgfQ==
X-Gm-Gg: AfdE7cnJ106/7fJE3f5BFlVnVTqwr6YTBUFi5J/8ZwntjQOY6Fcounhy4nBSkBoPOmt
 COueBTb1zCKLJLX4YmBpkZp+5/qMZgfyfKxkPpdsgja+rowdp5lyMOXNvyDGPvDFGYkTUe0C9Vg
 SuQ7ug68PCWSrFXo2wT6BrjPgBMEy//XFeT4IATVS5nuwTxOuWdnu26y9nh4YYmi/w0p4HwtFve
 TVrnnn8uIr+axvCkzGDdY4cCrbZioXMklurSfPRhQ18vqaSrjdUG/wGfuYMmtcFkcvg39lF86W9
 rWBKwQKG8LOUHqqRJ6dURG6+q2kWwiJ2nDuhFGQ+eJ2xCsBg1yyxnfi3xRM5L0pITy9hPQvAk/h
 xzlHIBQox5muTWNhnFJTI6/pNiwtc/xPwt2BWyGPG2zUct7o7er86I5+ocFULXw==
X-Received: by 2002:a05:620a:4710:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-92ebb54cf33mr199010485a.16.1783358034213; 
 Mon, 06 Jul 2026 10:13:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4710:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-92ebb54cf33mr199005585a.16.1783358033780; 
 Mon, 06 Jul 2026 10:13:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm27805980f8f.26.2026.07.06.10.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 10:13:53 -0700 (PDT)
Message-ID: <c3c65bce-f8fe-43fe-b3b5-dd81742a2d4e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 19:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260706161716.29488-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706161716.29488-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b7lF56bjE6nGrAQtx3zxX2Dg_Idd_uiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3NCBTYWx0ZWRfX10lOjKgAz7/A
 EvkJQeElBrvp+kuOepbZzUPlIny8TivEv3vzsU0KCywT48d9F5hKDmGwNuMT6XWzb93D6wxQWal
 hrqP7p8MhuKUET/t6BRXVy4dLt02EaKfv4Xe/qF5OowvqsaxOJjJABeY1sTpfl6gZELi/+CSWr7
 frNjd/ok1ZsE+f5Lj7X3ZsBdGeYNWIMXdM2DWoe6tBi7Jx8QdT1IP5Pt/e5spa+v+CucpOJFgMU
 WlxJK0kGnpe4HF6JkY644IQSiKQTgCzWyLHA/46pXdyODRbYAs1GNLQAbE9HSHj0eD2LhpDLmza
 U6vLcJR8+OMf5muSWMzXqvwESe/V/yOXN4ppuyS9NfMFAZbIK0KF9FdBIN/GjCmrG+3QEaCycQ+
 jTJzUnvXKULKtev4NiUwtFThvmv2iZqF1v+EAq/Js1OpPx7Hksd2gbyRLvzIEl+CZuB1Rrtplyb
 Ihw565MwPFjWwSwIhsA==
X-Proofpoint-ORIG-GUID: b7lF56bjE6nGrAQtx3zxX2Dg_Idd_uiV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3NCBTYWx0ZWRfX7VcDFYRZ4Yr5
 j7RfPKpv3kIHyNDuhIdTuko3mMks75DYgLOGV1kSYHGB++L37lAWZetSY5IwzJBESNeQP4IJYQ+
 s+w2VK197LBoh8++JJ2aI7RMETrajVw=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4be253 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060174
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

On 6/7/26 18:17, Bin Meng wrote:
> The OpenSBI firmware build job follows the same pattern as the EDK2 job
> [1] that was removed earlier [2]: it exists to produce firmware binaries
> from CI artifacts, but those outputs are not consumed by the tree.
> 
> Remove the job definition and its project include to avoid maintaining
> bitrotting container and firmware build logic.
> 
> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries")
> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binaries")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
>   MAINTAINERS                     |  2 -
>   .gitlab-ci.d/opensbi.yml        | 88 ---------------------------------
>   .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
>   .gitlab-ci.d/qemu-project.yml   |  1 -
>   4 files changed, 125 deletions(-)
>   delete mode 100644 .gitlab-ci.d/opensbi.yml
>   delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

