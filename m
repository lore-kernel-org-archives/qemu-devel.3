Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EF8C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E8O-0005Rw-TM; Mon, 14 Sep 2026 17:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E8N-0005NZ-G4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:22:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E8L-0003yv-OL
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:22:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYZbw2396370
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4frKn1Dtz3xhPw2N53s5o1MAwgvMxm5cQAIWVKEnsAE=; b=SIAbSXBr0QEwzYef
 YLx8XMHNoKhcGZCGsRhW1BkcrJ0ERr9HkaWeeT6HnfQeoXkYN8b0QoFSobW0Isdk
 sw+63lPMaS9tixN+4WFhA2JV2QQYLLWqRH4x/Gq3Vqucj/lqXEa/KbnQhDCoBRiT
 yfssD+X+9utcwgh9bbAc60wC1rDMGi6ZDjTgd5pQW+/Nv0pUdixFhTz6SykF48kD
 oMgfplBgAckn+j+GNDdEArx2ObuO3RePX9KgVnZ5WAMpHXloBLLbhPSbjcyOLPEI
 NHrKXQgvf46d4iTt5xoQdlBfKpNfoVwdbnFSKdn+7ka8pIVyMiQfbkABrYj7+JbO
 vEOL8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41rv67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:22:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso1639072a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789420955; x=1790025755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4frKn1Dtz3xhPw2N53s5o1MAwgvMxm5cQAIWVKEnsAE=;
 b=WuaAwIMF11lQeqI4c0t9F95GgHCRoLDr4MdPPSCKb6tCrH73QAuoaWCZwSZKWIixeW
 z8fQYmff2rSUnEfvZcrHF9bLEZGtk8TdzFZuSvS8uhK/K2sKKnr5N4pWbsTGpmr6nRp6
 DIKELeNuf7RsIkIpSotN4Wn+nYz2ec0XsMODzPo0oZWUjW6w3B32SsuXW18wFaHwaxwW
 VKRPlJrs3vwtZW7qjs67iER1nifL7exaxeHSJiYkJmXWClFe0KuyFdwZ+FnXmqFSFf6c
 690YHwetkEj1bBhVaQT8qsJE/aJsqR3+ojRR4zkP+pYol1mCQG1XhN/KQ4d8z1PP5Fz8
 KQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420955; x=1790025755;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4frKn1Dtz3xhPw2N53s5o1MAwgvMxm5cQAIWVKEnsAE=;
 b=2oVHRmOFni9z+5GHVZ+X21hSg0Rneg1NDo0VQBytyQgh2KoKqMYTOqK+lF0/INSYa6
 DcPz6msmGSExWGzK2MGqvkR8iEH7GUQK43ncroWix8RBl3nVpk8k5qJJhsW71ayX/9I8
 hKzq7ClqLV+LHxO5Aq+VKzNe/O0FVwh1OiG/qqCiheJKnyjaIIFuA04LpMPfBkiJcM6e
 qu85Ybj1thoSfYJLcSi8YtAec2/k8hhvg45Lt/l9Ri+o0Zr2uDxx9FrUfah6tZoZidpW
 vqLbOOqVdk3/LiqrCx9sfVLB6Y0KeHeHiXuPCo9YNSPsI/VLqvAJg+23/jHIH5LUe4Z/
 RSpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWOtUEYbwwiTNXZXbmvjYmwNL58Gw0voxb9OouDP1Pcru88h7k3IxxOLcG88b7Ogistko7crHNOO91@nongnu.org
X-Gm-Message-State: AFuF++lwcJo14s/oeTv6KLApR2ffv0wC4XWtX5z4Svu86PHjyuSWidi3
 gsKnnua/Yd7p6N7ZHZaLpkYnGo6JOZo9R8xxzcVIQUkEqniDJazgQtlnus3RCpfU61HpJrZkDGJ
 zDq9yQJoOUqrVNYY3P5/AxgVcOCUvC/bGx8mdZcKlRZM5jEA0PYToovUbzg==
X-Gm-Gg: AYBFou39q0H+mX5+Y/b29wuApz2KxCxu27ydVtKZ/c04FSw/Ol/lnWr625k8wbSDAV8
 9YZppNfCfYjBsoZtRMxf8MgW6vw99bUSWUTIrDRx8Vy+u6X97auW7S8AhiGZFhVS6kxSIXaieo8
 7UPuj/NLkVjwQrQ/fhP9THKk0yCk7oX6bUEFjxvdkrL5tC+Ex/7rFgheXEsx365QbY6uKdEMG+t
 bmeCrG2W9lHWWTxh1V5q0Bw6B9/II+K/7uDziJR3THeNhRohb5VU6DQYk9uUzn1I4wtT/LW/7k/
 q1kqde8dnIlJEgOTvYlI5hkBnZrDZOw4Ih8w+wzyMFlZT8QRnofYypIH0MYAnQZgBz9y+ORt0Ux
 BqYSuqIYNxR/B+Fcl8+9vyAZOgq10KAsVrGZM6KmrdwC2NaDhcMN0eD8lchgasezfTRlh
X-Received: by 2002:a17:90b:57e7:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39dec05d7femr8844123a91.13.1789420955324; 
 Mon, 14 Sep 2026 14:22:35 -0700 (PDT)
X-Received: by 2002:a17:90b:57e7:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39dec05d7femr8844072a91.13.1789420954950; 
 Mon, 14 Sep 2026 14:22:34 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b348cbsm27821214c88.3.2026.09.14.14.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:22:34 -0700 (PDT)
Message-ID: <bcca2389-f8a9-435f-9dc8-08f581e945c0@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:22:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] tests/tcg/hexagon: add dfmpyhh
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-13-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-13-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX4+Xa2zgUxDDP
 EkoVFV2efCL1ky7EGfdLLHUr8nujYkd5du3UPo7AY6KN/ISKRSHBOZ5XbxuA3fnc3fwWzNT8eK4
 /eXcgDOfEgCsik7/KUSHjJQsqEnvLm/lE9sww58APK1j36kotfNSFkXWlBssmZ2J7y5h7yhqvE9
 EpfkEr4xL1jITIZNwnFgHzAuR6wTgDwZyvXOmvB1mGlSsbt4dYDhE+AS5qhk3fNUgTS2zRA51Z5
 mZkuYP7yOI5UwvAFQp0AeHbyJsz3jXH16QYJZT4vdnGGqAnDE1EpBIW2svgvn14LL9+HK7ZjswU
 DWOqDRYbEHTQHLJYPA0xOeOBmLHK/0RLTG9htMp2rC1qmqkYiWGlszsCiTxKMf/GRtdL7TME3FI
 7wEXmTOMbNzwc1Qa0jcgFca3LsK24ZQqsdKZPnqbGeFgHxFipM3hakk/bGaL74zBGeKLfhv5U2E
 3mgwzDNOM+5ix4kPeEA==
X-Proofpoint-GUID: hOrlO-lALv9vW_lK9LuV8xjIIjLPhEb1
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa8659c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rI5z_-19Wkz7aFiR6rMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: hOrlO-lALv9vW_lK9LuV8xjIIjLPhEb1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfXwnFLyNxpk8pT
 3oeokHrpVYcnAedjGPaHZeed+aIBEHGFXAehO2Q/loARyrHTrZESfnoenmWyMNWgwIgZhUZY1ii
 GMxVVaQkRbCp9y5DcHAssIko8+w5eCY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140305
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Test the dfmpyhh instruction.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/fpstuff.c | 57 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

