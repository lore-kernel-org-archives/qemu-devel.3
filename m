Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C0AC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1r0u-0006Su-Qg; Wed, 02 Sep 2026 15:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1r0m-0006QY-3B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:52:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1r0j-0007VV-Jf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:52:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HrtvJ2731222
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 19:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Te+6+lQS/EW8h6BW95iDe7+CWxLjVFrpGbJ8eltH2k=; b=ff3WpydxxYK7v2m5
 jwBGQL6YIvJt5Ofl1uZsd2nBW7tmcy05rF98jv43wekJ96QE1YhsC0TSNnM6LLJl
 8ITDL1LX31K4p4gwCMlbMO7hWckkj1MzFUbi4Zfi5T8N5HXJPx+ismDjW5BIdsCZ
 8sxVWvd9RIkidCF3sRioZyFKgCau4vZv+6v5at4JyWtm5TFC6RgqLt0HjWq62uuZ
 XC6R4iZrY5bcggWyFeZquYaoUvShTeB6XX5kRoxD4kL+ZBiNN2S3nwShvv9GS1Lr
 va8QDl2GyKZPnUDrG5Zh/jANSHlBlULYGrsIVyf5FUUjzAOmPE6hiDUCRiDsiODJ
 YLHbnQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy2qch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 19:52:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso20058545ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788378759; x=1788983559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Te+6+lQS/EW8h6BW95iDe7+CWxLjVFrpGbJ8eltH2k=;
 b=PWBa96PViUliylVQGtgYdsFInidFljTJvjjX0SWhhMV6Rf2Q+3RT2uQ0Q5OKxZvqSf
 kXcigdjSlG4BB03MCEHvbfafYf59KxZfjr8VMG0oa/II4HhWs/T266mDRsY/+kD5CUJQ
 b5MEQhiX5GlAKBd84qYqx56jihwdKOBi7Mf2dGBP3rXkD+S9/dfc/Uze2LtGLAW7GenY
 elUYuFSL7uMtfWh6QgBnTt8Ntk3tz20CWh+x5pKMm/WilZbovvw7TFafMkoW2S557JSI
 MG2k/o8ekavLpH04HKKpG/WhOL7F8WfKrsA224ylWaOEg2PfzKHKQjssnEaE3ZK1NYMV
 5gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378759; x=1788983559;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Te+6+lQS/EW8h6BW95iDe7+CWxLjVFrpGbJ8eltH2k=;
 b=JdorurF1xKBxanB58Xx/tsxPQSqUsXsL97gW/Z0VcxX4pawf5OaxSLaU8GkbPkQmhR
 BdL1BOXz1BfHg2UuJNejonbt/vsGC6YeUaXDAVtUv5TjPh6jJi1iZcKVPMESWTTtJ0Ek
 8AWHNULjA0SELsai1ssgev8+XUf1CGFwZk+SlD523MYqx+m2o1mCc/RMLkKPE3ezGM9Z
 C9e7JZkHXfzZE0KgNxn9DEDOjz1SSAQYPnEPYqyxG2APyFrken9aK6UYcTHCJunfNmCi
 72LfRuvGVlSeEe1nrhr8rk2/5boJ8qOKX57momHJh5HQ9SoklwBvteI9vEaL70q7yA7U
 sgCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdP6zl9KYKupC+pcwbz7lQQDcDwg9QTWkiK7TQWTI3jQc0446249M/EMQXhLKKG/cEUO4zbwGgC3dh@nongnu.org
X-Gm-Message-State: AFuF++k0y6yIRIhvzk+lA/1XByMEtiIxupBZMOVoCkh2PQlhr6s8BpT1
 hBR0S0AAEIYsJeC8Bb6G0s2J3TQrMIBpTtGsPe275HO02k+Wy8OXgDF1GT+bzkMBew368rt8HSS
 FDlsZxTBAXfVUpkDnjtE2RMOjGUjoSoYZIYN1dh6wXeyuIXf6BRBpTpCJCw==
X-Gm-Gg: AYBFou2vEasSU3D65fQR7IZLmcysLbEDZsyRKu6IcYxLN7mM662RJXWEZ5JTMX77nI+
 N95g4vqY6UiB3MgIwwMeJJss7ZeqFJGM3Wx+C/NK4hEHt+7EKENfLnIV1SDQfU4ztqu4NQoy6f0
 FqFlIegsG8YqxD/c8izTT5cahnX+mPysZaLVoUzq0L3gk1Qj6bcJ2s4S2oHjKRWd05B3NJNmvvG
 8KtsYGxkjWtWOWLZ/JQIFKjszCzWYwtc+6p5nlQziaP7qEexODS6Ds/sVLOuGYcNZwg+1L3NzGV
 PIHxcxsM1WP0AEbNYZcfNnri6XFFbS4vWOB7ICyVGc6Sm9GaMKDeEFoXF+kW/fSx85El+YJoSN8
 1uD7xqM7wSsxxuI9gL2a8quSmvEHTAKMXFqstnKWp6Vjnb/yeeKMDbvlqzFo8Z/TjN3fA
X-Received: by 2002:a17:903:3884:b0:2da:fa6a:b04f with SMTP id
 d9443c01a7336-2dafa6ab21cmr26976325ad.2.1788378759578; 
 Wed, 02 Sep 2026 12:52:39 -0700 (PDT)
X-Received: by 2002:a17:903:3884:b0:2da:fa6a:b04f with SMTP id
 d9443c01a7336-2dafa6ab21cmr26975535ad.2.1788378759129; 
 Wed, 02 Sep 2026 12:52:39 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256416966sm307194eec.23.2026.09.02.12.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 12:52:38 -0700 (PDT)
Message-ID: <2f0f4aa9-54a7-411b-bf59-7c8442b099d1@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 12:52:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] target/s390x: Restrict interrupt handlers to
 system mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a987e88 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1EuahR8dtqhgXXsTjK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: S29GRMD0Zr9upgEDJDqOn8X-yWZjIl7z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3NiBTYWx0ZWRfX4zM4vfChltTQ
 s8yed+Wh1g36jux/iFEBBSIBlmA3WoBee1YMn8+QMFATQyS8BYOdybDjc1IWgNXirkpfXCcVHi1
 ba0QhT77ZBBniamDTmIGsSVmUejLOF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3NiBTYWx0ZWRfX7IByRrIKe4xd
 SFYiHMnBv29x4mFLeIlyGVqWJfBxO86FoqlDLOO8SitufHtJDAXC9Av6fNsbnRlGX7/O0FfLx+Q
 l7yzcp6hU+XCdsvEpuS84KK02jTltpDLDepj1zIKYxgrajVfNifd+5lgHA/Y2yDSOzd3+lADoda
 qyqyRKCK1g4tAcEORi99UzClYgjVs9Sob0Cd0Wohk6IPdy+Jxl57eJrfIm9in84Kk1xTSyPtgS9
 JAynrHyQ5wSPKrKhWG+qFsAeEzcfrMhdGKv7cO+sSRx37QXR8zfk4TpK1bjGjPpOkAKQG0bhW2c
 ssI5LhPpt4kWUANGeUN6J8UDDD3fO+sXwyEba/7zYo1UORUVxxSMZNDJvi+my0NNH5EmwvTatwF
 CyVzdzJ2zeeuaiDmUqkX/r8qWYL5Ej8p2ERmkLRuLQBOUnxdf4ZLUf71JxgOXLVXLomvG3mFV7d
 Krzk1v0jdES+oV47zOA==
X-Proofpoint-ORIG-GUID: S29GRMD0Zr9upgEDJDqOn8X-yWZjIl7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020176
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/2/2026 8:20 AM, Philippe Mathieu-Daudé wrote:
> Move s390_cpu_do_interrupt() and s390_cpu_exec_interrupt()
> declarations from system/user shared header to system-mode-only
> section, removing the unused user-mode stub.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/s390x/s390x-internal.h  | 5 ++---
>  target/s390x/tcg/excp_helper.c | 5 -----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

