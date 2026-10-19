Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D866606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zh9XWz5S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e5i75pXC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuxk-00023H-Lu; Mon, 19 Oct 2026 17:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuxj-000211-B4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:32:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuxh-0006sa-UJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:32:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKCR73329074
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7SX6g3pG8tn1w6hp31IhySFSlaSA2fhyEHuWnNJ6gV4=; b=Zh9XWz5SI0TMx4Y2
 1TcZwYjPETlrZQHTooAPClLMmw6ckh6ib178Irr8pwkrnM8fzSx+7q/gZ6SQbhG+
 SOwgqSJ/h1D1zJw/pgeEqfn4ZxOlatzZP5hXHW7yJ2m4PKVEzIPxSMLR/LENqo3+
 b7on4kliUKatHjTVSdx8dcVHgFMvTPMaGyBLOUWY32AyhdSW+NsUKD1AaBwDPU9V
 jBGU35yjc8zkte41Gk+9WcWu9bFosFQJyc9CWtjnMllL3YW/xpb6VIBV55i5e7vT
 UMUEsvfOxsDabfDfEWzNPkW0aGRPRrfJAkwzKyk9slTLocfy9flVKWHSRR3vGm5j
 p343lg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj3jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:32:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so6453493eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445524; x=1793050324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7SX6g3pG8tn1w6hp31IhySFSlaSA2fhyEHuWnNJ6gV4=;
 b=e5i75pXCZNdUKr99hS/dYtnTwIDBAWgYXkx/RgWS8ekF6C3I+3QBOnKYhV5XiT96k+
 gLMZfV65KS/vSDhMPgzjF8DJIhnEN2plDQj6EjoJehXb/sax37q0vN+IHs9SOC7/wy++
 q0RyDuJsKkC5A1hte8Ac2CNIQHIsp6f5bDfeSeHhyFMew+/QYYcdLT6A+xQq9lXDS+AO
 gF/o2b+jtphfvqAMOXB/Hn3TTUVwcARChNAyv85hxYFDHQjPbV0aAQqBxa/epy649PDY
 wkfXMfuu37taT04ijSe+krdT5lHYsDPibI2u0ANix+DofUXVE1wyxH2UsKQu7lggMiNe
 HGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445524; x=1793050324;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7SX6g3pG8tn1w6hp31IhySFSlaSA2fhyEHuWnNJ6gV4=;
 b=Zb2H1Sy0P5KdN5EDIKjleNQYbr2tuUxWA/tfQeyUDLvH48BRR5Fkw7K9K5cgyBGaIc
 t7ySv5PxXDzxT1QG24HPS94WHOyJXAo1dQVdsmo24PfIpEN8g1BV2cvY76DPgbykaOiR
 akJm/tneecAWSB5wTL2zRvjR9KmxuOcE29kNJzWfL8gSLlXcUbegMpEZ5fqn6pLNoOUw
 7UgZyj1n9EGfm/LhWEZGdWn14SEHWnmSwWimVyRIfAcu9XG4GqY3VvI39cPWf8SGz5jg
 Gfri7LVXvIs0QZmBMgDTdXzVoDRB/U8IwjTE4cu/IPR3dnQp83ONQo7XpC6wiw88hQp7
 hqtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjscA+BTM70w2IFrVOjHtaRm+PX4P33JVvsRy6HDHY+bWDuIitV/yVUVDNXzg09fca6GrGJpp8e4XF@nongnu.org
X-Gm-Message-State: AFq9FYIJ4k7W3DfUcTFKk0i7DB+jxmUp+67Ujql7o6boIhLFsAZUuuT4
 updSYStiGAwHETkeoNctJfzAIHfdxgyisvbfk+J2nukXo4/PZ/bgi3xnb9zezFnPYv+wt/yP8wq
 5Zzr/F0toKs1aRtT9LN7IoH2b3IQaGEOBOgONS+RYSTXTB9BU7r9A89Cm8Q==
X-Gm-Gg: AYBFou2tJqpUkpW/rH6/xNpi/O9D8/GShlVaJKLL/pxTH4EyVhg4A/UeZ6M0kdt7/CM
 0mLwqdeH11jlZzrH4o4o21L2X+8Q99GzwIXYWa3g8ZqGo5QGQOxQ6U0o+fva0San79BTwGMoDln
 42H9ceFjyOsLrdtwDE95BBPdYHxtrKrO4orBvreRTjfEx9TZWRY8ZNf5n32GF2GKsO0n1UjXztd
 b2WuKsmuHpJsH2we5BW68eagId4u/nKfXJ2clQ4DNurI6ZdQ/UDev29IvrRZ3+VbNsJza0YGyzy
 nfxrSRD8LfG6DpZ8rHfJ2Dmjw8TVD5dWoDTlmO9sSm06y6fit6lq4i8ZOOifL4o3iFr0G7p0bnk
 BRRGm1AhGRRhc7r7lLTWR3e4RZhTdLqFOvDoed7XpHg9hzf7E9m3/bjdgIFZFB9ls3uYoRQ==
X-Received: by 2002:a05:7300:d409:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-361a1f5019bmr13531219eec.23.1792445523938; 
 Mon, 19 Oct 2026 14:32:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d409:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-361a1f5019bmr13531188eec.23.1792445523205; 
 Mon, 19 Oct 2026 14:32:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ea7e5csm33481459eec.15.2026.10.19.14.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:32:02 -0700 (PDT)
Message-ID: <00a136d9-1717-481f-8136-d2f06778b61c@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:32:01 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019172603.2625677-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x3sXfJOcMo_EGFO0qJUtkvC0leVwR2tg
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad68c54 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1s6MZQv9Md2iBDlLmnsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+VwBSUY4Phju
 6rHy1MFQYejYwyeRo3pZ4XK1ItbFK9Y39acgSTdDiPRu5c9etv6Qz9AN7b5lwrgg6MZwsJvZeY4
 zk6PlBInlLHEPin0JSUVq042uE7tU9W67SwVdqQew0xNfbruq3Mrdn4koox+6x1zT4oeRRH4YdD
 R8GTI1jai79ewBIu6V/4a28haazf1ZdzcfNcA5BwpU2fr2CEwe8dMyCySoozQt/SfOSALnyLA0+
 +XTdz9va3Dde1ezTDpVzHOQinGQR0yS701WOZ+n3tcF5l5edu/dxqadGZ4UXN5ZJaYtQ+kJggyP
 CEE/BGRe4sqw1ufSgZei0qoFPSCVup9MDQZ9atlH9jrSDgrFHSwlqQWsiekQPCKneK8XA2P5/mx
 aG+BIdfw6gmlFUJ2xVi4GO9AnHuKK7RKWG8/t7hg61eVm4tixU+buAKvT6Tbd0yWy4msCE6R2+N
 FsDwC+zHeC8YB1VoeFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX18NhdhyIHTaF
 107SGkLUYiv8ONTgNUre7AaNXS1gghgbHRzZbtS9WanXsbhKz6oKH1v4D0ceLW/KxCaV+3CE5nX
 O17P5FIe5BIwT2AlOMofr+RzAhtKQC0=
X-Proofpoint-ORIG-GUID: x3sXfJOcMo_EGFO0qJUtkvC0leVwR2tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 10:25 AM, Brian Cain wrote:
> Bit 7 of L4_loadw_phys is valid through v81 but reserved starting
> with v83. Decode it as a legacy don't-care bit, then reject it for v83
> and later.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.h    |  2 ++
>  target/hexagon/decode.c    | 19 +++++++++++++++++++
>  target/hexagon/printinsn.c |  3 ++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

