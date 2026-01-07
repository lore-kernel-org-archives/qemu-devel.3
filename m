Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B16D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 22:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdc4C-0007CZ-AM; Wed, 07 Jan 2026 17:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdc4A-00078U-2C; Wed, 07 Jan 2026 17:31:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1vdc48-00034m-JD; Wed, 07 Jan 2026 17:31:45 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607JtQ0O029415;
 Wed, 7 Jan 2026 22:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IwcxXI
 4x7DYnnRBhDbwFCSZw1nUq4woIzVsiXrQyhGE=; b=JZQaNNzivxTVRYKD4CYbX9
 uhJ8agMY3676ZgVk9EtSnCCt7WN5m2GhbjCEZ0OUBWycmHLhGYUVaszH6wpRnXuz
 03FPru7SQnbXhlz99aQbRmYQCpR0QTR6uoCqJ8Z9fLEVIzcjxqFKffAo8NjqkNDt
 Yrf6GCLow0GDMeBf2edYNcYZfHMXJbz58wvLx3mzr/CNf9yy3+L/rdagzZ9w4E7J
 VC1/1mqO7IFFY8KLgUM8sfsJe6TiYz2BDGMp7HpG+checDONuvIIHjh09DxsiPN7
 Cr2yklhwBu5LH5e8HpV7l5AQ5zJa0IJiLk3ZSSmsdBkTnW41W2NJTcBfdtYPAMdw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf2bpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:31:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607JiXs6023501;
 Wed, 7 Jan 2026 22:31:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmgffx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 22:31:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607MVeJC21365302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 22:31:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2129C5804B;
 Wed,  7 Jan 2026 22:31:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 840215806B;
 Wed,  7 Jan 2026 22:31:38 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 22:31:38 +0000 (GMT)
Message-ID: <85c51b83-7d22-42fa-9b7e-07912b9a3a2c@linux.ibm.com>
Date: Wed, 7 Jan 2026 17:31:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20251208213247.702569-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE3NyBTYWx0ZWRfX3AT1Td2Ldm2L
 96Z8EZlrL/iS0QsillsD4WT3NN4kfiIvbkehjpMf15R6hHMBxl1AT0EZl5PNU+wpKLFbhk5Molr
 WeBR/JApYWs/vDhipk7qGCOTrCAD6zOmQiIaK21/5vStnE+ANoz9r8XJP4O7NGcPnBcI2NJGcha
 ip5Nz+kXd8bnp844l9iwZ6IqorhTYnopn4M9rVVkClWNkWc09T6NLqPAeKLFLpm/J0hLzLM0xTG
 MktXKZ61aqYJY6/PcvLd9VORteo4qiGEJ73HdNIUE7P1AFCRPT8/AALl5PoLjbffsYMLlGaK8/G
 nUabn9zFR0W2hL1pUtWVmfxscAEn/3vzCDOur4il5stKVb2xMCpYfOKoO9n247KDycvTQAovERS
 x4zLzRs+9FEM+tXu+QTTEM+KCz8VDBSxac0Oa+lRmhoaiwF/pu0gzwhLVNhHQETC0gMA0+bXRRl
 Bi4grXo0GRlW9zhR+bQ==
X-Proofpoint-GUID: DGuBM5xGEKzItf7zCp-y8wfsLAqs0_KQ
X-Proofpoint-ORIG-GUID: DGuBM5xGEKzItf7zCp-y8wfsLAqs0_KQ
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695edece cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=cIpVC7h0VThIaOqijDcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 12/8/25 16:32, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates from the
> certificate store.
> 
> Upon successful completion, this subcode returns information of the current
> cert store, such as the number of certificates stored and allowed in the cert
> store, amount of space may need to be allocate to store a certificate,
> etc for verification-certificate blocks (VCBs).
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully. A VCSSB
> length of 4 indicates that no certificate are available in the cert
> store.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---

LGTM

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

