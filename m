Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84680FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDsX-0001Mo-A5; Wed, 29 Apr 2026 18:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsU-0001GG-S0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsT-0007kH-7E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbLnK3992793
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9eI2/JXzL6NCzpBAQpD/kCiEk5GXfsBllQYxDaxsvXY=; b=ac/dTN5Zdz5Mu3/5
 15ZP7LGWfgsX0Xlx6NE8mL8JY6YkLlJkdzrJ6Wheqa7lMBovR3s8qxcKLnmF0lVS
 rpoPw3We/0c17jZs1rshBZ0AMqDq1IEkIFyD6oeatT8AvU/YXrkFbo1SnFNw/ubL
 DASX+WB5NquCDlT/atfZ4YuZG57eOLgNOwb3Ue+vH1y2KYZSpb1T5fz3WtotKvaF
 fMwTiPhv8/wlvEpdvfQbVw7R3NVoJJhtcgv4FkP748xam3+ktZBeqnBtLHZ+ZMBQ
 aRYWfw5FrljzBxJwJqpQB/ZSA197qCFJYHMOQv0x8JAUzvMjUHNiW1CquDweRxUQ
 a6a3wg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx928ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-126e8ee6227so560028c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503571; x=1778108371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9eI2/JXzL6NCzpBAQpD/kCiEk5GXfsBllQYxDaxsvXY=;
 b=GpPT54REUhcIIAfeC9O4G1vnAdOAhO/PKgOt4u53tMOjX9I1ssIQqKTX0Xw4/+WztX
 AKiljIMDbiQvk515kAjg+vNb2pv9cG2LOIH1ltsxf1hO5lLXjirpP3b0cfKZk+g9RDVx
 S/3dLBi8QHKAnekZ9am2JPa8aUZYh7jZUlJKgwBi0fki2aHQMJZ0GiDGLGoKdkxBj3Dm
 eGBZ+KQLwMPkZ1NKRcmm7aT3pGJEJEiFbrn5b2EP5obMbH/SCcGGGyZ+bE+agvcNVuek
 kwKDWfTkksxXm9bcZ235FHzwEovgoYqB8AeEhpH/30IXlbqIgvYO0CJaqJbCpxihWRXY
 BqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503571; x=1778108371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eI2/JXzL6NCzpBAQpD/kCiEk5GXfsBllQYxDaxsvXY=;
 b=V+1E1WhBuWwnckbbSylcdkph5I35HShcrWBcI5nUxqWF4s3onwEhQrEuwcWFWPttEO
 2xmR8bcsAG1bqkUmhJ7RfrRX4jt2vP7wxAEIKUlMV1oIHvbCMr8iU2jUNZPfFmJR8tvu
 cp07SlIVvq49cIWkr+RyE5F36i/yUQsvhpXLn/b/ZSjZHBMZXW19H9IsUmKaF/hwlvND
 lCcG6z29bClBh/XBqADZ6YA7lAQ12950IROffxHn6wn0pqTYAHVoyylzHXNkeyQHLEBI
 CkHxHRqozjKx5Hro43zi+Nti1+ES1Hfc8Nn8Hk97PZuRKri65J91TOTt85N0aB4OTVs1
 CXfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cpza7oHGFJd77g40N1b3aJt2OBadBJQevb6IkrGlphtlmr7ZJXBZ9OkOOkAKE925wajVNPiO+Yx1p@nongnu.org
X-Gm-Message-State: AOJu0YwZn5qDUMxUrKorzAZ0WZiLkr/Ay6HyoIH6yJ4vkSoVI4uXiplp
 uq2z5xXTOAKQ8uFXqzBGmIgxzuT9It/0vneEJMuhSMAIGmS9xF206Dwh3iZKy6IwlnmTriiE7Vn
 J7nn+OMva7BrLnBeqtrmGMpwEdxnB6hw6oTC5+wjyWGQU72duzleqSMJ+2A==
X-Gm-Gg: AeBDievIsSZt4XzmCzOCh6mfFr6UnEYXfxE2CF088cVl7nKTi1FHU3kaITkF4UzsiPA
 ccsXMYdYCiCvAvMOLTHBB3srwdxd+ksp2fgxX7w8BGjfHx/t1wEvatLwGhf2GAJ1Ky5N0YDjwgR
 U4s3kHC+nLV8q6ustCo4m3Cr4t6d5rbZdW5MhvFyFpWEGl5lEbPiZIfz+x3SCAERycijW5XGFNw
 n/GQs1FRFNd+xeuC7+J59AWiZSBFvNNHTPo5b2SP1xNWOc7dyoDu68zULvmDvKYEIvQP/fzpe72
 cLQ1FFSFmjkf49ls05weofViGUvZkKBu2QTUdOO8xeL6D/RzfaJ2EeGBZSEkdi1PFj5zQZJcfl1
 D6uvePhF6g9TxeD84ZmVKl0MNyADe2lG0mERZUynBtqRvYnTGmbxwgS+k8s7xnJsyD1pFHb/lnm
 AuLRyO0iVccW5F3BTDoRjDXWvA
X-Received: by 2002:a05:7022:6190:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12dead00360mr210105c88.30.1777503571157; 
 Wed, 29 Apr 2026 15:59:31 -0700 (PDT)
X-Received: by 2002:a05:7022:6190:b0:12c:2dd7:9099 with SMTP id
 a92af1059eb24-12dead00360mr210096c88.30.1777503570621; 
 Wed, 29 Apr 2026 15:59:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm5992786c88.5.2026.04.29.15.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:59:30 -0700 (PDT)
Message-ID: <c1a9a00d-b714-4c3f-a0f0-af58b0aa3afe@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] bsd-user: Add bsd-ioctl.h header
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-9-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-9-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXwvawzPwvWUjo
 oFD2HReOQsp3TMgIbp9TxZR7/gMhLrseF09KBuwOj8lCiX3dATqv7Jv8VWqVek6rWdo0gKpHh1x
 YGidWHnhqfRgPzMCqR+JZK4nTNWvKGccLhYAA3NZjQ0UuMaM8XWb9Ur4J31Htx+ZoaaAn6lbp93
 GYi+tm3s8VKprPCiVDAUtQyHXvfVGRk8fweqUeduQajFSfSgSsjKoE0qdJCGs5t3Ew8eRyEIdjR
 hgiUOy1njF1IiH2hSJ6DkmjTOWoCZeUaPFmlfRoZddkG/ORJuFh2gnhVKOR1qiFElxSqV27QYA3
 fTWZo7ne9NrLcwIzXt1sBfOZvim2IqXLzFJYaQBc9XEJjLcOu/PDnmT74WirGH/UjMgsYWQDAnG
 LdrNulyVZrj/VA3iF9RRwrYMvzpR6ocqqj8teWJcn6PCOJLc6owf5mDmiQrsy/hKi4Q1DnB7Qy7
 YOXDBF2gGXKVVQXIOwQ==
X-Proofpoint-ORIG-GUID: JpwXJ8h-4YPAQUk_8dHA6Qxk4BOrr_t6
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f28d53 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=ETJzFgsexhVFidZkbskA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: JpwXJ8h-4YPAQUk_8dHA6Qxk4BOrr_t6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add bsd-ioctl.h header declaring the public ioctl emulation API:
> do_bsd_ioctl() for processing ioctl system calls and init_bsd_ioctl()
> for initialization.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

