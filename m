Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DD606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gcK/yGqe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FgE4vdLo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv5C-0004sx-4e; Mon, 19 Oct 2026 17:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv5A-0004sZ-Pv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:39:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv58-0007GM-6P
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:39:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZmrr282895
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LdkhOvx7L6vgMJAlM6ROG0bvtt+/tfZYsnNI/yGBY0I=; b=gcK/yGqe3DcJvAO3
 F4SA7dj8k0JhaxzjJ0Nm9R+HgK6rE5czd4RtEwLXZMx5H0Y0PNeEVBaGdYm16wgO
 4LL64w5vIfQTQoIzJKPklbEjRLB+PR/DO9A3UcgOV/QvXSB98BA3f/BNTxC/UhKW
 wS0geGVl3abrrhQl7YASA5FDlKgxNqNst7yw9e0A03hW65ZFlrz3N6+Frxqtav+i
 mHC91lt8Awoey7LXPwVzwfklT3HNekZmtK86/LJXHW8NodI2jXpNPbXy5d3JB8S8
 Ej/2l7Yo1bdSDHqNDDbXiDnSkFxWFrH5SHut72todSDOsxm0zhSL2aUiQeXkfDAZ
 qhaujg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48kaw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:39:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so123183eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445983; x=1793050783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdkhOvx7L6vgMJAlM6ROG0bvtt+/tfZYsnNI/yGBY0I=;
 b=FgE4vdLohYkhEenxbPwY2AEMqUldMM6nKJtS/MRGdOkQzvKQ92Y9nU+Bv2q07d07wq
 MLEKt+MInFxxWHpVgjrWlmPeAW75paVVtZjHHWwSCp2k0sNIqzz+vNI4UUPtjhSqgW/D
 ejB4pgvK3/YtnzkLwk4B548cY7b2PbNoByHgR/+UjE20jKjrf9cKumzJk6VuNRiTx2Ex
 jVO3VmyuVHOV5zm8MvW4oCr8iQcwqgzp4twmz0AG5RaIv90orOWgXyNqhv9jQ53pGCco
 30RGfvd9ZB949LhvWrbToaA8yQTlhWm1qEdX3qyCWcCSaAjK7gdOQkYx0+Fyv/14jca9
 WE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445983; x=1793050783;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LdkhOvx7L6vgMJAlM6ROG0bvtt+/tfZYsnNI/yGBY0I=;
 b=g2Th6DA3+6YtbdiaP7/RQcUTdzuwBxv9PP9GYnbFawlSRbXQ54jM9lDhyNiJyA/DC4
 7K7r/s5Etbq088lPm0PGZt0Krwayu0/0Qb35DNEdb4gg7eOjurbqC+ToaeXIbTziD6YJ
 WOtmSdPIuLT0y5g8lCdpj6J94/G8l0ftBRX1UAIWzEJWyDTnr1/LaVciPQRqXugDsTio
 94BWMFfwfYLSMQvpwT9ChlsY+cOaclmQRZJHW5yFD1zmQ5YE0DbMyX7DiDpZq6l1xiV2
 UP4IHqXcpL0EAfRrE1pflRZa6WBkbU2pUkGka5moOtADXW3WPe38bE32aezOL0l5mj0/
 zLlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR46CN4R2KN21fzsK/USQKRFrI80+hv+weSzd1RMzZlQXLhavww6myWCM+OIVOS4UhcLrM7erbQQc9@nongnu.org
X-Gm-Message-State: AFq9FYJTcsFnkNerPEQbN0G2zMr+n/3d8bo9v2X462QGxfcVIdYZaeTA
 jTI1neCWh8KS+ytl7bIdGXzsitAIt7p1v64w8wwIxu/HydxzGBLJgICoc7niixx2C2SmfVWe6O0
 3TjEBJKAGDUiU6OtlKpGm2nqtLrK/dsgVGdq6awM6C04HM5zHFCzfubeieQ==
X-Gm-Gg: AYBFou0Epc1C9i7+cW9cD8A4ns61JUEa7StA53FuBFNaqxzTXB11b2CVzMCb9plhpt0
 8XUaoB9RaCur9g1fhzRBFfvqN7k3lOkTBgoF5lVKu0KRkphYGVsewK36+6oj/cH0JaAAVli/Llr
 fd0O0rPL7d44gr0NmxTWSesTLbQn5De3U83xqG4BJxWfCoYJ20PYQQ7+v6zG7vybAktsvZuI8Nm
 D9GLkzhNOpYNrEHBVzqBOmmLlJH0FoAb4seYU1ldFz8eErlqD1/iYE8GiqQhQ5SYvCyDrIiz3Tm
 0UNJ2thOGehPvLq0uiClVQNxtbcmrsU0A8cSqMl+wTPtlpbaaM1pteZRpv7V07DZ5KKgR6LEJeK
 8rx5vNw5vIJuSUP7M7Wq7G+RP/0SCOiDZWQQiVuXjq+pkVmeCLWTy1HJ7ltz+OGsfgnO8aw==
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id
 5a478bee46e88-365fb187594mr426886eec.17.1792445983526; 
 Mon, 19 Oct 2026 14:39:43 -0700 (PDT)
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id
 5a478bee46e88-365fb187594mr426826eec.17.1792445981823; 
 Mon, 19 Oct 2026 14:39:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm34834843eec.25.2026.10.19.14.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:39:41 -0700 (PDT)
Message-ID: <76be8c17-a625-4916-8a4e-7944a1f67af7@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:39:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/intc: ciad should forward its mask to l2vic
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
 <20261019060911.1479329-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019060911.1479329-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX+NTpTbTPTFyX
 49gInCeB1P9+6RUiDbTK5K56b/ZmgAodTKGZVka+WRdEUuu/3Q4EYoPqMy9EAzyl/m/6jxn506H
 BzIr03FhWKL3HJjOHl3w2euzl5tgXwjG4SBL5l+hf/OEqZSzL36XqGTrCdCSEMIIZl6FhiuT9RI
 +G4QjOtrmcWo9uzl7ACtyujuF+K2kokFFX0cZ2QNLc0x4ispOqKhz8YAwcYotOCuyoE39tr9Cd3
 H2vbK2XAinHxX8WWiDx2eZRwxpMo5vx8kB6Cjtf8VMrn+qpvm2Tfb1IMFlBT1KJjlY/oWqihhuL
 VBRW3AYx4ujibnmx9e2d1oCsYa3g8vpv71HlRpcXmC7VcXD1inB1bo82ZHd5TprT+pLD+YNmWg/
 m4SsDugHSrK7Vddw9HX02IfXS6trv6+o1PfyGEv4hbGHu9IRrCtYvYTAITeoj6B0zQebdC+zwII
 7Sn8LFyVPBEp+bqcDXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX5hGIZM9jsi5B
 QFgqZmbUiMM8rfGHnWVZKejcKZOf1tQQ7NxsHh2sLSCUmmzn/IRfXZd6fs0nr21RYhLutc/WoyY
 2Szp5Zb5eFIuBcM8XVJa/P3AFc1/aUo=
X-Proofpoint-ORIG-GUID: kTmDM8wlpboDeEfUA0inhoyz4xAjykOQ
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad68e20 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=eZRNJp06_hMD-UVa6dcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: kTmDM8wlpboDeEfUA0inhoyz4xAjykOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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

On 10/18/2026 11:09 PM, Brian Cain wrote:
> ciad cleared the last interrupt the L2VIC delivered regardless of its
> mask.  So a ciad for any other interrupt would get applied incorrectly.
> 
> Only clear the active interrupt when the ciad acknowledges the CPU
> interrupt that its VID group is delivered on, and only if that interrupt
> was taken or set with siad.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/intc/hex-l2vic.h | 14 ++++++++++----
>  hw/intc/hex-l2vic.c         | 10 +++++++---
>  target/hexagon/op_helper.c  | 14 +++++++++-----
>  3 files changed, 26 insertions(+), 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

