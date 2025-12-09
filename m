Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B39AD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSwna-00008Z-CC; Tue, 09 Dec 2025 07:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vSwnW-00005e-1S; Tue, 09 Dec 2025 07:26:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vSwnS-0005nD-JB; Tue, 09 Dec 2025 07:26:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB6D65969FE;
 Tue, 09 Dec 2025 13:26:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wmYCmwM314ZU; Tue,  9 Dec 2025 13:26:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BF95E5969F6; Tue, 09 Dec 2025 13:26:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BDBF25969F7;
 Tue, 09 Dec 2025 13:26:18 +0100 (CET)
Date: Tue, 9 Dec 2025 13:26:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 1/5] vvfat: introduce partitioned option
In-Reply-To: <CAJ307EgA88-FOPvh0vZFpfOgzgX3GoPmvFPucb1WXAZKGgf0jQ@mail.gmail.com>
Message-ID: <22357c3e-aa8c-ea5d-ec50-1ee1dfa6fd50@eik.bme.hu>
References: <20251127142417.710094-1-chigot@adacore.com>
 <20251127142417.710094-2-chigot@adacore.com>
 <baddb955-8a71-3f36-c5ce-c54ff15fdf8f@eik.bme.hu>
 <CAJ307EgA88-FOPvh0vZFpfOgzgX3GoPmvFPucb1WXAZKGgf0jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1528514626-1765283178=:66635"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1528514626-1765283178=:66635
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 9 Dec 2025, Clément Chigot wrote:
> On Thu, Nov 27, 2025 at 3:40 PM BALATON Zoltan <balaton@eik.bme.hu> 
wrote:
>>
>> On Thu, 27 Nov 2025, Clément Chigot wrote:
>>> This option tells whether the volume should be partitioned or not. Its
>>> default varies: true for hard disks and false for floppy. Its prime
>>> effect is to prevent a master boot record (MBR) to be initialized.
>>>
>>> This is useful as some operating system (QNX, Rtems) don't
>>> recognized FAT mounted disks (especially SD cards) if a MBR is present.
>>>
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>> ---
>>> block/vvfat.c        | 19 ++++++++++++++++---
>>> qapi/block-core.json | 10 +++++++---
>>> 2 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/vvfat.c b/block/vvfat.c
>>> index 814796d918..dd0b3689c1 100644
>>> --- a/block/vvfat.c
>>> +++ b/block/vvfat.c
>>> @@ -306,7 +306,8 @@ typedef struct BDRVVVFATState {
>>>     array_t fat,directory,mapping;
>>>     char volume_label[11];
>>>
>>> -    uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
>>> +    /* 0x3f for partitioned disk, 0x0 otherwise */
>>> +    uint32_t offset_to_bootsector;
>>>
>>>     unsigned int cluster_size;
>>>     unsigned int sectors_per_cluster;
>>> @@ -1082,6 +1083,11 @@ static QemuOptsList runtime_opts = {
>>>             .type = QEMU_OPT_BOOL,
>>>             .help = "Make the image writable",
>>>         },
>>> +        {
>>> +            .name = "partitioned",
>>> +            .type = QEMU_OPT_BOOL,
>>> +            .help = "Do not add a Master Boot Record on this disk",
>>
>> Maybe should say "Add MBR to disk" and not "Do not add" as that's what
>> true means now.
>>
>>> +        },
>>>         { /* end of list */ }
>>>     },
>>> };
>>> @@ -1138,7 +1144,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>>> {
>>>     BDRVVVFATState *s = bs->opaque;
>>>     int cyls, heads, secs;
>>> -    bool floppy;
>>> +    bool floppy, partitioned;
>>>     const char *dirname, *label;
>>>     QemuOpts *opts;
>>>     int ret;
>>> @@ -1165,6 +1171,9 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>>>     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
>>>     floppy = qemu_opt_get_bool(opts, "floppy", false);
>>>
>>> +    /* Hard disk are partitioned by default; floppy aren't.  */
>>
>> Singular plural mismatch. Either disks/floppies are/aren't or is/isn't
>> when singular.
>>
>>> +    partitioned = qemu_opt_get_bool(opts, "partitioned", floppy ? false : true);
>>> +
>>>     memset(s->volume_label, ' ', sizeof(s->volume_label));
>>>     label = qemu_opt_get(opts, "label");
>>>     if (label) {
>>> @@ -1196,7 +1205,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>>>         if (!s->fat_type) {
>>>             s->fat_type = 16;
>>>         }
>>> -        s->offset_to_bootsector = 0x3f;
>>>         cyls = s->fat_type == 12 ? 64 : 1024;
>>>         heads = 16;
>>>         secs = 63;
>>> @@ -1215,6 +1223,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>>>         goto fail;
>>>     }
>>>
>>> +    /* Reserver space for MBR */
>>> +    if (partitioned) {
>>> +        s->offset_to_bootsector = 0x3f;
>>> +    }
>>>
>>>     s->bs = bs;
>>>
>>> @@ -3246,6 +3258,7 @@ static const char *const vvfat_strong_runtime_opts[] = {
>>>     "floppy",
>>>     "label",
>>>     "rw",
>>> +    "partitioned",
>>
>> Does this also needs to be parsed in vvfat_parse_filename like other
>> options seem to be?
>
> It used to be the case, but I've removed that possibility in v3. This
> "vvfat_parse_filename" looks like a "hack" to ease setting vvfat
> options when instantiating such blocks through the format=raw.

If those aren't deprecated then I'd call it convenience than a hack.

> However, options can still be passed using "file." prefix. For
> example, "format=raw,file.partitioned=false" will create an
> unpartitioned vvfat block.
> Overall, I think avoiding new options in the filename is a better
> cleaner approach.

If options are possible to pass that way then omitting for some creates 
inconsistency so better be consistent unless we remove other options too. 
But I'd let the maintainer decide on this.

Regards,
BALATON Zoltan
--3866299591-1528514626-1765283178=:66635--

