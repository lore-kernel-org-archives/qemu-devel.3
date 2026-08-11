Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D3C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgdy-0002FF-Oj; Tue, 11 Aug 2026 03:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgdx-0002Ey-Q4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:11:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgdw-0002vS-EJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:11:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqQP92706465
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Kq3rY0wPs/eDjEbAn7SxZ7jvcIO0oV1bnQVGLvAn5o=; b=Ig8Vnu5g5UVAVZ9/
 DxMEI7pONe3OsJA6dMhqB3fUG6KGefP63A7+/pcK/N+xQ/t6eF5nMEnTx/0Vuycr
 vfgZFxqmlueBwN6BnWCFK3iz7B8rriCJsgNemteB/935dlHGMAxYKTm974MWuvXV
 XcXpnfjMLZZyCJls6CGhaN55+KgKaeksUywuVA9IbiDTwUuiA8wITFM8P/K5vS3M
 mnDraxJkGH85i0zZCGR4y1zWbadvzfjNJWe7We0kSE/jWpxG+IS6dVmC4FdDVfxG
 PITP7RUBRsmRS3rxqXga75FN9pUywcSSuDykUjDhm3/UI/89JeXSUzNOEbuRIKii
 zcdSkQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk62uun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:11:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so50075811cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786432282; x=1787037082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Kq3rY0wPs/eDjEbAn7SxZ7jvcIO0oV1bnQVGLvAn5o=;
 b=GmF4CLh5g2bILN3/AbBu4i/AOmE8hy4S74YWNyWOIXcpP0lPMArXuasLixqqUKS3qi
 qGn4GOgdqzCyHT6OHpEPmhN6r2ObU4zty63FgJ4Kv1bGP2wBjO2zJjbQB2PzHOXvPj14
 detfzJrX4QlygCoylLq+Y03dJvDdm75+HrSA2PNUIqEESr6WLKNBfaME9FEnB+jFZyV2
 vZ9d0lan4T71hz3vorlXEq3MjYTAuk9q3xMVKvXlrflqmj4gRVNEWJRc8XxQ1X7vZ5nc
 8ZPjHtmrGdWljt7eUoUnFB6LnKy4MmWNiruWd7VBzTga4g0COoRLNbze+I200IUd97hh
 AuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786432282; x=1787037082;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Kq3rY0wPs/eDjEbAn7SxZ7jvcIO0oV1bnQVGLvAn5o=;
 b=Q+eS/uBSpxxXdIXEl/5UOEHYo75zeN63i+U6CxBUiMM//8mZpbtaX1JHLzIZF1GEcf
 jtKjIjBZRSk+JCJslMSJLQuFfFyEJLaKmrkQ5lMHHIKw/JDjl7yjiLaVdJeMiAoW/XmZ
 Oj/xfCITuVqhr4nQhOP0rF7Vp/TE6/3fgSZNf2qTX/uqqICJqr+hLCumbKCWHNJK8l8W
 SVI8L7YUJHgw/jX2UAlf/XPb5uWWENTXdQLa+UY1/yVHBvP9tjlqnBpUYab24LuJ8b2B
 TcscvEhCdoH5PiKV52aUFpOFfHy5TIr35SugmGBTtd2z471h0cErkU3u5OtGsAAMcOaN
 gUUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RruBbRioSzf6HDfoH+Ro1KVRQWGMmUh0ML1/3T8CUit3XO472awKpllW08uwwGAYJ//PETfrQ6jUg6y@nongnu.org
X-Gm-Message-State: AOJu0Yw7RKlW6IwqShRLHaIRqVL+ywkeKJD/nA9kV+DLeOzyESljqiYI
 QeB2b+qOhTLQpLJGOj8KPCEO+0KwN6rB4pC/OOk1iZw6tIRIpkxIEDUeLJq1IWKM2LYJw5r1Nau
 w4qn3Z2LpUq2QJtt3tf14a5Pn0C9mK4gzjlsd5zCa/CpoWnSZD0k7J0VDLrz5YvLjVg==
X-Gm-Gg: AR+sD10UjAGtAG1ho814h3U6ocDo6vCR6FA2F4XdbIdwzAll+kiaQLZcKsaaSIP2zha
 GAbXIFJv8YR8f50RrHRFxdzO8svr9Vdqf0zvcTSfeivkr+eIZxNaKgsUXZIJ95UTJSLBaJzbig8
 gn6iLm0jDKy9nW71tSwcjupfZ9VlIHGNyT8QIFyl9CnDairylzXpFxGxQjqtbZOHJFEUyNECx04
 Y2Dl40b9z9caOl3oHymNqMDMd/kcpMSZNiTh+srSVaC2dutRnRtuPO8suwDI460iwaSqJvtJMXO
 5Zcr8J+JbXLbt1kSVOG2vXVKUu9TMmxJqNr5B9SeLWeYCIyCsn1YMu7JBiF7SUCTb+Kqgr9m8TF
 B6xvLDa89TBj7Kylk4IX3m+imNtrctL22t9YdUnF5
X-Received: by 2002:a05:622a:409:b0:51c:2230:7efb with SMTP id
 d75a77b69052e-52d585bdcc3mr9621461cf.23.1786432282608; 
 Tue, 11 Aug 2026 00:11:22 -0700 (PDT)
X-Received: by 2002:a05:622a:409:b0:51c:2230:7efb with SMTP id
 d75a77b69052e-52d585bdcc3mr9621071cf.23.1786432282190; 
 Tue, 11 Aug 2026 00:11:22 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a5be9sm28901605e9.4.2026.08.11.00.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 00:11:21 -0700 (PDT)
Message-ID: <08804c65-680c-4ca5-8e94-b416ed58d74a@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 09:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/riscv: add DesignWare APB timer to K230 board
Content-Language: en-US
To: raoyi <rao232328@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 caojunze424@gmail.com, bmeng.cn@gmail.com
References: <20260811064612.16517-1-rao232328@gmail.com>
 <20260811064612.16517-3-rao232328@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811064612.16517-3-rao232328@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7acb1b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ntWQesBoEHepiUpLgy4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: tgdaVg1sJKTz5VM9-KfmzHxMEBH7026r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1OCBTYWx0ZWRfX0daKFmTA4FI+
 +WlNTt94BcC56uHpJPIpBS8bbpT5mUspKkXaxG5YYGh2GsyVB3oH+/CAVnawxEoxFBtcXocgzEJ
 Aa/b20BawrNAtSf6AeftjBRV4nD5eWY=
X-Proofpoint-GUID: tgdaVg1sJKTz5VM9-KfmzHxMEBH7026r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1OCBTYWx0ZWRfX19eZKndrT3AN
 VedOzIbnd5guWVEyjButNfrSDoWbq1TbVVO9uJ6sBIOoBSe/jObv4HdIqAtbzRNqBzk5CDJx+y0
 UJfWQJHUJGGGm5SaVDfkBkkp7nCBHzw1/0E0XArxaviW3JMXXHgktxGvA0uQDp4/pEAliLYnUuU
 t/NbjeaPZ9foCczYd3RgVMtNN+pBpnTeM+jOzpFGygIkmwOAE3t7XlW6c6bjAu6QncqpD01TbAc
 EHyAa7z1J2YKaaDahSJ7F0Laol/rWYw9TS8BV2vdujCjFRzzxDpfkJdJ45KDsjoqPvx25sM2BNO
 k+MSLsWPzOKJGYr1Zwp84XcIgxf4VaRdvBunVAuZW9CejMkIuP6uoAwxlooWLRoOWHoy5ZNHWjv
 2YKXDzPBKsIG7EJ6IhGuuqyFwvTijyEE6IgTlkveDrWqOtMrud2abpCNzcvDWbC3W6M30CDBZoi
 87bzGvDblHdXooyNIrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/8/26 08:46, raoyi wrote:
> Wire up the DesignWare APB timer to the K230 SoC with
> num-timers=6 and a 6.25 MHz clock. Connect timer IRQs
> to the PLIC. Remove the previous unimplemented timer stub.
> 
> Signed-off-by: raoyi <rao232328@gmail.com>
> ---
>   hw/riscv/Kconfig        |  1 +
>   hw/riscv/k230.c         | 32 +++++++++++++++++++++++++++++---
>   include/hw/riscv/k230.h | 12 ++++++++++++
>   3 files changed, 42 insertions(+), 3 deletions(-)


> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..0f872554c8 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,9 +18,14 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/timer/dw-apb-timer.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> +#define K230_TIMER_NUM_CHANNELS 6
> +#define K230_TIMER_DEFAULT_FREQ 6250000
> +#define K230_TIMER_COMP_VERSION 0x3231312A

Keep these definitions private to hw/riscv/k230.c, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


