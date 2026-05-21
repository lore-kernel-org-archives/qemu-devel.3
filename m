Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C03DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 00:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPrZT-0007XV-ND; Wed, 20 May 2026 20:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wPrZS-0007XI-8H
 for qemu-devel@nongnu.org; Wed, 20 May 2026 20:47:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wPrZQ-0008Dk-Mo
 for qemu-devel@nongnu.org; Wed, 20 May 2026 20:47:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KEveFf072884; Thu, 21 May 2026 00:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qGp574
 yDrVh8ugnIb00eWtRX55wmGLCv1uCMj7zOA0c=; b=RB8R+SgKHDkzyMjeJCILvo
 7l1dv9B+UEjEpSYqAEvxgdSUNfiJaA8rsGdW55Td39lwyq0dD1Ffs0Mq4NPAgD+G
 3WvB3PvWN05tK1rKzM7Unc6uNp0dIOTY8svCUE8Tb9mXMcpBZ8qC9jFL3KJcSQ2w
 85utHp+ip3btdeXg2N5NeLi/CYEebvnTpTc6L71KZxELPTlLsJk06MHllkMQPZyz
 Sc+bAwxedn0/PwrGLwombrdOnLLkjdcpWC2AcU/5W5OeWSAyjgMvxlJe7id/d6xc
 HzsqEIkLOnK/Ph0SQwzJjHciHp5r/2HgLa6XHOs63j2UYGB4J5cgAG5otXAIuGnw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mvhnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 00:47:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L098Uk001859;
 Thu, 21 May 2026 00:47:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754ghkns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 00:47:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64L0lOsX33424008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 00:47:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19B075805F;
 Thu, 21 May 2026 00:47:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EF1558043;
 Thu, 21 May 2026 00:47:23 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.141.43]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 00:47:23 +0000 (GMT)
Message-ID: <61fdc7c291a43969020b3c84e287e7094aa10ec1.camel@linux.ibm.com>
Subject: Re: [PATCH 06/40] s390x: prevent crash if given invalid CPU#
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Date: Wed, 20 May 2026 20:47:22 -0400
In-Reply-To: <20260521-qemu-no-hmp-v1-6-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-6-d104f809e145@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vG6oyrInus05fIeJSHtNpW6N0kdzCKHt
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0e561d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=RCG6V7LVYpKTZnwaq0gA:9 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10
X-Proofpoint-ORIG-GUID: vG6oyrInus05fIeJSHtNpW6N0kdzCKHt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwMyBTYWx0ZWRfXyUmCudsAgu6n
 2itdMelguJVA6Byt/TXDHUaaAARFQWbtNlNe6cVnGco/7BlWDRjb5Je2MXQ2Mw1N2Zduz2StXDh
 4k/S9WavbUtfAIGo773xi453YiEAzaTmp9ZzXbvHG3nyNomg4S+Ef3crT0bsC0daUEgaA4gdz/8
 Cf89llH1wULjo/l+UDAGvvTtD3qhjx80uFMfK1G9x7mcAmPW0Bj99fogkNORB2xiqE4Pdvv3J4f
 DyZK60fp82sHfiAJ+wRR0VCwFfIoDyA0IrHVg/PYSX74pdyUdk4rZvbX5ZuJNGnFRIp8doK5vMB
 DKlhY299JCMp58xlkXaxe0lxG8q2YI+WcM5z59uKDQheLEfBYa29e+dgVxnYWAl4AUNcEGTIiEe
 jms8UAoNMQQBD4w0LjTaQs68pqDV1hDqhRHRZDyd2QewYctxephoJ+O7nNRV6jJoRPxv0yHilPx
 Pv2tTgxzcNcibqMTT3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210003
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

On Thu, 2026-05-21 at 01:49 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)

Straightforward defensive check.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

