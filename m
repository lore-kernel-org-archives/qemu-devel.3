Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegsN-0007rd-04; Tue, 30 Jun 2026 18:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegs6-0007r5-MY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:24:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegs4-0005KC-Ol
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:24:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDooa2960152
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FFtKzI8Rz6sDiiDhLZnf7EFWBiNqzfzMV8pZw2GBpmE=; b=Nj3jWPfxkZOgl7Sw
 al+h3dIHbe0YJS1yDZHj+lo2vZlqWUP7FgS/uYPR3t4yfTLRG98igWAcn56c/A1M
 PiAQR+doQFuAkHbmMv0oijTimh75Q2Ub7k2kkdr0WGTxI2OKRvwGCp5Gn9K5Dguz
 KmRQX0HXrNmvdFCZ1JrYVr2psFu4CINwtx1KHf1nGE/uYRAsjQeZePoxdPTey2ep
 JRRJGvHhWUThW+8i0J2LzUMA9J0ebtg5Jq9Sl6PGbtfa8UjdKmzrdCgYFHKL+181
 iCnp/8QhiwI6Qs8OiydGnZiXHRh8BMjPKl/YxHPiB2Cb50A2w6mhyu67p3vqTTb6
 lyZ4Qg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9115xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:23:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92aea0d801dso1558585a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782858237; x=1783463037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFtKzI8Rz6sDiiDhLZnf7EFWBiNqzfzMV8pZw2GBpmE=;
 b=DuDnGDA4UyiFcROi6oQpIm8I5CuCfce2L8ZqLLtY0lP12Zv/oasYMbb83SMN90gQ49
 9mxc/mTt2PlEfh1W2GnPLQuxjKz0gsrHxMj1MqDhvKYJ6bKwP9DYJmidoWPLZ17PnFsA
 q42jN70RvfEq2Cfrf6AquawYtVmcyDkW09pHXd+pCxA0m0kMssv82HL2ttaArpfQRTYa
 cgf2r71mVyYtoEnU8og1evuXWiMD1eZTaL2oROw5gZ1cNc2rdInPxMru+VsxfU9M8oaK
 oLptnZ47M/rlpB9aVXSddCQUf5mC9MjV4N+N8wsDbZvhqHTKwYnoLfS7Nb/wCIrcZ08P
 l4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782858237; x=1783463037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFtKzI8Rz6sDiiDhLZnf7EFWBiNqzfzMV8pZw2GBpmE=;
 b=a6C+b45kzjMioJc80qrgnVrPtVYF5+w7jRrE4lDfIzaULM84/K+WpzvJ7EbfVuQdPS
 ht+LU3uwVXvBUanmLl46cBYMvJU2JMpm7JifrQps+7OlEqpyZAIOL7VniUzCREJLRJ5k
 7SxgEwr/kHR33vju0/WprP1qJ2ZG0FuhtMxTnO7UPtmGvxK1NpfknZRCUDvNVvg+g0/f
 jMEKyn/sm0gATEX1dC4AFFPDKjxyhB4OfhR6CPw+BTOsLTrhLqZmBYpmAW2zaPmVPyZ6
 ClWkxOgY/EGODSo7Op49HNygwC9oWC4G3lPeWnOf82CURIke4KtZForcC92SFIo6Q1x5
 YPbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OVE+UprhM6thNtSnE5AXCZA1pxdXhuf77rDIffUaa2UT0C1tsQbok+x+S2LlcyvVazmSl37m2QoW5@nongnu.org
X-Gm-Message-State: AOJu0YyZ1V1NF8MOfY01pDaJVZrzq5krjItON5PJ3/zKTfySv3tC8jJG
 ztybYNj+9W3b+PSx4Vs32fxeO72Xzy3gm+bqbKR7voFxPsuR7EIzMrlHM9MccjhSZwIpPlUJ+DQ
 Xnw2Y+tG3UiWeVsxY9p5+kKCT+FSfmqG/Hm/c27v1/iXYSKwzQgHPIoGzew==
X-Gm-Gg: AfdE7cnWZDHIeGVrf0iHos7q/LQsoTtFqggEBo6w/li7cYAYVjs2VvR3mbzFXdXrtdA
 gWVF6YKA10GWix13l4UGRl+AMtDWAPqa9jJNdGRTDycpl1LLrnPAaa/LfQGXdIdDI/GOG+wzL6B
 asB4z1u/KiokTSvcz+7ak3ccX8ujPTtW2pP1VDZewClJaU5MrOPTeFTXsNx/hsPqyJBxW2FpSLJ
 Erbdw0S5Slx9MqJ90RHUpSok52AQSbfF6HWO5xOn4Hn3/WOu7vQgHWRDEsFQLaCFzQbLkikytDN
 Ks4PJ932XJOgQuEMxti4vWAy5js0VqAht7CeWMqCDMuAkBEy99NMu5rrCLk/j5fNOG/phZDoMrF
 kuCVlwCGSYCLP7jk1th9lzSZKyw2NtuG19JAtAL8Ruv4jBZbac20obfg7w1xDwA==
X-Received: by 2002:a05:620a:4721:b0:92e:5d7b:fe5e with SMTP id
 af79cd13be357-92e6249fdedmr941472185a.7.1782858237601; 
 Tue, 30 Jun 2026 15:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4721:b0:92e:5d7b:fe5e with SMTP id
 af79cd13be357-92e6249fdedmr941468285a.7.1782858237032; 
 Tue, 30 Jun 2026 15:23:57 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe616f5sm4957765e9.1.2026.06.30.15.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:23:56 -0700 (PDT)
Message-ID: <63980013-fbda-4df5-bf51-d5a0f4d9a3ca@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] amd_iommu: Return int from page walk status helpers
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
 <20260630220806.1758748-3-alejandro.j.jimenez@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630220806.1758748-3-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZA0e46DSC9SAdyHkWVTzyrmjRHc7LMAq
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a4441fe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=vbiqilLOFmBWQ9AWAW8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZA0e46DSC9SAdyHkWVTzyrmjRHc7LMAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxOCBTYWx0ZWRfX1eB3bzWRgIQs
 i+pbokxnmLUytMnvQ96r5ZzzKirZCBzTBkoz405Y0wQcijfUSaB+/t/IZLhUI99vdf9qSP5yZiw
 1nXhoFRjQ01Ovr8TJV0RHNt6fQIc1bVshGtw3J4EKPTjKqkX/tuLuUqS3qiUGIMussBoIAlDNjo
 nWnT1ktsOzWBLyMa9O4cJOMSW20gd5/trXEFYyy50nqkfb57kD+m3CpKAW0OCp0zqVnR4u3s+Gq
 zZaLrxmHzVTQp4Xql9GC1Vd6oIYLhWSFYeXPdv0M9d9xqxD65ARl3NQ3vqcrH/ngfpyK59FDydE
 vZVd5koP2JkpgEJRDa1TY4daJD/SZkN4OuQ6lmfr2qVelqH+WTXGuIGTI3FVT0OSx1mGdpdRN3y
 sQGDyX/oxQO0IW5AWyUbYe3rEmTtQ/lTvImLC+8fn/UbsOQBlacQps/vK5HduRpB5AfguzdK6bG
 itCEsqz66e6/06tSmMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxOCBTYWx0ZWRfXx9xupPK7KPPe
 0jJ+JHdyoBzp5Dma7O8aNQcC8Kte03A5KtBtuN5w7zxonNtUrUA1Dke5ab9T3ADmuzoMjOhUytl
 4pAkT9aESIBruVkpDSBHAapjghwgX94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300218
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

On 1/7/26 00:08, Alejandro Jimenez wrote:
> fetch_pte() returns a status code 0 on success, and (small) negative values
> on failure. The PTE value itself is returned via an output parameter.
> amdvi_get_top_pt_level_and_perms() follows the same return convention.
> 
> Both functions currently return uint64_t, which means any negative error
> values are returned as unsigned and then converted back to int by the
> callers. This does not cause any issues in the current implementation, but
> Coverity flags the type mismatch and potential overflow.
> 
> Make both helpers return int, so the type matches what the return variable
> is (0 on success, small negative value on failure), and also the type used
> by all callers to store their return values.
> 
> No functional changes are intended.
> 
> Fixes: a1c97c395729 ("amd_iommu: Sync shadow page tables on page invalidation")
> Fixes: 786550e2d38a ("amd_iommu: Follow root pointer before page walk and use 1-based levels")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/amd_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

