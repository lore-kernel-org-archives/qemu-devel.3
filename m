Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6682C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkIC2-0005XW-W8; Thu, 16 Jul 2026 05:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wkIC1-0005W3-F4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:15:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wkIBz-0005P2-Oi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:15:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7DU4n1994824
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +PgtuMJ651yFnS8milX9w/QPFeXR8tdPgpwmRBqUQKg=; b=KLvoksG338cZDcw8
 hsIUsvPG/4Yd0K0VK+FZBMO3sl06+HXfYqIDpp8H3OLhDpcFhvpVeCJ73RIh73lx
 Sb/3FNvrd5KGMz0179ljHmpyIxM4a8AscI8QgUGW0aZD7GAD2cH8Ufxbnf/qhesl
 K641llXfSvIrk0teDmZB775Y5MfAXdeoI79L5LZzDEik/D8J54i/yJKiFhltlyJ0
 dIffMcoc2lfnJw14vCbmAU2MzeYsVWYL/5+oZM3SoSsStfqvTe9epaRBgJ7XvjxT
 YyTIv6L4b4ftffgYhhmZCK3LJinR4ogmMwYamLyk0kvkLuvAA5aKxBIdhvYCtxl+
 MxCE0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqjya1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:15:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517e054fe07so133626661cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784193340; x=1784798140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PgtuMJ651yFnS8milX9w/QPFeXR8tdPgpwmRBqUQKg=;
 b=G02Pw+J++IiwveBnt0KR1xoPxLplTTxSRznKaV76IeNcsMH3zrmxReBt9BmnCLP1fV
 6sEYb26J23VQokIVyqN9sqim91bVEr8AcA5YloTcoyMF9/eO2HOhFYKHsMgoEQKNxsJk
 cjwa+/okhE/r/Ucwt4XBa/WgnQBGIXViFMr02/6yW0CwCTDYHeTFF+rQWCQX1QgPGkwN
 KxfB6IQoHghEDwn8/jC/J59Pw1Xprh3VC7QfWQau9jwEGxlioQ/b06aNSFn3ByQx+Hrt
 kqL0iQApY5exvV/IsXvwrjskfMPWIVR5FfwyMUjjRHrbE77NCXnrH+ni8g+Ex0Y5cpxf
 n/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784193340; x=1784798140;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PgtuMJ651yFnS8milX9w/QPFeXR8tdPgpwmRBqUQKg=;
 b=RnhsQRutmJaYKRC7ZYS2bbZxFmzH2NKaMpdK4DUKodsokc+M6QUSRvemZX0+5IqjTO
 A85Vc3g3JFQAEhTC5qGN4dOSAuTRlrPnBHu6H12WSBpTUnhJPjkRGd0cw4pJKdsixIBV
 jYwyVK8Z4TyDbQjHBj7dTpqBCrOJfAfUUj7cakOf73cOZ6+ATVP0qAxygng3yDGtvCsL
 Q98llvDL6nw0U42LFTzT8mAvqX+at1t44bfpAl0P3a8br6Ke2C9Aun07JBTUiRBJymD0
 IGR1xw3jh4pib327eUMHxGgyUSQCRJUCP29JJi9cbzMKL0BGiI+YsbWOPzPh+bDTIVOu
 079g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvRH6Uv4BFF1rpJ8/CAP+LwrHkEOJlXeKYlhHcFBWP2HNsBQYFWmuV+vDpO1rWmxGmVeqz4bOM0Nl4@nongnu.org
X-Gm-Message-State: AOJu0Yy71ehYMXQKMk9fi5uUAC5EVbrVbLdeQwQVEWdbZa/3Cek60R4y
 IKGwJGEQNVcncmsFs4rb7dXZY42+2TKcdHrNh+ofXAX1jPLlgg6+JMfU4anbl+zDuu4cX4HCoyC
 AH1IHs20rAbePG/BE4o8ERchQUp0fJmja/L7ocJc8yhWQALxUNosJvsCTrWLW6Pwvjg==
X-Gm-Gg: AfdE7cn1S7O5Ixt3inoFWNlm5iYAYvkKFjP0gpb85Kllc4mr6RAzbGx1UTzdBHF8COv
 iiYsSWqodYMNwBilAynRUwpwuMEQbAXEfkZtY2WdHegGHThk6aW7CxHz1KBlT2dcfKysX0vB9t8
 tiA94LvKGJioX8pk8a1mIIl13m4eoWa7nCTdOaNE2Y8UC68IguVuxNF7OrzOceg8Cgvn3GnMG6+
 8WhX0J0PWzbzvVGj9AECfpZdRK6xq3D2wipYVrQUAynVUsrFKjbqxt+up3pNIF1bxQS5qAwwnwF
 PwJELl/9dYMy3qSmLX6LqoGDeJm3yk28WK0vtYboogTzOSp6MDq8TXd7PPogABgdg17KM6LalWw
 +dDy01vGrT286pLhOrbMFcN52hccSX/y3jJDNxXxEC6ytb+pr0B0=
X-Received: by 2002:a05:622a:17c4:b0:51c:511:c5 with SMTP id
 d75a77b69052e-51e4ede12d1mr69734691cf.16.1784193339917; 
 Thu, 16 Jul 2026 02:15:39 -0700 (PDT)
X-Received: by 2002:a05:622a:17c4:b0:51c:511:c5 with SMTP id
 d75a77b69052e-51e4ede12d1mr69734431cf.16.1784193339327; 
 Thu, 16 Jul 2026 02:15:39 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687171464sm172581066b.19.2026.07.16.02.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 02:15:38 -0700 (PDT)
Message-ID: <59818965-dfdc-4856-bfa1-cdc197793994@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] spelling: happend
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
References: <20260716063457.532035-1-mjt@tls.msk.ru>
 <78e31bf1-328d-46ba-89db-1e069f21c7db@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <78e31bf1-328d-46ba-89db-1e069f21c7db@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58a13c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zeRjNQde2fG1WwSHE68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfX/nEfB01/16IB
 hiU5FyusAMTC9nLNlPCVm4GNlAvNOdWw7kx8sOgkidBk2Rvul0bEjHreLi6NpCwj9Ol+t6TgWqI
 P2txb23ST3on/PEIBG022BZzko6rkA4=
X-Proofpoint-ORIG-GUID: JfD5ln5f69O4R7m7empg52FZzAiLoV0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXwtmsEKlxQMpJ
 kX/R4IAMKmLNNY6vWHLHIfc9PkS7aR8nJKXw3zUgPATGt6mdeZz1PpCcZMwZ7IItrmGrzssIJ8r
 fYqQfZXPpoz+c5EFKxl2+zZPuyDDBEy4GxKqG2MxQ+W/s/MUDq/3P9YQhjXPh0as3fv7yv6l9AB
 W8l73vkdrdGzf3zPbOStf4lehgRxR1TMsJtIcXRq1v6TB/f42L9++Z74Um/53HKl0iR3PQc1wTg
 9PiQYBMqEdatGb16frqj6R1CGMQMi00dByasIMhFjNdoTxuX/5wQd8vnyo8vFwzb/iYWLhPrVpR
 YrzXsmBOjH49urQU6Z/7PGYPgYEohUAG9oDuUZMxBziyekd+tju3gzlg+CcESfK4OQlF0SNrpSn
 8RhOT1b4girGrfJZ7zZe3u+0aAqIwXmyKAO6ShphRdn4e+Xf+f5uU0zKpUalAUGcDdnwpsx/wzJ
 6TwI6ItzqDWSbKAqQnw==
X-Proofpoint-GUID: JfD5ln5f69O4R7m7empg52FZzAiLoV0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160094
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

On 16/7/26 10:06, Michael Tokarev wrote:
> On 7/16/26 09:34, Michael Tokarev wrote:
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 66bd900465a..802474750b5 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -270,7 +270,7 @@
>>   #     (Since 10.1)
>>   #
>>   # @postcopy-non-vcpu-latency: average remote page fault latency for
>> -#     all faults happend in non-vCPU threads (in ns).  It has the same
>> +#     all faults happened in non-vCPU threads (in ns).  It has the same
>>   #     definition of @postcopy-latency but this only provides
> 
> This doesn't work, - it fails to build due to too long line, so
> line re-wrapping is also needed.  The correct(ed) version is:
> 
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -270,8 +270,8 @@
>   #     (Since 10.1)
>   #
>   # @postcopy-non-vcpu-latency: average remote page fault latency for
> -#     all faults happend in non-vCPU threads (in ns).  It has the same
> -#     definition of @postcopy-latency but this only provides
> +#     all faults happened in non-vCPU threads (in ns).  It has the
> +#     same definition of @postcopy-latency but this only provides
>   #     statistics to non-vCPU faults.  This is only present when the
>   #     postcopy-blocktime migration capability is enabled.
>   #     (Since 10.1)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

