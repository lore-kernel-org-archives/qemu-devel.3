Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C3FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 10:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV6jt-0006er-Ui; Tue, 07 Jan 2025 05:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tV6js-0006eE-7j; Tue, 07 Jan 2025 05:23:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1tV6jq-0003Dg-1K; Tue, 07 Jan 2025 05:23:07 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507869t5019076;
 Tue, 7 Jan 2025 10:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0LS9GD
 JmMum43dShuZbCZsDykEJJ2cgFq4ken0mlNvQ=; b=ScNcWvMdYQpQBy9LILTUi/
 RTUxV8HEuraz3IJQbXCXrlfdFsjOTDIjkpkvzx3ToWmuy5ecrd2/hS4SDf4es4p7
 hVhdV5GhBkqhxnLYBrYY1OfvpZNGxwTnDyaNvAAY4RZD1SO6mN3I+vTa8/rXbgzb
 BkphuTGsxV8JhCFaGwsWsRBjvZHMLNfmhuDD4hhSYF3amWm1xtjl47M0Xdrgv+3S
 vM0loM1tw1+e205q1SvplyeAdu1lTEMt6DDa+RKIc3sjX0D37GKtfX0IOdf6Lqls
 sdTRnq2bEpz/PCWh4yAw1uCsMDT+LmXMZAsV+7PDEc++EzlkSs4uwjP4JajSZ3tw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f38j5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 10:23:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5079Y00U015903;
 Tue, 7 Jan 2025 10:23:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtksumq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 10:23:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507AMwXX37749062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 10:22:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 874D82004F;
 Tue,  7 Jan 2025 10:22:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F8CD2004E;
 Tue,  7 Jan 2025 10:22:58 +0000 (GMT)
Received: from [9.152.224.86] (unknown [9.152.224.86])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 10:22:58 +0000 (GMT)
Message-ID: <4e88ca55-0849-411b-95ab-8b88486907f5@linux.ibm.com>
Date: Tue, 7 Jan 2025 11:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/s390x: Remove deprecated machine types 2.4 up to
 2.8
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YVfo6FjqrXF1rohMfkyhaz1D8myW12fu
X-Proofpoint-ORIG-GUID: YVfo6FjqrXF1rohMfkyhaz1D8myW12fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=963
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070083
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am 03.01.25 um 15:42 schrieb Thomas Huth:
> According to our support policy, we don't support machine types anymore
> that are older than 6 years, so we can remove the very old 2.x machine
> types now. Let's start by removing all s390-virtio-ccw machines up to


not fully tested or reviewed, but
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
for the series.


> version 2.8. (This also helps to get rid of the problem that has been
> described in: https://gitlab.com/qemu-project/qemu/-/issues/2213 )
> 
> Thomas Huth (10):
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4 and 2.5 machine
>      types
>    hw/s390x/s390-skeys: Remove the "migration-enabled" property
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.6 machine type
>    hw/s390x: Remove the "ri_allowed" switch
>    hw/s390x/ipl: Remove the "iplbext_migration" property
>    hw/s390x/css-bridge: Remove the "css_dev_path" property
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.7 machine type
>    hw/s390x: Remove the cpu_model_allowed flag and related code
>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.8 machine type
>    hw/s390x: Remove the "adapter_routes_max_batch" property from the flic
> 
>   hw/s390x/ipl.h                     |   1 -
>   include/hw/s390x/css-bridge.h      |   1 -
>   include/hw/s390x/s390-virtio-ccw.h |   6 --
>   include/hw/s390x/s390_flic.h       |   2 -
>   include/hw/s390x/storage-keys.h    |   2 -
>   hw/intc/s390_flic.c                |   9 ---
>   hw/s390x/css-bridge.c              |  16 +----
>   hw/s390x/ipl.c                     |  10 ---
>   hw/s390x/s390-skeys.c              |  10 +--
>   hw/s390x/s390-virtio-ccw.c         | 108 +----------------------------
>   hw/s390x/virtio-ccw.c              |   5 +-
>   target/s390x/kvm/kvm.c             |  16 ++---
>   12 files changed, 11 insertions(+), 175 deletions(-)
> 


