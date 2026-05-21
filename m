Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFE6CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 23:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQCPi-0008UY-2n; Thu, 21 May 2026 19:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQCPg-0008Tr-IW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 19:02:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQCPe-0006q7-Ib
 for qemu-devel@nongnu.org; Thu, 21 May 2026 19:02:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LKSvLg776932
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 23:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KY5nAHZi8Zp+Ck5wPu+K5eVAF9IjYgvbbr/Q5b2GxV0=; b=dJuEo0CVhwLm5CeF
 Tv0ANSnfmlFt65pWWHw8JoxaRi1oSnRHILvn3tZLNi82L3DB3sQC3ew9JLuVt1B8
 1TdyF8lIjr5nTccFywv7RtGYc8tDG5gNUS48mkJ9NJAqRgBImwqv43ckWiYWh2QN
 jWlmGEgmFlofLd7mte/4quqDE7NlhNzGnLvF5fBZIMrFuQPhGgd6BtxSRgAECLRq
 QjDDcaFNCuNM+yKixEXjvN9fS7i+arZGKicl+o1NS2CyJXmDRq0x/xT6pK397Wez
 5rIiWoE0Cn6mYwloWJ2wEk7MhrdIJJFsPsjGeJZputhtUhWHp1l42j00+bkeiU7o
 FowCdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h0nrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 23:02:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso8151495eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779404563; x=1780009363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KY5nAHZi8Zp+Ck5wPu+K5eVAF9IjYgvbbr/Q5b2GxV0=;
 b=JPEkXeBJJn7DPAmIAt4KRh+0M+vA86zq2clM3UJd0omA/nvpdTOlQFl6LpecG9+O7x
 JwpaEPyBHl3DoIBTbm0m2/WpbKMCCAh2BU9lo98KmmrC2O19lrrWk9huwGNi1kFlZb4Q
 DCDXMilbxKP2pYU7Kx15uRS/lyz6DsBJzMkRS5tyk9nX6bB+Fn0nltHX9ZcGUmjoNav9
 HfrWjEbr2ScB4EcS9mGWI0eEu8TiEY99jSP9+WwFSnMah34/msLk6nahWh3kA1r4zyyZ
 JOBwI2AHO1l31pfeUAyY2jKSgQV48+gy/yS05jfD4MVLSDlWyru0ziRZsWS70e2KIfmX
 y2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779404563; x=1780009363;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KY5nAHZi8Zp+Ck5wPu+K5eVAF9IjYgvbbr/Q5b2GxV0=;
 b=FdSoV+iQYARX9tay+ctwvlZWIKWGO9oD8Xpcn7xL5MxWG3f7uxLuEm2dlcCXi6YTj6
 yY0KYJm8N/VyzPNRpM6nKX3kXp9QSmVyactF4v8Bm3QHN2A10f0S3oXJ0UBHD4HnWM/6
 rfECiZbnU4yLvBSsxOJv5B8FSn8W3Hvxg+NoWScenuGsjY/y2jXNaTAuZNmzHPMRIHHM
 rjkG+Q/vIcbvmofehcEkFyFbA4YrGjgzlaCEoYrZ9wJMEwsgHGcV7BubawMXXnXIwrY/
 02ijfj9UzlNPF8BXZM9vFaCICU4hE2nmKArWq2Iav+53G0UBKrRpz60WucVglU2G/DI3
 Kzog==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xhT3sF2zd6jzuys8YJdjNRrOBI313I9L5QrqI4XOXzIu6AdYD2u9am6oUBG/YaZKSFPcndqLf0/0P@nongnu.org
X-Gm-Message-State: AOJu0YylmLDE/RkMaNjRpX6nuE4Z72w8Rgl6HsVhJM5Y8y8Gc++KqUG7
 NGjmTUiLoDxDz+CLCJtSdsVPRbUYYFtL0ZS8d53vnu0nVqP09a/BiVSoQJyJJEQb7uNtp4qd4SZ
 0bCFROXnvriIjiwz4pdMrCvTqnP7eaPEFY7zQDti8jw+b4JlgKiVYUX8WVA==
X-Gm-Gg: Acq92OHurV5EaQYg8R9zCNfY7OioMKnYO9zibOtRnne1LdnDG0t/qGPeAeitHu9ZWHF
 ZxblJceGueI7CGnBhsP+/kgnWdrjFick+NCgErbw8WCzhelV09PJpLz1W3fC8sUwombPZRo/MRK
 3gyHHgtdgZZpidyjnQY5sVIABl3aVWneL3s28TlVUwyosJK/oT3CPApBrAwVxf2zlhNqdHqPT2y
 Y0q5W+Ux+Ktvgo8sv2kunOC4rVc+8HLQkVp+65iRP9ksdB34xgSlXuBO1JH7HoCNECYuQRCSRHC
 THSp+Z1N54wgW4uOIUwDP9xKEBC4oFM6N3Zf+oYQZo/EV1BgU2RnLMFiBBPMd5cMUX9fijAPpTz
 q9ZX/HYj2Sw1C4PM0qI+50SLXymcPb/wXYkf8Ho6Own6isFIl/OG7JQJPePsmxZ4qGWbcrbD0mN
 oCJ+IsiWlqp2oMNEq39ZuToFzC
X-Received: by 2002:a05:693c:2b06:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-304490953f8mr646268eec.23.1779404562533; 
 Thu, 21 May 2026 16:02:42 -0700 (PDT)
X-Received: by 2002:a05:693c:2b06:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-304490953f8mr646249eec.23.1779404561995; 
 Thu, 21 May 2026 16:02:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3044b94cbfcsm359926eec.20.2026.05.21.16.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 16:02:41 -0700 (PDT)
Message-ID: <e2f75b45-45a7-4dd3-ad6d-ac60108fffec@oss.qualcomm.com>
Date: Thu, 21 May 2026 16:02:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] iotests: mark 151, 181, 185 & 308 as flaky tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260521085148.1492614-2-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521085148.1492614-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HbuXkIighAjcHHpSwby_Zvn1gxVm0DUY
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a0f8f13 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=mDV3o1hIAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EbziVhiPQUMTRjPRd6AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: HbuXkIighAjcHHpSwby_Zvn1gxVm0DUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIzMSBTYWx0ZWRfXwD0YerQexw5W
 SK9+q/7oByN1H9EOkHyQ6zIFgkghItcbiw60kwGIFX3S4YUzt4TfuHCIJCRC0Vh3RCLHK/OCREK
 eGkZMJd1xygelKNtZKxWywvIEGNrIjuW/J+WAxLYwDyfbDmFFoZIX/4pqJWbeN1CcSOhH6x947W
 VmLgPG/inx0QdcI+/SwYd/Z0r5ABMDhE1QjNHt+XJUHMg6yKt3tfXhmNKg4bc7gU2ceHlEtY8li
 zhNmh3i5eUqcIT8WE0cSR31h/SeBhoRxfB8mkAU6v9WdaIWpRyg/FjvbQ+ttitxZmDKr7N6i30L
 +pWc+S7xr43B+h67jYqDHWpFzrweC0Y7hOwbwYsSdurJC/nkEnAHDmiOjCajDidA+IaPPNY6GBV
 eOX4ceO0ECevDYWDcoVIGHhQ1ZR9GM7irMZLKYi4gnt/JuDDQDX5QAxkJxOoVEUg0z2y/axpKKE
 DDiLojWdR5vm9lw7Yug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210231
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

On 5/21/2026 1:51 AM, Daniel P. Berrangé wrote:
> Introduce a "_flaky_test" function for shell based I/O tests which
> accepts a GitLab issue URL, and causes the I/O test to be skipped
> unless the $QEMU_TEST_FLAKY_TESTS environment variable is set.
> 
> The equivalent "skip_flaky" test decorator is added for python based
> I/O tests with the same behaviour.
> 
> This is used by:
> 
>   * Test 151 which fails in QEMU private AWS runners due to failure
>     to make progress in time
>   * Test 181 which fails with a non-responsive QEMU on AWS runners
>     with the QED format
>   * Test 185 which fails in GitLab shared runners
>   * Test 308 which fails to see disk usage increase after fallocate
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Previously posted as part of the larger I/O tests series. Attempted
> to merge but it failed on AWS private runners, while still passing
> on GitLab shared runners.
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04939.html
> 
> To skip the further tests we needed changes to iotests.py too, hence
> posting for re-review before proposing for merge again
> 
>  tests/qemu-iotests/151        |  1 +
>  tests/qemu-iotests/181        |  2 ++
>  tests/qemu-iotests/185        |  1 +
>  tests/qemu-iotests/308        |  2 ++
>  tests/qemu-iotests/common.rc  | 16 ++++++++++++++++
>  tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
>  6 files changed, 38 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

