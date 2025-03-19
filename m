Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492A5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwNR-0002Jw-7e; Wed, 19 Mar 2025 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tuwNQ-0002JY-0n
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:34:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tuwNN-0006jG-RX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:34:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JD4p88019575;
 Wed, 19 Mar 2025 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=t7E9dm2P6I3UUViueOfUy96OyIj1
 Ik/NVP5pZxVg9Ak=; b=oXathd2nvxTzpYkkF/CIyFFQLiAQi/79ME1QYr1Qucj1
 0uIyPJJWYWmws5g88gqOvXLvBK8qFy5Uo3d7CpfISw2+Io/b3dRDz0z4iDG0F+JJ
 yizvarI5zmSLHdsVSZciEBO/Z2nv2Dj5GzsY5HozSbBy2kKM2cFrGjIALszGd3k5
 uCd99xKfVhfxIQo6u/ptqA3IBJEjnw/yu3cGnS33E6FmTd2O3S8q13U5neOoW7dN
 n31EgumQh5pwaPffiHdNIY2rKrearLZhiGP+wdhdPjijlIH9uECDZ+RpjGGgkEWi
 5Kqyb/xQqB9YH5Cvd5K8UNG42Xiw/3gJYHkvxbsmTA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9ks7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 16:34:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEYDbI005579;
 Wed, 19 Mar 2025 16:34:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm902ryt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 16:34:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52JGYaDu31261422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 16:34:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA9CE58055;
 Wed, 19 Mar 2025 16:34:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 711D458043;
 Wed, 19 Mar 2025 16:34:36 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Mar 2025 16:34:26 +0000 (GMT)
Message-ID: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
Date: Wed, 19 Mar 2025 11:34:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Jason Wang <jasowang@redhat.com>, dtatulea@nvidia.com
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: VDPA MAC address problem
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vq2W0cBhoeMnbxDebC5YM_B5WnnNUtlo
X-Proofpoint-ORIG-GUID: vq2W0cBhoeMnbxDebC5YM_B5WnnNUtlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=800
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I’m observing a problem while testing VDPA with Nvidia ConnectX-6 (mlx5) 
on s390.

Upon start, virtio_net_device_realize() tries to set a new MAC address 
by VHOST_VDPA_SET_CONFIG which doesn’t do anything.

Later, the VM gets started and learns about the old address from 
virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG 
returns, unless it's "6 zero bytes", in which case it instead returns 
the desired new address (and the problem is avoided).

Then QEMU again tries to set the new address from vhost_net_start(), now 
by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC, 
VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is 
successfully programmed into the NIC, but the VM doesn't know about it.

As the result, the VM now sends packets with a source address on which 
the NIC doesn’t listen.

Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is 
“deprecated”, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must be the right 
method, but it’s apparently called too late. Or maybe 
virtio_net_get_config() needs to always return the desired new address 
and not the old one from VHOST_VDPA_GET_CONFIG?

I’m looking for an opinion/direction from someone who knows this code.

As it is, the only VDPA scenario that's working for me is:
1) Avoid specifying the MAC address in the "vdpa dev add" command (which 
will create the "6 zero bytes" condition on the first launch).
2) Keep using the same MAC address for every subsequent VM launch on the 
same NIC "virtual function" (so that the old and new addresses are the 
same).

