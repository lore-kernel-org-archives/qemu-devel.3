Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE022FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxA4-0006Ab-2y; Mon, 04 May 2026 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wJxA2-0006AF-K0; Mon, 04 May 2026 13:32:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wJxA0-0005Ug-Q1; Mon, 04 May 2026 13:32:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EmcBv3253820; Mon, 4 May 2026 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=zIfmtG33y487nSlQJh1u2z4mbpB3/1Gh37GwIu/+v34=; b=c70SSZ9EPM43
 3GnJcFSy2FDDh/6u4FRXN6O/rFYZBOTyX1WhbMPaV4QvZaO5zcDISGLL67Cx2Xpa
 R5XNvyr7Adap8DkvAEi00MRq1aI/ywzOt05b0EDNFmTVQrFEYaVEvgdOa2NPOkGx
 8fEwhRy3qqekMOCj5dRdSsJ3PEtthJlIqA5htZPvT1S0oEa+b3aoxdrZu/OyZiNf
 AYfhaRRZR1NnUZoHkn7w7qgrbQ9kZbTiogu8oxKUuEI42vOJoqnmycaC0c4SAqq7
 cn0ntY2ZINkXzxFO8no0X6DTYYzyEkxTTzC7J2+gP1zmBgBrWFXZ2rk4wt6ULX1Z
 EvbgU8iwfg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6816h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 17:32:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644HOSYW009039;
 Mon, 4 May 2026 17:32:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg60yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 17:32:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644HWhv414484178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 17:32:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D605658054;
 Mon,  4 May 2026 17:32:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF59158045;
 Mon,  4 May 2026 17:32:42 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 17:32:42 +0000 (GMT)
Message-ID: <b12aedb5b7a1cb3f0175cd3a593e17d0b269efac.camel@linux.ibm.com>
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Richard
 Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
Date: Mon, 04 May 2026 12:32:37 -0500
In-Reply-To: <3b6ba410aa57cb53612c3fcd836a52f4295df478.camel@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
 <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
 <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
 <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
 <06c5cd6f-46a3-453e-a0b5-30e2bd03a4d0@linaro.org>
 <3b6ba410aa57cb53612c3fcd836a52f4295df478.camel@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f8d83e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9waQfESMeQaW2VO_eOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CfO_wPayk92Hbg5e-ORbgBl0pTIy4OaV
X-Proofpoint-GUID: casJuPrCEBbtdkPS4BL5dWEgrW9FyekI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NiBTYWx0ZWRfX/1yl+IUW179k
 Hzk7t8Q1QFkH72EibUmvhwz4GsMuWQJRMfW9iXYbQdk3FT4p6lAx7Ul72i+ISOM9FP5AHGCzp/o
 mdUuhDopMQceH+rSA+4cdCUtTcDFExgf1jfJ0j9F6Cg/I0BudAQ3lA6ELjhHH6EAzZhM0nMeR5V
 /jYxCya90f5a+oYaykjcL0eduxhHgXFRQGVB6qGJcWob0/Xy6sHBC5G9o9A2xbmh7WJXa5PkuWs
 9BTVeZO1zhEdFwVAFF2SH/l2RUVfMouQzgeceE7O7/Oyh7g1KtMW/vfzGvHrN9Aw4q9A+5fpQTK
 c3OCqpcWZr0+hZYMu/hmSmjpp9gDp9J5CTOfBybdLRUwKiMueZEkBkbvtGd5LEwnQ0/7+EMkw9p
 s75Uq24J0itoo91g4VgtG2VpgyRGmQXOmecG5Qu78BRUCVLfdNwMC6f7dh+YM+UUw8oEyYt6VQ+
 Xoa7wI2i0ats6dOT/Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe,

Regarding the MAINTAINERS file, do we really need a new entry in there?
We already have an entry for the PPE42 CPU with myself as maintainer
and I believe the rest is covered by the "PowerPC TCG CPUs" entry. 
Were there any files in particular that you had in mind?

Thanks,

Glenn 

  
On Mon, 2026-05-04 at 09:59 -0500, Miles Glenn wrote:
> Ok, thanks.  I'll go forward with these suggestions.
> 
> Glenn
> 
> On Mon, 2026-05-04 at 14:32 +0200, Philippe Mathieu-Daudé wrote:
> > Cc'ing Daniel and Thomas, our deprecation experts.
> > 
> > On 4/5/26 11:48, Cédric Le Goater wrote:
> > > Hello Glenn,
> > > 
> > > 
> > > On 4/30/26 17:43, Miles Glenn wrote:
> > > > On Thu, 2026-04-30 at 17:15 +0200, Philippe Mathieu-Daudé wrote:
> > > > > Hi Harsh,
> > > > > 
> > > > > On 30/4/26 08:54, Harsh Prateek Bora wrote:
> > > > > > Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
> > > > > > 
> > > > > > Glenn,
> > > > > > Please take a look and let us know your thoughts.
> > > > > 
> > > > > Glenn can have a look, but I think we are good to remove them now,
> > > > > they have been deprecated for more than 1 year, enough time for
> > > > > any reaction ;) Otherwise that'd defeat the point of deprecating
> > > > > and the pain for us to schedule and wait for months.
> > > > 
> > > > Philippe,
> > > > 
> > > > Sorry, I thought it had been made clear back in August of last year
> > > > that we would need the PPC405 CPU to hang around.  The topic was
> > > > brought up by Cedric when I added support for the PPE42 processor.  Is
> > > > there some formal process I need to go through to have it removed from
> > > > the deprecated list?
> > > 
> > > I don't know of any un-deprecation process. I suggest sending a patch
> > > to revert commit 52f0b59ec6b7 ("hw/ppc: Deprecate 405 CPUs"). The commit
> > > log should mention the PPE42 processor which is a stripped down version
> > > of the IBM PowerPC 405 processor.
> > 
> > That, and updating MAINTAINERS for these CPUs (likely adding a new entry
> > including at least Glenn).
> > 
> > > Thanks,
> > > 
> > > C.
> > > 
> > > https://lore.kernel.org/all/20250925201758.652077-1-milesg@linux.ibm.com/
> > > 


