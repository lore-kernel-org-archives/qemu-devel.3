Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0B5C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtT4-00082U-9f; Fri, 02 May 2025 12:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSl-0007nx-Pp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSh-0006Uu-Pp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ6LGo3EmUQNiuDdGer7Pnmf83Ixx9VZUInNoC4VPuU=;
 b=S2DDsaz1SajkkE1kG+Y++qAceWHpwFl/z4ivl3WcTJgS5KgxrVkEhq1oDpcBUHIwgY1P5d
 eMU5wHm478mZVQ+0uNfKpt/3VAqL0szOSPZTBcQF5HKqcsDhwU6jBpvlivV2aXZsA3pWvi
 gokoAiFnc8veNjs1fTKDqahH5fi/k5k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-YxZtR40XPrikl_8i19m-ew-1; Fri, 02 May 2025 12:42:06 -0400
X-MC-Unique: YxZtR40XPrikl_8i19m-ew-1
X-Mimecast-MFC-AGG-ID: YxZtR40XPrikl_8i19m-ew_1746204125
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47ae87b5182so46188221cf.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204125; x=1746808925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQ6LGo3EmUQNiuDdGer7Pnmf83Ixx9VZUInNoC4VPuU=;
 b=pL8DnCfiYn6nnuDu5rZeXLRfOzz/ld/GODmBBoAQCTzyAOc/wq5TuBPxMeN35wjy5/
 9LehEtbACaqtYJNHXBuPtHNy475cN09MTVhMiHvoaNEFrmFw1wjuIqW9LrK8ui9MJdjZ
 FdZusflihcZdqJg+RSaCRlfyynNDuqNHwSWWTBcHbqNFO03816oGlCXig+urLcXwVukl
 ye4HBmCDOxeVT9XsdOb4ZFyph+5250hK02EVsGtjUPkR4ENjeBTgm3AYE6+kDzmFhjnr
 xYTiIJ4ghQwN/i8SVwvZ0XUKlvLFppRW+co0fxrc0kLqhYHHHhoLlBYSK4emaWyCL2p4
 Z3bA==
X-Gm-Message-State: AOJu0Yx/+qWbQvhCqwZHNAPK4dUIRF80SHjp2f5nBYYg2sIS8X1x4nsH
 HnJWO+KeVcvkDtnRglSILmEtwliwF3Sz3HvqMPMUJvo+enGI6ARwz4+Gb3iacGd2EHMZQoacyQR
 prsHLblZVBwWsS18mkzgQIwqt++zIkZh9RtOJAKqYHKgrikx5v/74ImXSzY4eqw52YKKBBDQyq7
 cU/yh8v/MlyZuhAjbnB8puYs1JYPizAMz6AA==
X-Gm-Gg: ASbGncsTWx23K7ozY5SkSTkrR6JTTqhKbMMVw3bYrQUM5AM/SeTjxSO1NcCyy0OlzhP
 XWrMUAIF0TRac9NDNsoldKjeG3wsvdK3vZLvxtjM8EGgXEMoTJMDsgED/V0bUwWTkEySZ8cy4v1
 EdNqSi09xEtw2QgKjWszGmLacsFAI6P3hjinnwFDmU91E8lnWM7HMSFisXPnz24K5JEslx0NUxj
 RGlhDn7yR2XptvfIsok49IMKq/2q5JAzqiirS9cIHuyHuMrP9bo2PPx2vsuhvx2vs60T5IRmys1
X-Received: by 2002:a05:622a:ed5:b0:48b:5656:bb01 with SMTP id
 d75a77b69052e-48c311649cfmr39084081cf.10.1746204125140; 
 Fri, 02 May 2025 09:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYLdRbciPNTI8T2YmCs7k44odWgi3wpbc6/Iw57N6IsUYOnrdyJ+dZuiBRoWddHNXCnzQ6tw==
X-Received: by 2002:a05:622a:ed5:b0:48b:5656:bb01 with SMTP id
 d75a77b69052e-48c311649cfmr39083691cf.10.1746204124694; 
 Fri, 02 May 2025 09:42:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:42:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Jack Wang <jinpu.wang@ionos.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org, michael@flatgalaxy.com,
 Michael Galaxy <mrgalaxy@nvidia.com>
Subject: [PULL 13/14] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Date: Fri,  2 May 2025 12:41:40 -0400
Message-ID: <20250502164141.747202-14-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jack Wang <jinpu.wang@ionos.com>

I hit following error which testing migration in pure RoCE env:
"-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
systems and your management software has specified '[::]', but IPv6 over RoCE /
iWARP is not supported in Linux.#012'."

In our setup, we use rdma bind on ipv6 on target host, while connect from source
with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
fine.

Checking the git history, the function was added since introducing of
rdma migration, which is more than 10 years ago. linux-rdma has
improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
back in 2016 seems related to the issue, eg:
aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")

other fixes back in 2018, eg:
052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
3c7f67d1880d IB/cma: Fix default RoCE type setting
be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
63a5f483af0e IB/cma: Set default gid type to RoCEv2

So remove the outdated function and it's usage.

Cc: Peter Xu <peterx@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Yu Zhang <yu.zhang@ionos.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Cc: linux-rdma@vger.kernel.org
Cc: michael@flatgalaxy.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Li zhijian <lizhijian@fujitsu.com>
Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
Link: https://lore.kernel.org/r/20250402051306.6509-1-jinpu.wang@ionos.com
[peterx: some cosmetic changes]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 180 ++---------------------------------------------
 1 file changed, 4 insertions(+), 176 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4875ca1987..2d839fce6c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
     trace_qemu_rdma_dump_gid(who, sgid, dgid);
 }
 
-/*
- * As of now, IPv6 over RoCE / iWARP is not supported by linux.
- * We will try the next addrinfo struct, and fail if there are
- * no other valid addresses to bind against.
- *
- * If user is listening on '[::]', then we will not have a opened a device
- * yet and have no way of verifying if the device is RoCE or not.
- *
- * In this case, the source VM will throw an error for ALL types of
- * connections (both IPv4 and IPv6) if the destination machine does not have
- * a regular infiniband network available for use.
- *
- * The only way to guarantee that an error is thrown for broken kernels is
- * for the management software to choose a *specific* interface at bind time
- * and validate what time of hardware it is.
- *
- * Unfortunately, this puts the user in a fix:
- *
- *  If the source VM connects with an IPv4 address without knowing that the
- *  destination has bound to '[::]' the migration will unconditionally fail
- *  unless the management software is explicitly listening on the IPv4
- *  address while using a RoCE-based device.
- *
- *  If the source VM connects with an IPv6 address, then we're OK because we can
- *  throw an error on the source (and similarly on the destination).
- *
- *  But in mixed environments, this will be broken for a while until it is fixed
- *  inside linux.
- *
- * We do provide a *tiny* bit of help in this function: We can list all of the
- * devices in the system and check to see if all the devices are RoCE or
- * Infiniband.
- *
- * If we detect that we have a *pure* RoCE environment, then we can safely
- * thrown an error even if the management software has specified '[::]' as the
- * bind address.
- *
- * However, if there is are multiple hetergeneous devices, then we cannot make
- * this assumption and the user just has to be sure they know what they are
- * doing.
- *
- * Patches are being reviewed on linux-rdma.
- */
-static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
-{
-    /* This bug only exists in linux, to our knowledge. */
-#ifdef CONFIG_LINUX
-    struct ibv_port_attr port_attr;
-
-    /*
-     * Verbs are only NULL if management has bound to '[::]'.
-     *
-     * Let's iterate through all the devices and see if there any pure IB
-     * devices (non-ethernet).
-     *
-     * If not, then we can safely proceed with the migration.
-     * Otherwise, there are no guarantees until the bug is fixed in linux.
-     */
-    if (!verbs) {
-        int num_devices;
-        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
-        bool roce_found = false;
-        bool ib_found = false;
-
-        for (int x = 0; x < num_devices; x++) {
-            verbs = ibv_open_device(dev_list[x]);
-            /*
-             * ibv_open_device() is not documented to set errno.  If
-             * it does, it's somebody else's doc bug.  If it doesn't,
-             * the use of errno below is wrong.
-             * TODO Find out whether ibv_open_device() sets errno.
-             */
-            if (!verbs) {
-                if (errno == EPERM) {
-                    continue;
-                } else {
-                    error_setg_errno(errp, errno,
-                                     "could not open RDMA device context");
-                    return -1;
-                }
-            }
-
-            if (ibv_query_port(verbs, 1, &port_attr)) {
-                ibv_close_device(verbs);
-                error_setg(errp,
-                           "RDMA ERROR: Could not query initial IB port");
-                return -1;
-            }
-
-            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
-                ib_found = true;
-            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-                roce_found = true;
-            }
-
-            ibv_close_device(verbs);
-
-        }
-
-        if (roce_found) {
-            if (ib_found) {
-                warn_report("migrations may fail:"
-                            " IPv6 over RoCE / iWARP in linux"
-                            " is broken. But since you appear to have a"
-                            " mixed RoCE / IB environment, be sure to only"
-                            " migrate over the IB fabric until the kernel "
-                            " fixes the bug.");
-            } else {
-                error_setg(errp, "RDMA ERROR: "
-                           "You only have RoCE / iWARP devices in your systems"
-                           " and your management software has specified '[::]'"
-                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                return -1;
-            }
-        }
-
-        return 0;
-    }
-
-    /*
-     * If we have a verbs context, that means that some other than '[::]' was
-     * used by the management software for binding. In which case we can
-     * actually warn the user about a potentially broken kernel.
-     */
-
-    /* IB ports start with 1, not 0 */
-    if (ibv_query_port(verbs, 1, &port_attr)) {
-        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
-        return -1;
-    }
-
-    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        error_setg(errp, "RDMA ERROR: "
-                   "Linux kernel's RoCE / iWARP does not support IPv6 "
-                   "(but patches on linux-rdma in progress)");
-        return -1;
-    }
-
-#endif
-
-    return 0;
-}
-
 /*
  * Figure out which RDMA device corresponds to the requested IP hostname
  * Also create the initial connection manager identifiers for opening
@@ -917,7 +774,6 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
  */
 static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_addrinfo *res;
     char port_str[16];
@@ -953,9 +809,8 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         goto err_resolve_get_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses, exit loop on first success of resolving address */
     for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -964,25 +819,12 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret >= 0) {
-            if (e->ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
-                                                   local_errp);
-                if (ret < 0) {
-                    continue;
-                }
-            }
-            error_free(err);
             goto route;
         }
     }
 
     rdma_freeaddrinfo(res);
-    if (err) {
-        error_propagate(errp, err);
-    } else {
-        error_setg(errp, "RDMA ERROR: could not resolve address %s",
-                   rdma->host);
-    }
+    error_setg(errp, "RDMA ERROR: could not resolve address %s", rdma->host);
     goto err_resolve_get_addr;
 
 route:
@@ -2611,7 +2453,6 @@ err_rdma_source_connect:
 
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
     int ret;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
@@ -2661,9 +2502,8 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         goto err_dest_init_bind_addr;
     }
 
-    /* Try all addresses, saving the first error in @err */
+    /* Try all addresses */
     for (e = res; e != NULL; e = e->ai_next) {
-        Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
@@ -2672,24 +2512,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         if (ret < 0) {
             continue;
         }
-        if (e->ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
-                                               local_errp);
-            if (ret < 0) {
-                continue;
-            }
-        }
-        error_free(err);
         break;
     }
 
     rdma_freeaddrinfo(res);
     if (!e) {
-        if (err) {
-            error_propagate(errp, err);
-        } else {
-            error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
-        }
+        error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
         goto err_dest_init_bind_addr;
     }
 
-- 
2.48.1


