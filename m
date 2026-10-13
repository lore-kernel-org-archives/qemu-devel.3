Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E7CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGebk-0000t5-PX; Tue, 13 Oct 2026 11:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGebg-0000ra-Vj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGebf-0003qH-Ei
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3w4f1492075
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t2k4+heMZDVN28axRvxVEhEif1lfuBGs2QOACejWny4=; b=KZM7Lr3v2X2qshL6
 iZa5/0vUnltBWcmi+mhSTyn2B7G80q+7wRRPd9A/3WrW2oJlTKJbR3HZjMHBFISd
 nq+Bu2WU1fiGp0tIsH3HUKm8CvWbY8jMCtbG8O7sxqOvm8ufgZlE1Lj2dkwrWvDe
 o0RXHU+9dzEu24Vgid19euHjzEyQ2KcIwqR2gtTdapNi3nH+8DhCefx3Zqjy61ah
 0br/KGqQFwWs3FQ/h7PBl+NBa4DTtqvlNMZGnr/Th9QGg6bdTLM6rFCfPv+HKjov
 eBzRxdv3uMM8N/AZ4Jc2qFYZ2yEqqL6w8BTLl4Zu0fXYV6ibqqhCUzuPY2T8VTP4
 3lstzQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqttcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:39:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b7e90fef1so39020506d6.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791905991; x=1792510791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t2k4+heMZDVN28axRvxVEhEif1lfuBGs2QOACejWny4=;
 b=QAZno+ufACXzvmiFVyaPVl/S7IrByrII2vF7E+DFMjMfPKir9+ktMJ/GpjqorMoGjs
 4c2EWGbhz1g0LUqY0xQrUKWfBcX8i0cMoak5hLVpzxvRACi4rnv++ox7tDuwQOtdDYAB
 9fDwuIrUCJUED1G+tmySjvWw59JhFU04aSu6SISa9+J8OrvAsDoLAphfTCb1QF0lYINj
 EVkHDAdg5IQQ1nuEI2IC0ZnfAPZuJOMDKEO9WXxciqC85Ln7N0Ggzo8Wj2rZ7nQqb2cH
 xnRL0lj99Oj/qUxKfUAqW8v4XBd41yD80CgjjQyh3odEx5EXt1fh6A3iUi1GCGHUkJNc
 pDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905991; x=1792510791;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t2k4+heMZDVN28axRvxVEhEif1lfuBGs2QOACejWny4=;
 b=e6xGXMxSK8AIVOixEJ2RSmd22g2l+CiVNNGHzUlypRYRqQG0FKDaIU9dhKUhlEAik0
 KMCF5xKf2BG7BZh6DUHvUX2fdG4qbsPmqN3ytb5dP4U0BLUAjD2GQRkTUSNMAstDXTVc
 TFDNDSTgdUr6L4qEnaUDkJjodfiOJiX60qK5+dT8KCsMrcoi4/SnraZbfo7OwVQ1vKIm
 CKWFOQsGC9qu+sPWdYWH/6oB6zgFARlD4pof+CQ3sQC8uZGkEQEfzVqVGEau4psm/uT5
 tGu2CvHVkiJAwuE3Om5XEZOXtzCVKoXKqtD3CoGtPg91SBeClA6NU6EGnB8sKMx/6Fqf
 IWnQ==
X-Gm-Message-State: AFq9FYKD1CRJIePR9hPfxCJEhQ51Plcybp6hTB5GqXceutFr0i1gE872
 bH4Pcz+6RZoCUUtLSkH49r2Ujfr0u9Pn9nxmd1p7wT/B7Qn4IXKdz4TquAwrn27++Imyw439t4x
 SpJP4/ajkNq8cU3NG1pnS2uJbbJwn/c9JB4I+D68KsBXhCc/1tfM+ZZIThK8W3uW1Qw==
X-Gm-Gg: AYBFou2SF4BGm2pomeLlwxSWbt/VeepRWFxCHv5hRgELLjRgoqope+KHM2cFQ2qRnXz
 zRilBZ/SwijmqHHQfzPnImRId0agw7oGpgV6LEe0nn73vyMh0FBCLT3COn+PJsVQvJ22RyqS6Re
 LRVyQ4gzZeLyDoTDZOB2vXHaiknXX9BL7NrX4zGKEIRO02jN0L2wOceag0XE6/FTIOauY3IqmgU
 9HYJugm2o919jlXF3q/UcQF1pzG0iD/Fzl3ieZwOIRbBH1DKBYmWQj6DO+5jFiUBkyyDcvbFqmJ
 eDbSkSdaPHLNgKr8+0s/e6/sIoML+hOqccWapa+G7Hx0p4dHgNCiIIpfsLzwcoyxwc54wtMP46Q
 4egJfAuRsl7/e5wgxMklDMk9Zr0dk1C3wAv18cHUPEBVtJ5dUQX6/ZdTCO/3AGqjp
X-Received: by 2002:ad4:5fc8:0:b0:91b:5d39:e132 with SMTP id
 6a1803df08f44-91b5d39e8c2mr194125846d6.29.1791905991430; 
 Tue, 13 Oct 2026 08:39:51 -0700 (PDT)
X-Received: by 2002:ad4:5fc8:0:b0:91b:5d39:e132 with SMTP id
 6a1803df08f44-91b5d39e8c2mr194125386d6.29.1791905990825; 
 Tue, 13 Oct 2026 08:39:50 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97b38700sm28151696d6.11.2026.10.13.08.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 08:39:50 -0700 (PDT)
Message-ID: <cf5d4d62-4ac5-4903-8564-4ab3c4e8874a@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:39:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] target/hexagon: fix semihosting OPEN filename
 handling
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
 <20260923153516.3615007-2-brian.cain@oss.qualcomm.com>
 <CAFEAcA9YPi22UHrBpvih0YtWfa4M2a0RwbfyfWGparN3oUxm5w@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9YPi22UHrBpvih0YtWfa4M2a0RwbfyfWGparN3oUxm5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aqpCIDhDDrmuOUqXgoNk49HtclKx0dJX
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace50c8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=az2HLknMwyL0ufk_kykA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MiBTYWx0ZWRfXywLsTyp+g5zj
 MCcdFonTFGFKqqgT+suielmUJnG2Fcpc/pX4TIkYq53H49jSXP3gI1wVYUnwuVQ3dvwrgiv7qff
 YtergtCzPlPDXGYT7AD/hDYR03/2+DU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MiBTYWx0ZWRfXxDovTnQV5MQo
 8TmWBW+NFsTgR7dojuc/nwoCXarBFY2WTLxjsuTDCskcpNJg0lIo6mAziKK2grrIA45ALTTs1Um
 cBdx5VgoXNTGEsWgQj6v58h6DB78SIfQwUhXV3D+l/Neeibp5lF82cZzPaWE/+5b1ntQ449XEnM
 w2NM1AisOOr+uHYFMBTeGoQb31Rkv1hSFlZwRo4nDUFvoRBotsWLSLeVKMGykgbT/RDsZYsKYBI
 X8Rmy2rJRtjD70Q4QtcyTal36m8tYlbJV9WPTsFfNHisqy43EnHtCgJsfG8wMzZgDcPyZmHGm8y
 OgrdKaWDxjtFfCm3Uh8P5ZPlXyApD4qYZ0uVkYDJdQG1CEhbKMQa4eigL5W3MV2P12vc+yK8HTP
 RBQBs5vZazneAg2cBYbR7lDWX81owtGpGgGCAYn8Pxyq3Uj36P7/bb7p7Yr2lHLiY7awNZuTImp
 sXPFvICSxVYAvjIadSQ==
X-Proofpoint-ORIG-GUID: aqpCIDhDDrmuOUqXgoNk49HtclKx0dJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130062
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/13/2026 10:10 AM, Peter Maydell wrote:
> On Wed, 23 Sept 2026 at 16:35, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a
>> NUL. A missing terminator could overrun that buffer. Use lock_user() with
>> the ABI filename length and validate its terminating NUL before opening it.
>>
>> Replace hexagon_read_memory() with get_user_*() for semihosting argument
>> accesses.
> This is doing two things; it really ought to be two patches, I think.

Okay - will split them up.


> thanks
> -- PMM

