Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC4DD73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 20:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlYYn-0007pR-K2; Thu, 29 Jan 2026 15:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vlYYm-0007oG-Gd; Thu, 29 Jan 2026 15:24:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vlYYk-0003ne-PL; Thu, 29 Jan 2026 15:24:12 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEKD2t029482;
 Thu, 29 Jan 2026 20:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UyU3dK
 ++UdeaDqtT/avPfpuBrHvDA1Uz2a9KrZYelj0=; b=Lv98KukWn3Oax+UkwLmdY9
 mkEpzymvF9FohspfZfLvPmsv0oJpAF5s19nWAOb9q6I3+0ohptMnvhRbA143kQMK
 6G6iyhByj5TspTv0xfH2YIlCo2QL4mwcbLdLqLD4koRdkTpfA83qp+r/jtMY5Gpo
 DodnNNvheBlFjBVLVYqTEpNn4P61Jbbf7KP0jnlJK3VBEsBvfCM8bhmqfWf9qgJZ
 ubV4SqXQsleSI5FCUFtV8pvBWrXJ4+e2y06jpj+fvC3ErVMxS2RnVk3brqOFLPco
 FdSByt4HL2iyUjz5Rw0FcrBOQRzLGiRYGHGeGC5nyQGoF2EKX3yTpmbesqfHczFg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt82seu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 20:24:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJV2k2026805;
 Thu, 29 Jan 2026 20:24:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkkg3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 20:24:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TKO4ZE37880410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 20:24:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AC2A58050;
 Thu, 29 Jan 2026 20:24:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1FB158045;
 Thu, 29 Jan 2026 20:24:02 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 Jan 2026 20:24:02 +0000 (GMT)
Message-ID: <3e782672-84a4-41fe-ae4a-d0a7766f09b6@linux.ibm.com>
Date: Thu, 29 Jan 2026 15:24:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/29] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-20-zycai@linux.ibm.com>
 <48169821-01a4-4e9f-b301-94d430afe8af@linux.ibm.com>
 <c8331857-02a8-4b22-8587-3834cb1a2e4d@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <c8331857-02a8-4b22-8587-3834cb1a2e4d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: doI3C_chOHQGSOdef0yi6aZYEi02vmfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE0NiBTYWx0ZWRfX+Fr/oKfi4pdf
 hXYnY05olepFLuZ1bv0ZNSw0qlFMx0GaDfvl4sce5v5DZtPAFNicqK6Thfy43hRgCdxwp/VOmWa
 2kZ0ZfGZ9ILLyKAltmMZaJHzNvlWwh1D8Mtkd4EniHRiHPuqAEqf12I+zgbgy26YCAUpqruJWLE
 Du/2keHHYdqPNxneg0rws8klgHAgjUPBVPJt4pzUX/Jx4TguV2umIsK4PMShnscGaWB/ZartaNK
 zC7eZtf5NO/RsyhtNkCumkj8X1sfrVEJB7fdWteLvQxAwjO/ZVxenrr2hql3vvzz3mYec7krd0/
 NzwcdSjPQ1b39iC9Or/6FWZSz0sM8ulmlDmaryXfdLZFqRMCplx0LnG7YdwaiPcKpPxA2rPwB9c
 ZOEXL0lsv2sfVGkL1D9m2grAiEwpVJ3VduUYIHsJCpR17hF39A9WTUwHkvjTzkm4LPNoC5Q9DnE
 Qp2vSEqxVhR8Kil37Gw==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697bc1e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jVsSQdv-zovq_dpEqAsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: doI3C_chOHQGSOdef0yi6aZYEi02vmfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/29/26 14:19, Zhuoying Cai wrote:
>>> +    /*
>>> +     * Store indices of cert entry that have already used for signature
>>> +     * verification to prevent allocating the same certificate multiple times.
>>> +     * cert_table index (cert_table_idx):
>>> +     *          index of certificate from qemu cert store used for verification
>>> +     * cert_table value (cert_entry_idx):
>>> +     *          index of cert entry in cert list that contains the certificate
>>> +     */
>>> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
>> If you agree with the suggestion below for verify_signature to adjust
>> the returned index, then the cert_table can be used a bit differently:
>>
>> Make this an array of booleans.  Use the index returned by
>> verify_signature.  Value true means that the cert has already been added
>> to the IplSignatureCertificateList.  False means it has yet to be added
>> to the list.
>>
> If verify_signature adjusted the returned index, I don’t quite see why
> cert_table should become a boolean array. We still need to track the
> certificate index in IplSignatureCertificateList, since that index is
> used later as the IPL-Signature-Certificate Index (SCI) in
> IplDeviceComponentList. That’s what cert_table currently provides.
> 
> With a boolean array, that index information would be lost. Am I missing
> something?

Ah, I see.  This is to keep track of which cert store index corresponds
to the entry in the IplSignatureCertificateList.  I thought it was to
**only** keep track of which cert was already retrieved from the store,
so my suggestion was off.  Thanks for clearing that up.

I might've been confused by the comment.  What about:

```
/*
 * Keep track of which certificate store indices correspond to the
 * certificate data entries within the IplSignatureCertificateList to
 * prevent allocating space for the same certificate multiple times.
 *
 * The array index corresponds to the certificate's cert-store index.
 *
 * The array value corresponds to the certificate's entry within the
 * IplSignatureCertificateList (with a value of -1 denoting no entry
 * exists for the certificate).
 */
```

It's just a more verbose explanation of what you already have, but the
main point is to correlate where the index value comes from and which
data structure the array assists.

If you take the suggestion to rename the IplSignatureCertificateList
variable from certs to cert_list, then I would also suggest renaming
cert_table to something like cert_list_table so it will read a little
more clearly when viewed next to cert_list.

-- 
Regards,
  Collin

