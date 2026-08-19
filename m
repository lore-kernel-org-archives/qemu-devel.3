Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED655C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgwz-0004H7-Oa; Wed, 19 Aug 2026 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wwgwy-0004Gr-NK; Wed, 19 Aug 2026 10:07:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wwgwv-0006EI-CR; Wed, 19 Aug 2026 10:07:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD1WIO3480028; Wed, 19 Aug 2026 14:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JK/ufO
 8LtegI2KExrv+JneTL3BHjpBHf/LtGj7CMYVw=; b=cZpha5YRt1BaksWrxXS1ou
 4g4MO7X7vurDl3fN8AePymg46+NsJHOhP7nlaPTXynatMWktVRPGqDD51DrHcTzv
 o7s7QdPdTwyTSojjzqD95YxCY+ReaKCpl+QOqRjn+FtH/IfzSaW5XHGnx3nunrEy
 jCw1tOSNW9YwLvPJ41aHowlCLO5J/Y0Zt8pcj8UBBo3erlPopS/cenNaw6Kr+orh
 M9IqIsR8HVObLe8tHYwthf9gISnyVxdzYVQxVCU0n5her+djUkTOVJKztUdBPGLZ
 V5zhVNupvw6yzVD+ksCnrVurvMCQESDwCMeQhMmTETuy1mBC6NZfO0g6h2vD2wjQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1c690-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 14:07:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JDuHBY003465;
 Wed, 19 Aug 2026 14:07:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngh2rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 14:07:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JE7Jnp9634478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 14:07:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A6458056;
 Wed, 19 Aug 2026 14:07:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CB4058067;
 Wed, 19 Aug 2026 14:07:18 +0000 (GMT)
Received: from [9.61.78.161] (unknown [9.61.78.161])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 14:07:18 +0000 (GMT)
Message-ID: <478e38d1-171f-4ebd-aed1-9e91e11a7f29@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:07:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/34] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a85b899 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=etH__ywx-kW60aPSC6AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DpoPkjBLck7rVo8TYs2bAWtHm12jkft-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX2DBdgsgvjizW
 7w6icgHVPGB2/uqpELPFvJpGpgf071EygLA4BPwJJ02NeMV73YSxFx0IQm0ozMv4KhgJbtsIVJF
 oFs9LsuHIhNeUtv1FafvJ2v3ODwDYgA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX5QVG+h6YvNr9
 mYCIAkT6roaNNOJrQCYKgcBFtmru9p2ZtyBc8gF1SOgdkkeLO/7I8dt+Y8caufoZOmf3VEUMbUb
 hTN35QWRzgu4CEb7tBWTuSGzlybxZ+GWruEjpe1wXiEWXtgeYAYQBJXi9stsGztyaXtMXJxgGGZ
 nDbAsXRhNkjheYCsdZrIQlKmbNIoNK/awRxEpqa9qinRB0zwYkN9sCE1GnEZ+p1IPN5Y25cdfHG
 LHGlSX9KVEQi3DXo11/wwVMrrsKDXX8Qy/SfIVp1hm7UNYN1JAs/gmgHUhzD0IcR+h8eDA3xa7f
 qVgzktN2PEWMsUq+j0yKCzmCiQcoi+dzV3gGx16tGNT5AwHCfB/OCkJ8tvUj3sZDZGcnU0VWb6X
 OQ6wIAJrrOR75cR8rGWQpIIcvCkmPqHTGLBjbqctr56ywxKWFEM+aX+XCmbqDRX00BhxJK/FcIc
 6HmiVoPuC5uh8TFjqqg==
X-Proofpoint-ORIG-GUID: DpoPkjBLck7rVo8TYs2bAWtHm12jkft-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190109
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/30/26 5:45 PM, Zhuoying Cai wrote:
> changelog v16->v17
> 
> This series is based on https://lore.kernel.org/qemu-devel/20260723163806.368127-1-cohuck@redhat.com/
> which adds the new 11.2 compat machines for QEMU.
> 
> [PATCH v16 09/33] s390x/diag: Implement DIAG 320 subcode 2
> [PATCH v16 23/33] pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
> [PATCH v16 24/33] pc-bios/s390-ccw: Add signed component address overlap checks
> [PATCH v16 26/33] pc-bios/s390-ccw: Add additional security checks for secure boot
> - Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 
> [PATCH v16 20/33] pc-bios/s390-ccw: Refactor zipl_run()
> - Moved the "/* should not return */" comment to the same line as
>    the `return -1` statement in `zipl_run()`.
> 
> [PATCH v16 23/33] pc-bios/s390-ccw: Add signature verification for secure IPL in audit mode
> - Freed tmp_cert_buf when no EXEC entry is found in zipl_run() to
>    avoid a memory leak.
> 
> Compat machines
> - Moved the boot-certs and secure-boot machine type options from
>    11.1 compat machines to the new 11.2 compat machines.
> 
> MAINTAINERS
> - Added secure IPL related files to the s390-ccw boot firmware
>    maintainers group.
> 
> ------------------------------------------------------------------------
> 
> # Description
> 
> This patch series is an external requirement by Linux distribution
> partners to verify secure IPL process. Additional secure IPL checks are
> also included in this series to address security holes in the original
> secure IPL design to prevent malicious actors to boot modified or
> unsigned code despite secure IPL being enforced.

Thank you!! I have queued this series for 11.2

..snip...

> 
>   MAINTAINERS                               |   5 +
>   crypto/meson.build                        |   2 +-
>   crypto/x509-utils.c                       | 409 +++++++++++++++
>   docs/specs/index.rst                      |   1 +
>   docs/specs/s390x-secure-ipl.rst           | 197 ++++++++
>   docs/system/s390x/secure-ipl.rst          | 184 +++++++
>   docs/system/target-s390x.rst              |   1 +
>   hw/s390x/cert-store.c                     | 244 +++++++++
>   hw/s390x/cert-store.h                     |  38 ++
>   hw/s390x/ipl.c                            | 128 ++++-
>   hw/s390x/ipl.h                            |  29 +-
>   hw/s390x/meson.build                      |   1 +
>   hw/s390x/s390-virtio-ccw.c                |  70 +++
>   hw/s390x/sclp.c                           |   2 +
>   include/crypto/x509-utils.h               | 113 +++++
>   include/hw/s390x/ipl/diag308.h            |  34 ++
>   include/hw/s390x/ipl/diag320.h            | 118 +++++
>   include/hw/s390x/ipl/diag508.h            |  45 ++
>   include/hw/s390x/ipl/qipl.h               | 113 ++++-
>   include/hw/s390x/s390-virtio-ccw.h        |   5 +
>   include/hw/s390x/sclp.h                   |   6 +-
>   pc-bios/s390-ccw/Makefile                 |   2 +-
>   pc-bios/s390-ccw/bootmap.c                | 108 +++-
>   pc-bios/s390-ccw/bootmap.h                |  22 +
>   pc-bios/s390-ccw/iplb.h                   |   9 +-
>   pc-bios/s390-ccw/jump2ipl.c               |  13 +-
>   pc-bios/s390-ccw/main.c                   |  59 ++-
>   pc-bios/s390-ccw/netmain.c                |   8 +-
>   pc-bios/s390-ccw/s390-ccw.h               |  27 +
>   pc-bios/s390-ccw/sclp.c                   |  27 +
>   pc-bios/s390-ccw/sclp.h                   |   7 +
>   pc-bios/s390-ccw/secure-ipl.c             | 561 +++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h             | 183 +++++++
>   qapi/machine-s390x.json                   |  23 +
>   qapi/pragma.json                          |   1 +
>   qemu-options.hx                           |  10 +-
>   target/s390x/cpu_features.c               |   7 +
>   target/s390x/cpu_features.h               |   1 +
>   target/s390x/cpu_features_def.h.inc       |   5 +
>   target/s390x/cpu_models.c                 |   7 +
>   target/s390x/diag.c                       | 576 +++++++++++++++++++++-
>   target/s390x/gen-features.c               |   7 +
>   target/s390x/kvm/kvm.c                    |  34 ++
>   target/s390x/s390x-internal.h             |   4 +
>   target/s390x/tcg/misc_helper.c            |  14 +
>   tests/functional/s390x/meson.build        |   2 +
>   tests/functional/s390x/test_secure_ipl.py | 172 +++++++
>   47 files changed, 3537 insertions(+), 97 deletions(-)
>   create mode 100644 docs/specs/s390x-secure-ipl.rst
>   create mode 100644 docs/system/s390x/secure-ipl.rst
>   create mode 100644 hw/s390x/cert-store.c
>   create mode 100644 hw/s390x/cert-store.h
>   create mode 100644 include/hw/s390x/ipl/diag308.h
>   create mode 100644 include/hw/s390x/ipl/diag320.h
>   create mode 100644 include/hw/s390x/ipl/diag508.h
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>   create mode 100755 tests/functional/s390x/test_secure_ipl.py
> 


