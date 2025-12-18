Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C29FD6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJty-0001Pk-EQ; Thu, 18 Dec 2025 14:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vWJtt-0001LQ-3V; Thu, 18 Dec 2025 14:43:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vWJtr-0001jd-On; Thu, 18 Dec 2025 14:43:00 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJ6XTb007666;
 Thu, 18 Dec 2025 19:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8ll/o2
 477bZXrx8jaf+2IlIFnOJsgomcyi8qYwy6cIk=; b=c4RR0pGoXXjToiwu6rOQwu
 M64WKiFRdCnbhSuYpHWJMEc3WGYmbW3lyI5/d+CHl3HnbvlXfvhXZaYjElasZW4M
 jVlEh9sBpnv+gAw/hphc9JRLmsLr4EdDagkGDvO+j7KXkGCVIlIlMe8OFNlbl6Le
 PPkK9W5rTXyLmkiG/tcrL2JbkqCYX4pnx5Y64Y8EtZTIY2JyvCjr6BcjBqFPbqmc
 W+ZwhLhzUVe0H8xZKQab/Whos4szbSkw2VXzh9X2cSFDsu9dcpq9BCYJiGggq86D
 5Sl0zKGIU6PzROq6C/yVlpH4TBaa+bQHlF+PT0LSUKui7BAgdanelYkgaHq4pbcQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjqbvby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:42:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJY5f5031459;
 Thu, 18 Dec 2025 19:42:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvu8136-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:42:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIJgtB626542780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 19:42:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55F5958061;
 Thu, 18 Dec 2025 19:42:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CD3B58066;
 Thu, 18 Dec 2025 19:42:54 +0000 (GMT)
Received: from [9.61.241.132] (unknown [9.61.241.132])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 19:42:54 +0000 (GMT)
Message-ID: <7fa5f075-49c6-4703-bf0a-c48be5a52ee2@linux.ibm.com>
Date: Thu, 18 Dec 2025 11:42:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add util/s390x_pci_mmio.c to the S390 PCI
 section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20251218193642.170968-1-thuth@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251218193642.170968-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX4qxj7A2Kq2Iz
 9fHuo3OUiEPD5v+Ay2ZE9qKkMePptBpC7tzT7ejSqXcMnuAPKxvfaBsVAfLz37UstkHFOAxFgdu
 vTODoybJ2CawLZbYKDm57FLi2luo+EckwO6oDjrTVeBEIs/CjSCYl0U5scrmWI9IWrN8aR0lUeb
 vs3qteZphUlC9dRCuEYdtEqdp4FNCXKz4i5eItxm3YYO/EJvybAgCMMHzzqJ54lOf5QoBrDLGDc
 S/Axfz9I/b/6sAybDEp21ajGQbeMCGRVQm9Rto9N0ebYUhucTIbOteegT7aSy2KugcVai8Mdunl
 LBVI/4lUl8k6IWhLVa1UanPK0LUb8IZrHX5VQt2r/MmfwKCIo4cJ6bUgrOq+n2gWBbVrI9SLggN
 xUX+Kcb02XxHvgT9gWonyiXQJ5ZXMg==
X-Proofpoint-GUID: 2eYPgeNhKrKWmANxe2AZK6tdoIhuL5Ts
X-Proofpoint-ORIG-GUID: 2eYPgeNhKrKWmANxe2AZK6tdoIhuL5Ts
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69445941 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=ilp5LmaJLCwKH9wWbpgA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


On 12/18/2025 11:36 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> s390x_pci_mmio.c currently shows up as unmaintained. Add it to
> the S390 PCI section to make the right people aware of changes
> to this file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7faa5672a4..226bf64f68e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1843,6 +1843,7 @@ M: Eric Farman <farman@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/s390-pci*
>   F: include/hw/s390x/s390-pci*
> +F: util/s390x_pci_mmio.c
>   L: qemu-s390x@nongnu.org
>   
>   S390 channel subsystem

