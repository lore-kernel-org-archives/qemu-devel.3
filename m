Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B972CC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc6x-0008UM-Ct; Sun, 16 Aug 2026 10:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc6v-0008U9-Py
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:45:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc6t-0000JV-Ox
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:45:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlHDa3215103
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Iva9Cp2rWOiA77mHuy0m8Je9DaFdGXz2U94IouBV12k=; b=DhRtOux7NlES02Z1
 dnDB/yWvv16TySJei7pz5H1WKmkGZpdAYm5F6PElk9j80GjwXYcVEZElJGEXjwCY
 R1/duUFSRPrF7cWWUt29o93T7Xg4nWLcUlpzOhYY8IZk7mKyC6SRL2tBjDicJJa2
 1oCFoLW7/utho/leocmHittQ6Kud3PRSOhV+JVwSIFnJN5CN3zK+EOfNQb0/SCzS
 khJ5Qb5Vi2ulcjZEU7cekEuoIfooLi1nYJp6ODQ+MjNGcnPg56sqsuTrnwRwrAhL
 a91V/rKGeyf5K+VkaKUrxEElpadDZ6tKaLtYi9qGFrXNQ9jrhri7uSmONrMZE8pJ
 JZ29Gw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbn2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:45:13 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9077b4c35c5so46571406d6.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891513; x=1787496313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iva9Cp2rWOiA77mHuy0m8Je9DaFdGXz2U94IouBV12k=;
 b=Erfc0EwsdKjXqHBD+5j5mFmk/rGqThXwYwTMIqeHcNNfyHh9ZxZ1zGQHJsSf2y2va1
 EmpEs2Eg3pOWTpJP/PfePk7CcxhwMbLLeTdtriUuEc9ebO/LW7Aj/texTAuR1hmGW6U6
 UKvcAVQRFD86BcQHFN50wUOuoOVdj0OBqexVTH1prhLTysQ/YTJTqaEfAXIyp63gXtnU
 Gy9qHb6bQo1zx23T3XnqoF5FZk0sJLMn5XABllfcQRwRQqabO49FpcKoO8QyITZeeW6Y
 qaX5n+DgO1dBMEtvoDLdZeS6yeMC6nWdlkwtZH4J2li0UyrqLRWna+jznvTouH/A5uLQ
 88Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891513; x=1787496313;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iva9Cp2rWOiA77mHuy0m8Je9DaFdGXz2U94IouBV12k=;
 b=VCnUqyYmHTbUf0lI8fUUxsm8ibhxe/EJr9oo9BUbvJHVt/QfYHdu516+S2VkLUehd0
 ib8ouq6WO2qumfhmkGLcQA4nixM8bT0mrZxoIMOL/WbGh0SnQjy7cfEaOge6miXz9A+O
 GOprCiQcnlAM5OtMAXa6nPmNiu3wkk0Jc/swgK8gn9/meMJdbhoyFFVcCB8WnRDUPINL
 XRPCM3PPktl8kWoWz0zsMn+87FKg3rnd8OxKX+gLN8Uvqn/d/RBB9mJ0L7uPK6PW1cag
 p8/pPUcZU2Xv2tE0QJEx5feKl19CDx4qc7H42U4qxkSXPIXpw5MEb4xBgF81XVt+DNME
 2dVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPFdEnkH9g3+4qljJjgqzoiviUDQzhAw7vaA9+kF6O0AqRz3rk3C0VXZTu8Fyiv6idwngp1QNOt5mQ@nongnu.org
X-Gm-Message-State: AOJu0YwmhQNT4NxjaN0On5uEa2fh9SBf7UzCnfGhB13Mo+a9aKE1I9JF
 K3TT8osar92/pw9Busj/gBbuVAsTv0FzdSVq01lphW607FA8CbwHHO5XpZbzSROjepNgc8Hzktr
 e4eMZjktpRiO7OCAknkHz1WHyWF6VJP5tHyI4S+BGJgY268wZGyWCL8Qffw==
X-Gm-Gg: AR+sD13bKwRz2gX/en/1qrL6Vvz2SFsuRrr7Ix18Oi7/bXGE0KhxEnQMRy/gAnN572a
 YeodBdyexAEdkS0/if0fF1Q9eqsMgIa7KRSENOXQcfPDWvTdzzXzHMFM1dg4h+CgX7L35u8uMKb
 zJk28xqTESDHBZLjuYvu+MQ51w8/5m6JfTXLqrsy685F8GJaUtOOPedoeVlFrRm4Ft8y1o7Ttms
 pnZxyU6CyJbc6M6eiCyxw16ULrT8Z7rebch66AZChuW5tCT87nsDZt1586mYbBKNIp1N8D44kn3
 zU7j+Ks3XvJjtbXmk061AGLFa2JL+hxXaT6aM0ymRC18U8Boqtks7r398t/L2yCTxc3d0Geve+2
 3qMNW2UBUcy2696TD541bYxnggOmSSxhaxWY=
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr233954221cf.18.1786891513160; 
 Sun, 16 Aug 2026 07:45:13 -0700 (PDT)
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr233953571cf.18.1786891512843; 
 Sun, 16 Aug 2026 07:45:12 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm125989005e9.13.2026.08.16.07.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:45:12 -0700 (PDT)
Message-ID: <763011b2-d6cf-4220-892b-c7ed22c483b4@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/core/machine: Move EHCI migration compat properties
 to 11.1
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfX4mYvwrJp78bM
 hOmLBhWJTjy1HbcQkk8ffAFSFIEXTFjObaGOyGKPWwXZIT61NmAYpYbGosa6lP2+s5MbdmUg7xk
 l81/+ZUKkNSZ4D7kSkx/VwO92VoQWHM=
X-Proofpoint-ORIG-GUID: o_ULyWnDufOfI6cNuD-_BNrE7LIheP_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfX/pq3UAWMf6wj
 1444cdJkoKRzrUMN8mOYjsqOEwopPGbVsBMa+TzTu776W0+OiUoLUo7A/8JjfypxTEGQa39QXe+
 9h3tWCmIs1y7OzEkUcU3MWjJfLY5Ox4E/KB1Hi8oFmv3/aYymOWoY7WWyAeBUJ8aGGATMmZN5jG
 74LueGB9WnAFa50XcmqULghsP/LWdNAIeLiTIyg8X4DPwsBelyXr/4SknztrJO9C7m0x/583zIM
 zt4tvv2o3oul/68akqv/IUmfgsoHn5Q9li7LB8ZFFucCJp1v5mAR4dOMvrprPjxUGh7/w3UqYZ0
 0/PfHOHgkcpw0v2l1MmfEaaRH+ZHUEbPSjpFLSTjikzj8mPay7R/E2jYsNeO3VucvPNJl8VajJS
 uPa5ZZKVgfNTTVUJucsxaeZLSBCtwokpkFa/qT9O6bQ/MD2dky9ej2j21suuueGoGzXG5F4KQBL
 w+zAoKjZPUrHWLbdyZQ==
X-Proofpoint-GUID: o_ULyWnDufOfI6cNuD-_BNrE7LIheP_m
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a81ccf9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2NxCb60AAAA:8 a=PAnQMx6uU0io_VPjrswA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160117
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

On 14/8/26 05:26, Jamin Lin wrote:
> The x-migrate-fetch-addr-64bit compatibility properties for
> sysbus-ehci-usb and pci-ehci-usb were reviewed before the QEMU 11.1
> release and were therefore initially added to hw_compat_11_0.
> 
> However, the EHCI migration change was merged after the QEMU 11.1
> release. As a result, these compatibility properties belong in
> hw_compat_11_1 rather than hw_compat_11_0.
> 
> Move both properties to hw_compat_11_1 so that migration compatibility
> is associated with the correct machine version.
> 
> Fixes: 38ed803aebb2 ("usb/hcd-ehci: Change descriptor addresses to 64-bit with migration compatibility")
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/core/machine.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Queued, thanks.

