Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA61606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SFAxzjmm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ghjpvdwu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPPg-0005BX-2u; Fri, 23 Oct 2026 20:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPPb-00058p-St
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:15:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPPa-00026r-6T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:15:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLuqnu877068
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4bpI9jhAGric8ZMG4AHlEYOvbBfeuU1k4Dbs7r3HLgs=; b=SFAxzjmmRK5GYvj9
 kZjb+ib0Ps+SabMBLH1AJNp/Tk0LaIQT2Y7glqdF2gnMYxI3yZzZilXcLc2LItGS
 dDGC+M5xXFmtKyLYusbLwPJ8sigKuLzkGgc8WnmWymh38SEyO6ehNN9kLiSAWELe
 xykcKGE7dF1lpwXONEGVP7bcu/li8nzkQBTh3o1Xs6RqlWv2PYRYX9Ks5YXuYqVh
 wWrbXYL0PzyWc0okE1KnbvcnDFmh3Cw8h7vIa3Rub1EgDqojw56Wo9ycBHQuUINc
 gEDleYNYVwlW31pNlzqzibm/5o2d/riwXeugCvshzaDgbwtbXq8DRD2c2stuLz+s
 r1dwtg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr69031-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:14:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso3148492c88.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792800898; x=1793405698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4bpI9jhAGric8ZMG4AHlEYOvbBfeuU1k4Dbs7r3HLgs=;
 b=Ghjpvdwu4/u0IFQf3extcRoussgm4QyZqObReo7nFNiysLf9Lzzs/z8eKaLqUOGbSk
 bxyyuPS6tVtkAAjpOnu5Z1efr+52eULCmxuHtp6gH6ww6KgkykdNRMqOO5pa2jcqYJwo
 dsoggHtBCBMlEtyRrNVflEruXoUxUodPUtlzPtXxMlWRmGfPQKU6tj5mLDHgXenkaa9D
 tgRByAbhMLJMJl5Chf+i7wS8Eeb4LZK3YYKTXPOv5WM6GB4Hgy3dFA9ZVb/wW5I7qUpd
 /TrbcjwCHNKGkm+2tt4hRtT6zVP4vOAJ3UP+1WtCnp/OS6BpC8gEyBx0gBtBZP20NLNs
 tRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800898; x=1793405698;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4bpI9jhAGric8ZMG4AHlEYOvbBfeuU1k4Dbs7r3HLgs=;
 b=JbYv0Bjgc/2JSNGMg07wyogM4jFN0uNZTptEiRj2Hy3jrGu6CJan6MbvBr+lOtMm1Q
 lwBzd2xKbhVqcpur0ynUpB2Ijumdfz0DpcYw75XsZwd2c2oH33mJeVafjGuOiIKdiHJQ
 L7CfD5lbEEtkJfwA+sZ6NV/9BGzWaJVz1EmMIm5xeUArCt3VY7NjKVNiNBn1EVfiR6dN
 oBitMuLS/d8pnpLY7j+waUCgvXqpKgTgB7AWWJiV3xfN5oAI7mrDViUJhhy0+U3kIt0l
 7km3hGAKfstX3bfPHfJCggypqBT4UEdOamQx2cd3wq5cwxNmMp3/ClRANasaoCAn9SeS
 6apw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwek297SZWEnF6xI2BeI/920FCSn2qWqsXa340xFbDvL1wFlbfwPp/Cox4e9ULPuPYLmvLmS64EXJbn@nongnu.org
X-Gm-Message-State: AFq9FYJ0yHfSb09N5rRckP6te/YIEx9zNdj9tcUL1wLEk2LCLmzZ4+JZ
 wgwyc6y2xWbjHRGZWGadu8Yk7kWZqLVQwawJvVzGZhA8No1Ju4dKN3jvxLj+pdc9t0akuZqroRK
 jS7Z4S6xWn8sNjvcBRItRokzTd2RD6/Cjq+igGYqgG6ahdj0+RXVEyVuq4w==
X-Gm-Gg: AYBFou2r0LMdH/k0SdEvlsM+TrfapthTkQGe+O3675V8FVK1lnK0A9MZPv9XaQPpAjn
 7H4DdmecuCpOg6wBovZqWm3j4bg00InP3Q+qPvFoha2bo7xSee8umB7oHttHKaBZZfalcWHkejF
 kkpL1AAOwMH+L4YpxLW0PhexsigFtHPcjonALHFDLkwDkRKr4KTW47RmT85F2oPC4hKgGWwOJLp
 cQsZIIee8AkR/4eny17XTP9aZ6kwKMoUaSsgokNpIcY/FBbLuSkd/QShgofCqcZTgG9SFIpSSUb
 lCidEXuGBDA2WgqRkQzTDjCq0Y9ItUgvMY+ukbQ1WLd3P0R0qayKVL3Uq8bZteTmWa3bkgHVBh6
 XRbskR+b5WzflzW05JBsXvyzpK/mO+4vhSVz//P4xcLjUZ1k2VWwZdQPwkASTAWAg0CFmOQ==
X-Received: by 2002:a05:701b:4302:b0:185:6b47:dcf with SMTP id
 a92af1059eb24-19936b55d45mr809984c88.36.1792800898262; 
 Fri, 23 Oct 2026 17:14:58 -0700 (PDT)
X-Received: by 2002:a05:701b:4302:b0:185:6b47:dcf with SMTP id
 a92af1059eb24-19936b55d45mr809962c88.36.1792800897765; 
 Fri, 23 Oct 2026 17:14:57 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2e32479sm1585117c88.21.2026.10.23.17.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:14:56 -0700 (PDT)
Message-ID: <c7401c85-2495-41f3-9645-787f74568289@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:14:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/hexagon: add v79 HVX vcvt2 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
References: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
 <20261023225820.330905-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023225820.330905-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbf883 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=x2WwW-MCBrOZlcoFpM8A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX6i6jrOA179La
 NqXQ5AZoOD6JEXUy7Gf3sGQX77z9G8sOnL2iOEiRb4BZLf/aDBSp5iZXbLAumfYwvESq18jSPhM
 QT34BRgbupv4KeIRkU/6pMxmQEKSOL95x2VMUY/UExm0lZStOmcldmN4qSQwEquF8Esx5AUk2iQ
 EBHQh0uZ8WAenEvn79yWxzYJz8cUbxtVfyN0aYWVDM1YtDlyB7khbf7LNzS10qWPiCm9emxPdvT
 Echirlc595enCHz22NkPyJov6d7e76DfAxl5z8Kn9GapCzrK3yKRj9kRPk+dPWP3zWFLNJxlnWc
 /iBx0xnr+8jFIwxLsniJqDHqCwFj1++QdY1Vsz8/0zqtX4tBIRQQjCRaP8RwUgizq/AOsCPKPYa
 7UEQovSdkpg78MtCpFIMj313xJR6PwaEfIVilZYpCyqCR+WxVYdgTHz1nMHhPsf7ceFSgqazaJo
 LroY9/Uc4u2Cl9ncFEw==
X-Proofpoint-ORIG-GUID: rEXU4r3uvX151-mL6duV_KjBW4YU_yd5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwMCBTYWx0ZWRfX54ygIc4JUYfY
 3EJALcmOE4ZCWRp1NNswvwVHdgCKoUVmO1X4wJn1jYm+oK0rcsZ9cqLGaQF11VGgCLdD3tg6/m8
 T3R2NSordYCCdykQPp1vvYgxwTZP44Q=
X-Proofpoint-GUID: rEXU4r3uvX151-mL6duV_KjBW4YU_yd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240000
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

On 10/23/2026 3:58 PM, Brian Cain wrote:
> Add V6_vcvt2_{hf_ub,hf_b,ub_hf,b_hf}, which differ from vcvt only in
> element interleaving.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/tag_rev_info.c.inc            |  4 +++
>  target/hexagon/imported/mmvec/encode_ext.def |  4 +++
>  target/hexagon/imported/mmvec/ext.idef       | 33 ++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

