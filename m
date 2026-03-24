Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBFE9A75E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ytb-0000kY-4J; Tue, 24 Mar 2026 06:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4ytX-0000jg-UQ; Tue, 24 Mar 2026 06:21:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w4ytW-0004wG-E2; Tue, 24 Mar 2026 06:21:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O5Olql506491; Tue, 24 Mar 2026 10:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=77vNsp
 GKb4jyYYCUBeGZhGYidOS5Jp0iRojdGwns6JE=; b=gUrJOMt4GipFLFmfyQmN04
 r4FxijAygPAVzt90cV5A2ZJNSFMtVson5EwI3mMRS9lIfoiDFwlG3Tbl/ZNjIdAU
 Z7W7VBrE61kG83D2Au1a3dPgrAjR/kQI7AbIxgvoHHvwuate/V2uiCbF2levT8fV
 uiLEmjPpPV/55O7ap1pBiC9FNCQvFXGdNaxxVpL3t1M674MYaw6X2JqaUkX2Y2+r
 PCJhhhV3DWZTfkHRaIx4Wpar08sY4fU1d5OOa83bd2arnmFmvLQTcScl0o4+t5Ea
 oVSmbsij+WS9hozsboOCO7e8HaVDgnnENTjsUNHUnDlyvP5Tt9O9C6330qB8UDjg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqaw0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 10:21:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O9HHuD004407;
 Tue, 24 Mar 2026 10:21:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c213v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 10:21:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OALaFQ50725244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 10:21:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C590520043;
 Tue, 24 Mar 2026 10:21:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1C6020040;
 Tue, 24 Mar 2026 10:21:32 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.27.96])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 10:21:32 +0000 (GMT)
Message-ID: <fc2985a0adfeb0de4bb2980798950f1ca2b0a4f7.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com, Aditya
 Gupta	 <adityag@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Tue, 24 Mar 2026 15:51:31 +0530
In-Reply-To: <CAFEAcA-zJor6L=WFxjfPVhY-bCGHvJTht0yX37Gks_Ozk+PdZQ@mail.gmail.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <20260323231612.GA2637687@ax162>
 <8cde9a355050b306180f80e8d1340ec814c0876c.camel@linux.ibm.com>
 <CAFEAcA-zJor6L=WFxjfPVhY-bCGHvJTht0yX37Gks_Ozk+PdZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HsprzhrMtH4oejrr10XIFWKftOVEpckN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MiBTYWx0ZWRfX+bo4/jkEOvfa
 aKrgyXA7dA+2aFwED6X4pFkoF0NrQ6Mkg4LPot+IKiR2dEr5v0PB/H2PJpIpfMbeSZfX0XjWC0+
 GAI3FciPHX6H+4gH22W98qkQcX6f8/4gItcw/N70XAOYr/IuevncLXG/5APZKIGWMFoxNedWnTS
 +2ma3ZO5vlw1EN+745dB772PQFMGFBKdzpvPOvCvTS/tueaKKrOLojBNPMouUDS96vicLyiMs8X
 vz49BkzpKfcqInBDVcvP8i0vxrIkwrTsvGlBddaKrLvZteI0deKRvv6fzI67FgBvCGgju2qgtdo
 P+nztwkDTEHH3vYR0vq7kLcs39Bqkt83yuV0JUJMbmNP61cqJg1pdJjxk7ehZOCSkBrztV1xiUb
 NDL8ZF3bIVcNP65qZ/K6icnE0ALGtSYspxSX9f/I16L8PaaaAdXr1PUSo/zW6b3pHXCXkcck91v
 EbUJaH6fCx2invSgnZQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c265b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xmvE-_sHl21UGuzNvFwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zaJwa3M8fbP3j1RW6wiWs17QgpAwtFVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240082
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2026-03-24 at 10:14 +0000, Peter Maydell wrote:
>=20
> You might also consider using qemu_add_machine_init_done_notifier()
> to register a callback that happens after machine-init is complete
> (i.e. all command-line created devices have been completed): if
> I understand correctly that would be a valid place to create the DTB
> (the machine-init-done hook is called after everything is created,
> but before we process the dumpdtb option).

Ah, That would be a good direction. Thanks Ill check on this, and
report.

~Shivang.

