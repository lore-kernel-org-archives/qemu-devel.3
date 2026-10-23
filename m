Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D8606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J/RpV1Ah;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CiqjmkBk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFOM-0004km-1D; Fri, 23 Oct 2026 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKFOK-0004kX-J1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:33:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKFOI-0002Cc-Hy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:33:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAYhS2965961
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 13QTDyQHtjRCuPBX2ygpwPMh/nqi4lYwVYmuRiDTsCM=; b=J/RpV1Ahy81qB5jX
 kY4/T0EeyTl20LN6exh0A7qMIZ8ypF4jcJrywSexZ30g1DAld5Jf0Qa3wzh+NVjm
 2NTwvSMDn+NwiQ86v2asMsl1JYizZo+eH+VYT2Ly5P/jRf8FBQud6Qx1wOhaGx9D
 Tajtz6XFoShfv1PLBl6Mq6cWin5oEknqQ/uxmlz/1XLYiWYS11nHy7Xb1AXHUl8B
 DEw22mR3QBYwERhKPaQqYpR6B1BdZBY5SqD8V5Vy5bHY170pBbv8Y3KB+wZpTOHp
 O3Rf5my7sWLFnfTPXf25lzPgvaKgT7NQSvcqn2k8UTCNA2+eQ4psOYuj08k3jbdt
 nW06mg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0mcub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:32:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53639e47be2so17438811cf.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792762372; x=1793367172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=13QTDyQHtjRCuPBX2ygpwPMh/nqi4lYwVYmuRiDTsCM=;
 b=CiqjmkBkGV3Im3mKux8fNybDxVXBWPoAItB8nSWvgKdcruFFULiEjj35V5ge9V/ZOs
 R1wNj4bulhwrtXon64I0dgVQlg7RGXlKngYrFgMACqcKOUWuuNa38OKsLpSbDYChJXl+
 DHbVHQqAVSqsYxyYmpJZt7LmFXX7sdQb67deGu6lMkiJs/fZRLPDoSoOCK/yhcfs1MwZ
 dnuXN2eEBd3j76LgAs2EY/vNRlXMMguSWTsHSu/JiTwvpKpTUWl8NeVRephwgjcZlXwr
 Njbku2cgvwRYwdz+MQfI5XM2LWHbLNjTLQKmCV8yUacSE/Z+cdP0YAXgNwK6MlrG6t7h
 89UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762372; x=1793367172;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13QTDyQHtjRCuPBX2ygpwPMh/nqi4lYwVYmuRiDTsCM=;
 b=AnStcguCCHMRNhL0+cfh0Q4tEZxwc/jMhlfp2eX721iGESyM59kK5EBLPW1y9X8Dc4
 7KLbLyZ0YLi7c6jOGLqBpBP0vM0rRaFdcxUaPED5S4aTPzuXN/tohx0M9u2gUJy8NQvF
 k5I+E4r0AlJEFF5vcnak1mJM5cOHqYL/baH/ngk/SOnAhpuGBJEeXM0Bi1pxSMPG2Zz3
 1SAu8pDgXQfZFAgCuKlkTu7Nqw8GddibNQhO6T1+SbGwD/4mE+L9YZje+GrKT7KiVk1x
 0XmQUd6gUpk5xSmqV1RF2e8xNIdRFy4+L0SL7nIZR/+lJkFSZ3lH7Y04I/D6Ws1rVhtX
 +jfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxww/YJ57DbKRv4we2HMaKw29AKf/b2Nx7q13/yKzZjczT0+UCKMeBvDT698daV9gSI4uasvXMxgTAb@nongnu.org
X-Gm-Message-State: AFq9FYKBa2SbIhPgGdvOV4qxGzUFn26UyECdb9jd7zf+bqOO1gPJje05
 8QJgIp4kOCIerbTREmxkwzv80JyN4zg4CByvgoKjI6QZso8Mie5SQ88djjhIqZh+K3qeHoomUW1
 YQcn9sEOJdVGSmW38PFExu6j/hA+0ebWXraqwO+m06lvbhLd45GXX4MEinA==
X-Gm-Gg: AYBFou2Rk0Q3OhnhpRPlhylskk7inceLp+eNYsCxyJrqoCFtREZ2PMRQM1RdHzTTvUz
 k6OMdGKZUUF846j7jg8zv7Z7RQHvzT2d2VBK+9g+6s9xxXl4BGVHUYQcWOpTKiiF7vFtzonOgb1
 Y68r+dDsNkGjAjDyzkr7dv8mvd9LMuqAChHCwjwBGFBxsZK2H/BA+MawMM9WBV9DJ6zTzi9doFq
 +jwyAVSDPWA3UOR29r4O18J+kajDmWfUIfvFqAnIDJEP3x50BOI1CN8XakQbPElx6rUlL9rgYhi
 e905iX0NcnDrwNxA32tKUahzb+GxvlxxsI666/ZpOEaFhFKI6rN872DP+80mwq4Xi0qLJmf0vUb
 sKs5N0Pl+omb6c0PUXTdEbrUhjxCOKElgSadyuMgzLrCVi79mNE2hd900MKXcyQZf
X-Received: by 2002:a05:622a:c86:b0:536:5c86:cfd8 with SMTP id
 d75a77b69052e-536c27cf44emr27423611cf.12.1792762372167; 
 Fri, 23 Oct 2026 06:32:52 -0700 (PDT)
X-Received: by 2002:a05:622a:c86:b0:536:5c86:cfd8 with SMTP id
 d75a77b69052e-536c27cf44emr27423181cf.12.1792762371727; 
 Fri, 23 Oct 2026 06:32:51 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm1610416d6.27.2026.10.23.06.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 06:32:51 -0700 (PDT)
Message-ID: <c3f1b28a-7538-4c38-aaab-554ce5ab778f@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 08:32:50 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/hex-l2vic: avoid shift into sign bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261023084624.1063258-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261023084624.1063258-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hFxHqlWf8l7QanlIu3dq9gG-Xpbcoe5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MiBTYWx0ZWRfX8d/+HPgqJZME
 RGs/d795a7vfT9w8BX1HR/d7abFv5xUlN/kg/R+VjQXhwzxr4V0heMVtO/YGrwYTnqB0q+5XlIh
 iFb8wdjrzoedqCX/o3tt+tZIyEGnNSTXmBHXmU58h3fMeT87yTS0DoPHPSbv9/ODDpdWY8H53ED
 8AddPKE8OsOwUp6M99EN6dGr5Ue+weLPs+3e1YQJv2QXOp8gM8HTmWLLhhwNJFjmxsk5g8QGUmI
 ODD+Lp5Yq3kDyYc5Cn/qDaAjpivU8B+f2hHlqJusdJeK4YdSOIJbjTHwo3zt8ndc1/tDzCLukuf
 qNmE09ACP93GvjHWZHyD2F/8rqU5TyZIXDXNgC5kWI+W6/4prdSYpHaI3WgCQJthirHIxlBb3LO
 84YKggkd+V4X9TfJ0LWPbWwxjolkOd7M0GMd/hq0FDWLzUE//9LjptAqtygc3Pe1iYvtXocJ5O+
 TJrH4KFVUk63lLVMh0w==
X-Proofpoint-GUID: hFxHqlWf8l7QanlIu3dq9gG-Xpbcoe5N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MiBTYWx0ZWRfX+n3pg60YFbnb
 wzCWW4Wx41zUao1jCIFZbAqR0xmP+aSae/J7bQ77Y+JxIcXLRAU5N/N+3RKcIFdzc4cQOeTCu3H
 85ONWvJrWJbv1WQ5+LR3FcjXYMS6LQE=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb6204 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=IMs-YuIRBPBbULbUHgMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/23/2026 3:46 AM, Peter Maydell wrote:
> In fastl2vic_write() we do:
>     val = 1 << (irq % 32);
>
> Because '1' is a signed integer, this can shift into the sign
> bit of 'int'; the cast to uint64_t to assign to 'val' then
> results in all the high bits being set. This happens to cause
> no visible problems because l2vic_write never looks at those
> bits, but it's obviously not intended. Use 1ULL so that we
> do the shift as 64 bits unsigned.
>
> Resolves: Coverity CID 1685261
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/hex-l2vic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> index 736f1be3b1d..89b44200928 100644
> --- a/hw/intc/hex-l2vic.c
> +++ b/hw/intc/hex-l2vic.c
> @@ -381,7 +381,7 @@ static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
>           uint32_t cmd = (val >> 16) & 0x3;
>           uint32_t irq = val & 0x3ff;
>           uint32_t slice = (irq / 32) * 4;
> -        val = 1 << (irq % 32);
> +        val = 1ULL << (irq % 32);
>   
>           if (cmd == FASTL2VIC_ENABLE) {
>               l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);

