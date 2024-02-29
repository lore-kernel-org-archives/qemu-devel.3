Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AD8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXl4-0003MX-1A; Wed, 28 Feb 2024 23:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXl0-0003MH-Hd
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXkv-0003us-5P
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709179847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdzd6VIUW3hlgCiE4T+P7eltHsKNEsk4aM3drN+iWHE=;
 b=O9tyD4voAOfW6+pSSUSrQgSFpHr2HnTJwcEpVir7XW8h1w03RyyxbJev/fqubhPB/Z7OGb
 Xxnt5FCJH8peIZfkl0yjgQI2p2WDqfNvbVsYo2ZRD5tbL3dqCi5sIfjb1/eJrZK9XKvdl3
 TOJdJ2eD63dPbse/dsrQG2eEfZAyc94=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-oOPU9fJ5OtCdhe2ej1GRFg-1; Wed, 28 Feb 2024 23:10:45 -0500
X-MC-Unique: oOPU9fJ5OtCdhe2ej1GRFg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso109870a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709179845; x=1709784645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdzd6VIUW3hlgCiE4T+P7eltHsKNEsk4aM3drN+iWHE=;
 b=egBi5LOl+gCm+Okx33QjRtq4JlIdIDJNX3O6/MQmFXcVn9kbryomEbkQ11iOdltPPw
 plkuoJfcy+zGyQw2zb7T8SgY0yc6igfjRQYG4fiYlk3XtM+k3mkx2kfp5yBldV20ULHy
 1m1KWQJVWoSgJyEP77xUhQ7UH1wYWryRb4RR9S6DmjNksGZRYOStTuYIx6KvTbh0fhMC
 RWMi65qj6QozK7IGI10aSUx1+jDfsx6YukMbM9Ev8yFT25vQ6DTVMsp7rcJxAbymI8yo
 4ejYD9nS0RfzV4IW4+PAM2wGzmqLkMTFl9PALjn8dE3KPfch7tB80VHuhxrvBZT/+1MZ
 9Z4w==
X-Gm-Message-State: AOJu0YxEjthzr56oivs1qTiBowQWt8NzPqTXj3mqFJ+sSu8T2w7+9tyD
 5ChloK5dJ1T57SU06JLmJBUaYNPU9qOJQaigRUWfDeHuFe8fTm/ytXdRfgycO0xvMrpZ+ggtNmD
 PEkscPVKqKWrhsX8Y0lc0LLh4LiXiBxnwwFljthYhKhDiPAjVfxkt
X-Received: by 2002:a05:6a00:1405:b0:6e5:35a7:5333 with SMTP id
 l5-20020a056a00140500b006e535a75333mr1251261pfu.2.1709179844655; 
 Wed, 28 Feb 2024 20:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2sGvdjs0f1rg+szna9mKRM4GK0kKYeov6CyGIYhbiROhbKsytvhfojqmXvLLh7bXFpZagw==
X-Received: by 2002:a05:6a00:1405:b0:6e5:35a7:5333 with SMTP id
 l5-20020a056a00140500b006e535a75333mr1251249pfu.2.1709179844209; 
 Wed, 28 Feb 2024 20:10:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z19-20020aa785d3000000b006e583a649b4sm225467pfn.210.2024.02.28.20.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 20:10:43 -0800 (PST)
Date: Thu, 29 Feb 2024 12:10:33 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 03/21] migration: Add documentation for SaveVMHandlers
Message-ID: <ZeADuRyAj0OBprh0@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-4-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-4-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 07:03:27PM +0100, Cédric Le Goater wrote:
> The SaveVMHandlers structure is still in use for complex subsystems
> and devices. Document the handlers since we are going to modify a few
> later.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Still a few nitpick comments below.

> ---
>  include/migration/register.h | 257 +++++++++++++++++++++++++++++++----
>  1 file changed, 231 insertions(+), 26 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 2e6a7d766e62f64940086b7b511249c9ff21fa62..2cc71ec45f65bf2884c9e7a823d2968752f15c20 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -16,30 +16,129 @@
>  
>  #include "hw/vmstate-if.h"
>  
> +/**
> + * struct SaveVMHandlers: handler structure to finely control
> + * migration of complex subsystems and devices, such as RAM, block and
> + * VFIO.
> + */
>  typedef struct SaveVMHandlers {
> -    /* This runs inside the BQL.  */
> +
> +    /* The following handlers runs inside the BQL. */
> +
> +    /**
> +     * @save_state
> +     *
> +     * Saves state section on the source using the latest state format
> +     * version.
> +     *
> +     * Legacy method. Should be deprecated when all users are ported
> +     * to VMState.

VMStateDescription?

> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     */
>      void (*save_state)(QEMUFile *f, void *opaque);
>  
> -    /*
> -     * save_prepare is called early, even before migration starts, and can be
> -     * used to perform early checks.
> +    /**
> +     * @save_prepare
> +     *
> +     * Called early, even before migration starts, and can be used to
> +     * perform early checks.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
>       */
>      int (*save_prepare)(void *opaque, Error **errp);
> +
> +    /**
> +     * @save_setup
> +     *
> +     * Initializes the data structures on the source and transmits
> +     * first section containing information on the device
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*save_setup)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @save_cleanup
> +     *
> +     * Performs save related cleanup
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      void (*save_cleanup)(void *opaque);
> +
> +    /**
> +     * @save_live_complete_postcopy
> +     *
> +     * Called at the end of postcopy for all postcopyiable devices.
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @save_live_complete_precopy
> +     *
> +     * Transmits the last section for the device containing any
> +     * remaining data.

This doesn't flush all remaining data when postcopy is enabled and
supported on the specific device.  Perhaps attach one more sentence to
describe that case?

  Transmits the last section for the device containing any remaining data
  at the end of a precopy phase.  When postcopy is enabled, devices that
  support postcopy will skip this step, where the final data will be
  flushed at the end of postcopy via @save_live_complete_postcopy instead.

> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>  
>      /* This runs both outside and inside the BQL.  */
> +
> +    /**
> +     * @is_active
> +     *
> +     * Will skip a state section if not active
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true if state section is active else false
> +     */
>      bool (*is_active)(void *opaque);
> +
> +    /**
> +     * @has_postcopy
> +     *
> +     * checks if a device supports postcopy
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true for postcopy support else false
> +     */
>      bool (*has_postcopy)(void *opaque);
>  
> -    /* is_active_iterate
> -     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
> -     * it returns false. For example, it is needed for only-postcopy-states,
> -     * which needs to be handled by qemu_savevm_state_setup and
> -     * qemu_savevm_state_pending, but do not need iterations until not in
> -     * postcopy stage.
> +    /**
> +     * @is_active_iterate
> +     *
> +     * As #SaveVMHandlers.is_active(), will skip an inactive state
> +     * section in qemu_savevm_state_iterate.
> +     *
> +     * For example, it is needed for only-postcopy-states, which needs
> +     * to be handled by qemu_savevm_state_setup() and
> +     * qemu_savevm_state_pending(), but do not need iterations until
> +     * not in postcopy stage.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true if state section is active else false
>       */
>      bool (*is_active_iterate)(void *opaque);
>  
> @@ -48,44 +147,150 @@ typedef struct SaveVMHandlers {
>       * use data that is local to the migration thread or protected
>       * by other locks.
>       */
> +
> +    /**
> +     * @save_live_iterate
> +     *
> +     * Should send a chunk of data until the point that stream
> +     * bandwidth limits tell it to stop. Each call generates one
> +     * section.
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*save_live_iterate)(QEMUFile *f, void *opaque);
>  
>      /* This runs outside the BQL!  */
> -    /* Note for save_live_pending:
> -     * must_precopy:
> -     * - must be migrated in precopy or in stopped state
> -     * - i.e. must be migrated before target start
> -     *
> -     * can_postcopy:
> -     * - can migrate in postcopy or in stopped state
> -     * - i.e. can migrate after target start
> -     * - some can also be migrated during precopy (RAM)
> -     * - some must be migrated after source stops (block-dirty-bitmap)
> -     *
> -     * Sum of can_postcopy and must_postcopy is the whole amount of
> +
> +    /**
> +     * @state_pending_estimate
> +     *
> +     * This estimates the remaining data to transfer
> +     *
> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>       * pending data.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @must_precopy: amount of data that must be migrated in precopy
> +     *                or in stopped state, i.e. that must be migrated
> +     *                before target start.
> +     * @can_postcopy: amount of data that can be migrated in postcopy
> +     *                or in stopped state, i.e. after target start.
> +     *                Some can also be migrated during precopy (RAM).
> +     *                Some must be migrated after source stops
> +     *                (block-dirty-bitmap)
>       */
> -    /* This estimates the remaining data to transfer */
>      void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
>                                     uint64_t *can_postcopy);
> -    /* This calculate the exact remaining data to transfer */
> +
> +    /**
> +     * @state_pending_exact
> +     *
> +     * This calculate the exact remaining data to transfer
> +     *
> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> +     * pending data.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @must_precopy: amount of data that must be migrated in precopy
> +     *                or in stopped state, i.e. that must be migrated
> +     *                before target start.
> +     * @can_postcopy: amount of data that can be migrated in postcopy
> +     *                or in stopped state, i.e. after target start.
> +     *                Some can also be migrated during precopy (RAM).
> +     *                Some must be migrated after source stops
> +     *                (block-dirty-bitmap)
> +     */
>      void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>                                  uint64_t *can_postcopy);
> +
> +    /**
> +     * @load_state
> +     *
> +     * Load sections generated by any of the save functions that
> +     * generate sections.
> +     *
> +     * Legacy method. Should be deprecated when all users are ported
> +     * to VMState.

VMStateDescription.

> +     *
> +     * @f: QEMUFile where to receive the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @version_id: the maximum version_id supported
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*load_state)(QEMUFile *f, void *opaque, int version_id);
> +
> +    /**
> +     * @load_setup
> +     *
> +     * Initializes the data structures on the destination.
> +     *
> +     * @f: QEMUFile where to receive the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*load_setup)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @load_cleanup
> +     *
> +     * Performs cleanup of load data structures
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*load_cleanup)(void *opaque);
> -    /* Called when postcopy migration wants to resume from failure */
> +
> +    /**
> +     * @resume_prepare
> +     *
> +     * Called when postcopy migration wants to resume from failure
> +     *
> +     * @s: Current migration state
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*resume_prepare)(MigrationState *s, void *opaque);
> -    /* Checks if switchover ack should be used. Called only in dest */
> +
> +    /**
> +     * @switchover_ack_needed
> +     *
> +     * Checks if switchover ack should be used. Called only on
> +     * destination.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     */
>      bool (*switchover_ack_needed)(void *opaque);
>  } SaveVMHandlers;
>  
> +/**
> + * register_savevm_live: Register a set of custom migration handlers
> + *
> + * @idstr: state section identifier
> + * @instance_id: instance id
> + * @version_id: version id supported
> + * @ops: SaveVMHandlers structurex
> + * @opaque: data pointer passed SaveVMHandlers handlers
> + */
>  int register_savevm_live(const char *idstr,
>                           uint32_t instance_id,
>                           int version_id,
>                           const SaveVMHandlers *ops,
>                           void *opaque);
>  
> +/**
> + * unregister_savevm: Unregister custom migration handlers
> + *
> + * @obj: object associated with state section
> + * @idstr:  state section identifier
> + * @opaque: data pointer passed to register_savevm_live()
> + */
>  void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
>  
>  #endif
> -- 
> 2.43.2
> 

-- 
Peter Xu


