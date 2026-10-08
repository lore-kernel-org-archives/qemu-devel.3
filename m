Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C205CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnSL-0006jz-NI; Thu, 08 Oct 2026 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEnSJ-0006jS-Hn; Thu, 08 Oct 2026 08:42:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xEnSH-0007ND-1I; Thu, 08 Oct 2026 08:42:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 324A9583355;
 Thu, 08 Oct 2026 14:42:31 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yrY_p_b12hGu; Thu,  8 Oct 2026 14:42:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9FAEA5831F1; Thu, 08 Oct 2026 14:42:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D1B75831F0;
 Thu, 08 Oct 2026 14:42:28 +0200 (CEST)
Date: Thu, 8 Oct 2026 14:42:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Utkarsh Verma <uverma@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com, 
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, pbonzini@redhat.com, 
 th.huth@posteo.eu, sbhat@linux.ibm.com, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, rathc@linux.ibm.com, philmd@linaro.org, 
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net, 
 alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v2 5/8] ppc/spapr: add block device backend to VOF
 open/read/write/seek services
In-Reply-To: <b82de4bb-9957-49d6-8858-21a949cd7d47@linux.ibm.com>
Message-ID: <dcf6e003-fe36-ddce-564f-94d6cbf37e35@eik.bme.hu>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-6-uverma@linux.ibm.com>
 <ae59611f-fede-edf8-3824-ea04671276a9@eik.bme.hu>
 <b82de4bb-9957-49d6-8858-21a949cd7d47@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1313277333-1791462576=:68168"
Content-ID: <03b2c7ca-99f6-6009-9927-ee51011635fc@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1313277333-1791462576=:68168
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <588fe367-d120-dcbb-a872-dba552270855@eik.bme.hu>

Hello,

On Thu, 8 Oct 2026, Utkarsh Verma wrote:
[...]
>>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>>> index 6f6d424347..d4b57b3b46 100644
>>> --- a/hw/ppc/vof.c
>>> +++ b/hw/ppc/vof.c
>>> @@ -11,6 +11,7 @@
>>> 
>>> #include CONFIG_DEVICES /* CONFIG_PSERIES */
>>> #include "qemu/osdep.h"
>>> +#include "qemu/cutils.h"
>>> #include "qemu/ctype.h"
>>> #include "qemu/timer.h"
>>> #include "qemu/range.h"
>>> @@ -25,6 +26,9 @@
>>> #include "trace.h"
>>> 
>>> #include "hw/ppc/spapr_vio.h"
>>> +#include "hw/scsi/scsi.h"
>>> +#include "system/block-backend.h"
>>> +#include "block/block-io.h"
>>> #include <libfdt.h>
>>> 
>>> /*
>>> @@ -38,6 +42,7 @@
>>> #define VOF_MAX_METHODLEN   256
>>> #define VOF_MAX_FORTHCODE   256
>>> #define VOF_VTY_BUF_SIZE    256
>>> +#define VOF_BLK_BUF_SIZE    (64 * 1024)
>> 
>> * KiB instead of 1024?
>> 
> Sure, will use KiB and fix it for SPAPR_VOF_PREP_MAX_SIZE in spapr_vof.c as 
> well in v3.

Sorry for taking that long to review which caused you needing to prepare 
another version but I have little time for QEMU now and generally don't 
like to be first to review AI generated patches so I hoped somebody else 
could do a review. Since the list is already high volume, if you agree 
with a change it's OK to just include it in next version and you don't 
have to reply for those with "OK, I'll do that" here, unless you have a 
comment or question about it or answering a question asked.

>>> 
>>> typedef struct {
>>>     uint64_t start;
>>> @@ -47,6 +52,8 @@ typedef struct {
>>> typedef struct {
>>>     char *path; /* the path used to open the instance */
>>>     uint32_t phandle;
>>> +    BlockBackend *blk;
>>> +    uint64_t pos; /* current position for seek operations */
>>>     void *vty;
>>> } OfInstance;
>>> 
>>> @@ -138,6 +145,8 @@ static int path_offset(const void *fdt, const char 
>>> *path)
>>> {
>>>     g_autofree char *p = NULL;
>>>     char *at;
>>> +    char *last_slash;
>>> +    int offset;
>>> 
>>>     /*
>>>      * https://www.devicetree.org/open-firmware/bindings/ppc/release/ 
>>> ppc-2_1.html#HDR16
>>> @@ -156,7 +165,76 @@ static int path_offset(const void *fdt, const char 
>>> *path)
>>>             }
>>>     }
>>> 
>>> -    return fdt_path_offset(fdt, p);
>>> +    offset = fdt_path_offset(fdt, p);
>>> +    if (offset >= 0) {
>>> +        return offset;
>>> +    }
>>> +
>>> +    /*
>>> +     * Apply the OF wildcard rule for vSCSI disk paths. A path ending in
>>> +     * disk@<srp-lun> has no per-LUN FDT node, instead the FDT contains a 
>>> single
>>> +     * generic "disk" child (no srp-lun appended to the path). The 
>>> phandle is
>>> +     * shared by all LUNs on the adapter, matching the Open Firmware 
>>> behaviour.
>>> +     */
>>> +    last_slash = strrchr(p, '/');
>>> +    if (last_slash && strncmp(last_slash + 1, "disk@", 5) == 0) {
>>> +        int parent_off;
>>> +
>>> +        *last_slash = '\0';
>>> +        parent_off = fdt_path_offset(fdt, p);
>>> +        if (parent_off >= 0) {
>>> +            int child_off = fdt_subnode_offset(fdt, parent_off, "disk");
>> 
>> I'm not sure how this should work but what if there are multiple disk nodes 
>> such as disk@0 disk@1 or similar? Should this look for the original ending 
>> of the path instead of just "disk"?
>> 
> There is only one "disk" child node under the vSCSI adapter regardless of how 
> many physical disks are attached. It seems a little weird that only one disk 
> node is created even for multiple vSCSI disks, but that is the actual open 
> firmware behaviour, I cross checked with the device tree data on a pseries 
> LPAR machine and with the SLOF implementation of it as well.
> So, the GRUB only searches for a "disk" child node under the vscsi adapter 
> and then calls the vscsi-report-luns method to get the full path of the 
> individual disks and passes the same path to firmware while calling open. So, 
> GRUB doesn't rely on FDT disk data to search the disk, it calls the 
> vscs-report-luns method to get the full disk path.
> This is why I strip the @<srp-lun> part in the path before searching the FDT, 
> the node it needs to resolve to is always the shared "disk" child node.

We're in in the common vof.c file here which is a generic OpenFirmware 
implementation and is shared with pegasos (and later could be used by 
other machines needing OpenFirmware). On pegasos2 for example we can have 
/pci/ide/disk@0,0, /pci/ide/disk@0,1, /pci/ide/disk@1,0 and 
/pci/ide/disk@1,1 for 4 IDE disks so this change may break clients 
accessing those device nodes. So likely you need to avoid changing this 
function but maybe by moving all the other stuff to spapr_vof.c this will 
not be needed here any more and can be handled in spapr_vof.c. If you find 
you're trying to change vof.c for something specific to spapr then think 
again because anything spapr specific should be in spapr_vof.c.

I've also noticed pegasos1 sets boot-device to /pci/ide/disk@0,0:0 where 
:0 is showing the partition so that is a generic OF thing that could be 
handled here in vof.c but that could be fixed later as well. To make it 
easy to use this block device support by other machines in the future, the 
functions to be added to VofMachineIfClass should be chosen to do the 
machine specific mapping between OpenFirmware nodes to generic QEMU 
constructs and then the code here can work on those without needing to be 
machine specific. E.g. I'm not sure requiring machines to implement 
vty_open/read/write is necessary and if it could be done more generically 
with just one function mapping an OF device node to something that can be 
used here like for block device the mapping function returns a blk device 
for an OF device node. That would also make machine code simpler as it 
does not have to talk to the device just return the QEMU struct to vof and 
reduce code duplication between machines. But I don't know what would be 
the right QEMU construct for a vty, maybe a chardev?

Regards,
BALATON Zoltan
--3866299591-1313277333-1791462576=:68168--

