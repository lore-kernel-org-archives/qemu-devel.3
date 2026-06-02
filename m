Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7CFCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUQHU-00044B-RW; Tue, 02 Jun 2026 10:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4613c7fe8e=mnissler@meta.com>)
 id 1wUPKP-0001E6-6L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:38:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4613c7fe8e=mnissler@meta.com>)
 id 1wUPKN-0000LH-4h
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:38:44 -0400
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651K2Vcn1621208; Tue, 2 Jun 2026 06:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=gYagSwz16GrA6Sm165
 brLVtxDNJo/MGlmgsaUncimgk=; b=h4rShyrIhDu+FuwyOUoxbuN6xdV19eujfc
 iu1PdbIzRfGVRJPrY7+WbUQWrY8bKsoBmzAqs1YVp1fXqn2/zTopH6vFB7Y7tO7h
 CFTCifEsFjAriAq0BawuJnv881EqxCmg5+ZfKIC5oPHS/wohDGFW0x+bwRURc0Is
 aOBXqNNOnSPfjA5z0TuWqq1AHK0rR6A7ii5Th1bsSJoiGcQBRBlcJ7h8PTbomISp
 FS7Iwrwx8yQ+YmQE5EDD0cZf7OnOWzbfZJ5EJK90BpkailzgT/sR/UGmhY3IMvHn
 /T1MKp98FgYKgavUuLb+G8UMN1/Wlh1DZKJ8yQHWdmE+Qo6+P9kQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eghn5dbqc-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 02 Jun 2026 06:38:37 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 2 Jun
 2026 13:38:36 +0000
From: Mattias Nissler <mnissler@meta.com>
To: <qemu-devel@nongnu.org>
CC: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
 John Levon <john.levon@nutanix.com>, <mnissler@meta.com>
Subject: [PATCH] docs: Update vfio-user spec to describe DMA access mode bits
Date: Tue, 2 Jun 2026 06:38:29 -0700
Message-ID: <20260602133829.305842-1-mnissler@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1c::11]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzMCBTYWx0ZWRfX+xVrrE3ERCQT
 UAzcdK7UOgxmO9ixgGpETEyNfmExQg6lWyDR1wSaTGqOA/6jqVCf4m7nbMUje2rSa2l1nRvss6k
 A1lKOVOgbfMdMvN7bPcYPIilCXrNGEpp0IiHnbDbvTYo1dnMSrH5eWyx01A6nek8likLjE9geIQ
 BolmRvUJbIF4gYcM0BPnL60S6MYManrAshoAzT7QeTUyzqiy6gXCg7l8XdFywcI4hm7ZymIGgJJ
 y2S1gAsajb7Wx6ThLvfAj5Rs1iTUSX7FwjGejTiLiXCsTM4iSRynyXf7QgP2F+C9G2j10ica10U
 LV+vP+Kwx+ubaDmS0ZtHOPwHI4E6DuZplT95OtA6MWba0nManDwDvU596OEMnU/hthg8Pg2rgae
 HkodUKMgLvejUicuMUWIgff1imdtaiTIHlfAASEZgMQIoJA6/7DIFcvIHECmanl7dsM7Sadk9HO
 0dHZ1Rljr7kPj362UgQ==
X-Proofpoint-GUID: nzez_HIbkGXqRC1wpj15cVdQ0huMNUpx
X-Authority-Analysis: v=2.4 cv=HrZG3UTS c=1 sm=1 tr=0 ts=6a1edcdd cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=qN4U-Vrk9NcT6eTNmKQA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: nzez_HIbkGXqRC1wpj15cVdQ0huMNUpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4613c7fe8e=mnissler@meta.com;
 helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META1=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:39:47 -0400
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

This makes the intended access mode explicit when registering DMA
regions with the server. A new "file I/O" access mode is defined, which
can be used if the file descriptor provided by the client doesn't
support `mmap()`.

Signed-off-by: Mattias Nissler <mnissler@meta.com>
---
 docs/interop/vfio-user.rst | 82 ++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 12deb25102..1c92f442d2 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -604,27 +604,31 @@ Request
 
 The request payload for this message is a structure of the following format:
 
-+-------------+--------+-------------+
-| Name        | Offset | Size        |
-+=============+========+=============+
-| argsz       | 0      | 4           |
-+-------------+--------+-------------+
-| flags       | 4      | 4           |
-+-------------+--------+-------------+
-|             | +-----+------------+ |
-|             | | Bit | Definition | |
-|             | +=====+============+ |
-|             | | 0   | readable   | |
-|             | +-----+------------+ |
-|             | | 1   | writeable  | |
-|             | +-----+------------+ |
-+-------------+--------+-------------+
-| offset      | 8      | 8           |
-+-------------+--------+-------------+
-| address     | 16     | 8           |
-+-------------+--------+-------------+
-| size        | 24     | 8           |
-+-------------+--------+-------------+
++-------------+--------+------------------------+
+| Name        | Offset | Size                   |
++=============+========+========================+
+| argsz       | 0      | 4                      |
++-------------+--------+------------------------+
+| flags       | 4      | 4                      |
++-------------+--------+------------------------+
+|             | +-----+-----------------------+ |
+|             | | Bit | Definition            | |
+|             | +=====+=======================+ |
+|             | | 0   | readable              | |
+|             | +-----+-----------------------+ |
+|             | | 1   | writeable             | |
+|             | +-----+-----------------------+ |
+|             | | 2   | access mode: mmap     | |
+|             | +-----+-----------------------+ |
+|             | | 3   | access mode: file I/O | |
+|             | +-----+-----------------------+ |
++-------------+--------+------------------------+
+| offset      | 8      | 8                      |
++-------------+--------+------------------------+
+| address     | 16     | 8                      |
++-------------+--------+------------------------+
+| size        | 24     | 8                      |
++-------------+--------+------------------------+
 
 * *argsz* is the size of the above structure. Note there is no reply payload,
   so this field differs from other message types.
@@ -634,6 +638,8 @@ The request payload for this message is a structure of the following format:
 
   * *writeable* indicates that the region can be written to.
 
+  * *access mode* bits indicate how the region is to be accessed by the server.
+
 * *offset* is the file offset of the region with respect to the associated file
   descriptor, or zero if the region is not mappable
 * *address* is the base DMA address of the region.
@@ -641,16 +647,30 @@ The request payload for this message is a structure of the following format:
 
 This structure is 32 bytes in size, so the message size is 16 + 32 bytes.
 
-If the DMA region being added can be directly mapped by the server, a file
-descriptor must be sent as part of the message meta-data. The region can be
-mapped via the mmap() system call. On ``AF_UNIX`` sockets, the file descriptor
-must be passed as ``SCM_RIGHTS`` type ancillary data.  Otherwise, if the DMA
-region cannot be directly mapped by the server, no file descriptor must be sent
-as part of the message meta-data and the DMA region can be accessed by the
-server using ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages,
-explained in `Read and Write Operations`_. A command to map over an existing
-region must be failed by the server with ``EEXIST`` set in error field in the
-reply.
+There are several alternative access modes for the server to use when accessing
+the region:
+
+* ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages, explained in
+  `Read and Write Operations`_.
+
+* ``mmap()`` a client-provided file descriptor, then perform direct accesses to
+  the underlying memory.
+
+* File I/O system calls (such as ``pread()`` / ``pwrite()``) against a
+  client-provided file descriptor.
+
+The access mode bits in the flags field indicate which access mode to use. If
+an access mode requiring a file descriptor is specified, but the client does
+not provide a file descriptor, the server must fail the request with
+``EINVAL``. If no access mode flag bit is set, the server should use ``mmap()``
+based access if the client provided a file descriptor and message-based access
+otherwise.
+
+On ``AF_UNIX`` sockets, the file descriptor must be passed as ``SCM_RIGHTS``
+type ancillary data.
+
+A command to map over an existing region must be failed by the server with
+``EEXIST`` set in the error field in the reply.
 
 Reply
 ^^^^^
-- 
2.52.0


