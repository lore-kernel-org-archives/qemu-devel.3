Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E32C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjne-0001vJ-5B; Wed, 07 May 2025 14:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnW-0001s2-8d
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uCjnS-0004py-Vn
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:47:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547IeVWr025463;
 Wed, 7 May 2025 18:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=za0hYpX4TfnF3z1+
 rI+iYxKfu29+UjmJYC3u4pi94NA=; b=IWuv3u5QvXVeNRwG4wLXnouDSMPUKzDY
 caLM0bf8qaFQ+XGygwaE8b/uZgE4IfazqMC8tnGJ/ys3eiD+rojFRuZzt/u74z5R
 3MvJRMfxaGF7yY+SLGc/eQtmadUF93y/XntMK1GNcD4GrMF7u7MIAuMxJ6WFQgxS
 GyVef9L73MM44ulSIWMRNe9odYXlg63lARomymAHLnfEotXXsYJma7bHrknZrWp1
 q+iYARzYsQGP2ZHxeMjl42y6eii5ETXpKxIEAQM/CweW32RcDpmgRwoCJJcVcNNa
 ec8wGiGzQXAotmBafhEla7ytqEWxoQqFcElghgbK04OMDSZwVRZtXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcgn028s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 547HtMYp036036; Wed, 7 May 2025 18:47:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46d9kbhd62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 May 2025 18:47:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547Il3it029452;
 Wed, 7 May 2025 18:47:03 GMT
Received: from dhcp-10-43-71-250.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-250.usdhcp.oraclecorp.com [10.43.71.250])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46d9kbhd41-1; Wed, 07 May 2025 18:47:02 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com
Subject: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
Date: Wed,  7 May 2025 14:46:40 -0400
Message-ID: <20250507184647.15580-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX9zYeo4L84gmz
 YPcfH7k3MKbf77OyVdPIr86RqJNWLvxDxLpjQ1yshYemVxlMPsIqA+PDd2WrOKOMz/Ku4224xLo
 Dlw4BtJvUZbTKUqka0r/qep9PazPTlKWz0pC8XLEbxr6n0sKj4IwQQN/OsPV0EH9lv3YG+GFiEX
 Swf5072J9queQrOtCnEknaUWCi5L8zoXBdMqk580u3MFjUDtypVY0pcEIB3s7ALRJ5EbRQ1wo92
 64vFL2gQPUC5g63I145gMkI9MZCfDtzqjVOOvWANqN1KYj1aMvE3JEdhB/HAJvz3ef52ufcEWMx
 rSHpcm0pgumfFDtVNP9jZ2XKes967JdOWeK4Mnqohsv3KE0TE9RnqE6lpE9cV5CCFOAFlj475oG
 q7pZ2kPw8CoNCafyxBCQ8Lay6G51O8OZOz3zTFMlO6Qfwzfm/oVmQWwUD5qHRrSBzSReDf/o
X-Proofpoint-ORIG-GUID: yY8Yf6h6k_rsiku5Q5dzDwFpuyvPUEaL
X-Authority-Analysis: v=2.4 cv=GKcIEvNK c=1 sm=1 tr=0 ts=681baaa8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=WQgBD-38X1HkX1-ZmYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5WABlXvFAscA:10
 a=n0c7R5xxTHgA:10
X-Proofpoint-GUID: yY8Yf6h6k_rsiku5Q5dzDwFpuyvPUEaL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as checking the trace timestamp from the moment
the source suspend the device to the moment the destination starts the
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
secs to 2.0949.

Future directions on top of this series may include to move more things ahead
of the migration time, like set DRIVER_OK or perform actual iterative migration
of virtio-net devices.

Comments are welcome.

This series is a different approach of series [1]. As the title does not
reflect the changes anymore, please refer to the previous one to know the
series history.

This series is based on [2], it must be applied after it.

[Jonah Palmer]
This series was rebased after [3] was pulled in, as [3] was a prerequisite
fix for this series.

v4:
---
* Add memory listener unregistration to vhost_vdpa_reset_device.
* Remove memory listener unregistration from vhost_vdpa_reset_status.

v3:
---
* Rebase

v2:
---
* Move the memory listener registration to vhost_vdpa_set_owner function.
* Move the iova_tree allocation to net_vhost_vdpa_init.

v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.

[1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
[3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/

Jonah - note: I'll be on vacation from May 10-19. Will respond to
              comments when I return.

Eugenio Pérez (7):
  vdpa: check for iova tree initialized at net_client_start
  vdpa: reorder vhost_vdpa_set_backend_cap
  vdpa: set backend capabilities at vhost_vdpa_init
  vdpa: add listener_registered
  vdpa: reorder listener assignment
  vdpa: move iova_tree allocation to net_vhost_vdpa_init
  vdpa: move memory listener register to vhost_vdpa_init

 hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
 include/hw/virtio/vhost-vdpa.h |  22 ++++++-
 net/vhost-vdpa.c               |  34 +----------
 3 files changed, 93 insertions(+), 70 deletions(-)

-- 
2.43.5


