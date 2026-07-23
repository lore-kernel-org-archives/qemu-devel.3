Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BC2C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmog2-00065h-RZ; Thu, 23 Jul 2026 04:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmog1-000622-Eb
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:21:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmofz-0005cP-Vw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:21:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BakI3257134
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ofIop53K3VT3TxxsVXHmuEE8xYN36++fuLPmfDUtDz4=; b=fsU4xNT1BxE4YRmZ
 kMaWj9hnrh6UNu8WB8s8fcZ8Pu0pLRBHd3/rkCGbast6r5SEVPaqHaYJHXLXZsjS
 C4OUFuQWs1vaxvsl0LFz25KqBVGDHfo0exmmRkYdqa9Q4TIN9hiCeeqparLKbBW7
 AG6GZY1H4PS8oFQKVj7u6VSAGaRB6Y1bBj5OfGl9YJs2NXE3hS33oo/D+amfonjk
 uI05uVe62EBxbvq6LX3oKWFe1A4S8+A/cv6/XWzNqAIQWSFT+UplyuM1XodcJOzH
 ybqNwrAj5j97Ip1LId5+F7lrXJ0z83zNDGxf3VAxEFw8eh/Rgk2OHqiIGe1aPJLx
 Umh9Jw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vk4b9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:21:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ac0a54110so81786485a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784794866; x=1785399666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ofIop53K3VT3TxxsVXHmuEE8xYN36++fuLPmfDUtDz4=;
 b=RhmwsyNKFci1+sQqN3gYHAwLqHz6U6LWQ3GfG5cAL5YPz+u5v3DUYSoURVQoC+q9yB
 84FCJdCav/PCGmqec6nLAiRRZP0kdcpMhmNmaqWrTKbK5Ef5BPJzd9IE6CeH8hEwtpaT
 zCQaGWOJrqjKqfkYPffOB1wXsdGcdHT+Qgoggf9xamRQLPIW6wzUlXf9L8r2H69+cl9l
 O2BPaMTElWSP01vshfPkI1ZU0+/dKFQf83yvnnE6UONy1SAi4m9ME6pGKvg3RirYSbiY
 vTvst50Opog6hbWYXY3MFtlTL3jwfR3QaXT+ATps3+xybOP1uOTBQuOcF8CwAzWAtDlc
 WIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784794866; x=1785399666;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ofIop53K3VT3TxxsVXHmuEE8xYN36++fuLPmfDUtDz4=;
 b=edmAuNA9vA60fqAJ6bvYi34d68fvtUpn8EZDJ/B4tu3bw5jbBj5ABSLXafjWGF7Pgs
 TkjhDiX0QI1M1xf1rrzmCCMiqnUdEC/0Bpbj6pcDnmsEKSRAIUFbX/91anrxYtSvNviu
 5ZYHarOdKRh9SE8Y+IEVBMqWtgcAkAj8BsOaI6kxYlC+JIzeejrMeAehS0GteVoM4cZV
 AZ79tXNbCSFkqqvEtMvvk+Zow6Gxz4vRMpRkE9pbKUb8xACh+yUIUjkdNlmtnDsZ8IJ1
 vyOcsUZgKKRzy1wPAEQZxq2tZau1C/FdWPfCzJD/rn46F+1zsaa6Tu8tYi9hcZLOX7Gn
 DlUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4rEkEjpjAtwuJ/KVAqXuw8brzxbBNJ7UO0d+xBm5XCi0qxQ13Aypa+1Gr562cw2FjUFFrOIQSoZIx@nongnu.org
X-Gm-Message-State: AOJu0YyLYTEYAW7F4iaiQv1NmTOlwxf5toNLaEUlm1SD8Nt8E1nKKSfL
 DAi8aRv8z9fXsaulK/xoqfw+G/aWs8N6fSrx3R0aE/m1q9bTglJzaP/+AKfEv6h34+gIgPctHgg
 ItXtvLj3hJU5ly9r6UsQM5a9+A0LLwnVm4+NhxiwMDrSSeCf40LbwYACWwg==
X-Gm-Gg: AR+sD12Cs/pvqi8n2Zf0zcFg1wiC9JnpVbF0TQaJ+KcUfqiec7LXkUxZGNYypLY+oF4
 vNcHxUGH4D7NYr3Mx/igLNXnZ1KKlHL91E9G33W5qE6CSD02UUVVrd8GgsO8BT433jAJTtoKnx1
 DQiF7+zTAP3+mgvQtbVoyfsrNuL1CC8YB+yJKKeUZ31iz0+OYwxp2bHimN3/pIZ/pPlfPEGBMgC
 7WHqURTNGJj2QgKu3D19Krqwf0k7Vzn9NpCnGdF+betE4/qbJ61KJcWeVW7y4JJwYF3WZTVPJD9
 iZuzVuaeS+OWbix04jXvAXrxicOKrYlh9FIW4yqVlDsTH157ajmrALoQKX/H0In9sON/KkIE2Xw
 KCJ0Of6jg8+g8SfCQBDh0asJP9sYBCNI0Gn9FZ2buGwQE9du/+Gk=
X-Received: by 2002:ac8:7e94:0:b0:51c:52a:8e70 with SMTP id
 d75a77b69052e-5283dda8cf9mr17565511cf.2.1784794865762; 
 Thu, 23 Jul 2026 01:21:05 -0700 (PDT)
X-Received: by 2002:ac8:7e94:0:b0:51c:52a:8e70 with SMTP id
 d75a77b69052e-5283dda8cf9mr17565231cf.2.1784794865239; 
 Thu, 23 Jul 2026 01:21:05 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm14297331f8f.7.2026.07.23.01.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:21:04 -0700 (PDT)
Message-ID: <4dfaed4c-60bc-425e-aba6-76451f9abfd4@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/net/can/flexcan: Fix mailbox reset mask
 initialization
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MiBTYWx0ZWRfX2zOSQ9CzK9PJ
 tGDEOdXjSBiygfRIIAcs6uP8l6yWykCXsNDUcYofMYFMTcemySxnmFwI0JZRg4+zeFZhI7BLG18
 65Pyzl4/yVvLeYVaLmTiNsOhfK/h3Ic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MiBTYWx0ZWRfXzHCP62dUZhbr
 ZR2SWxQ1c1gM67nPCjjFYh7qagAAadsjjNFV8mp7twffgImrI1Tf5GggyRh4/ptgDmjOOALrohv
 rCu6fiL83OfeooW6WEAqlUb+IeBLIWTWfwo0ZMN3WPC5SCjIYJ+5adiMtcKPUf4ObVwusuVNR8U
 36LKGNgzIgys1PewE0rBqYH1THQ596Qn8LHMI9liyoyEPmbQA/KStY4XeLB/ri5E1QK3XrR+kkL
 C/sIPepKMD8WuJR5Q5gvpBCq6m+lN8+bIYN4PrHQjGw/oMzTveE79f+bD8ANUVJjr7CPcuIvGw5
 8zVC0e3CCKqEU8Dp9cgnpzthVQ1qXyq7/x7HZwtoRyS56kiHAppt8SoH0ZuLSv3/7lS3hLskrOc
 a0443Tm0yG0Al1axyFtbWXiWX7C3gfAefwiotqxuprF+tweCYYJLipl2AMfFCXWMG3XKqOheuLG
 C/Ovqh59p9rrhFqGzaw==
X-Proofpoint-ORIG-GUID: kVJPjppeoZe-cZ7_7oiBBwVux_OTcPpn
X-Proofpoint-GUID: kVJPjppeoZe-cZ7_7oiBBwVux_OTcPpn
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a61cef2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> The mailbox reset mask initialized only the first word of the raw `mb[]`
> array. Fix the initialization to cover the whole mailbox, as indicated
> in the field description in the header. While at it, use the `mbs[]`
> view instead in order to drop the redundant and oversized `mb[]` view in
> the next commit.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/net/can/flexcan.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

