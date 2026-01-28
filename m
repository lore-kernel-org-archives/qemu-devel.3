Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E5FD46C01
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEZk-0004gH-Qn; Wed, 28 Jan 2026 18:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vlEZi-0004fa-PI; Wed, 28 Jan 2026 18:03:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vlEZh-0005m6-2G; Wed, 28 Jan 2026 18:03:50 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SLbE91024596;
 Wed, 28 Jan 2026 23:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DQWv6y
 Xq+AWOeb+LQfTDO6ppWKtBayQQ9welBgel/hg=; b=oN1oPQfy8KUEK9kw0USADo
 2foj8h/vNq2+gb6OqwSWqml15wQHcU1Exe5K36FdIRIjDAclO2fOgunqPPLFH9rw
 ba9Z3DfYAkv6YXVIqEFE0ew8XiK4BHYMw8Es6PpZN7wtwvMZqbxiF/mWFu8NMJUR
 p6pt2v7OBY8IRkWhhPfor1iQLFASGGlJS/7CFkUEt+8pOmG6tsQ4rmEliDkZ/+b+
 Wrqnsrx8xsWLeE/xkmn0dOMRlkUZdmrcCQeiCFxmGIJynLED0tPIELPPa+ctlq6c
 0m2oyO6/Q/ah4Rnwy5qlqgIjPafLMhEeAed2NN/w9XdfgKmD1hrR66iE3vQq6VOA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtp0ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 23:03:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60SKJCte023341;
 Wed, 28 Jan 2026 23:03:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjy96r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 23:03:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60SN3hUo18023140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 23:03:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B32458087;
 Wed, 28 Jan 2026 23:03:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DDDE58082;
 Wed, 28 Jan 2026 23:03:42 +0000 (GMT)
Received: from [9.61.94.134] (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 28 Jan 2026 23:03:42 +0000 (GMT)
Message-ID: <a18a2bd0-14f8-4c1e-b321-095746b3446f@linux.ibm.com>
Date: Wed, 28 Jan 2026 18:03:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] pc-bios/s390-ccw: Add support for virtio-blk-pci
 IPL
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-12-jrossi@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260127161547.459443-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zAar-yGJfh0v5ySwitZ8_Ct9mfEF886w
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697a95d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NmE1XoREQO4h88GRL6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zAar-yGJfh0v5ySwitZ8_Ct9mfEF886w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE4OCBTYWx0ZWRfXyXjpfmmAaAww
 f6aY/D5c/nJvPlaul0KK2SMKGVMDcRnab6QSTEhtppSL1HdjxZVoPWp8Y8FfxI9eB5zNX1wRlEe
 z7/wNy0rDCGZZR1tQjjLs39C2dFg6gKeBowui/Tmg0HPhhnjUVbq4caiWElYxvwbP+JE3rkD8e4
 bV1z4FXSEoFL1NPSYx2P+bDu5Oyj8IKQlrVeUp20/i4BDh+boSn2OxTFa3L09GJt0fWWMjNNUlX
 7GH5QYX1Xae1NT/YTiWv0kO61tqmzYrk13KfnymK2EsBpVcMCWfYCr1B8MGFNA/AtJeELS6zpeZ
 fec+6IvJpBXdnf8TXJd7B5JTCqRtWTydMQq0Lk3C/93ny8VPbOrbAD/AsBEPkLCzTow2lDHorh1
 gjdXItyVO2LA23EwDZIHPDyTGuhKSDmbrD2SYEJOsmFUX6hhCA7lmfGqiXMYpkqJ9Yl1c/B3Go5
 pSxeHnuawEwCd1t93Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I found the following mistake after posting...
> +int virtio_pci_setup(VDev *vdev)
> +{
> +    VRing *vr;
> +    int rc;
> +    uint8_t status;
> +    int i = 0;
> +
> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> +    vdev->cmd_vr_idx = 0;
> +
> +    if (virtio_reset(vdev)) {
> +        return -EIO;
> +    }
> +
> +    status = VPCI_S_ACKNOWLEDGE;
> +    if (virtio_pci_set_status(status)) {
> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
> +        return -EIO;
> +    }
> +
> +    rc = virtio_pci_read_pci_cap_config();
> +    if (rc) {
> +        puts("Invalid virtio PCI capabilities");
> +        return -EIO;
> +    }

Reading the capabilities configuration must be done before writing 
status to the device.

I have already fixed it for the next version.

Regards,
Jared Rossi

