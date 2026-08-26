Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AFDC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHFt-0006hZ-3f; Wed, 26 Aug 2026 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzHFg-0006cE-DB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzHFe-0008Pr-C8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1WHa401742
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S5V+6J
 7URfJuDNjNAhBlX2DIcv53ITL9VpkLEr1B2aM=; b=HHNTjb8xxlG3svbfBJ8hD2
 bfHhWMCcBuVOwenTpHREo1gv2zCg6UXtRlJrP+JFfrKZydPRqXM5bOqy45ofQNxG
 OrluJFQn2gaXMM7+FVXI4+E5jkp/Pjek9oVwLmjckueGtC+59PPgIfLIwh/9T8rx
 hZM+gkVZJagQgnGWxsjeEzjYF+FN6kT5ZGdVdzOvVsNQqTLW0oVVaIFhDVEnGpXp
 P+NDRp3iWl/DKDufBpQ8s061zxKEZwicSyCozwN+0BGIESKlelwPSwmmB/iZft1w
 ERv/1+PH7j1iODirlNotawxOtsyYxH9T/moIx8vdPkkRXFtbrFUnAB0M1hKt0IzQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g739484q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:17:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGfF4K006407;
 Wed, 26 Aug 2026 17:17:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragk10q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:17:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QHHHQG22414016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:17:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B36558055;
 Wed, 26 Aug 2026 17:17:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 958CA58054;
 Wed, 26 Aug 2026 17:17:15 +0000 (GMT)
Received: from [9.39.23.191] (unknown [9.39.23.191])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 17:17:15 +0000 (GMT)
Message-ID: <86e80197-a96f-42e2-a061-5312e219150b@linux.ibm.com>
Date: Wed, 26 Aug 2026 22:47:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net/tap: add tap_fd_get_mtu() to query host tap MTU
To: Nariman Sayed <narimansayed28@gmail.com>, qemu-devel@nongnu.org
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20260816043451.2547-2-narimansayed28@gmail.com>
Content-Language: en-US
Cc: asahu1x@linux.ibm.com
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260816043451.2547-2-narimansayed28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rJU0s2yPxutEOKAAG9d8RKmS9AdfM14S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MiBTYWx0ZWRfX0Rt7Yng+Pk+1
 Op54OWRfGzD10uKsGpIGf+dXDo+WKz60hb+fJT6XLbnKk6ZWHGORS3VmtHjHC148pyCUo4n4AES
 wLwf77ceJFnPNBaGpKvI68OLGKPtuzpPTqGhbTjzNbafMwZRaPKcQobRqzcvSQSPfgFqgrGCjL3
 ObnGA1H/ehjdxT1dcxh9mZcrk+4w3m0d45VDwCj6opVDzkqIf3wkgHKVWEta1CeSXgV9JiPFV2l
 YI0WaHJOIO4i3RvEMOdTOW/qJ8m2DUzwOA7UYlbrT/uAGXhdNayCGc38aHeO3CybWVWlW5WyC5r
 vHMi0VBifHMhNRFCed2ycHp+rtPzaUBjnkJ5mDHIZfV4pKu9MiFveK0c2Efg3vD9tNSHaOEnVxs
 Y0hHs3ABbPekiya+uiAm7Y6yihkILmKO8spd5vvQssCgTsj43MosYbWULTCqGfBadVylgcW+mD6
 0YLodIwk4Vuuwh51GDA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f1fa1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=o_qhWZrZVVRVgZSg2JwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MiBTYWx0ZWRfX3y6tfxlOJVnN
 aIbrS6S4lSSvW/xG24Lu4FwBsoNCuzreHtdoNTuWTnl5UYBseiRRnDZpkL0ATxbdQzs0SXizr6a
 k/FLGoNl3OoxS7kvUqfX0j2QlDLHNEY=
X-Proofpoint-ORIG-GUID: 9LCpZLGvR8ok0Db3gfMSmXLGCqLnY79U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
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

On Fri, Aug 16, 2026 at 04:34:48AM +0000, Nariman Sayed wrote:
 > This series adds automatic detection of the host tap device's MTU and
 > exposes it to the guest via the VIRTIO_NET_F_MTU feature flag.

Thanks for this patch Nariman. Please feel free to add:

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>

I've tested this patch series on ppc64le (POWER10 LPAR) and can confirm
the mtu-from-tap feature works as you have described it.

Test environment:
- Host: Ubuntu 26.04 ppc64le on POWER10 LPAR
- Guest: SLES 16.1 RC2 (kernel 7.2.0-rc7)
- QEMU: Built from master with this patch series applied
- Tap device: tap-test with MTU 9000
    root@ltcden6-lp4:~# ip link show tap-test
    4: tap-test: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc 
fq_codel state UP mode DEFAULT group default qlen 1000
       link/ether 9a:81:53:15:e9:cb brd ff:ff:ff:ff:ff:ff

Test results:

1. Control (without mtu-from-tap):
    Command: qemu-system-ppc64 -machine pseries -cpu POWER10 -m 10G -smp 8 \
             -accel kvm -netdev bridge,id=net0,br=virbr0 \
             -device virtio-net-pci,netdev=net0

    Guest MTU: 1500 (default)

    Guest console output:
    Welcome to SUSE Linux Enterprise Server 16.1 012-RC2 (ppc64le) - 
Kernel 7.2.0-rc7-160099.47-default+ (hvc0).

    enp0s2: 192.168.122.203



    localhost login: root
    Password:
    Last login: Wed Aug 26 18:52:47 CEST 2026 on hvc0
    Have a lot of fun...
    localhost:~ #
    localhost:~ #
    localhost:~ #
    localhost:~ # ip addr
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       inet 127.0.0.1/8 scope host lo
          valid_lft forever preferred_lft forever
       inet6 ::1/128 scope host noprefixroute
          valid_lft forever preferred_lft forever
    2: enp0s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc 
pfifo_fast state UP group default qlen 1000
       link/ether 52:54:00:b2:6a:47 brd ff:ff:ff:ff:ff:ff
       altname enx525400b26a47
       inet 192.168.122.203/24 brd 192.168.122.255 scope global dynamic 
noprefixroute enp0s2
          valid_lft 3585sec preferred_lft 3585sec
       inet6 fe80::5054:ff:feb2:6a47/64 scope link noprefixroute
          valid_lft forever preferred_lft forever

2. With mtu-from-tap=on:
    Command: qemu-system-ppc64 -machine pseries -cpu POWER10 -m 10G -smp 8 \
             -accel kvm -netdev 
tap,id=net0,ifname=tap-test,script=no,downscript=no \
             -device virtio-net-pci,netdev=net0,mtu-from-tap=on

    Guest MTU: 9000 (correctly auto-detected from host tap device)

    Guest console output:
    Welcome to SUSE Linux Enterprise Server 16.1 012-RC2 (ppc64le) - 
Kernel 7.2.0-rc7-160099.47-default+ (hvc0).

    enp0s2: fe80::5054:ff:feb2:6a47%enp0s2



    localhost login: root
    Password:
    Last login: Wed Aug 26 18:58:22 CEST 2026 on hvc0
    Have a lot of fun...
    localhost:~ # ip link show eth0
    Device "eth0" does not exist.
    localhost:~ # ip link show
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
mode DEFAULT group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: enp0s2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc 
pfifo_fast state UP mode DEFAULT group default qlen 1000
       link/ether 52:54:00:b2:6a:47 brd ff:ff:ff:ff:ff:ff
       altname enx525400b26a47
    localhost:~ #

The guest successfully negotiated VIRTIO_NET_F_MTU and inherited the MTU
from the host tap device without requiring manual host_mtu= configuration.

Thanks,
Aniket


