Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEA7C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmI-0006pQ-PK; Mon, 05 Feb 2024 22:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXBmC-0006od-8S
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXBm7-0003Bb-5O
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707188729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ihqTtNg+asBqbtb9hlUrkdPTtT8ZKO4Rd1mTMFdl1Q=;
 b=GEotfg4n6GjZ6TdHhU7OD5VZxYKVvSKX/P9EN97BzsqOWcqEATyhdhGaL1XnrOJbYqkVsO
 k348jmu7HbZ+A3cbVQjtGsYTjE5bCk9DyDkwNBoScrHaHGwiNe/k0SHsryesy2xoyUpNLy
 D39gBkBwNWJnh+s/1mVrirCWyI4nQ2E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mzNqC3lVN66zxXIRMPNe2Q-1; Mon, 05 Feb 2024 22:05:27 -0500
X-MC-Unique: mzNqC3lVN66zxXIRMPNe2Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d942fd19a9so1664975ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188726; x=1707793526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ihqTtNg+asBqbtb9hlUrkdPTtT8ZKO4Rd1mTMFdl1Q=;
 b=qcp2aG9nc6pfudTIJMydGNF2AxTALMpq+SvlgmXcKLxGBJ7KPx1xGUTKTBGeo9VdyN
 p5Mlh/9qNdsodnlEo2JXTgfCsXwvsQolcQD2D0O+jDpvOLk/yONOLg1YnD01bLtX7+bu
 CRzzaS6JCseSI2RMCR7yCc9twPTobZ94NIJUh+QtevuqH6XSU1CGoOQBgDGiR9QCMopJ
 0QYWGImrNgMFaLzFC8EkmS1rDR3e+NJjrnxxC1C6MWWK5+Tp2PbJJRwkP/eOURcMwxpr
 C9rMa2vVjGXOjPdmBDe2djibXrC7aXDtzFEnSt0WRkoA/YyndK01kqprxos82qGEyXQl
 96WQ==
X-Gm-Message-State: AOJu0YxJqjnSswQ1+elFIgNyRZXBqgNJUG7I6HoI6j0nSOT0CWxD6e1V
 D/0OC6F4FK97Ep0g1TalM8R3gEXOHxKDUzP8f2v/6rw6HESgU6pRYERbBmk+r0jFX9nzTOMTrgr
 Tw3WZzZxv5Sj27uh0TCD2DnkXDcWGp9jifxbo4VIo/mVrsh2WApkUhJsBBLzkfimio/7oYt4w5f
 Xm8qK/kozp2qHXn9yWVB7lrBNvSoHRt+4TodEV
X-Received: by 2002:a17:902:c20a:b0:1d8:ca6d:ae90 with SMTP id
 10-20020a170902c20a00b001d8ca6dae90mr1523698pll.3.1707188726533; 
 Mon, 05 Feb 2024 19:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNhagOB9s7GXO7sL2acw5yRaowu0m6gZvSEX40fGgMCUsg3qqroNnPCOYRebpZGJDB9wbXDQ==
X-Received: by 2002:a17:902:c20a:b0:1d8:ca6d:ae90 with SMTP id
 10-20020a170902c20a00b001d8ca6dae90mr1523679pll.3.1707188726159; 
 Mon, 05 Feb 2024 19:05:26 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV0Y049HjCMISRRDsHKdYt2GGDRO1K7q/Rhss0H1o3x+k78igFV90aUl+RJ40ZUGVVJZH3BSvyEYeo8JC5VSv3E5U1X8jdL8QjiLx0lVEn8cCfYprJsM6rgcDkTyjKRhFlhhbgbFTrLBTsFCv/60edI5RaADyZ5iY9Y5iNWe6IPVsbDBsc6k3KcvP/8sF2OjLzEyBaIIKRB
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ko7-20020a17090307c700b001d8e671e24asm625403plb.254.2024.02.05.19.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:25 -0800 (PST)
Date: Tue, 6 Feb 2024 11:05:18 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare()
 and cleanups
Message-ID: <ZcGh7oS3RVWrZjis@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

queued.

-- 
Peter Xu


