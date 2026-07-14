Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB3AC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjeQi-0003PV-1U; Tue, 14 Jul 2026 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjeQg-0003P5-F4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:48:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjeQe-0007vo-W2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:48:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEfpsj1523939; Tue, 14 Jul 2026 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QSfWZW
 N4NxG76Jj6T2pZUIASi7NXReN1oRYrrIrme2k=; b=jZrS3WUN8eb4EqoMWHpNlg
 D58gnzjtOAvpw4ccW99mhQyvGXkIwgBYI+bq+14TaRBr3Em4MyZEpzZS+He1dwEQ
 U5xL+z7n1e/T7Naw+FDd5YiOKa1746NTY2VkelVht9HV+M23l9OFAVYmnmK3ZOu7
 C7jp0VH5F68bxguuXIpSvSUZlhiqQwinwq3xipT78XWgesQ1bhcdWZrP+4wzdLcu
 FINYPvZ4WMQI7uFY5AbdVa0DJKxRhBl+8MqNSHgslpFZfarTxvi5uA4HTO3aWR5F
 QAz1EVlncGUuZQpSkfTkexJkc/4L027ykK7y3ZHSgRUTHCpL29c6albuck3hOjrQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwp6vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 14:48:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EEYd9e011763;
 Tue, 14 Jul 2026 14:48:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw3dhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 14:48:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EEm2uT57934212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 14:48:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C63EB2004B;
 Tue, 14 Jul 2026 14:48:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C9DF20040;
 Tue, 14 Jul 2026 14:47:58 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.31.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 14:47:58 +0000 (GMT)
Message-ID: <bc94506bd307f3273b199a432a4f6df8c219b212.camel@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Harsh Prateek Bora	 <harshpb@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Daniel P. Berrange"	 <berrange@redhat.com>
Date: Tue, 14 Jul 2026 20:17:57 +0530
In-Reply-To: <0dbbac06-8fdf-45ef-9cd4-eaf2510394d2@linux.ibm.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <87pl0rdnar.fsf@suse.de>
 <0dbbac06-8fdf-45ef-9cd4-eaf2510394d2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qMzBDuvt40j2-Nqb-AxJgBMv_jGe6TIE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfXz41s8DfHx3Ty
 gio2InVgUHl+35mhjrp1w7Rn6YfFUa0ADSN0CgF2uO0TjmCMExjwDkCtEOAtTDyXV+wiUF7BUC2
 PO2ofhJalDrbmo/XJQrz3wxB/MNgeqfit3k3CymNb1S5giMqnv0O3xuYwsHXuU8eQ7RVV6nqvRx
 grxQlzSB0XesF0aii9BLy1xilBSQOS9Winjva3wZ92OaN6kEIVCpE/Oiy/57xurPwaFOxecGlNs
 E3TEQX1OUupq0RiQvset9xP4oqQmDm1Eec5XoabYF7ttpO2uOffh9v3SzuWj5HO8iqvMLQIL+KC
 qKDuA5ZPDzBhxOidTz8lSU/+fgkxlpMQo0nnZXPSusWFcN3Pj+N0zJS4Xr4JoFgmG2EqdwatG3R
 I9PBo2b9o5R5Bw5ryLmMs0DQDOVhZemlLxbPu8HJArQubiP37Z3cvddMkZ+Gmy2G/3TkLVLibxQ
 u/Zxlg37LnZVjUOI3JQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a564c28 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=yVy59pUPNZymXm2ZWfgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -Gpr_-usH2vnXnpG_Ur-xxsMtBj_wpJV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfX9VQx+jRZsI74
 LFtKIOFkefsIEpTtBur1HFlCxgv+N5Ik0RYsEiO51qXlHSde7o7nCPPcHAMyBhOUrwdkYuIN/AP
 jQ3lfY79mQ7+Vkhrpiy92xuZbF9135c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140153
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Tue, 2026-07-14 at 15:54 +0530, Aditya Gupta wrote:
> > guest code.
> >=20
> > PPC folks, please confirm, it's been years since I looked at this.
> True. The way the spec mentions it seems the OS can get control back
> after
> execution of ibm,os-term.
>=20
> This difference is noticeable with `panic=3D15`. On an LPAR, this would
> print the
> following line and do a reboot after a timeout of 15s (this happens
> in linux
> after it has done the os-term call):
>=20
> =C2=A0=C2=A0 =C2=A0 [=C2=A0 338.186072] Rebooting in 15 seconds..
>=20
> But on QEMU, this isn't printed, and the machine powers down:
>=20
> =C2=A0=C2=A0 =C2=A0 qemu-system-ppc64: OS terminated:
>=20
> Maybe worth taking a look. Didn't notice this earlier, thanks Fabiano
> !
>=20

Hi Aditya Fabiano,
 As we register the rtas(os-term) as the panic handler for spapr in
linux, I think we expect the machine to be shut-down properly and not
handle any of the work. I am not sure how else would we implement this
function in qemu without using `qemu_system_guest_panicked`. I mean,
the name conveys, the guest has "paniced".

But then again as per PAPR, we should expected limited number of rtas
calls from the OS (the following list).
- nvram-fetch
- nvram-store
- display-character
- power-off
- ibm,power-off-ups
- system-reboot
- check-exception

PAPR reffers to host as "live-halt" after it has called os-term. Not
very sure on the meaning of this.

Maybe other platforms then linux will rely on this? As Fabiano
suggested he found some case where he needed to comment it out, That
would be interesting scenario to explore.

Regards
~Shivang.


