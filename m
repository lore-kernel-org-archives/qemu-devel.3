Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06F9D5E374
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVVtH-0002Kv-RA; Tue, 16 Dec 2025 09:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVtE-0002KU-4p
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:19:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVVt9-00087n-Up
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:18:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30BFC336AB;
 Tue, 16 Dec 2025 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765894733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4CHdxOJU3qI5EBTc30kGFsXqkr5Eur+RFMrl6wkELwA=;
 b=CZr0vA7zTOmfNlkYqzOEDvR4t1clmRBZDm22EeHUvayEcRcnLllcLL3Vtp+RnWufne8t25
 6/YWMTA+7QrpR5GZ3vUQJ7yWaXpdVOjB+8Mw5+RlitVP6wACZv3az9i+ZLffeyqe15R1+e
 Jxzacw78kuMil3tsAPFjevAObX6kOOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765894733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4CHdxOJU3qI5EBTc30kGFsXqkr5Eur+RFMrl6wkELwA=;
 b=8jyeFM4e9vv3vmilGGySU85WN4t0GqxGxVVf5SW6A3WHFb1JjLKmKIfal0XPSCyZXdzzqN
 ziRcUPFe2celu5Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iSumMjeL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/RQkjtbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765894732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4CHdxOJU3qI5EBTc30kGFsXqkr5Eur+RFMrl6wkELwA=;
 b=iSumMjeL7fs3Ln2qLUqfTtC2A6hoL+igjINatzNrHRvVaRrlUqWF4hx8+nG8IMWcGrty6j
 unI3InfH6Y/YB2mrDy+AhCak4FfeerSQ1xuuJp9fIvUj73309Up0A78uWfsof4UyDDx4RB
 2f9EiF310Hx0pYBhn19jGC1KfZ0zvgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765894732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4CHdxOJU3qI5EBTc30kGFsXqkr5Eur+RFMrl6wkELwA=;
 b=/RQkjtbQdqyLLzNx+PGyBXoyHCXIZswiTWj01ffJrx1lnqeDU3Pz1azF4NquTkzLTl8tyD
 1JoildFl6NfolhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ECFB3EA63;
 Tue, 16 Dec 2025 14:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VBuaF0tqQWnqQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Dec 2025 14:18:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, peterx@redhat.com, Alexey Kardashevskiy
 <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
In-Reply-To: <20251215205203.1185099-12-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-12-peterx@redhat.com>
Date: Tue, 16 Dec 2025 11:18:48 -0300
Message-ID: <87qzsu1pdj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 30BFC336AB
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Support the guest-memfd type when the fd has init share enabled.  It means
> the gmemfd can be used similarly to memfd.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/framework.h |  4 +++
>  tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index ed85ed502d..b4c5edcad3 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -34,6 +34,10 @@ typedef enum {
>       * but only anonymously allocated.
>       */
>      MEM_TYPE_MEMFD,
> +    /*
> +     * Use guest-memfd, shared mappings.
> +     */
> +    MEM_TYPE_GUEST_MEMFD,
>      MEM_TYPE_NUM,
>  } MemType;
>  
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index e35839c95f..9aa353bac6 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -26,6 +26,10 @@
>  #include "qemu/range.h"
>  #include "qemu/sockets.h"
>  
> +#ifdef CONFIG_LINUX
> +#include <linux/kvm.h>
> +#include <sys/ioctl.h>
> +#endif
>  
>  #define QEMU_VM_FILE_MAGIC 0x5145564d
>  #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
> @@ -283,6 +287,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
>      case MEM_TYPE_MEMFD:
>          backend = g_strdup("-object memory-backend-memfd");
>          break;
> +    case MEM_TYPE_GUEST_MEMFD:
> +        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
> +        break;
>      default:
>          g_assert_not_reached();
>          break;
> @@ -425,8 +432,55 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>      return 0;
>  }
>  
> +static bool kvm_guest_memfd_init_shared_supported(const char **reason)

Should be in migration-util.c, like kvm_dirty_ring_supported() and
ufd_version_check().

> +{
> +    assert(*reason == NULL);
> +
> +#ifdef CONFIG_LINUX
> +    int ret, fd = -1;
> +
> +    if (!migration_get_env()->has_kvm) {
> +        *reason = "KVM is not enabled in the current QEMU build";
> +        goto out;
> +    }
> +
> +    fd = open("/dev/kvm", O_RDWR);
> +    if (fd < 0) {
> +        *reason = "KVM module isn't available or missing permission";
> +        goto out;
> +    }
> +
> +    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD);
> +    if (!ret) {
> +        *reason = "KVM module doesn't suport guest-memfd";
> +        goto out;
> +    }
> +
> +    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD_FLAGS);
> +    if (ret < 0) {

Should this be <= ? I see there's a window between the addition of
KVM_CAP_GUEST_MEMFD and KVM_CAP_GUEST_MEMFD_FLAGS in the kernel.

> +        *reason = "KVM doesn't support KVM_CAP_GUEST_MEMFD_FLAGS";
> +        goto out;
> +    }
> +
> +    if (!(ret & GUEST_MEMFD_FLAG_INIT_SHARED)) {
> +        *reason = "KVM doesn't support GUEST_MEMFD_FLAG_INIT_SHARED";
> +        goto out;
> +    }
> +out:
> +    if (fd >= 0) {
> +        close(fd);
> +    }
> +#else
> +    *reason = "KVM not supported on non-Linux OS";
> +#endif
> +
> +    return !*reason;
> +}
> +
>  static bool migrate_mem_type_prepare(MemType type)
>  {
> +    const char *reason = NULL;
> +
>      switch (type) {
>      case MEM_TYPE_SHMEM:
>          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> @@ -434,6 +488,12 @@ static bool migrate_mem_type_prepare(MemType type)
>              return false;
>          }
>          break;
> +    case MEM_TYPE_GUEST_MEMFD:
> +        if (!kvm_guest_memfd_init_shared_supported(&reason)) {
> +            g_test_skip(reason);
> +            return false;
> +        }
> +        break;
>      default:
>          break;
>      }

