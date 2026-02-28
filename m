Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B251048927
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 01:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw9OQ-0006ma-G8; Fri, 27 Feb 2026 20:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9OM-0006m6-VO; Fri, 27 Feb 2026 20:45:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9OK-0001o8-GK; Fri, 27 Feb 2026 20:45:14 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RKqtWU2347135; Sat, 28 Feb 2026 01:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a/N0Kg
 3gpsN7//5mPm2l8kIf1SnfJhAWHdM3MfRt9h4=; b=GZKbea5Ki7XeDNk5Q0z4/e
 j5r9syl8Sn1tmMZzdX5W1PMCoV1EmNttyQZq5yZ+kSo94pKkzrfu7i62ggwwm+iq
 P6DzqYIWCFduv/9pwMUWeKJZTfTnarDF442m1X654u86X6u3V1Jn6TVG16Q7iUXr
 5RnMcoxAMjn8QcRUS3n7Cci6Tkld0UbRh/AOdBvpzK2oLP+zxZ4IwUvipT8i2sIs
 89sEveTgj4+d/SErS1bTFlGTUmHXJX2/DEgl+vAONIq+xmkUoeo9D5bFIHAzVmtX
 cHB7psDyF67uwtXm9gFoesM2p+MSW6kLXVznTjsiY3GA/0/ExMHN97QQ0eQ5tgMw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8594msc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 01:45:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RNsUY9003413;
 Sat, 28 Feb 2026 01:45:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kcqq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 01:45:04 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61S1j3tA19989218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Feb 2026 01:45:03 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 628C258054;
 Sat, 28 Feb 2026 01:45:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAA415805C;
 Sat, 28 Feb 2026 01:45:01 +0000 (GMT)
Received: from [9.61.45.42] (unknown [9.61.45.42])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Feb 2026 01:45:01 +0000 (GMT)
Message-ID: <18582621-9207-4123-841c-d6af4c89f3d1@linux.ibm.com>
Date: Fri, 27 Feb 2026 20:45:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/30] hw/s390x/ipl: Create certificate store
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-5-zycai@linux.ibm.com>
 <7c6424bd-031f-4a58-80b5-1a989baf7f14@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <7c6424bd-031f-4a58-80b5-1a989baf7f14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAxMyBTYWx0ZWRfX8uv9Hkfszegi
 KN7Ww/B0/mVC+Luz6HymGN7yUv2ON3QrJBq6kgpFJzOnGm8Y4HgVI9afKOroMyS67nzx1uwqnxj
 zYygKTaw+zCom9hUG9CNE1ygjG/Ghd1yzm4O1MuDyX7LYChn5dIuF9SzJCKHGTkbqg/xnp/+2GO
 nCjVlYaRhXNf4N6jgjwJJusbL8+lvdHbRUdorcUuJLP+wPhqsuN75HDgpAF9sD5o0y5pHTJK2VF
 DgKp6IDgx5joFfG/J2MjYFFfgZ5+gkiEX/YW00kcWqpEsdBCryz94i678yi3EOsWFG0oebHWfOj
 YoDIAoZnazDWKkPOe8Zwm7aO4Gr/Z4jTwgqAX9vYm5eBwhjd+jOsXBuUgBEQS2ruXLzON1qL973
 VCaLoxglIiESa7VFBsh9aQHnp09INZxr8E32vK5VpHoVL5zMuCVirbXvmUfWitd+sCOiR6NjBkR
 Tfp2drPwEiYfYIqPqWw==
X-Proofpoint-GUID: 6P6Z_nuSKSwn476jrPCM7kzSiRJtK1VX
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a248a1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=aGgZRi6wSp843-NrvLwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6P6Z_nuSKSwn476jrPCM7kzSiRJtK1VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602280013
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/26/26 11:02 AM, Thomas Huth wrote:
> On 12/02/2026 21.43, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
>> machine type option into the cert store.
>>
>> Currently, only X.509 certificates in PEM format are supported, as the
>> QEMU command line accepts certificates in PEM format only.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
> ...
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.c
>> @@ -0,0 +1,221 @@
> ...
>> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
>> +{
>> +    GPtrArray *cert_path_builder;
>> +    Error *err = NULL;
>> +
>> +    /* If cert store is already populated, then no work to do */
>> +    if (cert_store->count) {
>> +        return;
>> +    }
>> +
>> +    cert_path_builder = get_cert_paths(&err);
>> +    if (cert_path_builder == NULL) {
>> +        error_report_err(err);
>> +        exit(1);
>> +    }
>> +
>> +    if (cert_path_builder->len == 0) {
>> +        g_ptr_array_free(cert_path_builder, TRUE);
>> +        return;
>> +    }
>> +
>> +    if (cert_path_builder->len > MAX_CERTIFICATES - 1) {
>> +        error_report("Cert store exceeds maximum of %d certificates", MAX_CERTIFICATES);
>> +        g_ptr_array_free(cert_path_builder, TRUE);
>> +        exit(1);
>> +    }
>> +
>> +    cert_store->largest_cert_size = 0;
>> +    cert_store->total_bytes = 0;
>> +
>> +    for (int i = 0; i < cert_path_builder->len; i++) {
>> +        g_autofree S390IPLCertificate *cert = init_cert(
>> +                                              (char *) cert_path_builder->pdata[i],
>> +                                              &err);
> 
> I'd maybe write it like this to decrease indentation:
> 
>          g_autofree S390IPLCertificate *cert =
>                     init_cert((char *) cert_path_builder->pdata[i],
>                               &err);
> 
> ... but up to you, it's just cosmetics.
> 
> ...
>> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
>> new file mode 100644
>> index 0000000000..50e36e2389
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.h
>> @@ -0,0 +1,41 @@
> ...
>> +struct S390IPLCertificateStore {
>> +    uint16_t count;
>> +    size_t   largest_cert_size;
>> +    size_t   total_bytes;
>> +    S390IPLCertificate certs[MAX_CERTIFICATES];
>> +};
>> +typedef struct S390IPLCertificateStore S390IPLCertificateStore;
>> +QEMU_BUILD_BUG_MSG(sizeof(S390IPLCertificateStore) != 5656,
>> +                   "size of S390IPLCertificateStore is wrong");
> 
> Why is there a QEMU_BUILD_BUG_MSG here? As far as I can see, this is not a 
> structure that we share in the API with the guest, is it? So if this is just 
> internal to QEMU, the size of the structure should not matter here, I think?
> 
>   Thomas

I initially assumed that all non-packed structs should be guarded with
QEMU_BUILD_BUG_MSG to prevent padding changes.

You are correct that this structure is only used within QEMU. If the
size is not relevant in this case, then it should be safe to remove the
check here.

> 


