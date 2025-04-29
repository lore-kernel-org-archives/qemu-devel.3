Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45545C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ffR-0007qo-QK; Tue, 29 Apr 2025 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1u9ff4-0007nQ-RT; Tue, 29 Apr 2025 03:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1u9ff1-00004s-L5; Tue, 29 Apr 2025 03:45:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EXpG028608;
 Tue, 29 Apr 2025 07:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GC2Pq3
 t7zkGok5uU5gkEEXkYg4bcrwYYdNywiVnp0rM=; b=KvF4HtZOHM0U9I/Yi1Sf/G
 mwSTzN2oCCZyryqDd4lWWc+BZiwyP6S1lGuz76ss1WYha02hlCJFyUP3WvT5zCvK
 OuhX95YzMEor6W6cRVvawXBAzkPV/sy/UVMRyO7ZqffJWAZCsa9A9gc1WjapsmZh
 Us8/cWmSsOHm+uLIERCoyctOx6E9ZGyPiOOntO03Cm7QvB0quJMH1KRoEUELs1ZB
 tXLA0F8ma4R/ysIJa6Pah8g4N8cwc34tScCzzEZKJBK77PKvvXDsL+2Aw46ROjtB
 0e3LUYWJhLD6lcKy8vCZnsoFh1/BkbsY1fklMlns77Kxj4g277VNIAXb9gXZHyxA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8m9yht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 07:45:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4HAuB016145;
 Tue, 29 Apr 2025 07:45:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70abw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 07:45:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53T7jbo428115262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 07:45:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D7F42004B;
 Tue, 29 Apr 2025 07:45:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B695320043;
 Tue, 29 Apr 2025 07:45:36 +0000 (GMT)
Received: from [9.111.8.182] (unknown [9.111.8.182])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 07:45:36 +0000 (GMT)
Message-ID: <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
Date: Tue, 29 Apr 2025 09:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EzX7TH8HLc0pktR3xlW_ct10ACmm9LM9
X-Proofpoint-GUID: EzX7TH8HLc0pktR3xlW_ct10ACmm9LM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA1NiBTYWx0ZWRfX1rIW0bhSn+gv
 57cP2lWMpOCeq5xisBKNi4tHwOTcSkiDgqGGe1bA3+BCvLoThs9TKG1sZ/qXdWqQLv3mp9zyfqs
 jJ7mn0ZSaarLBk3ciPZGxqHoGGNEkkQpqJ7/f0eNybIZJ298ypVY/oh2Y02T7ULMQNFsv+quJC/
 xZJlXBCEpeF0h/DKxjEi94IsyNFImJ6RxSsco/aGj4FL4xoJ/LZWu00dJl7WIwtR3adCWW8TqWI
 2bseRMEzTf+tOoHuPa6fm1Y3g41cHnB1VvGkNCsOqbac+w368x6hhr3DKl7v7iAKjyR1WiBC/GE
 J/frmRp4cjldsorbshIODrLMDu+pXoGgq1oke+ZOYAe9mYc+aIqDAxzy6vRpPAageeZx6OSlRCe
 tpysmfue/3OebMGd4P6fdfdt08fcKVlDVbefORj+yaKmCswc1I+yM1KoNynW/ULoNi8ywqJV
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=681083a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=euwsPxPV0lgtU7-4LgsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 mlxlogscore=720 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290056
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Am 29.04.25 um 09:37 schrieb David Hildenbrand:
[...]
> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
> 
> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.

CC Matt to double check.

> 
> [1] https://lkml.kernel.org/r/20250226210013.238349-1-mjrosato@linux.ibm.com


