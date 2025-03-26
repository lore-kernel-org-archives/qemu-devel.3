Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD08DC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRVC-0002E3-Gz; Wed, 26 Mar 2025 10:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@flatgalaxy.com>)
 id 1txR6B-0002OK-Qz
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:47:16 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@flatgalaxy.com>)
 id 1txR68-0001dG-Ob
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1742996809; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jSe9p62Sbl3vq0npVO/JGOTEUcul0hNfn9w9yjiAX7hjWZPe2vIDdj1vUWjbqFH8ihVt64LB17iFkR1VTkNZmgGn+6MLzcJ9G+MDesw67m9zUJtVq6EmwcHCBFN3lJXRXtgUmD1Nmwzo3sedmyKKq5EG4N7ig+gwyoyKXRjd3g8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1742996809;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id;
 bh=Ya+Cm4FcXfK633y9VAHmLdegNMjCm41gaYy/Jk/KfH4=; 
 b=n/sjplzCLpW/wvuNdDhiqRAg3lh97yADKSwCXXD0aZoOk+mrLIGRhrXk7bDT3rJ+YcsHwQEVaL0BmvfqCB5PZX/mt3oiqIznZXGYbFCvAPSyj+nVucWoRe1suGKzkwHQLQ2RabtbNbSi0kf/SwZA1L4FsW/Rb7y3b5hxZAo+CDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=flatgalaxy.com;
 spf=pass  smtp.mailfrom=michael@flatgalaxy.com;
 dmarc=pass header.from=<michael@flatgalaxy.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742996809; 
 s=zoho; d=flatgalaxy.com; i=michael@flatgalaxy.com;
 h=Content-Type:Message-ID:Date:Date:MIME-Version:Reply-To:Reply-To:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Message-Id;
 bh=Ya+Cm4FcXfK633y9VAHmLdegNMjCm41gaYy/Jk/KfH4=;
 b=rou/0vVCyyGEAsuJ8refixLvnWsTb1moU2TuJa9ZUtPbfzksv9Y6/VAruO9FNzB2
 9yfE8cTslqsiFaEkGyplMlM9yFqq1qCWhWsyuzbuIty5Fbg9Oy2k0wU/Ors8RLrBQDc
 0hqA6hJW23eVBbWhqi2cwBKpdYVwmDPtoXfmWloA=
Received: by mx.zohomail.com with SMTPS id 1742996806299356.7061399281512;
 Wed, 26 Mar 2025 06:46:46 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------0QKeZsXDRuAj9Zm00KDaCOJr"
Message-ID: <e742d858-f84f-48a0-8f8a-5ad8e4d48a61@flatgalaxy.com>
Date: Wed, 26 Mar 2025 08:46:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: Jack Wang <jinpu.wang@ionos.com>, qemu-devel@nongnu.org, farosas@suse.de, 
 peterx@redhat.com, mrgalaxy@nvidia.com
Cc: Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org
References: <20250326095224.9918-1-jinpu.wang@ionos.com>
Content-Language: en-US
From: Michael Galaxy <michael@flatgalaxy.com>
In-Reply-To: <20250326095224.9918-1-jinpu.wang@ionos.com>
X-ZohoMailClient: External
Received-SPF: permerror client-ip=136.143.188.12;
 envelope-from=michael@flatgalaxy.com; helo=sender4-op-o12.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_KAM_HTML_FONT_INVALID=0.01,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Mar 2025 10:13:04 -0400
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
Reply-To: michael@flatgalaxy.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------0QKeZsXDRuAj9Zm00KDaCOJr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Excellent find. Thank you very much for checking on the history. 
Hopefully my comments were not too hard to read. =)

FYI: I've since left Akamai last year and now work at Nvidia.

Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>

On 3/26/25 04:52, Jack Wang wrote:
> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
> systems and your management software has specified '[::]', but IPv6 over RoCE /
> iWARP is not supported in Linux.#012'."
>
> In our setup, we use rdma bind on ipv6 on target host, while connect from source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
>
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")
>
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
>
> So remove the outdated function and it's usage.
>
> Cc: Peter Xu<peterx@redhat.com>
> Cc: Li Zhijian<lizhijian@fujitsu.com>
> Cc: Yu Zhang<yu.zhang@ionos.com>
> Cc:qemu-devel@nongnu.org
> Cc:linux-rdma@vger.kernel.org
> Cc:michael@flatgalaxy.com
> Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> ---
>   migration/rdma.c | 157 -----------------------------------------------
>   1 file changed, 157 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 76fb0349238a..5ce628ddeef0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
>       trace_qemu_rdma_dump_gid(who, sgid, dgid);
>   }
>   
> -/*
> - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> - * We will try the next addrinfo struct, and fail if there are
> - * no other valid addresses to bind against.
> - *
> - * If user is listening on '[::]', then we will not have a opened a device
> - * yet and have no way of verifying if the device is RoCE or not.
> - *
> - * In this case, the source VM will throw an error for ALL types of
> - * connections (both IPv4 and IPv6) if the destination machine does not have
> - * a regular infiniband network available for use.
> - *
> - * The only way to guarantee that an error is thrown for broken kernels is
> - * for the management software to choose a *specific* interface at bind time
> - * and validate what time of hardware it is.
> - *
> - * Unfortunately, this puts the user in a fix:
> - *
> - *  If the source VM connects with an IPv4 address without knowing that the
> - *  destination has bound to '[::]' the migration will unconditionally fail
> - *  unless the management software is explicitly listening on the IPv4
> - *  address while using a RoCE-based device.
> - *
> - *  If the source VM connects with an IPv6 address, then we're OK because we can
> - *  throw an error on the source (and similarly on the destination).
> - *
> - *  But in mixed environments, this will be broken for a while until it is fixed
> - *  inside linux.
> - *
> - * We do provide a *tiny* bit of help in this function: We can list all of the
> - * devices in the system and check to see if all the devices are RoCE or
> - * Infiniband.
> - *
> - * If we detect that we have a *pure* RoCE environment, then we can safely
> - * thrown an error even if the management software has specified '[::]' as the
> - * bind address.
> - *
> - * However, if there is are multiple hetergeneous devices, then we cannot make
> - * this assumption and the user just has to be sure they know what they are
> - * doing.
> - *
> - * Patches are being reviewed on linux-rdma.
> - */
> -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
> -{
> -    /* This bug only exists in linux, to our knowledge. */
> -#ifdef CONFIG_LINUX
> -    struct ibv_port_attr port_attr;
> -
> -    /*
> -     * Verbs are only NULL if management has bound to '[::]'.
> -     *
> -     * Let's iterate through all the devices and see if there any pure IB
> -     * devices (non-ethernet).
> -     *
> -     * If not, then we can safely proceed with the migration.
> -     * Otherwise, there are no guarantees until the bug is fixed in linux.
> -     */
> -    if (!verbs) {
> -        int num_devices;
> -        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
> -        bool roce_found = false;
> -        bool ib_found = false;
> -
> -        for (int x = 0; x < num_devices; x++) {
> -            verbs = ibv_open_device(dev_list[x]);
> -            /*
> -             * ibv_open_device() is not documented to set errno.  If
> -             * it does, it's somebody else's doc bug.  If it doesn't,
> -             * the use of errno below is wrong.
> -             * TODO Find out whether ibv_open_device() sets errno.
> -             */
> -            if (!verbs) {
> -                if (errno == EPERM) {
> -                    continue;
> -                } else {
> -                    error_setg_errno(errp, errno,
> -                                     "could not open RDMA device context");
> -                    return -1;
> -                }
> -            }
> -
> -            if (ibv_query_port(verbs, 1, &port_attr)) {
> -                ibv_close_device(verbs);
> -                error_setg(errp,
> -                           "RDMA ERROR: Could not query initial IB port");
> -                return -1;
> -            }
> -
> -            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
> -                ib_found = true;
> -            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
> -                roce_found = true;
> -            }
> -
> -            ibv_close_device(verbs);
> -
> -        }
> -
> -        if (roce_found) {
> -            if (ib_found) {
> -                warn_report("migrations may fail:"
> -                            " IPv6 over RoCE / iWARP in linux"
> -                            " is broken. But since you appear to have a"
> -                            " mixed RoCE / IB environment, be sure to only"
> -                            " migrate over the IB fabric until the kernel "
> -                            " fixes the bug.");
> -            } else {
> -                error_setg(errp, "RDMA ERROR: "
> -                           "You only have RoCE / iWARP devices in your systems"
> -                           " and your management software has specified '[::]'"
> -                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
> -                return -1;
> -            }
> -        }
> -
> -        return 0;
> -    }
> -
> -    /*
> -     * If we have a verbs context, that means that some other than '[::]' was
> -     * used by the management software for binding. In which case we can
> -     * actually warn the user about a potentially broken kernel.
> -     */
> -
> -    /* IB ports start with 1, not 0 */
> -    if (ibv_query_port(verbs, 1, &port_attr)) {
> -        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
> -        return -1;
> -    }
> -
> -    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
> -        error_setg(errp, "RDMA ERROR: "
> -                   "Linux kernel's RoCE / iWARP does not support IPv6 "
> -                   "(but patches on linux-rdma in progress)");
> -        return -1;
> -    }
> -
> -#endif
> -
> -    return 0;
> -}
> -
>   /*
>    * Figure out which RDMA device corresponds to the requested IP hostname
>    * Also create the initial connection manager identifiers for opening
> @@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
>           ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>                   RDMA_RESOLVE_TIMEOUT_MS);
>           if (ret >= 0) {
> -            if (e->ai_family == AF_INET6) {
> -                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
> -                                                   local_errp);
> -                if (ret < 0) {
> -                    continue;
> -                }
> -            }
>               error_free(err);
>               goto route;
>           }
> @@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
>           if (ret < 0) {
>               continue;
>           }
> -        if (e->ai_family == AF_INET6) {
> -            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> -                                               local_errp);
> -            if (ret < 0) {
> -                continue;
> -            }
> -        }
>           error_free(err);
>           break;
>       }
--------------0QKeZsXDRuAj9Zm00KDaCOJr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Excellent find. Thank you very much for checking on the history.
      Hopefully my comments were not too hard to read. =)<br>
      <br>
      FYI: I've since left Akamai last year and now work at Nvidia. <br>
      <br>
      <span
style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;"
      id="docs-internal-guid-a0b80d43-7fff-af1c-cef3-0fa87a1a56f8">Reviewed-by: Michael Galaxy <a class="moz-txt-link-rfc2396E" href="mailto:mrgalaxy@nvidia.com">&lt;mrgalaxy@nvidia.com&gt;</a>

</span></p>
    <div class="moz-cite-prefix">On 3/26/25 04:52, Jack Wang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250326095224.9918-1-jinpu.wang@ionos.com">
      <pre wrap="" class="moz-quote-pre">I hit following error which testing migration in pure RoCE env:
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

Cc: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com">&lt;peterx@redhat.com&gt;</a>
Cc: Li Zhijian <a class="moz-txt-link-rfc2396E" href="mailto:lizhijian@fujitsu.com">&lt;lizhijian@fujitsu.com&gt;</a>
Cc: Yu Zhang <a class="moz-txt-link-rfc2396E" href="mailto:yu.zhang@ionos.com">&lt;yu.zhang@ionos.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-rdma@vger.kernel.org">linux-rdma@vger.kernel.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:michael@flatgalaxy.com">michael@flatgalaxy.com</a>
Signed-off-by: Jack Wang <a class="moz-txt-link-rfc2396E" href="mailto:jinpu.wang@ionos.com">&lt;jinpu.wang@ionos.com&gt;</a>
---
 migration/rdma.c | 157 -----------------------------------------------
 1 file changed, 157 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 76fb0349238a..5ce628ddeef0 100644
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
-        struct ibv_device **dev_list = ibv_get_device_list(&amp;num_devices);
-        bool roce_found = false;
-        bool ib_found = false;
-
-        for (int x = 0; x &lt; num_devices; x++) {
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
-            if (ibv_query_port(verbs, 1, &amp;port_attr)) {
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
-    if (ibv_query_port(verbs, 1, &amp;port_attr)) {
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
@@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
         ret = rdma_resolve_addr(rdma-&gt;cm_id, NULL, e-&gt;ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
         if (ret &gt;= 0) {
-            if (e-&gt;ai_family == AF_INET6) {
-                ret = qemu_rdma_broken_ipv6_kernel(rdma-&gt;cm_id-&gt;verbs,
-                                                   local_errp);
-                if (ret &lt; 0) {
-                    continue;
-                }
-            }
             error_free(err);
             goto route;
         }
@@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         if (ret &lt; 0) {
             continue;
         }
-        if (e-&gt;ai_family == AF_INET6) {
-            ret = qemu_rdma_broken_ipv6_kernel(listen_id-&gt;verbs,
-                                               local_errp);
-            if (ret &lt; 0) {
-                continue;
-            }
-        }
         error_free(err);
         break;
     }
</pre>
    </blockquote>
  </body>
</html>

--------------0QKeZsXDRuAj9Zm00KDaCOJr--

