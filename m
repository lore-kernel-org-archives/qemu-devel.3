Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257A0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkUQ-0004Ns-TU; Wed, 17 Jun 2026 03:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkTy-0004HA-ST; Wed, 17 Jun 2026 03:14:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkTx-00067m-51; Wed, 17 Jun 2026 03:14:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnDrD2895421; Wed, 17 Jun 2026 07:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f91rzU
 lp0dnh7oHCGlpYGXEe6+j0GFhmUC0B0dl+paU=; b=bpe+U6spmTO1nosLDBF8ag
 XMycmrqru8PshMrmg8EOiMeX/x1fXcU0Jvk8bIZ6asAMAKwZpjWq8f/+QPb+W7hR
 d8FONJ61VJtZaiTssPHIZoIcQX24IeGaYKMt3wFEnAGxWY8qHHDQxmZtUnuPYvn6
 gad90VVZGbfdA3BYgwDCHLim/CjJVir4gbZ53H6Cf7exDrxgiKa00jL12AxiZFyF
 X0LrxDP7+CgE53q4Bc1ntvBGcp62EUc3Ly2VG6HAE+g5J1RolD4xc+f9GhXDe2Yp
 IdPdbuuj3WhTYKPBeuy+Am7xeGSRUXqfNgkjR22iSVAxjBfgqgaStgE/bDEP91Yw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1pkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:14:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74Zpt012532;
 Wed, 17 Jun 2026 07:14:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva20n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:14:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7ERlW13435396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:14:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 829C85803F;
 Wed, 17 Jun 2026 07:14:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C491A58061;
 Wed, 17 Jun 2026 07:14:22 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:14:22 +0000 (GMT)
Message-ID: <702f3854-acf8-4955-8436-7296ebdcd2db@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:44:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] pnv/phb4: Update PHB4 to the latest PHB5 spec
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnu@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <af4HEUe0erFyaQmB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af4HEUe0erFyaQmB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX6N187fc3kC2W
 on4KjZsly0tqJ+eejw3yiMM9Sys14aZ1oDxtqp+KY+wU2i7iP4g3qW0wCDAidcNWK8XfRjRWjFM
 Qf9H/P8nq/O2l6oZBuvp0DF53uAw+lY=
X-Proofpoint-ORIG-GUID: bdjDhfBsGPW0b5cPZ8Npt8pSl1akqjBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX1Gai07ENgAPn
 G9OP/LvAeD+dreso4sjODlDDuFCrW3WxChokfcozJoE+sbjbTDiwm0hRZhTaPEkrfbTVMgunpcO
 cN9fY5YqiFhcX1CEhajXIUT2Na9avmix+Uqp0cxBsOfSqVzutwnVbiKZ+rzlgLCu596SB0mekOX
 t/6rAG8dkrH4e144Kq9XFMQdroLiI4N1v194F2XdL7vvA2tSqYKci4yOOSAZl76kMFft7lc6Mgi
 3nkrjpHtOSUqJevTeNr0xfyTxn9bIApTPMALJA88f+AifMMu/IPkTW/mUVVsJV0W33q31TZzPjV
 g5d5rZFBO6eDzZAlIhMM4/iIsQDiB+Y3LfYa8tT6v/gR8hVaQVXEU2hdQYSbUg8LzauIPnfdLtH
 m4TWWsq+RRBWRztE46kaqBsssYjT/RtnCb4JhemM8OsOg4nmqF1agyS6OgjwZ+4gB8VwMrpODMU
 f1kUs91b8c2Bsdr9xHg==
X-Proofpoint-GUID: s1dW6-2orvG3mkJXQiTIh7iawlZ31dDs
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a324957 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=xrUvTQNI3rT4VkUW52AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 08-05-2026 21:30, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> Hello,
>>
>> This patchset v4 resolves the tsan build failure seen in
>> https://gitlab.com/mstredhat/qemu/-/jobs/13201554945
>>
>> Few variables were declared directly after a case label inside a switch,
>> causing the compilation failure.
>> These are now moved to the top of the block.
>>
>> This series updates the existing PHB4 model to the latest spec:
>> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
>>
>> Updates include the following:
>> - implemented sticky reset logic
>> - implemented read-only, write-only, W1C and WxC logic
>> - return all 1's on read to unimplemented registers
>> - update PCIE registers for link status, speed and width
>> - implement IODA PCT debug table without any functionality
>> - update LSI Source-ID register based on small/big PHB number of interrupts
>>
>> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
>> to various registers of interest and verifies the values.
> Thanks for introducing phb5, saif.
>
> I am currently seeing powernv functional tests failing with the patches
> applied:
>
> 	 1/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-hv                    SKIP              0.17s   0 subtests passed
> 	▶  2/16 test_powernv.PowernvMachine.test_powernv10                                       FAIL
> 	▶  2/16 test_powernv.PowernvMachine.test_powernv11                                       FAIL
> 	 3/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-fadump                OK              166.62s   1 subtests passed
> 	▶  2/16 test_powernv.PowernvMachine.test_powernv9                                        FAIL
> 	 2/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-powernv               ERROR           182.93s   exit status 1
>
> Able to consistently reproduce it with: 'make check-functional-ppc64 -j4'
>
> Bisect points to below commit:
>
> 	commit 9b95949d3eb9e733973c692b0e8e0b9043df98e9
> 	Author: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 	Date:   Thu Mar 5 00:09:04 2026 -0600
> 	
> 	    pnv/phb4: Add reset logic to PHB4
>
> Can you fix the above failure ?


Reverted the updates that were causing the regression.


>
> Meanwhile, will be reviewing the series.
>
> Thanks,
> - Aditya G


Thanks,

Saif



