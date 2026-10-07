Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0932CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWtT-0008Uq-Lx; Wed, 07 Oct 2026 15:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEWtA-0008PY-A7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:01:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEWt8-00045K-I8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:01:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697IBiR44077417
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 19:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BByMeNxXmBIr6rTxYzS+zAy/rN0joIxQVrX6lFg8TGg=; b=aTuC2Org7rTdEL07
 JNZH651FPOhFT31Ewg756AYotHmQwXpbJwIk/liH41OjEyL4BzPGdZCXTtJ3i5Sh
 CeNntASmwXhqgw8gi/FTjRiRLWPVYNTDM6ppNBRWLllwuRPyepT1ihtKfcXI8/Mj
 TWMyCiyXzPwkDC5HRl+jNFkOGD4dLFdqh7yFVjCeFTK12UbJk5IASx6I5H/4eow3
 ztV6F8bNktGDrzr1WNk6KrWeGLkk+DShZE8c03SrmWKcfREH6fcrHZv1diIZX+h2
 fsVuCyx6G5uvs/5pmHEYes1zFkeLFUi0COpBiaQgQJbsiv49uJyQXnNqcnLFzfaH
 8rIBew==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s3r2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:01:10 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf71bbf197so3883751137.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791399669; x=1792004469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BByMeNxXmBIr6rTxYzS+zAy/rN0joIxQVrX6lFg8TGg=;
 b=XE4ABPsEOjaMVtC3mX8M9ft4qvFOZDxsTWDxMRhaK070lJwFnZWvDsBiHACsZhyyCq
 QZyXv3DUAtVEd8AYNb5ZRJGs0plf/hmKNt0YS6Plsbi3Gz8mx1iHbOViEeUG97+MuOuJ
 gwbVLuhQe2HsrpnvjhLVJ4E5w6aY8VXYV9yFx54hLPcUyCmqE9CM1uW6gtnbHcLJRQfk
 1ayDoEnHxu6Vx3cNk888uYcpMPF2cGoT+91j52nieJqUwzMhZO1z1B1BlDjViYJsT8vz
 wWGixan68cydvdetLNELIWjqPa02qhMUekVy1mrIP0k/Rdupyix5xQNYAo6Nnz6KgQZe
 6pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791399669; x=1792004469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BByMeNxXmBIr6rTxYzS+zAy/rN0joIxQVrX6lFg8TGg=;
 b=AQRbmbvqKsGbrkwVPd4rDa0YvC7X0r2McS/g7bru2DiThFoqcM/FlRMAOQ9BKxKzwt
 KAohXtpMlfmtFAil25Wawku8xJTv2QJbpJXcH89rQ9bxx3JEvRzP/8Bed8081uW0pKuk
 6JxaOXbdO2MBc240Ji4jKd/N5IUat95a1cv+s2+ozHrbL1X3z0kx3MckPGcKlUCycURc
 MSzAtQ8kDiPIIzo6nZ1V9BSBeRuO3G1VKKIqU90d36uCBB22ixe+ZL7oadPcleTAmmus
 mIsPiylN6N5LkPY3KH+Ks++er/aTTwRk7lcjxEUXoJpN8Nv/7nENGLS1RQzVSzF1ujvw
 myWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNPNd6taCm1dUbAJkrYZv/inh74aehsuwg46mUWzspHkEJDGecrKJ983dWjtqb40KouI33hl2GhnS3@nongnu.org
X-Gm-Message-State: AFq9FYL3rPiu/nCrUpAEMarlFamrXRiS9l9nCzIMQueI8Xjuyisva1C8
 IqtCpSBcpPtODABRWfJvbVMKO194+zG1ZFdabLDs51mMtMtnj13SNpcHC0B/FBc4vy0BzldvV5p
 WWpfuRDHYpHfzz4TTeEJRhLRa355EeKsMwHIP5v+SNnoKML726YAXwBp1mQ==
X-Gm-Gg: AYBFou2n5IZ3GPsBIyw0s3p7y2UsVEztJYb/FdXo/4jexMPNLDqkG65lHnle2dzGT3w
 j31uwF3K2jb9I6z8zLH/9YBeEtNEDls8Su4pAiHLUvSKke5L/QS/Ilb8RnViJ3NsjfhzZBW0sXf
 +8qtGGzRvz3Xw8ZQ45436DoHELgIxxosqHcV/k7chjH+E1nwz0QZtWHc/cfJa78JUt0FGnxQc2M
 6F5B4tcKSAn5aeKnfxTQEOc8LEBjDsGBCBdaCEhlF6ry7B6rfYUClyVq6o5UGwCiABOphce2GEG
 uRSjPzkmMjkrYyMAtavAbxy3feQH04l/F6zzlztx+RVWlInjDSaNxYQNtFHtsy2hhmzmUCziLQC
 E6kGvtxuXyIVqMrXB8Juz
X-Received: by 2002:a05:6102:54ac:b0:7c2:7a0:ae28 with SMTP id
 ada2fe7eead31-7ca38e1c3fbmr1181719137.30.1791399669347; 
 Wed, 07 Oct 2026 12:01:09 -0700 (PDT)
X-Received: by 2002:a05:6102:54ac:b0:7c2:7a0:ae28 with SMTP id
 ada2fe7eead31-7ca38e1c3fbmr1181709137.30.1791399668739; 
 Wed, 07 Oct 2026 12:01:08 -0700 (PDT)
Received: from [10.251.42.73] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2eeb6sm6943818f8f.43.2026.10.07.12.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 12:01:08 -0700 (PDT)
Message-ID: <c76a70ea-f788-47a6-8a0e-229694e6c571@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 21:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: shuffle bios loading functions into kvm.c
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Luigi Leonardi <leonardi@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261007183545.1899945-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007183545.1899945-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9xsDjYkyc-Y2dXctzPf_2zWxAvBN1cp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NSBTYWx0ZWRfX4csOnw+eH1I4
 V87mHX0cAUrQ7xvwe91RJMjcYSGgUqgbatMwSlvOE6k497vxV00FFOL0uneaq2kPxuHVBajaJIJ
 f0nErfGFF1LgoiNQJeH1hSn8WadYa3jPbcMjx+91GexPbUnE9Vk1Yq1yE4s/a8ePM+TX2hfh5Lt
 xeR0pSs58kVOUTEbf2+CCYTH9blOvhXVjgqYz4UKsULvA3DU/6KyP4Ilb3pyMHcMsmbJYBm7Tyl
 LU/vzOtzfq0arTtHihvayc/y7kLjtBM1Detam0irveARpbiMrA7PEftOpJDtznogZfX21iNEnTN
 B92+5O0oDvf5QKGlwNymCgDLet2BoeNMOJZxoKNrKsMKvbSlvvQi3VRFQLqpyXXOYM5eoC7Yjkk
 EyEOase4kdhZh6O9Iu8qwaNNvPLTyia7WFt7eeLZNfiAeUgd0AjWgeVZlB/CrBz5ceY3NOoFKk0
 jVq71TDdAwjluTBa3dA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NSBTYWx0ZWRfX0fmUMNdR/t3U
 UoaI16s0yN9McP6UvbAoupsxiIdKU87Yfyi4sw7IGcrj/iwCWciCB9SGtdDF5GyK+nbsMbIEBOs
 QAdWv3FP/Wy9q1obidfx4b1VSmpdaHg=
X-Proofpoint-GUID: 9xsDjYkyc-Y2dXctzPf_2zWxAvBN1cp1
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac696f6 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070075
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

Hi John!

Cc'ing Ani / Luigi & Mark.

On 2026-10-07 20:35, John Snow wrote:
> Currently, these functions are located in kvm-common.c. However, when
> configuring QEMU with `--without-default-devices`, we encounter a
> linking error at final assembly time where these functions cannot be
> located.
> 
> As a quick hack, I've moved the functions into kvm.c to allow
> defaultless-compilations of x86_64 to succeed. This may not be the
> correct or most elegant approach, but it does restore a compilation
> feature that was working in v10.0.0 and broken by v11.0.0.
> 
> Suggestions?
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   hw/i386/x86-common.c | 125 -----------------------------------------
>   hw/i386/x86.c        | 130 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 129 insertions(+), 126 deletions(-)

Can we move to a new hw/i386/x86-bios.c file instead? Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

