Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F468606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JJSDB7CU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ju4E67NQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAYK-0001yO-Cr; Wed, 28 Oct 2026 16:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAYI-0001xk-9v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:47:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAYG-0005JE-OK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:47:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPNA41898351
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AYMeulMkCmzs922Q+TBa/0IqF3dNps1kulv2tWpwqSo=; b=JJSDB7CUb91KFqlM
 CjHY9/GICUws1U+17MJdKjxNKt4mUgaBhthnZ8p+5lfc96SsJ+hU4oQxvevc0jNH
 ZYJjof1Scr1oYji6yMlk6R1J0eifhy50NCcSgeYhrjcHoBpP3LD4fXg5RmjFqWs9
 V+mGrlQ6jEhz8M/zJ8lsUkG6Y/pzzs6bO1saUzdtqxEuVrOvL52vT1/QHpz8c9T/
 8meoRE047+yGwZ4opJad1UJnMfRUTUN9WBcDRX5+OM/Iw9l2+weYtCNjj8BBliQx
 XXTcVXbk1b7iTprSWkWwuNHjtoniOb22Wwi/n/5FHGUMnghgIyqjJbCPCQPSSQDD
 /YFyjQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehjfkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:47:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36998507c13so2071705eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220434; x=1793825234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AYMeulMkCmzs922Q+TBa/0IqF3dNps1kulv2tWpwqSo=;
 b=ju4E67NQqgIR5AGdOvrXCdCMq+BdReTkZ/HpY+XT5DHHr8UyKrafj30ZBy58zVWITF
 Gh7tTdsMrDNga0nXYDu6k+agpcY05/yBpSpjwGEnEVal95dT25ApzRAgvW6YveNLHUxk
 oUzore1UkeQpI0Ted8tAS568mG3MeUHHM9M+7PfdOdiBdGpE2feCY7DYqVMINWHtlRL8
 on6s2ocpMNXyNUVSp0EpPWc/L5X56E6EHG6ETmZB17WSCJaOVkyxx9Ph8EQc9IbY/osG
 nYGYMXUhIjcEa50cfMjDnROUJolVILpJJ8fVA4FvUYLwn+XMUtqDDTC7r/rif9tFeat+
 QWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220434; x=1793825234;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYMeulMkCmzs922Q+TBa/0IqF3dNps1kulv2tWpwqSo=;
 b=Id/bs2VnHDp25rkWTGtobS5eeXwKrG2cMFJfJa/pTqbWD6W0a/g4gI+m3tJdplh0eU
 0Bpb44acFTG3huOleZb2Wf6EI1r17yTx4e+ZiBKa3pCwsBSnfOzL3j395lwABce2UD54
 6GpocXUk3dGGEFfAMqbzecp6AUICtwrgl7YZIRwh/LEedKXi6ANrtF7zU1LulE3GwLSL
 6ae08bNFiozjXhntuUhNSx/S7uZx9hqzHUcH/ub8VWB0Hat0MD2w2Tn++nlXfNw98S1h
 8LAhicrz+dX7v1wW4tmI4XAcONTy+mlAd3Tu9trrg+oUk5Ta6to5N6/Q2EOevUzr7JmS
 GWnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLbaAocVFOJaGm0mKxUypoIGN46440xykk21x6hoZ4gwDb/yYGzFyNxF8iYRwkjbOIVXldRW7AA9cm@nongnu.org
X-Gm-Message-State: AFq9FYJtgg+Tmd4SMa18Zp8BVuNzUyJB8uX9FdELZVmvofdSSLfpiUpq
 6vieQ13YDVDXWpxIj+Ev1cVJo/W1QorKUrGXYHPvgWr8L6hkKqN/tHZRqQHLnc1NFOZN/SfyZQP
 ufw5S3o4KfqMAqdKyKEz58UbJSWkbWiW0fcTZXLc6Fu9ssVEbPDLsTrlkLQ==
X-Gm-Gg: AYBFou2e1jwT0Sn5iRU6y7IqKZZHFQ98WRs0ZdM1zJdTmyERGccOBCTlgZsoK7lkkof
 Id3GopgNy6K2nHICpYM09Ie/pf20NMxAFXBRLRaJJtuVpfy4be/6m7LbK+eEKUhcC3D2kNIoQ0u
 XbjF5+nozjkHh6JV8MZtY5NTBgM8LdhmPAfHuCYVkCk/yaFXdG7abaNdSia8gukLzDFA1BSe2cP
 dNUr/5db5RNBb+1hfvAisdzcxfC8Xmo+HGSOQV21SX7NrK14tExQ1w5pY/n8oyFF1wpsfgxtsAF
 gziyCOOOArTxvK4eWcohVW9LH5K85wGIUS3Xo9vz0ShWmBVatLxXtiU9KrjCAQn6xzmpe+sYziy
 03M1i5UzaWAQ64I5AZLYaFtA7OtlWVhwXMns3Y0Cf6ZNuhUMq+7ORv5b54pwpNQBwNgzfVqNQk5
 VCcLJK2PkzX7sLbcU2IAHSfQXT8YGazbBpFk/UpB7H210=
X-Received: by 2002:a05:701a:c945:b0:192:fd91:c569 with SMTP id
 a92af1059eb24-1a6ce01d383mr3885010c88.11.1793220434478; 
 Wed, 28 Oct 2026 13:47:14 -0700 (PDT)
X-Received: by 2002:a05:701a:c945:b0:192:fd91:c569 with SMTP id
 a92af1059eb24-1a6ce01d383mr3884972c88.11.1793220433718; 
 Wed, 28 Oct 2026 13:47:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814917sm8055903c88.5.2026.10.28.13.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:47:13 -0700 (PDT)
Message-ID: <1c0c84bd-d148-41eb-9085-6fc4f89f543f@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:47:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] target-info: add target_loongarch()
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXya3JFas+WX4y
 SfXT+LRvkrGwE9H06xcly+ZDID3Yj/3HNwDJ6biA6uJVYhTSFbFAflih5FjZLXTfk8/Uw8yuUfQ
 +rkQv+eZY8j04v+1z1HLjOSizVw/WLqwAnq8iH6pZ0hygSor74rzoBu6JrGq2GpGTlkagY5ZsV7
 UqFIYz0uLkGrRMssi4Yhc9StiAwVzxDc8xdgBDgj+xbY+smfxC78jeBNBpnlpMZ30wafPw/OA4Q
 MDZ2JjdixbxGOHxYUe7fea+mISFTzH4KP94yLwraX83s+mR7g5PoPeYjI2VMmrrqcs0uU1EkP9k
 gJtf6nOKE2Bq4/vcg6pckqnUzyIXxdMM7Oh+HO/ghfRS6zGGuPMQdxJkBKE0Sy6MDWsxXtAOrH1
 lA/4qe44DPrl11sHxIVSirMkVfbS+NYInuCDUfV7uqPocIwywG9IfL1lH4R+QjcFv2w3cnS9M+b
 8+x65Onv32sHSdaf9FQ==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae25f53 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CDSh6yXX78Sf7shxXIQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: SBSKeBUcZdwkTsSUuSYZm_4F19atv9qb
X-Proofpoint-GUID: SBSKeBUcZdwkTsSUuSYZm_4F19atv9qb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX9n5XkUsUqJ96
 UrGKji6rRU4yz0AkEw6NnONFN1G7X37n/Rw5ULIp9HbzSK9G0Z9IvdlzJiDTLPoHQpkfeOSWN1J
 HhD8i9JHjpmBAHCWPjc3+2HQ3MpQUlA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> Report whether the selected target architecture is LoongArch.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info.h | 7 +++++++
>  target-info.c              | 5 +++++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

