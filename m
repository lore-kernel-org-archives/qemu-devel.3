Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252FEFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKchv-0007nC-8g; Wed, 06 May 2026 09:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wKcht-0007mW-DE; Wed, 06 May 2026 09:54:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wKchr-0007PM-EV; Wed, 06 May 2026 09:54:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6469uOxk3027857; Wed, 6 May 2026 13:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CCaDjt
 J693/GrsVwNyJuN0gvj6orBbdlxlluEtvrfcI=; b=JcDK48MISfvI97IYbnsG2+
 I3NiN+WSbu4Fb0+eF4XvLAZOLKOAAZ62/SmoRHPgLNVgV5L0/6YwPMuGhBflgn5d
 7vB8TIK35cqp/h05UBbj0+PBbql8J+p/m0NR4dgfZ7Xhgf/S2ZyFaP01uQnSyQYE
 1P5wEOPuucfUPoiLiusb/fPZP9+lYZ4llB67C7vbMHryYmtSHHQfdebKyNAxbCj6
 C1gMhVs4MQoX9oXFQ79WWjb0+JOq0ZYvD4+FcZidzyHO4CrxDXzMsK+I+BE54zXl
 SkbgJA9rYI9HEIWBYf1VSPYK4X8eAOY1HoChvG9gyofkVHgIgJBr1snehW0c3a9Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxr8ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 13:54:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DdUoc025614;
 Wed, 6 May 2026 13:54:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9ye6v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 13:54:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646DsCHr32637492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 13:54:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A000758055;
 Wed,  6 May 2026 13:54:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24CDD58043;
 Wed,  6 May 2026 13:54:11 +0000 (GMT)
Received: from [9.61.247.69] (unknown [9.61.247.69])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 13:54:11 +0000 (GMT)
Message-ID: <1fa40ad0-0ad1-4d01-9660-48b2f7f78b62@linux.ibm.com>
Date: Wed, 6 May 2026 08:54:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNCBTYWx0ZWRfXxaTgTC2u7M8M
 10n5F4w9nJlBZbRiemBWj1f4Z/EO8jLVt+CdgqAejXL5q8J+JbFpZpRwKAOG+l6m/kaBGWGZ+fZ
 b+SpVhEYk+lYKWuyarArBHLURBYxSOUYJ4v8hx+eHQeYoVmsjMHoFjHRp1LJfghD2xU/CbuIBoZ
 etWYHyIYQ+AkWDloC6fYZHZrnFb4PVXFTkN5OUbZI5K3mMhgWXwiDhuo77jUT8SOiH2fuKPglh1
 BsmPAPyap7c363K//hGaCxVec1FoQuHlmaqjEglsEtnXarA8ZxmDLOELUbyLSbDN8EQDr47Rx4D
 BNNed97DL8R7ubhypr39ggtu3w24E7hvaeZEG3zeUuq0cqrGa5F21NTJsEwhiYYvM/s8pQuIeyT
 ahyJHMGvetCNEiOOUeLvxGCMrwWqnFW7fjdF9eChhreBwfg5Z8iU449lca1fetIYyNmjQHe7xNt
 Eg8ClmHXxRK4gO0TgNQ==
X-Proofpoint-ORIG-GUID: W6WEuMz6RBIaYXL3-MrW2AuGEszCEOGQ
X-Proofpoint-GUID: Xas5_YaBqngRMHpMMrwhioKkKyVkfG3J
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb4807 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=M98VLt0xmqTDZtsn:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=YEB5RgzmAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=X7Ea-ya5AAAA:8 a=omOdbC7AAAAA:8 a=BRBGA3hWAAAA:8 a=TzBKX8RWupExPol2bRUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=_C00WXLGY46RvuVuNj2J:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 5/6/26 7:26 AM, Cédric Le Goater wrote:
> On 5/6/26 14:01, Markus Armbruster wrote:
>> I'm cc'ing reviewers and lists mentioned below, and frequent
>> contributors to MAINTAINERS.
>>
>> There are a number of MAINTAINERS entries with S: other than "Orphan"
>> without M:
>>
>>      $ awk '/^M: / { m++ } /^S: / { s=$2 } /^$/ && s { if (!m && s != "Orphan") print t; m=0; s=""; getline; t=FILENAME ":" FNR ": " $0; next }' MAINTAINERS
>>      MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>>      MAINTAINERS:1792: SH4 Machines
>>      MAINTAINERS:2022: Machine core
>>      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>>      MAINTAINERS:2555: vhost-user-scmi
>>      MAINTAINERS:2862: XIVE
>>      MAINTAINERS:2872: Renesas peripherals
>>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>>      MAINTAINERS:3719: Checkpatch
>>      MAINTAINERS:3746: RDMA Migration
>>      MAINTAINERS:3894: Record/replay
>>      MAINTAINERS:4029: OpenSBI Firmware
>>      MAINTAINERS:4153: SPARC TCG target
>>      MAINTAINERS:4233: CURL
>>      MAINTAINERS:4238: GLUSTER
>>
>> Some of these have R:
>>
>>      MAINTAINERS:1792: SH4 Machines
>>      R: Yoshinori Sato <yoshinori.sato@nifty.com>
>>      S: Odd Fixes
>>
>>      MAINTAINERS:2022: Machine core
>>      R: Philippe Mathieu-Daudé <philmd@linaro.org>
>>      R: Zhao Liu <zhao1.liu@intel.com>
>>      S: Supported
>>
>>      MAINTAINERS:2226: ACPI/HEST/GHES/ARM processor CPER
>>      R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>      S: Maintained
>>
>>      MAINTAINERS:2555: vhost-user-scmi
>>      R: Milan Zamazal <mzamazal@redhat.com>
>>      S: Supported
>>
>>      MAINTAINERS:2862: XIVE
>>      R: Gautam Menghani <gautam@linux.ibm.com>
>>      R: Glenn Miles <milesg@linux.ibm.com>
>>      L: qemu-ppc@nongnu.org
>>      S: Odd Fixes
> 
> 
> Harsh, Glenn, Caleb, Gautam,
> 
> Could you please propose a maintainer for XIVE ? I can still act
> as backup as a last resort but I'd rather not.

Cedric,

I spoke to Glenn and he'll take on the role of maintainer of XIVE. He'll be submitting a patch set shortly.

Thanks,
Caleb

> 
>>
>>      MAINTAINERS:2872: Renesas peripherals
>>      R: Yoshinori Sato <yoshinori.sato@nifty.com>
>>      S: Odd Fixes
>>
>>      MAINTAINERS:3165: CheckPoint and Restart (CPR)
>>      R: Peter Xu <peterx@redhat.com>
>>      R: Fabiano Rosas <farosas@suse.de>
>>      R: Mark Kanda <mark.kanda@oracle.com>
>>      R: Ben Chaney <bchaney@akamai.com>
>>      S: Supported
> 
> 
> Since Steve has retired, I believe Mark has taken over and should
> be promoted Maintainer. Correct ?
> 
> Thanks,
> 
> C.
> 
>>
>>      MAINTAINERS:3746: RDMA Migration
>>      R: Li Zhijian <lizhijian@fujitsu.com>
>>      R: Peter Xu <peterx@redhat.com>
>>      S: Odd Fixes
>>
>>      MAINTAINERS:3894: Record/replay
>>      R: Paolo Bonzini <pbonzini@redhat.com>
>>      R: Alex Bennée <alex.bennee@linaro.org>
>>      S: Odd Fixes
>>
>> Only R: feels tolerable with S: Odd Fixes.  However, S: Supported and
>> S: Maintained are clearly wrong.  Unless somebody steps up to serve as
>> M:, we should downgrade to S: Odd Fixes.  Volunteers?
>>
>> These have at least L:
>>
>>      MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>>      L: qemu-riscv@nongnu.org
>>      S: Supported
>>
>>      MAINTAINERS:4029: OpenSBI Firmware
>>      L: qemu-riscv@nongnu.org
>>      S: Supported
>>
>>      MAINTAINERS:4233: CURL
>>      L: qemu-block@nongnu.org
>>      S: Odd Fixes
>>
>>      MAINTAINERS:4238: GLUSTER
>>      L: qemu-block@nongnu.org
>>      L: integration@gluster.org
>>      S: Odd Fixes
>>
>> Likewise.  Volunteers?
>>
>> These have neither:
>>
>>      MAINTAINERS:3719: Checkpatch
>>      S: Odd Fixes
>>
>>      MAINTAINERS:4153: SPARC TCG target
>>      S: Odd Fixes
>>
>> Unless somebody steps up to server as M: or at least R:, we should
>> downgrade to S: Orphan.  Volunteers?
>>
> 


