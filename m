Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB9606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LiPIc9Eo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWlDs-0003ec-0p; Thu, 26 Nov 2026 20:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWlDl-0003e8-Ic; Thu, 26 Nov 2026 20:57:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWlDj-00047u-TX; Thu, 26 Nov 2026 20:57:53 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQMt7ja1433123; Fri, 27 Nov 2026 01:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sDHavH
 W+p47m2ng1RXSgKlcA7VZcGGJ9Z9D/24wBOns=; b=LiPIc9EoM6yxG/RAGZ/atl
 UQl6c5vFcnPcJOXpnBoVfs9lB1YH+d/6PYiBotFk94Y/xbFfTWCZTeQ57ohaPPWT
 SjHPLLu6EtKLEDDH8Rt8vqPLI/VUXHwIb7eSFw8il0JFIQTVRlLkDFHCIS0/AuhQ
 dMOeEBw7ClrpCCvgstR0yA+uKPTKJRMG9eswPFWwpLzwTvmneDKoOxoeMgSXq4pC
 rBbACXPzpW1glF3eIDtzHy+EwciQDxZPUcWAt/UqhJ3bZQc4tXF/dddr3cDUqSO1
 XrW5+VYc0YzkT50O9yv8HPa6ys7a5fb1oD9uQoNbnDLX/1++Rd/p2H/ILKcSlpGw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkussh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 01:57:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR1twxD3907600; Fri, 27 Nov 2026 01:57:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg2cns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 01:57:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AR1vjfG19989114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 01:57:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F03525805D;
 Fri, 27 Nov 2026 01:57:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C0F65805C;
 Fri, 27 Nov 2026 01:57:39 +0000 (GMT)
Received: from [9.43.32.12] (unknown [9.43.32.12])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Nov 2026 01:57:39 +0000 (GMT)
Message-ID: <926fa006-7eed-424e-83ab-38b01de16056@linux.ibm.com>
Date: Fri, 27 Nov 2026 07:27:37 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] tests/functional/ppc64: add pseries CPU hotplug
 test
To: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
 <20261124110030.30097-2-anushree.mathur@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261124110030.30097-2-anushree.mathur@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAwNiBTYWx0ZWRfX4RRhkS9pU+wE
 m8glGQvQIhaFt/hg+vSwsztGiVxA1RwDPjngWVCj2dF16xv7ESwboG0f7b3k3aB0uySvsShQb/2
 IsKcYZXHp+yRsLnsdRGiQ5A+o0wiW2rLr9BQPak19jjWoQeDxiskXdry1/UUJ1FNWvm7T5EXPCp
 cSOUoZxmGhnqn5BKbPlFqBx8gVldUgaGfUh06y+weA8ZNlWtyAUi5ymWXgZ/Amp7LQpQzNcSxR5
 NmdB2fMyatjVLarv8DolhbvgpayteEKBJKVJznzbEcnDV53dHKwq6Hv1Rwpf6YhJFV6//a8t4Y1
 1XKXVetZbEpf/haJkQcE6LB5sdZHgPcRkryu9tSXql2b77KahQhOWD6dVB/RJZWZh95Xst9lqm5
 U+lYYtBQ4rUVDGmceZab0NcdQbBgZ+hyfSbXco11kGmU4XM8Y+2YnEwoELDLWvZmoUR4tGFleZm
 KspzDuGB1DzR1+BYt+Q==
X-Proofpoint-ORIG-GUID: l2cIUrRpTxp7I8OA6UMToG3mNr72Z6kv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAwNiBTYWx0ZWRfX1oO+m70NcaqL
 gHXr0p4hrUwYgcmguXpqzygT9Oy/skJfz38rd2V/Ztz3Lk5+cPir++uJmCYTgZT4viPea5ihX6b
 jq259RZEt+epaO4KgBw3PKfBdRpqHhI=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b08e39b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_RYaHsNbD6jD0Yuexl4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pQBuJAq0sYlMp2YhF5ODR-SOt3K3eSGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 4:30 PM, Anushree Mathur wrote:
> Add a functional test that exercises DLPAR (Dynamic Logical
> Partitioning) CPU hotplug and unplug on the pseries machine type.
<snip>> +        exec_command_and_wait_for_pattern(self, 'poweroff', '#')
> +        self.vm.wait()
Nit: '#' is not a good pattern to wait for, since it can match an old 
prompt. It would be better to use 'Power down' like the other tests do. 
Though it is not harmful here because self.vm.wait() follows, but it 
would be more accurate. I tried poweroff and the console shows:
     # poweroff
     <snip>
     [  T163] reboot: Power down

Apart from that, the patch looks good to me.

Reviewed-by: Utkarsh Verma <uverma@linux.ibm.com>


