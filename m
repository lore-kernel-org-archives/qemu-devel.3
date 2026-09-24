Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081C6C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qmZ-0004zp-Gz; Thu, 24 Sep 2026 17:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9qmR-0004xp-TR; Thu, 24 Sep 2026 17:15:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9qmN-0007IX-Ec; Thu, 24 Sep 2026 17:14:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5dR61896488; Thu, 24 Sep 2026 21:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=22UzeV
 SsBkA91ymallq5z1GzPiVE29ptE5Duc6vci2o=; b=tdGR6X+NQbGPPYVm+nkgGX
 8J6faYXOnvar0ycQx6nj6qoZonj6rSERJhDg1ugvPROvVAN0KRhExCxAIUwLQIQ0
 eTh9e/d/2CDBVaxfyDHAdYn+sdmAJ2iIlpo1sUYrpcNlqBQ7igFiPcDFYxyn9UKy
 lJ26NGQA/PIVI/vO/0E6Ni+Npnv94gHhUZeXARmWrA/n//GPfD7iUsKWrisDUj9I
 wDKkZpWAFHi6NAcTueN/iwTOXHD5OoXfS//2qnCMcK/g825p5ONAN8fOnnoQtYrI
 OrictE1K0MI1NwVVwQy93VOmucvkJ2oqcAGq1e87qmkfp/S/uvGpJ3xctRsClKpA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqttey-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 21:14:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlWm42559294; Thu, 24 Sep 2026 21:14:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1ysy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 21:14:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OLEoVV61079902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 21:14:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB80B5804E;
 Thu, 24 Sep 2026 21:14:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C7955803F;
 Thu, 24 Sep 2026 21:14:49 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 21:14:49 +0000 (GMT)
Message-ID: <8eff2297-c230-42b3-ba61-51cd2b2d975a@linux.ibm.com>
Date: Thu, 24 Sep 2026 17:14:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-7-zycai@linux.ibm.com>
 <d38eaf1a-2b72-462b-a4d1-db1d5e531532@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d38eaf1a-2b72-462b-a4d1-db1d5e531532@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab592cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=JyfQK4TMPtnT4apVw0sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfXwXfbBRetfvdg
 6d5nDc5lJvWZ6IN+WI61TisBCWYfHeyARZxHQBuSZ9RBEecr6xvIc5JMo8xloVr2fDff/ZXuBiu
 WnikyVWlYWtje9RSDfJd3wcn2QULiSt3KUPS1M55YAA8t4Z7GDoy603To3AJOUfPpXNFI4ywvYN
 hwgP8pLWeL2oJIZMnkK1kXWuf7yAmZvaKTzwdUbBfqnHJphJ2GofjKLq3UPkuuF0lzSrbfYDIzz
 lE4DYqCRUCAb7PdTUWE6UAues8CWGB4tUjZkTHlY60w7KXJZCsK1AEes7xLnIGtPcfbf3QniCvH
 E1SAJliKtilZFH4QjJVtJqzWpSR2wQLXuh2Kdhv/9S3GzJauM3XVdsr4lfMPXgYMNt4KxT1sGCp
 /gopxBddTMmJMDwhCbh+JdoUHzkPHIwqD6AASijANVW6QW3bRaJ2rtnbUnUyjfGkrlUNTx0fbPK
 zZVnC+JX4MVMWghia+g==
X-Proofpoint-ORIG-GUID: ffvA0ZJHlriAGR91MUXzWrp8WIciXVrv
X-Proofpoint-GUID: ffvA0ZJHlriAGR91MUXzWrp8WIciXVrv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX+z0OJV9aLFKD
 A4H13nlk3/9mI5CWFmFojeHBGrYLXsPdAiNyMbY4WJgFBoFMoi3huZeOWm8C2Tw9ZbpecX44EV2
 fh+YPb0t5er7hzERt9uGptIkuEUWJUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240086
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

On 9/24/26 4:25 PM, Matthew Rosato wrote:
> 
>> +
>> +static bool s390_bios_has_net_ccw(void)
>> +{
> 
> Since you'll need to respin anyway...
> 
> Sorry, I think there was some confusion about what I asked for here.
> 
> AFAIU checking for this string is going to unconditionally work as long
> as we enter netboot code, before we even decide if -ccw- or -pci support
> is actually available.  That's why you don't use this test for
> virtio-net-pci.
> 
> Your old comment block said virtio-net-ccw support has always been there
> (that's not strictly true)
> 
> So rather than removing the comment block, just reword it to explain
> that the test just assumes virtio-net-ccw support is always available
> and only checks that netboot started, it doesn't try to verify ccw support.

Quick clarification: I meant 'only checks that netboot code exists' --
since we are just looking for the existence of the string, not that it's
being output somewhere.

You're assuming if netboot support exists then it always supports -ccw
and maybe that's the right way to word it.  If that assumption ever were
to change in the future then we'd need to revisit the testcase.

> 
>> +    return s390_bios_has_string("Network boot starting...");
>> +}
>> +
>>  static testdef_t s390x_tests[] = {
>> -    { "s390-ccw-virtio", "virtio-net-ccw" },
>> +    { "s390-ccw-virtio", "virtio-net-ccw",
>> +      .boot_dev_support = s390_bios_has_net_ccw },
>>      { NULL },
>>  };


