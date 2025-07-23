Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B8CC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 20:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uefsC-0003m3-GZ; Wed, 23 Jul 2025 16:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uefs7-0003jx-4q; Wed, 23 Jul 2025 16:15:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uefs4-0001nk-UY; Wed, 23 Jul 2025 16:15:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NF9Dbf021966;
 Wed, 23 Jul 2025 20:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Cx3CkH
 rliTFfoz9I5ekWvDXT8t0KGPB1EGVnZZqpT60=; b=dT9mGMt+mXfLmLQDI9pfkk
 DNm5mQ/rRr6xdTOKBLfkDWyH+/uPwBE+6b3WVPNxoCPw5YP61b+QhvqCGU7vO2aF
 wYkuXDPlAel6q/Ushoy5WQRCoaGVEzNRNj+0Eeyng8yzGyU/6ZF3dxg/rpVGHKTl
 snvb3XGi6vaoTfoLEJPIZHxicgGRCXBPFjYPQ2CxoDFKQjDnZUq2HXV/VO9SE+Kj
 zZj8PpwnWDDG50J9YrCZmE/ZYU27yEwxiwTRW4aSmjgW+HS59gYvVNhzgETJJYHw
 BKtT37dt85etjIcyhtFmP4gUOGAJstp7o38vn3aaatPzMzFFpOyeCSZ9+WjYXGBw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbewb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 20:15:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGFt5B005457;
 Wed, 23 Jul 2025 20:15:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvr0k5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 20:15:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56NKFI2d16974386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jul 2025 20:15:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAF8058058;
 Wed, 23 Jul 2025 20:15:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79DDB58059;
 Wed, 23 Jul 2025 20:15:17 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 23 Jul 2025 20:15:17 +0000 (GMT)
Message-ID: <b32fcde2-80e1-4bf8-b192-ab642978d1e1@linux.ibm.com>
Date: Wed, 23 Jul 2025 16:15:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/28] s390x: Guest support for Certificate Store
 Facility (CS)
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-5-zycai@linux.ibm.com>
 <84eea732-145a-4650-bec3-0b9daf25723e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <84eea732-145a-4650-bec3-0b9daf25723e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -EaJ1CabrLlltPyyI8xzHdLGwwYSa_uc
X-Authority-Analysis: v=2.4 cv=De8XqutW c=1 sm=1 tr=0 ts=688142d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=-jnog_1G-58QiefbCCQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -EaJ1CabrLlltPyyI8xzHdLGwwYSa_uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3MSBTYWx0ZWRfXzbUUejQcEobM
 tFtnsUIeCNSn82rGxAh4QImputOO92KBV8TnMbd6zxbVKpejRClgLVbscTu6IK85WxgT7llqDHv
 WFUWnl6Gp19xwJL+wvQg6pMBDMXvGST7WaQRw+b8C36DRFgdqiceWgG+R+HHR+9XE+l+OxRuPDZ
 tUlG5W3grGGou7YyUitJ1Et9iSikFlSKkkNXIioN9C6qi4I++8xfG07zuaJIvOZo2TF24JUvatN
 queeWyVwuA2vJI2FOI+no6j0YPXnsdPTXzz2O1fwuhsLVFax0KC2s3YG3AVqt8z4r2qY0HQXo/I
 jlOZ6MSoy0h2LGqOYqcSdIQvVop2FSzFzPfh3suqQxrDKQFN6NPzYt/UXC7mfIoDRbsfvKnvQ5u
 dQkjXXGI1HPsQasQatN1es97+F9GeCZhU/DrHtS6nKpGfi+hmJTXGFHDmcJWz1tsGFjkmtLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230171
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/21/25 17:30, Collin Walling wrote:
> On 7/11/25 17:10, Zhuoying Cai wrote:
>> DIAG 320 is supported when the certificate-store (CS) facility
>> is installed.
>>
>> Availability of CS facility is determined by byte 134 bit 5 of the
>> SCLP Read Info block. Byte 134's facilities cannot be represented
>> without the availability of the extended-length-SCCB, so add it as
>> a check for consistency.
>>
>> Note: secure IPL is not available for Secure Execution (SE) guests,
>> as their images are already integrity protected, and an additional
>> protection of the kernel by secure IPL is not necessary.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> For consistency with documentation, please change this from
> "S390_FEAT_DIAG_320" to "S390_FEAT_CERT_STORE".
> 

I also believe this patch and the subsequent patch #5 should be merged.
Functionally, this patch does nothing meaningful.  This introduces the
CPU feature and the next one makes use of it.  They're both relatively
small patches.

Make sure you merge the relevant information in the commit message.


-- 
Regards,
  Collin

