Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E7DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaF2o-00076Y-GN; Fri, 11 Jul 2025 10:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uaEnJ-0001PU-V8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uaEnG-0002co-Ke
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:32:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBDROe026463;
 Fri, 11 Jul 2025 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0B8VN9
 +A3BbaD3Moiu4eFI57LqO4J5mKzn01bJDi8iQ=; b=brMsSxPncK0ySLcZ0w6Sj9
 Rr8oSzOoLvJO/MdM/Ad+kWyIRUp+CbJ8EEKro9b3ALAXNHrAHFO/MBNbJyNz17oj
 MVrsLfnZCRyhZxpmvCYqsG8IaoYBViJQlYtcjMwYCURMWjHSrp9+lLNZASfNE91K
 gSEgrI8Ap36NbuWgaBhI7GX8i0KDgd3j0bQWKHIoUVdTQ4SkHXPoH8gdGq3vVIUQ
 y48KCuq5ZbH4uIa00zzLB8TZjSJYcOZd36vS8l1O07zWiivD49+Enjfump4dTsaf
 0ruxEMNyVokyBqjGOOB5miXOZRXcb9Z5QVZtzPj6KGr2jpVPqTNSdvK1nzyY1YPw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4kcx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 14:32:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBVPTg025668;
 Fri, 11 Jul 2025 14:32:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpk4ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 14:31:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BEVwmA29229814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 14:31:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FED420043;
 Fri, 11 Jul 2025 14:31:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D15DA20040;
 Fri, 11 Jul 2025 14:31:57 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 14:31:57 +0000 (GMT)
Message-ID: <1f1dfa78e9c53769b95ff3a8b58efef7dbafdc8f.camel@linux.ibm.com>
Subject: Re: [PATCH] tcg: Use uintptr_t in tcg_malloc implementation
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 16:31:57 +0200
In-Reply-To: <20250710225053.168169-1-richard.henderson@linaro.org>
References: <20250710225053.168169-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwMSBTYWx0ZWRfX184/9ryNIvlC
 HVs0ohNcRbgurqPqTlGd9cYyylGGBI0BeZLIRfWxm+OP2OhnhRvQ8GGnMGtIrmxBGchTra8Hdsi
 myJAnLxEUdc1C2yrKQ/QQaIVgQMOrVsg0eoHBAeN0JQzeOEA5BzFqzyNhIwGV4kIrtYvNHTG7Kl
 j/DsmdMVQFdtwFkOVYyk0gQh8SEw2s4G/+tj2YXODNukF3aocmYaPl1tjDmZHmW6BqoEwsBJ+4H
 elepNTcn5cmtYoqoIiOKXMJ8wc3d9YLv1fMvpwhT98PzSvBq4pVI2QHuI2VWzMMOcJxzXjWh9l6
 gHww7w/JwoDFQQTXFbdEGyJbcKJ4MSjWy/bHFPCf8F+L+X7+IH43xrcQ9K2eo/ds17Xvg8Vi3kp
 Kim1VJyPoFlfUB16XpFImvlnXnwL9gdBvKWBZEr8RNIt4jxAZXFjK9bj+aFqTPjhVOP2s/f7
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=68712061 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=2p5-5N_fjv6BlIB3O1QA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Nz1u2GbijnWWZ7NPF58WpU21wme6cwjU
X-Proofpoint-GUID: Nz1u2GbijnWWZ7NPF58WpU21wme6cwjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=688 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2025-07-10 at 16:50 -0600, Richard Henderson wrote:
> Avoid ubsan failure with clang-20,
> =C2=A0 tcg.h:715:19: runtime error: applying non-zero offset 64 to null
> pointer
> by not using pointers.
>=20
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> Supercedes: 20250618183759.9197-1-iii@linux.ibm.com
> ("[PATCH v2] tcg: Remove NULL arithmetic in tcg_malloc()")
>=20
> Ilya, I think I prefer this solution to &dummy_pool.
> What do you think?
>=20
>=20
> r~
>=20
> ---
> =C2=A0include/tcg/tcg.h | 6 +++---
> =C2=A0tcg/tcg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++=
----
> =C2=A02 files changed, 8 insertions(+), 7 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

