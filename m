Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88405606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fXTASwHu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZqICuEJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzgj-0004B6-LQ; Fri, 27 Nov 2026 12:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzge-0003vp-JE
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:24:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzgb-0002h5-2D
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:24:39 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFp6KQ3560820
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VG7ozrshwDV9CI4BAq1C5EhaqNDN4FneDmMByMW9r7Y=; b=fXTASwHuLj6hSRE0
 ixso+OvyHwgMWON9x/Y586B4e9EnT0AMATDezM08fyomgFdd20qN04mDa/8ZaZ4l
 +AJKNiFdB6u3zUEhdfZDlloh+NhCK/2aSvYlKKy0IGXolQsEyJNmlas8eC1w7wcV
 gDBA1NxGzDqyHaAMlZfTDQzWArkylFqHvUBujQXQ0cDpw1hj3j7FI1lQtWlpcp/X
 D4C8vPoKYb2Kdg5rA8CWr/hpzIFJ2qzEKEReKq4HgtOcE292s0pGHGDbyjItZSBL
 +WsxscsVtO7a9aueS3KIr22raWCy/3mMpcxMA8HOOOvcTE8sasQXT9rJP3fm2DiP
 CdhkSA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf94hg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:24:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14373747468so7909811c88.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800275; x=1796405075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VG7ozrshwDV9CI4BAq1C5EhaqNDN4FneDmMByMW9r7Y=;
 b=CZqICuEJ/XSzohKjGdoN5nZkjYhR6k5H/dRa0ixwXYPcKsd4K2bOcgr/UovtYeKKqb
 vqZNxHWtk01Rd1+YyCh+LTV7Bw5J1YsdHa6kzU5MGCs/Id2in6W/GZ8Z8QBhha/9UCvp
 JzvfB9sTO/UmxcWao/tszvFpQ1CdumUG7x/5KkbEFCf9bpvnTAHl+weoBLI1qJV/vZ7y
 /Mh0L5lU6rnUTsxswPGpkYkvps2VKx4fOFVPQIWW262T5FNbcqDBLw6gZlwM2xt/1yVG
 FFRdighvCn7nIQvzKQboroxihgPh8AarKl9Wk0o2rrIWbCTIxRRf5mPpnOJ2B4FPeW3/
 BaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800275; x=1796405075;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VG7ozrshwDV9CI4BAq1C5EhaqNDN4FneDmMByMW9r7Y=;
 b=uWwA4GKpcMSrPkTz0pRlDiGIV8cWM4JkgY0yJMh2tyxEVvUHbmdvMnO22YO+1R22rI
 E9anWQAUMya9DqO67MOKp5v6OO8L24SmoNo8bOyVYaCq/HdtQMjohKBFIPCjP/CX1y+r
 Cbak+/u5SZ2TZ/9JGJjGphY9iJD27DHvFYrqhmbu/wW7eids2yQiagRvBJlWHQEFAqxl
 wX/W76jeEQ8ol090BrU06Q95ZDgHB/3M2CJn7t2G18q8Kn+A/qVTD/KTHWutJVWyu4jQ
 0FqT/Tg2lr4jn914NWTenKhY+Y5GiDg3igemRaQnXRaPX4m08kEyVax68ky1JqWGTXX7
 BVuw==
X-Forwarded-Encrypted: i=1;
 AL+hErEI85hsdPBi3+/Y7dWWgKXprqNAgsdLwCBnmAGwaqDY9vtDGf5XyXsSzgTlJTdaJJSajPLiNjcI4Koa@nongnu.org
X-Gm-Message-State: APuU4Z/T4U/TNbWHEhWmxViMYti1wpyXx6R6sA/JUbSiPqwX94fVOPKO
 aNBCTaCoVuIPGlMfS4Je3ByH7NlEUE1JNymFaX2Za7WjdRkICVufk9tvBCiMDqRDyYhuyrwPWU1
 3DtM7vE8QjEf5B68oSDFTYr71xS8JVSdulAJjmT15ZG2AP9C8sg5Gq2HOow==
X-Gm-Gg: AZFdTZeNfjjucTvnQaIyvA2Wf8MabsLv2kVRvgIATFQA/hvYqvSmDYRVAEIbvQfiwBT
 uRBZPdgXdY8STmz5qC8HJayQK+pW1GY3WOVawEJAj153BBfWRFV6DhqC/LCOU9nc2N/GympOZl0
 SmKkfQ/d+Qn1jidOsA4dU8ssfHgm/eN50u5/Y9orka3qWYAMZe202hLlLNdimQJqZIzXWcRWt9o
 malvBsMH5L+IZS14q22YRt90JcUd4JlLDCEAJpq8l5AI4S84/7LCOjz85qwGfjdAIph2ao7UCbA
 cn6ZFOadltmAIJmY3EYtHhBuhhwG4csQEo9+eWnV8RpAV+dyUN1D6Ra/9eyHFwW/GU9HN7F14jD
 mDeb/bfhcVgXO0Fc2z2PyiK8yibTLxRVK6LbzCxRafOSSrQl52mZIm5+pBCEIUJIhRaZyho3Wn1
 qZXDN6uBwnhTSScWOz2ZYLsdCUAIDiOr6zYfN/KnTmN5E=
X-Received: by 2002:a05:701b:454e:20b0:1b5:4401:9d69 with SMTP id
 a92af1059eb24-1b5569bffbbmr21558685c88.25.1795800274684; 
 Fri, 27 Nov 2026 09:24:34 -0800 (PST)
X-Received: by 2002:a05:701b:454e:20b0:1b5:4401:9d69 with SMTP id
 a92af1059eb24-1b5569bffbbmr21558665c88.25.1795800274154; 
 Fri, 27 Nov 2026 09:24:34 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm96375870c88.9.2026.11.27.09.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:24:33 -0800 (PST)
Message-ID: <ca38a09e-9233-4ac6-98e6-c713dfdc3b26@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:24:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 3/3] docs/system/hexagon: document PMU and
 limitations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
 <20261126183812.1366883-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126183812.1366883-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pMZF0B3ogPjhGb-uuWOvKMMyvfEFIb5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX8A+WDVTQBZ7e
 VR4OooCpvJfLlc0wnW9h/aHzoeeoalYxQm6E0Q4yBRfnbdcx77dfavuiJCmEsNx1bfZTIZlDXyC
 2tJYc7qh8Rxv8K8PVUA0wTAFp6puJNkb63GNW1DdpOF+iJldnLV4J0qrsvMj33YcmM20f/TU+Ee
 T3wjcaLjt2aEfVihCu7RASa87po6jO22noK2daoJJBw3jALfC9khV51uyx8PaJ25CpXydQUvufq
 dYl4NKoNS4r9trkD2IxtO6PvCk1R49RFL4OLzPM0fVrSyVm1r0WXkNzhPWZfxXsrPNcddSsR5T+
 tqSoiI28BdVH4hWQh0rJIsmJRuJekTaoNdbhVHiNfVUxw2nWF6STpZITLeYByFtkMe+TnHrT/Vt
 I18KCccTyPGisRyQZO0oW6771gdNeujk5UvbmbRnW9EQUnF46gtwVItmwb+8/xS/WxM8ZuzU0ir
 SejQbtPlCKreDFqYgew==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b09bcd3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=F4_Ns7eHH980AMGgZawA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX5KpGovDAb8Vn
 XRnw8Di+z1YTECKolzCskeuPdRA2mPoFZrcUGLFabah7BxVO/GPOLcU1X3vnpZ7bSDV+Wme7uqm
 DjGkucHjnlUDXOtWm3LvnBc4QnzIruo=
X-Proofpoint-GUID: pMZF0B3ogPjhGb-uuWOvKMMyvfEFIb5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270069
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

On 11/26/2026 10:38 AM, Brian Cain wrote:
> Describe the PMU registers, which kinds of events are counted, and the
> main limitations of counting from a functional emulator.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 34 +++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

