Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F302C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 21:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHhq-0001hW-Jt; Thu, 05 Jun 2025 17:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHho-0001gz-Ly
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHhn-00033J-AH
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749157254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POkjGthuK1VyXruRbBoewqCX15WQ2+kkRBUHn5Okug8=;
 b=N5LkBqQQWI0yd02H6Fl9QIPdt5MOUoeljXHPBrS9VK/cGDicU28+dqlGp610HFRGU0TTto
 HT0UuNHFqYJaYSI6HNIw7jdZaeGPnkujxPu9f6oxPgUioVu4FprTDyMXbdFn81rLxJUIcM
 YLXNwVSmED9rzifGu9xswtlGIOJ1A98=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-HXddRhVNOQyj-0CzTs93RA-1; Thu, 05 Jun 2025 17:00:53 -0400
X-MC-Unique: HXddRhVNOQyj-0CzTs93RA-1
X-Mimecast-MFC-AGG-ID: HXddRhVNOQyj-0CzTs93RA_1749157252
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-87de236ef78so127617241.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 14:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749157252; x=1749762052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POkjGthuK1VyXruRbBoewqCX15WQ2+kkRBUHn5Okug8=;
 b=dAB++jNavbVNDid+QKTuzVZ4fxO1r1PUpLyMqB9SqME37CZNNJA7owehauA+jDwUxG
 vOjWWrp9DC15K01pXknVsVQ0nNfFvhR2QYmy9C5+qClZ4ZO7N2eHsYJ/yJT0oC56uL7Z
 i21FiHhC+zggGF75DKtUuUagCPAtEFFGjJrs/eoBGmY1pOSapVV3TG4ggPE+9fHuz/mZ
 o+qaN9nJVY7bJqaK9tNIVyW/JtZfg4fHOYDNxhdYp9UZ5nJ1OLsNY0aMVON7Y0ya0go5
 hKaJM8Xh6F9T9e9YT2KURqc7KKw7j9S5HnBUznHiG1Is1VHqDC/bNw5eheHcw7tLUUGZ
 bP6A==
X-Gm-Message-State: AOJu0YwuLvRFT9d2E32dTENaXOfgFnUiARDbOSvcI/zRO5XEzr6mNFEa
 mzGik8zDc7boOGYe0W9IWu61ov3Vh/bnB2NTiKMfztg42VFJwVU6eMi77nPJ8lCSqoABSRUlZ1x
 iqyk9Q+hfg7N+atQjntESKbDWA7PGxxL42lsR0Xq1wqTiRGN5mZQ+r0Zad5SupdBI
X-Gm-Gg: ASbGncvF3xIgP0OQtWIupBB+in6SZJZW745vAmfwA/fn/5MyEbU6PMfJZwTihwjD98F
 zERalwCVlNzldDD+Jq08m9db5bRUqKLom/EA1+mzVn6Q/smIfz4K66w1vNUDd3zYsMdi3ik0EM+
 WtQxh5JtBVwnR0UmMsSX7nHC5MaAtoVez1QPjtOzgjYo69wFQv9lec81n33AR9LdX/+EMzNMmcK
 qPvI8TatQAyhhm2zabdd+P9SZMpKukD27GIkrxv2/sZXnVhUBLslmDrGfhTq2UCVnmeL/Cs7AgC
 OV2mL74cLsidTw==
X-Received: by 2002:a05:6102:3a0d:b0:4e5:babd:310b with SMTP id
 ada2fe7eead31-4e7729af39emr974392137.10.1749157252155; 
 Thu, 05 Jun 2025 14:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZXkin2ewW5a4uwXthqsW09F2PNmKFR572+ID2/bByWawBaQ/jnNXIZNa9KMom2FsZWtE6jA==
X-Received: by 2002:a05:6102:3a0d:b0:4e5:babd:310b with SMTP id
 ada2fe7eead31-4e7729af39emr974320137.10.1749157251830; 
 Thu, 05 Jun 2025 14:00:51 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25170615bsm20728185a.9.2025.06.05.14.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 14:00:51 -0700 (PDT)
Date: Thu, 5 Jun 2025 17:00:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 03/21] qapi/migration: Don't document MigrationParameter
Message-ID: <aEIFgAvjat7EARKQ@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:37:52PM -0300, Fabiano Rosas wrote:
> The MigrationParameter (singular) enumeration is not part of the
> migration QMP API, it's only used for nicely converting HMP strings
> into MigrationParameters (plural) members and for providing readline
> completion.
> 
> Documenting this enum only serves to duplicate documentation between
> MigrationParameter and MigrationParameters.
> 
> Add an exception to QAPIs pragma.json and stop documenting it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


