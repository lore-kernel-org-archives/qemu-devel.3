Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFF9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRrm-00017S-Lt; Thu, 13 Aug 2026 05:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuRrk-00012t-MC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:36:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuRri-0000kb-Hc
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:36:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D92FYG1926703
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 09:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s7DjGT9uRTKlyWJxqLjEGtUu9Rh5JVPwobUNLuq3QnQ=; b=nBCGDH94OA8b5KkP
 5wJfvsOAZd9xywjaSD6/IYxv0h5iuVvB3NodVwqhue6ZwQN/vqLwu0dXPpI2DyIc
 bYqp0a+DCRG19KxyYWw1EomzccXW0Cqs+XFTPJZ+ysoods4+tNp2VUPByNKgIKD4
 Yng4Pls/lAR2fLRMVl8VxT707vtiic620eYZHyuv+cpMqM5FpkO9xVIGZsjqcQm9
 QvNGMQiLWxuqKn/yPEEVpahdnlL3GYbfYVyPGDQlTRfi+sOPOXSSIBFtJw828kJg
 ldH6AkvaEGhg7W3mwVQqEPT6TXxuJ2gwdrVUnX6Ea56q4cdAfNxjntVDfqqodcne
 xEnQAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts3ym4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 09:36:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso19281381cf.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786613802; x=1787218602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s7DjGT9uRTKlyWJxqLjEGtUu9Rh5JVPwobUNLuq3QnQ=;
 b=AczmX7Gh1vHjalo2k6EODr/tSmXC6WuNbIJ7tayI59HwDyO9gn4/UgDs1GZTKU9Au5
 Jiegcr5ylIduDRnmNYNQdBFjFGayojJS+Yf+A9g2GycRcE2Sa4WlpS2tvT1LFrv3ub3z
 LY0wu3s09uQIk2FD4AWc4KQEGktRJKa2Oj7sQglokohJ1wqiMPOqUYK/ImQM0wfFecFM
 9J7haNf8zFONx59xAjKlG8KNtg99iyCguBtWwAaq9nmQGQ588WOSrCfp1aLMbZSZmMp/
 tdvQz5OkzDp9kADGZ9fijqHthaDEmoqJPFe3YT72alPELwXZj+Sz1HcTlPN7zPLReWIA
 HFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786613802; x=1787218602;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s7DjGT9uRTKlyWJxqLjEGtUu9Rh5JVPwobUNLuq3QnQ=;
 b=cZZlr08zUvTAxGSsxcGhqlIcgq4TCPS5p8Z0mdMAADa5gLXDolVqyLQr8EVbgo0kSv
 t2/IysU2tpIdaaJtw8xonWLi3aqlm4Q7wq9uJsnBMHKQjkCe7FOzUimhJqe0uLeGeVt/
 tdfsn8HWN3cs0Hmd4DgW5XVuWgz1RkOfAxoGGf3aww9ciav8Sj6NATbZbb3R/JcDpF1Y
 j2GdqLUeD7xog9v+6bjgLwTZj7M7FakXjouXPGQCkZV54wmFk8EH1IFW4qqgL+lSiL+d
 nuVQmIdw4tQH3sBr8HKyDJtiJmW+8HsFkNiUOTYqv0UZWPbmu2fGsD8tefA8lV46xktI
 Cztg==
X-Gm-Message-State: AOJu0YzMcvM8k2bKRU0/VinK4lZxPXS7tCGRB73dmMEF1yUvP2OiLh1s
 4XAx9g7R77EImepNxDUkOEnXf0ugki15zVIqd/OvGoBqGDT4prndxclLQ1UVsXtzjznRDpMZHNv
 /rQyMDRv5bk9iXbN1rcrdV6jvMSVLW1XyCN0QR2z+7lzBlPZxvalwxcAmCg==
X-Gm-Gg: AR+sD12e7nVvy2OaYaBXdshrbq6jz/gRgLpATIYBeG/3m9CvsOf3S75zvVXe0qXXqJH
 mBk7tCTGOZN+raDid180ultctUB4EujZoLKvbPOycv8Xd3ax/pzV79dZ2wgtqM71A+IA/CTCWea
 QsGdfy2h1YQcNeHUk4nbV/SyC7VzP8v3+KVinU0UO8DPCK8Qdkg/niYonEibcJEQYQdi9G1ZHpi
 lvkvnyJtj/Q7s6U6QSiFtuY3b5+ZOjMvsWdbt9FkP54bginyap0PFs92mdi65tMi2IaAzK56Ut3
 2/puJqF4Rsj7D4/jEtDcN13LrRFl5eYt0kxdZujaNXjH/RfalDjib7gEgq1cg/3n22HQIORVgg4
 tK4uIGO8UEeCiT7SdJt1sV8oSbW9HibMcAFc=
X-Received: by 2002:a05:622a:5912:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-52d73d9dd24mr43081381cf.39.1786613802610; 
 Thu, 13 Aug 2026 02:36:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5912:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-52d73d9dd24mr43081101cf.39.1786613802197; 
 Thu, 13 Aug 2026 02:36:42 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1063esm62080165e9.6.2026.08.13.02.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 02:36:41 -0700 (PDT)
Message-ID: <064bbb73-926c-4c2b-b964-66737bf0e8e7@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 11:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-18-philmd@oss.qualcomm.com>
 <an2NvKchBydh0f3X@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <an2NvKchBydh0f3X@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CZwd5ApN4Q0gTB5UZdfpy_160ZkH0hQu
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7d902b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xK8ZlYmSxX36IeW0HpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: CZwd5ApN4Q0gTB5UZdfpy_160ZkH0hQu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NyBTYWx0ZWRfXx8HIr0m6ahtU
 aKV1YpfsuaYHMQISrecY+L3RJvMsq89dczOO70C/xhWaZYg6h8PaBW9kmIYu/SCCcQ4GOzvFkgM
 QSiStUK6GsPveuLtGX4E9DbuqeDSaFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NyBTYWx0ZWRfX3swFwDRbRaEl
 qE5O7YAMce4Oi80kG0GVcsDUZHhLAgMnTxNgs+Nl91XJHAblq0PkaHPdpWxHWebsK6lfw9JE/gw
 NDMn19KbsEDdxFMQsN969hdTyScfuyDx2Zz9PHjz4MlZCBTOgUhzNAyporNQjOh6BQx9Ru7jMjZ
 spSO7DF/U2GybIJRvtQ5G7XHix4lj06YJEB3rPydG1tTnkNC24nN1l0kX62X9BMK2fj9K88CRTo
 BfwYDD+SJgbLLEtLT4MCAIKRdh2A0U+JDXCVBDLSxW1pqeXw0Z+w9YzdhqkoV6VwK6PQqGAajKo
 zU0SGuTWtN/xgG+vvgDASpmrll0xZeHIDU46EdVczxJ4TigJRbCeh7z5dZlKvoDt1phc44kIYzV
 b82ca+aZ/fvRIxWkqyd8o7tjIXK6NYL06OAg6/1yMiigu14taV+I/6KagGjoxlLQmTN7/To/ds4
 PLhosWIe6e17GlTL58A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130067
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

On 13/8/26 11:26, Daniel P. BerrangÃ© wrote:
> On Wed, Aug 12, 2026 at 11:17:01PM +0200, Philippe Mathieu-Daudé wrote:
>> Mechanical change to sanitize using the following patterns:
>>
>>    MonitorQMP *qmon  (this patch)
>>    MonitorHMP *hmon  (following one)
>>    Monitor *mon
>>
>> Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.
> 
> The more suitable names to me feel like  'mon', 'qmp' and 'hmp',
> not least because we already use them, whereas as have no use
> of qmon/hmon currently.

Interesting, this is what I chose first, then thought I'd receive
comments that this the monitor state being named the same as the
interface used would be confusing. I'll happily redo the rename
(but after Marc-André 'Make HMP optional' series lands).
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   monitor/monitor-internal.h |   4 +-
>>   monitor/qmp-cmds-control.c |  18 +--
>>   monitor/qmp.c              | 256 ++++++++++++++++++-------------------
>>   3 files changed, 139 insertions(+), 139 deletions(-)
> 
> With regards,
> Daniel


