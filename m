Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7665BE81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTxR-0007yp-KR; Mon, 09 Feb 2026 11:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTxP-0007yA-31
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTxM-0000QY-Hp
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwqtWcKT6bMRKiNyqucDx1JuTYDU5zNr68jdfk4Q9wk=;
 b=BYMjE4FbSSQw3BUl/MKUv7GkP9igrKFv7njiYmCtgbQXhKAEl7dqYeAbJXy0W9ZDzpq9qS
 kVtkWXyonu5AeiTNvkz2vhNCiiyosUoIcUhfkH+juhLMfPeVWNoUE3glcsjpFoakP/sxgj
 E/kcKqufxN2jz8+iUwf2IURg8/F6lX8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-AoAnq7TONf-e5aiqy9VAiA-1; Mon, 09 Feb 2026 11:17:44 -0500
X-MC-Unique: AoAnq7TONf-e5aiqy9VAiA-1
X-Mimecast-MFC-AGG-ID: AoAnq7TONf-e5aiqy9VAiA_1770653864
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c70a62ca32so1364751585a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770653863; x=1771258663; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vwqtWcKT6bMRKiNyqucDx1JuTYDU5zNr68jdfk4Q9wk=;
 b=GR8b0QAErHdO7Rdi9hdVtAUDjno3aoErdMkb2iLhTHcw6oA+us4aO4uZopNbF05S+3
 KVDoDiESD5UoxEti78NeTCY+CBBckbuPb/1rq6Q2YJHkB3WQNKDjv0Kx89jM0NrBUBpb
 l/ya+zapFuIgTuA+wyPwmmTOFQ8nWRHVGEpfT9AFGpvyNt6ahXccK8Fd9WaUmN/wtzgJ
 EqFul1PgDsy07EZ2eR0eise7FiCz/GA3BTHW6uN1FRMYZLsRVidJIzNNpfXMC6Eccqxn
 /F+prgX5fszdAI+oI+UwhSVxdQEbwzt7t+mRY06yUtVE22J31sii8Pk1Fykg6bN6vIae
 rbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653863; x=1771258663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwqtWcKT6bMRKiNyqucDx1JuTYDU5zNr68jdfk4Q9wk=;
 b=AK8Uu7h2n97N4eqDw9e7/BQcjFnZTyoGWGN2Sta7qSqQAfKq8xIvC+j7uNldFtuF3j
 7A7tEYQJyRO6hSIiKKkDy9Z0dArh9SkU9g3iQ0X+teu9XiqTrNmBgQxkpCPt1+bRL+91
 A83xGXVlXGwvUzOIBTPBcLzH763n3VJ9pW3C18HtTlpNSOZ7fRLr2V/0p5vbwyKqP8Wa
 YeiUKHDxDRtgJ9ZdHp9Dt8BMSXNdO09C0wbNmu3je/x8z+Hk0THqAStjS9sk09LCLhyk
 dMehhrLAJpop8iqqVAVVOnC7Ogzl+sQqeTImzxzJ6eBQWo1i1nx1F8+rUij9LT1ytnxj
 Ki3A==
X-Gm-Message-State: AOJu0Yz/Sej1MTeD0B4VMjh9BHVmKPyigHXsgeSNc3F7juSEzCBUtRhB
 zhgmH5QAQYBFKa0ZwgP+I6UTMDiZK3RgNsK8WdnbXOi87+tLDY64uiAKycBCkfWj69xpfdJ8u/c
 Mi9zUYlgWqPSMEoKJVL8sGHAN0UELMKtQVXvdMcLvh5Uu3vLlt97xUmSeO0hBcp4i
X-Gm-Gg: AZuq6aKXsgReLaF7wf/fVloQXAHuEYqdWhgMoBnPy0fJQT11u/2bUfhU287ogiVSXii
 1FS5ppG+HBqu8gzmqPxsh7pInfBIzuHyYSedvMPFxlmqgrgATiqu4hj98nqovzyx1BBy1rDQc3r
 01FD8jWVK2tz7gVjRu0Sbttlmn6yKkfP4rBa7aTZhLxSiYvsm32H/MfvLEWchlr96hiDAfD41wr
 KdWWw7MxLv/iqTuA2NhXloiKwEDice7bSqlYLzc4QLsWQ8VrKmVFdl6gej7Hc2scIH+NKTs/oW6
 NXXL/MO8dIXT8FtlachHKjxV85FTR7o1n67mpKpDnjx6POwY7J5dfTLYhaIzrk3+PHyDV+z11XW
 HW7s=
X-Received: by 2002:a05:620a:1a91:b0:8ca:4392:c20d with SMTP id
 af79cd13be357-8caf2690fbemr1384746285a.80.1770653863090; 
 Mon, 09 Feb 2026 08:17:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a91:b0:8ca:4392:c20d with SMTP id
 af79cd13be357-8caf2690fbemr1384742585a.80.1770653862519; 
 Mon, 09 Feb 2026 08:17:42 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f6982sm834975985a.6.2026.02.09.08.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:17:42 -0800 (PST)
Date: Mon, 9 Feb 2026 11:17:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 06/16] colo: Don't send ENABLE_COLO command
Message-ID: <aYoIpX1i_lwgQKyw@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-6-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-6-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 03, 2026 at 11:15:12AM +0100, Lukas Straub wrote:
> We only support COLO with the same version on both sides so this is
> not needed anymore.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Besides squashing with prior patch, another nitpick inline:

> ---
>  migration/migration.c  | 5 -----
>  migration/savevm.c     | 8 +-------
>  migration/savevm.h     | 1 -
>  migration/trace-events | 1 -
>  4 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3f3fc5276bb067ae1960e4b675b33208ad641b23..5515be1bf305b40ba0b590136df18a53451872c5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3496,11 +3496,6 @@ static void *migration_thread(void *opaque)
>          qemu_savevm_send_postcopy_advise(s->to_dst_file);
>      }
>  
> -    if (migrate_colo()) {
> -        /* Notify migration destination that we enable COLO */
> -        qemu_savevm_send_colo_enable(s->to_dst_file);
> -    }
> -
>      if (migrate_auto_converge()) {
>          /* Start RAMBlock dirty bitmap sync timer */
>          cpu_throttle_dirty_sync_timer(true);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 413688b75f4bee6cb10878eb51886cf6ba14872d..a3af09616a7bd22194ffba3cfb7cc4cf15fc88e0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -90,7 +90,7 @@ enum qemu_vm_cmd {
>                                        were previously sent during
>                                        precopy but are dirty. */
>      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
> -    MIG_CMD_ENABLE_COLO,       /* Enable COLO */
> +    MIG_CMD_UNUSED_0,          /* Unused since 11.0 */

IMHO it's not "when unused" that matters, but "when it was used, and used
as what" that matters.  E.g. if we received this unused command in some
future QEMU debugging session, we can guess where it came from with that info.

Hence, I'd suggest:

       MIG_CMD_DEPRECATED_0,      /* Prior to 10.2, used as MIG_CMD_ENABLE_COLO */

I still think DEPRECATED is better here, as it reminds people we shouldn't
"reuse" it and better be left untouched to catch surprises, where "UNSED"
may imply "you can use it now".

Other than that looks all good, thanks.

>      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
>      MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
> @@ -1092,12 +1092,6 @@ static void qemu_savevm_command_send(QEMUFile *f,
>      qemu_fflush(f);
>  }
>  
> -void qemu_savevm_send_colo_enable(QEMUFile *f)
> -{
> -    trace_savevm_send_colo_enable();
> -    qemu_savevm_command_send(f, MIG_CMD_ENABLE_COLO, 0, NULL);
> -}
> -
>  void qemu_savevm_send_ping(QEMUFile *f, uint32_t value)
>  {
>      uint32_t buf;
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 125a2507b7279412bcb0745b95a774874c31c54f..0a1e5bfd1ca125565a4c90c6f31b2f8c94404117 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -62,7 +62,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                             uint16_t len,
>                                             uint64_t *start_list,
>                                             uint64_t *length_list);
> -void qemu_savevm_send_colo_enable(QEMUFile *f);
>  void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index 91d7506634c9f110e8f0b5f9183728058fe6542a..cfd4d58a0f82ec299ca9e8a9260dd3c3a210cece 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -37,7 +37,6 @@ savevm_send_ping(uint32_t val) "0x%x"
>  savevm_send_postcopy_listen(void) ""
>  savevm_send_postcopy_run(void) ""
>  savevm_send_postcopy_resume(void) ""
> -savevm_send_colo_enable(void) ""
>  savevm_send_recv_bitmap(char *name) "%s"
>  savevm_send_switchover_start(void) ""
>  savevm_state_setup(void) ""
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


