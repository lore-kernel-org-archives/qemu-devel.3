Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Smr8gSOz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQbF-0003Dd-PA; Mon, 09 Nov 2026 09:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xQQbD-0003Ci-9R; Mon, 09 Nov 2026 09:43:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xQQbB-0005lq-HP; Mon, 09 Nov 2026 09:43:55 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF0vM3700731; Mon, 9 Nov 2026 14:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7Ct0XiE4zppiq1ZbAR4EpQhjwpps2jTFXC6hTU2NW
 Xk=; b=Smr8gSOzi8kWmapE+gI0UNimAxkcnn7tQObHdFju396zd85zYL5ReMups
 sRO7FNNaPNelKGa2XqiSrpX2wGfNFDAmVyOAd3/lyAReCY9cAqt9SlHYgPWtz37C
 21EhnCpbTZdgyPqb90ACkq/fr4UG7Ued1fw8KvY10ReC9Jb8oKiOQY2nYcLVwxKv
 I9kg8BSlMzWoO2YMuhwKRhcxcvavnyqLlGxuMxYQr1C7+BxeXCDXjZqp2mKh3KPo
 iOuJ11cYDw2rnByHMmgNt8erP+mbKwAS3OMeNh/c49FD39AlAvShTQZyHC5opkFC
 RpMYxCk69DGmUJFGwLcZHNEb/VIYg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5wxxx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 14:43:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DJtws131299; Mon, 9 Nov 2026 14:43:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y025w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 14:43:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9EhlFl8258054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 14:43:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F45458058;
 Mon,  9 Nov 2026 14:43:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7226058017;
 Mon,  9 Nov 2026 14:43:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8058-b2c04f424b34.ibm.com.com (unknown
 [9.61.139.143]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 14:43:46 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL for v11.2 0/1] s390/vhost fix
Date: Mon,  9 Nov 2026 09:43:42 -0500
Message-ID: <20261109144344.847531-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Gfradbs-vUNrhnMZWNWiDCvQ3lJTFwd
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1dc25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=VOaAam9ey9TYAhJQ9r4A:9
X-Proofpoint-GUID: 1Gfradbs-vUNrhnMZWNWiDCvQ3lJTFwd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX5QhX318fmlEn
 TekTh1E7Lt6N+CPq54UXNBkyOvTX1NO+YMQgLb3MQmXLBMcjFdjVG3bYOfNDyqBGIffhdwT5wS/
 +OKyfMJK9HFOex1rNOhEx3KxVlLRr2ThA1ZuNemvVGnyG9T+pCHPpcPu95CzKCf9jc5MJe2UlSE
 VncTDluOgjHPjUEsMLUIz0YSj2vtGwApAVGk/ca3azOq0jyH5oX5CeRSduV6c2jhltWwx6EhO9T
 L56P8+y8oDI6lVLRdbm6TEetkX4p4SK55EKzNesmr7AyHcVlrH7IunPKZQyzFvhz+b2fNIQrL80
 QBc0peHKTluDYu9opuwzLxDC3BmV2pKycPrxN91pNzLWxtfdtofirFlF5X8ZTwEgVb0YSFuMIcM
 CnHQ6Gy0KxNaZlT/JD6CoqfGzYT9qeYnltDHHv2jgeXbrcA++kbA+g1pHvRFjhhRGeGznwdTpsp
 tNRSi9IWU+vGxjA24+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX5S+LfjW/e6/f
 odJB0Y+Twz/mceCfTGcbDoVuLlUAULhlWiE6sOGaTCmNEmSyFT6r2VaZSeEEj8XfY2kzid+YaiG
 DUExPJMpp/pxKY2T96VtPMXDuVabtGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:

  Merge tag 'pull-loongarch-20261105' of https://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)

are available in the Git repository at:

  https://efarman@gitlab.com/efarman/qemu.git tags/s390x-20261109

for you to fetch changes up to 94289e7960008ceedd16ba366ddca986df739936:

  vhost: only use config notifier when exists/initialized (2026-11-09 08:14:45 -0500)

----------------------------------------------------------------
Fix vhost on s390x

----------------------------------------------------------------
Eric Farman (1):
  vhost: only use config notifier when exists/initialized

 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.56.0


