Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A578C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEk-0001Rl-0N; Thu, 03 Sep 2026 15:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DEi-0001QX-Fa
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DEg-0004CU-SC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683IDIgP1257104
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xFFM9Mzn6kzPq3OKw0lQ1wbgyP83Y7dhITvmKCJo0t0=; b=b4ZPb83M2U0VSxl9
 sLzDPsBTeSxJM/IVeRS45k74THH87Ny9/IPOeb/izCh0JFBcUq2t0mGE+zTTWK2j
 rV/BSIK2Amoj4/dNhkWQHXAVhYx8FVPPfcJ1q9cNzn8XPTMAHFIxOYPUeY1cur8i
 KMekF2lfM28XWevnVi5IdLh57cca7oQCOE80w0atSc6y92XFHSC6Vg4LLLPxvHu8
 mzYFPfbXF0+8OoGwLjsSsD0zYJz4Tge90F3RiDGR7ZC/CbdOBwBERb6ZJbwkKs/6
 uMzsTNpeBbeMZUTQmYBpDZGFzGfY7RR6cWjRgIbipi77s9lRpypp5YCBEJL9K41u
 zRbjiA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxgbvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:36:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d94f086fedso2477795ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464193; x=1789068993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xFFM9Mzn6kzPq3OKw0lQ1wbgyP83Y7dhITvmKCJo0t0=;
 b=YVkyuowIsWPwil56tpc3/GBFzBaq7ZhlWXyb0+CmFhjvPxkBdBsk4umCiQWrNQakm0
 uDHz6A3GQ2jVw9LoujsXdJn0TRFf92ktQ4a1ybWHPd0J6znu7++Eq6nLXPccRN/g4qrd
 SxfMD7+LCMxEYQB9JFiAd0l43YowEyS4XCsdG3veup4/qck6uciT8rDjdsAt+AI6a7aQ
 hvA34/PQoXVkT0AM9Px1uWXxhEVGtL3wDN/EKXCqStVMGCeChMRsTC8qLfGdrTBzmd9v
 P6k5a0oUb4VuuwZ8Z/PwtcNv8BSq+jGkaB0hNiAgwq+nwoDRdDu7ESE5RZ1RDOhcHq6Q
 H7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464193; x=1789068993;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFFM9Mzn6kzPq3OKw0lQ1wbgyP83Y7dhITvmKCJo0t0=;
 b=qPoIUoTHPjyiwdeD5yr+QUiHXAuJHNH00SzI4WeraBMqUAWVEygUfyi4obPXRfjyJ9
 En0kpCZk+bkw8mbEdO8rf3+Zjnsm+GUXpfN+oe7El6DfKrVq/VgKpWVZnwukR+5e1nQS
 YbH1Jzz+PbK+drwQNhaGUa2eGdCoAgPWDJCU51kwUU3AkNBNQhHb0lieHs2a3QS0wYY7
 rkw4Grs5YBhM9hmy0eKkY+2RFIP6H1bbdkMj9srj9ECsO4E2RqEZJtQNz8JgPRAFi1Iv
 d6nC2rOxqWeR8RisWokc446tpOTU5Sj8NhLL3X8N2KozDO/23pXRSzUjAvpPwbGeaIvZ
 R5NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrthrqlnALaqjuwmQCRL5XpXZUXVY/PZWJo+jeHO68kQilG7k4HUYrXTfAqCb2bLCBAVROXKqzF/Ti@nongnu.org
X-Gm-Message-State: AFuF++nF3tRFVUv02gJtoZ770Va9BJl6hnUyZTv/NM/soWODc45uc8Vi
 mMxzUOR461sdFW0EJW4Ru37rURxXrQs7y2Ss8cuFWMTHJJQAfYVkME2Cx4Z/QPOM2FIc/wgas2j
 YrjLrukeUBJJyLLGirHh1rqbDBz62StDcFDEwm+qMwJgC6E4A6KNHPbswTA==
X-Gm-Gg: AYBFou3LSAusScYTVo7Bq3bYYxAKO1auxTkgsfT+sf3OFY0DVnylLxo3lfboAto23MD
 nJblyqxjsZ+TQ/Wv0lBG4ILM9kik6eD9QINDvgmc2MlY3AI/lGkjT+OkVnG1lxdZjWWWX/5DQqh
 YkPms+dda+Hxibz0yK1xCCNyjbn6MuNIw+XOiVPV3MatTIRXsE689HNqdex+Ynm44S3IWnPKwyt
 V2iErGlgn53/HT9TPGuN+fZg42LU6YZ/YljTVRlgsVEwfDpQx8kpau4mY+CCdXGNVvPGJzjltWk
 xdNck9nqJlX48+dL4m1xeKxKBV1hLGQ8lXlKvvQN44yLtRqDH9rtxXcIBYfbzyLFJdcUkNGUDLx
 fSf7mpuTVRrc3AHSsuOneiKJwvqJ6SlFgWnQQQs7aINhvyT9qJfWxFRDl4lHZru0l5gnX
X-Received: by 2002:a17:90b:2b8b:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-39b26272f0fmr1158578a91.15.1788464192964; 
 Thu, 03 Sep 2026 12:36:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8b:b0:398:c0ad:711c with SMTP id
 98e67ed59e1d1-39b26272f0fmr1158488a91.15.1788464192499; 
 Thu, 03 Sep 2026 12:36:32 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm1008717eec.22.2026.09.03.12.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:31 -0700 (PDT)
Message-ID: <c47f9ff0-5e93-40db-8318-396a10091181@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:36:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/hexagon: read BADVA as an alias of BADVA0/1
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T3ggd12FYZ3duDQUR2AmSQnudMJrjsN6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX8A1cHLH7Vwtg
 AUM8bvcThA/guss7PlnGu2EWxfayBcYcnadyUWw53JgC4qsKH/NjO/GxBHWbb/fe1UE0NCa0hd2
 Xh4FYVwLGoKrSIN9KwBqv21rDdWMJjo=
X-Proofpoint-GUID: T3ggd12FYZ3duDQUR2AmSQnudMJrjsN6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX6SvQLn1dsk5n
 O6RcXWJb5dpLLmhpZwW1HvC2UBwC2ETM807EPifBwzQJZI8ZBj/bPcilfOCBaeRRPFMXNbqlUJg
 6xR7yZWJzw0viZt6/nORVTV/Ej9vfLZuakE/mBKRXDZTyEcoce6wFdJkOpyh04Xvscx7A5eU0Bh
 rn/MdaSylt0DJGwWBgk82a+kMMHoqKURYMhOAaQK+LW0/aSTAb409qphlOV8Z0Oo/rqAV159434
 WoET98zRtfEusnRT8F4MrUxvlgp0tvoM3ZhlHVVbLj4F3IBML6d6rLe0Fq7yMkPZh0zUWDZMT6f
 PSpITkRZB+nfPPbtaJdQFPUV/Eo62pYmXgzOzbEdtsnfpkl2AJxKhVD/zSUMltW2uIkcHNLIkES
 K6b1x+kA9UDoo7OCgdj9QEwXrQBboLWjefS1UHUVcc/nh9ere/ujNTgqvP3D4Ta9C4OLVv/Qlv3
 OmGRMzk25CwPTuPGTbw==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99cc41 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=d8xkAdPZd3D54Ali3CMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
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
> BADVA is sort of a virtual register: it reads back as either BADVA0
> or BADVA1, selected by SSR[BVS].  sreg_read() instead returned the
> separate copy that set_badva_regs() stores in t_sreg[HEX_SREG_BADVA].
> 
> Guest code that writes BADVA0/BADVA1 directly was reading back a stale BADVA.
> 
> Uncovered by the h2 hypervisor kernel/mem/tlbmiss test.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

