Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E174C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CaJ-0004aM-7k; Mon, 14 Sep 2026 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CaH-0004aC-9y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:43:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CaF-0006ZM-H4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:43:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJZ5Nf1383749
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5J2nOemGL3odri7V0cyYzAfJiMtcfwQYJXdWY2gt2vk=; b=AVbdGc0voeqC4sj2
 w3NTJpZgnMJGkNj+yXAZDhODkiI9Y6i/66oeOrj7rEPTJLALPATExKzik9prJ0UW
 nV2vyHGwJ/T2WQlLiQP8vRMRq7lKxTtR0LT6m4ATpTFVax7vvOxSZZrOVEQGF6y2
 tC7ZjiQQYhGfJIinFHZnuT5PzS/b4Sro8ZUtO0z+Rv2foNFU2vbj3GLCPm6Rz6TQ
 EKbO8N+9JkXoJsT5rweu7Ky9pR6Z7C0MAFe/83jQoeVJ77ZsO1PM84vVX5CPmWR2
 tfWMCRvawGYoui8XVfLUgERZuh+jp7BHpeYqj6+Bc8q8Z/0iRs9c3QIKCXuTzTud
 hWr3wA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvthv2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:43:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so5407320a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414997; x=1790019797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5J2nOemGL3odri7V0cyYzAfJiMtcfwQYJXdWY2gt2vk=;
 b=YWIbl7nbfVdnk9yQO53tV1H1mwvJnUt/ijziXakqHuAi0ocxlYyMpgZ7Sc95nAbsT+
 4RcHOcNk2cQDA2Oknddo1P0+W4yQFfK1GMwZnClkwKexTTNw8DwuA7vBUKhm8gV9JcMr
 vGYv6T5rdZSn9Wp05pAOx92k6g7tzcga/MHJtOcbZgwMtjS3a9H54PnYa/H5umzpuTkp
 FDOfQiapm9BCki6xT1LUcmX8hT1TFdH0sCsn0Ummt6C/SPkA9olD2QqvDIzDfyJwb6Gn
 NnQS1BIIsBDKS1siFokK8cZxsUu1qTkdNvUSSyvGWF2wMv87N5qjMVSVR/oeAwsAsuYi
 tQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789414997; x=1790019797;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5J2nOemGL3odri7V0cyYzAfJiMtcfwQYJXdWY2gt2vk=;
 b=Yw/406YscE8HA26V4sEj8CJVgXNBtRl62rMDTo7/5cfQyjYGYuwTCRIHJUmsoHMQeS
 1efXAkB5QijkufaDPj5hAMeqmtPi0wzcEkUyGlF9poH+WjKfIsZux+xXNP3ylYWwC49r
 JaYjI/WQcZtLLAfFBVyW5H80Yhi2CGmu6vWRTX54Z6eUhgFJUY1wvb8XUW8nB9YRpc2X
 dHoYm1QO2RhgxM/thp4UNePQCSlU0Dte7fhTWC3UM3ZekAsehLeP7UE7IwWA4sb2RLDn
 XbGjXJyJhCekL26vRfaEqRYIpDdG/ooI+oAq6YZZohyPrJERsYj5ZqE0hiWw5rveMGeh
 Ykmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXhZepmWHicPAbIH+g3ZeVRvdsz+EQ+/PPC5ukkrsC9eu7Hx+PQtxGLlUbwsu4PJblSdx8XiQAjWRx@nongnu.org
X-Gm-Message-State: AFuF++kddzuEYpjp2eVWrw37YgMgeaGYnQo+mrez/H63xEDeeA3WXH7m
 aX9942p482r2aEGyxcqTTkW0ciUrdqm9qS+9V2kd7kZ+ISEAoBpJWZb2Hw+O73MkNTxbFClGXJ7
 fv9ni0C7SgVeVTl6NzVYCY6rokeFg11/PlUQDsc0ZkE7EJ3a4J/USdrkvL+/zqY4aug==
X-Gm-Gg: AYBFou3Akx8nd7u8SUTegzo4TX4uatwJxnfDEfR4JvE8D0frs3IVw3edJD7BdAnfmJi
 YvVSGCbjyCiMawetX3s05XwUvEjSVA3nL2ZnkNNHxFwlxw3GQc5Kdx5n4ydkZvU2PXv4sEfxZ0W
 qpAAGB5enHNv+VkyFTzi9gM7ltFDX4qA1BXhJSPJi2fEBqJ/I/hXBirolR/1+zdYI2r2nhlVPQ6
 s9s9U5TF+vMdDPKrl97evQ0jdxHGQWBalHho2wlcOqnva6hoHcCARHbxnDeEEwin+5AZlPHR7r8
 CyDbhZ69Xnq/5zYHVxu0XhUJQfgEtsXuh13E/WAA1mPnD3lhK/jkKXl6HB38Lx+56e+44K+PWmA
 09m8tKTD7WfoNZflKGfh+NmYbc73avP9LVDH9L+bCBhu+1pf01NjJ/+W89mMN0tG+oUkx
X-Received: by 2002:a05:6a20:ce4a:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3db404efc97mr10378372637.7.1789414996719; 
 Mon, 14 Sep 2026 12:43:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:ce4a:b0:3c3:8d86:9855 with SMTP id
 adf61e73a8af0-3db404efc97mr10378306637.7.1789414996305; 
 Mon, 14 Sep 2026 12:43:16 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b759d0sm28253217c88.7.2026.09.14.12.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:43:15 -0700 (PDT)
Message-ID: <823b95f8-e0f1-4f6c-92d3-f4a17af2ccfe@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:43:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] tests/tcg/multiarch: suppress UBSan for
 float-to-int conversions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa84e55 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=41fbqxF8g0oZ3Y58i_EA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX+D8AU02mTlvw
 nw5i1jzjRTxpkdqhJ7YdowuWI/0Yz3YWyofGIYOxoUoLxHUSD5YzihNduApPyvRqTMWe37MDI9i
 Jqy5r2fnveTE4NebRFYpw4b8lve9GI9tpdjhSUsY4V0a7ZpdwDJ/mInvt1yA1QWpX7pRA7y8YAk
 SJLPrfGLkihZInxC4KJli8N+2IeNXqXjVp0VesFmZjL0QQ3yWU6x++C8psACXBlxguXmniw9ISX
 NtUNLnyQwMHFmpP68JCXhZ2iSprcwWls7IEXRlKWdo0qo6wQHzVpHYPc48aykJzXhc+UyWLzWnJ
 asCZlVKvw1XSUsPk9QV27vcgTCxaDbS/me+7p7shuT9PU0U2wPJ+vtyS2Ov+tLFX/NWTW1Z8E3X
 G1WSzTg5D+yAXKRBhOc4GINuPmfaWyGxdvtNPKOIT5Cx1TiqGcQGEMGS55UZ2CEAL2CGjKkcpRE
 SP7sG20wU8IyM1eJ/5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfXzcpuyODqFwCT
 aMognyGOaz4/g2YX+nZM1ekps1XNNAaxoCtBW5k7DI84WBGL9sFHk+a/+NgFnezFy43Usk9hLTl
 ElGH874zspFtPjXCzPDtjwagbIlmSvc=
X-Proofpoint-ORIG-GUID: eKAuIwYAk2WECP4yD0uUWo2t14_gqlk-
X-Proofpoint-GUID: eKAuIwYAk2WECP4yD0uUWo2t14_gqlk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140280
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Add __attribute__((no_sanitize("undefined"))) to the float/double
> to integer conversion functions.
> 
> C17 6.3.1.4p1 only defines float-to-integer conversion for finite
> values whose integral part fits in the destination type; it discards
> the fractional part and explicitly makes it UB if the integral part
> doesn't fit.
> 
> These tests intentionally exercise both of those UB cases, so we'll suppress
> it to get a clean ubsan run on the TCG test suite.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/multiarch/float_convd.c | 1 +
>  tests/tcg/multiarch/float_convs.c | 1 +
>  2 files changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

