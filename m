Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7206CCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjN4-0004yO-OK; Wed, 17 Jun 2026 02:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZjMx-0004xX-6g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:03:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZjMt-0008Mo-K4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:03:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H60pDT274624
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d5gh9WoT+7JXtpu9g+VmN4U7nytmQ0VdETWTeIE2GSM=; b=M5kQeRarIZ5XOrCs
 NkoYY98KBXmtJvapxfw60gLhItf4Pkhb4y5ieqnREJ+r1K/A3/Cz6CqiFo1ZQOBL
 /HAL0taKQ0DGWML68U5Q879MWgnDwE8PQH+JtvUp9koLlF8j4GwBDHERW0RMvgdu
 MXXseF8nnVsKwkjdMXR1FNDNtNR1cnWRth/u1/G+5p3lLjKFDUuKm9LjN+Tfp25d
 EFheyqGaHeYpPktCesdu4fKycNTbeuaRToV/84YhQ6zrVnWhio6j6HSZUvG3hnay
 dZIBr+YCCJZXNUpPoyaAe68xmLWo3au2f/rtsUZHivwiKxqtrPkayQ1OvuNf0vNj
 e+RU2g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemhm01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:03:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517878a92c5so95659871cf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781676188; x=1782280988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5gh9WoT+7JXtpu9g+VmN4U7nytmQ0VdETWTeIE2GSM=;
 b=X7sDH0JiWcbwD0BLXOiqhdJ3b6urgN3JG22c5VoMbH/u5mzHPhB1wf7kAJ0aPS7NRN
 Z2haqWK9XU9bzZ7eV3DpF7tg6JqcNanGbwO8Y6EogJUmKZsGwIzVpCSpNs/3zCUYNR5V
 7/u4PLxYwg9bZXzisZbFvjL0bx1bQzsjSAHhooYHBVPh0IMZYLXqhy/ddlMg3PzQkEnW
 B2lfbdkpuN8Q0MIoQJeMHfJ0WoxtP3pFieOMsoKWT8snGib9xkz5vfqJFhAVIP+ch3yq
 eXanq+cmTI/N0b/6odETolqxOWiTAajR63WcCDtN6Ksso+CIavdljmc+XdjP4ttOLliy
 DKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781676188; x=1782280988;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d5gh9WoT+7JXtpu9g+VmN4U7nytmQ0VdETWTeIE2GSM=;
 b=p16W0iD+LcIJ+OdBbgV+R5XI3xyJS89HKJyeLwXBRZ32z7bhJgjJk0ICXmLj+desYX
 6PuKN5+P56onTMWbafe7ZxdMI6fssoYFvd9X8M13QZNi3iH6kc593jkL9V62Y5dM6Zu8
 rT5wuQhzw4RQdygUt79CcOPdQQ5Tbn7YnxvWxUGLJjK2d14VImbZaLezVaO1gT5Of3Oa
 51RtydG/A8o2gAD592owLneQe8SwBW6XGFPxI/FHY7UxjsjqYqa0mvCEcUp9FfjDiOy1
 0BR3U46hjNLEVVxxW6EFBcWlxGPYxlyIcW3W3vr0xAIZcKSktVKtzccWrV+NPHVhDFtv
 xULQ==
X-Gm-Message-State: AOJu0Yzo29SkyGGwjvixx/Z9tmD5RnegysuVbqfoxvO+gMoWNXTd/rU8
 ZjLmic3Ti/ZqAzzbZaW5dQ+6f0uWnwwDTUOY9aONzC13W/vj19Olqz0ITrf7C3wLTnl0BRUaPwl
 ofG0JQUN3cS8zLkIlmEz4R5wU8QnFL3gWsTjmo2TQ+om6rLs+sJJEBWCSCw==
X-Gm-Gg: Acq92OGoUZuaI88U9dLPi+5nreXJw0NXU1kVn7y9uFVkXwRUAwOUed/C2goODLKvIRU
 cw0Vj5L8ZvLGpuKaE6LiuYzwVR8HjFhIhB3GP34OhjS+CajhiC+2NulSbI7awrPNYd/kekBHcfZ
 uyB+XmH3vTBG/FFu/iI8NT0UBFELxv5vAzI7l5KY8chcGtArngVlIIn+yfUcwdpE9IoEyBRc8xf
 63X7MpVV3P3cw8g/3yx90a0RGIfmlld4+zQON31uxaoWrlg3kCXkSgLcvMrY2pdzzIeqvZDUtzb
 HUI/CHLohcuaHRQe5uLuq9Ka1HKfsS3dZEmFWf7FLqERbTNsyIgyiO8Ya5M557DUMlcm02+GDeK
 m2Vno53FVQUiGtoHUWeEuQ19AL2jAqKbG0YXQCEe44gcK7AAiVaB2SDkhJot/aQ==
X-Received: by 2002:a05:620a:7081:b0:915:3d27:a816 with SMTP id
 af79cd13be357-91d8e3a1d4dmr442211185a.49.1781676188490; 
 Tue, 16 Jun 2026 23:03:08 -0700 (PDT)
X-Received: by 2002:a05:620a:7081:b0:915:3d27:a816 with SMTP id
 af79cd13be357-91d8e3a1d4dmr442209485a.49.1781676188129; 
 Tue, 16 Jun 2026 23:03:08 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3abd0sm150365495e9.1.2026.06.16.23.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 23:03:07 -0700 (PDT)
Message-ID: <302cf743-9ccc-4ed3-9306-57f40211458e@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5 qemu] block/file-posix: Clean up sys/ioctl import
To: Damien Zammit <damien@zamaudio.com>, bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
References: <20260208055858.2166524-1-damien@zamaudio.com>
 <20260208055858.2166524-5-damien@zamaudio.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260208055858.2166524-5-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MiBTYWx0ZWRfX7Tb2ELWkg1q5
 e9Nd5QRLL0R6KK8ds21zI0CBKJA9NbRcKuLcn6OawGzeyUkuyKlLjxa/rmrWppi2dAAkeG+jLMz
 IYVXztRsflTT3TC5LqDGtrcVVdZlFXo=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a32389d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1aEGRzILAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=YnQOWIQKVlvq_qt1GCjI:22
X-Proofpoint-GUID: ZicM-vs-1jIKRQFVNqlDs0AkM0MHVnjx
X-Proofpoint-ORIG-GUID: ZicM-vs-1jIKRQFVNqlDs0AkM0MHVnjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MiBTYWx0ZWRfX52jrUdaW/Nb+
 H+w1446FBfStVY2caYVmjZM/Uy2DQ2F+XYkCySfaU3mtlS65onS+RoXsbVqCQKSzY+CH/I7tJUI
 MkLV6N2RjrUhWC9Kzch/3oPjUMeXQ2R72Hw/0pPz5+QcQv1mXtBpDrH8pJjDpCkniwfLiqxtrJN
 vM1LKPnUt0MMrL/z9nE1QmSN6Cn+AAAWOdqZgLZXEfXnVt8JkDR9MlWTQjWtGe4rkmq1ROQyi05
 HVO0T+KgK+6HYfBSX/lguY4vbVR1wSdzIlDkQ6r00jc0EL0M1LmMq9lmMdVNFw/R/OQpzciEKen
 Aa1ofX443C5GTAxZHXJyyGXsvAT4nDOfWGBUDeeQsXk4HykKZ2X3JrVFhK8huvJkQvecChzgDlN
 6cWBPg7ZA5P/h52GK3Aq9OE2NbR+x/Q32IX22oRxL9owElqtB669iB9X7CqfQsRmkQmjKjBmnct
 YELnTtkKsUTknen0JiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 8/2/26 06:59, Damien Zammit wrote:
> Since all platforms except sun include this header,
> clean up the ifdefs.
> 
> Signed-off-by: Damien Zammit <damien@zamaudio.com>
> ---
>   block/file-posix.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

