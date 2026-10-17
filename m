Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7863CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI8Mh-0001BT-DY; Sat, 17 Oct 2026 13:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8Me-0001AS-4O
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:38:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8Mc-0004a9-E2
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:38:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HGAKVu1333105
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vom1JDduJAKUdzHJoMNoxgfCXw3xmjhd2QQV73+SBXE=; b=SYCl4KwjH9hteXXv
 6tHCPEYbG0VJlrnQpSYN29wa16opVdeNc2Z/sWUUpb3z9z5mxdRiEkjbA3YewMGK
 4+MztZInfaR1t2mZ+BhtEWoHyyTSUiBYpBM0nqMCVyRPt1KqmkvB2MGvGkk6ytDd
 NWTUEEV0j/a5phfMOxXI9IbQAdeaoIGchtjC2wy2NW///OvRJD82de0keAsIBCtj
 +mpBo8/CcWswmm8qSrDQWSgzpiOekwpycLK7iic5Pi7P6glqc9xtYc5I1d7ELxiU
 Xgee72q1bJRH/OV/++0qnR6dDM9tlTt8plxSkGptVEmSjs4k9TT2seCQRxg3MuzR
 kaTsyw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxcnss4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:38:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso1425790eec.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792258711; x=1792863511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vom1JDduJAKUdzHJoMNoxgfCXw3xmjhd2QQV73+SBXE=;
 b=G535rATLMovxfpISDydNNfCaO8OmnZUnGyrc0AiruPRIz+MvP6AZq5OSeW5HEZJcfE
 zTYreps2sQqlRnnw+LeaPt7pxYbs5/CvAsbQZayw7enXfswQqi8ct6vPZ5tYQaTUloDP
 MxdSCJgYrZtPAqAmr0yWDLdjho5toIqmvlFnu7lCvuvLO3hxZRzW5xkwrEMqAIUODOCt
 IRZeQXYBNhmXFIgQPueHTzdk4mAKUAZGKmx+DgWT9hcoPNsaOVYRGz6WMTaCwKagdE+H
 KZonD//S8Lk9jYlP0SvKJfa2oP7rnfRz5P5AIbgwAoROA4Ak2IV0SfA4FdQyCvBB4X+A
 QqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258711; x=1792863511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vom1JDduJAKUdzHJoMNoxgfCXw3xmjhd2QQV73+SBXE=;
 b=xS0N9OAp5io0LnJB5ylvP0W998SNQ4dRQYviIhPlmCOVgrgfLKrkCQYYEKZr5sSnn9
 WFFWwPTsexMP+2qOaFi6kv6V7fsfMdj5cCws7Ek22kP/jMasH6TV63i7kA4RS9z+dd3E
 JyxbrHD8v5pAjYsi2jlJ35lGYATchRgMCF5q4FGX+EkPDxGa6HqANsTuYHgjfjTGF3IO
 w+Y4F9IWVlmLqX/aN/xh2TVJwElLA794lObHXAzmKi1SwG6j8yh7RH4qWPbY7yUtXm/n
 on6nVlKgLr4YEehiUKJaWNEbwb8DW76P9TRNDjV6EXZeGceP1Xi1Zh+MvOktOY7W8hTd
 WWyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgTGl08zAMZumQ+sF7KtKImey3cmTccwIjxpArKmTSwPJ4/+3FSYHVggR2eSiswY8GL+XE5jFh6oNf@nongnu.org
X-Gm-Message-State: AFq9FYKJxcO6MekMUQUyoacGQCTHUJAVpzA2wL3fuebO3NCGNq1KR1Dm
 d2owqfa6yV+dRslv4b38/NcyKx3UMMvxnTRKQqn3xwrpd4ie1tvLh80UVH/sBKfCF1U2kGbVaSw
 TI0LvudUdBsCVXCKhze2J02wEzctAO1xH1yXnDw/QHXKwXcnbhZQ9lPeEdw==
X-Gm-Gg: AYBFou2pCwojCJI//lHQw5BUZivHtyUYhKKh3oNwZBAPlvVVV2rzdjHOyXMl83DEK+m
 Yo0qiOf2y7J5SA01B1CzXLZPNCoHNrygNZN6x0C1QRX/S75Tz8E+knxLbmm3eFHrh7VyGsfsLxG
 bbsXiSvmWQveN3dF9GO6BlPb7g00TG0sa0ngKywaRcey20lhNWx85AfnXlEVl+tVkxzow7JGnBf
 d0OPSAxt5rvbVNPOL4NXKdWKltEPz5C+WdzkpzA1eIRAN7l2la9ctrPzXqdQcVTlwUPgFJ8oNhi
 Wi/ECuM4ySd3iAqCv1D0hgIdyoNCyV6Jd+YTCxNz8VseTP9YcedIyIGxmR/juy63ujLZ7MMfqsi
 AtLgLMsXIW282zLQPGl5uApakKby9JtKFQyU3FOsx80XbI1dm2hBjUb/z2NF5hhteydDSJA==
X-Received: by 2002:a05:701b:4291:10b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-18513e7c690mr4792011c88.38.1792258710608; 
 Sat, 17 Oct 2026 10:38:30 -0700 (PDT)
X-Received: by 2002:a05:701b:4291:10b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-18513e7c690mr4791967c88.38.1792258709682; 
 Sat, 17 Oct 2026 10:38:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm15680524c88.15.2026.10.17.10.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 10:38:29 -0700 (PDT)
Message-ID: <adc63c00-6fc7-4e72-896e-3d650e02cf3f@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 10:38:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tests: add an alias for all TCG tests of a target
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261017073952.1346449-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017073952.1346449-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BNUmP1QG c=1 sm=1 tr=0 ts=6ad3b297 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=8qsUK3cBa2MkJvFa:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=--kmgXq9RwlOQe7paawA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: b0nE_-CbXkmKuRPMLxDlO2LKAKNx35mP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfXzYpPgVV9H7iF
 1kH2/ulxBWu9G1KrIxP6PRFdNuVWp5Pagfdh1ozYvcKeoeM7VGylFFOPTGBGxd4PsjgwQl8sXyA
 /MfAlwXUfqRcQGoYyr+8uhrYLXtLatc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX2ILgLByw+S0G
 B5FqAnHCqIuCwdO3jYLW9TZoBvXlWtGAONTlJ23pHUlyybW1zx30bSWfUbVMzlAgkbGMbSHcu+4
 YGN/EoIpvYLTCAshQFJU4/6GfDLGa5MCpWn86pVbHIBmqys/dQTZuMBpmRr6MfaNio0/loPUCnl
 AhXS4UOZQhqimNnuWmrFjLwyWe9j/yyjy7RQ83SDFwMilN8tIWT3FPNNidYhEXMhgVyt9ORrkRS
 0A36xrJAz2CKHEBxApVkfVH/GEeUSF4gcQB1EWybZak3VIrygT3ql83dkONGGb7TohsKzwBleFd
 iTpZsemHrHaXadncH3JlMnwG2i4oa5kd+HYAfb4bhMi4d69pTOlPkj7WJL2pj8HXrjjdWucEUpD
 F+Xkqaec7ytW2XIEae4sYOASL1Cr4w8n+tpL8eZlaj+Mnb1L9O5hh6hjHfsKsY2pLpi+f5pyPr0
 udJJEcUywSyTPXLoLRA==
X-Proofpoint-ORIG-GUID: b0nE_-CbXkmKuRPMLxDlO2LKAKNx35mP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170070
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

On 10/17/2026 12:39 AM, Paolo Bonzini wrote:
> Allow building (without running) all the TCG tests that are available
> for a target, so that they can be run manually.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/testing/main.rst | 6 ++++--
>  tests/tcg/meson.build       | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 

Thanks for this addition.

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

