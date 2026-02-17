Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A79E68149
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGoK-0003ee-Ep; Tue, 17 Feb 2026 03:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1vsGoJ-0003eM-3e; Tue, 17 Feb 2026 03:51:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1vsGoH-00088l-IQ; Tue, 17 Feb 2026 03:51:58 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H6Hl4u3548407; Tue, 17 Feb 2026 08:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=z9v2eG
 PO98yQYxa7pdi54Q3clFHoZ4yUqPrRZ6jGAaM=; b=XQ0AcDXpfiaOodHABrfBPc
 lOFLVfJGtRTUhSRkl59AsdJUMimcica5DAe28XeDCKwb7ZsAJ3AsFksjP7CYtwEq
 DCgXaoC3brt7bNwIx3QT9NYL+7LrMrpv15kCS6heLMkqSV1sXvEOppbDoetz+XGn
 JzCwoQgKVyxImJiEqNBsTlhSxi3GOfHi0cd55WlzZ0C6ctXpZT1a8L0apqpHMngT
 hBMnVcobWnnK8NHq3gDhK6AQeAQxb0hcBBx7DfNz5gxMosl5Bafexr2K3Z3RHa6f
 8OqlKAHXqUU97qeue5HJLoT1Mc12I3blzizWoL+m9x8fyX61tFMRjAJkvIbqFoGw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqu5mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 08:51:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3OSbN011898;
 Tue, 17 Feb 2026 08:51:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb26ss63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 08:51:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H8pkDE23593326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 08:51:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71FBC2004D;
 Tue, 17 Feb 2026 08:51:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D3142004B;
 Tue, 17 Feb 2026 08:51:46 +0000 (GMT)
Received: from darkmoore (unknown [9.87.130.124])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Feb 2026 08:51:46 +0000 (GMT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 09:51:41 +0100
Message-Id: <DGH3XLSWU2OB.29T9W7UBKFNRS@linux.ibm.com>
Subject: Re: [PATCH] s390x/kvm: Add ASTFLE facility 2 for nested virtualization
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Halil Pasic" <pasic@linux.ibm.com>, "Eric Farman" <farman@linux.ibm.com>,
 "Matthew Rosato" <mjrosato@linux.ibm.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Ilya Leoshkevich"
 <iii@linux.ibm.com>, "David Hildenbrand" <david@kernel.org>, "Thomas Huth"
 <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Cornelia Huck"
 <cohuck@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Hendrik
 Brueckner" <brueckner@linux.ibm.com>, "Nina Schoetterl-Glausch"
 <nsg@linux.ibm.com>, <qemu-s390x@nongnu.org>, <kvm@vger.kernel.org>
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Christoph
 Schlameuss" <schlameuss@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260211-astfleie2-v1-1-cfa11f422fd8@linux.ibm.com>
 <8f5f2131-b5cc-4a9a-84f7-57586c3df928@linux.ibm.com>
In-Reply-To: <8f5f2131-b5cc-4a9a-84f7-57586c3df928@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9tM4ANgpK_AQqaAow0r-uO8I94VAgi36
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA3MSBTYWx0ZWRfXxhPkqfcZfJhD
 R994RWTLLlXqN2+XV2LfkQunSZT3HP33ZCqK+QYwpPqfNQub1iLwylz6H51/UmzaHkstYUMpJKB
 64JdfAXccyw/Wh76r4YsknDiY0KfrGeLglchV3+I2YgdyoulFKEXyS+ypVQUM4j63kvsdZ79I6F
 PqEZUJRnbOP0CZlxi4K4n4ux/Ul6LrzEM1G0N1KN5V9XgSdUBZYf786Azkx261CKM+vFo21eezV
 qwkEnExDsJwhkFcKXbSqLoTQ0+9qFDCq3sfL/mbRDo5XGTOP1UCm2eigCw5mrynBnGTFC2W7jRI
 2ia0zmxflLxa9ofzZyAgzqT0CGnRpWoHYfMjInoWY2nqhN3fokZxf9mfrNy28uscuV/wZpp8Dsf
 WaTmsYV9KeZxxWhdjmqMCYVz2fnujRVoOlyZt5ITs6pHL/CT/T6B3OejQ2zQ2jtGnjutS3wuCYr
 kVMZR1IHc7403efbUzw==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69942c27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=Iy1ZBe_RzdfgodXlwn4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9tM4ANgpK_AQqaAow0r-uO8I94VAgi36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170071
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=schlameuss@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Mon Feb 16, 2026 at 8:44 PM CET, Christian Borntraeger wrote:
>
>
> Am 11.02.26 um 15:56 schrieb Christoph Schlameuss:
>> Allow propagation of the ASTFLEIE2 feature bit.
>>=20
>> If the host does have the ASTFLE Interpretive Execution Facility 2 the
>> guest can enable the ASTFLE format 2 for its guests.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>> Cc: qemu-devel@nongnu.org
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> To: qemu-s390x@nongnu.org
>> Cc: kvm@vger.kernel.org
>> ---
>>=20
>> @Christian, @Hendrik: Please confirm that we want to add ASTFLEIE2 to
>> the Z16 default facilities.
>
> This depends on the sie facility (sie format2) so I guess it should not b=
e default
> but rather FULL model.

Thank you, will limit it to the full model in the next version.

