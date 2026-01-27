Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD5D2FEE0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkpqK-0004UA-OQ; Tue, 27 Jan 2026 15:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkpq2-0004Pk-La
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkpq1-0007qq-7p
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769546339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVv+dmAl4wJssfZAUaUchzCTDsL518B8jhKX8oW61no=;
 b=NHanuOu+Do2J39CrLEl4Heb3Ze7Dp6zODQxEKpSZkQLW2MbTQMVEb/TQCjAcEktBT2MIKK
 LcGtNIfoUBFQuhE+vtFs61/4JHGLzAhWaNLs50g/a9h4PYSVkiWSojFtRE4POAo/7xqStc
 YOSkWZMBqP7GWxweLrkiIEbgNq3OCDI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Bvj1rXzlO52ymJ2gSgM5mg-1; Tue, 27 Jan 2026 15:38:58 -0500
X-MC-Unique: Bvj1rXzlO52ymJ2gSgM5mg-1
X-Mimecast-MFC-AGG-ID: Bvj1rXzlO52ymJ2gSgM5mg_1769546337
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894769f8732so296700686d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769546337; x=1770151137; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PVv+dmAl4wJssfZAUaUchzCTDsL518B8jhKX8oW61no=;
 b=iUQM1HaJCG2uhrr8RvxRhlKqiqvbM1N+1sbT/DCIJpKHEYYYkbLb7Obkapqfu7Smwr
 ewYmyiHVXfRW22hdVLeIYSkMg6D2u7OYIkQa/6F87/YbslH2BgUSCklGGxlUp5C6v3VF
 uv1/qmHOokATf2FhZzFt56MWVRVQUoU7t0g25wZDbBFQK5hHdvjL12nOY2cjX6WAGCwP
 QxJO5bl+RnupV3XvxcO4EqE9YZLDrxlchkm5Z6SweJm3bUXaBWkKvDppWVFSiKDNgzsP
 H2Lco8Ttnc85lJbztjbxxez5tx9FGxTaFr/GfuLalZAiZlAbyLTkSPjCcFgzLyrCjK42
 og1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769546337; x=1770151137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVv+dmAl4wJssfZAUaUchzCTDsL518B8jhKX8oW61no=;
 b=OVHYKBxXCN+IeSiHzLBHUW1Di5xDkCJ+OoORJz8oKQcegQdXSM9956QBS7dmAkyvpP
 /nnJSeLuZlvsPyaVsNCiHJ4X1ciZfzjbEcFOpBpr0H4qYetR6bSo8G3UBmbqoOrRWfCp
 R9ph86GPNx8yHGyJpu4aKTTKOVSA3fzsb/ZKjnw9e4RpOMibirB9l74KhzCYLaJ1zrzE
 CygNeQUaWD4ZX/rbnDUn0u3A2ZH5EEFcjt4QqaMOTf6rbs5JlJ+uELxQan7knG8kAxDH
 XUqa5kXj3TH3dYQU2FFA8tOGQLxSUycX8j2ryUXQVQjb85zkuj3YYxZ6BcIa65t7Fq/K
 iLXw==
X-Gm-Message-State: AOJu0YyEGDqsx9WI006R87wBtYvLfHDEnefOCuNoBoVBj8fzfT4FQak4
 GfVXfJ5AqBOEQ9MhRAvJUNnXS0caKHM0uTIwpFRsb2S5gKXZ4LQkxVr5dsrXfmrOkDeC27OWiVF
 xEzeM6OrdS50rU0lhKCm2WZGDLEDbL6CJPVsWdSD5a8z4+RJe9WP+sq4J
X-Gm-Gg: AZuq6aLjf3Jfl5ajNo+Zg7s7j/nemwq/VZteLyE3JOulorhhZbEURhv0F2CKultEaC6
 LgQHwBD8Ww3jUcqD4XqgJgc8tpwyzoy47vJkdIgNK99922sAZZEKy7pUoGSinxCVIMMCIqHF+e3
 BzsyMHZn8HuLfWz0Lyg+atunRc4eYTXWR63Lv1kZn4050sBBrjlw+J0OZ90IXDfFEAWnE84wIIG
 G6YMW+x1Ya+oD78zBM2+RtmeM/rKLjvX0aQSO30xl8bJcc83J/DgqJYzWnmFrZ6TlDLWqpQDrsU
 gyIoIqYKKiErx66o2fIJYER3EzRHwkGn7YNXnrUnAxytnzsPBWKcM+j6FhxwK7AuhmTtVy6zk2m
 A1oc=
X-Received: by 2002:ad4:5d68:0:b0:890:7fc7:8837 with SMTP id
 6a1803df08f44-894cc7f8bd6mr48191786d6.19.1769546337590; 
 Tue, 27 Jan 2026 12:38:57 -0800 (PST)
X-Received: by 2002:ad4:5d68:0:b0:890:7fc7:8837 with SMTP id
 6a1803df08f44-894cc7f8bd6mr48191406d6.19.1769546337109; 
 Tue, 27 Jan 2026 12:38:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36ad309sm4180376d6.6.2026.01.27.12.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 12:38:56 -0800 (PST)
Date: Tue, 27 Jan 2026 15:38:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/10] colo: Fix crash during device vmstate load
Message-ID: <aXkiX-jvFOieE9FG@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, Jan 25, 2026 at 09:40:10PM +0100, Lukas Straub wrote:
> With colo we load device vmstate during each checkpoint, on top of
> a vm that was already running. Some devices expect a reset before
> loading vmstate on such a previously running vm.
> 
> This fixes a crash when using COLO with Q35 machine.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Yes makes sense, maybe you can add some comments into the code too since
this was overlooked before,

Reviewed-by: Peter Xu <peterx@redhat.com>

Have you tried to measure how many overheads will this introduce to loading
each snapshot?

> ---
>  migration/colo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index db783f6fa77500386d923dd97e522883027e71d8..627b3706687036554eda3909b4194116a7640493 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -727,6 +727,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>  
>      bql_lock();
>      vmstate_loading = true;
> +    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
>      colo_flush_ram_cache();
>      ret = qemu_load_device_state(fb, errp);
>      if (ret < 0) {
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


