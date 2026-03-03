Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46596EDA68D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSpU-0003iz-M1; Tue, 03 Mar 2026 11:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSpP-0003V8-3o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSpA-00069Z-ID
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772556139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CmRnhrPoWTJMnAa0/tkjzZE5IhCFmR9/52zORg0fgBM=;
 b=REtHl0S6YeKVvrjmbxce1wPQEIamjNsY6H9RXRFsI+ZmthDyurIUW8REs7F863dwHx05gP
 uWfTbssEA3V2oYpWafyS0sRB+Htr6OFDwLsgL3JYk/YcLCwSOWH9MGmirTZkg9hg0sNOIJ
 gNijvRFuifTug1PzgCikkcciqOxZuWU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-oPIsdAebMRGHiKZJZtBm4g-1; Tue, 03 Mar 2026 11:42:18 -0500
X-MC-Unique: oPIsdAebMRGHiKZJZtBm4g-1
X-Mimecast-MFC-AGG-ID: oPIsdAebMRGHiKZJZtBm4g_1772556137
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb4e37a796so3715591685a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772556137; x=1773160937; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CmRnhrPoWTJMnAa0/tkjzZE5IhCFmR9/52zORg0fgBM=;
 b=oTz/wpklCeN78O2O7LIlKguk11w9UPuxW8uLAzY45EPswbiWuqfjNQHCkBFW0U7Obz
 mqUxtdXItHb7C5W406OVhAo5rIEAGoXVmKZTRbzFQd4cRk0pU2FI3yGXrD+gAcO2TyV4
 lakjDTrZDF6u3kXLtYLFXOh9t6GxPYvFS4XXLsHTsMY1QFLsX/xT0KeXzUZozUgfkyJe
 DwVp/YRloT3hx0Bm8Q6mjCTywbEevKyTDrPxoAzbCwLuuh6bKbeAKJGeZMMjaWi546+x
 28gdEEMgAFTlH//J9ZBzqgrkiEYZbi3rhfN4iMHhswntqsXPpAJF0zL8Ah1YADZIv9Cl
 v9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772556137; x=1773160937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmRnhrPoWTJMnAa0/tkjzZE5IhCFmR9/52zORg0fgBM=;
 b=iFf8Iv0JVoXIYJnDVUx5T9BTwQyfIwROY22Z6dvpHzziY3m69JSSoxdjCX8KKQpnMK
 qMzqkxWV5GfLS1MDacag/EtLDepjcRybEF1TlhlV8FjGC3YMSFFMDdoY8y9I51tR5mXl
 71DjqX4u4yOCDnECTSH/I7fBNgHlivryTIT1VJw9QRPgTl7TdML0o4Wsko1BZzi5eClb
 K6UhjPTt2Tk/TkCQOBhX/SNI2UFhZAuzEMHUtn4yisxL48F6EA3hiMV2u7Neh2210X/y
 CEwbpXt6y0U1mu6t4uRrFvTBtl7RRCu2lUnSKkbR0/QamJmS4BpV1Vf996f9MGksUuxL
 MNwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFH3/YRpQGgqWoM/wp/AHec60qzaufAyDbe0y1OTFtheLJsDe4tmGu8/leDxal3NWmNgK/64AZLWev@nongnu.org
X-Gm-Message-State: AOJu0YzJx3e/4Kq7dCn7Q1JiqczKtRqp8m/qWVkfzZwbjU58v+frH/wi
 XZ825i886vCCW7PgBGFRKOS+EWgZO3gX55R0X2QH9kZEe3KITNXQ7sMMHi+WDgaCphY07HPX1ex
 icFY4D5cAxLvmpuFkwNzDFaeeWdXMoFNSVerd8Xk9IwKkA+1dgGNc/tVn
X-Gm-Gg: ATEYQzzbf8VuWc2wQ3URisk6kx7xkwUK7SaQNpQqEZBgme2E2AcYnHEk8YApzoYIwY3
 a/R+yBn//CqqIpbtH/M5k2slhgpLtwQdqhjWfSzxQ8nJZnZBHBYXcGuArYBwWPJKyPozHJ4oe43
 U6i3js4l6jLnHqOY+F8w/eqE1kEfed3YP+zLBPeAZB0ayZT/HfDkcQgGVOrVxp5baScykVFcSLK
 vNJ7bJVNdWP2Maje8SEgSTyy9dvvVVHoLS2wON4GYtljLp48rI3STFT2RSH7W/LAexgIuhHTQ0w
 OAyKfcO8BXjgQFB5GjGaGcruAZ1OGQ7aOcEoAjAA+j2XotRhBDxhgzSBiEdZ8gzEtGSjufy4QEY
 QvHPQrP+5Y/mqCQ==
X-Received: by 2002:a05:620a:3187:b0:8cb:7ad5:6c09 with SMTP id
 af79cd13be357-8cbc8d85c10mr2206467385a.24.1772556137081; 
 Tue, 03 Mar 2026 08:42:17 -0800 (PST)
X-Received: by 2002:a05:620a:3187:b0:8cb:7ad5:6c09 with SMTP id
 af79cd13be357-8cbc8d85c10mr2206460985a.24.1772556136440; 
 Tue, 03 Mar 2026 08:42:16 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a04849cb3sm33503926d6.6.2026.03.03.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:42:16 -0800 (PST)
Date: Tue, 3 Mar 2026 11:42:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 15/16] migration/savevm: move to new migration APIs
Message-ID: <aacPXDprRcJPtGf1@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-16-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-16-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 21, 2026 at 12:02:13AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial thing to mention below.

> ---
>  migration/savevm.c | 107 +++++++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 52 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c5236e71ba..8c001d7468 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -205,27 +205,28 @@ void timer_get(QEMUFile *f, QEMUTimer *ts)
>   * Not in vmstate.c to not add qemu-timer.c as dependency to vmstate.c
>   */
>  
> -static int get_timer(QEMUFile *f, void *pv, size_t size,
> -                     const VMStateField *field)
> +static bool load_timer(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, Error **errp)
>  {
>      QEMUTimer *v = pv;
>      timer_get(f, v);
> -    return 0;
> +    return true;
>  }
>  
> -static int put_timer(QEMUFile *f, void *pv, size_t size,
> -                     const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_timer(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, JSONWriter *vmdesc,
> +                       Error **errp)
>  {
>      QEMUTimer *v = pv;
>      timer_put(f, v);
>  
> -    return 0;
> +    return true;
>  }
>  
>  const VMStateInfo vmstate_info_timer = {
>      .name = "timer",
> -    .get  = get_timer,
> -    .put  = put_timer,
> +    .load  = load_timer,
> +    .save  = save_timer,
>  };
>  
>  
> @@ -297,7 +298,7 @@ static uint32_t get_validatable_capabilities_count(void)
>      return result;
>  }
>  
> -static int configuration_pre_save(void *opaque)
> +static bool configuration_pre_save(void *opaque, Error **errp)
>  {
>      SaveState *state = opaque;
>      const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
> @@ -318,7 +319,7 @@ static int configuration_pre_save(void *opaque)
>      }
>      state->uuid = qemu_uuid;
>  
> -    return 0;
> +    return true;
>  }
>  
>  static void configuration_post_save(void *opaque)
> @@ -330,7 +331,7 @@ static void configuration_post_save(void *opaque)
>      state->caps_count = 0;
>  }
>  
> -static int configuration_pre_load(void *opaque)
> +static bool configuration_pre_load(void *opaque, Error **errp)
>  {
>      SaveState *state = opaque;
>  
> @@ -339,7 +340,7 @@ static int configuration_pre_load(void *opaque)
>       * minimum possible value for this CPU.
>       */
>      state->target_page_bits = migration_legacy_page_bits();
> -    return 0;
> +    return true;
>  }
>  
>  static bool configuration_validate_capabilities(SaveState *state)
> @@ -376,28 +377,31 @@ static bool configuration_validate_capabilities(SaveState *state)
>      return ret;
>  }
>  
> -static int configuration_post_load(void *opaque, int version_id)
> +static bool configuration_post_load(void *opaque, int version_id, Error **errp)
>  {
>      SaveState *state = opaque;
>      const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
> -    int ret = 0;
> +    bool ok = true;
>  
>      if (strncmp(state->name, current_name, state->len) != 0) {
> -        error_report("Machine type received is '%.*s' and local is '%s'",
> -                     (int) state->len, state->name, current_name);
> -        ret = -EINVAL;
> +        error_setg(errp,
> +                   "Machine type received is '%.*s' and local is '%s'",
> +                   (int) state->len, state->name, current_name);
> +        ok = false;
>          goto out;
>      }
>  
>      if (state->target_page_bits != qemu_target_page_bits()) {
> -        error_report("Received TARGET_PAGE_BITS is %d but local is %d",
> -                     state->target_page_bits, qemu_target_page_bits());
> -        ret = -EINVAL;
> +        error_setg(errp,
> +                   "Received TARGET_PAGE_BITS is %d but local is %d",
> +                   state->target_page_bits, qemu_target_page_bits());
> +        ok = false;
>          goto out;
>      }
>  
>      if (!configuration_validate_capabilities(state)) {
> -        ret = -EINVAL;
> +        error_setg(errp, "Failed to validate capabilities");
> +        ok = false;
>          goto out;
>      }
>  
> @@ -409,11 +413,12 @@ out:
>      state->capabilities = NULL;
>      state->caps_count = 0;
>  
> -    return ret;
> +    return ok;
>  }
>  
> -static int get_capability(QEMUFile *f, void *pv, size_t size,
> -                          const VMStateField *field)
> +static bool load_capability(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field,
> +                            Error **errp)
>  {
>      MigrationCapability *capability = pv;
>      char capability_str[UINT8_MAX + 1];
> @@ -426,15 +431,16 @@ static int get_capability(QEMUFile *f, void *pv, size_t size,
>      for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>          if (!strcmp(MigrationCapability_str(i), capability_str)) {
>              *capability = i;
> -            return 0;
> +            return true;
>          }
>      }
> -    error_report("Received unknown capability %s", capability_str);
> -    return -EINVAL;
> +    error_setg(errp, "Received unknown capability %s", capability_str);
> +    return false;
>  }
>  
> -static int put_capability(QEMUFile *f, void *pv, size_t size,
> -                          const VMStateField *field, JSONWriter *vmdesc)
> +static bool save_capability(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdesc,
> +                            Error **errp)
>  {
>      MigrationCapability *capability = pv;
>      const char *capability_str = MigrationCapability_str(*capability);
> @@ -443,13 +449,13 @@ static int put_capability(QEMUFile *f, void *pv, size_t size,
>  
>      qemu_put_byte(f, len);
>      qemu_put_buffer(f, (uint8_t *)capability_str, len);
> -    return 0;
> +    return true;
>  }
>  
>  static const VMStateInfo vmstate_info_capability = {
>      .name = "capability",
> -    .get  = get_capability,
> -    .put  = put_capability,
> +    .load = load_capability,
> +    .save = save_capability,
>  };
>  
>  /* The target-page-bits subsection is present only if the
> @@ -539,9 +545,9 @@ static const VMStateDescription vmstate_uuid = {
>  static const VMStateDescription vmstate_configuration = {
>      .name = "configuration",
>      .version_id = 1,
> -    .pre_load = configuration_pre_load,
> -    .post_load = configuration_post_load,
> -    .pre_save = configuration_pre_save,
> +    .pre_load_errp = configuration_pre_load,
> +    .post_load_errp = configuration_post_load,
> +    .pre_save_errp = configuration_pre_save,
>      .post_save = configuration_post_save,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(len, SaveState),
> @@ -969,8 +975,13 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
>          }
>          return ret;
>      }
> -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> -                              errp);
> +
> +    if (!vmstate_load_vmsd(f, se->vmsd, se->opaque, se->load_version_id,
> +                           errp)) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
>  }
>  
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -1028,8 +1039,6 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
>  static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
>                          Error **errp)
>  {
> -    int ret;
> -
>      if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
>          return 0;
>      }
> @@ -1049,12 +1058,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
>      trace_vmstate_save(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
>      if (!se->vmsd) {
>          vmstate_save_old_style(f, se, vmdesc);
> -    } else {
> -        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
> -                                 errp);
> -        if (ret) {
> -            return ret;
> -        }
> +    } else if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
> +        return -EINVAL;
>      }

I understand you may prefer merging them whenever possible, but for things
like this personally I normally keep "else" and "if" separate:

      if (!se->vmsd) {
          vmstate_save_old_style(f, se, vmdesc);
      } else {
          if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
              return -EINVAL;
          }
      }

"if" / "else if" can hid problems when we grow the condition in the future
(I recall we hit one when reviewing the other series adding the _errp()
variances).  That doesn't apply here but split "if" and "else" also helps
slightly on readabilty for me, so it says: there's no priority of doing
old_style or vmsd_style, it's just that we support both with/without vmsd
pointer, and it shows clearly what we do on which path.

I would expect the compiler will always generate the same byte code, but I
didn't check.

No strong feelings.

>  
>      trace_savevm_section_end(se->idstr, se->section_id, 0);
> @@ -1317,8 +1322,8 @@ static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
>          json_writer_start_object(vmdesc, "configuration");
>      }
>  
> -    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
> -                       vmdesc, &local_err);
> +    vmstate_save_vmsd(f, &vmstate_configuration, &savevm_state,
> +                      vmdesc, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>      }
> @@ -2748,7 +2753,6 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
>  static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
>  {
>      unsigned int v;
> -    int ret;
>  
>      v = qemu_get_be32(f);
>      if (v != QEMU_VM_FILE_MAGIC) {
> @@ -2779,10 +2783,9 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
>              return -EINVAL;
>          }
>  
> -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> -                                 errp);
> -        if (ret) {
> -            return ret;
> +        if (!vmstate_load_vmsd(f, &vmstate_configuration, &savevm_state, 0,
> +                               errp)) {
> +            return -EINVAL;
>          }
>      }
>      return 0;
> -- 
> 2.52.0
> 

-- 
Peter Xu


