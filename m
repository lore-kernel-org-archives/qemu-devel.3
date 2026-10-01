Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7F8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP3Y-00060Z-KD; Thu, 01 Oct 2026 18:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP3I-0005v2-Fk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:14:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP3H-0003Lc-0i
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:14:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsc1Z3512247
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLhllw1lPvFsUw4K+gUA5ViqaqHdIWDlHn9eJjHjX4A=; b=ZnJkjegcPmgj6U4V
 ulPEmdaF3MOnU9txbAY3jO856FEV6DSN8kXD8sFsY0bQspeAM4qjFAtFhM3vh2Xq
 ujk/3bjaorNGWecen9jsXyH4SQBoinmzM1PDNtmzUo+a9PJdlZTrjKRAu6F93z28
 h4GEWLRyWfyIS5YVaqmSbEFcoqkbSq7EuiMVthaTZgqiqZshk9gfdybDMKQiTUe/
 YH08y0kfbjNcXHHRx3JMcCLivHTrvXpYVoXSyw5DtDCMG/dK4QlQvCajGqcWrOIK
 qa8+IbO0wgveqtpFkeri4TVDhyapOkgXqiZeeUPTir+0GeviWSK7yjHaHpmzMXtU
 a/q3Vg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1qukacs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:14:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef5fd7934so1291066eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892893; x=1791497693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bLhllw1lPvFsUw4K+gUA5ViqaqHdIWDlHn9eJjHjX4A=;
 b=TGLD8+dEkoBgP+ga9amKIbKYiSqYfaZ3b97fWHEOuNIpC7aoE48JqVlnXlYCvUjtFy
 ruduBIB613oVG4XaExwbI++4RvYbEi9rcG5UZ5th3J/Z/4B9FyP7jr6u1zlOYV1fsgR0
 qKdJRrahndF0d+qDKf7FNUKeq/6ehmLMI4QiDvepscGxcCMoesTaPsuvU3D1hc51UIXv
 0UG8bwrJt4TQdi3+vQYJRU3LEHys8mDiwhHob6nj9p7xaMem8gyi5cSn4b9Av/uLEEqE
 NJHzLXGG90E0RdWd0TXGbNzSral7wFtJm/BVYXl6Nm1tKEg8//YQEf9t/FYIqEbN97du
 1OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892893; x=1791497693;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bLhllw1lPvFsUw4K+gUA5ViqaqHdIWDlHn9eJjHjX4A=;
 b=l3AbGmAafBvTufjTJWqMIze6e1IRKnyWlc1V+4SBzoNzteJhScjH+FZ6Dn014U+JVW
 5bKnR1wGrj20/i0KrNa0ysB6vxnOmQv80Z6Q6mAd1gL9Pbb5n9KM2K6BDSFXhwLcPjKM
 l6jS4/sm0m5w3iRZphdTNqCGsUNlemDCdvWxP9+rSZeiUyKu0Pw9NagL5m/sVxq7oCwU
 +XkDQ4ufbN+dBmfCVtDInJQ3ErBU2pbtG+KnmmferS4F01s6F0VwWZ+upm3/lcS9QdmI
 9B/rd15YywRKveJMW43n7fWtEXdi5b+drnmlHIqaNOvjOrLc8WhsKcn0OJSSyHk0G5U9
 RPiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxg4fvO0kaT6SkvREu2RHkWjO3GyKxfrwZCsZqSmbMDegjLlRrW3YauWLHTE3BY1WKBqHJyq7dHg6W5@nongnu.org
X-Gm-Message-State: AFq9FYLXWLJBYXKsMI0REG1DFdEF33S12z4xLI2TaODF8wJ3JY7mJy2I
 XK1wP+/Zgl4FE9hbHjCxoXaZ0O7jX9jKNmyStwcNNBVAxCmLd1JqpnQxa2FPzK6gQ/HGase6T+w
 Ucr6FUjf18XAOMMv04SBrqcytGy79QcR9p89wX2UmPc5PNqiFD0eE8gLc7Q==
X-Gm-Gg: AYBFou0uTKOSrePmIa+7mmH9yN59ZEfWo0HDQJb0lt7YfIuNu1ZxlD1mRi+Lsa9/KWE
 0hxhU00UWkG3AN12whwd7pNNzcMxhogUjI0qlMuS8rnfPQgzAdHhWioKZ3OdEP6H1ZFTYAZ+Opd
 Gnn/VknrwEe3pMTLKbwKgifI5+t5xG1t5kSG3YmGFilcGrssnR3ehcklSmVhn3EMkXlCZz3fbVm
 zmm7kzTk67aGxXpsUyOpYZyM0EXJObzPRvC0emd+ETxc2uyNMCZ+HsOyZ2F97bVenS17np1I+Xh
 4x98weucbgMls5535cuqOgoP2hzEG6tXQEXXpcHqQqLoMwe9a96fuEyq9vE/uWgY34+2KEuwJBL
 nkhdrritpT3gsud5XtSDLOzUXHzWxn7fhOYrZvCwYoHceEYDV2DY2jiUv6rwJYLPZuhgbuw==
X-Received: by 2002:a05:7301:83:b0:331:89d6:80e7 with SMTP id
 5a478bee46e88-34f1506686cmr692208eec.13.1790892892964; 
 Thu, 01 Oct 2026 15:14:52 -0700 (PDT)
X-Received: by 2002:a05:7301:83:b0:331:89d6:80e7 with SMTP id
 5a478bee46e88-34f1506686cmr692185eec.13.1790892892240; 
 Thu, 01 Oct 2026 15:14:52 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd9698sm1101288eec.23.2026.10.01.15.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:14:51 -0700 (PDT)
Message-ID: <e33c9fc6-5b6e-4b96-9ec5-e75f1665109f@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:14:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] target/riscv: cpu.c unconditionally check larger MXL
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-8-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-8-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX7KbPBccVczrQ
 v/aLLJ2/+nwsTLYnI5mAMovDC4VPvnOTyz4FwMzoDNrrs1ycK0v8hs/VDSj2q93BVUn7NHwQV/Q
 aH9CbIFBQJLsb4dKxormC2EW7G1wnyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX07zzP6dNtSu8
 XelQOKRTDIEa6kgPyE9b+Xd1Foz3RSsYPMhKR6xV/8xIi/Rv6O2cKyz12anA2ZJ22sgaBSCMC5Z
 lgDpV6hcWRu6bg1taMWFF1td/+g5FVcxx1m507dws3ViSENMprrJuS8mOkMYHj4utJWKlrWcm+4
 8DYxIxNMLyAXAseOg1ivLpg2EN/RkzdDKoFWmBBEXs4EMPXfoaieozkRH1kuygE3rQL9ZHWSFGl
 KHg2GaA+qxRoM06pyWAw5/OM+UxAeKfgo9w1ImD0equKaYgtptaYtxqCAKPKsP/+Y65nQHxWpe9
 D8wrdxYtTXFszGN8PLaju19rPaB1vBoEbAr0lSZPUgXm/R/Rb+WbmKCUnBQ6P2FA34lDiVlUUBs
 fH1copdL6LI5cFUZ24/8NeE4h2+IOCJoTS/F1xiZIWU+jg7CzZAvlZ2cYtAXMhdovJyjf3MEZK2
 DM2Vyr0CQi4ko7fKnOQ==
X-Proofpoint-GUID: shLiXnNMk_nV6xSu7QRuLRP3cs2Q4qnL
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abedb5e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IYDyM7DTYpwxc3Yv4xYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: shLiXnNMk_nV6xSu7QRuLRP3cs2Q4qnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

