Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8889CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOyL-0000YW-NE; Fri, 08 May 2026 13:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOyK-0000Y2-64; Fri, 08 May 2026 13:26:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOyI-0004Xt-LB; Fri, 08 May 2026 13:26:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648CSEcj2280958; Fri, 8 May 2026 17:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=knF9dQ
 5RW2liL3wE8nObZVvB1NUusR0V9EUY5QJH0Y0=; b=ee8Sz+aiJUB+19q06s9xEp
 QK+R7lYs2lsmk6QjjeKJ1OTRRvn1WGdCxps3krw+5E2MsG3NdZ/ZJL4MEC7gOqD4
 Gidnhj7rfLSUMjJhyftcTgQhbypMdw32aTcL3PCsYBxKgw8LlHFc3dfugAJOlhN2
 TbMmJ18DJLv7F1kPQ7RcD9ybd7o/PzXPom+Cv9ObC+qh7KGdLFbZP/WAbaJdNMwy
 yfVQ0Mz9hxmWx9W+9V6yyPU2XPUB8B2BL3d6xlINbh4/I4ubQl9o7EucceT1Pf43
 0la5BvqmUIdmZYsqNhcF+G2GHSmAGU5+boFNAuGgPOzYLJQYjZbSNslRv3Y6B/PA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x54vse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:26:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648H9SlW022543;
 Fri, 8 May 2026 17:26:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e100748s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:26:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648HQcou19595904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 17:26:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 406165805A;
 Fri,  8 May 2026 17:26:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6454F58054;
 Fri,  8 May 2026 17:26:37 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 17:26:37 +0000 (GMT)
Message-ID: <5ed5e41362e107f314de841eb06308b87db169d2.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] pc-bios/s390-ccw: Rename Virtio CCW run function
 for generic use
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
Date: Fri, 08 May 2026 13:26:36 -0400
In-Reply-To: <20260504221613.826825-4-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX0gTZm2RfSDe9
 3PsuS3Hs6DRQc3fve1HMEvhgP15zoArjLoKBx+cAo7PQIO/3PMPPKbrbOgT2SJoict3rIUN7fxd
 kTn0x59aZdP+RrrTCW+4BjEvr0grmSlqbTwQReQdjLT/tdZqiGz1yiUfFyfa36w8cxqylNsIegO
 uCc9mXnZaYQPhywFSQceNDbCPIqKbM+lKJHg3KaF4ftYRq+lZuZeM5leDAejxwhJjosmMRSLHeB
 J6Pit75fE37QTNLiNSViPk5PbIZWUTYVW7BU5OZI5pUWqp0r0hojnUGGWaeXchQrPxNQH5ieUSj
 i2Wvj4QDEQd1YcirhXajrWlwMOdHrSI0DOhW3MCqVQf9C1TPL2YhwLxWjBUM7Ij8hLd6RhlGx6l
 R09//MD5/ImUvkBeSP7VbEa/LlotQ9WIhdQ8aK275rb1vqZxZgmclMAmEDPCA1kwtwzVMPAGGrQ
 tIKe+w9hgOOtpnf6m/Q==
X-Proofpoint-ORIG-GUID: KiPEGF6TSgaDNijc8oXsC3liem17Cf-M
X-Proofpoint-GUID: KiPEGF6TSgaDNijc8oXsC3liem17Cf-M
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fe1cd0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6QhBD31FDyHq5gHwSToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080171
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2026-05-04 at 18:16 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> The same function can be used for issuing both CCW and PCI virtio command=
s, so
> remove CCW from the existing name.  Additionally, move the function out o=
f the
> CCW specific file and make it static.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-ccw.c | 17 -----------------
>  pc-bios/s390-ccw/virtio-ccw.h |  1 -
>  pc-bios/s390-ccw/virtio.c     | 19 ++++++++++++++++++-
>  3 files changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

