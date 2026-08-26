Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A528C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzN7H-0005EZ-7q; Wed, 26 Aug 2026 19:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzN7D-0005EH-38
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:33:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzN79-0000w7-Dn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:33:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdKMR1483396
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 23:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DdVxad6UyPL4ArhJ3DPNHSvMMAQBBbSixyEVjNtOmS4=; b=fZeuC1oQSyqyMpMz
 DLgUgTgcI8rkDhCEH+A8BRCBoMZ4XN6N9aKpfpoZSF7OYaHKi+pfRcKS1v2ZvjeK
 e7qfxScWjreidJLn2Anm04UMzdZjKjRHCW57JnjGopAuFCe9l+vi1w0Wi+hd4CkQ
 pH+PO6gtTr1ITCTRkXVZoHIwHMeTRXnZD3MpEkNVY12d9EMNwIbVguIRdphesddg
 l7gALK9Ied2WukRyd+Q8EnVKVLWE7RUJq42uzTpvJYvxg4DlbDM86KxQkmrOg5id
 t0jOVU9Nyi0KgXYGIpuCRkvlkyki5X91+gxMM9M1cefoa+7+Gv+SdAVkpdeMFt/j
 Zs0m4w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6etrmwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 23:33:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so146742a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787787181; x=1788391981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DdVxad6UyPL4ArhJ3DPNHSvMMAQBBbSixyEVjNtOmS4=;
 b=ItxeGjcnDLlJfNwjV2qgettmTAOCj4w7PrtH1CrT/nXMgTPdzZ27pPIw433H0ZDO9+
 8FGXk4TrzCdrpryOWkSicLiClRzkjA1WCYdibTalxr6b8qGb8MybawVpEmjmPfLoK4sP
 c27eJ9UgGojN6KWEXirxM6FjZ4MUyNmSd0urk4GQEPtFbOCfTkQ24i6LBS/qC3qmsOfC
 HujWyxCu5C8YQh5pHuqJNi6EXjjByhW069EALzLWxm19cysi0BAZkCSSFPjXmev9xFTy
 NrIXGmaGLIvVm+k5N2wb69jEPFR4jagEOl6sUo0nbouJXPDg/BH9jRDotZ9q65TXwZb5
 DEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787787181; x=1788391981;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DdVxad6UyPL4ArhJ3DPNHSvMMAQBBbSixyEVjNtOmS4=;
 b=bzb1WogegTsNX0pNHp+ubr2Wk20zuQ1EJylN/jSTs+GVq8KYTDJYPm0e9FvoQNu04l
 BNxQZWRgN2U9Hbp0OYyHquwvpo1Iiuicro2xBIsBCR0bbzg3xtUjfK1OK5lpYokplyJv
 v19U00drouT6q5KYuhHepb1mnUL7dPpAqjsfKqd8NtDSIqbnexWpjpaP0Pn5MlhPqyxp
 7chTjkG8a4Z5vDAwH0Kxm+tPMEAPc8e5Hv+OqmAqPwuIlYUQDYYQSnlxbg+K4DMxK23c
 Oxlir7EM5pmOuSE+g+MKl8yUQQP27Vq1+JbxlD8/u3I4Z4RIa4KrQRY0hnaHjLuBWupA
 H+Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3+qNRPvQ/ZNfIZsk7t5xUxk7glzU4DedqN88l0jx+Qzv/JZMBE6ThQUwU5gFRafrrHc6djm9u1eAr@nongnu.org
X-Gm-Message-State: AFuF++mUYUmsw5qlJHPR7aH8Fzo47pKIMI/qak93UpK2/pbJ2BF7ZE0L
 9H1ipxin53/fx4jRXNbP7rHRPI47XwsBqinT4ny5j/R7mx3L6Kmmf49QOiIdiNkA7UWLNYzWG3g
 AoI6Xt+LZ5kk8VVPaL/pdbtOPggiMFEjZZyjLcoqOIJvloKux8+9umAumNA==
X-Gm-Gg: AR+sD13+Dwv/Sfkut0MBvm2m+291ejPQem3jgoXEd5lqxDbXhEZWRyOKX5EXi0ugrtg
 J0lZWhYIjh4K4943u8zO+p6IOdSzaR3f6VHjaboCt4+6lSBEEk5/MaKXlitUnvMow44njncUIP/
 ySzbOzorYFJxXpp2WL67ZsvIQLofQ+jcv+JscBUFdFLBN4z+FuckelXttrg9GzXh42DRCl8hkWI
 VMBhswZSBbhHu3lxRS3QlJz2xn+/teEVxX+rRxIfmc51bY/So+VYqyeFgqSeQKwSc3mtcDmAkOR
 DByv3suPTS6sNvJRDVB+5TQD4AsSBRvk+KlTJk0306gyzIXNBv1hPjxVK9naG7nolfTwMTDDNE1
 bgaXJFzFupDEW2jjJueFBA8JYcnUmt+jCLVH1CYAiUStGxO2mDPwJmIdKjM8I8DzFjk8v
X-Received: by 2002:a17:90b:4b04:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3966d461cbbmr20288437a91.16.1787787180841; 
 Wed, 26 Aug 2026 16:33:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4b04:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-3966d461cbbmr20288382a91.16.1787787180456; 
 Wed, 26 Aug 2026 16:33:00 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8f20095sm11234598c88.6.2026.08.26.16.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 16:33:00 -0700 (PDT)
Message-ID: <3f11dc89-35c8-405f-b3b3-3b2e38ede2e4@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 16:32:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/cpu-models-x86: Remove a Texinfo leftover
To: Borislav Petkov <bp@kernel.org>, qemu-devel@nongnu.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260826205417.2062172-1-bp@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826205417.2062172-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a8f77ad cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8
 a=D6C-LRx8RRtA2orPdRwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: VbAjKpPnYJ8BvFnhIwlFuwvNoLFvbsWh
X-Proofpoint-GUID: VbAjKpPnYJ8BvFnhIwlFuwvNoLFvbsWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5OCBTYWx0ZWRfX+rEnRVSq0dZW
 TZlw2i2afu/DOTHCVki4IvJHEbUGXJFuySnDFpT6atwgNeIhHnzANjRMlsnRx07UNPHfZbHfgdJ
 GLao3nJ+B0qp2DMgMkGX0vz6M0CxJ1X/TaKbrGOlDEg4nQ4nVSKDgNsiBmXO+4s+/2VOCpTcp4g
 YNYqqNa7sztzKNAPVXaxB/kBUVx3gXQVsBoUj3UNoYH6UVhMSt1SG83qsDcfzDxjroWtcyrSmml
 OIAbWmE47jbvPW7WpBxM3QwxapUHwHolO6sZbExu6V3c/e0HcgHlDfQIVCNRlQTypI16tc5wSn2
 PpfKdrNebzN2n43N2lKppRe5lmRNAd4iqzYkdgXI808dBrFSzAhhBVm6DRTkzHNOOxWKubKRKN2
 05S1tqUuQWesoHPLVoY1+U5+/+RbwbMs0v6cbw7qIHbr+L8LrgpNojSQ7R2rD+VoaUrvwsGxGo4
 fPscz+f8GKtfeAHEPTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5OCBTYWx0ZWRfXwvEBSBaUbHXR
 bplfa2Rqk8AWkHq3VsTOghY76s8KMJ/3yNI3VZd5ClrnJnf42BVAMHpiLtsQppvRh99ZfwLZNsW
 +RKXxGQYhpqGjKyLGO8A4IF9w/+9MVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260198
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

On 8/26/2026 1:54 PM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Commit
> 
>   1bf84a1e2e8f ("docs/system: Convert qemu-cpu-models.texi to rST")
> 
> converted docs to rST but left an "@end table" which shows in normal
> text.
> 
> Zap it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  docs/system/cpu-models-x86.rst.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll let Paolo or Richard pull this through x86 subsystem.

Regards,
Pierrick

