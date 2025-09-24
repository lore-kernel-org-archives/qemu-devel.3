Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F270CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UK4-0003cT-Ep; Wed, 24 Sep 2025 14:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=836270231d=erick.shepherd@ni.com>)
 id 1v1UK1-0003ba-Id
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:34:34 -0400
Received: from mx0a-00300601.pphosted.com ([148.163.146.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=836270231d=erick.shepherd@ni.com>)
 id 1v1UJu-0007lA-8s
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:34:33 -0400
Received: from pps.filterd (m0484889.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGVxfa006286;
 Wed, 24 Sep 2025 18:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=PPS11142024;
 bh=jAArDJE1lficqVu0DhVMmleFIC2RiI61DN4/WUmMBXc=; b=EH++WnoEiD9R
 mlWvC4h1ft3cbv1EJcMJIP7a4o5KqrPYu3bevTG6LnE9yt54DyQgRsOIrGMd+RYg
 rwe0uNftxmokXsgilbOe+G6eMERoDjtK1VzXlTRomcdBJl5FP0wLvRbkI6Ah2Cmg
 4+5dsMtEyKVKZxCryYgqOTEoqEsJQd1NSbZaFmDb/NCXiNsqtJOrZLI8x5S0Mgi8
 YqOdWSSum6/lVaeTh4PtozwZDi65iDPSEFQBVTiKaFw93lEPWc+tivSy9hSzVaxs
 QHJzwQtmxbxFfE2TuZo+Z6Pp+hX2SqRJKGqMBKZdsApS30fuo1j4Urp98GVawMQV
 xF+sTtDfZQ==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
 by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 49cec7uwt3-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 18:34:17 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Sep 2025 13:34:09 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 24 Sep 2025 13:34:09
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <erick.shepherd@emerson.com>
Subject: Re: [PATCH] .gitmodules: Update URLs for the u-boot submodules
Date: Wed, 24 Sep 2025 13:34:09 -0500
Message-ID: <20250924183409.288909-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aNOV-h9y_gNHToYv@redhat.com>
References: <aNOV-h9y_gNHToYv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ya8GrEsLoNhJRhQFBUkS7jUFgLQark2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDA4NCBTYWx0ZWRfXw0eBIkRDWYjY
 d4tOHCVXv9vCSaegqeVXBGIsZvXdSDDqCO5amlrLN3uiwqUS44T3+5UOME/LDwtAjMtckqee7z5
 Bmn6YClE0D/WWzTBWhK3DXxW+joZiijTxz+GsqQQX8fG3L/qbCCZR5m7ushWaufxLlSh6cuOohy
 kve6di+IxijwtaT0IXRAIQlMhokq9LWr2Ba2sFuufXFUYt0tszriNrTH78dKm6Gb3kyrXBrqXX1
 HtvZB691R4gZAXKtkPDP/VmkeRRxB067hh3EPaC+knqck/GV/i6kLTEsFb3RAV9yVxwPskCIaVl
 2J7kI3NBeKGnoWrKZO1Nzb7XhqhOn3vkGszhBPR0i3aR8y76QcczkdAkRqX3XBeAbiIHMIJWO+8
 PxzoE0fX
X-Authority-Analysis: v=2.4 cv=cY7SrmDM c=1 sm=1 tr=0 ts=68d439a9 cx=c_pps
 a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17
 a=yJojWOMRYYMA:10 a=ot0xh6MuC4eyea9F_OoA:9
X-Proofpoint-GUID: Ya8GrEsLoNhJRhQFBUkS7jUFgLQark2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509240084
Received-SPF: pass client-ip=148.163.146.64;
 envelope-from=prvs=836270231d=erick.shepherd@ni.com;
 helo=mx0a-00300601.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

What is the current stableXXX branch and are there plans to cherrypick=0D
the fix to it? I see that the Xilinx/meta-xilinx master branch uses the=0D
xlnx_rel_v2024.2 branch for Xilinx/qemu.git. I just need to identify=0D
which Xilinx/meta-xilinx branch will pull in the recent fix.=0D
=0D
Regards,=0D
Erick Shepherd=

