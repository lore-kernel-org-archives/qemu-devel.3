Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7307CEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdkm-00041R-3m; Tue, 01 Oct 2024 10:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1svdhs-0002dn-Ma
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1svdhd-0004ZA-33
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727792289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPD6ZvvWxHHxq3Qn4DcBLd7P+iaV3q6rH7h5YefbD4s=;
 b=UpVGQgxLvvVwhdXYuMv0HgIvqZfaS8fuDVfvIcwByMFzAMXeLlisAGa+RoR+8gDjMV1mQ2
 FNL8AIrTMFIVoaCfkB35RalRG5+NgzUwJFh6WeMP+hnLBszIQ+AcJtpfzuSTTofZeTsHr6
 cas/6dmE+MK0Q9wVygsq/NSskqSqvd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-NoXjy6wBP0-_Fcv4SWT-6g-1; Tue, 01 Oct 2024 09:15:25 -0400
X-MC-Unique: NoXjy6wBP0-_Fcv4SWT-6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so42137455e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 06:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727788524; x=1728393324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPD6ZvvWxHHxq3Qn4DcBLd7P+iaV3q6rH7h5YefbD4s=;
 b=BwEFAiKONZgNkbyfb74X1dnHWOYUDMxWZ/8eBEUG+r6rQGbBHar/0rftWMZ3aYE/lY
 43TUKqNloOwNlS951I5Zg4vbgQzOaBW+Khp+MsuZ5+PHuN3Q3Wjnjny7SqeBmFlpdMY6
 Fbx+FTDaXdqDtprNw51D214dJnWIf2lSuxH4KaSlLP54AQt4ALeB1x+neVOw0W/ZFoJA
 OCVXURZ6/ccsjSR242JsRzXwTqT1JZDHc0Lkf5DpWGo4Ek5OxFhtVmhYKZ1e696vpGz2
 eudZvbkWo9FT40BnH3UHAPDgIhSbrcV+gsH4sNvw5wZja3FrK7WOkeQaVYh+6isC9gYt
 MfCA==
X-Gm-Message-State: AOJu0YypTKEGlZ2UQ+fv+ZHaj9/+EEVhbNIBmDIe08LdVilBbhFBwlCo
 37eWm3TdLCZhE91zx1Y2+OWykaTHU4a0lyd1piuJPnsQW7qFLjaGElRUlmBdxg72lRA6Bpu+olw
 ecVpYCS05UvoxRJlAret6pjMgN9FUGgY0rCsZKZHEHvNCPgjtfBKj
X-Received: by 2002:a05:600c:1d97:b0:428:e866:3933 with SMTP id
 5b1f17b1804b1-42f58464a07mr146258415e9.22.1727788523657; 
 Tue, 01 Oct 2024 06:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzxbWnmdl/vVZ5NHkSzauwE1lz58+IOylCR7ely6xJ4HTHwOOnPnI23qRDGuSjHG49v6ywuA==
X-Received: by 2002:a05:600c:1d97:b0:428:e866:3933 with SMTP id
 5b1f17b1804b1-42f58464a07mr146258035e9.22.1727788523248; 
 Tue, 01 Oct 2024 06:15:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55e:42b2:2c3a:bdd9:126e:d43a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57de1192sm132241625e9.14.2024.10.01.06.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 06:15:22 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:15:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v7 0/5] AWS Nitro Enclave emulation support
Message-ID: <20241001091436-mutt-send-email-mst@kernel.org>
References: <20240922094441.23802-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922094441.23802-1-dorjoychy111@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, Sep 22, 2024 at 03:44:36PM +0600, Dorjoy Chowdhury wrote:
> [7] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html

That list is dead, would you mind reposting to the new list,
so we can vote on it?
Thanks!
-- 
MST


