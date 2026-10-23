Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB53606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W6f+FPlO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGwq-0000es-9v; Fri, 23 Oct 2026 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwl-0000dg-Na; Fri, 23 Oct 2026 11:12:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwk-0003dl-2s; Fri, 23 Oct 2026 11:12:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEE8ZE3288600; Fri, 23 Oct 2026 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=w0FzpdOHg89JH8MIdWtg/K/ur238sLx3VHsU6VBrg
 8E=; b=W6f+FPlOyzRzVRAlAe2d13QnIqcs9lOOXO9uY9Ri0+vNKGoL8mAh6bTf8
 mxt2F//hOqylUn7tPM8YCFZhhYD7Dn/+9kbs/ADYFFbxM4dGth4GpQfOJVAxzPGC
 6DmyV2+F9Z0Qdbih6ssa8qg1LeGuxv1C9DZZoYZKYq4UMAkVerCeuExZs/2sGw+j
 Jfgf6P+69WqTu8GtXA6V3ez5Xaaphf8rjzYB0mAc7bTAPcKdgQilHouhH87DJJNB
 Beo/L8LF3wlVpiNrQY+bYcj8EKNv7wy5kmyGkkNcGAR8iMsqcVr1LBx94KtHZmOW
 ODyMdKaGIk0i+jXqwhME/y3WEZCOw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw596048-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE64071018563; Fri, 23 Oct 2026 15:12:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hg5exs5h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFCVRV47776150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:12:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CE8E20043;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70FE020040;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 54AC9160FDA; Fri, 23 Oct 2026 17:12:31 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/2] s390x MAINTAINERS updates
Date: Fri, 23 Oct 2026 17:12:27 +0200
Message-ID: <20261023151229.1196404-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z7TiiSLf-qjO7Pem9R21cylgxLir61mf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX1zjgFYlgA1f9
 JjrKo+FiemDNUJV6FAzv/s63dKi4cqaTKqNoWybfqXh+S5erjmU0jyYToaednvXgIe5mII91u19
 Ys2vojq6Eus3iVebq90BlnEaQ8bUft0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX9uQDR+U7De4n
 GL4N5Np0mWwA2FpbyFbdft1W1zPWjNXqa/nyFEu2Grm3hu8759NEukdRQLVoddoZx/abXNdrlds
 9WdPNxPz63+Us/0C6J1Edo8NM1vFmt9h7V0GFcAgCsAvrmxaoeNPmjPS4d8jGzsw67ve1+Knxac
 c9FvNYuU4MjqEJwslfASWKKZQS4hSgpCAst7/66t51ce3lQL+Z+PqWlrPgnxgwB2FRvjXiHQu4k
 q9giQhoE/J/tZ6zV5lNsI/LYKWjD4XqcHJit2s3Kesjoy0RdkYZnXd5owvqgqOUN5kw1om3OgdE
 Lh51/0ubXuK2Hfzg1sk+VUQRykmqM98f18oudK+cp/RUW8VmBma3vBH0U2AAr276B6CoTE/a2L3
 uk3mvwNLMQDXhagQ1HhxOsvEmXysKyKY76slU78owEBPobT1DjpvcX0mbFtE/9hXfKUNvcH4y2D
 Pq7EXorWAexy5tK2ddw==
X-Proofpoint-ORIG-GUID: Z7TiiSLf-qjO7Pem9R21cylgxLir61mf
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb7964 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1Ix5eLCBSyxhi_lRrlcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230057
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two quick updates to MAINTAINERS

Eric Farman (2):
  MAINTAINERS: Add other s390x tree
  MAINTAINERS: Update s390 boot reviewer

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
2.53.0


