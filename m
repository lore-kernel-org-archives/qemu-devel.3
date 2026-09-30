Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96587CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxRm-0000UK-O3; Wed, 30 Sep 2026 12:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxRM-0000Nr-DR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxRK-0002zb-RW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:45:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE07FB705156
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T5pYXiGD82UPAYmmoPeqo+sm0YWEVcDeOy/IdoIzlpo=; b=XsAJvpHH34PiT8tN
 jkGyCvzyhlN8wuJ+JH5Q6UDUtCFQrG0aM7hcvU74W8UGPal5GNSBVNe2YaYO2JK6
 O0Hgi5kVOVKUokQT6YJJfVHXmPjp19q9pFryBNEW69EyhoEnmh3DsagoV09TA70F
 NfEGRXV5FwU8WTePYVboLTa1H7vBBOrj1Pw+Yq1br0UyhpYzr+RIY7c6ZXXADEJB
 v2q9IiD5QdJ4iMfPRYgfKdwN8ABknbm3rtorjHqr0sGv+CrGbrNEEok0CXI+pfZU
 due0tTUIv4ISzWtlK4SAT0HpH7uoL1THCPl//cRdYB3fSICyHbxYTGebJ7sraaYp
 IvshmA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tgwkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:45:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936708f129aso1130594285a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786752; x=1791391552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T5pYXiGD82UPAYmmoPeqo+sm0YWEVcDeOy/IdoIzlpo=;
 b=Wkx2eVHHx08vTLFIdJhP3y6P9+j8xAgNSUWBx4WfaxC5LI17w8J5KZHFFLTXuhzB5m
 inWgWd9ph6VsQ6PzTFKzcMk9Ed/tnyzzSvHlmAyfIrodj3CeF9H4xJOScPYKu8LOyPy6
 H/ZSncxYnrfM91+hLF+0UIXNlRa5T3MSzI+WmoS7glteSYbEj/vFck5YZXgC7eQTyMrD
 D1nmYrl61FK8pLxmokbBJ2COgTP/hz8I/zYRjETx3kX95LhAMw13nprwIqXx/MALI2ik
 eJ9NftboPNeG+jZxsSz5gOWNsfRVxW6WCb68dWwsE4dq7OZranBGJuMUfrlYGDiM9Bfl
 DbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786752; x=1791391552;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T5pYXiGD82UPAYmmoPeqo+sm0YWEVcDeOy/IdoIzlpo=;
 b=JKRSIAW/Q1HThEgz8fwdPiKGtsa+DDaeJoerEGaV4Q0TA/Wx8W5h3nd+cCpl4e56Zw
 qqGOUzF/DfZgsTWSXI3pqTrjLEKyTwj4ohMDiDueeqhHPauwIs2YYK3LzouLkGgfxCwu
 O1xogcH9WJn7uKT7i4m9Q7/QFj8HtL6LrV+LAzPqdLdN5x2vnPbKjLT6w91msbRsT9+o
 UkWWLrfvwDMMk8gQFftbLJzgx2tesT7MKj8VKIypwpokGX66ZHJlHjymENFUTg8uDaq3
 s3GotuFswX6J4rlZ0VQJ+Puh8s+/4YXDwgNeKe+N7xvYzqsyUBJZmpo+Bue2Ok4tvGuX
 DnOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylw4mdHr6JTO9kCUiyZCY4cvwC1ZsiNHbf8Xp+Bd/a7JXgLgCdeHQv95ij16o0hCmOLUg/8j28RrYh@nongnu.org
X-Gm-Message-State: AFuF++neaWws4KXw3JvOzlrN7vkszdZJ0JN2zjX55RywdFdM55KvUkMw
 65OlXczMZm4AyrM9T0SCphC3/YLMh75XFdjfb6GnY+A7kvte3aycirF7WOJk0EHPg8y2uUkLIsS
 nSvW7pdHqTbKQdOB/V9zhJXMw9xKlT9r7PfIKyBb2YeA/OQDN+1l4lwQaBA==
X-Gm-Gg: AYBFou02ixLg4Y08cRAPmi7QSxGbTb3HphDlrGFqwfssiqr/xmjAHxy/VgsQK1YHw3B
 X4ij0Psr6JVRKCezIeUSdxs/oEa7S/sKaeflEQ/iP3z//kommVbyQlr7nFBhqJALpgFS4QtC8M4
 W2gMnz3LrvDo4cEV7L5n2lwWfelPWpDhsAzG60dukdJOlOqigx8UzwvvNxyl9+DGBVJTJuYJlLm
 9jfti+q3RwgEeqm12UfdvQF73JnLehSWIwXP6Apua8j+0xV4xDhoo/CoYCyv9zV2+XfQ+sMdi7I
 ypczVVH4TyOeppVENmNj3+aBsApnGpodc+8Qrq4WNedTMLeLHX6Cgs70dX2qPcJji1RV2y+qdmf
 ZYmqY2UVpRDbX7+GBels=
X-Received: by 2002:a05:620a:470e:b0:93b:cb6d:6d73 with SMTP id
 af79cd13be357-93cac149674mr304818985a.32.1790786752314; 
 Wed, 30 Sep 2026 09:45:52 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:93b:cb6d:6d73 with SMTP id
 af79cd13be357-93cac149674mr304811985a.32.1790786751707; 
 Wed, 30 Sep 2026 09:45:51 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb5de74sm4053895e9.3.2026.09.30.09.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:45:50 -0700 (PDT)
Message-ID: <3b7525d0-634b-4b8f-94d9-b33086dd2830@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] hw/usb/dev-smartcard-reader: zero bChainParameter
 in DataBlock responses
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-20-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-20-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfXyPwwlFZZn5LO
 H2s8laeOjTz3y/vidQtN48xI2UETrrRInfoaZJfs9k1kr58wnhcSNEhorZCNmvaJkZuEFjepQ1g
 zVJXhbeScZfK3rkjnI+rEq6JBOOL2tE=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd3cc1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=MMTYLR3RXaHeQL1zJH4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: mf0wRr2a9QERCTfq88P-KiRJBnzRJ_rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX/c155zjR/15V
 QoQJjbTfiZa7hrEkIrOkP+694MMs6EGXO3d0Uhs5G+ggNm03i8W2rUQYVC0MbHN5Xtz1Hw/ECOE
 9VVaXWU3d+m5uAPJgkFE3JaA4J56beWbeFiOx50VM1CPqI1+GFoJBeMJN+pJX8GgcpleeKzsYJr
 137Vi5ibdfC+y+lGnAfFb9v6NSE0BOcxpf9IsH5cfesbLuWwhUl0bk+Fkexz21wexJLL6AEk3zJ
 E8HxuF9JZZYeM19nNDxni6ZQiwpgiOpAXGmNpYyNIHKgkdM8N/v3EVFdq7AUBsTGE1C+PRGndgr
 dM58EiGSZ8oyyLyMUprHZhA3Y59NM4CqFtrioc+kijzC/jGkWKwW8Sbtkm/B3Sb7YIzFjIpvVNw
 VX/SkPFiC/BLKz2jreEQzL0EjehusyQDhrKm1xV4SdiA6WZNCSq63uwmxMDzLW+a5wdvJh7ZFuY
 oAQs3Sft3vcRTR6UiGA==
X-Proofpoint-GUID: mf0wRr2a9QERCTfq88P-KiRJBnzRJ_rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> ccid_write_data_block() initializes every CCID_DataBlock field except
> bChainParameter. Since bulk-in buffers are reused without zeroing, a
> stale non-zero value can make the guest CCID driver misinterpret a
> complete response as chained.
> 
> This device never chains responses, so set bChainParameter to 00h as
> required by CCID Rev 1.1 section 6.2.1 for TPDU-level exchange.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

