Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CD5FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITYb-0007ry-BI; Thu, 30 Apr 2026 11:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wITYa-0007qp-3f; Thu, 30 Apr 2026 11:44:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wITYY-0002vF-6N; Thu, 30 Apr 2026 11:44:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UBUHQM2134186; Thu, 30 Apr 2026 15:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=OP3AzPnq30zAxg4JIWyin9zxI67vbeujnK3bO1ASYd8=; b=qsuhZwCv7NHx
 mdqdGa1wzVRJr5sJR3tX+EGZEdFTwOYTfOy7zdi4cf0v/pE1Qq/KhLBGYsnKJY7d
 A+ts1QBpBf5IuVgPG14MPnUj9ddsuSz59xtCIz+1QRBjLaXAasVNWkpgwtbFTq/b
 Sozb6fGVMhcTJKyRQfSv2y4+8UKR6SqbfiCiXKqOzroN3WTlqVaAzzZH9qWwk31i
 9SQYpX3Rp6BBWpHHUMpPoAjZIy4N9N0cuh1rRIskGgCHMdv/xrqd7XAsLegsgb6a
 i+ZH1cfwcL+8ytiddUpb9VDYKO/0wbYGtRa/mZ/kujyqMhFP+VJlS4nwfZpdDTjQ
 QvYW+C32Pg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rgjrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:43:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFciPs007185;
 Thu, 30 Apr 2026 15:43:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqksad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:43:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFhv3k32178744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:43:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4020A58052;
 Thu, 30 Apr 2026 15:43:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 406695805D;
 Thu, 30 Apr 2026 15:43:56 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:43:56 +0000 (GMT)
Message-ID: <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
Date: Thu, 30 Apr 2026 10:43:55 -0500
In-Reply-To: <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
 <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LYKKxBipLlxEdAEyI72G7zCLjleplTxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfX08VuQzb9VoZB
 4jIk643LB6+juR+t6KcGFGtVygaPFWogVPJ1E/DbC67w5TVkaqettTBvZdSxLP+TWsQrdxso6UZ
 ZzAStBS9Aasxo+9uBrRM3ZmgUnh6NrAtidM0q1cH1i6KDzRm2RvG3tKjiO/4q30G50Kjjw3vwu/
 jb9V315SOn68lff9M3nDhS9W6TYIQa4q1l2P1ofbC7T4C6x3I6OgxUUqY7qyDhNR9VYEHbZPUM6
 eFZiXreJXhi3Vwqd44oWnOaIM2mst9DuUQWXk+BxAG373fSaj2uJ01+CXQ6oo5VpWeSka4Tp11G
 HlANIQyGft/n2Qn+lzLBVO7aePD1VJZFqbwI87BTEIexred3IeGL3SWG1ob1K2D4YV45FM97HdF
 QWyj0WS13PwqAKHQPY8XwjgFy3/Cm9CzfJc2P8AMva+h6xNiDsehyQWaiqrYJzfmbYIn9iYZVUQ
 3eicdSx+rvQogZMvc2w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f378bf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=sUPKZ96fmHwcYvpxElwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B0fl1raFP4MRaDJ8eW_tQamkxpXteiCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-04-30 at 17:15 +0200, Philippe Mathieu-Daudé wrote:
> Hi Harsh,
> 
> On 30/4/26 08:54, Harsh Prateek Bora wrote:
> > Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
> > 
> > Glenn,
> > Please take a look and let us know your thoughts.
> 
> Glenn can have a look, but I think we are good to remove them now,
> they have been deprecated for more than 1 year, enough time for
> any reaction ;) Otherwise that'd defeat the point of deprecating
> and the pain for us to schedule and wait for months.

Philippe,

Sorry, I thought it had been made clear back in August of last year
that we would need the PPC405 CPU to hang around.  The topic was
brought up by Cedric when I added support for the PPE42 processor.  Is
there some formal process I need to go through to have it removed from
the deprecated list?

Thanks,

Glenn

> 
> My 'Should we proceed' was more of a polite ping than a question ;)
> 
> > regards,
> > Harsh
> > 
> > On 30/04/26 11:00 am, Philippe Mathieu-Daudé wrote:
> > > On 14/1/25 08:47, Cédric Le Goater wrote:
> > > > On 1/14/25 08:11, Nicholas Piggin wrote:
> > > > > On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
> > > > > > On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
> > > > > > > Hi Cédric,
> > > > > > > 
> > > > > > > Cc'ing Laurent & Richard for user emulation.
> > > > > > > 
> > > > > > ...
> > > > > > > The deprecation message (see previous patch) was about the
> > > > > > > "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
> > > > > > > for user emulation?
> > > > > > > 
> > > > > > > $ qemu-ppc -cpu help|fgrep 405
> > > > > > > PowerPC 405d2            PVR 20010000
> > > > > > > PowerPC 405gpa           PVR 40110000
> > > > > > > PowerPC 405gpb           PVR 40110040
> > > > > > > PowerPC 405cra           PVR 40110041
> > > > > > > PowerPC 405gpc           PVR 40110082
> > > > > > > PowerPC 405gpd           PVR 401100c4
> > > > > > > PowerPC 405gp            (alias for 405gpd)
> > > > > > > PowerPC 405crb           PVR 401100c5
> > > > > > > PowerPC 405crc           PVR 40110145
> > > > > > > PowerPC 405cr            (alias for 405crc)
> > > > > > > PowerPC 405gpe           (alias for 405crc)
> > > > > > > PowerPC npe405h          PVR 414100c0
> > > > > > > PowerPC npe405h2         PVR 41410140
> > > > > > > PowerPC 405ez            PVR 41511460
> > > > > > > PowerPC npe405l          PVR 416100c0
> > > > > > > PowerPC 405d4            PVR 41810000
> > > > > > > PowerPC 405              (alias for 405d4)
> > > > > > > PowerPC 405lp            PVR 41f10000
> > > > > > > PowerPC 405gpr           PVR 50910951
> > > > > > > PowerPC 405ep            PVR 51210950
> > > > > > 
> > > > > > Up to the ppc maintainers.  I don't know of anything interesting at 
> > > > > > the user-only level
> > > > > > wrt these cpus.
> > > > > 
> > > > > Just getting back to things after the break...
> > > > > 
> > > > > We are looking at modeling some microcontrollers on the POWER
> > > > > chips. There is an OCC power management controller which is a 405
> > > > > and some other weird cut down 405 derivatives, we're not up to
> > > > > those yet but we want to model them.
> > > > > 
> > > > > We should be able to remove a bunch of boards and CPUs, I just
> > > > > haven't started looking, so might be easier to wait for a bit.
> > > > > If it's not causing others too much problem, could we leave this
> > > > > in for the time being?
> > > > 
> > > > Sure. We will need a new SoC for the OCC and a firmware image. I think
> > > > these can be built from https://github.com/open-power/occ or, if not,
> > > > they should be made available.
> > > 
> > > Should we proceed with this removal now than v11.0.0 is released?
> > > 
> > 
> > 


