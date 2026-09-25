Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAF6C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA9Br-0004LJ-70; Fri, 25 Sep 2026 12:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA9Bf-0004K0-Ve; Fri, 25 Sep 2026 12:54:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA9Ba-0003a9-Jn; Fri, 25 Sep 2026 12:54:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5S1t3853825; Fri, 25 Sep 2026 16:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/p6LsO
 8IlLhbxOfZYymSmUTAG2YIT3Ly2zUTV+aNR4s=; b=E3RrM5yrQTZIKejKk5VEvh
 jGsPVWA5IjipF3h6reymBdXWrESGV2CI6ieyBteSuGRZq02cVYowThNjeEJP17jy
 0IXBgmuFA+pBiFrusboxs8h9s6iCdeiCnQVe9n2oqrm3HoGXZEV2pW17Lnr80EzM
 ZH4HqJbkWxlzOdEAXk9Hlb1yyMFFlwOUzQbys39toUawKoRh8AOU0wkhhCaGVllj
 ilotgiGdKEqpc3t66ZgEEHjZ+PsWX3Gil+S2weIhjRBIx7XgIrwIm819ipy7iO0k
 8cU6EtrCSRWLXKALzLYAgxx/xqXBCjH4KfIykozNzvSr+9MQ5wl1D4KYP93Gurjw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske285x1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 16:54:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG359F2859248; Fri, 25 Sep 2026 16:54:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efdmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 16:54:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PGs61C32703196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 16:54:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5C8158063;
 Fri, 25 Sep 2026 16:54:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FE1D58043;
 Fri, 25 Sep 2026 16:54:05 +0000 (GMT)
Received: from [9.61.148.101] (unknown [9.61.148.101])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Sep 2026 16:54:05 +0000 (GMT)
Message-ID: <4a1ec908-eb10-4248-af29-cc94236cafa6@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:54:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924222949.147720-1-zycai@linux.ibm.com>
 <20260924222949.147720-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260924222949.147720-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -ECWmsEUXe4PWXUD0VhSkuB_kksS1bpv
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6a730 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-Um3eNmrxm62QSWs9fcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX5GquPXvndJz1
 MLUUGX8htz7vB2XTBRmajNDxJqcWfE8K9zsVGQdC2oBSYMx8x+kbP/7fo4RS8rZ+hp3fKdNlEAK
 7yzQUa7e/dzo31rtNOAoXmVWnDuUZoc=
X-Proofpoint-GUID: -ECWmsEUXe4PWXUD0VhSkuB_kksS1bpv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX2FDB6xCgqG+l
 O2vpT2aoq7FD/Vd1aZTmD/FzGpTjmmF02/UxRjq8t/oS0QUlbPxp0lVNkbeGrz5nm2SCGz9F1Zh
 jOFpF8ALpFTFNBZkvqzIvpT120iFMUYvgS4ukfU/tVij7zlbVED9WtBvkOAYs7/89WKItHKU4/8
 GfPUsR1y2eOv1mE6knLsqL9daUvUcLNUx2r3mAoVP5mYfRpW+CJvmM76LVUB10IVTBnRtmVA5ml
 RvqtkDAPHr9eaC/LuxuCmHIVM81H0waktdI+GGbzxqrXV2rX+wXy67hMK5Gg7uHVopBbpY3gP+d
 /9pVjPiIeU/MkqE1GITk3XprhzvlSi+zP4eCx/ihDvHZpGr/j9unEIKHtZFFmaBMed2LzCVrxal
 lUqQVCK1cbD6sO1p1kI+hVQI+Njb+HUafqsj8p9gnZWV8nBfsaTWMeOi/2oZ5e3+7K63fRvNTNr
 VAO2hwIdK9e8snkPmCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/24/26 6:29 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
My previous RB tag was incorrectly included in a reply to Matt about v4,
but officially for v5:

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>


