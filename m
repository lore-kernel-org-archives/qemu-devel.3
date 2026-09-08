Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B1FC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7R-0000hL-Or; Tue, 08 Sep 2026 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x3y7P-0000gf-MB; Tue, 08 Sep 2026 11:52:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x3y7O-0008DB-6H; Tue, 08 Sep 2026 11:52:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1dDc080539; Tue, 8 Sep 2026 15:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3OSfxX
 cifBrY++C2lHtpfiSD2blTyvfealAfX5LytzY=; b=qImKPVnW20TEEFdDN0qOCE
 p3Hm8H2Qo7Ld0gEdYF7LgOGJtqkjO04e7ECEM4fNjNQZdhR+1ePEQV09rU2T1Wi0
 2L9g7FzhHi2yhMQDjI6tp6I0TrSvZ+xc4T3q5PvrAeKnLLoabjAhMam5gNYEbwoO
 uaKkVt4WQH5llkJ6nHUyj4k7B7vIrI12cXJhvFzsRqKIu84/hsxKyzObs8TYHiR3
 kXGdq5eKoRLdFjX3JlilgKTQa8Dv0BA5Tr/ldOBazZizKmhfRCBvhsgANX5Y0dVh
 EfUDGFB98rTyD/awkkcyF66S8UipeN2QsciE1GicbrtdpckydDYFSV8FyjKgmQVA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrqwbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 15:52:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688FfJRm004170;
 Tue, 8 Sep 2026 15:52:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh4s4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 15:52:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688FqBpn21627466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 15:52:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15D8058063;
 Tue,  8 Sep 2026 15:52:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C115804B;
 Tue,  8 Sep 2026 15:52:09 +0000 (GMT)
Received: from [9.61.96.29] (unknown [9.61.96.29])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 15:52:09 +0000 (GMT)
Message-ID: <d6e65867-2028-46da-82f2-086947781cfa@linux.ibm.com>
Date: Tue, 8 Sep 2026 11:52:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260903155805.1881366-1-jdaley@linux.ibm.com>
 <20260903155805.1881366-4-jdaley@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260903155805.1881366-4-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa02f2c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YG8he1e7WkifaKf6NRcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX8UnUEcYfIagU
 0juy8Rx3TAoHhqCDoDhyBRDGflO8JNoDUxnlFG9K+YNJO49b/o3CUi2389CJanCq0lt8qUgD+7O
 dGiPmMJ/fF9m4b4TrCp6e9sJjJCeaZ4=
X-Proofpoint-ORIG-GUID: DXf3T6UEKwgALNdzHja3jiR6FpbzNnNw
X-Proofpoint-GUID: DXf3T6UEKwgALNdzHja3jiR6FpbzNnNw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX3ghFl4K/8BJe
 OZEXSfnohP3AZJuoYrBy7JL6HmtOp0gm76VDC9VcVYVl9fMF6stzgpdDVmQC9ICCFZCDNy4ADFx
 8e6Q9B/AAOzAi2XX8YAol/3WE4fyzLgexuAY/2FtEJcBOg34FM0GMKcGH2ph74QXcCeucUEgAjt
 AczXcI2K72ceDjDCk7Slau2Rr9Jn0E74RPebXLsODHTcyUEPf90KTqGjvIBSeWkUHmctIrDLago
 vseEjtjE1OKgugDmiH6PW6aztdEPAGUzSEn2+CD9RZGYdIFmc3iUjESv7EBmX0Ia+mcX96qFnSC
 em0WPQht9TuhTzZkdWpTtNNe9rtvQF8G3LxO64R00zE5Uv2xtsRdLx8/FliVZI9ONysZkGBy3oj
 MjeNuakxOubKdouhP0UJuNoPknq/vjptbCI+NIQjiyk4PDh63apoLP/1KyebI7aeTCsoVF3gKxa
 A89MxRUSDpx8IKox/6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167
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

On 9/3/26 11:58 AM, Joshua Daley wrote:
> Split test_s390x_secure_ipl() into two subtests. Each tests with a
> different boot device: virtio-blk-ccw or virtio-blk-pci. Use class-level
> variables and a temporary shared workdir such that the time-consuming
> setup is not run multiple times.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Thanks, Josh.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


