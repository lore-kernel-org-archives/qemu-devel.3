Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C953C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9BNB-0007rn-IE; Tue, 22 Sep 2026 21:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9BMu-0007p9-Ms; Tue, 22 Sep 2026 21:01:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9BMt-0000EC-7M; Tue, 22 Sep 2026 21:01:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI73af1156726; Wed, 23 Sep 2026 01:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ILKFu/
 D93TvVQl9ZpVNt1iE6mvQzNtL5CSi4QlfgVKs=; b=rkkouDQfSN1RUuf1ufWjBv
 qVOe0JInme00efLayEnDO29EEXTlb+kdLCF7Mt2K1LTFmnIkCWaNoB7lPj27I6jT
 bEY6NmE+vGDzQS6vKmyUBpr1zWJrFwqAqDeDxNKylF/uoEkjREURaHpLK+lw1TKJ
 hcg04cjlcNBAwZiBkR4wAxT9lLZiW3Q+oYua8Z6OlEWn+Pp8k7OLfWDlqzsozSqo
 I30R7ioefojnAxKORXfkvJuOoYADuqeR8BAoaLpJFyHMKLKz/unsfVBW/FZvV2kW
 mQGQXSf4c6i2XiwePXLjV4HaVScnN9SBm5Jh1JjCd0TwXxJD11ghhTNQG44mRpFA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv893h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:01:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MN2IWN3198565; Wed, 23 Sep 2026 01:01:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjv5w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:01:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N11kHW18940536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 01:01:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D946658081;
 Wed, 23 Sep 2026 01:01:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 060EF58096;
 Wed, 23 Sep 2026 01:01:43 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 01:01:42 +0000 (GMT)
Message-ID: <1a1e2294-cae8-41f3-8683-8987dd079aa6@linux.ibm.com>
Date: Tue, 22 Sep 2026 21:01:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/functional/s390x: Add tests for virtio net
 PCI in test_pxelinux.py
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-9-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hdUz8OOMK7LlO4-tVhg_MZ7MOETSkRpd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfXzcs0l8fCYEsc
 DdAIJBRiEuftcxU1+SRNYdOG8VTqHDO7J/JVSQ1PNlC68RZ9KZOLGvuA3ANad9tP6uMwjN4xzCK
 3p/RTUehMqG1iNEv8ZNUcZGYaGwUvf4=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab324fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=I5qeRYr2U79j_5RURzYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: hdUz8OOMK7LlO4-tVhg_MZ7MOETSkRpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMSBTYWx0ZWRfX/f4YSQKrF9R2
 MwdGtKCsZIdn97sb+aMcoNmDmXqhe5NaphBxmRdqB9ZXdie1FkbhMxOzHKNu2tSK5Pl6qiGPvNM
 ntLhqVW9B0pVccDDl9fuQRSdacsjfpxx7bW/hp77DKwmCry1xD+rspakWy92t0ieoVD9xqO2Hcu
 hRBNecUrkblyKuh6lrEu8fqVQSSjskz9/iNitzLssiLL9/HBXwRCZK1W41pTPqH01lcgNfv7CCr
 KfCd63owhkTIlEBKDRAW4ew1/NReTSyhZYWGc6zIg+fdT8NEz44om/Sh8jaEWXxNQEyGd7LM+ET
 4sfb5gFf1dbRCVx4aSBmJJRjcfTZiZLBe2LNQcFpoXTtGFaEiwXhwT5xCK7klIZ0vEB27xF4b7a
 lUhy+ND0lgg83GH4pEzY2BibA2MDiYO0wGiP25zep2lCvK9wyb6u6rdFNf/oRL27ORyeaeyOS4D
 kMfnFlaKhazVDHpcfBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230001
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> extending the pxelinux functional tests.
> 
> This patch adds PCI variants of all existing pxelinux tests to verify
> that virtio-net-pci devices work correctly for network booting.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>

How about adding "_ccw" to the existing virtio-net-ccw test names:

test_default -> test_default_ccw
test_ip -> test_ip_ccw
test_mac -> test_mac_ccw
test_menu -> test_menu_ccw
test_uuid -> test_uuid_ccw

I noticed when I pointed this test at a bios without your pci support
that e.g. 'test_default' would pass while 'test_default_pci' would fail.
 Would be more informative to see 'test_default_ccw' passes while
'test_default_pci' fails.

With those renamed:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


