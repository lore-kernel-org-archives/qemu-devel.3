Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oxqFIEyN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z+9XAFhF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZ52-0000PL-DO; Wed, 21 Oct 2026 12:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4h-0000Fu-BA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:22:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ4e-0005A0-UJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:21:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTwvC1481033
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BFo5u5dI2ZgpTXHJTIMc7kimkbbwk6iHSZv+Ud8VMBM=; b=oxqFIEyNMYTeG3F4
 PIW0nI0lNqFz89M08uVQMPYvxPyTfrXvCQyov8BcZVK5BFV0W2QVtS3AOqx97cZe
 xNYwRPBYv6Vt4DiQuOJh2w1Vj4Q7EsbidzDCZN55/hfy1x61JBxGYniY6gUJd0G/
 00bzBX6YO85UDFJqWh0AY3e7isjYUln+XGXlBlB1+zPGbJlH6klYcuU1Zr2DpgOj
 eZyzCcWFbclxV+VxGe8t3q+T/KGUW9hVlpmR59+23L7A+fdE3kN0SeNMfhNTr1o1
 4+2pQhmhDTRSaCqf/949vE/4Cmm/vxKe+g7kt1o+k43K3uMthjlczJ30Va2nSAlY
 hrTCOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs045se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:21:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1554263eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599713; x=1793204513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BFo5u5dI2ZgpTXHJTIMc7kimkbbwk6iHSZv+Ud8VMBM=;
 b=Z+9XAFhFNFchjv4+ZyH6YMckfb8LKdDw5g5sqfFGP1dbH7D7ei2pWHkQMZ/aLwfZTe
 FAEwmXBN0pxyP0g067Q+ySjGoQv4AltJcRnvJ3dZXj22DAqNNtkFfnWWxUpgA8dnDOyx
 53hCtQQhMOJqfzCKQG9Gj9I8SkGltw6aVuAqohH57N8Boyp4j+Kv0uEmR1EDc/f4dGsw
 5blJSOVBlsj0vFWYfL/GOkKyyYF4Vd6NQ6WUw0DColcJ3Y4B6V5nnH4Z0Kk2F6RuJACm
 cPpxNFcv7/4/09RZnDQ9DfIujIwj/WthV/UYYcrGqnVxa7sdAiry427UcPGtHNNNx2K/
 ypUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599713; x=1793204513;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BFo5u5dI2ZgpTXHJTIMc7kimkbbwk6iHSZv+Ud8VMBM=;
 b=YNwLZ+/HTFIruyvqIsF2Pt+WQS49XCdekh12ekaU0CTVvhCjk5RboJoxCxxxz+o2Bf
 Ow7+wSsQDUflNUyxBaPoOHti1lZsyEpdhA+L7Yt1z5tYh7RUARvSBdD/1j4iIF0p1Gjw
 9IOEA4SZ/HccNh+M59Ivfjj/7MSqdvvmYgfSdjAJkQymHnrJ27k5nq0yL3yCSORFwVyz
 sEpPrEYbWwekx6VIQ1+/4ayt2iwlO99CFoM3kvGgzeCEebcYLHAEflulwyhxunzP6kOW
 Woc6tZUh2XRuLQ8kOs/hAqwWLgT22wlebl5bvmMRJYShomjmQJClkeU1eg7BXflgwhea
 Q4jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl9zYYKscVX/oXnljQwqWBI5LGK2XXqUH8ZDPQXfniXdGheEWASfXorPinxc9k52iYwBySFlaS8i8m@nongnu.org
X-Gm-Message-State: AFq9FYKXA7JDisAejpBDhb+IibtsYQcwcifZR0nyRfw/U7z/KPxMOctn
 8B9D/sa4WDu0gNm8ZC8hIet6LHSsMrJ+MSuWGF3uUbaarCjVbB6e9+ZGbwuxYX1l6x0xavve7dx
 VK4F1UlNDI2sn0vdjqwkGiwOXBTgUknNy/5ZFIHPGfFVUVo5dfryP8KQRSg==
X-Gm-Gg: AYBFou0ILnYNEySMbYuyClx+5lJDC/9JLwmL2JwXuniNptWwbeQVIALwdsjVQs9jyLw
 fuNe6pL1TuBDMGRp2JKQ9parKp8uYbZMH9gnclqIOXACw4nS01R0Ixg5oG3F39etlek9LQx5XTX
 liBPCPMKWx/zR7Sxqj7HrLYtN5PiIa37CxyRMERCzGwXdtMjK9cEal40RH97DL3iVknz4uhCRTZ
 eiUy9Y75qQ9RiYxmSmmiIwtilLliNCTpyIZOZ6zGcPr2ycLsTsJaB9Lr7eT2sOlhMitUVx4b8af
 betRpLO8Sji8rRGCSdi9w2pPeLyJhdP6QwVW0BGte5gqPA5ppnzU7W7Ja6XRMcAjYCCojXmIzyr
 O1WmKgptiHS9+N86P6ZCxvNA4NpKldWyhoxFG9PWMFgdA9leY/mU9mUnYpKUI23lLZ1OzTQ==
X-Received: by 2002:a05:7022:ebcb:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-190a437d58emr3623027c88.16.1792599712518; 
 Wed, 21 Oct 2026 09:21:52 -0700 (PDT)
X-Received: by 2002:a05:7022:ebcb:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-190a437d58emr3622994c88.16.1792599711888; 
 Wed, 21 Oct 2026 09:21:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926035sm6622401c88.1.2026.10.21.09.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:21:51 -0700 (PDT)
Message-ID: <c68d8793-3dd4-4be8-b398-19b18baffcdc@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:21:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/33] target/ppc: Use a static table in
 powerpc_excp_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-22-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-22-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8e6a2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RrPE3oRBrgevXTNA9bAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX69OJfoNMZb0w
 t8nSENKpYrcD+ZPm7p/zzEBvS/aVWG6EGharGIR0czK2nxJPbqQYxJKl0sC+zK1uEDm09n7tXoW
 eohEErilKWS2fLMDVUEEucYPuYp9N6BqbPSk1/cNTVjhaPDKnJKfdMZV/uKsYWkqm5RNIvYK+Sj
 OOV0BgBXRzAZhzqWjJQbZo4r86cMPM5O1gDnQGeeDTtJbl/Bf052N7w4jV7dJxVzjLxfZqsDQeN
 jA81QPW0fx3G7fbVPDTMPfYHWFT/d89v5yN5S66mFiRdhHY6mGIcmieceC2C6Jp1zn7rbuTDLaa
 QAFzHaT99kldNV8bEKhv82EOn0k9aG/U3ryRGVFyRj+YDZ/fsPIw66mr/NryFPW5WhqTyrnbj0x
 v+IAV/0vXT8Mh3kR6ORmCJwogJNInRTC/0bKAVyo7SgC96BxZWmsHoZGZAcCuk6XPc1U6L6M+1k
 1D9w2cubiehzeCqoqnA==
X-Proofpoint-ORIG-GUID: K4UJpCd74KaMpo-wYLtrxE96sK9_v3zg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX68WpVTIF3Vcz
 PH/lrJZAKTBg89ACYghhLLDEcDKXDaxwfjbGqtNzljAHRPL+NEkwULhO7qe8WDQY3XpZuqjxwFQ
 Uxuuts38+oS01cniQ+tzsMP68pJ6KyQ=
X-Proofpoint-GUID: K4UJpCd74KaMpo-wYLtrxE96sK9_v3zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:13 PM, Philippe Mathieu-Daudé wrote:
> Replace the switch statement with a static lookup table.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/excp_helper.c | 136 +++++++++++++++++++--------------------
>  1 file changed, 68 insertions(+), 68 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

