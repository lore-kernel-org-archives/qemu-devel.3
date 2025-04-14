Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D6C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4O0G-0006ys-Gp; Mon, 14 Apr 2025 13:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u4O09-0006xx-6l; Mon, 14 Apr 2025 13:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u4O05-0002tT-6H; Mon, 14 Apr 2025 13:53:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAeQ3L010420;
 Mon, 14 Apr 2025 17:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2MhIM/
 A/LFUmEOlozDd6kef0Z1QR9BNyaI/EBpLW5JQ=; b=VPrGASKV8Ox7vTDVpOm+Qt
 kWRSmNQfwnuWvzHpY7sMFlQwqC9GCAG/WkjMrPJUI+D3WwyRqcEWp76QTUmKqdR5
 jyRz+9Ks/pTrh+axPGwgbpeWiLtV0iOpoPUDWWkRc6XxBmJ0Q8s91eJ0AcTP82wT
 v8otRpWem2/OzMqo0lo3JxC+6r3Y4jNxQGfc7egN8A0DP79tBf88lgnu2N3zKTEr
 0E/rV7fEM8YqOk/LygjdfxCLoH5jSeDpyZdnA9Gp4dXynt0u5NypSTtLOi9CbdpS
 ttFjiY5ApKD9upoz7Qgowk/HORWxcCHBXNlCf0chxOmLwZslMizoRNHZNpHnv0AA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tpa1a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 17:53:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHk14x010387;
 Mon, 14 Apr 2025 17:53:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjy3e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 17:53:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EHrX1m26739030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 17:53:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAAE05805A;
 Mon, 14 Apr 2025 17:53:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1703C5805C;
 Mon, 14 Apr 2025 17:53:33 +0000 (GMT)
Received: from [9.61.117.19] (unknown [9.61.117.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Apr 2025 17:53:32 +0000 (GMT)
Message-ID: <8d3fa077-84ac-4964-a03f-6c4b335ae54b@linux.ibm.com>
Date: Mon, 14 Apr 2025 13:53:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/24] s390x: Guest support for Certificate Store
 Facility (CS)
To: Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-4-zycai@linux.ibm.com>
 <1ea0eeb4-796d-4970-84d9-e46dda888aa2@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <1ea0eeb4-796d-4970-84d9-e46dda888aa2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aor217e1qE4CZnYeg_f5Mux-bWS40l7C
X-Proofpoint-ORIG-GUID: aor217e1qE4CZnYeg_f5Mux-bWS40l7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 4/11/25 9:28 AM, Thomas Huth wrote:
> On 08/04/2025 17.55, Zhuoying Cai wrote:
>> DIAG 320 is supported when the certificate-store (CS) facility
>> is installed.
>>
>> Availability of CS facility is determined by byte 134 bit 5 of the
>> SCLP Read Info block.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
> ...
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 4b5be6798e..99089ab3f5 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>>           break;
>>       case S390_FEAT_TYPE_SCLP_FAC134:
>>           clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
>> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>>           break;
>>       default:
>>           return;
>> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
>> index e23e603a79..65d38f546d 100644
>> --- a/target/s390x/cpu_features_def.h.inc
>> +++ b/target/s390x/cpu_features_def.h.inc
>> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>>   
>>   /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
>> +DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")
>>   
>>   /* Features exposed via SCLP CPU info. */
>>   DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 93a05e43d7..7d65c40bd1 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
>>       if (s390_is_pv()) {
>>           switch (feat) {
>>           case S390_FEAT_DIAG_318:
>> +        case S390_FEAT_DIAG_320:
> 
> So secure IPL is not available with secure execution? That's surprising. 
> Could you add a comment to the patch description why this is the case?
> 

Secure IPL is not available for Secure Execution (SE) guests, as their
images are already integrity protected, and an additional protection of
the kernel by secure IPL is not necessary.

I'll provide more context in the patch description for the next iteration.

>>           case S390_FEAT_HPMA2:
>>           case S390_FEAT_SIE_F2:
>>           case S390_FEAT_SIE_SKEY:
>> @@ -505,6 +506,7 @@ static void check_consistency(const S390CPUModel *model)
>>           { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
>>           { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>>           { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>> +        { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
> 
> Please also add a comment to the patch description why this feature needs 
> S390_FEAT_EXTENDED_LENGTH_SCCB.
> 
>>           { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>>           { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>>           { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 41840677ce..52c649adcd 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -696,6 +696,7 @@ static uint16_t full_GEN14_GA1[] = {
>>       S390_FEAT_HPMA2,
>>       S390_FEAT_SIE_KSS,
>>       S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>> +    S390_FEAT_DIAG_320,
> 
> Is it available with the z14 already? 
> https://www.ibm.com/docs/en/linux-on-systems?topic=linux-secure-boot seems 
> to indicate a z15 instead??
> 
>>   };
>>   
>>   #define full_GEN14_GA2 EmptyFeat
>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index 4d56e653dd..d07ca879a3 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -2487,6 +2487,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>           set_bit(S390_FEAT_DIAG_318, model->features);
>>       }
>>   
>> +    set_bit(S390_FEAT_DIAG_320, model->features);
>> +
>>       /* Test for Ultravisor features that influence secure guest behavior */
>>       query_uv_feat_guest(model->features);
> 
>   Thomas
> 


