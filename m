Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E4C02187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXiCH-00054p-7D; Tue, 14 Jan 2025 09:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXiCE-00054e-R3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXiC7-0004D2-Jg
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736866020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOlROBk17BHUz162XEuxDt6XJZMjroPpi+3OvbiUmw8=;
 b=EiDes+h6T+9USZQQQz5R4eCIiMXOiVCMzOONUmAHGmAG8MXOVgYTC6MC4qE8M6K60ntYNn
 j6n22B55P79P0+kvDFckzIxkl1CiIVVxfrxr4HvnucdAjhCcoRA33WDeNw1DEYeaNrMMXg
 5DMrYq/DKJwtJChindl/cm276N68c/U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nen259apOh-2wHl5NeO1hA-1; Tue, 14 Jan 2025 09:45:48 -0500
X-MC-Unique: nen259apOh-2wHl5NeO1hA-1
X-Mimecast-MFC-AGG-ID: nen259apOh-2wHl5NeO1hA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef909597d9so15577367a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865947; x=1737470747;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOlROBk17BHUz162XEuxDt6XJZMjroPpi+3OvbiUmw8=;
 b=gICZ4JbBBznMlfAXoGVwE1sRxn1cCLk4Hma6VyQ7rePnL/+YIoVrWwnrUrpaaWcoJj
 1WQvyA7YUIr0HsADxfKNKUJUdpKTjDgdPeSdGINuXnMJM0I3WIaORrpxL4HlZ5oKLkRi
 0ygyjiydI320RtZBlntgu6Joctm/O01IhvOAa2rp7cOSVoQqMnhMg69gcjxuJnYkh6FV
 2kmPQkSU7GM8ZUdnESyQptcB8/BSIM9lVK0kAvMXD5yadwO/4OGQtLhKhYiSCvzNsNZO
 zeRmWufwP07N8uCgVTBTqzQwacL6Ir9/NDxEIl8dh4XmXuMayk6mBv+jW/369c1YMfYp
 6ITQ==
X-Gm-Message-State: AOJu0YyrDj5W63JbRlRpxdYj0ytuwWNyvaqeYyH9MfMyOF6/BR9LVtQl
 EXPiRUIy281nYVu5URFB1zJKG3CCjdLMaWxoYfaJWmEM7IsAIa+5PU5fEbfe3iDFRqo8YfUk7Oj
 pRcl7//KtqYPNaKkRnW9QV5jazlYlipWDQRM0i4LI7xsqbbfO6zaZ
X-Gm-Gg: ASbGncsbRBrswSSwytJfX7qnl4ClFDxWFZkzP62gEoa2IVOt0hRN1ansSutv9vU2AI5
 pbBbawAQaHW0LW3lw7HzgXxgTDx88DpyOYeA3FTdABffsxrw82zf5qgzYghYazue015pE4WgP2I
 nP0ofgKM3lEnn+MKqtL6wSgai6sptAnYG8dkeJzjr7Eu3/RTjR1mQSF3ts0l5ys9CTHBVzIJ5uT
 B7CA3QF9kVIyYoZEf+NwHiaxTTHe4aZBKJOV0BeSqgiA6uTunVYnBj9qhLdBc4fPhDXlE8m/Fly
 /YiOpnA4BMumU03ZoQ==
X-Received: by 2002:a17:90a:d00c:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f5490a9987mr31098226a91.26.1736865947723; 
 Tue, 14 Jan 2025 06:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8dcVibdrqiiNp/fz0FcaknPjThGS7cHBKd/WbYk6FYuFpkzzuVMup6UIPQvNKUdIHGZe0cw==
X-Received: by 2002:a17:90a:d00c:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f5490a9987mr31098202a91.26.1736865947402; 
 Tue, 14 Jan 2025 06:45:47 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a2872bbsm11910519a91.17.2025.01.14.06.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 06:45:46 -0800 (PST)
Date: Tue, 14 Jan 2025 09:45:44 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: fix -Werror=maybe-uninitialized
Message-ID: <Z4Z4mF22jC94tmfp@x1n>
References: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 14, 2025 at 02:48:11PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../migration/savevm.c: In function ‘qemu_savevm_state_complete_precopy_non_iterable’:
> ../migration/savevm.c:1560:20: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>  1560 |             return ret;
>       |                    ^~~
> 
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


