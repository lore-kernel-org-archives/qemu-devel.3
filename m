Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E34CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWamF-0003Ca-Q6; Mon, 08 Jun 2026 10:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wWam7-0003Bj-EE; Mon, 08 Jun 2026 10:16:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wWam4-0003NX-WA; Mon, 08 Jun 2026 10:16:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6589kWE83408398; Mon, 8 Jun 2026 14:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=64xIJW
 w1AMKL8GO58zHE7O9D5ShUo66kzybtdjo60yI=; b=p1kB2J/vs0F4OyY4TaGDIy
 tzH7pC44bEtR7m2kyXVUhNWf49kSnICC7hsYNURy/DE+31oPQtn9sEOqyF2dSa8o
 vXUMUZX7lgU03h5ihFvnVsSyEnSCzgyEkx2zs19R9G6Wgz8DnbQcmtCckueL3E8U
 7AYHKvommhECcNe/x3a0ypPakMqJ4T4+6xK1mDcIDBME5QzmsqzlUGsIFgp+WNyI
 Re02zOtK8hA8iOOceKugZbBsENkQ1bPq5kzCYyoTzPgfUKIX0mnQBstiE9iNKVSJ
 Fo+pstwHPUoeJsPkLCebOOZ/FBuAjf9HucWL5YwgoR8QkxJFI5S5I+6G85v4d90g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhqtdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 14:16:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658E4bf8005677;
 Mon, 8 Jun 2026 14:16:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpwsw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 14:16:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658EG8rs3605166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 14:16:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF2B458063;
 Mon,  8 Jun 2026 14:16:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6DE55803F;
 Mon,  8 Jun 2026 14:16:06 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  8 Jun 2026 14:16:06 +0000 (GMT)
Message-ID: <ba4c0775-5679-478c-8b7b-cae9bc656a52@linux.ibm.com>
Date: Mon, 8 Jun 2026 10:16:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-10-zycai@linux.ibm.com>
 <ce623f2a-9247-4a67-98a0-7a180fdb88ca@linux.ibm.com>
 <f5998015-159a-4d67-b006-092d20d91c2c@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <f5998015-159a-4d67-b006-092d20d91c2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfX7xCvHhpjSzjj
 6gMADdiV+d45XYSjjVVDb5h+GN7uV+VJDY3RiwhzkV3AFq56IXqx73hu5Rms0eR3EsMZa9qLt3j
 VaL5ayodyFt2/Rh9ZClhSVIste79/NVTwk9qEOO/Kgjuvcu6HxbbTKe9+g6iAo8oQwVYIrcUaag
 t5pTOwo1iJ011IaLN0H9At9tDmysbSOUGs3HElrwesxt2rhEp01inMNXyVqP4Tjofj2Pjiprr/g
 CAd10Uw8rnAR0dNOqPwnCb5xaFAwYF5KO5qwNPPb53AIZTS3b6aBQqwRqyJHnpV9UFPjy/0VHtM
 HIckI/nFDZqSL2u+DuvWLTktQWLoW+/xuJtLAy9DdGqPFtFc8MxP36vPbQni9oXvrS1ou3Oxeh3
 oignkxDq4qnmiL92a74joNvC4Ppto7YivHUrHVy4h9jbLKAG4PUrFteii0QVUBOi4Rq2KDXm/UD
 mCjEgurE7hlvkPCoOZg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26cea9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=x_i36jWCeggssP13cGMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pRWGTZgwM4hC3A42oppnublQJLT6i6Jm
X-Proofpoint-GUID: pRWGTZgwM4hC3A42oppnublQJLT6i6Jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/5/26 3:20 PM, Zhuoying Cai wrote:
> Thanks for the feedback!
>
> On 5/24/26 6:32 PM, Jared Rossi wrote:
>>
>> On 5/5/26 4:18 PM, Zhuoying Cai wrote:
>>> [...]
>>> +
>>> +    rc = handle_hash(vce, cert, keyid_field_len);
>>> +    if (rc) {
>>> +        return -1;
>>> +    }
>>> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->vce_hdr.hash_len), 4);
>>> +
>>> +    rc = handle_cert(vce, cert, hash_field_len);
>>> +    if (rc || !is_cert_valid(cert)) {
>>> +        return -1;
>>> +    }
>>> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->vce_hdr.cert_len), 4);
>>> +
>>> +    vce_len = sizeof(VCEntryHeader) + keyid_field_len + hash_field_len + cert_field_len;
>>> +    if (vce_len > be32_to_cpu(vce->vce_hdr.len)) {
>>> +        return -1;
>>> +    }
>> We already used the maximum size when we allocated space for the VCE, so
>> this
>> check is redundant I think?
>>
> Although exceeding the maximum size is unlikely, I think it’s good
> practice to keep this check, along with those in the handle_* functions.
> These checks help ensure that the actual lengths of the certificate
> metadata retrieved from the qcrypto functions remain within the defined
> limits.
>
> Please let me know what you think.
After taking another look, I realize this check is not redundant in the 
way I
thought it was.  As far as I can tell, when building the cert store, the 
size
of each entry is checked using the largest_cert_size variable, but we never
validate that this value is within our max cert size.  So the check here is
actually the first time we validate the total size.

In my opinion we should check this in the update_cert_store() function 
that was
introduced in Patch 4 and gets called as the cert store is populated.  I 
guess
this ties back in to some of the other comments about defining 
MAX_ENTRY_SIZE
earlier in the series.

Maybe we could detect invalid certs earlier if we add a secondary check that
data_buf_size <= CERT_BUF_MAX_LEN when updating largest_cert_size.  I 
think both
update_cert_store() and build_vce_data() are doing the same size 
calculations,
right?

I think we have all of this information available to reject certs before 
they
are added to the cert store.

Regards,
Jared Rossi

