Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2616DCD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSGE-0004LQ-91; Tue, 02 Jun 2026 12:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFe-0004DT-7a
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:46:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFc-00013h-A7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:46:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652EDEJE3302641
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 16:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOKmFV9X6id2xOdU33l1JoJTU1UJ2bydrV7ScMIOQ10=; b=RGEa/yPNAdCzzO3S
 uIqq56f7lEUKRo1iURzRgyYDKmX/LYBx7Q0TVdSEWJAnQ7ARKW/oynb7MK2oq9cO
 K4hOy53nBaHo3bppCfoc1rYMCI9KTVtPl37E/9jXLnbX0T9fSeNeaZpEdZ/xQddz
 wuFceLaWJwi+0YJDCqTxuTVZYZnQMcC3WF52DcNDdvqCdL3PSH6WvQ6/7VIiQL+t
 DrphjIOATD/ZUyursTfyah+YG1ndu5jnkMZA9Iq3hQFsrdD0mCTdrvDBtNoRDj7G
 Dtrk1gwjyn5cyjEg+2w2uwTwqfakOBK4c08YWTo6XxjiTERZoW3vyuHxq+2zQAL6
 1c2A0A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu18j8rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 16:45:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137dd516985so4584634c88.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780418758; x=1781023558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VOKmFV9X6id2xOdU33l1JoJTU1UJ2bydrV7ScMIOQ10=;
 b=h20LPgSAA1hK/cSrHebkDN6cMlgh5YIwn2OzXuPLKSL+V3Gn1gKjCJ6dqDUd/5D4yA
 6axUMZVMzFydT1QROUcsPvtuvc4NFiDKjP7+N8uR6wqQdwKvbDfenTnxqbwaYaR9/cJc
 HNuof7MDsDm/y+6bVOC3XqBwu8Tym44e8CNLQDtexlhmA66MY/KR5a3R1maCGBY6g0LT
 yra0TlIOzXpqjl9h5uxdDQ/mcrdrS5QlHlhHSMbBGMKzxPLOR/wQOIMS8KXbGDf9PzLW
 hZ0bTlXSbT5qnYYGCSRbnE5EjqT1MGyy0U+UBkrn1g12f4ldH/1ZVfdXS1beCnDJWoce
 smkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780418758; x=1781023558;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOKmFV9X6id2xOdU33l1JoJTU1UJ2bydrV7ScMIOQ10=;
 b=F3UTy4M9ewsSZ+pFxBoxKB42ztiE3kLpa9cPSg7QqA9esU9nXJCW7zSxITqoNsL0tZ
 ll63zDJ+qLIKTpbPSiRYRJUPget39RGtaEp0zI96NVw7OCnkj8taGT1HCu3gAlNa4Qgu
 2OZVDnmNSRtHYaLWlnSm/NDfBGIr1b6kyGehWTbxFrdOcfFxgecgxOsh0uwVxNJvVQhh
 J4NDA0YNmG+GJfq4cMFjrhoQFZUIIx+Na0vErUvuVwQypgmS3+sekujwQm8muGTCCnVK
 9+3v5xKsmZuVm1Sma9rXjpqM54rdUp8Ddq96LZPf76g2fH9Xwvfj9jdJ/aCW61CfdWQq
 gm3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XbhDAINbUgM/oTxjUTcay2ax+MDuqYZhJ1WJMHcrdaOiXGASMg1jNUXXaMdh/us5BezsacW5Qj64l@nongnu.org
X-Gm-Message-State: AOJu0YycezgshjvR/aLmG3OFG/yO8vcFRiafOVXPcxKVNpFvDRd9wHjx
 eLYBUdYMQCBc/7fliPS5sz1MNs3O00CFdz3im3zCC9b859KI5ntBAStOIFcA71j9lXudVcNfG+b
 +QPLxvv9Wc3rF1L+Gy6Y4njay9hUYw7GPntSUWDeFoLr5WrTR15j+nEvKTg==
X-Gm-Gg: Acq92OE6sN44VFdrCS5rLRDzEU/OgIrRxYn6f14u7ss4CN7cx8TFX1miHUq5lD/ZaX2
 GSB7TQWWW1q8qkQKaMwVPGH0zLvRc2KYZRt6kGdhVHmeNod+QilJwugDP8R684P2yZtu78zW3gw
 uA3V2E1pVYafUTn919avL2qX+5on8VKZWsC2BkZdO7tDvvT6V9EqSxtlM/QfcP++oxbnByIDzo7
 xE6NBqezrn+he64kJrJiQ7/bR5IYkunyZ/zHBl3EaEixiXcufm+qjnWGG6A5JVeeGehnT1xq3X1
 J3paTvJD1bPs0Lh5apzEJa9cliTzpsJYPMqP0bI5mGoUOixyEvLvbA/t+hgE6nHL85ZHfxl2mOC
 kzAAlul5NhQNqxnJfwTSCXYFJFsApZ8R5GijoelWc+a8rp3FzBX899/23soLFjmoK9PwNTfHooo
 V4iA8PvvVQGBIVjxXcDqc+85gH
X-Received: by 2002:a05:7022:6ba4:b0:137:eac4:82e4 with SMTP id
 a92af1059eb24-137eac4897amr3490513c88.17.1780418757588; 
 Tue, 02 Jun 2026 09:45:57 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba4:b0:137:eac4:82e4 with SMTP id
 a92af1059eb24-137eac4897amr3490445c88.17.1780418756474; 
 Tue, 02 Jun 2026 09:45:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f556049csm156786c88.15.2026.06.02.09.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 09:45:56 -0700 (PDT)
Message-ID: <4aa3a806-4f3f-4e51-8999-b7efb529ce06@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 09:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lcitool: remove Cirrus CI support
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Warner Losh <imp@bsdimp.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-3-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602162457.828969-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a1f08c6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=x5SdGgq81RCrRPtamrUA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MSBTYWx0ZWRfX8w8tAyjkp74f
 NXns3HUvoTaVHL2gfvn0jWeX+IcRVQU2tuCJP760133Cimaq+SH7qupIz4MKtpiGeii8Z1D4MgV
 AauaGLs9ULNO0uxszICGVMMrBntbzrKjBsqoN+oRFyJwNxZOnWrnAZfftEsx45Z61JGtr9LaqAd
 9sL+VquYI5d1byufqli7LnQQ8Rv6W1Dpfw9wP4w4yy/TYcsqEoW9QCDiPDOAfl8se9xtnc9uXrc
 Lp85YPDhgvjFYhPLW7/vsYuVaKH7gySvRtEbwbb1+r2zeeGLZFc4PXoq6uAH/Ra7KA2vK/9pQ9n
 RlCyDTrDDVD5eqr2+VJVJWl1aqzApKpuevWQ0hPV+JzGArQLMxzVpLfin5Nb5NkFGMTwtPVr4JT
 lmrk87nAAoA6SDQRqqZE5e5LupwNP16H7Qf6teevuTqX6c2xbo1BfrjT/KMDwbFZp6b5bm2Upod
 cWuVwFMKxXVDCC4Xp9w==
X-Proofpoint-GUID: uf110TZ3yOLQbxoIs1gBuQkkRzz6KjUW
X-Proofpoint-ORIG-GUID: uf110TZ3yOLQbxoIs1gBuQkkRzz6KjUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020161
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

On 6/2/2026 9:24 AM, Stefan Hajnoczi wrote:
> Remove GitLab CI integration for Cirrus CI now that nothing uses it
> anymore.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .gitlab-ci.d/cirrus/README.rst     | 54 ------------------------------
>  docs/devel/testing/main.rst        |  4 +--
>  .gitlab-ci.d/base.yml              |  4 ---
>  .gitlab-ci.d/cirrus.yml            | 32 ------------------
>  .gitlab-ci.d/cirrus/build.yml      | 42 -----------------------
>  .gitlab-ci.d/qemu-project.yml      |  1 -
>  docs/devel/testing/ci-jobs.rst.inc |  6 ----
>  tests/lcitool/refresh              |  6 ----
>  8 files changed, 2 insertions(+), 147 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/README.rst
>  delete mode 100644 .gitlab-ci.d/cirrus.yml
>  delete mode 100644 .gitlab-ci.d/cirrus/build.yml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

