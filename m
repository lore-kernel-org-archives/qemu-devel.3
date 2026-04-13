Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FFBF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQK1-0006Bq-Sn; Mon, 13 Apr 2026 19:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQK0-00062k-3x; Mon, 13 Apr 2026 19:04:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCQJy-0005GJ-8M; Mon, 13 Apr 2026 19:03:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLIS4F1733880; Mon, 13 Apr 2026 23:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WY7tbT
 hfaPTQUfZNcDixA0OwPRss35rDRWFEl6dU+40=; b=ivR1vsob2bl0iK73zpWLa1
 quhfOz3+XeT17xuLNc+aKlYYpReXH3rn3p8P9E4Fo5VDw49jspLKU6diRSp3wkGV
 1kLCrCYMeUJKIevs/+o6aijih27qalE1mWevoSoDqDEGb3BwOGTs/TFxG53W0qWq
 PhG+b3VrnTcI53Pi4X2STIgfszghM764RFz/J+oG72vk3HWAeMEev3c6oz17Fu30
 3FPmk3bqNFTxDFHiNka+oz5UaYZxitktdlSeikwUuaTrqGNwu7VVuu3TmoGSePao
 eRonFF/1scJltcc1Vq/G05PldPB8bt/oBA6bLsH5ix8qHnnlreFWwZSp1FIci3yw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m07v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 23:03:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DIamxR025761;
 Mon, 13 Apr 2026 23:03:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1ewjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 23:03:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63DN3pqR31720054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 23:03:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85E8D5806F;
 Mon, 13 Apr 2026 23:03:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D365A5806E;
 Mon, 13 Apr 2026 23:03:49 +0000 (GMT)
Received: from [9.61.251.241] (unknown [9.61.251.241])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 23:03:49 +0000 (GMT)
Message-ID: <1e63bff9-1d51-4191-8480-8a9f76d7a8b2@linux.ibm.com>
Date: Mon, 13 Apr 2026 19:03:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 30/30] docs/system/s390x: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-31-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-31-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69dd765a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=q5T4S90kAAAA:8 a=VcpBB9CY4TacUpeCvWIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=LnBBZQxPVJ0Z7KJyRdxh:22
X-Proofpoint-GUID: Ic5dj5XnQoMPDAThQH1xc637UV6Hh-Cc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIyNCBTYWx0ZWRfX0tHWXVRk6kte
 u/T43s0H6boSwCv4D+ab/FSnGk4vP5CXZUaM1N0dxBfksxbwbSQh3VRKm7aEYB2/fGabKwlf77F
 hHHDwr8ogp6Hz4SVm5DZ7qSji9hCAleiE8XdTuF6sVaGNwj0JTv+0+5aRpMAMON6BXaYt+bpe85
 F5xgErslt5nNlHBhN7RIl3hE5Ofx3ALTWahOYULK07nnnk0v8IKFq5qL6/RFjcvxO5jNA6Fs0jm
 nF71Gpkh61pccr7HMC7ph+ImSuDyfsIKgBLzb1ELDX9H7bk14fr1aBj8cElxbMny39CMbu2wCAz
 dR0VzE46Q5eAX2F/j7Sdte3Mbk9CHml1LDXOI9hY48S0iJ/S4fNDW/IdyKCnliGkkVJ5hvX9krC
 73OFg3HjlUHfeGSoBJP//w/vV3/KQUZOmtcVTDyZBZPNa6GTxSZKlEoTjlZVvHruEbCl66Gngrz
 wdXTOUgfgYjtfOFTlZQ==
X-Proofpoint-ORIG-GUID: Ic5dj5XnQoMPDAThQH1xc637UV6Hh-Cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604130224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/2/2026 6:14 PM, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst | 97 ++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index e0af086c38..db9fb46fea 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -1,5 +1,21 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
>   
> +s390 Secure IPL
> +===============
> +
> +Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
> +verify the integrity of guest kernels.
> +
> +For technical details of this feature, see ``docs/specs/s390x-secure-ipl.rst``.
See my comment on the previous patch.
"For technical details of this feature, see the :doc:`specs document </specs/s390x-secure-ipl>`."

> +
> +This document explains how to use secure IPL with s390x in QEMU. It covers
> +the command line options for providing certificates and enabling secure IPL,
> +the different IPL modes (Normal, Audit, and Secure), and system requirements.
> +
> +A quickstart guide is provided to demonstrate how to generate certificates,
> +sign images, and start a guest in Secure Mode.
> +
> +
>   Secure IPL Command Line Options
>   ===============================
>   
> @@ -78,3 +94,84 @@ Configuration:
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +
> +Constraints
> +===========
> +
> +The following constraints apply when attempting to boot an s390x guest in secure
> +mode:
> +
> +- z16 or "qemu" CPU model
> +- certificates must be in X.509 PEM format
> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
> +- a boot device must be specified
> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
> +  network) will cause the entire boot process terminating early with an error
> +  logged to the console.
> +
> +
> +Secure IPL Quickstart
> +=====================
> +
> +Build QEMU with gnutls enabled
> +-------------------------------
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via certtool)
> +----------------------------------------
> +
> +A private key is required before generating a certificate. This key must be kept
> +secure and confidential.
> +
> +Use an RSA private key for signing.
> +
> +.. code-block:: shell
> +
> +    certtool --generate-privkey > key.pem
> +
> +A self-signed certificate requires the organization name. Use the ``cert.info``
> +template to pre-fill values and avoid interactive prompts from certtool.
> +
> +.. code-block:: shell
> +
> +    cat > cert.info <<EOF
> +    cn = "My Name"
> +    expiration_days = 36500
> +    cert_signing_key
> +    EOF
> +
> +    certtool --generate-self-signed \
> +             --load-privkey key.pem \
> +             --template cert.info \
> +             --hash=SHA256 \
> +             --outfile cert.pem
> +
> +Sign Images (e.g. via sign-file)
> +--------------------------------
> +
> +- signing must be performed on a guest filesystem
> +- sign-file script used in the example below is located within the kernel source
> +  repo
> +
> +.. code-block:: shell
> +
> +    ./sign-file sha256 key.pem cert.pem /boot/vmlinuz-…
> +    ./sign-file sha256 key.pem cert.pem /usr/lib/s390-tools/stage3.bin
> +
> +Run zipl with secure boot enabled
> +---------------------------------
> +
> +.. code-block:: shell
> +
> +    zipl --secure 1 -V
> +
Please consider clarifying that zipl must be run on the guest filesystem.

> +Command line options for starting the guest
> +-------------------------------------------
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=cert.pem ...

Regarding this document overall: The bullets in docs/system/target-s390x
do not render sensibly in the sphinx build. See my similar comment on the previous patch.

