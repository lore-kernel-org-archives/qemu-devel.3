Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795B6C982FE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9BNJ-0007tD-3i; Tue, 22 Sep 2026 21:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9BN7-0007rm-J4; Tue, 22 Sep 2026 21:02:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9BN5-0000FL-U6; Tue, 22 Sep 2026 21:02:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7ARt4143683; Wed, 23 Sep 2026 01:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SPbxEU
 B+wpQz3YHuFOlyuThy6ctPKPngc9mU+/ddHDY=; b=NyBUHRL4tXXUdPSLH7nD5l
 zQD3NzYm1g/7xdBX7yhP8W8xNxflOH0dnGSztC26R6WsC6f0yS8ieGmwGw/Fl8sB
 y51Qu4bikOgzJrkz+1X+KTsFRry7SvjcxydtSYs95VPwo0bAEpdeO9cThHaigJ0u
 rHXSIZUkXyy5Jf0GbKzmwNGTFkzGFmLnjRKfywu6pdgEI3gaVhNAT3ewcBWKBuRT
 sAOAYCD4ObmiupelO9HFhYLq3yagMrnX3QR8tH8/VOOy0UXLfwOJ2Ei1AvcppA8i
 0y3LE07K2AOeVDeBCuV9DYw4yPwJN8X0A7TKtUqmyGruUC60XkpI7uoz0hDmOtfw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqg6xa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:02:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MNB1Xb1973291; Wed, 23 Sep 2026 01:02:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkeq96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:02:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N11xmr32637482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 01:01:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FA845809A;
 Wed, 23 Sep 2026 01:01:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C44C58091;
 Wed, 23 Sep 2026 01:01:57 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 01:01:57 +0000 (GMT)
Message-ID: <75eec9ab-af1c-4ff9-806e-3855f9150935@linux.ibm.com>
Date: Tue, 22 Sep 2026 21:01:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] s390x: Add support for virtio-net-pci boot device
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <0ec1ff23-83f4-4572-974a-076d7fc6673c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <0ec1ff23-83f4-4572-974a-076d7fc6673c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab32509 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iLtJzS2Hl7Vm3TQyEQAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfXwNHdz2VkNBMt
 /MJ9+axn5OToOemcOPJe1xUNVwsgiSAbn7UDrZBrwKbszNEEH98JbjTcuu0gXAj4/moqa+b77nv
 X8hFzuUM7eX6Ooxt34AhAoI7sWXm8YoS3c5qWR6a/mM746KrDT725/6FSyrxEvZyIaRQnvaWNQI
 R+NaoAajYB95zQeeVeaIpSO1uaZtlC3ZXF6apdh/6KSXFJCITVj9N8LQ3hJaVS0cKCEBWs3Q58N
 hAtHRWms4RUgxiSVXcTlq0VQitynfoVJ8wxQwtA6OCcugyqih7MQFa9qO0f0510rHT2GwR2uyr7
 pBEnLJknZ19nLqvH0C5IfV+BcDsGLVs8NCtmAt+bakmhxoZBwSOBdHsSFUY7r/qDDorCq/uAgsX
 tnUTkIM85dMLCmk3S9wOL6iopwzcmUBzTIRDkqNNhheiaa7hvVwmfSRcqCzjYtrky23l88kYp6i
 PXDZZwNBFXFg3r2UVyw==
X-Proofpoint-ORIG-GUID: rcPvsH4EQRV16oyWXyaY5DFNboAjAv5P
X-Proofpoint-GUID: rcPvsH4EQRV16oyWXyaY5DFNboAjAv5P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfX1aq/ZTe7tQIn
 nT1UvU4qvKtcNukJzF/sdKXFRfYEQTQXW2a/XRtBRjfm4HhkVitWif/TR0Wj6iEcHMQMA9+swY2
 v6IMivD2VE58+lJAfdgNurdDVJ/B8Lo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230001
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

On 9/22/26 5:33 PM, Matthew Rosato wrote:
> On 9/14/26 3:34 PM, Zhuoying Cai wrote:
>> changelog v2->v3
> 
> FYI, this will need a respin to handle merge conflicts I'm getting
> against master.  I didn't investigate, but I assume it's due to Jared's
> virtio-scsi-pci series merging.
> 

This series is close; please respin to address the merge conflicts,
minor comments, and if you address the message confusion on the qtests I
will take another review pass at those - they ran as expected and the
code overall looks good it's just that I'd really like less-confusing
breadcrumbs should a test skip/fail.

Thanks,
Matt

