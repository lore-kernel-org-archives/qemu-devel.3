Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D3DC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbM06-0004rW-UQ; Tue, 06 Aug 2024 11:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1sbLzq-0004cO-8q
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:21:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1sbLzm-0005CE-TG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:21:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476BxAJE023732
 for <qemu-devel@nongnu.org>; Tue, 6 Aug 2024 15:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7rziiALIRZcQkv5dhc4S9SxPMguEnP/Nfg0r+aj4qS0=; b=S51b/RG1vz/vlMus
 oXe9Jb2O46iMXnKx0Ts0YtnDNVww8ghjLSrSWQR0xcRG1AoSqR3XckHpRG9krxRJ
 4lsXGyrwUpdbj+KCknZ1hcZg7XTlzfz1KXtBnY96wEZOcpaTQYKXWMh943CHQNO1
 3brBr24fMkwkQt55ayorc7X0Lq0I9HpAokNqkligkGc/zsQVsy/hnZ7sg151Kad6
 75jGZxWDcJ9syc4I5TdeVbm+7JFc8qelt9DnLr2D9eDCXIq26TtWLHvDvjnqe66y
 RxD39HUEQ4VN8ZdDzeXKc5m+ig9TDFf11Vz8Fy60tKYEs8XlnN8qYSDzueDl0uXj
 MGtd0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgryv9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 15:21:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 476FL1NC022734
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 6 Aug 2024 15:21:01 GMT
Received: from [10.111.136.152] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 Aug 2024
 08:21:00 -0700
Message-ID: <137030be-f5b0-45e4-97d5-0d17aa8d6347@quicinc.com>
Date: Tue, 6 Aug 2024 17:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] system/vl.c: Expand OpenGL related errors
To: <qemu-devel@nongnu.org>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-3-peter.maydell@linaro.org>
 <871q31sr90.fsf@draig.linaro.org>
Content-Language: en-US
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <871q31sr90.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: s6BxaKlBDJVt-HvUcs6MuLPkgGKfJX0l
X-Proofpoint-GUID: s6BxaKlBDJVt-HvUcs6MuLPkgGKfJX0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060107
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On 06/08/2024 15:41, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> Expand the OpenGL related error messages we produce for various
>> "OpenGL not present/not supported" cases, to hopefully guide the
>> user towards how to fix things.
>>
>> Now if the user tries to enable GL on a backend that doesn't
>> support it the error message is a bit more precise:
>>
>> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
>> qemu-system-aarch64: OpenGL is not supported by display backend 'curses'
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   system/vl.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 9e8f16f1551..213ee6a6a92 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -1973,9 +1973,10 @@ static void qemu_create_early_backends(void)
>>   
>>       if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
>>   #if defined(CONFIG_OPENGL)
>> -        error_report("OpenGL is not supported by the display");
>> +        error_report("OpenGL is not supported by display backend '%s'",
>> +                     DisplayType_str(dpy.type));
>>   #else
>> -        error_report("OpenGL support is disabled");
>> +        error_report("OpenGL support was disabled when QEMU was
>>       compiled");
> 
> Maybe "OpenGL support was not enabled in this build of QEMU"?

To stay aligned with the other changes, this can provide even more 
details with another hint.

"OpenGL support was disabled at QEMU configuration time."
"It can be enabled by running `./configure --enable-opengl` before 
compilation"


BTW, whole series:
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>

Cheers,
Antonio

> 
> Anyway:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 
> 
>>   #endif
>>           exit(1);
>>       }
> 

