Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE9C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgSr-0004vv-SG; Tue, 14 Jul 2026 12:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wjgSp-0004vU-FB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:58:35 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wjgSn-0002bY-Gd
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 12:58:35 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15ea93028dso496513666b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784048311; x=1784653111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w0ZFtVAr82+Dw8HzS8ki3X8OreS6Bg4bic9UiUzONrs=;
 b=MvjrCBXdaSZKUPUjjhOERUwDEebsJa4XjhbspJsUZsiotC7C1c2FZ5p6zjJ1O2/6a2
 OlnvnYTYLjOEfwxEk3eKl+Y1HBoYNQjPtpt/A2svtSXiMdr4DR9hRqR/nmh8ZloHABzW
 bSeGhOBEuQa+RHXp5ZvV61AYDTIw/Dhzc4NRN6FaGodnzP5kNpWY7FawJqJIvAQwWZ9C
 EBK1gtkFOa9PzAukcHm1EAeMhP0ThxKvG00uTYyqntIDNM1tu46ojk84+c1Go2a7apIh
 zeaHMg807G2UUs+ToHfQGzSMA4wYJqLvTwo2KtmZUTfPoKzUKUETZCYuy/rnu4gJKZkM
 wjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784048311; x=1784653111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w0ZFtVAr82+Dw8HzS8ki3X8OreS6Bg4bic9UiUzONrs=;
 b=WLwl5EHvrZNEl2kRrQuNEMjJwxu+Tn85dS6k5aDxK6c+JltxgzCcP0QhMlphZarYYs
 acXvI+RlqlcVlGBbMt503zrLc06m+FxYc8ni1N/uAhfAmEzwIu+tKqvDHGQvIMWVlTSL
 VyifsAnd6w8AWbwPUd7Xa5+dbJpUkRlVADu1Iv6XJFbBJCO71d/l6yvAJj2iQbuiAOG6
 Ql3sIaSts7c+ga28wFxSMJJyfZTN/Ffkq9PWj4xY/2WCjSmAkYx/QB8Iwe2dK3QFlBXS
 HVYhUbTjCx2DO+NJlkEU7M9LgiXLWoyc0gLvD/wukfZKwD9KJvC+dBAzbiFrL2vRNQdI
 phOQ==
X-Gm-Message-State: AOJu0YzAJQrDMoYR1nO54UAHy0yZ/o64Nc8xA5QisXHFrHSPE7AvgYGR
 eQ+sD62hImdHdzsWrgEpCGT5xst+tLRF7jljfU1SAUdDHQTzKcZlzPN/Gp2pAGW/azo=
X-Gm-Gg: AfdE7cmumVtdhgQjDS6Y5SmTUYyHUA5j1x+0lQxRmM4CH48LpFR+DW5vxg768U/JlpN
 HW3QipE8ea/AhyTvPbtakMtf42XiZ+CzhD9Eq6ddAwhq8b14u4l77h611wr5ayl5zAk55QvKzep
 RDxXFGVuZnijClHjsvChx1VP5iooTK1efRJLLVMKs7DyLYY/+hDvnYvqCIJlnhXN+t4iOgIz9xp
 YZarNM/askaU+JSeXeL0g2kzWliwS+7g+B9nraHR/7xia1ZubhaHUO2aXUeDssUTU2x1neKoUFT
 vXMQwy4bVI7EvEw8QNOVUJIgsbeYYhFNjESpWbBWIU8jIDMcaePPZ/FMgXhcISnlEmIAOrElJ8X
 5WUg3ZV2CsX/8VftvjvFzzGo4XcNn5dDwuwaaxDiyZhcqM7gfs57daaMC+KCXg4gTqL7/mSRVyb
 H4EI2LtpT9Igp3iFl/2VNIvu7T3Ay50oD0rFCwAIHqn0r2lsOoxpbVQ2WQqfZyeH0QuOUuMJZ5W
 YcINlEfsmxBaGLy7eXPECTtdJw=
X-Received: by 2002:a17:907:c011:b0:c16:157a:a442 with SMTP id
 a640c23a62f3a-c1667bf8240mr159823666b.60.1784048311168; 
 Tue, 14 Jul 2026 09:58:31 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1670a906d5sm69798466b.7.2026.07.14.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:58:30 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
Date: Tue, 14 Jul 2026 18:57:59 +0200
Message-ID: <20260714165759.7521-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x631.google.com
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

Implement the qmp_guest_get_fsinfo() API for FreeBSD.
To implement it, reuse build_fs_mount_list() which is already
implemented for FreeBSD. Extend the FsMount type to include
a string "fromname" attribute to store the disk the FS is mounted from.

Disk mapping info is not covered by this implementation.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
Changes since v1:

 - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo

Changes since v2:

 - Drop the unused 'errp' argument to build_guest_fsinfo() and
   clean up the related code.
 - Fix leaking string through g_strdup() for a g_path_get_basename()
   allocated string.

 qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-common.h |  1 +
 qga/commands-posix.c  |  3 +++
 qga/qapi-schema.json  | 12 +++++-----
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 94ff6fee6a..1c51d099eb 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -20,6 +20,7 @@
 #include <sys/ucred.h>
 #include <sys/mount.h>
 #include <net/if_dl.h>
+#include <sys/statvfs.h>
 #if defined(__NetBSD__) || defined(__OpenBSD__)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
@@ -28,7 +29,7 @@
 #endif
 #include <paths.h>
 
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
+#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(__FreeBSD__)
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 {
     FsMount *mount;
@@ -55,6 +56,7 @@ bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 
         mount->dirname = g_strdup(mntp->f_mntonname);
         mount->devtype = g_strdup(mntp->f_fstypename);
+        mount->fromname = g_strdup(mntp->f_mntfromname);
         mount->devmajor = major(mount->dev);
         mount->devminor = minor(mount->dev);
         mount->fsid = mntp->f_fsid;
@@ -178,3 +180,52 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
     return true;
 }
 #endif /* HAVE_GETIFADDRS */
+
+#if defined(__FreeBSD__)
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount)
+{
+    GuestFilesystemInfo *fs = g_new0(GuestFilesystemInfo, 1);
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
+
+    fs->mountpoint = g_strdup(mount->dirname);
+    fs->type = g_strdup(mount->devtype);
+    fs->name = g_path_get_basename(mount->fromname);
+
+    if (statvfs(fs->mountpoint, &buf) == 0) {
+        fr_size = buf.f_frsize;
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        fs->used_bytes = used * fr_size;
+        fs->total_bytes = nonroot_total * fr_size;
+        fs->total_bytes_privileged = buf.f_blocks * fr_size;
+
+        fs->has_total_bytes = true;
+        fs->has_total_bytes_privileged = true;
+        fs->has_used_bytes = true;
+    }
+
+    return fs;
+}
+
+GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
+{
+    FsMountList mounts;
+    struct FsMount *mount;
+    GuestFilesystemInfoList *ret = NULL;
+
+    QTAILQ_INIT(&mounts);
+    if (!build_fs_mount_list(&mounts, errp)) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(mount, &mounts, next) {
+        g_debug("Building guest fsinfo for '%s'", mount->dirname);
+
+        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount));
+    }
+
+    free_fs_mount_list(&mounts);
+    return ret;
+}
+#endif /* __FreeBSD__ */
diff --git a/qga/commands-common.h b/qga/commands-common.h
index 263e7c0525..a07d0885f5 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -29,6 +29,7 @@ typedef struct FsMount {
 #if defined(__FreeBSD__)
     dev_t dev;
     fsid_t fsid;
+    char *fromname;
 #endif
     QTAILQ_ENTRY(FsMount) next;
 } FsMount;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..837e285b6d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -731,6 +731,9 @@ void free_fs_mount_list(FsMountList *mounts)
          QTAILQ_REMOVE(mounts, mount, next);
          g_free(mount->dirname);
          g_free(mount->devtype);
+#if defined(__FreeBSD__)
+         g_free(mount->fromname);
+#endif
          g_free(mount);
      }
 }
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..8cd0ba048b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -874,7 +874,7 @@
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestPCIAddress:
@@ -892,7 +892,7 @@
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
            'slot': 'int', 'function': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -912,7 +912,7 @@
            'ssid': 'int',
            'subchno': 'int',
            'devno': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -942,7 +942,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
            '*ccw-address': 'GuestCCWAddress'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -1063,7 +1063,7 @@
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1077,7 +1077,7 @@
 ##
 { 'command': 'guest-get-fsinfo',
   'returns': ['GuestFilesystemInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @guest-set-user-password:
-- 
2.52.0


