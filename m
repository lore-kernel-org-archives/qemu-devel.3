Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F6ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0T5-0000Ul-Kw; Tue, 09 Jun 2026 13:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wX0T3-0000S3-Up; Tue, 09 Jun 2026 13:42:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wX0T1-0002Mn-Dk; Tue, 09 Jun 2026 13:42:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659H0oBa3174993; Tue, 9 Jun 2026 17:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Dq6/Mo
 H96xbE6EG7DZWMJ7KBLkm/SsPauuSSazZ8yIk=; b=RbD2Y5VsRzRSoZs4sbv3jM
 LqcVfT1iHDuxDVKJ8f8O7aWKEFFqAMhVuFj+FNVOlz0AHHV4o0OYlo9DBDIUevSp
 8p1M7xFIOftJC75wTQcxUQZ2sTG0ROA4xfKCmi21htCAa8ahBEUk5SyxeOJtXmVY
 xTApeaRSfJqXWg18WEhATPi5dkeoaHZ2rsjebFrSVYVOxGIRVUnyddDPwnuPAU3f
 f6jmTGl9htlrk7XfCgat+Ak6Cw03nBUf2AH8fVgwWjJt19f7OAgep8wUTjtrM2RZ
 WrbQuAWaJzEFnGI/BqTO1jboG/cDb8xSUpnzRMHvOz9Wal3OS6eGi9xXbvchjvDg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qng69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 17:42:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659HYaTH024872;
 Tue, 9 Jun 2026 17:42:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq39xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 17:42:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659HgFPk20382218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 17:42:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D93758063;
 Tue,  9 Jun 2026 17:42:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EFDD58056;
 Tue,  9 Jun 2026 17:42:14 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  9 Jun 2026 17:42:14 +0000 (GMT)
Message-ID: <febb7ef1-4059-42f2-9ec0-4beac378cc45@linux.ibm.com>
Date: Tue, 9 Jun 2026 13:42:13 -0400
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
 <053fe695-54a7-475e-b7f0-11a7eb34f67c@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <053fe695-54a7-475e-b7f0-11a7eb34f67c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a28507a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=zSHzv-vbunXvwhmcltYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hpjuvyREiPA9HIJphiW5x7IUOEvQmSOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE2NSBTYWx0ZWRfXyL86A7Ow20XJ
 k/FT6ze5+NUvsPLSl0cThfmRwO7F1ZVzETIt0CwHoCLZd3EYP4htUwMJ3igQASYKyflIIqCroi8
 Px8EwNlzABiWUik2tgc7z5YToSyin0Oc+tuQPWNyGz4DO2lLAxoAnEr3YOnKuJQHfFgm4T0iLAT
 iol5z8TuMi25PRKzRJMq67lZ2QWOMuFR1jARm1GVjBSnYSeAAHYj+Xz/OX/45YOcFdeBH90b5ko
 lTsx3LBsvF4bwoB8LviNi/7rCYvfhXjRsbl+bbM8QO9gp5ZajSh600qf9/B+CczgU6d1zHfyapU
 wyddYluYJL8IsrIZFN4JcZWBASTpxj0TIJyFTVWTO2vr0doJJVwTWlJaJRAlVinQT2YFC3wAJux
 fwivcXPjs/YtpLg4BCdCSO7CGbHCz+Dk98E98dzXWypLHQzCNXO1GC9qsCoPBGENCvYpTxvFAUo
 gaHIPAQ/3bkOIhpl2Iw==
X-Proofpoint-ORIG-GUID: hpjuvyREiPA9HIJphiW5x7IUOEvQmSOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 6/9/26 11:28 AM, Zhuoying Cai wrote:
> [...]

>      vce_max_size = sizeof(VCEntryHeader) +
>                     ROUND_UP(CERT_KEY_ID_LEN, 4) +
>                     ROUND_UP(CERT_HASH_LEN, 4) +
>                     ROUND_UP(cert->der_size, 4);
>
> After thinking about this, I’m not entirely sure, but I think using the
> calculated vce_max_size might be a better choice than MAX_ENTRY_SIZE,
> since vce_max_size more closely reflects the size of the current VCE.
>
> MAX_ENTRY_SIZE is currently defined as 8192, which is significantly
> larger than the size of a single VCB that will be requested in a later
> patch.

I agree that it does make more sense to use the calculated size here, but
do we actually know 8192 is significantly larger than what we will need?
If so that seems like a problem with our definition of the max size.

Can we use a smaller value, or is it possible that the calculated
vce_max_size is close to 8k anyway?

> Although we check whether the remaining space is sufficient to
> store the VCE, allocating MAX_ENTRY_SIZE for each VCE might be unnecessary?
>
> Just wondering if this makes sense, or if you think we should keep using
> MAX_ENTRY_SIZE here?
In this context, yes, it would be better to use the calculated size, but
also if you feel that the current definition of MAX_ENTRY_SIZE will be
significantly larger than we need, should we reconsider what we define
MAX_ENTRY_SIZE as?
> [...]

Regards,
Jared Rossi

