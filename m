Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCE4C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 23:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgB6l-0002q6-Ql; Thu, 06 Feb 2025 18:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgB6j-0002py-O1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 18:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgB6h-0006hS-4F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 18:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738883785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQjCbaMmyEQ9iWu8KqijQmLbeqKu9Xlg5S4NHn5FL7c=;
 b=B4ayPRlQW8ssRBjMA2asmL4om/Oru1GYCoYz5bYG04SrP5XG/UgKLK+et6qcpD9CzxO1Qc
 VwgNgAIgDFStCIcCDunvV0P/ZFs4WaHSQCpFVo1OTmUuJXuJo46fXNKKHq+Z9Ukv45uPtL
 sL49Yq3KpOS8995lSIzxCskReBdnBx4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1pKgTYOROTucmXT5QFOHyQ-1; Thu, 06 Feb 2025 18:16:23 -0500
X-MC-Unique: 1pKgTYOROTucmXT5QFOHyQ-1
X-Mimecast-MFC-AGG-ID: 1pKgTYOROTucmXT5QFOHyQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e44150a32dso22139446d6.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 15:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738883783; x=1739488583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQjCbaMmyEQ9iWu8KqijQmLbeqKu9Xlg5S4NHn5FL7c=;
 b=hXa9s/TblpC3RQiUo3YA1Cj2RNIkB5AqEc6mlLcUi/JJOV4nL2aMaCxrIpRMp5HBSJ
 ILpXVaA0/lGZqR/snXTe3pZnNZJul7ZnfPhm8SpagZ6NR2AzHwVrEinKdPKYWWgUrsKb
 zsWcs2yhmKP06yQkE+wCNTHmFw16JhoRGTc6lh0IA3J/vFXp9xbDPHqu8GU+4CQDtxc3
 ysdkLLenlJEBXhZJQo6ln8KTxRVapXWLYxzBpMfh9cEXScJ0GhdC/pyRL/4gGEIeDwqM
 tLKdFRr+kBSUtdAMoFb/h/Y+mw1TmSM9SIIFPMmPsgHgb5Km0AXa5Wl3St7uobzN4DC2
 eFrg==
X-Gm-Message-State: AOJu0YyUFOi7JCMO/vQhOyuWo8m2jroFBrJhr7Cd5XUdd/5CaosapBwv
 WAfpSCOUw8m3JKJWkmrXeHt3oYc6miNjMAUBanturE0uO+4vLHL1MbTiK6HWUjT2IEnW4Thuowy
 v4URsZvcs7J81dEctms2z1x/cRsSt1B4ut89U1tfZIc2j8Tmuu/af
X-Gm-Gg: ASbGncviAyf8vb3sdhC/SzBDDFJpLfVsRY75RAybRgdTsIVEYy348BDP6Md4oMhsXpL
 BBtmph6HYcbFoto82v+RjND+rWlRmwZxzB7WDxqkmqOc5rvvxpG7Q6vd86jwMilfRjVjhGkdcs8
 vIqmUfafACHXOUofSTZl3M/btzil7LiyIHZz6g8sSUdvyZVM3fp3vVhnS5GtsamrcusCQt4Jo46
 xPtOWujLtqqvdLnhzeoYQzfPfN85Hdjb28TMCuZ3u5fiPXf1A7eSof0Lt2Y23HUsCp3ZHiE4vdv
 6aj2lQuRdcVtwy7VGluTj5wOYdweSudeLOFQ7paUPIyOwDz8
X-Received: by 2002:ad4:576b:0:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6e4455c5bb5mr16579656d6.9.1738883783188; 
 Thu, 06 Feb 2025 15:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT31fIrSmRms4CRinNFUzwsSJsmhfmKTf2Gl8JEqjmUs7Ij7LpnNxG8OzBaIT/l4s9nT26vw==
X-Received: by 2002:ad4:576b:0:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6e4455c5bb5mr16579186d6.9.1738883782688; 
 Thu, 06 Feb 2025 15:16:22 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e4437ddc85sm3648796d6.87.2025.02.06.15.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:16:22 -0800 (PST)
Date: Thu, 6 Feb 2025 18:16:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6VCxEKxn6-_okRx@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205122712.229151-4-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Feb 05, 2025 at 05:57:10PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Enable Multifd and Postcopy migration together.
> The migration_ioc_process_incoming() routine
> checks magic value sent on each channel and
> helps to properly setup multifd and postcopy
> channels.
> 
> The Precopy and Multifd threads work during the
> initial guest RAM transfer. When migration moves
> to the Postcopy phase, the multifd threads are
> restrained and Postcopy threads on the destination
> request/pull data from the source side.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c      | 106 +++++++++++++++++++++++--------------
>  migration/multifd-nocomp.c |   3 +-
>  migration/options.c        |   5 --
>  migration/ram.c            |   4 +-
>  4 files changed, 70 insertions(+), 48 deletions(-)
> 
> v4: no change
> - https://lore.kernel.org/qemu-devel/20250127120823.144949-1-ppandit@redhat.com/T/#t
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 2d1da917c7..a280722e9e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -92,6 +92,9 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>  
> +/* Migration channel types */
> +enum { CH_DEFAULT, CH_MULTIFD, CH_POSTCOPY };

Maybe s/DEFAULT/MAIN/?

> +
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -929,26 +932,33 @@ void migration_fd_process_incoming(QEMUFile *f)
>  /*
>   * Returns true when we want to start a new incoming migration process,
>   * false otherwise.
> + *
> + * All the required channels must be in place before a new incoming
> + * migration process starts.
> + *  - Multifd enabled:
> + *    The main channel and the multifd channels are required.
> + *  - Multifd/Postcopy disabled:
> + *    The main channel is required.
> + *  - Postcopy enabled:
> + *    We don't want to start a new incoming migration when
> + *    the postcopy channel is created. Because it is created
> + *    towards the end of the precopy migration.
> + *
>   */
> -static bool migration_should_start_incoming(bool main_channel)
> +static bool migration_should_start_incoming(uint8_t channel)
>  {
> -    /* Multifd doesn't start unless all channels are established */
> -    if (migrate_multifd()) {
> -        return migration_has_all_channels();
> -    }
> +    bool ret = false;
> +
> +    if (channel != CH_POSTCOPY) {
> +        MigrationIncomingState *mis = migration_incoming_get_current();
> +        ret = mis->from_src_file ? true : false;
>  
> -    /* Preempt channel only starts when the main channel is created */
> -    if (migrate_postcopy_preempt()) {
> -        return main_channel;
> +        if (ret && migrate_multifd()) {
> +            ret = multifd_recv_all_channels_created();
> +        }
>      }
>  
> -    /*
> -     * For all the rest types of migration, we should only reach here when
> -     * it's the main channel that's being created, and we should always
> -     * proceed with this channel.
> -     */
> -    assert(main_channel);
> -    return true;
> +    return ret;
>  }
>  
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> @@ -956,13 +966,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>      QEMUFile *f;
> -    bool default_channel = true;
>      uint32_t channel_magic = 0;
> +    uint8_t channel = CH_DEFAULT;
>      int ret = 0;
>  
> -    if (migrate_multifd() && !migrate_mapped_ram() &&
> -        !migrate_postcopy_ram() &&
> -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> +    if (!migration_should_start_incoming(channel)) {

This says "if we assume this is the main channel, and if we shouldn't start
incoming migration, then we should peek at the buffers".

Could you help explain?

> +        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>          /*
>           * With multiple channels, it is possible that we receive channels
>           * out of order on destination side, causing incorrect mapping of
> @@ -973,42 +982,58 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>           * tls handshake while initializing main channel so with tls this
>           * issue is not possible.
>           */
> -        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> -                                          sizeof(channel_magic), errp);
> +            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> +                                              sizeof(channel_magic), errp);
> +            if (ret != 0) {
> +                return;
> +            }
>  
> -        if (ret != 0) {
> -            return;
> +            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
> +                channel = CH_DEFAULT;
> +            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
> +                channel = CH_MULTIFD;
> +            } else if (!mis->from_src_file
> +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +                /* reconnect default channel for postcopy recovery */
> +                channel = CH_DEFAULT;

This is still in the big "peek buffer" if condition.

IMHO we can skip peeking buffer when postcopy paused, because in this stage
the channel must be (1) main channel first, then (2) preempt channel next.

> +            } else {
> +                error_report("%s: could not identify channel, unknown magic: %u",
> +                                __func__, channel_magic);
> +                return;
> +            }
> +        } else if (mis->from_src_file
> +            && (!strcmp(ioc->name, "migration-tls-incoming")
> +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> +            channel = CH_MULTIFD;

Confused here too.  Why do we need to check ioc name? Shouldn't multifd has
the headers?

>          }
> -
> -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> -    } else {
> -        default_channel = !mis->from_src_file;
> +    } else if (mis->from_src_file) { // && migrate_postcopy_preempt()
> +        channel = CH_POSTCOPY;
>      }
>  
>      if (multifd_recv_setup(errp) != 0) {
>          return;
>      }
>  
> -    if (default_channel) {
> +    if (channel == CH_DEFAULT) {
>          f = qemu_file_new_input(ioc);
>          migration_incoming_setup(f);
> -    } else {
> +    } else if (channel == CH_MULTIFD) {
>          /* Multiple connections */
> -        assert(migration_needs_multiple_sockets());

Could I ask why removal?

>          if (migrate_multifd()) {
>              multifd_recv_new_channel(ioc, &local_err);
> -        } else {
> -            assert(migrate_postcopy_preempt());
> -            f = qemu_file_new_input(ioc);
> -            postcopy_preempt_new_channel(mis, f);
>          }
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> +    } else if (channel == CH_POSTCOPY) {
> +        assert(migrate_postcopy_preempt());
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
>      }
>  
> -    if (migration_should_start_incoming(default_channel)) {
> +    if (migration_should_start_incoming(channel)) {
>          /* If it's a recovery, we're done */
>          if (postcopy_try_recover()) {
>              return;
> @@ -1025,21 +1050,22 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>   */
>  bool migration_has_all_channels(void)
>  {
> +    bool ret = false;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (!mis->from_src_file) {
> -        return false;
> +        return ret;
>      }
>  
>      if (migrate_multifd()) {
> -        return multifd_recv_all_channels_created();
> +        ret = multifd_recv_all_channels_created();
>      }
>  
> -    if (migrate_postcopy_preempt()) {
> -        return mis->postcopy_qemufile_dst != NULL;
> +    if (ret && migrate_postcopy_preempt()) {

It might be better to avoid such "ret && XXX" nested check.  E.g. do you
think below easier to read?

diff --git a/migration/migration.c b/migration/migration.c
index 74c50cc72c..9eb2f3fdeb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1064,12 +1064,14 @@ bool migration_has_all_channels(void)
         return false;
     }
 
-    if (migrate_multifd()) {
-        return multifd_recv_all_channels_created();
+    if (migrate_multifd() &&
+        !multifd_recv_all_channels_created()) {
+        return false;
     }
 
-    if (migrate_postcopy_preempt()) {
-        return mis->postcopy_qemufile_dst != NULL;
+    if (migrate_postcopy_preempt() &&
+        mis->postcopy_qemufile_dst == NULL) {
+        return false;
     }
 
     return true;

> +        ret = mis->postcopy_qemufile_dst != NULL;
>      }
>  
> -    return true;
> +    return ret;
>  }
>  
>  int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 1325dba97c..d0edec7cd1 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -16,6 +16,7 @@
>  #include "file.h"
>  #include "multifd.h"
>  #include "options.h"
> +#include "migration.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> @@ -391,7 +392,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
>      MultiFDSyncReq req;
>      int ret;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || migration_in_postcopy()) {
>          return 0;
>      }

[1]

>  
> diff --git a/migration/options.c b/migration/options.c
> index b8d5300326..8c878dea49 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -479,11 +479,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              error_setg(errp, "Postcopy is not compatible with ignore-shared");
>              return false;
>          }
> -
> -        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -            error_setg(errp, "Postcopy is not yet compatible with multifd");
> -            return false;
> -        }
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> diff --git a/migration/ram.c b/migration/ram.c
> index f2326788de..bdba7abe73 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1295,7 +1295,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (multifd_ram_sync_per_round()) {
> +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {

If you have above[1], why need this?

>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_ram_flush_and_sync(f);
>                  if (ret < 0) {
> @@ -1969,7 +1969,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>          }
>      }
>  
> -    if (migrate_multifd()) {
> +    if (migrate_multifd() && !migration_in_postcopy()) {
>          RAMBlock *block = pss->block;
>          return ram_save_multifd_page(block, offset);
>      }
> -- 
> 2.48.1
> 

This patch still did nothing for multifd in postcopy_start().  I'm not sure
it's safe.

What happens if some multifd pages were sent, then we start postcopy, dest
vcpu threads running, then during postcopy some multifd pages finally
arrived and modifying the guest pages during vcpus running?

Thanks,

-- 
Peter Xu


