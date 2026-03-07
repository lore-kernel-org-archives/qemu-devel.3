Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A8F513ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 14:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vysk3-00083V-W5; Sat, 07 Mar 2026 09:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vysjy-00082E-Am; Sat, 07 Mar 2026 09:34:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vysjw-0001nb-Fo; Sat, 07 Mar 2026 09:34:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 627AFhYH1568061; Sat, 7 Mar 2026 14:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lx4PZP
 GeuQl+NBAETTs2GdxY0mTntWP8SR+m30D6Fkk=; b=Plb7X0iUSK0FQRuNtbv87A
 hZjM21ipq+bRBgACxYAhSQ6atOMUiAzTFHxdTn8L14d6yIY3tGETCEpF3GTnXRt9
 rGFwqjVdAmaLOkm2wRME8eRUE1BkhXOXwhJK/J5kB7VbT64RotGvfnBz3jVZbrla
 fXXZe/XdOHSGgHW+XKX3r1zuVfFLh5fC3KZMwqEywaVCMLjyXrtuzYNqWmYlo1aj
 AVBwOiT8/0G8iby3Mrn6wlH8D+zs2x3FbDEe1z4OuBksbRqIoPLcPi8BHnN7rJRD
 Cdbga3Eupqb2msbf2xlV4Kt/0mzatsZORZHWVpMoL3VPtmnROBgnPiK2biY2Oy2Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1m93va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Mar 2026 14:34:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 627Bg4wg029016;
 Sat, 7 Mar 2026 14:34:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsm1m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Mar 2026 14:34:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 627EYRoA38535546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Mar 2026 14:34:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B122420049;
 Sat,  7 Mar 2026 14:34:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 867B320040;
 Sat,  7 Mar 2026 14:34:24 +0000 (GMT)
Received: from [9.124.213.84] (unknown [9.124.213.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Mar 2026 14:34:24 +0000 (GMT)
Message-ID: <0fc09340-df2d-4eba-a5b8-ecab3d8a52d5@linux.ibm.com>
Date: Sat, 7 Mar 2026 20:04:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
 <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
 <7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppeczqmix@wtrwux3aeswg>
 <aapz6OnPgmMevinB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <CAFEAcA9wBVE7XcpdNfnz0xs=vQMj6jT1ce19o9TKAZeY_qKVQg@mail.gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <CAFEAcA9wBVE7XcpdNfnz0xs=vQMj6jT1ce19o9TKAZeY_qKVQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69ac3778 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ck-FgUaf3JL1Vr6-PMQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDEzNyBTYWx0ZWRfXwAynM+P+r8eg
 rxdkwigN0abh0Rf9nH1VIATRKiSgCpRZnxeKn0idkZqox0XZxEJd+728/P5UO5Y0sBehLegPddn
 AlvGSSL3Rk4BiA9jNgeqthBZ7kwSL0WyfmKJLblzfv932sv02BqSVz0/Ql/yGxUVgn/HxLLhTz9
 vmy10dKufsiJsV+AnwB4Aazu4hjvi+EEhgJdgPndJXv7VQfDm69oCoU5Z5uL3eYlCc+cMkOaziE
 DJ/Ksa1m/RwYb2Yo5KO8XipT/rCcocszYCGlhp0AcffZy88RNqSrtgi1FNseOB2TFJW0F+9pe0N
 S3/s9oU/+WKh1Jg3vU21Uc0J4kNFtUgceqsF3Wxi/RuVNv4yW/jMGXun+G44jSdYfZciwz7v7FV
 Gfqows7bCsxaU92HfcLsuVkozB3NCiI0tXgD0d36wqhAxl1nPXSRGptMyRrQIdK3ob0fICFJ/E+
 IgFh2Gdy+Em68E5T6fw==
X-Proofpoint-GUID: ta_SSPK2WKOi2KkSYNQje8zCk_UKmRdJ
X-Proofpoint-ORIG-GUID: NIVzOCWUA-vuiMHa6hCqxKnO0LManA4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603070137
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 06/03/26 14:27, Peter Maydell wrote:
> On Fri, 6 Mar 2026 at 06:32, Aditya Gupta <adityag@linux.ibm.com> wrote:
>> I have below suggestion for this, acknowledging peter's dead code
>> suggestion and balaton's concern about things changing at runtime
>> (would be possible if let's say adding/removing a phb is allowed from
>> qemu console)
>>
>> This generates the fdt everytime on a pnv_reset, which might be same as
>> previous fdt but takes care of the cases where any device changes
>> between init and reset.
> Do you intend this as a sketch of what to do later when the FDT
> can change at runtime, or a plan for now?
Yes that is my plan for the case atleast when FDT can change at runtime,
eg. when MPIPL is introduced.
>
> I think that for now (i.e. fixing this bug) we should do the
> simple thing, and generate the FDT once on startup.
>
> We can design what to do for the "we really do need to
> generate a new FDT on reset" case later, when we have the
> requirement that motivates it.
Makes sense. I am okay with either way since I don't see fdt changing at 
runtime
for PowerNV as of now

Thanks,

- Aditya G



