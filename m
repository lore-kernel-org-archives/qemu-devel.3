Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962BCD31767
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Me0-0006nr-NM; Tue, 05 Nov 2024 11:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t8Mds-0006mu-Vd; Tue, 05 Nov 2024 11:42:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t8Mdr-0003ns-97; Tue, 05 Nov 2024 11:42:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Ge16C017707;
 Tue, 5 Nov 2024 16:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fusMRa
 AnU7kTfMpx2bzD/p+JENCApKCz4Dbjz/ffYWY=; b=f7x/fm4OfdDsaAdjpRRbgi
 DYhj/PMYxY+Nu1O8IR2cA7orb0ZFlaSUjXCxiOcMQOnPYgw6q0KgYfMdkFzmARvV
 Sy6m1UMRsU9rfCMTtqO4sHoySWiDC1C1G8ZhXlqbX+RHgIEWwqab+LmAz0EKFY39
 IvR5apUDHmerMeTUoAOr2pFd+i7dyoTRnOyxlWsrmCYScORNyhIgYQChlXBIz53G
 c9TIBNKwu/xwLXxPV/KrecbbOC1legXjs2ajk0ikv+XI4gAGrnJ06UEK4rADQhL0
 g3fZHw+fXGEZC+6/Ybc7QuR6rkYpYUVTHtbZAToCPXqtA7t2Lt5cN9w1uNPu6ntA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qq33809c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 16:42:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5875KT019625;
 Tue, 5 Nov 2024 16:42:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj4djv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 16:42:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5Ggom622610634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 16:42:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B157458043;
 Tue,  5 Nov 2024 16:42:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 278E25805D;
 Tue,  5 Nov 2024 16:42:50 +0000 (GMT)
Received: from [9.61.16.77] (unknown [9.61.16.77])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  5 Nov 2024 16:42:50 +0000 (GMT)
Message-ID: <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
Date: Tue, 5 Nov 2024 11:42:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1m4pt5r-HGYOTRVqjSbheCUoW5HHnTyP
X-Proofpoint-GUID: 1m4pt5r-HGYOTRVqjSbheCUoW5HHnTyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Thomas, Sebastian,

It looks like this is simply caused by the "is_cdrom" value only ever 
being set
to true.  I think it is a one-line fix that just makes sure to 
initialize the
value to false each time we try a new device:

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a4d1c05aac..3fdba0bedc 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -214,6 +214,7 @@ static void boot_setup(void)
  static bool find_boot_device(void)
  {
      VDev *vdev = virtio_get_device();
+    vdev->is_cdrom = false;
      bool found = false;

      switch (iplb.pbt) {

I tested it with the two scenarios you mention and with the existing qtests,
and it seems to work correctly now.

Thanks for finding the mistake,
  Jared Rossi

On 10/31/24 11:50 AM, Thomas Huth wrote:
> On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> changes v4 -> v5:
>> - Fix a bug with per-deice loadparm support:
>>      The machine loadparm is no longer overwritten by device values, 
>> which now
>>      allows an empty machine loadparm to propagate to later devices 
>> even if
>>      the primary boot device set an initial loadparm
>> - Fix two instances where changes were squashed into wrong patch
>> - Fix an instance where NULL_BLOCK_NR was returned instead of 
>> ERROR_BLOCK_NR
>> - Fix an instance of logical AND being used instead of bitwise AND
>> - Standardize all error values to be negative in all device type paths
>> - Minor stylistic changes and code simplification
>
>  Hi Jared!
>
> Our QE Sebastian also had a try with the patches today, and discovered 
> some non-working scenarios:
>
> Try to boot from non-working CD image first, then from a working HD 
> image:
>
> dd if=/dev/zero of=/tmp/zero.dat bs=1M count=10
> qemu-system-s390x -nographic -accel kvm -m 2G \
>  -drive if=none,id=d1,file=/tmp/zero.dat,format=raw,media=cdrom \
>  -device virtio-scsi -device scsi-cd,drive=d1,bootindex=1 \
>  -drive if=none,file=good-image.qcow2,id=d2 \
>  -device virtio-blk,drive=d2,bootindex=2
>
> This outputs something like the following text, then aborts:
>
> LOADPARM=[        ]
>
> Using virtio-scsi.
> SCSI CD-ROM detected.
> Failed to IPL this ISO image!
> LOADPARM=[        ]
>
> Using virtio-blk.
> Failed to IPL this ISO image!
> ERROR: No suitable device for IPL. Halting...
>
> Looks like the s390-ccw bios is treating the virtio-blk device as 
> CD-ROM in this case?
>
> Almost the same setup, first device is again a non-working CD image, 
> but the second device is a virtio-net device - results in the same 
> error message (so it's likely the same or at least a very similar 
> problem).
>
> Could you please have a look?
>
>  Thanks!
>   Thomas
>


