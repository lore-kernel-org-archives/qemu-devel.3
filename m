Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C26CF0427
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHow-0007Bz-G2; Tue, 08 Oct 2024 17:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syHor-0007BZ-Vt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syHop-0001fz-5U
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728423153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tAMVPS2am1yS4o13xkzW5mLz4awcRKd6jCjWOyzywo=;
 b=Ft3OV3Db88Np8UnSec5AgSbcE1OF0l3ugzeI5DsaF3LvrTUOc56W5ARYIPFtfrUIztCz6h
 1IGE2Rue+7xVvSmlOTQ1fK7y7qPs/KWZL3mLV82zdi13qKcq9mQ0HNHCany2Itrqzl8N7F
 qzMbSTTmw5Qk+7k4sJHlqPQiui1O7sw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-L5fkoqC-NfWPylVrDc7mew-1; Tue, 08 Oct 2024 17:32:31 -0400
X-MC-Unique: L5fkoqC-NfWPylVrDc7mew-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a3466d220dso63482835ab.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728423151; x=1729027951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tAMVPS2am1yS4o13xkzW5mLz4awcRKd6jCjWOyzywo=;
 b=eQnpUtb+Dg8F+b61wwFzl2o36ti/YiTCpAUF+k+QH3G303KOEVSz1qwUjI7u3uPlMW
 WLXdDW4pnPzAW02Q9XBAJ4wtgJmiMkgWLsssXWoKqe02KbY7NPqUumIYsOqQXHm8I3bo
 B6eOEDMNis+Bz46PDIGIa6KttnJ3eZJFtks6WoFmbn6fe+YLQ4heWYsyf3zcIO/vVw7C
 M0nMSEDaLOvDDqctqYXcyHih0c/50pTToEGkQHRJUGn5UbjnCzNItYlHh4gD8o+n0mTN
 oVq/yL+F6JtS3HUf8Ez3f8ejVlNzLoAWEPVPV6tgF3lD2cmeQZ1lMumn8hUAjEa7eauZ
 TTJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxtmBOXN+ZnN1MHHDd7uXT97aw+m6wKbTZMMcOdunINowINNVR93R3nKlhWPzvEt9iFOfiVtawIWDA@nongnu.org
X-Gm-Message-State: AOJu0YzR7K4OUCplQcLloE2nNwpf+rnwj37s3sC/bUn68VvwJOn68Qy/
 3+PnXY7kOrABBOC7y6twwT270k1ZZn1LvhQfhIza/7KoNKVvrB1v+yYky5Nw5PT5W/sEbsPHhO9
 zmzOgs3kHtJzvg3Ud8SACMgiX+hcDUKdgBWaNodoZ83zg+J+v8zSv
X-Received: by 2002:a05:6e02:19ca:b0:3a0:b384:219b with SMTP id
 e9e14a558f8ab-3a397d33562mr3267785ab.26.1728423150980; 
 Tue, 08 Oct 2024 14:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGElKKzzkMNUSwsoLWLWcZCwJu3djEykh/IWuby15UHHonX2z+RiNL4CioheutxDO2Obd/xQw==
X-Received: by 2002:a05:6e02:19ca:b0:3a0:b384:219b with SMTP id
 e9e14a558f8ab-3a397d33562mr3267605ab.26.1728423150578; 
 Tue, 08 Oct 2024 14:32:30 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db94cb82d9sm561147173.75.2024.10.08.14.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:32:30 -0700 (PDT)
Date: Tue, 8 Oct 2024 17:32:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
Message-ID: <ZwWk66RpczCpejhx@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
 <ZwQDBc-8niK2A0Vt@x1n> <ZwQMRlSSqP0i0ITb@x1n>
 <025423a6-8cf8-4300-91f2-13be32ec2c5c@oracle.com>
 <ZwVdGZtmZ27tX6gS@x1n>
 <22321990-d30d-4ab7-8c3b-f2baea662d7c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22321990-d30d-4ab7-8c3b-f2baea662d7c@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 08, 2024 at 05:05:01PM -0400, Steven Sistare wrote:
> On 10/8/2024 12:26 PM, Peter Xu wrote:
> > On Tue, Oct 08, 2024 at 11:17:46AM -0400, Steven Sistare wrote:
> > > On 10/7/2024 12:28 PM, Peter Xu wrote:
> > > > On Mon, Oct 07, 2024 at 11:49:25AM -0400, Peter Xu wrote:
> > > > > On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
> > > > > > Save the memfd for anonymous ramblocks in CPR state, along with a name
> > > > > > that uniquely identifies it.  The block's idstr is not yet set, so it
> > > > > > cannot be used for this purpose.  Find the saved memfd in new QEMU when
> > > > > > creating a block.  QEMU hard-codes the length of some internally-created
> > > > > > blocks, so to guard against that length changing, use lseek to get the
> > > > > > actual length of an incoming memfd.
> > > > > > 
> > > > > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > > > > ---
> > > > > >    system/physmem.c | 25 ++++++++++++++++++++++++-
> > > > > >    1 file changed, 24 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/system/physmem.c b/system/physmem.c
> > > > > > index 174f7e0..ddbeec9 100644
> > > > > > --- a/system/physmem.c
> > > > > > +++ b/system/physmem.c
> > > > > > @@ -72,6 +72,7 @@
> > > > > >    #include "qapi/qapi-types-migration.h"
> > > > > >    #include "migration/options.h"
> > > > > > +#include "migration/cpr.h"
> > > > > >    #include "migration/vmstate.h"
> > > > > >    #include "qemu/range.h"
> > > > > > @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
> > > > > >        }
> > > > > >    }
> > > > > > +static char *cpr_name(RAMBlock *block)
> > > > > > +{
> > > > > > +    MemoryRegion *mr = block->mr;
> > > > > > +    const char *mr_name = memory_region_name(mr);
> > > > > > +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> > > > > > +
> > > > > > +    if (id) {
> > > > > > +        return g_strdup_printf("%s/%s", id, mr_name);
> > > > > > +    } else {
> > > > > > +        return g_strdup(mr_name);
> > > > > > +    }
> > > > > > +}
> > > > > > +
> > > > > >    size_t qemu_ram_pagesize(RAMBlock *rb)
> > > > > >    {
> > > > > >        return rb->page_size;
> > > > > > @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> > > > > >                                            TYPE_MEMORY_BACKEND)) {
> > > > > >                size_t max_length = new_block->max_length;
> > > > > >                MemoryRegion *mr = new_block->mr;
> > > > > > -            const char *name = memory_region_name(mr);
> > > > > > +            g_autofree char *name = cpr_name(new_block);
> > > > > >                new_block->mr->align = QEMU_VMALLOC_ALIGN;
> > > > > >                new_block->flags |= RAM_SHARED;
> > > > > > +            new_block->fd = cpr_find_fd(name, 0);
> > > > > >                if (new_block->fd == -1) {
> > > > > >                    new_block->fd = qemu_memfd_create(name, max_length + mr->align,
> > > > > >                                                      0, 0, 0, errp);
> > > > > > +                cpr_save_fd(name, 0, new_block->fd);
> > > > > > +            } else {
> > > > > > +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
> > > > > 
> > > > > So this can overwrite the max_length that the caller specified..
> > > > > 
> > > > > I remember we used to have some tricks on specifying different max_length
> > > > > for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
> > > > > host so the size can be bigger than src qemu's old ramblocks), so that the
> > > > > MR is always large enough to reload even the new firmwares, while migration
> > > > > only migrates the smaller size (used_length) so it's fine as we keep the
> > > > > extra sizes empty. I think that can relevant to the qemu_ram_resize() call
> > > > > of parse_ramblock().
> > > 
> > > Yes, resizable ram block for firmware blob is the only case I know of where
> > > the length changed in the past.  If a length changes in the future, we will
> > > need to detect and accommodate that change here, and I believe the fix will
> > > be to simply use the actual length, as per the code above.  But if you prefer,
> > > for now I can check for length change and return an error. New qemu will fail
> > > to start, and old qemu will recover.
> > > 
> > > > > The reload will not happen until some point, perhaps system resets.  I
> > > > > wonder whether that is an issue in this case.
> > > 
> > > Firmware is only generated once, via this path on x86:
> > >    qmp_x_exit_preconfig
> > >      qemu_machine_creation_done
> > >        qdev_machine_creation_done
> > >          pc_machine_done
> > >            acpi_setup
> > >              acpi_add_rom_blob
> > >                rom_add_blob
> > >                  rom_set_mr
> > > 
> > > After a system reset, the ramblock contents from memory are used as-is.
> > > 
> > > > PS: If this is needed by CPR-transfer only because mmap() later can fail
> > > > due to a bigger max_length,
> > > 
> > > That is the reason.  IMO adjusting max_length is more robust than fiddling
> > > with truncate and pretending that max_length is larger, when qemu will never
> > > be able to use the phantom space up to max_length.
> > 
> > I thought it was not pretending, but the ROM region might be resized after
> > a system reset?  I worry that your change here can violate with such
> > resizing later, so that qemu_ram_resize() can potentially fail after (1)
> > CPR-transfer upgrades completes, then follow with (2) a system reset.
> > 
> > We can observe such resizing kick off in every reboot, like:
> > 
> > (gdb) bt
> > #0  qemu_ram_resize
> > #1  0x00005602b623b740 in memory_region_ram_resize
> > #2  0x00005602b60f5580 in acpi_ram_update
> > #3  0x00005602b60f5667 in acpi_build_update
> > #4  0x00005602b5e1028b in fw_cfg_select
> > #5  0x00005602b5e105af in fw_cfg_dma_transfer
> > #6  0x00005602b5e109a8 in fw_cfg_dma_mem_write
> > #7  0x00005602b62352ec in memory_region_write_accessor
> > #8  0x00005602b62355e6 in access_with_adjusted_size
> > #9  0x00005602b6238de8 in memory_region_dispatch_write
> > #10 0x00005602b62488c5 in flatview_write_continue_step
> > #11 0x00005602b6248997 in flatview_write_continue
> > #12 0x00005602b6248abf in flatview_write
> > #13 0x00005602b6248f39 in address_space_write
> > #14 0x00005602b6248fb1 in address_space_rw
> > #15 0x00005602b62a5d86 in kvm_handle_io
> > #16 0x00005602b62a6cb2 in kvm_cpu_exec
> > #17 0x00005602b62aa37a in kvm_vcpu_thread_fn
> > #18 0x00005602b655da57 in qemu_thread_start
> > #19 0x00007f120224a1b7 in start_thread
> > #20 0x00007f12022cc39c in clone3
> > 
> > Specifically, see this code clip:
> > 
> > acpi_ram_update():
> >      memory_region_ram_resize(mr, size, &error_abort);
> >      memcpy(memory_region_get_ram_ptr(mr), data->data, size);
> > 
> > Per my understanding, what it does is during the reset the ROM ramblock
> > will resize to the new size (normally, only larger, in my memory there used
> > to have a ROM grew from 256K->512K, or something like that), then the
> > memcpy() injects the latest firmware that it pre-loaded into mem.
> > 
> > So after such system reset, QEMU might start to see new ROM code loaded
> > here (not the one that got migrated anymore, which will only match the
> > version installed on src QEMU).  Here the problem is the new firmware can
> > be larger, so I _think_ we need to make sure max_length is not modified by
> > CPR to allow resizing happen here, while if we use truncate=true here it
> > should just work in all cases.
> > 
> > I think it could be verified with an old QEMU running with old ROM files
> > (which is smaller), then CPR migrate to a new QEMU running new ROM files
> > (which is larger), then reboot to see whether that new QEMU crash.  Maybe
> > we can emulate that with "romfile=XXX" parameter.
> > 
> > I am not fluent with ROM/firmware code, but please double check..
> 
> Thank you for the detailed analysis, I was completely wrong on this one :(
> 
> I also keep forgetting that ftruncate can grow as well as shrink a file.
> I agree that preserving the dest qemu max_length, and using ftruncate, is the
> correct solution, as long as dest max_length >= source max_length.
> 
> However, IMO the extra memory created by ftruncate also needs to be pinned for DMA.
> We disagreed on exactly what blocks needs to be pinned in previous discussions,
> and to save time I would rather not re-open that debate right now.  Instead, I propose
> to simply require that max_length does not change, and return an error if it does.
> If it changes in some future qemu, we can reopen the discussion.

Hmm.. why the extra memory needs to be pinned?

From QEMU memory topology POV, anything more than used_length is not
visible to the guest, afaict.

In this specific ROM example, qemu_ram_resize() on src QEMU will first
resize the ramblock (updating used_length), then set that exact same size
with memory_region_set_size() to the MR with the size of the smaller
firmware size when src QEMU boots:

qemu_ram_resize():
    unaligned_size = newsize;
    ...
    newsize = TARGET_PAGE_ALIGN(newsize);
    newsize = REAL_HOST_PAGE_ALIGN(newsize);
    ...
    block->used_length = newsize;
    ...
    memory_region_set_size(block->mr, unaligned_size);

Here a tiny detail is the two sizes are slightly different, but the MR size
is even smaller than used_length.  The MR size decides what can be visible
to the guest, when the MR that owns the ROM file is mapped into GPA range.
That's true on the src, while after CPR migrates to dest that should still
hold true, afaict, as all the rest memory (used->max) is not yet used
before a system reset.

The extra memory (used->max) can be relevant only after a system reset,
when the new firmware will be loaded, and qemu_ram_resize() can indeed
extend that MR to cover more than before.  However that should be fine too
because that means guest memory is being rebuilt, so VFIO memory listeners
should do the right things (unpin old, repin the new ROM that is larger
this time), iiuc.

-- 
Peter Xu


