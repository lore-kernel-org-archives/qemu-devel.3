Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD37FCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5jJ-0003Yf-1M; Fri, 29 May 2026 18:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wT5jI-0003YA-1K
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:31:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wT5jF-0000WF-CC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:30:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LxK2998027
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 22:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L1D2r0SvESpY7BywsROF9DfNK4tc1iiarW+Lbc11LaY=; b=H7mugs/VeidxaOYz
 JC2UWriA19XVgfuiPNy2au3WIKrLuD9+tWRppe6E7rZXR1indV8eAGu6Fmk57PnV
 1IxVpp6/ncfdAddDABV7D/AHDCK7+Jia1Ch8M5Meqt5nHU0NEPvV96uWl00XnoF8
 MvdjIqtLHkM7qt62vfKXUnUzu+E6t6qgBsVj5bQ9VKpeiNRrR2OK4nZaHRu6Ox3r
 GXqfKM96Tc32Hwezdo+IACkHWiIiiljLpu87oKjkKzS6pIBMg33cmaIgh8FcQqP1
 kFkHe5r3Fix/+AsVhpV2/WpKd2yUtgiGuwboP7QALGbO8J6Rohwxoutes5mgxS50
 3yyj4g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4hwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 22:30:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ea42b025so420921eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780093852; x=1780698652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L1D2r0SvESpY7BywsROF9DfNK4tc1iiarW+Lbc11LaY=;
 b=biKIdvJov0yTOlLptzW7MT1F7WQbbrSaEAFRmarvoAcp66iJQFrKVY6rOu6KIjWYnJ
 q2uzNIyXiQ/YS7I4YtBXRTduvrAzX/qhCavZeP58L7ZwPLmC6l/G/rIJ9SNdpo2h308B
 S80qotc5CYmF3jwS6PwX8BjUk0XqsyKkHHtSJyIMAS9nOfJwxLAgdkeUx61uTr1afKQ1
 gC6xhTqGp4TvK3s+vXYkd6YEk4D4oz0/F827MQHwLAK8iUcXUleE48HDxEeG4gue773z
 eqxt1MNr7MvzwJ71OS2eZ1k+U0rz7djzTXFvLdqgh+EZ1gYHP0HmTFnX2utOGgFVqM0C
 Vdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780093852; x=1780698652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1D2r0SvESpY7BywsROF9DfNK4tc1iiarW+Lbc11LaY=;
 b=He88UfPAFcnNSVg85ECjgBm9/p9bW4v2NsYg5NsOdqJBkbVFSFCnhBAnVhoyQkiZtu
 NJ0LSzuXjM2vJweC5YPOw+sfP24aaQtFFSobH9rrEsPek0Ps0Qlp3s89EFtw+c1fp5aG
 6vwNcstu+5G9F2dAmxTxM/+xlYDJt/HWuxbf6OCu8NnMcbD6ktE9xnWHpxHW/hdjYVTl
 t11KZanmhVz4SCSKWAk6ipAy0Gj+lvRUqnBnY+F4g/960nJ+bYommIozjTRkPJUjlznL
 y8tAbSYTU9NYs4BQPO6Kyawhy1LY5lhG4A2EhgKL7IsBwVfxOHs47hzsh1m/YrPxaGxz
 ew2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NHeiWjkuJHt01ldrruZE111mZzCa118TPcIusMH9GTx5rQtASmoRtFvn6d3ih42I16dLxYZieCxuF@nongnu.org
X-Gm-Message-State: AOJu0Yz7uKgTX3tVwbbx4vP5ZNQVvn90amfLayH9shaSUhmqy4zDj6kS
 aEQt0pYQC0mrTp/z3cjdPiErHXtfGOiQGnDzr8tCV7uuO3iyCPMrim7nkqu2XjiiLFNLFuhIT5t
 s+sWcUbx1Ihhm+SHFBADKwhgDzxV7WUfg2B4P8l9uqcYs/NX2F9RrskemTw==
X-Gm-Gg: Acq92OGydtDtM2DZq59Pmbpud4PvLE028P7d1XaAvotgwSVVYW5hoLGMJycPG1x6VeM
 4WxN0T8h8++fF4RXrBpo6pFhdeIDo2hyQZVoYMW6oX+xuSiBsZ/JxlcoZmvQDR6SNSx2NiXraEB
 DUB3gWPP2G/F5HLlfsh914vJHrFtByGYJM2iRS6rxQypzXEqaLKjoYHbeZSx3xacqRh80ehDTZ1
 b4ZNwJ+lgNtV3mHKat15XJCHaelcC7DMhtAkphjNK1pZQrHXIIIhk59GWZd3ulCxccDIrDWwS8e
 7+Xs7Ql60+/PJLjadbDneWXwl9Atu4b+jDoF4rxfgWqwFJk1znYuCB+eS0edFVYE0pfakhXrpmC
 BkEH8PnM6l4k3eLM5vqDCyUpOlSbVtWEpiL3HIfHVGHeKOeyK+IrW/gHQ73oxqnwd9akptSA2uo
 z7PGyEuQn2HSE7Pg==
X-Received: by 2002:a05:7300:371e:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-304eb1fed14mr2024241eec.18.1780093851830; 
 Fri, 29 May 2026 15:30:51 -0700 (PDT)
X-Received: by 2002:a05:7300:371e:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-304eb1fed14mr2024230eec.18.1780093851253; 
 Fri, 29 May 2026 15:30:51 -0700 (PDT)
Received: from [10.110.86.149] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm2567458eec.5.2026.05.29.15.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 15:30:46 -0700 (PDT)
Message-ID: <f29da65f-3a66-4c2b-abde-d4d9e14cd184@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i3c: rename DW-I3C queue capacity fields from
 _bytes to _words
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, clg@kaod.org, 
 jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, qemu-devel@nongnu.org,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260529014034.864722-3-jithu.joseph@oss.qualcomm.com>
 <4b1e3557-246f-4218-b14c-b4191f899aff@linaro.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <4b1e3557-246f-4218-b14c-b4191f899aff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIyNCBTYWx0ZWRfX74alKsAltNJ7
 X3oksZ8r1YjgdxCF/9CohGhqpfq9xg0RBGCgfs/g0KUE3Rt/B3+8fqiL7dBch6jm0RhClRS2tfZ
 Rt7moQ43A/LPbkJgY/JH9H7KyuBIbPGjtHSGt2+6OyLnYhf3wXYMwpw4MGgGRsMBpbm34UOOIWV
 oQWwEUS0QDBF8ux8PNYzTqjuNPLDyYZ22DS4rc9w/7iL6CTbWC7ZGiBWyAeOULRiewSUsfmlwxE
 Ky1koM6fWlYewneiFAhopDmUIZLJIH3bAepi4bg0G6gJG4QgcVIq889iosTd2uROZ9G7VuRvBrh
 Fhl1Zb//5uq1n4gvcG8XwiwLdmxVS0wipAd07wXzL9mu2n4caop4ExJHW4HD1fTQ/NArqfi01lz
 sHGU+4yMNLDs/gMXrbcqSRgNd22sqzVTLJ1ztVK31xIzDdOPkVOQWh4ODhUdgymFkSd9iVTatQi
 tQynMMlFj1rzFdyl0Wg==
X-Proofpoint-ORIG-GUID: oQxWMSFIQTpiQ28zHfOtJOa0LFwLy8ip
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a139c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=vyrdR5AXxAAKuoWMauMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: oQxWMSFIQTpiQ28zHfOtJOa0LFwLy8ip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 5/28/2026 11:17 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 29/5/26 03:40, Jithu Joseph wrote:
>> The cmd/resp, tx/rx, and IBI queue capacity values are passed straight
>> to fifo32_create(), which interprets its capacity argument as a 32-bit
>> word count.  The fields and device properties were therefore misnamed.
>>
>> Rename the three struct fields and matching device-property strings:
>>

...

>> @@ -1824,12 +1824,12 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
>>     static const Property dw_i3c_properties[] = {
>>       DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
>> -    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
>> -                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
>> -    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
>> -                      cfg.tx_rx_queue_capacity_bytes, 0x40),
>> -    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,
>> -                      cfg.ibi_queue_capacity_bytes, 0x10),
>> +    DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
>> +                      cfg.cmd_resp_queue_capacity_words, 0x10),
>> +    DEFINE_PROP_UINT16("tx-rx-queue-capacity-words", DWI3C,
>> +                      cfg.tx_rx_queue_capacity_words, 0x40),
>> +    DEFINE_PROP_UINT8("ibi-queue-capacity-words", DWI3C,
>> +                      cfg.ibi_queue_capacity_words, 0x10),
> 
> Properties are user exposed, should we keep deprecated aliases?

Technically they are reachable via  a qemu commandline parameter like "-global "driver=dw.i3c,property=tx-rx-queue-capacity-bytes,value=64"" ... 
However,  the _bytes properties only controlled the internal FIFO backing-store allocation (fifo32_create())
The advertised reset values in QUEUE_STATUS_LEVEL/DATA_BUFFER_STATUS_LEVEL — which are what the Linux driver actually reads at probe — were hardcoded and ignored these properties entirely. 
So a user setting tx-rx-queue-capacity-bytes=N in v11.0.0 would have changed the internal allocation but had no effect on the guest-visible depth.
The property was never fully wired up, so there is arguably no correct external behavior to preserve (other than somebody's qemu commandline not starting  with an error like can't apply global dw.i3c.tx-rx-queue-capacity-bytes=64: Property 'dw.i3c.tx-rx-queue-capacity-bytes' not found)

That said, if you feel a deprecated alias is warranted, I dont mind keeping both (though my preference would be to just keep the correctly named properties alone, to avoid confusion)

> 
>>       DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
>>                         cfg.num_addressable_devices, 8),
>>       DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
> 

Thanks
Jithu


