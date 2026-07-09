Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25669C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpwH-0000lF-Q6; Thu, 09 Jul 2026 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whpwH-0000ke-2q
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:41:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whpwF-0002LF-Hq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:41:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DwPFJ2014470
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F/MEHsgY09tIfxmk11wChFOkw+/ArJxt14+6bvFwW9k=; b=WNq3a4hhaYYBNpmu
 aLC8fu7zUNEar51OHMk2bzKIcjIJ5sdeCcd9/37e7kQT5qtzyuRYVrgAdYsw+3wY
 0X3RjgQUcOh+rWxgBa10Y0Dl8lkMkT/oy/WRXacetzFrK0FqNJ43eqktcTbl0oam
 8im28qjyX1GeW1MSUsg4y70aXzzUGDE+XSTo4FNiwxP9jRpEVLb4cYzIWBEGiO1Q
 1herrb78XceMhdeltZydHZLT+XkDGiRwGBfY87ZzW1ivboUyZZdXMJ6XDeVUzhAB
 SEXmiaf4qI5SQ4/kD6/1LqMeYCbgQR/cMTxr59L1wXcWj6bISDoV807H+AfPMyAy
 AoJoVw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6mbb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:41:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c083f1818so18846231cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783608078; x=1784212878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F/MEHsgY09tIfxmk11wChFOkw+/ArJxt14+6bvFwW9k=;
 b=iWumnNDDNukgxCmbonvBWjLoXhaOlv/+VShQS2c6Wql/aBou41ifUa7jVIZ3e2EvQv
 4zVaDFPO6MI4Gcl49kKpuWcxevkJPhRlNBn9ZHod8Zb82PpEwW5MQ33z8J2WTb3UG+i9
 Zr2ejklnU22ov+EXaxeb3GYN4cGZ6TkHPQAWO9cLbFulzaAKr4/EocYBc2DG/crKm2KB
 yQI2slYUebx9iO8Nw1YG7YBlPWAUXUdlD1G4T+CxC+nMfrEyvCUi/2qxMS1DztQKIdjJ
 G1Dm1Sn8paAXpCMNVtXrGNtKIm6+DC4yFKPzx02r0XOzyg0Q6zyB8oYgWOf9LZWU1ZX4
 08bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608078; x=1784212878;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F/MEHsgY09tIfxmk11wChFOkw+/ArJxt14+6bvFwW9k=;
 b=S0NHfcqx+YILNIeq3w4RuzHWkXiEPMtX1083DvzRP5P4toLoqnTyoDVt5JrOq4JMNW
 Yzd/4oKwNAYEQSjgU2i5JJbMjxrvsAS0OmCmeDRDcoXR00C3L39zsM1AQ981tZPkrDKj
 Vwo2e13sIUfKTYl6vN+y3LzmL626v9MGpWANcZVPPRE+8fhmSoDjmS9bkhX7uq8mi7Bv
 tlyfD1FztctfPuxk1httmuDaJVGU2mR5oj//+QilRzZS6Zr5bRH8lzWXZudsnP5n3CH1
 1o5oHVvMit0gdsViBZshhORJhVNsnzLlukpVMXwOqgY3IfGWSjWORRCNZP6Pr9scLPZ3
 Q5Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCcdk4U3Lc4A4p1Rr4R9SHnWYjaUZjo0Zzkts41acYZmRM4x9kf2ri3f9sK6lshi5h+YU/2bXRh6ob@nongnu.org
X-Gm-Message-State: AOJu0Yw8Z7ZUb774bp7J07mV/DCdrkxTEhPVSrGUmiRT3KHeZEZrn4AV
 1UnkPnVooWKRkBSfhXgjrRAyU2ZBkX2PKkAgHWJ9+eKpKrwEcKT+QjQ0pm0lOSdVg6lXy+2N00R
 EE893rt6xcnwQMScOt1OaRGxNST3lccrcsEh6BtSVrt7DBWAfepMwyzdgWg==
X-Gm-Gg: AfdE7cmekuBr5SJmazvvmILqHoOp4tM7Ij4a+esuuLfScSbS+Xzd5OPLw7n6KtiEoCa
 44M6KsIm+7k+BjqtL3yBsjcPv4ZMPRPdA/YPcAkRBT4Dng76yvYTYhx5D/OG+htDxt29jnExLz6
 V7TvQllhZct/4GwsuBjlx3jFJUBLYW/HcyIE0o82n+DFB+1DPSqrJInKPwKDQWg4JbPrNMX7WN+
 mKAtrwkmUCAf2VquNr4xXlFj2NtLYIRCQDRMTlHRxPxtGwFNI7Haxwya1ZlLRXWbI65SZKJ41UJ
 2pWNCLuVFaixztNyg/6A45i7NDp6AnEngB477XALc2Zkf+99FoZFhkDvGrz8o0cO+7xZ8+3aQAz
 u/zd87DW/ayj0LLgBikBpnzT6m/HH2jze8NmcP02ycC1VK67gcO6HUxWSmmalCg==
X-Received: by 2002:a05:622a:1:b0:51c:e78:6213 with SMTP id
 d75a77b69052e-51c8b3cbf15mr90396411cf.57.1783608077826; 
 Thu, 09 Jul 2026 07:41:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1:b0:51c:e78:6213 with SMTP id
 d75a77b69052e-51c8b3cbf15mr90396061cf.57.1783608077372; 
 Thu, 09 Jul 2026 07:41:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb705e22sm53044145e9.6.2026.07.09.07.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:41:16 -0700 (PDT)
Message-ID: <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 16:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pvscsi: translate data endianness
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, shankerwangmiao@gmail.com,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-s390x@nongnu.org
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
 <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NCBTYWx0ZWRfX5bMq5pKUv0GO
 GlO1gEw7Cfc6cPC6wXrdlbaQyS6CIrktoVoMH45IOWktcqVkRHQkOi7FJC0nSYcyBif55IATA9n
 LupZxOLIxKkZOVGkUq4S5XLP1z4pUhg=
X-Proofpoint-GUID: 4JERzMvg9vAMSyfenrNe4WcO6M77BgFr
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4fb30e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=dD9blWidltQKhXxuiYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 4JERzMvg9vAMSyfenrNe4WcO6M77BgFr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NCBTYWx0ZWRfX3dnj15XldC1A
 /yxZ4RCt3lhXxKyuluewrHNAix8EOgQEduhPwT0skQbVyyLdOYsFsjh9lFsi6kSsJV8diHIfIK9
 uaxijB29D2OooWo6n2B79k9F1uxUzZULgBHbi2KYhDbK4jLJllfgQK0SSDSSQmGJXAMNS7+yVXY
 yVkebYZT3Rx2N1xy7MlJKdmY+6CnHpndmRFegEoeR0UgH6LtfBa4aYJ50LuBALrhdY01xhrpzqp
 T1hRiyEv4GWEFY0Ff4OxPPNumKxAMrAe9oMQbiOpVSAFNcMgmB9PQx20Lfbq0xnteq/nSWe8sCv
 B6eMkTFazPnk/m0PSxdunaznTBAQweGwoPf7i1DV1DiMC047cxhiBXFS0gxRZT5eWyScei+GIhB
 lLHjZ0gmAEwgeoHImcHmaq3HwZEJb7t9ZOXrPgUyMalvCU17ZLTemRY41IlqDknEWHLFoqjNYGP
 ImLqLiDl9ylajdBl2OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090144
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

On 9/7/26 08:39, Michael Tokarev wrote:
> On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>>
>> This patch improves the implementation of the pvscsi device by
>> translating the endianness of the data sent or received from the guest.
>> This ensures pvscsi can work on big-endian hosts with little-endian
>> guests.
> 
> Hi!
> 
> Can we pick this one up for 11.1 please?
> I know right to nothing about s390x internals so can't really review
> the change.  But the fix seems to work, and it should be picked up for
> the stable qemu series too, it loks like.

I tagged this for review and forgot. Basically we shouldn't using
tswap*() anywhere in system emulation except semihosting. Here it
seems reasonable to use cpu_to_le*()/le*_to_cpu().

>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>>   hw/scsi/vmw_pvscsi.c | 58 ++++++++++++++++++++++++++++++++++++++++++ 
>> +++++++++-
>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
>> index 
>> 11ae6b9b7474b9bc87621137eb7911361b5fd721..883dfe9b6b5dc687737de356da02fe5f68aea7ad 100644
>> --- a/hw/scsi/vmw_pvscsi.c
>> +++ b/hw/scsi/vmw_pvscsi.c
>> @@ -35,6 +35,7 @@
>>   #include "hw/pci/msi.h"
>>   #include "hw/core/qdev-properties.h"
>>   #include "exec/cpu-common.h"
>> +#include "exec/tswap.h"
>>   #include "vmw_pvscsi.h"
>>   #include "trace.h"
>>   #include "qom/object.h"
>> @@ -392,9 +393,18 @@ static void
>>   pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
>>   {
>>       hwaddr cmp_descr_pa;
>> +    struct PVSCSIRingCmpDesc cmp_desc_conv;
>>       cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
>>       trace_pvscsi_cmp_ring_put(cmp_descr_pa);
>> +    cmp_desc_conv = (struct PVSCSIRingCmpDesc) {
>> +        .context = tswap64(cmp_desc->context),
>> +        .dataLen = tswap64(cmp_desc->dataLen),
>> +        .senseLen = tswap32(cmp_desc->senseLen),
>> +        .hostStatus = tswap16(cmp_desc->hostStatus),
>> +        .scsiStatus = tswap16(cmp_desc->scsiStatus),
>> +    };
>> +    cmp_desc = &cmp_desc_conv;
>>       cpu_physical_memory_write(cmp_descr_pa, cmp_desc, 

