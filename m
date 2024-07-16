Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E996AC3DA60
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfHa-0002vi-TP; Tue, 16 Jul 2024 06:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTfHZ-0002v8-6U
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTfHX-0006ZZ-Q2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k47+0r+3UMCaQNRblcynTbey68L/APZhu/L4CLrdht8=;
 b=hQqoo0Ph0LxtFA2pDG3UUs/u4Nebv0p2HazBR++8VbwpJ0Q833PzIrkf3haE4x4vRjupIo
 e6lNfI2tgnmsqo8BGWLJOKdaiWTJ1WLPIvoUJpHmYxe5n6BHtWmL5qO5an/+03GSTjjZPm
 gDBdyuybH9Trr9DOUsJGNRXT6vQxrwI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-8OMFxdTXMK2Kp0Aiux0wkw-1; Tue, 16 Jul 2024 06:19:37 -0400
X-MC-Unique: 8OMFxdTXMK2Kp0Aiux0wkw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4264dc624a5so34553525e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125176; x=1721729976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k47+0r+3UMCaQNRblcynTbey68L/APZhu/L4CLrdht8=;
 b=VFeKlZ3k7rm501/g5gmNtVuan/NcoLe55IDZxCm+ssz3NOt7eImho2BqoXhJcAPKe+
 DhEeq+Pd92F9vEo+uhuQTfq2uL3KiwDWc5cbPDFTv+NAXivtkf6bCssf6EEXurvGi22g
 yIBnErr48p1DZIz+Lnq4E/Dgu9+plw/44oGstsKiqzTBf2xUqd+7dFXi5MjJVkmcEXIr
 zwVhtehzfW/d8/fTbcbCdPxdlm8jWOoTrom8r+7KlLryt1m1yDUdaxZF08n9ciBoECbq
 tNUVHEiTbUc71WQiano+5vGyP4bIT/Tnld1mEtLTI8xgHxwZWMfuQM56gt0R4KHCPm/4
 5vNA==
X-Gm-Message-State: AOJu0YxS802Z5HTlFMKMARmbFmNd6GqD/jNO9B4x1UkQcM0spV6XfkyX
 3xDtyRVwQGaz7vscJkRSfEKTmI4+zKC+l9Z8DyAKu6I9hlJMuHh0glXbrp6VcLCCNOyMYPXExtH
 DQmpUgUgVs7SJBHLHSgL7y0q9hLdayOBvv8bpsUckf0POHYgKZMV1f1Ka20Zs9IyXSdGjT8l/H1
 H9mOOGSfePj8HXv81UIKdkZMMc3wc=
X-Received: by 2002:a05:600c:3c96:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427ba6dc289mr11050955e9.30.1721125176681; 
 Tue, 16 Jul 2024 03:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcUx9U+tFzbTSrQt6yOPlxJW9U1TkmROAFTIse42JitfxEN+qyE3zP1JI5v8GjAf9m3Z6qcagF69fje1CoyAw=
X-Received: by 2002:a05:600c:3c96:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427ba6dc289mr11050835e9.30.1721125176401; Tue, 16 Jul 2024
 03:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com> <Zo_9OlX0pV0paFj7@x1n>
 <CAE8KmOzrAdxGMVb7=hYMOgAOuhhzUT+N0X=ONNN456S6f2i87A@mail.gmail.com>
 <ZpUjys64KeOI1Kmx@x1n>
In-Reply-To: <ZpUjys64KeOI1Kmx@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 16 Jul 2024 15:49:19 +0530
Message-ID: <CAE8KmOx+3coBeWooXc3TAdMODb8cr-K1STZoftE-VmJsaYe+zA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 15 Jul 2024 at 18:57, Peter Xu <peterx@redhat.com> wrote:
> I think it shouldn't be a major deal in most cases, if the extended cycles
> only cover a bunch of instructions. In special case we can still use
> WITH_QEMU_LOCK_GUARD, but I'd start with the simple first and only switch
> if necessary.

* Okay, will send patch v2.

Thank you.
---
  - Prasad


