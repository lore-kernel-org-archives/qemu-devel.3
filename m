Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649ADD59D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFg3L-00050k-TD; Mon, 25 Nov 2024 15:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFg3K-00050J-0y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:51:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFg3I-0004p1-Of
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732567883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUYC+tdyE/SsVFrWnz9ybOndScEBRZK/bO56fGpJ3Uk=;
 b=VLs9n84KxaTyODHwQA5lIvYm47m6UqIigrH9dlsYLXN3VNdg73XwN4Wn6wVax+XjTA93Tq
 l2agTFUnhd9rO2HIzp7t08zFfbd0Qu/HATzxY6FdhvBvZgy2c35lo+VDCiQRY/VkG0zw7a
 CjdciEK4MEC9FKlcTjYuT0+t+BJIjJo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-HlfBSUAOOjuNxZ0Y7gcX1Q-1; Mon, 25 Nov 2024 15:51:21 -0500
X-MC-Unique: HlfBSUAOOjuNxZ0Y7gcX1Q-1
X-Mimecast-MFC-AGG-ID: HlfBSUAOOjuNxZ0Y7gcX1Q
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83abe8804a5so502049839f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 12:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567881; x=1733172681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUYC+tdyE/SsVFrWnz9ybOndScEBRZK/bO56fGpJ3Uk=;
 b=h/DCb3RHFefWUu24VfcUxpRwSELe2svF+XnfAXWWlwdjzDuEca/XHuieA/RBAYVO8S
 PHlrRYMDCGgS9qcs37YTKCV4+f3i5mOVTdu81fvjCHiqLYopNRnPxcOgZxoNR7rWLWMg
 lxI2eihuN7ANGysf986HJFEVy/pdacpcByMWaZU2uqeb5dF0Od9K0Usq6t11ofkAl+KS
 J0KLJB6w6xIum4XbyjDsfi6C97CQmrLPiJjQ/oyUlXZss5tKqKxZSEtMW+Wv/T/SOL1n
 zz+G+vStwdA5cPATeP4YsriCf61jxNSNDpmXiHAN38PJqRgFC9YBr9raqxK5Gz3KbIh/
 DnZw==
X-Gm-Message-State: AOJu0YwASdKQzicAjrd17smtrDHMixT4df7wovmcMEoRIXEOA6iL9m5o
 YM9q/iAT3uTFdQKILDHbFrnDYvQfZl7/FwHdfNfGV1ABuOQa+sU+qsKl9zxeMwR2ZxsL4bGVrsy
 cHNgiF0FAmqnTQdbBHpdVqmaLvdgl4kAqkF/AZDKY97lOnWzP/+JZ
X-Gm-Gg: ASbGnct0a1eH7skr7p4V+1QbHutfRDpszoCvRbG08J7eFnbEaVWb0g4svYaEFQfQU8D
 0cXCwGmF+n9cWzin/DpD4B2Jv9NMpN0uR7sidI01eKmyAHTMtcTSSdhK7VQWQlff4KJ3OW194Is
 KcOhrpQH6xTCKGoxNexQaKA0D92FQ4I5vp0FOY43FJIPQ2XYGOwFzlJ8T6Mu6BMAiEcOgPg0A+1
 6kuHeRgPZc0D9l2gw4nGvz89nU5yyIoYSdRNCpjaD8Ki2+9eLY7NPWNECq7F+6hkFf7amFjodkw
 tGHTRxytLzI=
X-Received: by 2002:a05:6602:6b0f:b0:835:4278:f130 with SMTP id
 ca18e2360f4ac-83ecdd3a105mr1564038639f.13.1732567880989; 
 Mon, 25 Nov 2024 12:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYHRX5OLc2sMuiD6cWYijHtbthXXUWXIpSUtxn9l8kwSqk09eIZrVaHT4b8QG8r1l+urZ2SA==
X-Received: by 2002:a05:6602:6b0f:b0:835:4278:f130 with SMTP id
 ca18e2360f4ac-83ecdd3a105mr1564036939f.13.1732567880755; 
 Mon, 25 Nov 2024 12:51:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841a7f8dd0fsm37633439f.39.2024.11.25.12.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:51:19 -0800 (PST)
Date: Mon, 25 Nov 2024 15:51:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 02/22] tests/qtest/migration: Standardize hook names
Message-ID: <Z0TjRertI__KnVoZ@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 13, 2024 at 04:46:10PM -0300, Fabiano Rosas wrote:
>  static void *
> -test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
> +test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,

Looks like this one is leftover to do s/test_migration/migrate_hook/ (and
below when referenced)?

Other than that:

Reviewed-by: Peter Xu <peterx@redhat.com>

>                                                        QTestState *to)
>  {
> -    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> +    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
>      migrate_set_parameter_str(from, "zero-page-detection", "none");
>      return NULL;
>  }

-- 
Peter Xu


