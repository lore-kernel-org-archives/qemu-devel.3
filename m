Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B35FEA3F2F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkJ8-0001nt-6M; Tue, 10 Feb 2026 04:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vpkJ4-0001n9-PG
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:45:20 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vpkJ2-0006G8-Nr
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:45:18 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-382f9930e54so45811731fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770716714; x=1771321514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYf7M6vYBmCdx++pfrHosz7EkcgNmIGIs7/SS9YD8yc=;
 b=dz+b07eLfNG4fFr+s+IzQc3yUHP12ZXV8rKRI05njAt2dL/XlVlAAGFXeI5H/AB6qv
 TrxrPWJaiG95N6E+m2SnpIIs6HgpRI2/eD6SjB5MnN5ZRtxZE65jgy0CUe2Vv1BXSlqN
 a/dleRcu5ZTzB+2p/lzssCMFeRjyRzVUzH88a8BEpHkimzRxUX/NAow0BYupDU/jM4i/
 sRogzNIuRxXL04jUTyE4dovdXyGF401K+XVSe4DBsGALAUvdKAOlW7Jo5Ewm8hcY6EY9
 RVgyPwpA3K64TlEubLykC6aNxFcvnxgxYhIPW5FEAsxrW1cVYPFphjzmzkvd1DfvdXAX
 78MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770716714; x=1771321514;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYf7M6vYBmCdx++pfrHosz7EkcgNmIGIs7/SS9YD8yc=;
 b=GJRIhRtrrHHJ1cA5JcxaBqCIm9FD7FI69eL/ncF7c21wEWMtttQrD7DEw/0iat+26j
 JKSSxBk3PdAUlWqmo8yH9mB7sUCGFZbmDCeQIQs+smEiuXpA3TntKheqxnDaic4EHiFn
 yS8uJz0yYJh3QTAl1cqv1Ho+n3lTZmRXQv/YjkIXzuYvNxD4Q3TnGah3OWerqG3mKE9x
 8aSputEBRITwMSBJneCgDH/QvXwwo2oJqvo0UeYSVnIHQrEXlnh4mujQvI9tkkhbJKbQ
 K7vmrzDt2lbt/CVR40rzwOJlC+4oAZS9eILdQSGSDhYkfsY8dh3LAKbhXsrnh8PPcabO
 e40g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDusoojvkw3JcK4xhzR1ynx5q1kzY0WF4DckZFEojw114ze07FRWAB+ca/Lqo+P8pqmWP90iB/af/i@nongnu.org
X-Gm-Message-State: AOJu0YzrzsJ318ySdgn0eKO3ekB8YY0Bt27B5Q2SZ+fB4tCLO4+4OcMd
 BipA/p2y9SH8Slfi3rVlc6tiEgjx7DMnzazsLSKFS4gCyFVehk/NmZ6l
X-Gm-Gg: AZuq6aL7n39WquyD8ITW1ard9CCTTv+iPZnTUMwTr1JAmYNiVUFnnhu9tkVMm5O+lLP
 aJszbBJRd0W3R0Hr672ldMpZC0iQyzZ+Ntk5FWoWdj3iylM4ZdmW8xL1b6yd3DdfAuBlp7O6agp
 a1i3o6gX9c+U6sdGfvc0tgbUGjSER6TlFwi1IDAsmc7lh4foCV5f8BAPWZ2OCIQEOyxnf6GF81g
 TZ6D1AJBY2xBWQowzq35dGHRJ4pkVsKtX0UI2Q9E59VcSxkHii5oZLphSQ5fwaYcERuo0QuhgdB
 6XUHVaJ0/YzX0zOfPSbw4NTwzqS81uX1p5ooJwNnNpGNTyc6/f47+7yFpRsaIMnvC4nrbl8X4kV
 HbHZzrubgSNBG7au+1AwKHfiAL3bltFmPnFCttkBiw2860JhSsdvembjzVKy8dqdnPdgHa0vSmS
 R+9AbJiU9NaQ6dKnp8rtiCAjAKA+v6J0D3nv/Zn6b4Ib2i
X-Received: by 2002:a05:651c:3134:b0:386:78ba:efda with SMTP id
 38308e7fff4ca-386ee661ab0mr8325791fa.19.1770716713744; 
 Tue, 10 Feb 2026 01:45:13 -0800 (PST)
Received: from [192.168.88.253] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6408bc5sm30860671fa.40.2026.02.10.01.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 01:45:13 -0800 (PST)
Message-ID: <5e904364-240a-4853-ad28-b2e3c5ac8f83@gmail.com>
Date: Tue, 10 Feb 2026 14:45:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrey Erokhin <language.lawyer@gmail.com>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <d3cd5506-1ba0-492a-9eee-51f814da6087@gmail.com> <5961971.DvuYhMxLoT@weasel>
Content-Language: en-US
In-Reply-To: <5961971.DvuYhMxLoT@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=language.lawyer@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/01/2026 19:30, Christian Schoenebeck wrote:
> On Wednesday, 28 January 2026 20:13:45 CET Andrey Erokhin wrote:
>>> I was trying to boot from a directory tree owned by an ordinary user,
>>> and some daemons weren't happy about non-root ownership of some files
>>>
>>> Example use:
>>> -virtfs local,path=rootfs,mount_tag=root,security_model=mapped,uid=0,gid=0
>>
>> I personally switched from fuse-overlayfs to user namespaces+kernel overlay
>> fs (for writeable overlay for rootfs) long time ago, so I do not need
>> uid=0,gid=0, I'm being mapped to 0:0 in the user namespace. I wanted to
>> publish this change to support users which can't use user namespaces, but
>> yesterday I realized I could just run QEMU (with fuse-overlayfs) under
>> fakeroot 🤦‍♂️
> 
> Nevertheless you already came more than half way to finish this. All it would take is adding some lines to the command line docs.

Do you mean smth. like this?
(BTW, is it OK that there is no fmode/dmode processing in system/vl.c?)

---
 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 fsdev/qemu-fsdev.c      |  2 ++
 hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++++++
 hw/9pfs/9p.c            |  2 ++
 qemu-options.hx         | 24 ++++++++++++++++++++----
 system/vl.c             |  9 +++++++++
 7 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b9dae8c84c..10f3a7270c 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -94,6 +94,8 @@ typedef struct FsDriverEntry {
     FsThrottle fst;
     mode_t fmode;
     mode_t dmode;
+    uid_t dflt_uid;
+    gid_t dflt_gid;
 } FsDriverEntry;
 
 struct FsContext {
@@ -107,6 +109,8 @@ struct FsContext {
     void *private;
     mode_t fmode;
     mode_t dmode;
+    uid_t dflt_uid;
+    gid_t dflt_gid;
 };
 
 struct V9fsPath {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 07a18c6e48..c99abb3de6 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -46,6 +46,12 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "uid",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "gid",
+            .type = QEMU_OPT_NUMBER,
         },
 
         THROTTLE_OPTS,
@@ -92,6 +98,12 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "uid",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "gid",
+            .type = QEMU_OPT_NUMBER,
         },
 
         { /*End of list */ }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 57877dad0a..faa84dc033 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -58,6 +58,8 @@ static FsDriverTable FsDrivers[] = {
             "writeout",
             "fmode",
             "dmode",
+            "uid",
+            "gid",
             "multidevs",
             "throttling.bps-total",
             "throttling.bps-read",
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5ce97b76a6..f20b1c5d1a 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -198,6 +198,12 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
     if (err) {
         goto err_out;
     }
+    if (fs_ctx->dflt_uid != -1) {
+        stbuf->st_uid = fs_ctx->dflt_uid;
+    }
+    if (fs_ctx->dflt_gid != -1) {
+        stbuf->st_gid = fs_ctx->dflt_gid;
+    }
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
         /* Actual credentials are part of extended attrs */
         uid_t tmp_uid;
@@ -788,6 +794,12 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
     if (err) {
         return err;
     }
+    if (fs_ctx->dflt_uid != -1) {
+        stbuf->st_uid = fs_ctx->dflt_uid;
+    }
+    if (fs_ctx->dflt_gid != -1) {
+        stbuf->st_gid = fs_ctx->dflt_gid;
+    }
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
         /* Actual credentials are part of extended attrs */
         uid_t tmp_uid;
@@ -1587,6 +1599,19 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         }
     }
 
+    if (fse->export_flags & V9FS_SM_PASSTHROUGH) {
+        if (qemu_opt_find(opts, "uid")) {
+            error_setg(errp, "uid is invalid in the passthrough security mode");
+            return -1;
+        }
+        if (qemu_opt_find(opts, "gid")) {
+            error_setg(errp, "gid is invalid in the passthrough security mode");
+            return -1;
+        }
+    }
+    fse->dflt_uid = qemu_opt_get_number(opts, "uid", -1);
+    fse->dflt_gid = qemu_opt_get_number(opts, "gid", -1);
+
     fse->path = g_strdup(path);
 
     return 0;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index acfa7db4e1..492379d361 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4317,6 +4317,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->ctx.fmode = fse->fmode;
     s->ctx.dmode = fse->dmode;
+    s->ctx.dflt_uid = fse->dflt_uid;
+    s->ctx.dflt_gid = fse->dflt_gid;
 
     s->fids = g_hash_table_new(NULL, NULL);
     qemu_co_rwlock_init(&s->rename_lock);
diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..84f108d9ad 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1806,7 +1806,7 @@ ERST
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     "-fsdev local,id=id,path=path,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    " [,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode]\n"
+    " [,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,uid=uid][,gid=gid]\n"
     " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
     " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
     " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
@@ -1816,7 +1816,7 @@ DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     QEMU_ARCH_ALL)
 
 SRST
-``-fsdev local,id=id,path=path,security_model=security_model [,writeout=writeout][,readonly=on][,fmode=fmode][,dmode=dmode] [,throttling.option=value[,throttling.option=value[,...]]]``
+``-fsdev local,id=id,path=path,security_model=security_model [,writeout=writeout][,readonly=on][,fmode=fmode][,dmode=dmode][,uid=uid][,gid=gid] [,throttling.option=value[,throttling.option=value[,...]]]``
   \ 
 ``-fsdev synth,id=id[,readonly=on]``
     Define a new file system device. Valid options are:
@@ -1870,6 +1870,14 @@ SRST
         host. Works only with security models "mapped-xattr" and
         "mapped-file".
 
+    ``uid=uid``
+        Specifies the default uid for files and directories. Works with
+        security models "mapped-xattr", "mapped-file" and "none".
+
+    ``gid=gid``
+        Specifies the default gid for files and directories. Works with
+        security models "mapped-xattr", "mapped-file" and "none".
+
     ``throttling.bps-total=b,throttling.bps-read=r,throttling.bps-write=w``
         Specify bandwidth throttling limits in bytes per second, either
         for all request types or for reads or writes only.
@@ -1911,12 +1919,12 @@ ERST
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    "        [,id=id][,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn]\n"
+    "        [,id=id][,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,uid=uid][,gid=gid][,multidevs=remap|forbid|warn]\n"
     "-virtfs synth,mount_tag=tag[,id=id][,readonly=on]\n",
     QEMU_ARCH_ALL)
 
 SRST
-``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly=on] [,fmode=fmode][,dmode=dmode][,multidevs=multidevs]``
+``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly=on] [,fmode=fmode][,dmode=dmode][,uid=uid][,gid=gid][,multidevs=multidevs]``
   \ 
 ``-virtfs synth,mount_tag=mount_tag``
     Define a new virtual filesystem device and expose it to the guest using
@@ -1980,6 +1988,14 @@ SRST
         host. Works only with security models "mapped-xattr" and
         "mapped-file".
 
+    ``uid=uid``
+        Specifies the default uid for files and directories. Works with
+        security models "mapped-xattr", "mapped-file" and "none".
+
+    ``gid=gid``
+        Specifies the default gid for files and directories. Works with
+        security models "mapped-xattr", "mapped-file" and "none".
+
     ``mount_tag=mount_tag``
         Specifies the tag name to be used by the guest to mount this
         export point.
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..d363b046a6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3253,6 +3253,7 @@ void qemu_init(int argc, char **argv)
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *security_model,
+                           *uid, *gid,
                            *multidevs;
 
                 olist = qemu_find_opts("virtfs");
@@ -3301,6 +3302,14 @@ void qemu_init(int argc, char **argv)
                     qemu_opt_set(fsdev, "security_model", security_model,
                                  &error_abort);
                 }
+                uid = qemu_opt_get(opts, "uid");
+                if (uid) {
+                    qemu_opt_set(fsdev, "uid", uid, &error_abort);
+                }
+                gid = qemu_opt_get(opts, "gid");
+                if (gid) {
+                    qemu_opt_set(fsdev, "gid", gid, &error_abort);
+                }
                 socket = qemu_opt_get(opts, "socket");
                 if (socket) {
                     qemu_opt_set(fsdev, "socket", socket, &error_abort);
--

