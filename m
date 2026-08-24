Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418D6C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyc0y-0005rz-I9; Mon, 24 Aug 2026 17:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyc0w-0005rf-VF; Mon, 24 Aug 2026 17:15:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyc0v-0001vt-5Z; Mon, 24 Aug 2026 17:15:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVVdA2857996; Mon, 24 Aug 2026 21:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i5qs4u
 vY71z+Fplf6WZ48QXoGvawVNsph4cexjozqCE=; b=khmThF7v3DOSIBLVn6FpCi
 kc4KSImflP2YCIj5udLMU0wToUy0Vz+BI/voQYkpN1R57hlixU4aLEOECM1vPoY2
 o3vPEj4/PylspamodZHGW3/MxWIkWW4QfGvkryzCC+Ej5I+qH03wL3j//q496Isv
 B+ZKi+e9V7PZyaTc702xgy4ooJl/oVn3GjBiSdFzPjHrkTBWm+yY6w57AnPbSrbd
 KJMDAq5DbU/O+ufqcEKeqSHXr700dGm5Cm6iiST5opjfJXC/JJkb1KPPsVNykKy6
 +atOP3NQgBsXb81NjWH//pZO+TvtPYbaD/r6v65nwPFe2WrfWZyDGiYf24jgPgSQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4m8tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:15:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLBH5d030818;
 Mon, 24 Aug 2026 21:15:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag8cv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:15:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLFHuS25756332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:15:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D41558056;
 Mon, 24 Aug 2026 21:15:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41B7058052;
 Mon, 24 Aug 2026 21:15:16 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:15:16 +0000 (GMT)
Message-ID: <b71dae9f-3db5-4343-ae29-40ed0426f1ca@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:15:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/15] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-7-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-7-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oiwWk_o9MwXHNI5v-XveJy5Q_HKOAVaj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX1kiOFH874P0c
 4k+ih1Q4EzE7tyoQhRlKgtM2gFAH8o7yuKrLqG4lHQDraN3xhnQIam0KE4SHbRsddsy3l1Is0Qx
 oo3kN7Buvd7U6uG9+B9rO9YvB5ecmKI=
X-Proofpoint-GUID: oiwWk_o9MwXHNI5v-XveJy5Q_HKOAVaj
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8cb466 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sSd_ziPV4v-yqkggm4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX5Gm6XU8PuVFw
 8X+GTCmA+9z1oQHIX2DUjJlJdHSdRzK7a3sZyAtQPUkD2mO8nQ/nm9o12Jcul6klcVztsRkh/Ik
 Y867AQYut7bj5ggDlARFxtQ18duPrKF7ljvGnp2akSh6chZTd/jQWAAik11+/4wjVwi9x9vDR2X
 4ngIkJJYWA7ZjnbFbj74HA7CTYbRt5iPcJxMQDJx8hyUu4YQTBVqdJuK2/yfaUbi2vxY6KUP6tO
 Nn5van4vBcoW8Co0q3fP2fiK/eMOEPRfXZhLWa1X641dr/Jwr1nxpW+4qpUk7GHS+k2g8adD7eG
 BQ0xyvo0icafnE2WMlZqa23B2pAW9GwgeIMSPLjmMOILL8NKYwev+dvAIP7CSJUSIVKUYA6Ky+o
 26e5xqhi2DdNPP9uI/UbVBicUNe1bHpWotW40BbWVWePdwgbgYTvknMYeq4gBstlfJqEvn51sYL
 ET+vdTqLmzHhPsRljpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240178
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This pointer is no longer used, after fields were moved from S390PCIIOMMU
> to S390PCIBusDevice.
>

To be clear: Contrary to my comment on patch 3, the commit message for
this particular patch is fine.


> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



