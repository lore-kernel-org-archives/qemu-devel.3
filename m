Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A80606A8BC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=llifW1fX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYPM8aqL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOFv-0000sB-FW; Tue, 17 Nov 2026 13:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOFu-0000rE-GG
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:50:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOFs-00009Z-VJ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:50:10 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGJIu83327499
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWRsBfjlBszW7gbx4y38pQ2KP6CgYbX99HlmLzaV38g=; b=llifW1fXmLviccTK
 eYMO0KGHluNXh4GBMMXRRwYU3H0HB4ImpRaXwSlJ//SLDjA2yl/K0flOyrow5OH3
 Rhau1tuylNSaEubUBByu0MHRtcgqDXS2JsbYNEwbX+8PA+WlCFiJGH+Fgr8TZZsp
 5jR7CkA7LU22ziPJpWD0sqK2ePV2C0uPizhfxSWpaA2egktHOCLhQcVgLGXscuIe
 Af2PHEEYBq/F5C8Ls3Mi65Ikjxl0JeqVBBGjpnHov727svWgxXKGubPm9TgpqPnG
 jLdbavZBaRBKz6x8NTqzxpaNhSlw553TN65X4RbLOZqEbFlQEe1qOsuar3AtdEay
 r2HvSA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbarnr5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:50:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so212741eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941406; x=1795546206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KWRsBfjlBszW7gbx4y38pQ2KP6CgYbX99HlmLzaV38g=;
 b=RYPM8aqLtVVe+V1zfvQAMd3NdFS2sLg1hEHgICIIrj6aY/Znsx3Rzh/AKzSOXRO5WR
 5IvbTaTwj8l345CmWOmJ+2wb7Yve2ISTQoS993xMZinipdktpNqWejE/H+2Rce4I414R
 hIc5olXKtYGVhe4VeyiQk9vC2jQ88/ZQW+Y4/dSL/4m5KiQQ/BKI+yXFg7KpHbny1TPt
 D1FfELjNnOs3MQCnp/flVB0o6OnFZ+vMajfk8tsC/Y5AerwZpHxLWQakjeA1tAsXA7b2
 6i09aQBJ0Wl8iiMiXDXm0hpdXgC8QQvT+i/f/izevPx9xKJbL8iRWpNDA8apxXHgefEZ
 8hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941406; x=1795546206;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWRsBfjlBszW7gbx4y38pQ2KP6CgYbX99HlmLzaV38g=;
 b=OjDcdLPurOOnSkzq7uhYGzK3SGT/0XTrQJUhxjxs9sWsu6VSYAoAe+y24H1mqTardt
 a/o5VlZXmAGTeh3uc4pO6uARka05mjpx6sUmkQtD2pauyqIdeqqcx4pnFD/Eu7AI7Gi+
 Qa3RUnprAoAn3yrXNRkVGT9REvbHIuu06SCjGvLTdfi76RZM8GYa/s8s+W9hPeu2cuqx
 3pQ6cqHBT2NBilbrSe//vUNYqAXoquammu8ElH6zObqCFjg57AsKHl8N8ydIrPKuW1sI
 WImoJVmpcedkqNi7zn3n3o+/4epXOLKhTjMORa/yLbfxScrWfBRmlcKRCJOmnkyT/Pke
 mgsw==
X-Forwarded-Encrypted: i=1;
 AL+hErEJ5gHCj40Ur997w4iHr3F6R2HkBDYeg08NSwLgsjxfHgxvafG467uZAbujsSeDsVxGEiNvWfUHPh+m@nongnu.org
X-Gm-Message-State: APuU4Z9cTk3Q4bCFjJYBN2DEVEIot4tUhJVugDFwwSzKNGBP5MPk/3xm
 cMIH8JM/D1l8v+WQXefA51l7jmB/oKiX9ve4auhHE80GeNg9WMk6pIRK5TjOjJMc9Uw5Ys1s3nh
 TBAYBuWto2OSlKZABu9bZ0rPHqZC+Bt7PjAHb+ibf3GzHgMT8oEoMC6dlBiC2EfDXRg==
X-Gm-Gg: AZFdTZdNLvf6ImxA+5/AzxbIvX8vvckOWauuVJuXI0T8JV4MWrA6wdda4HOs6GIwvq8
 m/XrJwHThTUvkJRVP40XG06TBfdm6+yChjsgcg7R3erD3bZldwF69OzEbxxwKmbvCrLYojaimK/
 EpSfLtvyGGLmwthBSb3QSMzzC5GM+mPbEO50JaKEddjVAawUtuX4Cw2BvxKoefc0DNkYlgbGzA2
 8u24mdv1kydFLByUBbGY+BRUvSnEWBxkoMFgwUZxNcxpBJJHYi69CUkCa3IHIDYV9L9N5h082Rx
 8K9k7Hg6tu83mkGTvWvrzob5QRstobnJCSRSkN6eS87ZbCrbOgZBg/iUap+ZydrbNq/ybpKA1k+
 2xrLw6uDZfI3b9QYoLhXpSBuj0klzvLE7ahGN2ZzMe5A4RqP3kPP1QwgyOO1+GWYUZjQVcFgLNJ
 lMi1VhkEbptic+Ad4ageGrgXOeYq5DdUsUqwvnMfwzjkI=
X-Received: by 2002:a05:7300:de09:b0:369:f9c4:1fda with SMTP id
 5a478bee46e88-3828111a846mr292951eec.27.1794941406382; 
 Tue, 17 Nov 2026 10:50:06 -0800 (PST)
X-Received: by 2002:a05:7300:de09:b0:369:f9c4:1fda with SMTP id
 5a478bee46e88-3828111a846mr292919eec.27.1794941405816; 
 Tue, 17 Nov 2026 10:50:05 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm49386458eec.23.2026.11.17.10.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:50:05 -0800 (PST)
Message-ID: <39ae48fb-6723-40c3-a072-7496ab7ae833@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:50:03 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] target/hexagon: distinguish packet-page instruction
 TLB misses
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-7-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-7-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX+MJuLg168Sjl
 la1kxFk7a0yiKDRzX0WwD6Nq2htpZ6cfDJ1TNNcvGA0g73/Sxa7n9ZzLjImOGl/A4OYnhzEGbir
 c14vdhZmTCK14Frv3Okc5js13urD4f8W3eKr3hCl1gEXjmk0GnYvFnxlBMRNPZQklwMdJmhYO9d
 Ql+xa+hBNLZGiM4y6npdvOeAuyH7rJ8fbI8yXCu2Pvy1tJqShEzsXp7iAo9lqwctJxc+rHz2QDi
 ISo9jNMhjCCK8fPfvx3Xb2DaHGl3GYMlPJ3BG+A4UuZVgegYA8Fmbj5jntruBE6cQ+7YxGbQGDJ
 xEQH5rgTvJKADQTksYC85JNQqBK0cUDRsJBpUPLjJyAQCq7lwNYMgfP8+FpZsgdD+aUIGVxjpbG
 uc8itcp/G4Eeyi6cofKTViAOXNP/nB3IWbg45OjALr/2JCkl8Ni/OT+3EMolz7DmZLYn6KNEZ4J
 1zbAa5f0zYltxgaOR2w==
X-Proofpoint-ORIG-GUID: NOuvbCGiwU-EiSTPUspmvHYcWyMsJLU-
X-Authority-Analysis: v=2.4 cv=Vsy2kO2n c=1 sm=1 tr=0 ts=6afca1df cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YHqdVtTeOabZ1ThQ9-4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: NOuvbCGiwU-EiSTPUspmvHYcWyMsJLU-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8pgqhzrPKdrU
 q5M+BILvm2yh2vZ6rsH3/t7xeaxpHFQ2hg1urls4X5maaLZk/iKutJgbcL1m5h5ga9rTruy8Tvx
 +e/rliUSP9K9SobPu4gujHr/mzV3UgQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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

On 11/17/2026 10:36 AM, Marco Liebel wrote:
> A page-aligned fault address does not imply a straddling packet.
> Compare its page with the packet PC page to select cause 0x60 or 0x61.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

