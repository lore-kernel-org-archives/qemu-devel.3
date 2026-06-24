Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB829CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQtl-0006LD-7Y; Wed, 24 Jun 2026 12:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQtj-0006FO-CL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQth-0004dc-QL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfOMw701787
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 flG2QScEfl8CMuRf2CZTcr9VOFdklRgCSinvgaEyVcI=; b=H9Q2CnaddmumfirD
 snn4A1wIxWrbCUEV0iF54AcO2gBv/KPm3MSCKEERa11de0aMXa88uHyCN9b5LTM5
 RYBPj6klIlFV76clfZzGZvl2k78Jq/QhWlVX5/PotAvkniTuBSiaUD6OqODm/qJ7
 gyKBG0UJ6tHCNBP7DTgdJHAiqO1yiMW5UrxjGnPcxsJIYvyk6jaw1Qq5qBU9KTD7
 UDaDM7ldYFPVOCHpfVMJUgzUXRzbHLObvgx8SbVB2Vm249b9lfCCfQhev61yVlla
 ipQAoapdlHg6UBrcnPKzmTd2pa6ET8qcHr8Lapc4mhRumdKQ1Cu+dkm4SNm264Nf
 C8T0MQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0aqpaa63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:17 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so4808386c88.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320177; x=1782924977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flG2QScEfl8CMuRf2CZTcr9VOFdklRgCSinvgaEyVcI=;
 b=WTUlz1Zm29idzFw/qSj4MzF56phO//laaFSxcjaqz7uWHY6tS4Goq7oPQ2+tispMKN
 NRPXP6rJgvoHKY1MIQJsaoPpVGNoPsZ9zBSJMt6kdTeljtUMMJuPpKtX6GAt7YS5324T
 b1ilyjuvxFnARKaBxg8dwxdVd/PSy8npHUU2Nuhhb3Fn5k4tUyi6GHs0jk27g3AadhqK
 hXYwyK6C0E8fIL9oeFX8AP6CThkysbOUtGYL5XnP/+Otw6lIyiO8jVCdXrSvKG7EspaV
 Az5J1mGK/3MHGmLLwhsylKFqlHlvyfgA/ghIj6y0iUXgoJw2ulA3z4vOMYDr5bvkVrrj
 xrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320177; x=1782924977;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=flG2QScEfl8CMuRf2CZTcr9VOFdklRgCSinvgaEyVcI=;
 b=Hd9yETjngR8QzT7lQ8s8QEjRfvNcf1p0OG24EWeoyPvlkGiAgLGIBF4rQMXwiXNJFU
 4P2OOZqp8quZLLtSDkNdfiNDZe1rzjcZhRtsA4+MhH9zi+Vp/QoSPHJWjEAfRqlEQ0xZ
 2NPtexEqmI25/sC6JR+gYw1qHZkJ0T9MAgerECv9esvdS4GWciORMG7E+eSfOa5TJCFi
 8q9htn71TZvEYPCMGa98I6Rrbvz2nclCSGPBRAaQfTFzZND2sfwKfPQBWs5fJqkOLMKv
 5BJeMTID9iVim3wG+8ZtZKK0ciioviPqaGgfGteslOalzK01hhf4M8si3tjWj2BIQaKw
 4Egg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8m4dVZmR5xQF/ecky2um6kgTdPb906SpIy9q+7kCcrHDMe0qDCIPuUD8xIM24toWst6ytU04wEy2kn@nongnu.org
X-Gm-Message-State: AOJu0Yxil/u478raRFNfKTnz7Irg//O6s6GH1XV637VZKDw2GgVKcQ6u
 payo46jygb/oU8YAAcN0uJGRoBVdZ+cm8bcPhr4yhjc7oIF3wqjG8DutX3hQu/JmC+gygU2exms
 QlO01R5dV8CWGKJsPbAeojDDrIE4q2laezO61+3W0UJsGgPsFrGiWPVyCew==
X-Gm-Gg: AfdE7cmT8cm5XSAS2dOphBC48IS3PM7MEJ8NalR8rjuMeWwXRds9ZpmGrXgKn79bIiY
 CQM0qCl54vzanv5qdfpyhQ+u8Sqd7frpbA/O/N/lXtsv1lSlNDGwZZPEpChr0kQFL/jXpf/Y0v/
 3ZiQ6eSJ1fyXzPSRs/MSXo4J1MuNNzL49kZR48FxhoJy5hDLrP5lepj7MDpgGp7hcYa6m2rdOHN
 aZH5mwcg07KoUNGjasuH+LzKJo/ExGT4IHuOHuU9HFsqohfjghpodN4Kv+kq/Ai2bQQZMhfD1Uy
 CIo7D0zb2DwUEYeK17BRKdkZM3ir6lIiR+Badp1oA9x4ISUJ29A0/OWDTFdqpODsaS5L1bdHest
 4UVEUsviLJOw+Rufnkv3ATgXkfymCwcfxO2GZ6N3UAuO08XAM7XSjey8PJl+s/cEyu21eIsxbKi
 OSMgM=
X-Received: by 2002:a05:7022:4193:b0:138:104:439b with SMTP id
 a92af1059eb24-139d0c8165amr3358671c88.19.1782320176985; 
 Wed, 24 Jun 2026 09:56:16 -0700 (PDT)
X-Received: by 2002:a05:7022:4193:b0:138:104:439b with SMTP id
 a92af1059eb24-139d0c8165amr3358653c88.19.1782320176455; 
 Wed, 24 Jun 2026 09:56:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f77602sm458321c88.8.2026.06.24.09.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:56:15 -0700 (PDT)
Message-ID: <3f580f6e-79ae-4175-bea2-4580339c2231@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:56:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] gitlab: remove unused .cross_test_artifacts
 template
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-2-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dKMSIKdaphAgXF2_83EBq2Y2M8MDzn9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX8xVCLublyYAa
 sTfZhL+3cNWcx6NyzzdCjHk/SgNu+k/1B6TjnACWmGP+X9/TSoTuPn3w6psLxYce9HTc+iQ3nJ2
 2a7raYvS6QKqDgB8geM5pkpJU4UWaQLDwZdedFZ+glILDM46WCL186BSCvL6kj7n0ItAbd8HYP4
 2gwbNE+KxGKxyF6b0SWc/0IOyWv/69O+kh2gSn33e3/UgC2HrUpYIKtrJBQZspehVHBVPHzCHWF
 S6lNK5gf2BWptwUfdP/fOPr7K3iJFXdwyJlH4dekr6Tb2jliwC+r1lRB3tyHComO/Q+XbSj6foq
 ty7fdEfmNBNzsYNoLmnWyTDESEO6e9oTt7+a9JezFQLUHcRLcH3JO0f7bHcWgprivmJf9K9JBQp
 VvYd6PsQvSb2SsU/qWjcPNoE3wp9iA==
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=6a3c0c31 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=axZhOA6IkxznRsLioOkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX3VbItXzuFQ5p
 oxg8uB2IBrCSwc7H1PDADffrcYGEzKIZbn/4zwZoimsh0yGF+WgmyynhEuVS6DvXaZwBJjYbpqP
 tWCdsl7Ue4n+R7rIDIc3jq7DuioOXqI=
X-Proofpoint-GUID: dKMSIKdaphAgXF2_83EBq2Y2M8MDzn9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
> This is unused since
> 
>   commit 0d1137550bbf3af7ebe34801a9bff5a4839cc34e
>   Author: Richard Henderson <richard.henderson@linaro.org>
>   Date:   Thu Dec 18 09:58:33 2025 +1100
> 
>     gitlab: Remove 32-bit host testing
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/crossbuild-template.yml | 12 ------------
>  1 file changed, 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

