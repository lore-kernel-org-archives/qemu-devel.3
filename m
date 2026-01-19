Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A10ECCF2EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhnak-00064o-WB; Mon, 19 Jan 2026 06:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhnai-000643-UV
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhnah-0004dT-AB
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768822718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8Fp2BITjZsPdELUTFx4wGJOlXLt2YKwxXmktdHbL7w=;
 b=M6WGlnCFIIIQVkJWli1YbU15+YYCjLxdlX2SJLxg3WxDqs3kugZNTwClJ7Iddk3iTpOX6r
 LfrzvBfaxwKciK5HFT5a53DLdnW+eodTz9U324sNKN14m+zdQxl0R2E+aqKySd/yV2/hKp
 pd/EhuGhHN8j9Pnbk54cE3sDmrcNRro=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-gZ1pNuPaNLyGhA2tPOA2Iw-1; Mon, 19 Jan 2026 06:38:36 -0500
X-MC-Unique: gZ1pNuPaNLyGhA2tPOA2Iw-1
X-Mimecast-MFC-AGG-ID: gZ1pNuPaNLyGhA2tPOA2Iw_1768822715
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so3471773f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:38:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768822715; cv=none;
 d=google.com; s=arc-20240605;
 b=TtCzh6iM4LJaZfwX+D4N2coM4WDtGOwTiQDdum2XDZItQLB0PPE5q7n65srf9MrfU0
 uEVl7xh35jtUZm2Fs3I5fbvMsaqGBNe4o0fxLXv2PLOmi0Zk/913ady6etH5gNjiB0hy
 3GJuJkRJFTDPxeYhu+vTgQk/wM0ADiwM9Gjm+E1CBYL+CkZZZ/yGPPeiaffegE7dcRr7
 bcAbcgFlThqWWMdIU0yJhZA4rkuO0s1TOVTLUCe57xe7D1nE6NVsXMwQ/S7wdZFx7Xkf
 s+AwZtmdKcx8RJzkgiSVJL1/ONJTiYmcvu9bzEmecwzHUYSqr/VtMwmDS8/Fvc3LUx/+
 RqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E8Fp2BITjZsPdELUTFx4wGJOlXLt2YKwxXmktdHbL7w=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=B06ERdlfUkXn8CU/2/W1p80ibzrNQvpYbOEMP1hQaFKn0eUwi/J3P7egruStDtlw7L
 IphvEklO1VuoWTQOmuU9GRskFRaPyJ/mWORdlHX8TuH54PNdaRjfV57z4Pgg1KdHJe7J
 ZCrnQl1nuw+4pl7iE6UYW7czn/y1LVDCEm/l6X7CI6015wlR2Kya24R5DAfiZeVcLrD2
 ujMv3P8c+uL40bQYoojg8Hw3zkDvwlakYXml8qf55FnWbWQFtSqI5MGlcaZyZllOabpM
 7m/0OZkznSoppfz5IHGx4XP9gfcOSXwfL0aKHlCyYK9uRE6QGgQeOBw5R5SdWj8zGqQL
 UhRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768822715; x=1769427515; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E8Fp2BITjZsPdELUTFx4wGJOlXLt2YKwxXmktdHbL7w=;
 b=HMtQlUijfr1cLmCOLTb+p1HbdeFZczuAqHH98N/DI7rcEjRaNdw+EJHA675u7l7le+
 TIV0Q0IK1KMf7TF1RdtzygEUUpu51UWtBVmAIrPTdprJXeiMroKudI7Hgjykt+2w6EDw
 kHnYUEbTiI1V5280MW9q0G/dmXJ59/VcOSXf9s0C5k4HWZP4cquRcS3q/NyeyG4a8+gh
 xKL7opnb2ZBCM/HURD/lA7DokG/KZmC0sjeqHhhJYzQO0QAU99HLVavSdqq3PkBENkA3
 tOfN8WPZBFpapbyktZOr2Xiu1CM/dLMFuQOOCEfRE1ESGH3dZjbDh4d2SGzU97hWkKld
 3V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768822715; x=1769427515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8Fp2BITjZsPdELUTFx4wGJOlXLt2YKwxXmktdHbL7w=;
 b=MBymTYmxrrbFkHqSIm3VJdU4XIZ1MAaut69S5esgxRwE5qtBpq3UAfZ7z9W1FPsIZF
 /xOzHUl9hx4S9EeOPFFqZrMORMcHX5puK+o7qalqSHa5hfXx+BanIeASpjZr6Z6fq7wX
 cd4uoZHDbXKOk8F/wfXADEuBkCoGmX7qkmC1Bd4YmUcAN5CgUhOzAVsuDpQ+WAXAAOHt
 HCjsyeExEPYQnjGNDisgRQDBP56JQBnixXMn+XW+bxXctVFEQ4hZ5sGhIgLBYawqBht0
 F7tU2HNhmvMgtuWekYehgbfa9NRoz2MztiFMDO/9SzC9nzsNOxdcqiqJyhY28UeOV47O
 TkoA==
X-Gm-Message-State: AOJu0YwbjxhRoY2hzGn2NqzBkwgDeURizj1VQR+t227wc+Cm8I5G8hh8
 vHLbT0Iv7m8yuDmNqqKyHdjhsQBWZmoLf1Kcks0LFfF5cYSZvxcet6lbpxuSMT/MDtQ5d3IjfIk
 Rt+1DXkwwq/zCmiilC8UM5f+bkeI93bd5jX+cCFwufZ9kM5FsfcHVJi2FLK+qQS0HNhBVfkSAmP
 bRlE/rRbSX+fDaRU2Q70T3b1wja2HRYBU=
X-Gm-Gg: AY/fxX4e1lNk66khcgquKuSqSj5AXRLIG2ENYDvBVgIxSWuzi2rOQchL8YLmqcmb4yY
 zNTKiNHdlJjz76OuKzEUerYF+xgc09bQwJFohATdUIGiAEkyqhe0hinXpo6Oj3+bVHsgGntzwBX
 HZcT4kepV8+XmZQwy5PnoobVA9Sc5QxUSLRUGPgrQQYtbUhT82xcJ012LfFzbCkKelAMk7vpT+y
 QamxFqSOh5b+zedwBb6wPlF1oIx2ZyQ9eqOQYrWgKBFTrP/6nzyxD1/
X-Received: by 2002:a05:600c:3e14:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4801e30b8ffmr141038075e9.13.1768822715450; 
 Mon, 19 Jan 2026 03:38:35 -0800 (PST)
X-Received: by 2002:a05:600c:3e14:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4801e30b8ffmr141037845e9.13.1768822715091; Mon, 19 Jan 2026
 03:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-6-farosas@suse.de>
In-Reply-To: <20260109124043.25019-6-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 17:08:18 +0530
X-Gm-Features: AZwV_QgiCVqTlAXpKuPtwMt9PUm5SBmK5EtrKXDQVstcCQTcQ38J6yQS6n8ocRw
Message-ID: <CAE8KmOxqmyQ=FaBF=ikCtVpEQ137XrTbV6qXM7MP1px-Ev6U+g@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] migration: Move postcopy_try_recover into
 migration_incoming_process
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, 9 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
> (the diff is a bit strange because migration_incoming_process() was
> moved after postcopy_try_recover())

* This note could be removed from the commit message.

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index c45393f40e..4af5baad59 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -943,12 +943,6 @@ static void migration_incoming_setup(QEMUFile *f)
>      qemu_file_set_blocking(f, false, &error_abort);
>  }
>
> -void migration_incoming_process(void)
> -{
> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
> -    qemu_coroutine_enter(co);
> -}
> -
>  /* Returns true if recovered from a paused migration, otherwise false */
>  static bool postcopy_try_recover(void)
>  {
> @@ -982,12 +976,19 @@ static bool postcopy_try_recover(void)
>      return false;
>  }
>
> +void migration_incoming_process(void)
> +{
> +    if (postcopy_try_recover()) {
> +        return;
> +    }
> +
> +    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
> +    qemu_coroutine_enter(co);
> +}
> +
>  void migration_fd_process_incoming(QEMUFile *f)
>  {
>      migration_incoming_setup(f);
> -    if (postcopy_try_recover()) {
> -        return;
> -    }
>      migration_incoming_process();
>  }
>
> @@ -1087,10 +1088,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>      }
>
>      if (migration_has_main_and_multifd_channels()) {
> -        /* If it's a recovery, we're done */
> -        if (postcopy_try_recover()) {
> -            return;
> -        }
>          migration_incoming_process();
>      }
>  }
> --

* Looks right.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


