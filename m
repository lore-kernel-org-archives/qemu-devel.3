Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF31AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97dJ-0005An-SK; Tue, 22 Sep 2026 17:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97dH-00056c-Uj; Tue, 22 Sep 2026 17:02:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97dF-0004e1-Tm; Tue, 22 Sep 2026 17:02:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI709I1128984; Tue, 22 Sep 2026 21:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uf2Xqq
 4AAIBLxIMME6190JRNIwFaPDclq/wgMsYP90M=; b=pVXknKHv+Nak07tM7e1M1x
 Y8H4NyvH0swuL9yyAh8nU9V7SfwmeHMSZaognVZlZNCKQS0hBLMNb28xQ/IUuqP9
 NkSzfsFhPQ+BhK9HXPRC5iO1mlfXfT/F+175jf2IpvOWmSUNc2xiBnLG28ApcX3G
 rzGWXFJ1Hju7tkInR5gaScFpDirKopZJhI9khWOC9sJKWqQxzpcTxWnfw+GQM7Cf
 Y/oMBF2gbIJI/4Kg8XkOAWV/0EQ/Z0tkRbrR933n1ubfIBX+4TwE874vIukSQxvk
 vJ2UYIYGCYrPtVwwseGr8cYtSmX9B1TYYpruEXhuBu1TgWFrwV37eDae1tkbVZyA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2g001-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:02:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHZt04187977; Tue, 22 Sep 2026 21:02:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb8sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:02:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ML2KHk45482302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 21:02:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B5CD20040;
 Tue, 22 Sep 2026 21:02:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F01D520043;
 Tue, 22 Sep 2026 21:02:19 +0000 (GMT)
Received: from [9.111.77.23] (unknown [9.111.77.23])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 21:02:19 +0000 (GMT)
Message-ID: <77937daa-ee0a-4d99-ad65-a9b76a15172c@linux.ibm.com>
Date: Tue, 22 Sep 2026 23:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260922183654.798470-1-kshk@linux.ibm.com>
 <20260922183654.798470-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260922183654.798470-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -fl5aIW9J6c6XDPSs8JlcuFzawVRQdKA
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2ece0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=euEb3dDCjh3J-kT_7jQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX9alIcbeV0W8G
 hi5LNittNOXj9pHYSsG2ayI26TgRTKHT+Igh1tsYs4dRO+2YMLcgDdLGyKeUi+FsrIkFCAMxDtT
 bVA10A/RpgA3gxwoyS/CXZHRDmUk/WTJ0s0TwsSJpP714LvYE1zgzZR+mYe4giyoMAYELhnpXNZ
 e8+tXlaBeEgtrDeKwnm8SDOm1NBumHL6QBmWiU+n97HmwrJ6vxU2pm/enMdsd6GbQqno3w/kdoy
 eTIh/DS7AcIQhJRKS5dNdU44ONekLdQi0tGh8ISW5uiA7uhc18A3xiwk2XuXurSFFoqlTFpwVsp
 fCJuEpBSGl2KCKZvh034NZhAx2pzxpf6gmkP7OLa05dYtSCUsnSO94ubQWvdVpOWDrc1GlQPCuc
 /KyfbxQpOC0yn7lzWMw09LLVvMeFTQIQ7wV/y2EMxTNMY1XZOJA5KeljiNaR1TiYr824qGtkdhx
 SQxg3y1Q41sTE7WBflA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX74BOr3Bkta09
 DLJ8st+vmw3c8Zmyc5Yb+iDzB54MeIPtkt64c3vrRzoH4RDjJZXZD0jISK5YiDHELOp+cbta0GZ
 ACleNfE00JheLo9AtykzD9d3zZKEcDw=
X-Proofpoint-GUID: -fl5aIW9J6c6XDPSs8JlcuFzawVRQdKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 22.09.26 um 20:36 schrieb Konstantin Shkolnyy:

> +err_unlink_pbdev:
> +        if (pbdev->pft == ZPCI_PFT_ISM) {
> +            notifier_remove(&pbdev->shutdown_notifier);
> +        }
> +        if (pbdev->dma_limit) {
> +            s390_pci_end_dma_count(s, pbdev->dma_limit);
> +            pbdev->dma_limit = NULL;
> +        }
> +        pbdev->fh &= ~FH_MASK_SHM;
> +        pbdev->iommu = NULL;
> +        pbdev->pdev = NULL;
> +        if (auto_pbdev) {
> +            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
> +            if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
> +                g_hash_table_remove(s->zpci_table, &pbdev->idx);
> +            }
> +            g_hash_table_destroy(pbdev->iotlb);
> +            s390_clear_zpci_migration_blocker(pbdev);
> +            qdev_unrealize(DEVICE(pbdev));

Do we need object_unparent of OBJECT(pbdev) here? Otherwise you have unrealized zpci
object on the bus for the rest of QEMU's life.


> +        }
> +        return;

err_unlink_pbdev clears pdev/iommu/dma_limit/SHM bits but not pbdev->state,
which was set to ZPCI_FS_DISABLED a few lines earlier. For an explicitly
configured zpci device (the libvirt case) the device therefore stays in
zpci_devs, non-RESERVED, without a PCI function.
s390_pci_find_next_avail_dev() only skips RESERVED, and list_pci() reads
pbdev->pdev->config unconditionally (s390-pci-inst.c:118-121); CLP QUERY
does the same for the BARs.

So set the state to RESERVED I think.

