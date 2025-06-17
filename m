Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E48C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 21:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRdrw-0001gS-Rg; Tue, 17 Jun 2025 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uRdru-0001fs-G2; Tue, 17 Jun 2025 17:29:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uRdrr-00044Z-8C; Tue, 17 Jun 2025 17:29:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HE9KjD004841;
 Tue, 17 Jun 2025 21:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ow4znh
 7bynszcABECjLvEqHPn9RVhq5IFj199GleAbY=; b=Q7cOQ9zOQcln+v1kphjANs
 Hje4BIGJ3gcdKuuOwRtNa5csArbk+w+1hadEam5r83jqD9y9kejs0HmJOmeWCqyf
 COqzBh7IhjdplTpZ5sA3u3TZ4zZZ6TbaI+xueEBmvJ1HUs97pWMdsWXXePTm+pHp
 us+6T9tdQZ5DDgWG0+QTlR04L8ovTqFYi4ghMXsQcqhonVUYT5FxLEMOnGQ6NBND
 KmPkMSFiOnmHQIfwERsRsm+fSD8V7woogDzB1yP9Q9m2ZUeKm+zLozkGzQTq2OD2
 aCWylMQ5nABdt528Ql+FQyYGzOJNvNn0SPqfDRiAxydsIKvvChOMN7gW20rjMcuw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790te33qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 21:29:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HJStGD000762;
 Tue, 17 Jun 2025 21:29:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp5nbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 21:29:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55HLTAq030147148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 21:29:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C012F58052;
 Tue, 17 Jun 2025 21:29:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E018158056;
 Tue, 17 Jun 2025 21:29:09 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Jun 2025 21:29:09 +0000 (GMT)
Message-ID: <bc118189-e646-4943-bf6d-8d70b08f3947@linux.ibm.com>
Date: Tue, 17 Jun 2025 17:29:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/28] docs: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-29-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250604215657.528142-29-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nfuDdxHr83C6OfqTaB18PMfQQpLK1jnW
X-Proofpoint-GUID: nfuDdxHr83C6OfqTaB18PMfQQpLK1jnW
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=6851de29 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=seHwrtf_5J89tuW6MmEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfX+gX8+ANJNYoa
 aROBG7togxZnXk6YEZK9CFn0OYG0eDWnFeEhN2CIOqTqFI2fLSWVq9daqX0oZKgGKSVIsDVRYMW
 8gPiCnbZRCsjz6dKGgr4+Gwuq3yJbm5BMtsyUKRqFZRdISCp0Z43q364NgUUw6gF6Mo4qB3EEI2
 4DAlhBRoJh0o2xz3eavou2FCgmrqKz+X3YGZSxNh1y0XxiM+jjn5f1X2jA4ZZ5eLwQGNImA0nAy
 GWJHIbvIYu5UN8pBR1lgyXkciAYpD5y9ATa4LoyNzEqnoO8ug6L/xcGUjQhgSf2uOX1YXyhYvni
 ZOpsLjdM6PmZ5UwESkub/Rz3Wxo416Dux3l7r6WmxCkX3TNRxNs2d+jXBU7dO2sffnzfesumb5Y
 2L4eYrCd3kIq/98T3npXw8x2Gi45Q/eUkwpwXjHLcKKDmPdYZPHW1ozc00cBBpWkGaoXvA1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/4/25 5:56 PM, Zhuoying Cai wrote:

> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst  | 145 +++++++++++++++++++++++++++++++
>  docs/system/s390x/secure-ipl.rst | 129 +++++++++++++++++++++++++++
>  2 files changed, 274 insertions(+)
>  create mode 100644 docs/specs/s390x-secure-ipl.rst
>  create mode 100644 docs/system/s390x/secure-ipl.rst
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> new file mode 100644
> index 0000000000..53de036dfa
> --- /dev/null
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -0,0 +1,145 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Secure IPL
> +===============
> +
> +Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
> +leverage qcrypto libraries and z/Arch implementations to verify the integrity of
> +guest kernels. These operations are rely on userspace invocations and QEMU
> +handling. The user provides one or more certificates via the command line
> +options, which populates a certificate store. DIAGNOSE 'X'320' is invoked by
> +userspace to query cert store info and retrieve specific certificates from QEMU.
> +DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to perform
> +signature-verification in QEMU. Lastly, userspace generates and appends an
> +IPL Information Report Block (IIRB) at the end of the IPL Parameter Block.
> +

Let's reword the above to:

Secure IPL (a.k.a. secure boot) enables s390-ccw virtual machines to
leverage qcrypto libraries and z/Architecture emulations to verify the
integrity of signed kernels. The qcrypto libraries are used to perform
certificate validation and signature-verification, whereas the
z/Architecture emulations are used to ensure secure IPL data has not
been tampered with, convey data between QEMU and userspace, and set up
the relevant secure IPL data structures with verification results.

To find out more about using this feature, see docs/system/s390x/secure-ipl.

Note that "userspace" will refer to the s390-ccw BIOS unless stated
otherwise.

Both QEMU and userspace work in tandem to perform secure IPL. The Secure
Loading Attributes Facility (SCLAF) is used to check the Secure Code
Loading Attribute Block (SCLAB) and ensure that secure IPL data has not
been tampered with. DIAGNOSE 'X'320' is invoked by userspace to query
the certificate store info and retrieve specific certificates from QEMU.
DIAGNOSE 'X'508' is used by userspace to leverage qcrypto libraries to
perform signature-verification in QEMU. Lastly, userspace generates and
appends an IPL Information Report Block (IIRB) at the end of the IPL
Parameter Block, which is used by the kernel to store signed and
verified entries.

The logical steps are as follows:

- Userspace reads data payload from disk (e.g. stage3 boot loader, kernel)

> +- Userspace checks the validity of the SCLAB
> +- Userspace invokes DIAG 508 subcode 1 and provides it the payload
> +- QEMU handles DIAG 508 request by reading the payload and retrieving the
> +  certificate store
> +- QEMU DIAG 508 utilizes qcrypto libraries to perform signature-verification on
> +  the payload, attempting with each cert in the store (until success or exhausted)
> +- QEMU DIAG 508 returns:
> +
> +  - success: index of cert used to verify payload
> +  - failure: error code
> +
> +- Userspace responds to this operation:
> +
> +  - on success: retrieves cert from store via DIAG 320 using returned index
> +  - on failure: reports with warning (audit mode), aborts with error (secure mode)
> +
> +- Userspace appends IIRB at the end of the IPLB
> +- Userspace kicks off IPL
> +
> +

Add:

More information regarding the respective DIAGNOSE commands and IPL data
structures are outlined within this document.

Add header:

s390 Certificate Store and Functions
====================================

> +s390 Certificate Store
> +======================

Change:

To a sub header

> +
> +Secure boot relies on user certificates for signature-verification. Normally,> +these certificates would be stored somewhere on the LPAR. Instead,
for virtual> +guests, a certificate store is implemented within QEMU.
This store will read
> +any certificates provided by the user via command-line, which are expected to
> +be stored somewhere on the host file system. Once these certificates are stored,
> +they are ready to be queried/requested by DIAGNOSE 'X'320' or used for
> +verification by DIAGNOSE 'X'508'.

Reword the above to:

A certificate store is implemented for s390-ccw guests to retain within
memory all certificates provided by the user via the command-line, which
are expected to be stored somewhere on the host's file system. The store
will keep track of the number of certificates, their respective size,
and a summation of the sizes.

> +
> +DIAGNOSE function code 'X'320' - Certificate Store Facility
> +-----------------------------------------------------------
> +
> +DIAGNOSE 'X'320' is used to provide support to query the certificate store.
> +

Reword the sentence above to:

DIAGNOSE 'X'320' is used to provide support for userspace to directly
query the s390 certificate store. Userspace may be the s390-ccw BIOS or
the guest kernel.

> +Subcode 0 - query installed subcodes
> +    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
> +    subcodes block (ISB). This mask indicates which sucodes are currently
> +    installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory needed to
> +    store one or more verification-certificates (VCs) from the certificate store (CS).
> +
> +    Upon successful completion, this subcode returns various storage size values for
> +    verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
> +
> +Subcode 2 - store verification certificates
> +    Provides VCs that are in the certificate store.
> +
> +    The output is provided in a VCB, which includes a common header followed by zero
> +    or more verification-certificate entries (VCEs).
> +
> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
> +    to be stored by subcode 2. Stored count and remained count fields specify the
> +    number of VCs stored and could not be stored in the VCB due to insufficient
> +    storage specified in the VCB input length field.
> +
> +    VCE contains various information of a VC from the CS.
> +
> +
> +Secure IPL Functions

Change to:

Secure IPL Data Structures, Facilities, and Functions

> +====================
> +
> +IPL Information Report Block
> +----------------------------
> +
> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
> +IPL Information Report Block (IIRB), which contains the results from secure IPL
> +operations such as:
> +
> +* component data
> +* verification results
> +* certificate data
> +
> +
> +Secure Code Loading Attributes Facility
> +---------------------------------
> +
> +Secure Code Loading Attributes Facility (SCLAF) provides additional security during IPL.
> +

Feedback:

Can you provide a sentence or two describing how this "provides
additional security"?  What exactly does this do?

> +When SCLAF is available, its behavior depends on the IPL Modes.
> +
> +* secure mode: IPL will terminate on any errors detected by this facility.
> +* audit mode:  IPL may proceed regardless of any errors detected by this facility.

Feedback:

These modes are described in the other document, and the error behavior
is covered there as well. You can remove the two lines above.

> +
> +Errors detected by the SCLAF are reported in IIRB.
> +
> +Unsigned components may only be loaded at absolute storage address x’2000’ or higher.
> +
> +Signed components must include a Secure Code Loading Attribute Block (SCLAB),
> +which is located at the very end of the signed component.
> +
> +**Secure Code Loading Attribute Block (SCLAB)**
> +
> +The SCLAB is located at the end of each signed component. It defines the code loading
> +attributes for the component and may:
> +
> +* Provide direction on how to process the rest of the component.
> +
> +* Provide further validation of information on where to load the signed binary code
> +  from the load device.
> +
> +* Specify where to start the execution of the loaded OS code.
> +

Feedback:

I think it reads better by simply combining the SCLAF and SCLAB sections
(i.e. no sub sub header for SCLAB).  Simply have SCLAF reference that a
SCLAB will be generated, and go into detail what it contains and what
it's for.

The SCLAF/SCLAB section is a bit difficult to digest as to what exactly
it does for secure IPL... might be a bit *too* technical :)

> +
> +DIAGNOSE function code 'X'508' - KVM IPL extensions
> +---------------------------------------------------
> +
> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
> +communication of additional IPL operations that cannot be handled by userspace,
> +such as signature verification for secure IPL.
> +
> +If the function code specifies 0x508, KVM IPL extension functions are performed.
> +These functions are meant to provide extended functionality for s390 guest boot
> +that requires assistance from QEMU.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 64-bit mask indicating which subcodes are supported.
> +
> +Subcode 1 - perform signature verification
> +    Used to perform signature-verification on a signed component, leveraging
> +    qcrypto libraries to perform this operation and pulling from the certificate
> +    store.

Reword to:

Perform signature-verification on a signed component, using certificates
from the certificate store and leveraging qcrypto libraries to perform
this operation.

> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> new file mode 100644
> index 0000000000..f94b21f9fd
> --- /dev/null
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -0,0 +1,129 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Secure IPL
> +===============
> +
> +Secure IPL, also known as secure boot, enables s390-ccw virtual machines to
> +verify the integrity of guest kernels.

Add:

For technical details of this feature, see docs/specs/s390x-secure-ipl

> +
> +This document explains how to use secure IPL with s390x in QEMU. It covers
> +new command line options for providing certificates and enabling secure IPL,
> +the different IPL modes (Normal, Audit, and Secure), and system requirements.
> +
> +A quickstart guide is provided to demonstrate how to generate certificates,
> +sign images, and start a guest in Secure Mode.
> +
> +
> +Secure IPL Command Line Options
> +===============================
> +
> +New parameters have been introduced to s390-ccw-virtio machine type option
> +to support secure IPL. These parameters allow users to provide certificates
> +and enable secure IPL directly via the command line.
> +
> +Providing Certificates
> +----------------------
> +
> +The certificate store can be populated by supplying a comma-delimited list of
> +certificates on the command-line:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio, \
> +    boot-certificates=/.../qemu/certs:/another/path/cert.der
> +
> +Enabling Secure IPL
> +-------------------
> +
> +Different IPL modes may be toggled with the following command line option:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on|off
> +
> +Additionally, the provision of certificates affect the mode.
> +
> +
> +IPL Modes
> +=========
> +
> +Normal Mode
> +-----------
> +
> +The absence of both certificates and the ``secure-boot`` option will attempt to
> +IPL a guest without secure IPL operations. No checks are performed, and no
> +warnings/errors are reported.  This is the default mode, and can be explicitly
> +enabled with ``secure-boot=off``.
> +
> +
> +Audit Mode
> +----------
> +
> +With *only* the presence of certificates in the store, it is assumed that secure
> +boot operations should be performed with errors reported as warnings. As such,
> +the secure IPL operations will be performed, and any errors that stem from these
> +operations will report a warning via the SCLP console.
> +
> +
> +Secure Mode
> +-----------
> +
> +With *both* the presence of certificates in the store and the ``secure-boot=on``
> +option, it is understood that secure boot should be performed with errors
> +reported and boot will abort.
> +
> +
> +Constraints
> +===========
> +
> +The following constraints apply when attempting to secure IPL an s390 guest:
> +
> +- z16 CPU model
> +- certificates must be in X.509 DER format
> +- only sha256 encryption is supported
> +- only support for SCSI scheme of virtio-blk/virtio-scsi devices
> +- a boot device must be specified
> +- any unsupported devices (e.g., ECKD and VFIO) or non-eligible devices (e.g.,
> +  Net) will cause the entire boot process terminating early with an error
> +  logged to the console.
> +
> +
> +Secure IPL Quickstart
> +=====================
> +
> +Build QEMU with gnutls enabled:
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via openssl):
> +
> +.. code-block:: shell
> +
> +    openssl req -new -x509 -newkey rsa:2048 -keyout mykey.priv \
> +                -outform DER -out mycert.der -days 36500 \
> +                -subj "/CN=My Name/" -nodes
> +
> +Sign Images (e.g. via sign-file):
> +
> +- signing must be performed on a KVM guest filesystem
> +- sign-file script used in the example below is located within the kernel source
> +  repo
> +
> +.. code-block:: shell
> +
> +    ./sign-file sha256 mykey.priv mycert.der /boot/vmlinuz-…
> +    ./sign-file sha256 mykey.priv mycert.der /usr/lib/s390-tools/stage3.bin
> +
> +Run zipl with secure boot enabled
> +
> +.. code-block:: shell
> +
> +    zipl --secure 1 -V
> +
> +Start Guest with Cmd Options:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certificates=mycert.der ...


-- 
Regards,
  Collin

