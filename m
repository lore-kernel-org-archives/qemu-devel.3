Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066FAC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHVo-0004FP-L1; Wed, 26 Aug 2026 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHVm-0004F9-P8; Wed, 26 Aug 2026 13:34:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHVk-0003LP-BW; Wed, 26 Aug 2026 13:34:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1oBT314311; Wed, 26 Aug 2026 17:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a3vV8A
 8xORFgt3jbcKyQupAsoEgu1sukUe7ihAuUTt4=; b=dzcP419tmNTqts1GozcwvM
 xxyZXZYrTzk6eHZvRidOoxoD0RhO045RwhiaUi6yAporaiBDiVmSd0rY4apoKBeC
 oIBqfFEnHz8gR3FOkGeAJ5LVbfbV+ZjyCU9gZ9aiUZNSr6bUZeJDRIeH6iimtQ7G
 EXLIU3fAOm9ZOX1QkR3YSQBAe5FonFGDMH2x3uaCvb3HH3IUQ3/rGXZAbuKZXdRQ
 6j/R9rXjMIHF++hPuWT4ny9UiIB2lCWPpKKf8oTe7kpzKxXFPh1aJ6klwckRMTWn
 ZD/z3fp2wd4wtIO3PJQAFrf8o/GKR5JDEjOYYLDNWsxCcdmJbkrKXx/o6ekTOvcg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j090a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:34:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHQNTE030315;
 Wed, 26 Aug 2026 17:34:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyaxx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:34:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QHY0fX31064616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:34:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEF5058057;
 Wed, 26 Aug 2026 17:34:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE94A58058;
 Wed, 26 Aug 2026 17:33:59 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 17:33:59 +0000 (GMT)
Message-ID: <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
Date: Wed, 26 Aug 2026 13:33:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818205324.580199-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfX6fY0KF1vN8Fi
 6FX1ffviLHDBhNkile0whumjg8V9Z7oFIwOq35Bcyy6nFGjhtdZHW1sn0cxIFNuOncruYCGH+g8
 oapEixYF5it7CUHB0d14Mrm42Sp7P7M=
X-Proofpoint-GUID: RxWlbAAhvQXwINxwJdZXNXWwHR_Gvi9U
X-Proofpoint-ORIG-GUID: RxWlbAAhvQXwINxwJdZXNXWwHR_Gvi9U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfX6wussw4k97aa
 rLWuSUB7iiWSl33CfhQ9U3CFvi7lUZrmCOdoiqTOCeo5AsLiSG6Cpw3fdXrCcmUHaktfVoppKMj
 CRN0/ytDq/T7SPzu0NDyHS8+oUtGiOCB+qQuJ1x0fQu3S3hSC1pi7SrOte5JH/kL7oNCUycZs8x
 no8Fdv3ZiOuigcIGGa+ZLjoASaXhOpxWMixvuPILppe0Lcanje4Ig3k/St98ym3RaZVD3N46Cy3
 hspjncXA2q0tiVeM+6fYagLQsShEHWiqbnOo8rxlfOxtWZ7UxnZiBnp3o9VZz8usUkMMIouQC9J
 k8U5MVr2/hgGbv6Wkgfr+YOOh/h17QI+5zFWWEbCqkAXHGo1If96cvLiktpk+qDPGSnOSJZMCpf
 IvG0NcdjAuNeu+329Ys6CkJk9BOIloDE2i3y2Ik7XCj42xpjivdpnrGZCtxcPos94RyzSBsjiEj
 ChpZc2Qux4fn4XYetYw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f238a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=QHwxnGg55_BAGHAxD3gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260146
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


> +bool virtio_net_setup(void)
> +{
> +    switch (virtio_get_device()->ipl_type) {
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_net_setup();
> +    default:
> +        return false;
> +    }
> +}

This patch is largely renaming, but this does seem to have a subtle
functional change right here.

AFAICT before this patch attempting to netboot with anything other than
a ccw device would hit
IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");

Now, we will never call virtio_ccw_net_setup(), return false and instead
bail out with
"No virtio net device found."

That is new behavior for !IPL_TYPE_CCW after this patch.  For
IPL_TYPE_PCI, patch 4 will change the behavior again.

That's not a deal-breaker, but I do think it's worth a mention in the
commit message.  I then also wonder if the message
"No virtio net device found"
would be more accurate if it instead read something like:
"No supported virtio net device found"

Thanks,
Matt


