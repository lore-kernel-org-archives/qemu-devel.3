Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fek+PUh2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ON6fuNVg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFLM-0000C7-Bq; Tue, 20 Oct 2026 15:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFLG-00008q-Nk
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:17:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFLF-0007An-7k
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:17:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7kln3499167
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ly5KeuWedWP8VKVZpHHW4TTyHz/8QuIqqjJA/gUp26E=; b=fek+PUh2ucVNavJ5
 c1ihzsD6s25fEe5CqoPalNzrl60CwmiOYgEKTQYO+UET2odNg62+X5sPEBDwPm4O
 3NPr6p1pi4570wdIjD9bTBn3Ppg32MfttBw08DXfQZkjmVe1uOqPWpavh++AS+8+
 kaalI/1lD7sItCUd4XCKcNketxg/BgEvaj3I1qHf5K2iAyoO2mPz94rJJDEIdpvJ
 VGja7/BzPxWIjwy1RHZq7GyWle08OhFo1uoVm8oKdFzvcDzYwuzeZ8WPm2nIK5mb
 1HWvVRk0TYpFmJ56oDz0hGidOe0PUajlpyMgE/uG8I1C3RvzCkrYBjHoBg19J5vQ
 DJ6NgA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg8aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:17:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso5522807eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523863; x=1793128663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ly5KeuWedWP8VKVZpHHW4TTyHz/8QuIqqjJA/gUp26E=;
 b=ON6fuNVgjLpxAbozSpeQ3mlkvA/fAg5cqAzcJxnWEZkOOR2NeONrWJWKJNQG8+gFqY
 dvzFD+z6f+IOO/pUvJkF6HVf4z2MX5qRgKfjds56IWtRa5hmXVZJGwgG+nOtsbbKaOOj
 GjWIsmXtlGFe5zODn5x+L1L7uQkRMifjtNZU51t+FK5m5AJ36AmBfTJR5ER+iD93ILd9
 6GrD/KdEEpIK9ECkWVKdXv1uDQ9jybLQ0Fyg6Kl7Uc+WypZel6L8Q46SLwYvNMCUOYhl
 y32f0QYYM1sboScEIwwiRFpCr0yf609WGCR4bxvfg/clsq4yQDKDDOaSvbj9Q5WWEzfp
 QcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523863; x=1793128663;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ly5KeuWedWP8VKVZpHHW4TTyHz/8QuIqqjJA/gUp26E=;
 b=ubmPbsxe0zOTkBRX6SJNI4GKG8iwXliRt9s4qywf2tBlpWLv1JCGWKtGfafTDnsxGG
 bTzdmxJA9iXlqIcdk3tu2OywVoUl3E/KF0VQEi3trnUHK7Qu7DPBqSqcsDVmce/FOmrK
 GDHOTf0pisAQGD9pQmqQIH73MXcxy09T1toM+fNCxVVZ7Ac6OgtCYM3Qm2kgGzR4KJIx
 P653wjmvBLKpXKC+9phX9uL6SxaUKX0363GHHu70ERLci9bP7peF96hY06aY7VZtwfuy
 WFG7hgdjcrxmz08+s4YADjxM9jXpmV7ugq5CrRpuWZdHpbqvHhe2uiaRoUNseLrvC8Z+
 QGNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQzx0sHyb4Njm4P0a1Et+mcRzIBrjCJOKm1QOfi1L/eue9RGdM8LJrF6bnkz/lp/mAfRIelEpxfrHm@nongnu.org
X-Gm-Message-State: AFq9FYKzrfkTlSNFGJ4Juts4Sd44lGyWVpRDn4NTKfMPfI4QtqxZ5Xsl
 /qMsImEkJj64rmaEYmW6xAGo42c6y6Uxck7eu+QlMjO6mNQapUhzwgudZ+ikoBEIJsbSdxf/zCW
 Hc8dzaruDLhnUH97zE1rnBBkHwvr27+MrooJeNv3h95ZkIiSStMSIt1JKhQ==
X-Gm-Gg: AYBFou1znViluuCXr0cL105B4I4I+QNWj0/32xB4c6dFO9ElipN/78MvHMIMNC9CB5c
 qB4eWevYKde0ZFhu8KESDCLKb1PAwbDrN7uVXxyauOcMcHtGGhTLQG0ac2qyIXte2Y1oeQXqRwR
 zeXKnLP58pmJOlrAJ9xwOCVNZxDP36Zz6/1LgmCftdgIVaM8Sc0F17r+QvGnqGEEpAF1H4AX9kB
 iB5gaI46Y8ugCFyP6M7ogIPJdxZ7CFSGe6dYS5pQV6oCpk8z7KxxZqgX8uhg2BzC6y3PAwDXxAA
 bmbu8G0PJQE57uTA0QmkMnbuQDr3fMuCFL+rb/QFiap6cUYFdaQpJcZ5/JGQUVB9+ElKejN3Onh
 9ZJqW7nhV6frKrkmQRiDpQ87PlGWbpy69ShYS9xSC99mzozKN462RbwemzQuG6EONC7jSzA==
X-Received: by 2002:a05:693c:895a:10b0:360:e2e6:f849 with SMTP id
 5a478bee46e88-3674e745a20mr223729eec.28.1792523862816; 
 Tue, 20 Oct 2026 12:17:42 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:360:e2e6:f849 with SMTP id
 5a478bee46e88-3674e745a20mr223706eec.28.1792523862245; 
 Tue, 20 Oct 2026 12:17:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm612463eec.10.2026.10.20.12.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:17:41 -0700 (PDT)
Message-ID: <97202b95-e4ca-49ba-9151-c2c5dbbee96b@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:17:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/27] target/tricore: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-27-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-27-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX8PdN+hoermZ5
 eINuaLAfIWsfmhDvMGTl8OT6YnxKYMhO2UwvxVFWhbzEd440yGZlDBoc3jLjk33gXe8SIq8RAsl
 VPenf9SY8TsklGaL6Zx5rPmTZ1/Mtiw=
X-Proofpoint-ORIG-GUID: g5FI1ITtV4QfRBQ30cf9w2GwwccIQC53
X-Proofpoint-GUID: g5FI1ITtV4QfRBQ30cf9w2GwwccIQC53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX+eHpcgxJMhTT
 HwoC4wnGhKKzgmH7JAlNnI7oIjaCE292aUeVxRDtb1hwoe1aw6QvyLDITLBBtsUpQ9vl10DTgXf
 riLzN8CadDw3mVlGiOAOr+EGqFmCRp2bvOj2xiI1tT0hzHAZmACyM3daXQcRfF35A2VxpEi2ABl
 Aefgl3YPKz03b3RAz+d3yIIaOIZWX09XabjwCugyfxgP5CDCktTbYjcDjV/nxHsEmvWIPrwtW5O
 L8VAjOpYsnmYIBhsy/fBNINpM2z2bHgwyldNxthL/fPcZkLsMLqYuYZzMATZLQO23H52KWriU9G
 DRjpYgCu74O5bBc1nNorEKjosKJL+QI/MjtBGjxoqv1BoIBvZnNaPcWdXGM74R2ylPI8WRccPiz
 MW1Ogocch2ATrljDKX47bYBxLWfAZtmSktdLQACwzczuDUbBzbRP/LroP5gt+mItDwceuFA2t6H
 tMrayouRKajug12me7Q==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7be57 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wTf5QXz2J4iYi77Dx3UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> Implement tricore_trap_name() and register it as the
> CPUClass::exception_name() handler, so the common exception
> logging can resolve TriCore trop numbers to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/tricore/cpu.h |  2 ++
>  target/tricore/cpu.c | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

