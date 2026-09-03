Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECCEC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DUc-0008VU-B3; Thu, 03 Sep 2026 15:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DUa-0008VM-Pi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:53:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DUZ-0008Mf-4e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:53:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683JgKcl2572369
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 krSRUfSNp0iGdhbXy3KDRNC/b9yUZceFx4QXEqwZdqI=; b=isoj6JidIhzhHUve
 vJrNkfyW8f/z/t1lYXsm5oFcWxtEGg2mcSWPHBHRZKC1ZfETa5QUqldtskyax1YR
 FYcLma+8sDScVS8dSLuVMpOtXGhJGlxd22tVmXoEOeGvSBu+e9543dGBgIzuZjk6
 Th5rtbFNVXHulCpp9Kd7cEd+2k0I0v+bSwBQkwoVEzJCDNx5Sf7Ddar5odB0axu8
 3cnuFTRrM2Wf8DXkB8FY6fZfRpOPG+zKAmXbuEbTuD3apGHkiGxr3+oz0dxH3K6N
 YEoQIOct2ZcGqus2pNucptotTGzjDwPTW3wK5Sav0JXu+ovSvw2xiwn6Homy09pc
 H+6BUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b19y8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:52:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so451026a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788465174; x=1789069974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=krSRUfSNp0iGdhbXy3KDRNC/b9yUZceFx4QXEqwZdqI=;
 b=RNScHirKPenR6H06BK+59py6lvx6Em8XhbKY+a2DHCXso+qt4KckN6e8830Ut3ROJr
 MFkfKRff10llGNtKTZfj/wZw9FewA5SLiaRGU/RBZX2BJT2oyYo0qLADK8ECMpVfndlI
 pjhWVsftafoQ8BGqAT9eu55n0cB+CB4L1olm25QYjfP4cAjNrtW1xZhdcG4Xnm093I+E
 W+Zs93gHQT0VDmDMX1s5yXUThaFAuOYX0+DBsBxLs6yYsgKYCZsFK0nC2eDi9tH9joMW
 4aUvF+2DRZPRPhg2wJCqu+NUSq8pqQGib/7Sxgnt9rWUI0unYsIwTmNbRUCI3XHbvVV1
 cuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788465174; x=1789069974;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=krSRUfSNp0iGdhbXy3KDRNC/b9yUZceFx4QXEqwZdqI=;
 b=Dm4x8Vp/DKx2ZnLSBMBU3pfE+WNQIiY7gxqmoUuMQkna/w7P+SBHI3+w/+o4WEvLFH
 5hppWQAXxpxz1ogY220YPFMGR7VUeQlSlr0IUEJJuzb5G+oykfVUBkX6YNeXn7ttRxFn
 t9bZGmF27nSqIeGKib6tlX/SlJL73CmnyHgWpYoyHDnRmElnnTxdxX5kZL1Qn4ibUTxN
 ndsquYdWU3RrjPKsesB4P8otHDtHXr9xIZb3wsT0EOo2dXauGv7rC4GtuL8CSAzbiR80
 TZ/Bd1IW5HbXGcojguuO3SBKDweH4QkL8rc3V1AYZKD1TuyXV31nZVOI1avHvl5dW0Qk
 yoxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7uL8R7ec1QxBbgFa4NsfVF66mCGAb6hFwqGX+s83WTSPvB8IO3cndSG9MRDRzUM5HhJLQNoLP18dD@nongnu.org
X-Gm-Message-State: AFuF++m1KG5d/C8DKSEVMRv9BXdOIui80kXLEZag0wMOSJ/5KiSEcufQ
 CQScfuRzIa9oWvBvux68A8dL2iv1ccbchmwxa19VesBl40i6MlOZcA6wtlHzAqOHsvSUlkb+CDZ
 9mJ09oATF1z0KG92BriqW3yxLzybKEFFYXLIs6KS7rIWgDKXNt0StK4bPSQ==
X-Gm-Gg: AYBFou1aNwCzSeVHS7eCNGvCA1pfC+Qk9uBF0rZhnRzkfo6U4tr81P2k93XV5SPWUst
 feg20xDFoyMPrFsdFlu8YEiEh+AX6mtnKEaOVWq/ZRNMG1jX4TvO4KLrN6EfAc2ftCBrIpAF0U3
 BZLUe1UxlaaezXqxduA9TIBvHf2C2mstUd3ZtdKgTMkqTwo3StN9yzqry3MpCMyvpKVM7MTZMRf
 WvGjLEDQsR1dqj+vc8kcY3wkppzo6BxaALgFg8LUBsLS/Qk6svMHrFgphr/oc7s2MPD2uCBaXDN
 1pfAbdSSDFEFLXF6+JxAo6W0vE9DqCHN+/e3U8HoVxQ18/ETb7xPEcPiQv3ffrcuVKRM3KvUBiu
 nYxnXM2/vApr3vqBs0gf6HufEJ25C7vmW96EZNQXYEcKoV2oP+9dG4JxRNbF67TKwldwe
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39b25ed34f3mr1582738a91.0.1788465174186; 
 Thu, 03 Sep 2026 12:52:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39b25ed34f3mr1582678a91.0.1788465173754; 
 Thu, 03 Sep 2026 12:52:53 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339af25062sm1524555eec.16.2026.09.03.12.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:52:53 -0700 (PDT)
Message-ID: <62b4cca0-e5a8-46d2-a528-5244194da528@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:52:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tests/tcg/hexagon: add vgather/vscatter
 region-length tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
 <20260820215117.1788954-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260820215117.1788954-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JaxIQQi2VjE_mQeAvPa8bKBn0gfBeEeH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MyBTYWx0ZWRfX1tSoiDZ8bH32
 s8vdFK4IP4jcYiUHh1jp7AFujRqxIpAGDMm+a1kJgp7BYMpVSxFpVn9eDbkwBhn8mtbT8jeJjCR
 /EJMDQcVQ2NH/VMbnSVrzlpPv1xDCCs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MyBTYWx0ZWRfX5MFsa9rH8sRT
 J59RsiDuJSLW0DRM528uPyPD/kM+JMGdh0YmmPIt1iQ0TTX9DgM7NnW76kGWJQGgvdox4wF/cvW
 fBd9aRJxid29kZQNsSdA6oqAvYNaGOtX+vHlQpidM3LqeDcWhw+Ve9fvJiOYeXntR+dLZACZDvv
 zRm4U5J7hqAjQJE4FIIvBW07KrX+EElDEsgfvlVh5rqchq2+A6Y/FnS7FN61YweimcE/lrnoamd
 LzgMXYLL0llbdI+u7R/q8fcUe5/hVm7zoc7FDBe1DSoLXxv/NBDpYTz96E6YS5Kzz3GL5qddyb7
 0Eq0d5HTyVH3jnX2XCApWM/LEbXE7yr54QYcv6/11sZe4yv21RJU73KjwNhDH7tR4Wnqz5nZ9Rt
 P1lU5TqD0dKCC2mqEptaP4BI7niiQTbq5VFrUy2q7Wp81hcSN7Ulr/5zvYZFUs4hgY5u1XRv0j/
 pkxiOfoaQj9fK/rVq+w==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99d016 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=q-r6SJLbOQhasUAek_IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: JaxIQQi2VjE_mQeAvPa8bKBn0gfBeEeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/20/2026 2:51 PM, Brian Cain wrote:
> Cover the case where an offset lies beyond the region length: it
> must be dropped rather than read/written.
> 
> Place one dropped gather offset on a PROT_NONE page to verify that
> the instruction does not access memory for that lane.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/scatter_gather.c | 138 ++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

