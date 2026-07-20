Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A28DC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlthQ-0008CC-TZ; Mon, 20 Jul 2026 15:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltgs-00080G-Od
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wltgl-0000zo-PG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784575805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TqU3mjKmA7qpZdG4QIYN4PQ/Lwr+u5XJJdOx6+TfYEw=;
 b=h66MYTvaS4e2xnAvBhuv6q8jgmdcmCHFaSDOj4hyVxOxUzVS7oguvHXGFgdEWEgFon9E4L
 sIWqjTLH6xRjyDZB4xP5Kl49LDtH5D2IJKsfkxPAid8kzrbzFb76Tb5Gx7SFIDFE1oA4KZ
 zq9VRyx0bT7+Ixo9HSj7jpzYMM2Sd8I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-N9dWZRUgM_i5uow8a7W8kA-1; Mon, 20 Jul 2026 15:30:04 -0400
X-MC-Unique: N9dWZRUgM_i5uow8a7W8kA-1
X-Mimecast-MFC-AGG-ID: N9dWZRUgM_i5uow8a7W8kA_1784575803
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so1743404585a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784575803; x=1785180603; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TqU3mjKmA7qpZdG4QIYN4PQ/Lwr+u5XJJdOx6+TfYEw=;
 b=JscMiEKn3Zyerg4MgwYFqIB/55F7CP+ythb4EuRpkCNxEEDiCOcqEuYofBiV6Hkfgo
 fFbvCinPaDqhuq6kIrUNrRKcrKQznpZ9tKbfuv4eyMtDU/7S8c6kibTh/K3CmLNLqA4h
 /8Vv6aO7ilTo16Gd6MUI17zmbAWamCRuViWuni660qPVlx/jsJvhlCD5ddKgh8jWGQj2
 fZjlhSFqdZvLzXyo3jUC3sAAmj1nE97FaPV0s8/nJ98VL0LpoRf+wBfKQef0WlBH+APV
 OrNuzfAw/WWbvhXADEq5QELgsRx7NLEX5jGRN31KKx4iBpVkBk+9PKi2QlT7XS5TsJ0m
 376A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575803; x=1785180603;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TqU3mjKmA7qpZdG4QIYN4PQ/Lwr+u5XJJdOx6+TfYEw=;
 b=K/7DzV5silaExkcXpyB55SWYZoWOC6OKn55IubsLjgwnNCEtFcri0Fd/Szp+KONj6L
 jLNMQZ8e7IXDT/sd0Cwc399tvVcymble4KY77m17BsXG2u8D6qt9rzv0EUZS4uXm9xLD
 aD3fYbAJIyBEuDCftoXP/WsOb4tj2f60CB7VFy6sIwrjLw5K8n4Coc4wdQOSqmwuGgPu
 YuoihAaJHl+6pg6MgJiR8i1fayaME7nvcZosjG/OcPC0hN5S7xrBCgekJm74CnIjuobY
 dDJD8LBKW5yjukP6dzjR0ydFBYY1RZ426S7woAdqXYpRVgTqnP+2OYIOLadlajuA7HyR
 eouA==
X-Gm-Message-State: AOJu0Yz0bpasAj8k4vyy7VvJheO2Xyb7/f7dMvwtgHUxVt6Qfy0JvWgc
 BHz7FWMjbl6HfcQyhrhv8nzsw7AUR0lx+Qsdl6ObFZjlvT7c51topBF58AMVRh5/s2Sj8/yGlrH
 4JtiR3eMed3EjZmDbn4nhhg1o5u9mD35LJfAzMqpdnhE7Xzxv4Avq4zMB
X-Gm-Gg: AfdE7ck1v1jvcg4zTDxRMxy9euBLpdEXj96dvFYr853XcuDZzPaEh98in3bP1L2DOAo
 /cVBWi3V1/gsag2ByqrjDqT51/S7kDH/6MGbI9wDeFelRNzQGKXe3xNsbfGKI2+GcxpImmAEzxY
 Yemu2vzUJ+7gybNcv373ckPsb0nR+ZI2LYJZrx7pLtRTLdpDhgg1OsUU7/QelzknsfAVOjB3jTv
 fQQ727MVcI8njtK2tvf/wYwZt/GjKyeNXxq09rg7CHGUupAy7DjNXE/5GzMuVYpcRs71MVpwSMX
 KtYJ/AtrKjHNfByfuME+g3q6gsgjXsyK0yGj4OKGcEeSlOOPyXBmQ9X6ueIhizrasCQe
X-Received: by 2002:a05:620a:a415:10b0:92e:c117:5eed with SMTP id
 af79cd13be357-930b4329297mr1102299985a.89.1784575803403; 
 Mon, 20 Jul 2026 12:30:03 -0700 (PDT)
X-Received: by 2002:a05:620a:a415:10b0:92e:c117:5eed with SMTP id
 af79cd13be357-930b4329297mr1102297085a.89.1784575802678; 
 Mon, 20 Jul 2026 12:30:02 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52faa8fsm951687585a.12.2026.07.20.12.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:30:02 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:29:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 09/11] migration/tests: remove capability conflict
 test postcopy-ram+mapped-ram
Message-ID: <al53LrW7wXQL51Nf@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-10-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-10-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:45PM +0530, Aadeshveer Singh wrote:
> Remove the test test_validate_caps_pair, which asserted postcopy-ram
> and mapped-ram capabilities cannot be active together. The new fast
> snapshot load feature is exactly this pair of capabilities active
> together, with the following patches in this series, this combination
> will now supported and be functional.
> 
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load.
> 
> Add a capability check against setting multifd when configured for fast
> snapshot load as it is not supported yet. Also add capability check
> against setting postcopy-preempt as it is incompatible.
> 
> A smoke test exercising this feature has been added further in this
> series.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

The subject with "migration/tests:" may imply this is a pure test change.
Let's rename it to something like "migration: Enable mapped-ram with
postcopy" to say this is a functional change.  It's normally fine to have
test changes with such functional change, not vice versa (or people may
ignore this patch when backporting the feature only).

After rename, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/options.c                | 14 ++++++--
>  tests/qtest/migration/misc-tests.c | 52 ------------------------------
>  2 files changed, 12 insertions(+), 54 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 5cbfd29099..d61a10f1c4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -727,10 +727,20 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>                         "Mapped-ram migration is incompatible with xbzrle");
>              return false;
>          }
> +    }
>  
> -        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> +    if (new_caps[MIGRATION_CAPABILITY_MAPPED_RAM] &&
> +        new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> +        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
>              error_setg(errp,
> -                       "Mapped-ram migration is incompatible with postcopy");
> +                       "Multifd is not supported with fast snapshot load");
> +            return false;
> +        }
> +
> +        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT]) {
> +            error_setg(
> +                errp,
> +                "Postcopy Preempt is incompatible with fast snapshot load");
>              return false;
>          }
>      }
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index ec6d438cdc..4e0deb7f18 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -201,55 +201,6 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
>      migrate_end(from, to, false);
>  }
>  
> -static void validate_caps_pair(QTestState *from,
> -                               const char *first_capability,
> -                               const char *second_capability,
> -                               const char *expected_error)
> -{
> -    QDict *rsp;
> -    const char *error_desc;
> -
> -    migrate_set_capability(from, first_capability, true);
> -
> -    rsp = qtest_qmp_assert_failure_ref(
> -        from,
> -        "{ 'execute': 'migrate-set-capabilities',"
> -        "  'arguments': { 'capabilities': [ { "
> -        "      'capability': %s, 'state': true } ] } }",
> -        second_capability);
> -
> -    error_desc = qdict_get_str(rsp, "desc");
> -    g_assert_cmpstr(error_desc, ==, expected_error);
> -    qobject_unref(rsp);
> -
> -    migrate_set_capability(from, first_capability, false);
> -}
> -
> -static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
> -{
> -    g_autofree char *serial_path = g_strconcat(tmpfs, "/src_serial", NULL);
> -    g_autofree char *cap_pair = g_path_get_basename(test_path);
> -    QTestState *from, *to;
> -
> -    args->start.hide_stderr = true;
> -    args->start.only_source = true;
> -
> -    if (migrate_start(&from, &to, &args->start)) {
> -        return;
> -    }
> -
> -    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
> -        const char *error =
> -            "Mapped-ram migration is incompatible with postcopy";
> -
> -        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
> -        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
> -    }
> -
> -    qtest_quit(from);
> -    unlink(serial_path);
> -}
> -
>  static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
>  {
>      args->uri = "tcp:127.0.0.1:0",
> @@ -309,7 +260,4 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> -    migration_test_add_suffix("/migration/validate_caps/",
> -                              "mapped_ram_postcopy",
> -                              test_validate_caps_pair);
>  }
> -- 
> 2.55.0
> 

-- 
Peter Xu


