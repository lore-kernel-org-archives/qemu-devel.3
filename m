Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C4C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRna-0001FP-Jx; Mon, 24 Aug 2026 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wyRnY-0001F5-MM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:21:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wyRnX-0008NS-1a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:21:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O9W8lI1488504; Mon, 24 Aug 2026 10:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jSZAhN
 pNE4ILoRVimTVXjMFC2WrH/G142w97YmO8nAA=; b=bGZ2/CQe7xAus+YzdiX2re
 MJpXDUsaRPAMEfIfOvT6Uw88TCYv/3B33/7/HhpqFMlRB7NsdcrPtS+tJj5aFSko
 N8au8UgraKNWHNf1qAZaxnFMxVQmfUAbq9+WZnkgullCtCF4w9Dl7DhiDCjNUuBE
 NIcs9ag/MIcEmyhmNvJmldyiVw1e4lriyriL7NYox2eIv1DL9PANqpTA5XI+m0CR
 KDJFjGz9AUZigsvAT3JipzoWKUzar4JbyAEcgN5Y1ZbjP1C0ZN1liSVT9r70jFuu
 4kvdB0DanvN6y/sgT7871hClvUIyU+pv5I7eHHngzhfWULXTalJXsLDuDeWVylAg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4gj32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 10:20:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OABMMH019704;
 Mon, 24 Aug 2026 10:20:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgw62m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 10:20:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OAKp0K26215138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 10:20:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DF2358056;
 Mon, 24 Aug 2026 10:20:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 457725803F;
 Mon, 24 Aug 2026 10:20:49 +0000 (GMT)
Received: from [9.123.12.156] (unknown [9.123.12.156])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 10:20:48 +0000 (GMT)
Message-ID: <830c1edc-6364-4b09-a117-1fe7828c78eb@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:50:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
To: Cornelia Huck <cohuck@redhat.com>, Amit Machhiwal
 <amachhiw@linux.ibm.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chinmay Rath <rathc@linux.ibm.com>
References: <20260819045924.11732-1-amachhiw@linux.ibm.com>
 <deff00ce-ece0-4cdd-b1a5-90bb5e6a0835@linux.ibm.com>
 <87bjarq47a.fsf@redhat.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87bjarq47a.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rWg75Pc7v-HZdYB7rp9LXs8GIMQqE3OG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4NSBTYWx0ZWRfX8eu3yjal8RFe
 bQMQW6IMof4LfY+XIbxPzAD1BUviz7qkDna4S4lqDck90DGiXEh6BvrxCvJs8yO/WuwA1Y0XEi3
 HfzHd+11HItk99DN5BzfJkiYQmVHQAQ=
X-Proofpoint-GUID: rWg75Pc7v-HZdYB7rp9LXs8GIMQqE3OG
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c1b07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=tKOk9lj4RKfcT9y0UEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4NSBTYWx0ZWRfX7VkMhRBiw9zh
 AwNs6Bk6BhuGKQ0q6Eet7Aamwbb1Jo+TaLE3J+cnDDN1DBD7ZsjAgh6uYjYpfR5TyY1Hc3wnHk7
 zcwYTcqVdKFauGL5db79FtxUbBF9MGWgy0tVjzryzDVcH/O6kTCLoZexUDs/Ox/hlULOolRQRRI
 03gS1LB4ck4V6X1J2Bp4pQEiKPGhw0kbyVvyZChUfEr6WcxUQGhPIrpr1PJeJagO+T/IgPQev9h
 v1Rd1vTcbIaJjFhY+zX2Yz5ogyOIr3VQesBZ3ZMyNOcohv45qQKFsYzB27xmCLL8Ox4sNdqQQgO
 mclasxTBmVOfdQqfEgjd+AmZyUjQS4VbF1dUwu9eEpnfAthwhv7thU3WWx5gCkOZUPZi8m/ubs3
 O5j1cp+mY9ls9J2VAL/+QN91fevTXtBkNvXfELzMN60biOcr7je+TTWAGWeu58KQ8By6Qo4Mmwh
 UI9ZslUElY2PPiOokNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 24/08/26 2:34 pm, Cornelia Huck wrote:
> On Sun, Aug 23 2026, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
> 
>> Hi Cornelia,
>>
>> Will you be picking it up sometime soon or shall I fold in with
>> respective qemu patches depending on it? Please let me know. TIA.
> 
> For headers updates, the usual process is to simply include them with
> the series making use of the updates, so please just send them together
> with your series.

Sure, I will include it in my next PR then. Thanks!

