Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1378AFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITQO-0004Ds-5M; Thu, 30 Apr 2026 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wITQM-0004DW-S3; Thu, 30 Apr 2026 11:35:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wITQK-0000yK-4T; Thu, 30 Apr 2026 11:35:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UCu3bS2902222; Thu, 30 Apr 2026 15:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=QEpxw5u3ZeBI4gsH2LsgzDD6PLZ0Y19GAt9lC5gyr/Y=; b=aQRnFZEGJ1mJ
 U2Ba6UCExtReFSJb2+hKHZfwWflwP2MZjaAgZuiECzhanRe/5mX61GLB+05InrRA
 QRZ61nEiAAI0FmSE0z8zzCH7AFoQ7vckRhmF6Sas0y/7bsoO8WaXQNfbvfOAXefb
 6WlAbqXQFArRweeglODriDxpdK6xV/OtpoCCyfSaFogd5BQad5z9n3RfQoRtFMvj
 06bri5O1IEVOHfPnbtjfk5zVdh0ls10KfMDeMDM1W5v6PosPTn2AxedW227nCVUB
 jiHY5Rki+cKRa0rw6JPGFioC5CuPVbTAz3G5mO+/nKTXOj3ui3DGcHHN4uwHcYCc
 dwB3Q3h/iw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rghn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:35:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFOBqA025204;
 Thu, 30 Apr 2026 15:35:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqkrfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:35:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFZQHH23921376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:35:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5911B58043;
 Thu, 30 Apr 2026 15:35:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D045158055;
 Thu, 30 Apr 2026 15:35:25 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:35:25 +0000 (GMT)
Message-ID: <e9763956f267d76deb77ad8d9f13bfe1d653e1e5.camel@linux.ibm.com>
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
From: Miles Glenn <milesg@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
Date: Thu, 30 Apr 2026 10:35:25 -0500
In-Reply-To: <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: l6gfg1tWScuLn9mjyQPX2bjGsicaFEv0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfX9cTp3bX7004F
 0EThlzchKcmjq5N2qdMGQHQwSVfK4+Mo619Ky3pkHbmI/iiXWZAVaZeLHocMqqZM1jEx5y6EfWx
 QPhtqMwvtrjTd/kT4qY9hx3WKcMvyzvPz7TiCM0K02U2SwMf8s7GzOWmhdVLseUwukn+VZw8ZY0
 JbffVFMggXtvIozrRGYsZYgpC2RPrX3wx2C8gBcuwjK0KBk0lLqiRr5CiqSY6qjoba+ebFb2958
 ywlxOmo8SxzFg6/jYBkLbzb5voL5ToxJvJ7kh7CMVQBfXJvZzBkvCyvPMkSWEZbk2s/8GX1bk+n
 g5zxoz7O5MjgEFPf3CVJzyxLJ6wCtKKs4sU/UXow4BcZiUZVJrKajOROHPchXLvuhZn+HmVB2X0
 GluTB61chEM6qpaEA5rul+eT2mLIXzxUA/EtxHyVxxXG0knSXktUxV1FTM7vjrkojLgtdmQol4G
 QdKaw+Ld1WyBSiq7TQQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f376c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=JEIxtMm6yCCKLlLNWuYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qbcxqdLgt1rTIOF4M3RyUg3ePzsZCjEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
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

Please do not remove the PowerPC 405 CPU.  We are currently using the
PPE42 CPU which is heavily based on the PowerPC 405 and we will be
using the PowerPC 405 CPU in the near future (probably within a year). 
I do not have a problem with the removal of any boards as long as we
keep at least one for regression testing of the PPC405 CPU.

Thank you,

Glenn Miles

On Thu, 2026-04-30 at 12:24 +0530, Harsh Prateek Bora wrote:
> Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
> 
> Glenn,
> Please take a look and let us know your thoughts.
> 
> regards,
> Harsh
> 
> On 30/04/26 11:00 am, Philippe Mathieu-Daudé wrote:
> > On 14/1/25 08:47, Cédric Le Goater wrote:
> > > On 1/14/25 08:11, Nicholas Piggin wrote:
> > > > On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
> > > > > On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
> > > > > > Hi Cédric,
> > > > > > 
> > > > > > Cc'ing Laurent & Richard for user emulation.
> > > > > > 
> > > > > ...
> > > > > > The deprecation message (see previous patch) was about the
> > > > > > "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
> > > > > > for user emulation?
> > > > > > 
> > > > > > $ qemu-ppc -cpu help|fgrep 405
> > > > > > PowerPC 405d2            PVR 20010000
> > > > > > PowerPC 405gpa           PVR 40110000
> > > > > > PowerPC 405gpb           PVR 40110040
> > > > > > PowerPC 405cra           PVR 40110041
> > > > > > PowerPC 405gpc           PVR 40110082
> > > > > > PowerPC 405gpd           PVR 401100c4
> > > > > > PowerPC 405gp            (alias for 405gpd)
> > > > > > PowerPC 405crb           PVR 401100c5
> > > > > > PowerPC 405crc           PVR 40110145
> > > > > > PowerPC 405cr            (alias for 405crc)
> > > > > > PowerPC 405gpe           (alias for 405crc)
> > > > > > PowerPC npe405h          PVR 414100c0
> > > > > > PowerPC npe405h2         PVR 41410140
> > > > > > PowerPC 405ez            PVR 41511460
> > > > > > PowerPC npe405l          PVR 416100c0
> > > > > > PowerPC 405d4            PVR 41810000
> > > > > > PowerPC 405              (alias for 405d4)
> > > > > > PowerPC 405lp            PVR 41f10000
> > > > > > PowerPC 405gpr           PVR 50910951
> > > > > > PowerPC 405ep            PVR 51210950
> > > > > 
> > > > > Up to the ppc maintainers.  I don't know of anything interesting at 
> > > > > the user-only level
> > > > > wrt these cpus.
> > > > 
> > > > Just getting back to things after the break...
> > > > 
> > > > We are looking at modeling some microcontrollers on the POWER
> > > > chips. There is an OCC power management controller which is a 405
> > > > and some other weird cut down 405 derivatives, we're not up to
> > > > those yet but we want to model them.
> > > > 
> > > > We should be able to remove a bunch of boards and CPUs, I just
> > > > haven't started looking, so might be easier to wait for a bit.
> > > > If it's not causing others too much problem, could we leave this
> > > > in for the time being?
> > > 
> > > Sure. We will need a new SoC for the OCC and a firmware image. I think
> > > these can be built from https://github.com/open-power/occ or, if not,
> > > they should be made available.
> > 
> > Should we proceed with this removal now than v11.0.0 is released?
> > 
> 
> 


