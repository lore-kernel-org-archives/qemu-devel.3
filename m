Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A975FCB624
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 23:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyeTE-0007sq-PQ; Fri, 06 Mar 2026 18:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyeTD-0007sa-JU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 18:20:35 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vyeTB-0006mC-Hz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 18:20:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C82275BDAB;
 Fri,  6 Mar 2026 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772839228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEoLP155paFJ+AY3oJgFzzeherirP3VmV2rOTHID4pc=;
 b=a6bWpH38KSa9ljJbUu8Ak/dAedEXUVAUyIMUsKHseISkpUO6LuWGt/Pa73JIcTfdBfqDtH
 xPoUmP0p9v6Z41tbxjlj9cOmbxavsUJidXcugpp/kQkDmeHaRMg3vAkzAF/OgSTWSwlvRd
 yuo6WFHfnOVtn/O1immo0OUlf0ST4VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772839228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEoLP155paFJ+AY3oJgFzzeherirP3VmV2rOTHID4pc=;
 b=3qAwMSV0xYaK/f/T24jIRjmivz2tw4LVMoAGRj+YH4hSxk+EvCzr7KjVZhyH3YZl81Zmy6
 /WlRt8GVBa3cpBDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1mgO7iwC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ANnK0qaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772839227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEoLP155paFJ+AY3oJgFzzeherirP3VmV2rOTHID4pc=;
 b=1mgO7iwCSlUmA1fsI8GReLcGWn6Z9mM1ubn0Xz76Is5drdEdB94Ytqmbp/LKzVL/Br5kdX
 8bSOp7tNES7N7VeKw5CMvLN0f6D+nQK9LVxk8wO+6BaWI49TJ9u4ORi9muBuAJERAnJwX4
 MBdzAUClil5RVpnc9NTToCa6ebW0+ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772839227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEoLP155paFJ+AY3oJgFzzeherirP3VmV2rOTHID4pc=;
 b=ANnK0qazit+qSL9MoXshP6UPd6s7M5J8FxZAD4RZokSaSHltVEkzCVV8dABh2ypt/cz4k7
 HUJNU4qDQFay0YBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 452693EA75;
 Fri,  6 Mar 2026 23:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E9v9Ajthq2lpXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Mar 2026 23:20:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, qemu-devel@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:sPAPR (pseries)"
 <qemu-ppc@nongnu.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/18] migration: make .post_save() a void function
In-Reply-To: <20260304212303.667141-4-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-4-vsementsov@yandex-team.ru>
Date: Fri, 06 Mar 2026 20:20:24 -0300
Message-ID: <87o6l01r5z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[yandex-team.ru,nongnu.org,linaro.org,gmail.com,linux.ibm.com,intel.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C82275BDAB
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> All other handlers now have _errp() variants. Should we go this way
> for .post_save()? Actually it's rather strange, when the vmstate do
> successful preparations in .pre_save(), then successfully save all
> sections and subsections, end then fail when all the state is
> successfully transferred to the target.
>
> Happily, we have only three .post_save() realizations, all always
> successful. Let's make this a rule.
>
> Also note, that we call .post_save() in two places, and handle
> its (theoretical) failure inconsistently. Fix that too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/main.rst |  2 +-
>  hw/ppc/spapr_pci.c            |  3 +--
>  include/migration/vmstate.h   |  8 +++++++-
>  migration/savevm.c            |  3 +--
>  migration/vmstate.c           | 12 +++---------
>  target/arm/machine.c          |  4 +---
>  6 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 234d280249a..2de70507640 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
>  
>    This function is called before we save the state of one device.
>  
> -- ``int (*post_save)(void *opaque);``
> +- ``void (*post_save)(void *opaque);``
>  
>    This function is called after we save the state of one device
>    (even upon failure, unless the call to pre_save returned an error).
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ea998bdff15..1dc3b02659f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2093,14 +2093,13 @@ static int spapr_pci_pre_save(void *opaque)
>      return 0;
>  }
>  
> -static int spapr_pci_post_save(void *opaque)
> +static void spapr_pci_post_save(void *opaque)
>  {
>      SpaprPhbState *sphb = opaque;
>  
>      g_free(sphb->msi_devs);
>      sphb->msi_devs = NULL;
>      sphb->msi_devs_num = 0;
> -    return 0;
>  }
>  
>  static int spapr_pci_post_load(void *opaque, int version_id)
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 3695afd483f..85838a49aee 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -223,7 +223,13 @@ struct VMStateDescription {
>      bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>      int (*pre_save)(void *opaque);
>      bool (*pre_save_errp)(void *opaque, Error **errp);
> -    int (*post_save)(void *opaque);
> +
> +    /*
> +     * Unless .pre_save() fails, .post_save() is called after saving
> +     * fields and subsections. It should not fail because at this
> +     * point the state has potentially already been transferred.
> +     */
> +    void (*post_save)(void *opaque);

+CC Paolo, Zhao

This change breaks the rust build:
https://gitlab.com/farosas/qemu/-/jobs/13393119755

  error[E0308]: mismatched types
     --> ../rust/migration/src/vmstate.rs:605:18
      |
  605 |             Some(vmstate_no_version_cb::<T, F>)
      |             ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
      |             |
      |             arguments to this enum variant are incorrect
      |
      = note: expected fn pointer `unsafe extern "C" fn(_) -> ()`
                    found fn item `unsafe extern "C" fn(_) -> i32 {vmstate_no_version_cb::<T, F, impl Into<Errno>>}`


Is something like the following diff the right fix? It'd be nice to get
an ack so this series doesn't miss the freeze. (CI run:
https://gitlab.com/farosas/qemu/-/pipelines/2369688593)

-- >8 --
From 90a7b53d2b0d53692df1ef2cfe7607b13e4961d8 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Fri, 6 Mar 2026 18:53:14 -0300
Subject: [PATCH] fixup! migration: make .post_save() a void function

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 rust/migration/src/migratable.rs |  3 +--
 rust/migration/src/vmstate.rs    | 12 +++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index 7748aac2f2..7088c1b156 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -406,10 +406,9 @@ fn pre_save(&self) -> Result<(), InvalidError> {
         Ok(())
     }
 
-    fn post_save(&self) -> Result<(), InvalidError> {
+    fn post_save(&self) {
         let state = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
         drop(state);
-        Ok(())
     }
 
     fn pre_load(&self) -> Result<(), InvalidError> {
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index edc7c70265..f34a36f680 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -492,6 +492,11 @@ fn from(_value: InvalidError) -> Errno {
     into_neg_errno(result)
 }
 
+unsafe extern "C" fn vmstate_post_save_cb<T, F: for<'a> FnCall<(&'a T,), ()>>(opaque: *mut c_void) {
+    // SAFETY: the function is used in T's implementation of VMState.
+    F::call((unsafe { &*(opaque.cast::<T>()) },));
+}
+
 unsafe extern "C" fn vmstate_post_load_cb<
     T,
     F: for<'a> FnCall<(&'a T, u8), Result<(), impl Into<Errno>>>,
@@ -597,12 +602,9 @@ pub const fn pre_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>
     }
 
     #[must_use]
-    pub const fn post_save<F: for<'a> FnCall<(&'a T,), Result<(), impl Into<Errno>>>>(
-        mut self,
-        _f: &F,
-    ) -> Self {
+    pub const fn post_save<F: for<'a> FnCall<(&'a T,), ()>>(mut self, _f: &F) -> Self {
         self.0.post_save = if F::IS_SOME {
-            Some(vmstate_no_version_cb::<T, F>)
+            Some(vmstate_post_save_cb::<T, F>)
         } else {
             None
         };
-- 
2.51.0


