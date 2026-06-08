Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C95CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcHV-0006Ri-E1; Mon, 08 Jun 2026 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wWcHQ-0006Q2-7g; Mon, 08 Jun 2026 11:52:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wWcHM-0001rE-Gs; Mon, 08 Jun 2026 11:52:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658D5v7D3671261; Mon, 8 Jun 2026 15:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qUYk7+
 V/RjQMlLcLLBwL3X2NEJ6jdo0ANx0LHNL2oI0=; b=Wfr1WtiYqOUC9jSk/CPso8
 5dHrdSuBvNeggjbIJGNqOtCnyZYStV0JYnidBsnRSTbeK/cxI2PVqm9XcaoWN2RF
 rdf/z7eWnB7yI77bjZZTSDXZLb6+Y8M1NMfgQjVl+CvDUpWSgeXFI8ycrw84ML2f
 nLSl9Y9HZ3MYYVZc3pjg8psiGcbymCvVd1ZYsW1d5rt3dRTUJfgAG/wZeKidpEdk
 41RHAsQuT7+0U+h/Ye71W20YXm+R0IRmBH/4LrCD2OvT8cJZpXlUmBtUPWA1uDBA
 q8duBF2qyrq6a4EL0vaMDcmCvnJzUEVVlqiggHEHhjXEqXe1cucGjZzop8ZZiA1A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23r4at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 15:52:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658FnjWY017939;
 Mon, 8 Jun 2026 15:52:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgwwwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 15:52:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658FqalD21758630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 15:52:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49BDA5805F;
 Mon,  8 Jun 2026 15:52:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7583A58053;
 Mon,  8 Jun 2026 15:52:34 +0000 (GMT)
Received: from [9.61.179.4] (unknown [9.61.179.4])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 15:52:34 +0000 (GMT)
Message-ID: <c535c202-b167-4c6b-b38c-859ff06aa56f@linux.ibm.com>
Date: Mon, 8 Jun 2026 11:52:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
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
 <ba4c0775-5679-478c-8b7b-cae9bc656a52@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <ba4c0775-5679-478c-8b7b-cae9bc656a52@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26e547 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QOAFqgbR-mcsm-3LhfsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2G5HpOFl3wDPin_vHGg3bRmL3rPCBHuF
X-Proofpoint-GUID: 2G5HpOFl3wDPin_vHGg3bRmL3rPCBHuF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0OSBTYWx0ZWRfX8TfQXlqxXoGI
 IxVSFL4McPbBGG+odyzm4DYdI7szo8uJmcPd+hT6Ok7g+Mp5w+Z3ipy7gd+GoWR5RIwoVs10Zfm
 r7uabTo5GF6zQwHsQzQEeMgawUdXXskcacq9eAYXiio0VvoB/nQ4W2VusReXEBg1e0X9Il4KjOb
 ejOFhmyQFrZlDB0NMNaWN1CuxjmAuXUg1bbKM73o9Ya+s/hQnO3PcM9YoLHGkCPZ15/rcAovTZ0
 ih+hX1Te9DqTipu8DrptRfZbogfnvC9YDOM/UcoKkMpF2ZXAOgKxrMPwB+Da7t0jOR5sX/VDIXU
 JqPyDcTAkdjuH3AWqjoUv6I4dNtl0643EhlNDEWnwLLFwQaUn75VcQnTuDEtc0BcIHNJqZE9os0
 FPeyT+Pk1rfdx1QSI82ZknvmB0F5eleGVCHBtS8Y2OCl1SOAVUADTzXX0SQfHpXKyJHbY2dmGF2
 xDSsjKoJ78QmOFZNO1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 6/8/26 10:16 AM, Jared Rossi wrote:
> 
> 
> On 6/5/26 3:20 PM, Zhuoying Cai wrote:
>> Thanks for the feedback!
>>
>> On 5/24/26 6:32 PM, Jared Rossi wrote:
>>>
>>> On 5/5/26 4:18 PM, Zhuoying Cai wrote:
>>>> [...]
>>>> +
>>>> +    rc = handle_hash(vce, cert, keyid_field_len);
>>>> +    if (rc) {
>>>> +        return -1;
>>>> +    }
>>>> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->vce_hdr.hash_len), 4);
>>>> +
>>>> +    rc = handle_cert(vce, cert, hash_field_len);
>>>> +    if (rc || !is_cert_valid(cert)) {
>>>> +        return -1;
>>>> +    }
>>>> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->vce_hdr.cert_len), 4);
>>>> +
>>>> +    vce_len = sizeof(VCEntryHeader) + keyid_field_len + hash_field_len + cert_field_len;
>>>> +    if (vce_len > be32_to_cpu(vce->vce_hdr.len)) {
>>>> +        return -1;
>>>> +    }
>>> We already used the maximum size when we allocated space for the VCE, so
>>> this
>>> check is redundant I think?
>>>
>> Although exceeding the maximum size is unlikely, I think it’s good
>> practice to keep this check, along with those in the handle_* functions.
>> These checks help ensure that the actual lengths of the certificate
>> metadata retrieved from the qcrypto functions remain within the defined
>> limits.
>>
>> Please let me know what you think.
> After taking another look, I realize this check is not redundant in the 
> way I
> thought it was.  As far as I can tell, when building the cert store, the 
> size
> of each entry is checked using the largest_cert_size variable, but we never
> validate that this value is within our max cert size.  So the check here is
> actually the first time we validate the total size.
> 
> In my opinion we should check this in the update_cert_store() function 
> that was
> introduced in Patch 4 and gets called as the cert store is populated.  I 
> guess
> this ties back in to some of the other comments about defining 
> MAX_ENTRY_SIZE
> earlier in the series.
> 
> Maybe we could detect invalid certs earlier if we add a secondary check that
> data_buf_size <= CERT_BUF_MAX_LEN when updating largest_cert_size.  I 
> think both
> update_cert_store() and build_vce_data() are doing the same size 
> calculations,
> right?
> 
> I think we have all of this information available to reject certs before 
> they
> are added to the cert store.
> 
> Regards,
> Jared Rossi

Thanks for taking another look.

The current version I’m working on defines MAX_ENTRY_SIZE in the current
patch (s390x/diag: Implement DIAG 320 subcode 2), since that’s where it
is used. In the next patch (hw/s390x: Define maximum certificate buffer
length), I define CERT_BUF_MAX_LEN (MAX_ENTRY_SIZE -
sizeof(VCEntryHeader)) and add a data_buf_size <= CERT_BUF_MAX_LEN check
before updating largest_cert_size in update_cert_store().

update_cert_store() uses expected size values, whereas build_vce_data()
uses actual size values, but these should match. With the
CERT_BUF_MAX_LEN check in update_cert_store(), invalid certs would be
rejected before being added to the cert store.

I thought it might still be good practice to keep both checks to ensure
the size from build_vce_data() stays within bounds, but I may have
overthought that.

If you think the check in build_vce_data() is redundant once we add the
validation in update_cert_store(), I can remove it. Should I also remove
the checks in the handle_* functions as well?



