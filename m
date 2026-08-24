Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F21BC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycFB-0002Zy-KA; Mon, 24 Aug 2026 17:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycF7-0002We-VT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:30:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycF6-0007et-C5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:30:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJH3M43320743
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHQATmsqvxUF9FZYaf4cjSioap0GJcneajmCz57TpTU=; b=jscWkpYk0qvgW7tO
 NY8hOQq3rOuDGLKQyqB3Rcxonqh6jh+Tmwt1wA0gBwNadG9n+Ia9u+M8rfWgb4Vf
 uod5khrXOeaQJe1PC7lMhkvCc2P7GOhld2umAYCC+3ekzmrePHDpQVYA0kqJ7J6F
 Leb8opxnkitKCXhf38IyY39Lx6Tg8mzo7griWAWoin150ZOmonLCp5S0qZpGGovM
 EwMlSaYI6JsseEAYUPiM+YzkULMb9YTWXatX0Y0Z+TeLWp/DidrlNkFhZezheduy
 pbs30mOY6WKmWIo+ry2VyQDbs1xssNHglwxvMEzZH+mbGtf416WqNF7oqfEyK0Ez
 zjJ9wg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsjxyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:30:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso44913781cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787607006; x=1788211806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QHQATmsqvxUF9FZYaf4cjSioap0GJcneajmCz57TpTU=;
 b=GrEHbRk/612uWRktmcxz3/CXy7XT+8EK8r2yMs8f0X+NXLwBjSeV5P6ibXTWx1OVxV
 JYEciTOzCYm/gklnEecSG03IVvAqqEloeho6BOvLhTFHr6O0xTh28jOjh47eE1SSHwO6
 /0T7Odx3uUafC5chWylZVqAe5sBxUpcsPSDlXu9BR5V8Iy0QZeiaWkCE+uwCQCFRRPNC
 IY0u8b2p3i2pBUwHWhHyplT++JkdQkvSKCrRzLk12nkZPEsW5ayy1iyl8pkd27wlfbr3
 swoCp1LFEIrzrWfIkEQI/z2hD6u/5zgQJfcByTiHwDvr+IpniTG5X3n1JBkEkdtJUaso
 Vxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787607006; x=1788211806;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHQATmsqvxUF9FZYaf4cjSioap0GJcneajmCz57TpTU=;
 b=ZY1C16hrDTPXtjS+hOVr49oIbvT33Jj/47sDLAB7l40dd5vw3NaF7ga7JQ8RwI6pG+
 jS4EZFiIRh8pEnzN0ASqe1uQaXJvJvxyku3DJ0ZvaQnX8nJce78Mq4UU7i+Re2peSKLI
 xJxictQKTn6/ubIFZ/ed8WbdzCmggLlaCKMoI6yCm+h77PkaJDQgvvuacV4i5qaaTxAB
 p0SKaFWATtVaw7qysNeLlxRCqchIjtdXdwDRUBrOaLODQqwADuuo5lRa7jboOvQ2bo57
 qntbZO7ERj8AeB/zKhjz4gQD+7RjpKsLBrG+5U9baIxNig9DWP6qy8JUvxAqdSmIun9M
 vC+g==
X-Gm-Message-State: AFuF++mwALbwBXjiei7/5pW5AksiV6Hj3aMhw1b1kCiIWjhzELYoDdgj
 ct9uyJaPh5V9pKuYS+aJIeWoJr9lbnfXvexCtEaw8GYm4zlEn6z1JA2lRRWzbemboF5YQ2HEIrN
 OPN/WcN/Vw6VPfdkpJG/aa+RQ5Fjd+9S9vstiSuSTBbhvamd7XWHjLgF6qw==
X-Gm-Gg: AR+sD10CJYuu0xtzxL6B6EXEdn1UH7EGSO6KZJy3c5w7IrPhN8TxT9LptOPAIVcdkDv
 bbiOo9KFDXg+tn2D78I7nwbJGJ0QzkfPcQTbFJ6As3MepZF9nw2DZh/NCfdQKhXD4cmRREzK0n0
 95yE008cXuG7+RGMxw2ZiNGOfPfW/wBUpmE0qp06obq2mMmiUTeGLyOAcyKrx2VqAgZtFGqJBka
 lQV5qLHmY/ZcfSIRMu5KtQisys43PGucrrHN04wpYe/+PTLQb4AvkGkKBWuAw6X+FGx6UxdmZvc
 xxrnmG0jY7FE/MhMlnaTBog2eiDdzUkXiaDPKO/p+NvOAFCAc4xswS9zqq+hr20f8H6HzOXTdTg
 s8oGw01LS+tLiuqye9zlYZQq/9NsHVrLrtgWk68b+rpgq1YA5nEs=
X-Received: by 2002:ac8:5f47:0:b0:52e:2d78:60ef with SMTP id
 d75a77b69052e-52e2f12807bmr22064951cf.23.1787607005587; 
 Mon, 24 Aug 2026 14:30:05 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:52e:2d78:60ef with SMTP id
 d75a77b69052e-52e2f12807bmr22064161cf.23.1787607005049; 
 Mon, 24 Aug 2026 14:30:05 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9444905f8f.12.2026.08.24.14.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:30:03 -0700 (PDT)
Message-ID: <6e8821f3-9482-4ff4-b242-c84e67fea533@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 23:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-8-e53fc35bc550@redhat.com>
 <aoxGG6MZUBaUrY4r@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aoxGG6MZUBaUrY4r@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MSBTYWx0ZWRfX9AQoWe4UQK57
 LzEALRvYX9HS2BKUzud73t21c9Dq4lj0jrDOKVWo1pg4kMkHK6ebBrHweHNGbdgK11Qe9iWcQ9y
 UHAZmzc7aCBFFn8qrtzLpWX5PIcEHuo=
X-Proofpoint-ORIG-GUID: Td_3S6VQg_bNYuPe10jNOFD5IqOqoLca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MSBTYWx0ZWRfXw9AA8ybennGX
 5r5ky4fix51gxAWlJobTTYZQkMHtIofuSLOJswWbVfZ2s5CyLO53YKV3+hFbOwcFLT/u1airZR8
 glWiIOmQ7VlJVe9U/USqebhizSoqI7KTKOIJ4zt8T6EmSf2e8SoNofZ4vY8oP9fDBcA8joN9OSx
 kxtRZBCgE1qVCMKvgDKONuszDDNo7KEHwgYKf1FI5LZzG/Z1+O3tV/rzQhuEEwfmWXlse9Dl3Ad
 +HlDITk6T5EaBTmm9rRVzmIUp7n6sYPxu60qC1vIrvdgaFoan1lSDEDWwOeZmhKVN0vmhBnbwZ0
 lI8mb5e/gKm8fTWG7X43K7P6KM56mj3EcC8xXSjKheUXU5c8kjgi2gyYNxPsopkFzCwEylE4bvc
 IAlxJFLIy3Z2wHLkDb6uaB33eWRO9Og4s32JU0M5XLd4OQTtN7KeQ2njJlsUBDrkzwHOjFJchzd
 Ig4wWuVSvRh4G59h5kw==
X-Proofpoint-GUID: Td_3S6VQg_bNYuPe10jNOFD5IqOqoLca
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8cb7de cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=54E8qG7VjNTS33wMx7AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240181
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

On 24/8/26 15:24, Daniel P. BerrangÃ© wrote:
> On Sun, Aug 16, 2026 at 11:12:35PM +0400, Marc-André Lureau wrote:
>> mon_cpu_path and reset_seen are only used by HMP monitors; move them
>> from the base Monitor struct into MonitorHMP to properly encapsulate
>> HMP-specific state.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   monitor/hmp-cmds.c         | 16 +++++++++-------
>>   monitor/hmp.c              |  9 +++++----
>>   monitor/monitor-internal.h |  4 ++--
>>   monitor/monitor.c          |  1 -
>>   4 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 6b1114fdaf13..6718fec97047 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>>   /* Set the current CPU defined by the user. Callers must hold BQL. */
>>   int monitor_set_cpu(Monitor *mon, int cpu_index)
>>   {
>> +    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
> 
> Nitpicking,  'hmp_mon' is redundant IMHO - 'hmp' is sufficient and
> used elsewhere in monitor/ code.

That would indeed match with the other uses in monitor/.

> 
>>       CPUState *cpu;
>>   
>>       cpu = qemu_get_cpu(cpu_index);
>>       if (cpu == NULL) {
>>           return -1;
>>       }
>> -    g_free(mon->mon_cpu_path);
>> -    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>> +    g_free(hmp_mon->mon_cpu_path);
>> +    hmp_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>>       return 0;
>>   }
> 
> None the less
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> With regards,
> Daniel


