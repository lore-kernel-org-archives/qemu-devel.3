Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53021D43379
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Lc-0005lr-GZ; Thu, 07 Nov 2024 11:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t95La-0005lR-Dy
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t95LY-0002z7-2x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730996818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u53bY3U/68eLN1526XkzkzM5sR31Pc0hpesglfIM5uk=;
 b=e32n9s3UQJyrq347brlz5jJ/LNyvLP125r7lqlXk8CUBwQn9y5g/a8I5y1D7SsDCHKKgi+
 qc9haGT+2miy9r9Ibh1oD8QOiRwNtd4R0uqqWtFcPKY6LLe3H9vPekzJ9jI4l788jFzZ0g
 qvoLhqxwXT0UimgQ/OzlPytse+hEQrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-lI1djnCLNoGet5_9Sr6-CQ-1; Thu, 07 Nov 2024 11:26:57 -0500
X-MC-Unique: lI1djnCLNoGet5_9Sr6-CQ-1
X-Mimecast-MFC-AGG-ID: lI1djnCLNoGet5_9Sr6-CQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a22a62e80so84723666b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730996816; x=1731601616;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u53bY3U/68eLN1526XkzkzM5sR31Pc0hpesglfIM5uk=;
 b=ONWUIS5HLTb4e0KkQ797H5JIOjJCrincaHbawdl8g1sVBUweI696w/k1J/+snM8DLf
 7BkQBEA7/ziZqGYNZzXsouH9pTV2/+QeUznV98P1I82+e+yGjYdZhvL8Ka61c0akwpG0
 fEy9NJ/6OLx2Xe8d66wfKdGe8okNA2c0s9LdjjbCiV0ZG66IYMIh+GrP+Pjl6IEPY1an
 9OjTubXg2r9spIp7JWWhk+ByFWHx9jDJK9GAD0JAIWuQHMTml0t5bnA2cSTBh8LkSKJ8
 cKAfopqf5ly4H9cPkxXDZSMTmJntlLlQS/x6+3o0sagqrKq+W+//HXRBcRzuEk2W0vgP
 W6JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+9A9th5UyTt2MfsUQvaWvEq+XxW5QTy/RDlQuLi05JzZttXOqKzHy0kAwuZJkvJAino7PUpuItxIH@nongnu.org
X-Gm-Message-State: AOJu0Ywaenr7MCKZO8UnzvESqQXXZd3OXJb8qkvWSEgFg6fnvYz4vmKS
 0iEO9wPmx29VdlhfD0AlGs7jrZ6IKkPxobMz4wnmgjl3B7tcOh74Tu3m1zdvD5S+54FR26JxyQs
 9PKwxgm1d8muUmECnasdt2juWPJPvv2litUU85xJSjyUqamLT3jRy
X-Received: by 2002:a05:600c:3c8c:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-4319ad04990mr369757595e9.28.1730996360668; 
 Thu, 07 Nov 2024 08:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG04/BHiy4OoHmdPMZWBhxmIgCNNvgMzc3SOmazZnUpIhhIGhL6VBIfY2xRa8DWHXHryNBM8w==
X-Received: by 2002:a05:600c:3c8c:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-4319ad04990mr369757335e9.28.1730996360146; 
 Thu, 07 Nov 2024 08:19:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9?
 (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de.
 [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c1f56sm29429455e9.34.2024.11.07.08.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 08:19:19 -0800 (PST)
Message-ID: <715ddc40-dbce-434d-ab2c-4d4424561f37@redhat.com>
Date: Thu, 7 Nov 2024 17:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
 <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 07.11.24 15:04, Steven Sistare wrote:
> On 11/7/2024 8:05 AM, David Hildenbrand wrote:
>> On 06.11.24 21:59, Steven Sistare wrote:
>>> On 11/6/2024 3:41 PM, Peter Xu wrote:
>>>> On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
>>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>>
>>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>>
>>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>>
>>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>>> details. See below.
>>>>>>>>>>
>>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>>
>>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>>
>>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>>
>>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>>
>>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>>
>>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>>
>>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>
>>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>>
>>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>>
>>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>>> -- memfd if available and fallback to shm_open.
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>
>>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>>
>>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>>
>>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>>
>>>>>>>> Thoughts?
>>>>>>>
>>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>>> of options and words to describe them.
>>>>>>
>>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>>
>>>>> Hi David and Peter,
>>>>>
>>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>>> for simplicity.
>>>>
>>>> I'm ok with either shm or memfd, as this feature only applies to Linux
>>>> anyway.  I'll leave that part to you and David to decide.
>>>>
>>>>>
>>>>> Any comments before I submit a complete patch?
>>>>>
>>>>> ----
>>>>> qemu-options.hx:
>>>>>        ``aux-ram-share=on|off``
>>>>>            Allocate auxiliary guest RAM as an anonymous file that is
>>>>>            shareable with an external process.  This option applies to
>>>>>            memory allocated as a side effect of creating various devices.
>>>>>            It does not apply to memory-backend-objects, whether explicitly
>>>>>            specified on the command line, or implicitly created by the -m
>>>>>            command line option.
>>>>>
>>>>>            Some migration modes require aux-ram-share=on.
>>>>>
>>>>> qapi/migration.json:
>>>>>        @cpr-transfer:
>>>>>             ...
>>>>>             Memory-backend objects must have the share=on attribute, but
>>>>>             memory-backend-epc is not supported.  The VM must be started
>>>>>             with the '-machine aux-ram-share=on' option.
>>>>>
>>>>> Define RAM_PRIVATE
>>>>>
>>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>>
>>>>> ram_backend_memory_alloc()
>>>>>        ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>>        memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>
>>>> Looks all good until here.
>>>>
>>>>>
>>>>> qemu_ram_alloc_internal()
>>>>>        ...
>>>>>        if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>
>>>> Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
>>>> that's equal to RAM_PREALLOC.
>>>
>>> IMO testing host is clearer and more future proof, regardless of how flags
>>> are currently used.  If the caller passes host, then we should not allocate
>>> memory here, full stop.
>>>
>>>> Meanwhile I slightly prefer we don't touch
>>>> anything if SHARED|PRIVATE is set.
>>>
>>> OK, if SHARED is already set I will not set it again.
>>
>> We only have to make sure that stuff like qemu_ram_is_shared() will continue working as expected.
>>
>> What I think we should do:
>>
>> We should probably assert that nobody passes in SHARED|PRIVATE. And we can use PRIVATE only as a parameter to the function, but never actually set it on the ramblock.
>>
>> If someone passes in PRIVATE, we don't include it in block->flags. (RMA_SHARED remains cleared)
>>
>> If someone passes in SHARED, we do set it in block->flags.
>> If someone passes PRIVATE|SHARED, we assert.
>>
>> If someone passes in nothing: we set block->flags to SHARED with aux_ram_share=on. Otherwise, we do nothing (RAM_SHARED remains cleared)
>>
>> If that's also what you had in mind, great.
> 
> Yes, my patch does that, but it also sets RAM_PRIVATE on the ramblock.
> I will undo the latter.
> 
> Do you plan to submit the part of your "tmp" patch that refactors
> shm_backend_memory_alloc and defines qemu_shm_alloc?  If you want,
> I could include it in my series, with your Signed-off-by.

My patch went a bit too far I think. And would not work on win32 :)

We should probably start with this:


 From 124920aeda2756faa104bfa6e934c7c20b1fbbe9 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 4 Nov 2024 11:29:22 +0100
Subject: [PATCH] backends/hostmem-shm: factor out allocation of "anonymous
  shared memory with an fd"

Let's factor it out so we can reuse it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  backends/hostmem-shm.c | 45 ++++-------------------------------
  include/qemu/osdep.h   |  1 +
  system/physmem.c       |  2 +-
  util/oslib-posix.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
  util/oslib-win32.c     |  6 +++++
  5 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 374edc3db8..837b9f1dd4 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -25,11 +25,9 @@ struct HostMemoryBackendShm {
  static bool
  shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
  {
-    g_autoptr(GString) shm_name = g_string_new(NULL);
      g_autofree char *backend_name = NULL;
      uint32_t ram_flags;
-    int fd, oflag;
-    mode_t mode;
+    int fd;
  
      if (!backend->size) {
          error_setg(errp, "can't create shm backend with size 0");
@@ -41,48 +39,13 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
          return false;
      }
  
-    /*
-     * Let's use `mode = 0` because we don't want other processes to open our
-     * memory unless we share the file descriptor with them.
-     */
-    mode = 0;
-    oflag = O_RDWR | O_CREAT | O_EXCL;
-    backend_name = host_memory_backend_get_name(backend);
-
-    /*
-     * Some operating systems allow creating anonymous POSIX shared memory
-     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
-     * defined by POSIX, so let's create a unique name.
-     *
-     * From Linux's shm_open(3) man-page:
-     *   For  portable  use,  a shared  memory  object should be identified
-     *   by a name of the form /somename;"
-     */
-    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
-                    backend_name);
-
-    fd = shm_open(shm_name->str, oflag, mode);
+    fd = qemu_shm_alloc(backend->size, errp);
      if (fd < 0) {
-        error_setg_errno(errp, errno,
-                         "failed to create POSIX shared memory");
-        return false;
-    }
-
-    /*
-     * We have the file descriptor, so we no longer need to expose the
-     * POSIX shared memory object. However it will remain allocated as long as
-     * there are file descriptors pointing to it.
-     */
-    shm_unlink(shm_name->str);
-
-    if (ftruncate(fd, backend->size) == -1) {
-        error_setg_errno(errp, errno,
-                         "failed to resize POSIX shared memory to %" PRIu64,
-                         backend->size);
-        close(fd);
          return false;
      }
  
+    /* Let's do the same as memory-backend-ram,share=on would do. */
+    backend_name = host_memory_backend_get_name(backend);
      ram_flags = RAM_SHARED;
      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
  
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fe7c3c5f67..4a24f11174 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -505,6 +505,7 @@ int qemu_daemon(int nochdir, int noclose);
  void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
                            bool noreserve);
  void qemu_anon_ram_free(void *ptr, size_t size);
+int qemu_shm_alloc(size_t size, Error **errp);
  
  #ifdef _WIN32
  #define HAVE_CHARDEV_SERIAL 1
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..1b477fec44 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2089,7 +2089,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
      new_block->page_size = qemu_real_host_page_size();
      new_block->host = host;
      new_block->flags = ram_flags;
-    ram_block_add(new_block, &local_err);
+
      if (local_err) {
          g_free(new_block);
          error_propagate(errp, local_err);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 11b35e48fb..bc5c28b162 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -931,3 +931,56 @@ void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
          qemu_close_all_open_fd_fallback(skip, nskip, open_max);
      }
  }
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+    int fd, oflag, cur_sequence;
+    static int sequence;
+    mode_t mode;
+
+    cur_sequence = qatomic_fetch_inc(&sequence);
+
+    /*
+     * Let's use `mode = 0` because we don't want other processes to open our
+     * memory unless we share the file descriptor with them.
+     */
+    mode = 0;
+    oflag = O_RDWR | O_CREAT | O_EXCL;
+
+    /*
+     * Some operating systems allow creating anonymous POSIX shared memory
+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
+     * defined by POSIX, so let's create a unique name.
+     *
+     * From Linux's shm_open(3) man-page:
+     *   For  portable  use,  a shared  memory  object should be identified
+     *   by a name of the form /somename;"
+     */
+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%d", getpid(),
+                    cur_sequence);
+
+    fd = shm_open(shm_name->str, oflag, mode);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create POSIX shared memory");
+        return -1;
+    }
+
+    /*
+     * We have the file descriptor, so we no longer need to expose the
+     * POSIX shared memory object. However it will remain allocated as long as
+     * there are file descriptors pointing to it.
+     */
+    shm_unlink(shm_name->str);
+
+    if (ftruncate(fd, size) == -1) {
+        error_setg_errno(errp, errno,
+                         "failed to resize POSIX shared memory to %" PRIu64,
+                         size);
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b623830d62..f79a190b78 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -877,3 +877,9 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
      }
      CloseHandle(h);
  }
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    error_setg("Shared memory is not supported.");
+    return -1;
+}
-- 
2.47.0


So we can reuse it for the !host && RAM_SHARED case.


> 
> Do you have any comments on my proposed name aux-ram-share, or my proposed text

aux-ram-share works for me, I prefer "aux" over the "default" I had in mind.

> for qemu-options.hx and migration.json?  Speaking now would prevent more version
> churn later.

Both sounds good to me after a quick scan.


-- 
Cheers,

David / dhildenb


