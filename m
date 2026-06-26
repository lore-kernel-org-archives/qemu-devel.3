Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE2BC43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8V6-00045A-W2; Fri, 26 Jun 2026 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8V4-00044Q-Vg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:29:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wd8V3-0001p3-Dt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:29:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QF44kb1778585
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Mt9hFtwPTr0LdIXbJIGTvpEqMeI5bFCXbQcnpNX2PI=; b=pntkHo+orSjX2LEw
 Gku9lsFj0vqMgYyPhaMtjgw3LuM8I6+903Y+r5Oq/07diS0ozlvXbhsWR66wxb9Q
 /6IQJ4Bop4uv0WYwDZwWnLbZAG8OOnXVQ8txBvDArzVIjTxR7UH63NVqvhQDqQfs
 E0fOGPqirdegc4NNxtGmwIFBfpWtA6n9x2YBSKmUGEVatz2FFy+7ChUnCbNT9Nan
 JwTVUr5XAYVvC2PzppsJV1Csm+DMlCMVHXVFs3Ri6S6/WPbLaAyqZHYt3PaOWrKm
 80Yq+t3TB3+hP+nUrdrhOM1lx3/OZEEqO59NWuYh83UNVVTf8OHy0KSxAEyJiLrC
 A70ifA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1tc3ge35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:29:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c42d96713so829388eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782487787; x=1783092587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Mt9hFtwPTr0LdIXbJIGTvpEqMeI5bFCXbQcnpNX2PI=;
 b=ES1TGYLY22Kj13BPyM2YpMvTFl9twGPOCF4erTAHOPauQjwxvdE57FY53GaM7XWCZE
 McGniwrES30NY0tG4y7oYfeAG/dtOvZH98yS4FSNf/4NN0yh6sfNU3G2sBKWEkK8Q+lm
 q8jALHLOwugJ8fqDr7z4Z4c7byZDKxcTTCvqt7SingI+cUiT3Uey6nEgXYPqS4GTvh3K
 Cd2kB9I5o9QKqj0mZ49QRYd8Wz6RDBlMp8DxjSY3ME56tiGaFYg7tVvdem/3zLzwVFpX
 du2YoK7pMn2wyqkYrXk8fBY8WGJN+wPc+85NtYiqf3IS0bkKM3SCcictZNMTe4aEH7E0
 H9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487787; x=1783092587;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Mt9hFtwPTr0LdIXbJIGTvpEqMeI5bFCXbQcnpNX2PI=;
 b=Zq0xSxUixhXmVuFZ/y+4w3Il5Fr4vAhQBfouD/J13EsX4VvUTPsATLs1tu3xcadbhU
 6oeYdc7g+61hkotiTbQ723jSfhbu1DHWI7d49ioPpOv2dHKVtcatpVeed87B9701V1NN
 dfOKEUgor/A9ywPOt1LgXosWK/yhM9zIXaPx59VwlaL8DAwEF7tIC+SLzp1vKluO3iz6
 8kdR1YGlT0CFCpcDgJFrbFCOQuU48A579gYAZ783y5OK4FmdmdSA9OiQ4mwodjr3cQA+
 kmUqWz6tqTXgKM/tp6gegZL8AtChozlpPjjrrHe5sLA9Qqn0XVIUxp8YvL9UL55NFK/y
 0oYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8S4sSvnMl714cYhdULJtpI3eFkKHv8RupA9RxJl8m+aVwCY8mUCJq7werR9py3fbQs74irUVmmNe1@nongnu.org
X-Gm-Message-State: AOJu0YzhZxjCMS9f8S9eW7qHdw3RftjAZAcNkEMJ81G/47tSxl9rp+la
 x+LrI2NxhPi+zuU1p1USHiAqX0+J7M8Y2u148r9MWToLxKS9SwT08SdlwyIxaLkKS8fu23QBPc0
 eNMWSIyxmqlJDPjvYcqKTlDKMlOItiJptlp0unO/xOSUtzdCzauRuWIMrIQ==
X-Gm-Gg: AfdE7clp/Zfn86MAOMdDJO1XiumoD/CuvpYxEGI2xWen7CywnVzauVRaQVWY19EywxB
 trQv7ftYTj8a1ISb4du1tDyoGf0YcAz7V2lJKqUkJeY64FEUwzeZu3+upsZakYPQmzkmnjMT9Ss
 M9Htr8dULA2SzgUCu2gEqYSE1laH633/8+0EDNmYdx/x3PLF4Y5+VprOBpQ7Mvq3L+7mIyml1gt
 jNVbd5m5mn9RW+kSrPFj+L9z47cJj1hI6lmS3yRUFB6+XmfHc0RlvvaMO6FwmXOTuR3apx+I2TF
 bqHvmrpREwoFW6kPzt7sVbhfJCCBMuqDkKVHg3mp+8exFZUQTg1r44qcPNi9WnpMiIJmHqMTD4h
 4tSA8IcDrye6F9X6tZsQTCqcMrCVgnHvGoaPj6yF/dO+Sh2szLZpSC+6SnEFGp26J4de08M9r1A
 KlJ88=
X-Received: by 2002:a05:7300:c8d:b0:30c:ab4f:9ba4 with SMTP id
 5a478bee46e88-30cab4f9f96mr607597eec.44.1782487786627; 
 Fri, 26 Jun 2026 08:29:46 -0700 (PDT)
X-Received: by 2002:a05:7300:c8d:b0:30c:ab4f:9ba4 with SMTP id
 5a478bee46e88-30cab4f9f96mr607572eec.44.1782487785929; 
 Fri, 26 Jun 2026 08:29:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm21211581eec.16.2026.06.26.08.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:29:45 -0700 (PDT)
Message-ID: <7b30ce63-6387-4e0c-a883-ffd56eca032e@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 08:29:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] gitlab: expose more info about CI runner
 environment as artifacts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tMOEVoMuKHe0WlwVpfiLe9_73mGa5yQt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX/A+d2XByz8JR
 jswabjeMdQZxkSlnyfqL9cnpVg83cgviq9apxUDpSa7pxrWNk5T+SHqyB7PgaM5SiQ/SYOoSFJ+
 j4M6UxEUOhFWnNdX6gi0oQvpgTmlf64=
X-Proofpoint-ORIG-GUID: tMOEVoMuKHe0WlwVpfiLe9_73mGa5yQt
X-Authority-Analysis: v=2.4 cv=T4m8ifKQ c=1 sm=1 tr=0 ts=6a3e9aeb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=E-M4pueumD7XbDzm_F8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX6ZlNWqhQVvYE
 //6WeKPCVtgXriXKde2LN1Rnn6UGcn+05FitGHeRIfiYjjeMno1IiABvrwmUmnBbYE0rP6gO8d2
 h2orY8nw/BqEJoLP8rzOOFHI2ktWTEV0YNQByH9Ec3dNrDcMiXevYJ4JKTw6WpVLhSL/XeP9O4I
 uo4vuD2QPzSfZAoTfPhol8W/FW7V22UHEV4u5rsk+ecF7vSoS3SyZVAP4/Kg8aW1xcuGhXV80bG
 /oZJNp8SWrVvsap4rVVps9OoWkbpEce7vI1B2+zWBSTzoqLswQC2pFvFVw/gm1I2gP2pCt5mZ5+
 Z+46LWgZ40kB5Q5l0T8Al369bJV+KgNWZbxgdjdp+hSgoCVshI4Mg+ixmbcxNGDM3lXi0RnWTJ3
 49Ud9/OoqAUt7WtfS5VlQB2DDfQQScCgh/zkAiytllrtOLXJM35mU3pHtUGqx9ZWTezIPWuasAA
 e/xu1a2Wiqddi3wK5zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260128
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> To repeat the commit message from patch 6..
> 
> This captures the mount list, CPU model, memory information,
> device node lists, kernel info, user identity and all environment
> variables. For more details see patch 6.
> 
> The first 5 patches are all refactoring of the job templates to
> reduce redundancy, so we have more consistency across jobs with
> less code.
> 
> Sample pipeline showing the new 'ci-runner-env' artifacts in jobs:
> 
>   https://gitlab.com/berrange/qemu/-/pipelines/2626072516
> 
> Daniel P. Berrangé (6):
>   gitlab: remove unused .cross_test_artifacts template
>   gitlab: move .meson_job_template into base.yaml
>   gitlab: use .base_meson_job_template from crossbuild jobs
>   gitlab: pull ccache setup into .base_meson_ccache_job_template
>   gitlab: pull before_script logic into .base_meson_job_template
>   gitlab: greatly expand captured info about CI runner environment
> 
>  .gitlab-ci.d/base.yml                | 48 ++++++++++++++++++++++
>  .gitlab-ci.d/buildtest-template.yml  | 58 ++++-----------------------
>  .gitlab-ci.d/crossbuild-template.yml | 59 +++-------------------------
>  3 files changed, 62 insertions(+), 103 deletions(-)
> 

This was merged into master (8f1d3b586f1265023f75ea9c227c35d463321aef).
Thank you for your contribution!

Regards,
Pierrick

