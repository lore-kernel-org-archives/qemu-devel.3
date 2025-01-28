Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4906DC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjbC-0001yf-4Z; Tue, 28 Jan 2025 06:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcjay-0001xg-Lm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcjaw-0004nl-5I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738063042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmJQwkSsUtnKBAYHpglBR/kDXF1RdFa71lZVqouhLng=;
 b=hrLYpxUDcuiWTLHpDtc7+Y1LWoIQniriQ6ObhQoijSWfHanVHYl8wfMTJqarCNu+o9460v
 IfiL9RwW1lOYefYt/2LG/BkUHsuG5YTwTBTd1uzhzJLBLpLgwEAyIdnxKwC3YBwk8eTM4z
 h+CoTkchvLn0kK54Zv/ToWg9e2VuQ8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-F_oJaxdnNUi4qMIa2GKLJA-1; Tue, 28 Jan 2025 06:17:20 -0500
X-MC-Unique: F_oJaxdnNUi4qMIa2GKLJA-1
X-Mimecast-MFC-AGG-ID: F_oJaxdnNUi4qMIa2GKLJA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436289a570eso42132035e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 03:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738063039; x=1738667839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qmJQwkSsUtnKBAYHpglBR/kDXF1RdFa71lZVqouhLng=;
 b=BaMFivY+MURLOQlxYVA9jPBI6gyBCa0t49MZGSXTflucppvtUoBLh/lq8dw5LFILf6
 8vSAz16ppGD6b4PfF0Ddj59MrLvRsGR0Mdi8bLZzUEaG/SbkmwLYDcyH0KfFTaiOOEUw
 RSTSx/y53hnQE1wH+oglvJkz7ssM1CHuekrG8HeNzecibmU2QvuJ+r+ZD8OczDfMPB4b
 ip2pd+dtJd/jcYqkhJDsHBXUk9WB+4P4UbikKyI6SbNHgd7CVbQUenFmE/He4LSd/RKX
 E345wrUPxTwh+9hPdCM5SEAygGvevVn8amyyjHT0sx4Nk5UY/iHTtRMVZVf3J0c0sU7b
 Ny3A==
X-Gm-Message-State: AOJu0YyV0gfPCsT0SM8tAqzMT+SgX3ZYrWPYIYniXNGiiyNEFotfyS0O
 04/Ziifc9eI5TeFIbsFV6JfElAjL8UUcE7mm5LsewlkVnlJ7Aw0eF8JSb5K+gLv8hiP22PS5Hxv
 1El2AUZoMj9/abYiWD5+oLxT46f7CT763i0Xl/sqCVHulAglgfUbjl5tt5p9UDLL6pW/WYcmAoo
 Fm3vHum8ih/LitXr15yaR8PfzPZFs=
X-Gm-Gg: ASbGnctcX5MyqdrbFwR0wbg9/Lt9CigcS7g2g7I7P589VORbtJy+vL4BINMSQxCNy1h
 goYTDTCPftYr9diJFIJT7gU0Rj0oRkoaXDUMoE8MfFKzlDzjhJvCNZcINz3El3z0=
X-Received: by 2002:a05:600c:1554:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-4389143b41fmr398470865e9.23.1738063039025; 
 Tue, 28 Jan 2025 03:17:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf5eK6fTlxg1k8TMO1dAxuyWBnA/2L1QJ321FP5NqAwn97V0eWzTFVwlyFuJw19pOgvkZFG2LLglaU4v7KtCQ=
X-Received: by 2002:a05:600c:1554:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-4389143b41fmr398470645e9.23.1738063038730; Tue, 28 Jan 2025
 03:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20250127120823.144949-1-ppandit@redhat.com>
 <20250127120823.144949-5-ppandit@redhat.com>
 <874j1kufin.fsf@suse.de>
 <CAE8KmOyj0DvODhRVoyaqGaTSe+YDV8ymieFwCgnFZM0rWRuK-w@mail.gmail.com>
In-Reply-To: <CAE8KmOyj0DvODhRVoyaqGaTSe+YDV8ymieFwCgnFZM0rWRuK-w@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 28 Jan 2025 16:47:02 +0530
X-Gm-Features: AWEUYZkeHRGDmE70qlhqhq5jTj91qI_0RP-q6sQFRHRcOwt8NWKwg6_rR2TD0no
Message-ID: <CAE8KmOzCwr_vMYEGXR9RgAHb_hFp+wRznOhp+xxtDMGxaa7eGQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 28 Jan 2025 at 11:00, Prasad Pandit <ppandit@redhat.com> wrote:
> >     for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> >         if (args->caps[i]) {
> >             migrate_set_capability(from, MigrationCapability_str(args->caps[i]), true);
> >             migrate_set_capability(to, MigrationCapability_str(args->caps[i]), true);
> >         }
> >     }
> >
> > We could also set the number of channels as a default value. The tests
> > could overwrite it from the hook if needed.
>
> * Yes, this seems like a better option, I'll give it a try.

Please see -> https://notebin.de/?317b9fc90a9a910d#dGKqq4r5pyMYU5SXYLFhd8wrzKRCxCcokTkTRBCUK7w

@Fabiano: does this look okay? If it is, I'll further remove
corresponding boolean fields from MigrateCommon struct etc.

Thank you.
---
  - Prasad


