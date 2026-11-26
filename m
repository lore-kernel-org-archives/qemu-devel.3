Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14D606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D5hVApVh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWew5-0007qP-QF; Thu, 26 Nov 2026 14:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xWew2-0007po-5J; Thu, 26 Nov 2026 14:15:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xWew0-0007RU-D9; Thu, 26 Nov 2026 14:15:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQG4aEO775616; Thu, 26 Nov 2026 19:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=fwc4ODGBg0w9/7qUVvbaUJZmlpw+Pu
 NQQD5lEsVytwc=; b=D5hVApVhnK/B6xFS/bwcs+oA2SSeXTwLaWxkhdkpQjo9Vi
 MkIzJBBQmci2WoqDEGArwTAU7zNbCi5wUVs6y5UpQlkX10otwm/R/Cjfyc6jDS8m
 IsHWlyKecwXWg5IAHFtRCPDloqRJ2GX15IMT4ikyCfL/UaLbr6yDU4F3eNf86fnt
 ClIpCIfJfyhBbMm+RiJ6FvbSqhPnwbpF26onF7j1s6rxzgYo4SVcjHfEW++JwMen
 T7OxPG4uC1fQaxudAbbMlU5OkzWaLo/OIuoGgp6dI4yKFoleRQOQ20PdLjx8QKER
 thncAEp+1QNpy/6AIbaOP68BPn1scGUq6Mx3maWA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34faju8a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 19:15:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQG4FKi1406265; Thu, 26 Nov 2026 19:15:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa7g2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 19:15:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AQJEwGK47841648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2026 19:14:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B90F20043;
 Thu, 26 Nov 2026 19:14:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A27720040;
 Thu, 26 Nov 2026 19:14:54 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Nov 2026 19:14:53 +0000 (GMT)
Date: Fri, 27 Nov 2026 00:53:26 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc/spapr: Match the CAS PVR list terminator as PAPR
 requires
Message-ID: <20261127004815.9e9da3b9-e3-amachhiw@linux.ibm.com>
Mail-Followup-To: Showta Ishizaki <zakinko@snowrabbit.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NSBTYWx0ZWRfXy77ojx8e0mpZ
 O3PiABNNofCn/Pr2T61JyYZX0LywMXgdtv+7hbZ8IQFzL6hGTcpNPWxQDNJAgd3bUNI/sY30aWK
 Gy5dX9OFLM1+iQTTpNOeNwNGuHrkROQskLbOEq/dNn5VxT6DnOwoj3Rz0RrUIQYNe4YNRuCj32G
 ZyOzHb70QGEa+SpYmSbYu/ONiaZQo2M0eOj40xGBZDb0SHEFjz/w2yK5ZfVJ5CEI07inHHUpktu
 +eKY7GFK6wUW7/WkMuvRIK2Thmy7recFcZ9FXINgge+6W4p7qPrxbS/GSpdjLnD9zTWdSBE27fS
 ZVDGS3C3xe0IgeyVF0djJirnraQ/J3bjGz1QgNHzB7J8Lz/aDvv2b06YOguv6GUHPqNEJFb1pfK
 kP/ksisnWA5lWVljyOmUpXQQlz+OuANoJI36zu1KqGnO9ZdEz6yLYGein+E29RTU7GOTtli9ovb
 7VlnkYkVJOsBQvssUZQ==
X-Proofpoint-ORIG-GUID: uDRhElul35k9oN4f99tW50nUQARcZ2q1
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b088538 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1vYAx1WhSG8MWoolV_wA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: GXU5NSAp3qqBptejUqBJqqILvNFgBKG7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NSBTYWx0ZWRfX7MMdkSTVJo7z
 6VRCCQ8ts5mrln6Y0/Mx05hQxAGIKZywuyutW0zW2UWPLZ8GpOcFIPCL/6GGGOOmxBsRFik+IzJ
 VZvVqGoAZYNx8QIeIyI/z+gKQLK1hQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260075
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/29 03:45 AM, Showta Ishizaki wrote:
> cas_check_pvr() stops at the first entry whose value has bits outside
> its mask, before comparing that entry with the processor's PVR.  PAPR
> has the PVR list processed "until either a List-entry allows the
> process to continue, or the Terminator-list-entry has been processed",
> and both of its "List-entry values of special interest", 0x00000000
> 0xFFFFFFFF ("matches any PVR value") and 0xFF000000 0x0FFFFFFF, are
> terminators (B.6.2.3 in PAPR v10.60; the same text is in B.5.2.3 of
> LoPAR 2.9 and B.6.2.3 of LoPAPR 1.1).  The terminator takes part in
> the match like any other entry.
> 
> The check came after the comparison until commit 152ef803ceb1
> ("pseries: Rewrite CAS PVR compatibility logic") moved it in front.
> That commit describes a change in how the compatibility mode is
> chosen, not this one.
> 
> A client whose only entry for the processor is the terminator gets
> "Couldn't negotiate a suitable PVR during CAS" today.  NetBSD's
> ofwboot ends its list with 0xffff0000 0x0080ffff to cover Power10, and
> fails on -cpu power10 this way.

Hi Showta,

Before I send a full review: I would like to reproduce the NetBSD failure
described above and have not managed to.

What I tried: NetBSD 11.1 ofppc (NetBSD-11.1-ofppc.iso and the netboot ofwboot /
netbsd-GENERIC / netbsd-INSTALL kernels), booted under TCG with:

  qemu-system-ppc64 -M pseries -cpu power10 -m 2G -nographic \
        -cdrom NetBSD-11.1-ofppc.iso -boot d


 - SLOF does not boot the ISO ("failed to load CHRP boot loader").
 - In ofwboot and both kernels I find no "client-architecture-support" string.
   This was only a search of the binaries, not a trace, so I may be looking at
   the wrong thing.

Could you tell me:

 1. Which NetBSD port / branch / release (or commit) and which image or binary
    issues that CAS call?
 2. The QEMU command line you used.
 3. If you still have it, the console output with
    "Couldn't negotiate a suitable PVR during CAS" before and after
    your change.

The code change itself looks right to me; I only want to be able to test it with
the same guest.

Thanks,
Amit

