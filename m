Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C9EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96Hz-0008KE-Nx; Tue, 22 Sep 2026 15:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x96Ht-0008Fs-5e; Tue, 22 Sep 2026 15:36:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x96Hr-0003sA-6Q; Tue, 22 Sep 2026 15:36:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Sml4144249; Tue, 22 Sep 2026 19:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mWWQj+
 XWjtcT7d7V2eNQIzFypip8ndMZtn+YCFFY87M=; b=mytFEDyyF9oNxtTN3WS0wY
 Ib/VVn41XuOGrCq3ruLs7tPaYnP32Jeae9eXzHf7phUyHxCO96uYlFW+1eKSUZiv
 1Q+uuuFGZSFy1JF2HomA183hSpbn9Ru8SPVY4PwaRLTod9vNYPMSw5GZpdYcEDWl
 60tIcbWoyokIkMmaqQZQnuRCbtTdmTQeJc8Y+Box0y6+eNQiy88cP3FZvnLJSjKM
 2yOFhauCJpFr5nAmGh/R48nTKbTiB2EruGoDaBg5KWSnyriSVRVNZl65vGNlVgHI
 PNPbMCpNjRdLO8+JdstCGpvvAGVqoKky+JNQ7kvKMIY/Ht65LlPZOmoKjN9n4Vlg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqf8ux-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:36:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHb6T3220323; Tue, 22 Sep 2026 19:36:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vka4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:36:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJaFlw31326814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:36:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7A5E58055;
 Tue, 22 Sep 2026 19:36:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3458E58043;
 Tue, 22 Sep 2026 19:36:15 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:36:15 +0000 (GMT)
Message-ID: <170bcc58-0bae-49c2-ae80-7a231f16cd0f@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:36:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] virtio-ccw: Do not overwrite existing indicators
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-3-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260921184305.3791311-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2d8b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=uZfnXfx8t8SeaKmfT_AA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX5lyEdHSxtD+V
 SZNmiE/PvNnsAcDLtKAxbXN3P86ViUfau6EqzPvExLchJfTHk/2MaaY5KsWiq5vfvWMGPJOzv/9
 ffYrK7c/Vr7kpcIfEWxqHPeyQrWItc8W9Ehb1JTuKjAumemIaJfme7Y0dMxAhKtadJBFhX1tXzk
 YGCcICD26yQztd4/PYgmWyE651TFKIj5vhmWo00gmAJnTmnmXkPsnwRaHg2If0qbtV3IRxjjnxW
 27oH+Bha7fOpRP7/KfofgTtHaG9fYiHAFhxdq/LBlnCIus+uZ55Qr7OJd41weJNwQfpDJmfgKSV
 YzQKIJx3oqOwCWfZzJpS+tpE5VfsAyUBetJyEHKyAAqF8G69MZkP/D2NQBIlCn2i5m22Gl4ZDAi
 /cgJkn8nZo8WJaFe8sNElaqXgq0TQltbBIuvJLsMvE9Bl3U7olkCv71KSa3E7BN3puGCgnmSKfQ
 ChuMYjdtZKVbK/wb1kA==
X-Proofpoint-ORIG-GUID: XvzlpjX58Hebgce0Jh3g-OWxW4-Yp8f6
X-Proofpoint-GUID: XvzlpjX58Hebgce0Jh3g-OWxW4-Yp8f6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX7zQZ3/JGjwxV
 bJ68dFDop4O1wqYPjvPXlU+5gsRWnjIf2PRwU7kQUM/hRtJBSB2d07T8OuIXxINuQVTekPMLBD2
 0Bnjxp6GGPixqbJqgaeGZR7E0JcxLso=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/21/26 2:42 PM, Eric Farman wrote:
> The various indicators pointers allow them to be overwritten,
> but leak any existing structs that might be there. If indicators
> exist, ensure that they are released before setting the new ones.
> 
> Both the regular and adapter interrupt paths check that they
> aren't being asked to enable interrupts when the other one is
> enabled, so just do this release once all the potential checks
> are completed.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7bca3892cb ("s390x/virtio-ccw: reference-counted indicators")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



