Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F390C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXn1M-00088d-9v; Tue, 14 Jan 2025 14:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tXn1B-000882-H9; Tue, 14 Jan 2025 14:56:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tXn16-0003Rp-Fl; Tue, 14 Jan 2025 14:56:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFUDng005533;
 Tue, 14 Jan 2025 19:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3U3KrK
 LNp45J5k0Nwxy2NrOy/35ZNkaPq35D/9lcwYk=; b=klWq8wIM/zwKU5kKUJMxng
 8IIepzSMo4UN6LUbJ9MonxRXNfBacX07QU08gWiObthveC8koIFIyPUTIdWjlYHw
 cMXMPs12GyXuGuXzjIvtHvtWjp0XotPgJgeiiEHm++QVhkEl4WN78cWN+8y7Y2+G
 DkdXRuUM3YCMSeOGzLNN3R6DvdnFb96kEqW6zgRKaAKWUSNYCpga0l7ZXzLLpIKR
 TiYTwIOfXoe+ohpPTa1txzr9gd8g8unYqm+Nv891JBgW4+WpjYG1Oqb4YaT16e/3
 DEKS3z+/6mO8+2/gfwNHO8MJbDkEtqakDoJI353llQhWH0AJUusTCyRkLoVDR2HA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmgh68e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 19:55:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EItBnV016582;
 Tue, 14 Jan 2025 19:55:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1mgpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 19:55:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50EJtsNZ31916730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 19:55:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2854458056;
 Tue, 14 Jan 2025 19:55:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD7AF58054;
 Tue, 14 Jan 2025 19:55:52 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.67.108.235]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2025 19:55:52 +0000 (GMT)
Message-ID: <52b7868e00271d49baddd64432332859c8314d1d.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
From: Eric Farman <farman@linux.ibm.com>
To: Rorie Reyes <rreyes@linux.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
Date: Tue, 14 Jan 2025 14:55:52 -0500
In-Reply-To: <dd1b07c4-1b72-4051-acbb-d679d0a0f534@linux.ibm.com>
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-2-rreyes@linux.ibm.com>
 <f0213486-c0f5-4415-869a-99a851c8a4cb@redhat.com>
 <dd1b07c4-1b72-4051-acbb-d679d0a0f534@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mfQ27HnK5SHVzXrevjA4n2UZ-oos2sXL
X-Proofpoint-ORIG-GUID: mfQ27HnK5SHVzXrevjA4n2UZ-oos2sXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2025-01-14 at 13:51 -0500, Rorie Reyes wrote:
> On 1/8/25 2:29 AM, C=C3=A9dric Le Goater wrote:
> > Hello Rorie,
> >=20
> > On 1/7/25 19:43, Rorie Reyes wrote:
> > > This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to=20
> > > specify
> > > an IRQ index for signaling that a change has been made to the guest's=
 AP
> > > configuration. This is a placeholder for QEMU patches that use this=
=20
> > > value
> > > since it is a linux-headers update which includes changes that aren't
> > > merged into the kernel.
> >=20
> > Is there an upstream proposal for this change that we could look at ?
> > It is nice to mention related series in the cover letter.
> >=20
> > Thanks,
> >=20
> > C.
> >=20
> >=20
> Hey Cedric,
>=20
> There is no upstream proposal for this. It is an s390 internal line item.

Rorie,

I think Cedric was looking for the matching kernel code you proposed, which=
 this QEMU series depends
on:

https://lore.kernel.org/r/20250107183645.90082-1-rreyes@linux.ibm.com/

Thanks,
Eric

