Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28D5D15DAC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uBe-0001Y3-Ef; Mon, 21 Oct 2024 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2uBc-0001Xb-3p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2uBa-00058d-EO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729523949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rTUJXVwSnpTBxqVZ0n1fIUOLhyAxulXFJ+pM27GN8c=;
 b=e7aW/qzXTLC/+Hq1EZ5RD50J9mJSf2ivOtHTCnY+F2My5s9L3AXMrUWgKwKzCkGoLGNuHc
 qbguox1KbjiuMbhM0ZJkMH03g2YnAgH0xRsCA284IWqEr+NtTxGwcK9ejcxj4xrjl/rV9W
 vnOcw9MmEkRo6wuOq5WNdAlXmD0uoPI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-FnfYVOfXNIOFN6TtawZaMQ-1; Mon, 21 Oct 2024 11:19:08 -0400
X-MC-Unique: FnfYVOfXNIOFN6TtawZaMQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b15a8e9ff1so564243685a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523947; x=1730128747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rTUJXVwSnpTBxqVZ0n1fIUOLhyAxulXFJ+pM27GN8c=;
 b=hU6fmqoay3zUlXBijUHJh35UtY9n3c2FT832QooyixBcFlM/ljbQDwHhHDgd1UV5TB
 58IPnJCylwOR5LSd7vzSmz7BzOwyQRyDcOiv5p8lJVzo81u4TBvHj1eTG5QpIVF4R0xe
 vpBhK7Wqn/ME+fnFhmmaflimqniS4i6pP/d0O1WynkCRzqq+JyLKQZHvn1zbh8ls2SBa
 xHEju1f4FVucBiNqmLtRTudN4SBnPwIH1x9UTSq5nx4YtOwcLMvLXz7NuCdIuGW92InU
 W2oTUnBeJMCHQd5yRqkjlcerhB7s35cQ/x6IV/eYkGIYsZXPRRYLnMSA8pQXT8YvnA9k
 /9Yg==
X-Gm-Message-State: AOJu0YxvXgETCEsgfSkah2TChroPpGbldf/YasWor+RKr1apoUH8K3D6
 J2FqEd1Y5AeuZs9TMFL1CCFcDWSqoUqsUHmdyxafGR73+dgkIz7p+KBjPNA/Bc1webdQlm3kPYL
 V5YqOxjalGKAZCBn0BO6I6nKT8f5yea/v3RSvPywuP4gQyZ0C/nSb
X-Received: by 2002:a05:620a:45ab:b0:7af:cf2e:197b with SMTP id
 af79cd13be357-7b157b5aacbmr1430290985a.21.1729523947561; 
 Mon, 21 Oct 2024 08:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk9cwXOtQLjchVnabHiG3J83BRNsMYlqaDheVT6YBOgkGwlZ40J2LDpJiTnhg4MhbWv4NKbA==
X-Received: by 2002:a05:620a:45ab:b0:7af:cf2e:197b with SMTP id
 af79cd13be357-7b157b5aacbmr1430287685a.21.1729523947214; 
 Mon, 21 Oct 2024 08:19:07 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c88f1sm176949685a.17.2024.10.21.08.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:19:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:19:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
Message-ID: <ZxZw5xnN4cY7j680@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 17, 2024 at 08:14:05AM -0700, Steve Sistare wrote:
> Make all global and compat properties available before the first objects
> are created.  Set accelerator compatibility properties in
> configure_accelerators, when the accelerator is chosen, and call
> configure_accelerators earlier.  Set machine options earlier.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  accel/accel-system.c |  2 --
>  system/vl.c          | 34 ++++++++++++++++++----------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..c8aeae4 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>          ms->accelerator = NULL;
>          *(acc->allowed) = false;
>          object_unref(OBJECT(accel));
> -    } else {
> -        object_set_accelerator_compat_props(acc->compat_props);
>      }
>      return ret;
>  }
> diff --git a/system/vl.c b/system/vl.c
> index b94a6b9..bca2292 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>          goto bad;
>      }
>  
> +    object_set_accelerator_compat_props(ac->compat_props);

This is the probe/preinit iterator, might be good to keep it simple to only
make the decision of choosing one accel, then move this line over to
configure_accelerators() at the end.

>      acs->accel = accel;
>      return 1;
>  
> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>      parse_memory_options();
>  
>      qemu_create_machine(machine_opts_dict);
> -
> -    suspend_mux_open();
> -
> -    qemu_disable_default_devices();
> -    qemu_setup_display();
> -    qemu_create_default_devices();
> -    qemu_create_early_backends();
> -
>      qemu_apply_legacy_machine_options(machine_opts_dict);
>      qemu_apply_machine_options(machine_opts_dict);
>      qobject_unref(machine_opts_dict);
> -    phase_advance(PHASE_MACHINE_CREATED);
>  
> -    /*
> -     * Note: uses machine properties such as kernel-irqchip, must run
> -     * after qemu_apply_machine_options.
> -     */
>      accel = configure_accelerators(argv[0]);
> -    create_accelerator(accel);
> -    phase_advance(PHASE_ACCEL_CREATED);
>  
>      /*
> -     * Beware, QOM objects created before this point miss global and
> +     * QOM objects created after this point see all global and
>       * compat properties.
>       *
>       * Global properties get set up by qdev_prop_register_global(),
> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>       * called from do_configure_accelerator().
>       */
>  
> +    suspend_mux_open();
> +
> +    qemu_disable_default_devices();
> +    qemu_setup_display();
> +    qemu_create_default_devices();
> +    qemu_create_early_backends();
> +
> +    phase_advance(PHASE_MACHINE_CREATED);
> +
> +    /*
> +     * Note: uses machine properties such as kernel-irqchip, must run
> +     * after qemu_apply_machine_options.
> +     */
> +    create_accelerator(accel);
> +    phase_advance(PHASE_ACCEL_CREATED);
> +
>      machine_class = MACHINE_GET_CLASS(current_machine);
>      if (!qtest_enabled() && machine_class->deprecation_reason) {
>          warn_report("Machine type '%s' is deprecated: %s",
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


