Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E42C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DG0-0004Ch-Ry; Thu, 03 Sep 2026 15:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFz-00044Y-Ag
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFx-0004Xu-Ji
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683IChHq566352
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KmpVMruxT6rvhDIfqh6o5p4BvGtD5b8Un4jGFcpxVOM=; b=SRon7OlwuFRBaz9m
 j6jeZVaogMGpeAnLVLnFZKdKR2o+Itl+p860jSdzgZ0Ri266ffYkPohnWkEiLd0l
 WXa8satQ4HWGHpoWCEXlrFLsyHhOxWpRLjMDItLS2P1zglIftDlucGE9S4Pj+ilz
 idaCXPzcXGVaEQe8zIDiJ216KAFJ9OdpPrkPwsDuNiYsLIlfeHHjc6UtzfnquqdW
 H0q28gsLIU03AnUSBwUB/LElOUpCVeshYoXgWRjUcfsPolxYqCYf1S6g3eRJmvqT
 AalDQg4S5FIh7ZIlpRzNv7FNaqIBaLA/ueetiJvwaslngtjKVL6g/Vmx6s/7zexv
 W8doCA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp0bhb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:37:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-399311947f6so269890a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464271; x=1789069071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmpVMruxT6rvhDIfqh6o5p4BvGtD5b8Un4jGFcpxVOM=;
 b=TS1v4SEhD93CibU26YkkLoYVwu8oW7ViZ9P8KmxfXW3n63B0Rqi3iO8A762AoHpzix
 bj04mjVAJ9FMeFncy4P6BSTbhRFjvJZt+nEQ+t/H1StFaXGDKYfD4YFScpGD9d1pKjA9
 vtZC4wKR2yc0So37MzzAGHZdeVUoxWC+yLQWFNZPb13lx3RWe5yMHwlhZgOm/LQX1Hhy
 F9w/X155YB46LuQngqrn5v/PIKC5V0etqxnFGi4NT4xJJpoE5CN2DwNOwPRuUBfRPM9j
 D/9yhGA95+tJqPo4AfyBzOJqGaJq1Ub9pmnbl/lUM1NlhILUD4QtLbpFvOtIR5FLkHe5
 VyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464271; x=1789069071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmpVMruxT6rvhDIfqh6o5p4BvGtD5b8Un4jGFcpxVOM=;
 b=A2WJ6ww4uUwPNdwlTYypnP4ppQmNTcbECZVJakHD7Zd1FwTOUt2D9JlHf4rNp/jj5N
 KYTQhNKpKAUf0YYttfG255UN30DgM4+36kQatWgmUmOHx+Q7hfQt40mGw0DyrapBINLP
 7oFmh2tf0DTnLNj+CV3UthZy7WlXSVZuhvmJ8sDjiXIH3DoTCqgNv55J/HZ3rkklbHBq
 qKVDUPQfCcCy/XLJ3Ae/sNdgKJiYmtTOa/y74UMQ8G9Xt8apFpXvSixVULMX9k0imLeN
 b56KXeXUnyLje80RUKvbB57dZCctdc8Z0rs9Tyr+s+gE2MpZxq7NONvE8uPKsWKnrh+Y
 OboA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy7x37QY5Ybwb5L7QeRT3iHqAxG0KrimBVDgJeqSnhRNZ5ingdoy80mUEerw1kmJA6aHQIbNBZRbhO@nongnu.org
X-Gm-Message-State: AFuF++lYXd37FJBLtLAikDfC1AM3JjDIAqZizPdkkWkFQyNZHB9wkp02
 h6nkiH1AUQSI5546rjn+GQWRAPGjInEUfF3C1FC2c7HD2x/7t+aFsYjtjSWsNewB6Jj1fDY/fhR
 on7++DWTIa45d+G8azGUTf4yea2whOG7JT5ewhYxpGxR6Cxfqb9P+uphL7A==
X-Gm-Gg: AYBFou0a3xissYogmtkazLXWfwuVlaEkp2+KIbK709KSbrlzGChtNmX4BdwEDywmRq+
 eohApopho1u4gLQXWM/UZ84842l6ZlHwsNF/Sf99hNzE67hNN5exIhsYZJfYSQJqJoH8tcotCA4
 caEIcpvnK5OvskKD6falSxmA4UjlTDBRMyi8BY9dPVnQ5dcFVsqrCBDZGNjpF/LlUO5eMFxr7Gk
 SZM5Q98h0yDSzaKw1b1Lm6R3Y+yoF+uI5NOSt966RhSKZTJhSUbQrDI4IXilTENhHfSwqaIc1aH
 o3K7rsoKGlA84kOseDr+zBxykPHBQCB/qrG2SQAwP38gjP19eK/ssXSHjgcYe/GM2dp1MHidq+G
 y5mT8yLCGuwh+5bQjE1vzaVvKcZOm7Z3VFmyEf/0aR5EKQA5o7ERmpRtdxBJ4IIhHfLsf
X-Received: by 2002:a17:90b:582d:b0:399:e97:8d5a with SMTP id
 98e67ed59e1d1-39b2627fe18mr1335937a91.25.1788464271475; 
 Thu, 03 Sep 2026 12:37:51 -0700 (PDT)
X-Received: by 2002:a17:90b:582d:b0:399:e97:8d5a with SMTP id
 98e67ed59e1d1-39b2627fe18mr1335866a91.25.1788464271027; 
 Thu, 03 Sep 2026 12:37:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534152sm977926eec.10.2026.09.03.12.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:37:50 -0700 (PDT)
Message-ID: <f1f68463-810a-4374-9e65-fe6d2c5d9ecd@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:37:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hexagon: raise imprecise exception for multi-TLB
 matches
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5oePqGFA6PbACPK5x89zfWGxuUB4VpUV
X-Proofpoint-GUID: 5oePqGFA6PbACPK5x89zfWGxuUB4VpUV
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a99cc90 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7y3qieyC2XAqVrXZidsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXzUoCz4jsaYcP
 jyspk94sImzg2PYPeuSUmAEHhxWtUkd/o10CkmgZv7Nugem+o90ANFMF3NpkgYgdScSGaSRJvWo
 BTPEtP/73Oti9B4lP3tiLEZO1MEJ6nhAMhQE360lG8tHu6YqVWEgITJaBublvYgjTugDl3qVXJw
 zbcPcLPzBLIvlLOpzDLePU6v2XCQ4A9zkS+NEmuFzM7iN7j7J+0rVGeIWU6TpIaFnm0VLafULHN
 ApnTp9iMONHRbS3BrIwREoLvRjB/WDBwXfxL7k6EQEFUD1Hvb0I6c6av9Z1luZylNwO7EuP0BMC
 yYNvAsevHGwQ9mQwhKvEGfgr6oIMZw1Zz4+bw00RbTUJGl2UxNd+zBlnuMkrYpRRflTudtOM6r7
 bRuNUCraUkhPpQBKyPQuoLdUo+DZfxC3HHRwKdzu4LLDVh9tJpjEIqlf1ff5bfwmCSdqg8CfoKv
 K2LNAQNvtBRrM9LYKOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXxbl8wR99tnY9
 1SKjmwzElitE7kf+BmLdmx1nVriqFLk5xaASoAnrq8LGRNnY68eFRmw8Sbge6IKxsXy+M4DrOWh
 ao15jaqhipG8/zGkuT081D9U4TJENRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030170
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> The TLB walk stopped at the first matching entry, so instruction and data
> translations did not detect a second valid mapping for the same VA and ASID.
> 
> Scan the remaining entries after selecting the translation.  On a second
> match, retain the first entry for the access but record
> HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH as a pending imprecise exception.
> 
> Move that exception out of the synchronous TLB-fill result and check for it
> after every packet, rather than only packets containing tlbp.  This delivers
> the architectural imprecise exception after an ordinary memory access and
> avoids treating it as a precise permission fault.  Clear the pending state
> when starting a new translation and after delivering the exception.
> 
> The v0.2.14 mmu_multi_tlb systest uncovered this bug.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_tlb.c   | 10 ++++++++++
>  target/hexagon/hex_mmu.c   | 12 +++++++++---
>  target/hexagon/hexswi.c    |  1 +
>  target/hexagon/translate.c | 22 ++++++++--------------
>  4 files changed, 28 insertions(+), 17 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

