Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C0CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwW0-0001Rw-IH; Fri, 12 Jun 2026 03:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXwVx-0001Rc-JB; Fri, 12 Jun 2026 03:41:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXwVw-0006oK-1i; Fri, 12 Jun 2026 03:41:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C0MsQo677346; Fri, 12 Jun 2026 07:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N5IUqo
 FG9klRJM6wCXLVMFQ6uG4V1fVy+z+7D+JF6UQ=; b=L4ShN82c7e2DQtEzSTpG4g
 nuoExoQfpDBhE9PccmIukGJbbdRuP2Xo+J1wQ5YK8PdG0ARcIAscPekaivdIcvP9
 mJ+t/vY+mAlQLkDRo5uDoTw4i8H1Ox3Dll7zZSlIpiirraMSJoBFdv4isnE72waJ
 +sVppag8gsr+CsAjYtnuyl2CqxfxGPvSoHLEKXcWiSy27I+NxIKzNyUkQlXKnJ3H
 z5Vb4LcydVR9eGPzgjYlPIfMnmH3OL9B3OOsK4P+Zp60Y7O1TFqdqrClfCKLuXJo
 jCTYKGY7d1gLZi2EYKyVUyzlvV68IHvTuruGX93hdc8hX2LNADiROcxc6aztXcOw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8aqgp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 07:41:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C7YZAD023370;
 Fri, 12 Jun 2026 07:41:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a6u2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 07:41:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C7f7vL28770892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 07:41:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5F8520040;
 Fri, 12 Jun 2026 07:41:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D10720043;
 Fri, 12 Jun 2026 07:41:05 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 07:41:04 +0000 (GMT)
Message-ID: <1493ce3f9eb33b680bcc41fcd433af3e2098d725.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] tests/functional: Add remote interrupts test for
 PowerNV
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Miles Glenn
 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Misbah Anjum N
 <misanjum@linux.ibm.com>
Date: Fri, 12 Jun 2026 13:11:04 +0530
In-Reply-To: <20260610090235.3665904-2-adityag@linux.ibm.com>
References: <20260610090235.3665904-1-adityag@linux.ibm.com>
 <20260610090235.3665904-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Ntwr-EV6C-D4d677VEXaLpGIfKVDInJq
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bb818 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=mZFYVFaK0y8dwRNDiu8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX+UaECgrNGikw
 XPkBrFverjLnucpH8Ty2OUct09Mb7wbufOhbKLweft48y/0iVlMIrMqt1iGabnl3T6bMdcSeOIW
 4Tw5OOX1Cyo0lh+tJZg7U4955GYpa1SrTlXZzSZQ+DZSxEHl8fektuYkvtlOKi3sTPoktejqFKx
 zDdxRx6BdhTuvfMyn59HQtdY0RRiru2RMwXwd07PRI5c8led0eSQY+ByyUS30Pu3XRkmswmsXrp
 zZyd6ifLwcD5B6yzQQnh5jWxInpwtLJbJ2jdm+PqGiVAFAuyZFpcrimjeqBAEpVZNAdsLx0Ttas
 BQP4gqr9LYEJngfdTmtkYWlbBZomhpIG1KenBhkTNjlVoR+tc8bP83WByoX9iwJV0kkVjtRWEGu
 TU9E2NmmuWYjN69oDzzwrKfXNMcDBOXVAtRmLhqSkLtAGm91o/xTb1x/ZHpXMN4eey6GMHpPwQJ
 YxFyRxz/DjpiNM1oV6w==
X-Proofpoint-GUID: 7HhrXR4EUym5apAjC07iPhT9zx4IgZH9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX13p+c7mQVbbI
 UsQcspaVqk6VujaFyItaQkK7JqYB3TpGL5nwQet4Naz26/BvNvciJz5nNF75NXuATY5oeF4MbY9
 uFnNSdQkjvJzr0qA034+Q8x7UZjVq/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120067
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On Wed, 2026-06-10 at 14:32 +0530, Aditya Gupta wrote:
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "CTL_IRQ=3D$(grep 'eth0$' /proc/interrupts | awk '{print
> $1}' | tr -d ':')",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "echo=
 1 > /proc/irq/$RX_IRQ/smp_affinity_list",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "echo=
 2 > /proc/irq/$TX_IRQ/smp_affinity_list",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "echo=
 3 > /proc/irq/$CTL_IRQ/smp_affinity_list",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Generate network traffic to=
 trigger remote interrupts
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Ping QEMU's user-mode netwo=
rk gateway (10.0.2.2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exec_command_and_wait_for_pat=
tern(self,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ping=
 -W2 -c5 10.0.2.2",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '#', =
self.panic_message)
Hi Aditya,=20

Thanks for this amazing test. But when I was tinkering with this test
case, Even if i changed command to "asdf" it seemed to pass. Also, in
the logs, sometime ping sometime it might fail.

pasta:review-aditya-qtests$ ./build/run python3
./tests/functional/ppc64/test_powernv.py
PowernvMachine.test_linux_remote_interrupts -v
TAP version 13
ok 1 test_powernv.PowernvMachine.test_linux_remote_interrupts
1..1
pasta:review-aditya-qtests$ cat
build/tests/functional/ppc64/test_powernv.PowernvMachine.test_linux_rem
ote_interrupts/console.log | grep -C5 "ping"
...
2026-06-12 12:59:26,316: ping -W2 -c5 10.0.2.2
2026-06-12 12:59:26,340: PING 10.0.2.2 (10.0.2.2): 56 data bytes
2026-06-12 12:59:26,343: ping: sendto: Network is unreachable
...
pasta:review-aditya-qtests$=20

Also the interrupt counters, I think we need to verify the cpu where
the intrrupt is actually triggering.

~Shivang.

