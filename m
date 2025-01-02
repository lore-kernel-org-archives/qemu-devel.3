Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C7BE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTHu-0002n1-Rh; Thu, 02 Jan 2025 17:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTTHs-0002ml-QY
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTTHp-00067g-WD
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735855403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Qws+P/M9Q7BTCBMYBkPdKdi2XbzEaAz8RXEx6A39gA=;
 b=RHpPqin/NevGj5LUIv7akMgBKDS5Gx51PW64cmIaee8Gu5kOmuaFFM4wpbeJ8vPXu/XJC/
 Ofj8BFLNP9AJcUW6OfCbU1ucFWjgeRRJtlTdgpzTtIHZ8WNOrxBr1yOtrO69iEf4hyCf8d
 Zud5mhhVDqzB6FeEi4fgthfpTIBn8E8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-mYE85iYVPYOYTtxhOzwcuA-1; Thu, 02 Jan 2025 17:03:21 -0500
X-MC-Unique: mYE85iYVPYOYTtxhOzwcuA-1
X-Mimecast-MFC-AGG-ID: mYE85iYVPYOYTtxhOzwcuA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4679d6ef2f9so318107361cf.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 14:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735855400; x=1736460200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Qws+P/M9Q7BTCBMYBkPdKdi2XbzEaAz8RXEx6A39gA=;
 b=GSe7fpBF50FfmUEjGvRwN1odVzEvBnstxNejTdKrFZPoLSe4MooTuVdHcY3+Kokcxf
 tqS7sA3vojmTloiZUN9bu3eaSOSaeKln7XUgGnyxX/ZkLHtU4XWbnt6NvWiSOaVKRTFL
 9ypJPE2i4tUg/m07aSPpCei1NGUo1aE1n1DYbcAY3KPP7o/ZBONxEiC6APBgAk7G+fXv
 OFiCGf+5K7onqY2krFj9AiddnB3N31ZWl+mcBC5ySSMh5xgZxPN/rXpJItaWgzkTvmAi
 0j2xE6TOSQWTpGNz/jP/p1USrKByvhDFbFVVB9KZre9nCwOZUVViiTOBMhyazwtvNZt1
 8f7A==
X-Gm-Message-State: AOJu0Yxh/pRmHzSpRhxQuXwnzun4TMTA0NmsqZyiWYB9jrCGZTvLyTGK
 ng+rckEI1DJ/5HQ0WcsXJwZyF5JoDL/384Wn3vZVFNV6OGC87C26AgZAzbj+GXo+DJ983QqfEFJ
 1F7sX254I7MMHvLLUo+PUbB/YUV5q3SDfX14rOgRZKarf93DOmU/K
X-Gm-Gg: ASbGnctIcu+dum1HqtZ/PC5f5ONv+01Wfb+FtEKvvwluoW3PDGEzOBuwA9F5GdmFcsR
 5eA+h0fGp8JnfaZK0emjkGthTWXsYSPlm2iADMdejxoW+fytF3cSfyG67PalFiZ2LDwxtFb17Qg
 lK96x0SL1i41REJojBVdYYXv9pAmNdOQMDFKM7XmWGCb702OMNFoowx1IPK3fWlZMh2k9jkFI19
 1NAUO/n6SG0dUCPJYsaZBr1QOlWTCuuEIN4ur4a0y/5Hz22pyW9AvJUgWme7hbTV8nEtzPE/aVF
 +dcUPBKxo38CUQaOEw==
X-Received: by 2002:a05:622a:1315:b0:461:253e:cb8b with SMTP id
 d75a77b69052e-46a4a9708ffmr787518131cf.35.1735855400501; 
 Thu, 02 Jan 2025 14:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCsbAaQKPYGpkDI9DBdqIa6mUPpT1ewHNWL+AG+HNNlnsVyp6kCrzau4s6UKyndQbjYsm+Nw==
X-Received: by 2002:a05:622a:1315:b0:461:253e:cb8b with SMTP id
 d75a77b69052e-46a4a9708ffmr787517751cf.35.1735855400118; 
 Thu, 02 Jan 2025 14:03:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6a1283sm139368041cf.40.2025.01.02.14.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 14:03:19 -0800 (PST)
Date: Thu, 2 Jan 2025 17:03:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] migration: Add more error handling to analyze-migration.py
Message-ID: <Z3cNJZ0inEMRSitV@x1n>
References: <20250102185831.4324-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102185831.4324-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 02, 2025 at 03:58:31PM -0300, Fabiano Rosas wrote:
> The analyze-migration script was seen failing in s390x in misterious
> ways. It seems we're reaching the subsection constructor without any

It might be a good idea to add some debug lines indeed. Though are you sure
it's from parsing a subsection?

https://lore.kernel.org/all/20241219123213.GA692742@fedora/

====8<====
stderr:
Traceback (most recent call last):
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
    dump.read(dump_memory = args.memory)
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
    section.read()
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
    field['data'] = reader(field, self.file)
  File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
    for field in self.desc['struct']['fields']:
KeyError: 'fields'
====8<====

It reads to me that it's not in "if 'subsections' in self.desc['struct']"
loop yet, instead it looks like a real STRUCT field in one of the device
sections?  If that's true, then...

> fields, which would indicate an empty .subsection entry in the vmstate
> definition. We don't have any of those, at least not without the
> unmigratable flag set, so this should never happen.
> 
> Add some debug statements so that we can see what's going on the next
> time the issue happens.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  scripts/analyze-migration.py | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 8a254a5b6a..1dd98f1d5a 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -429,6 +429,10 @@ def __init__(self, desc, file):
>          super(VMSDFieldStruct, self).__init__(desc, file)
>          self.data = collections.OrderedDict()
>  
> +        if 'fields' not in self.desc['struct']:
> +            raise Exception("No fields in subsection key=%s name=%s" %
> +                            (self.section_key, self.vmsd_name))

... this self.section_key / self.vmsd_name may not exist..

In all cases, IMHO this would be better the debug lines work with both pure
structs and sections.

> +
>          # When we see compressed array elements, unfold them here
>          new_fields = []
>          for field in self.desc['struct']['fields']:
> @@ -477,6 +481,11 @@ def read(self):
>                      raise Exception("Subsection %s not found at offset %x" % ( subsection['vmsd_name'], self.file.tell()))
>                  name = self.file.readstr()
>                  version_id = self.file.read32()
> +
> +                if not subsection:
> +                    raise Exception("Empty description for subsection %s" %
> +                                    name)

This is checking subsection==None??  I doubt whether this will hit..

> +
>                  self.data[name] = VMSDSection(self.file, version_id, subsection, (name, 0))
>                  self.data[name].read()
>  
> @@ -575,9 +584,8 @@ def __init__(self, filename):
>          self.filename = filename
>          self.vmsd_desc = None
>  
> -    def read(self, desc_only = False, dump_memory = False, write_memory = False):
> -        # Read in the whole file
> -        file = MigrationFile(self.filename)
> +    def _read(self, file, vmsd_json, desc_only = False, dump_memory = False,
> +              write_memory = False):
>  
>          # File magic
>          data = file.read32()
> @@ -589,7 +597,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>          if data != self.QEMU_VM_FILE_VERSION:
>              raise Exception("Invalid version number %d" % data)
>  
> -        self.load_vmsd_json(file)
> +        self.load_vmsd_json(file, vmsd_json)
>  
>          # Read sections
>          self.sections = collections.OrderedDict()
> @@ -632,12 +640,25 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>                      raise Exception("Mismatched section footer: %x vs %x" % (read_section_id, section_id))
>              else:
>                  raise Exception("Unknown section type: %d" % section_type)
> -        file.close()
>  
> -    def load_vmsd_json(self, file):
> +    def read(self, desc_only = False, dump_memory = False,
> +             write_memory = False):
> +        file = MigrationFile(self.filename)
>          vmsd_json = file.read_migration_debug_json()
> +
> +        try:
> +            self._read(file, vmsd_json, desc_only, dump_memory, write_memory)
> +        except:
> +            raise Exception("Full JSON dump:\n%s", vmsd_json)

Better dump the Exception line itself too? IIUC that needs things like:

  except Exception as e:
      raise Exception(XXX, e, vmsd_json)

More below..

> +        finally:
> +            file.close()
> +
> +    def load_vmsd_json(self, file, vmsd_json):
>          self.vmsd_desc = json.loads(vmsd_json, object_pairs_hook=collections.OrderedDict)
>          for device in self.vmsd_desc['devices']:
> +            if 'fields' not in device:
> +                raise Exception("vmstate for device %s has no fields" %
> +                                device['name'])

This looks a valid check, though I still doubt whether this would hit at
all for this specific error (which looks like a top level STRUCT of a
section, that is missing "fields").

>              key = (device['name'], device['instance_id'])
>              value = ( VMSDSection, device )
>              self.section_classes[key] = value
> -- 
> 2.35.3
> 

For the capture part, would it be easier if we trap at the very top level
once and for all, then try to dump the vmsd_desc as long as existed?  Like
this:

====8<====
@@ -685,9 +686,15 @@ def default(self, o):
     f.close()
 elif args.dump == "state":
     dump = MigrationDump(args.file)
-    dump.read(dump_memory = args.memory)
-    dict = dump.getDict()
-    print(jsonenc.encode(dict))
+    try:
+        dump.read(dump_memory = args.memory)
+        dict = dump.getDict()
+        print(jsonenc.encode(dict))
+    except Exception as e:
+        # If loading vmstate stream failed, try the best to dump vmsd desc
+        raise Exception(
+            f"Caught exception when reading dump: {e}\n"
+            f"Trying to dump vmsd_desc: {jsonenc.encode(dump.vmsd_desc)}")
 elif args.dump == "desc":
     dump = MigrationDump(args.file)
     dump.read(desc_only = True)
====8<====

So no matter what caused error, fallback to try dump vmsd_desc as long as
available.

Thanks,

-- 
Peter Xu


