Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D54CC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglAL-0000M8-NK; Wed, 21 Aug 2024 09:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgb4Y-0001OL-8J
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:27:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgb4S-0006Yo-7j
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:27:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240821022727epoutp012c82c5ed93187316cf6beb4dadf7983b~tnVs9_Bge1953819538epoutp01a
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:27:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240821022727epoutp012c82c5ed93187316cf6beb4dadf7983b~tnVs9_Bge1953819538epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724207247;
 bh=6tiRZHwnZKExrFVNMQJZvItEGtEj3DhO89ay/P6KYDU=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=KovFZ70vl7mT1EcuPtcYeiTa+oQgYn+6VjSFsOQvZyqAg1Yl8Ob05q1l6ZVugcQJo
 rTNaxzYFpB66CixAKCb2Pb/eVSSL+QnNl6/qiAP3j+ZWCzSi1CyxwZaabrFQrqCQYy
 v4ZoOnUhnhCDsYsMjfgUS8oB/jn1QG0Jf0OxIC2g=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240821022727epcas1p2b4f8230d9273311378c03f2cca39aea3~tnVseL-TC2587125871epcas1p2R;
 Wed, 21 Aug 2024 02:27:27 +0000 (GMT)
X-AuditID: b6c32a38-995ff70000002812-f0-66c5508e088c
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.87.10258.E8055C66; Wed, 21 Aug 2024 11:27:26 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/4] hw/ufs: ufs device testing function added and modified
From: =?UTF-8?B?7KCV7Jyg7LCs?= <yc01.jeong@samsung.com>
To: =?UTF-8?B?6rmA7KCc7Jqx?= <jeuk20.kim@samsung.com>
CC: "thuth@redhat.com" <thuth@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jeongyuchan0629@gmail.com"
 <jeongyuchan0629@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p1>
Date: Wed, 21 Aug 2024 11:27:26 +0900
X-CMS-MailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCmrm5fwNE0gztTTCx6Xu1js7i/9Rqj
 xacGKYv92/6xWhzv3cFisfKYjQObx85Zd9k9nlzbzOTxft9VNo++LasYA1iiuGxSUnMyy1KL
 9O0SuDI6pi9iK7jEXvFr3UemBsY5bF2MnBwSAiYSP54sYeli5OIQEtjBKPFkxiymLkYODl4B
 QYm/O4RBaoQFvCWOX21gArGFBBQkfiy/yQYRt5T4/GQamM0mYC7xftJ1RhBbRMBU4s/3dSwg
 NrPAR0aJaX8FIHbxSsxof8oCYUtLbF++lRHCFpW4ufotO4z9/th8qLiIROu9s8wQtqDEg5+7
 GUFOkxCQlFj/WhMiXC9x49pjqFdqJB613YIaoy9xrWMj2CpeAV+JhcuPgtksAqoSzSfWQNW7
 SBzvXMMMcaa8xPa3c5hBxjMLaEqs36UPEeaTePe1hxXm+h3znjBB2CoSiy6+hxojJfH1xDpm
 iMs8JPbfc4YEVKBE+9e97BMY5WYhgnMWkl2zEHYtYGRexSiWWlCcm55abFhgolecmFtcmpeu
 l5yfu4kRnBS0LHYwzn37Qe8QIxMH4yFGCQ5mJRHe7pcH04R4UxIrq1KL8uOLSnNSiw8xSnOw
 KInznrlSliokkJ5YkpqdmlqQWgSTZeLglGpgCvZKP17YcTenN8On0/z5V+bpaa1i86qDDtzm
 OxNw4dvKE5y7dKZXvLz/pTrBXq98oYfP0d76z394j3DtbPZwF5e48KkzWfzP79l/U7hTnwbJ
 s9tzbRO1392w9GuDhM69+tuKrrZePROPpl+6lKLIqX5iO+c6QT7pk/PMXaOlnfW+p545t8b5
 Bkdwa9G/BHnTW55KyqdtN6zbJPSVO3rb3jvm5/qEXgiWP1tzxT95yf23WSozO27efMV/QGli
 44v7UrfVD4e+4u2WPDtndnn/39pLPg0VU+48jorOl35mvdtS88tLGcXTEgaLO4yL3pS/0fgR
 oPX6taLge7nIgCfvls5Skw0K3mw4sabIZrGeEktxRqKhFnNRcSIA5dZt/HkDAAA=
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p1>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=yc01.jeong@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Aug 2024 09:14:16 -0400
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
Reply-To: yc01.jeong@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From 936ef0a907bcf16809f9980c2d37e8fcb13697d2 Mon Sep 17 00:00:00 2001
From: Yoochan Jeong <yc01.jeong@samsung.com>
Date: Wed, 21 Aug 2024 10:45:28 +0900
Subject: [PATCH 0/4] hw/ufs: ufs device testing function added and modified

Previously, it was only able to test virtual UFS devices if they properly
read and write storage data. In this patch, three test functions are added
to test if virtual UFS devices properly read and write its metadata.
Each functions test reading and writing flags, attributes and descriptors.
Related minor bugs and errors are also fixed.

Yoochan Jeong (4):
  hw/ufs: minor bug fixes related to ufs-test
  hw/ufs: ufs flag read/write test implemented
  hw/ufs: ufs attribute read/write test implemented
  hw/ufs: ufs descriptor read test implemented

 hw/ufs/ufs.c           |  26 ++-
 tests/qtest/ufs-test.c | 414 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 432 insertions(+), 8 deletions(-)

-- 
2.34.1


