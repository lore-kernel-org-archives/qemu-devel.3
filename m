Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B685ECDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQE3-0005dd-CY; Wed, 24 Jun 2026 12:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQE2-0005dU-5S
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:13:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQE0-0005IQ-Es
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:13:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfGdO3293785
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AvU0NfU7xg0IHxweOiYJQnZCR1UE7WvtyOoqrqZNxNE=; b=k9fuFvFnHXNB+fMo
 /GqyXVEQURhZb8aRaW/Qxaet+zI58GSzCNaadPD69bDDqOzwntLtHDV37MersWdl
 Ldlj3GEVn19XkNuEDuTkZEqC0NSPQKBc60I1nb/HF0qoc8qIlbAygjCxGbTSpuY2
 S0pR2P1ueAjJa3qiNCTbhvj72PUQyWVQ0z2Wv8CR7IunojbY2Z74hm617bNaF+K5
 2B60kq4cFRUIxypZipRrN+LOlZwxe0sKzZ1WHnXK7L8Ip/kh90G9JlOW8l/lLsDb
 IdDpivbKmbcgBkj27hTdCna+CCg/XnvGSnnQd/T9Q/e9m06z2qNM9R9Fj2E+uuNA
 eGrORg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00evc14v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:13:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ba395b047so3366198eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782317592; x=1782922392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AvU0NfU7xg0IHxweOiYJQnZCR1UE7WvtyOoqrqZNxNE=;
 b=RWekxq3UC6ixMHUMFS/WBBJd7gXHLn/0fsKXRgNMAdwYEmSefHBx0N/FqnS8KAlWGB
 GX1vvJHhe0XerC5yWxnGA0jroDr6/x+UxWL9eHd4GoizRCf78kCkVoz1WFlovu/qzRWr
 mTPG85MPa+FOajMU4jamyCLVL8dooyJbG8NmNbSl+VitN/yWYOz+Hu20F50vMwRH7LIY
 GyZIkyUZyVDr8nmJFIIqmq1YC53siitIO/4qIDnH4fIGaS+tHwcMRV5Tg4JQ/hpVrNXe
 J7P5jVRifVwphdqPgbonSi9x16ADHCRtdEZSNi/ozYrQHgvINFlmJ7d5lNJ4RJgD6lm4
 qMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782317592; x=1782922392;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvU0NfU7xg0IHxweOiYJQnZCR1UE7WvtyOoqrqZNxNE=;
 b=k3G+WYoNbUky6JFb8haiZXz8W/+Ai18e59dP5h9M54rbWlMt1qBLqGHIJM5Wt2uoTp
 +EtaV8ElSpXc3gwoS33M7/jY4v1LTp0fs44YffshJ0rfUUBleiqN39Cg0pdtYHLt3xbd
 lAwPoh0UwQQ2XQnRRjSSfizH5YlDJcXh5p3jif1wtSK8M9SkkUNhw6hgxZ8j4kd4xPt7
 rqtx/v4m22mwYqpkfbtvS8slf9AO/Oj9n3U0XUq7BlIjL127lLjWiD56xWJPyNUNBTxG
 S+qykJxxfOjN3AYpMDjxpJGJWO79JNzSXMZzRTRup1jnj3fg9+km25FNcI3E5iJTUEvJ
 UIqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCNBkFW30uEDtB1zVIpjU0T98aqQ1EbQ/929ZUujnEpuaZ2+XVhQON5HvKiIvWfc/2IND5Z9dJ36kx@nongnu.org
X-Gm-Message-State: AOJu0Yyj/0SKjtT86rdgY/mEVf1pXU1adPSaAIkmE0EPmq5WdrrVmcdV
 NFy2g94hnqhmvFRPYNM4Z/YMJkfcNAG1JG6ONq1Cy19m8THoIwb83KHGaO/5pljAIo1EbK37wFT
 955GrO8ADdcTPH9a27HbTqvecoCSyRoErt1pD2TtHtsjX0Qfo5/XDxYmjsQ==
X-Gm-Gg: AfdE7ckIvrQ4d5chsFvkSfwh0GecOoHXxnpUG0R1lSJxLX3ODISenaGTdGfcd8049va
 3n08cf8vhQGdARRtl5qj4lro59CYHToKTgUePUV/SjaY7zMiZnRAd8Jo5B6RgyTAwlE9kl2JZHh
 Wb5ZBX5beHQ/lgHcg/QgkdRy/Er/92uLHYPDdvzmx7YZDb1BlSrIkbwqWKbhGb7gxMpEoi8twRV
 syCtdoRUltBtF6e95jRZTEM8H4SKZHRdRs2eBLt2RQDO8hOCpFoCVl6Jc33cNjsRIoxFRB6qtLT
 tT/p2J25dpYbn9q25dAJsceWc7BBXLhgVHukFZ+DCy6GHau/OQ8UfOHEQnjhwjtCj1P4+L+IEnU
 KF+AlNasvErnpM8VHq/VPeL6l8QQWgZl2T9PPadHwRr2b4PxM0I1qdk98SH7WH6TQbFMa+g+xN6
 OTldk=
X-Received: by 2002:a05:7300:f193:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-30c68dc9b9emr3331551eec.26.1782317591602; 
 Wed, 24 Jun 2026 09:13:11 -0700 (PDT)
X-Received: by 2002:a05:7300:f193:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-30c68dc9b9emr3331527eec.26.1782317591071; 
 Wed, 24 Jun 2026 09:13:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c570b7bsm267942eec.12.2026.06.24.09.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:13:10 -0700 (PDT)
Message-ID: <1db59fd5-f133-4ceb-9e24-3cd469d28967@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:13:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, stefanha@gmail.com, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzNiBTYWx0ZWRfX7eY49yQtckqZ
 jL4iFZDyqdFORuxljABkAG+As0IPQvNxxm0jGo/qb0qP86/yU1RWnxncl8NQvS6VdGedmrhc7CS
 PmfXuzZ8EDrGChSl1tNVmDB23zC3Oww=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3c0218 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bFnqaKyOiJoSggZbIzgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzNiBTYWx0ZWRfXy0i+Sw6xdEVz
 e5K7ZIdq9kS+zoL/qeJ+uWkQh4gRnHjID6+gJ4KD1ZvvVgPUhAN5I9kuDg5vnX2Od85ct9GF0it
 yzj5Ud7FNGtTNG/2dunMoB5A3sTeHFqri++kvE+O+S28ClXRZREjntFAn9bb4tbCfnAdVw4VMlf
 wxrlc7DhcetOqjAiLsQot5MzK4YjitWbWGZtPVYUyT3ZGeWJOUn4u9y4Hdug9Ad6OfWbFA7b2vn
 BHQkaZ33eFN+ColQpzm3cRapxr2Alpe7AsArFbi86VKxdGESiqZj+Lvzpt8TljuGX3AUKuX22E5
 3Ikodu32EtzSnPSRD1yJJ0/C2nCQU9oD1+u+Bdn8cSHtn+8SdZxjqOc0x5c67CpEUmU8JLo0tAF
 c+VzPrlEIuBSiOAEuJcpFT5znyOnpA==
X-Proofpoint-ORIG-GUID: CNqBHvbTCIbJCCHIhdDGjho8F9DWPyIV
X-Proofpoint-GUID: CNqBHvbTCIbJCCHIhdDGjho8F9DWPyIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240136
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

On 6/23/2026 10:48 PM, Brian Cain wrote:
> The hexagon idef-parser requires flex and bison as host build
> tools.  Add them to the emsdk-wasm64-cross container image so that
> wasm64 builds including hexagon-softmmu can find them.
> 
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

