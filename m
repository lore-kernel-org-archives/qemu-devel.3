Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB5CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyht-0002RN-FN; Thu, 10 Jul 2025 17:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uZyhr-0002Qm-St; Thu, 10 Jul 2025 17:21:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uZyhp-0001YF-3A; Thu, 10 Jul 2025 17:21:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AKn6Vl026281;
 Thu, 10 Jul 2025 21:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DlQBU8
 iN1Zn42nIC5RU3DARvLI+9tnYdgOiIOxyQ6yc=; b=XvGuM3zA3jo4J29iwU0RSJ
 sfDTbiE4l6K9qLs4deO4oFAcM+bH2HxTC9/5dp6UbQri6DEYeDivwwtg8LgrGfVJ
 uZs9MfoHbTAwRBrXxNw3dR83umGHYazv/g6Yk8b93B5BnhbmOlSBwt8DYfYYKJ/Z
 QkG324Jt5Q5ImCpwuISu43EvfGQh/FtjbaRWQiSKlb+oq4Z0fEWyxbLGt8y63rgb
 uVEJFuRZ50X4imiNt4QdvOzz/cG0pUAOR9hKyil99CBIsK8/RgHusrX23sPw/aWM
 hq9Q6MCfNYeFv4TI2iReJ4Xa+Wu45HGyptNV8FFGhf//OYZd92rS2OiFfJTQ0LAA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnp5qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 21:20:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AINjfl002847;
 Thu, 10 Jul 2025 21:20:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmqg8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 21:20:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56ALKsFj32178888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 21:20:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 450FA58059;
 Thu, 10 Jul 2025 21:20:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 937F65805B;
 Thu, 10 Jul 2025 21:20:53 +0000 (GMT)
Received: from [9.61.107.132] (unknown [9.61.107.132])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Jul 2025 21:20:53 +0000 (GMT)
Message-ID: <36819228-b4c2-44a7-bc85-f5630c8412b5@linux.ibm.com>
Date: Thu, 10 Jul 2025 17:20:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in
 functions taking an ett
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250710161552.1287399-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250710161552.1287399-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=68702eb8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=tF9ib_puwyeb5LtTvjEA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: j1oZxdu8S-oXX4Z0SdZjxVPziMmjKsFG
X-Proofpoint-ORIG-GUID: j1oZxdu8S-oXX4Z0SdZjxVPziMmjKsFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE3OSBTYWx0ZWRfX1bt+hBOTHbEs
 5D6jY+QG20ai3jLHnH/tZ+UjVWnjOG0lWREgtAdxNS9MexUgba5mIYay5tKwN1Uu7ZCWCs9XEIo
 wdHnjqTDLJMGuX0aPblSOuMldNjNnAKVOTUrUTIFfIMP0wdJuv4qP2PrHVEOWau/NaSVyl0XqmI
 8kTqZtSm3lQCv2JsTUlMlYuZhzpqY4yXc4xB0y/L51qaLVlS8JPNZbI3UuXV1Kyp64UGBzcOzvB
 2i8TISOieN4biPFfBEF1Uk7DUn+xIDTava93jSxrxEaQjqRXtgYakgzVIWdaoR2TSQkxMvagsk3
 kp3ZwAyK91p5CsBEMDpfZHzjWvSMBAJCPZ7wP4mYIen1WMEAIqRkOXOuJtuPCaMhddc/YRZhI5c
 JbuqvhEjnz/zMqGFvsN0cJ/mioqLjaPZUNyW4xB/rZGdGdS+A8Vn7U6VrSId+UaSQfHqZNmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=450 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100179
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/10/25 12:15 PM, Peter Maydell wrote:
> The s390-pci-bus.c code, Coverity complains about a possible overflow
> because get_table_index() can return -1 if the ett value passed in is
> not one of the three permitted ZPCI_ETT_PT, ZPCI_ETT_ST, ZPCI_ETT_RT,
> but the caller in table_translate() doesn't check this and instead
> uses the return value directly in a calculation of the guest address
> to read from.
> 
> In fact this case cannot happen, because:
>  * get_table_index() is called only from table_translate()
>  * the only caller of table_translate() loops through the ett values
>    in the order RT, ST, PT until table_translate() returns 0
>  * table_translate() will return 0 for the error cases and when
>    translate_iscomplete() returns true
>  * translate_iscomplete() is always true for ZPCI_ETT_PT
> 
> So table_translate() is always called with a valid ett value.
> 
> Instead of having the various functions called from table_translate()
> return a default or dummy value when the ett argument is out of range,
> use g_assert_not_reached() to indicate that this is impossible.
> 
> Coverity: CID 1547609
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: only tested with 'make check/make check-functional'

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Also to sanity check I ran various tests with s390x guests and a few different PCI passthrough devices using a guest IOMMU to drive table_translate frequently.






