Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787CC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVbT-0005G7-Op; Wed, 22 Jan 2025 02:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taVbQ-0005FX-5B
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taVbO-000426-LB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737532601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TsPA3DoT3bJlQ+hoGpgvHGAOWJBptocA7k6CB39oCp4=;
 b=C1Bzs/8bI9F4x4gVUXqExtx3L+mNX1p2Ue0FEsMoAJAiiE6Uw1j//iKOVe11lGVaa9Nbh/
 KYCEs2wRgsfcqhL9naXF/aY1CJJSvcN5ZyIm349MlRUjScu4cFaQennhFT8FUjSyM+DIGA
 wzq5dHlIgS8ePu7ICE6c3KeXPhJ7Lkg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ghy4z4o0Opei2iJmS4gO1Q-1; Wed, 22 Jan 2025 02:56:40 -0500
X-MC-Unique: ghy4z4o0Opei2iJmS4gO1Q-1
X-Mimecast-MFC-AGG-ID: ghy4z4o0Opei2iJmS4gO1Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so51455405e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737532599; x=1738137399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsPA3DoT3bJlQ+hoGpgvHGAOWJBptocA7k6CB39oCp4=;
 b=tXZIRxaarWeSFpGLB8rFKrHMNHC6gvwqeBWsD+oa4tPOUHjlDhqEDw8nQTkiPNjFgQ
 lGlgFtaMuBA2KQAP7PC73ko6QIca5WVSU3WmJ6TurWPGpJhj4gJ0Q/LNyEJ9+Rae9D6O
 8cXTIsW5Qoneix30MCuIIQON3dOK1acHrNoFNIsxhMdrjHxsDjVVkbu7/fsYedpRl04q
 P6vGMtht0A5OsiGNo/Kby+TU7F8Z6CDYeXB+fk1Acnj1txnPJexTjMsvQmvR5fYkXwNt
 o12JUP1bR+H+5PkyHS6lD2SUy+RJYagYM0lBFWxWTQi2jbY0swfUkvR2DIaSOe7VREzX
 L9rQ==
X-Gm-Message-State: AOJu0YwjLeMNPpFNiTbxc53Ebxqm92pBTCd8GcrF+espOm5rN0l1d1Iy
 JUZ/kyODEuP0SaX5ocgn70Kg1/vA5WF/32YcQNLhhARQZYfiQY+IZXMS8pmt9OCLGnpZFJOs/ZP
 dnvVy75dOs/XiR6V34XwnqLqt3T708k+MuKU7816oi6nwhTLH53SHEPX3FEcLdyP1AeU7heIrwY
 dLFdcBXTLKyFgu2kBmyTsXO99ReFg=
X-Gm-Gg: ASbGncsjeDKsiceKQ6N7EWGVDINt97guEfWbtRw5z0FcOyHTo9NpT/28xpA8nd0cbPv
 m2RLqIsJWab8ScK2OqNLaxA3cyK0ef87CK94Zn9YWDKyqPHXUXEecEQ==
X-Received: by 2002:a05:600c:4e06:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-438913c60e1mr191012025e9.4.1737532598801; 
 Tue, 21 Jan 2025 23:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEflFffCnmVB1xlEG6/ZbbLh/CRKzelZf5KENtBOaSTfkvmw4qjON/h6Y2SFB4Npx8Tv1EvZbM2Eao7BPOgWp4=
X-Received: by 2002:a05:600c:4e06:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-438913c60e1mr191011875e9.4.1737532598444; Tue, 21 Jan 2025
 23:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
In-Reply-To: <Z4_Bh3ytv9REBero@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 22 Jan 2025 13:26:21 +0530
X-Gm-Features: AbW1kvbisZurnGBy0hJEazIfjYIYI4LvLJU1UGJrQMZyktlamKbwNynrsUia9vE
Message-ID: <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,
On Tue, 21 Jan 2025 at 21:17, Peter Xu <peterx@redhat.com> wrote:
> https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/
> Would you please add all the tests mentioned there?

    /x86_64/migration/multifd/file/mapped-ram/
    /x86_64/migration/multifd/tcp/uri/plain/none
    /x86_64/migration/multifd/tcp/plain/cancel

    /x86_64/migration/postcopy/plain
    /x86_64/migration/postcopy/recovery/
    /x86_64/migration/postcopy/preempt/

* Of the tests you suggested above, I'll try to enable multifd
channels for 'postcopy/recovery' and 'postcopy/preempt' tests. For the
'multifd' tests above, how do we want to modify them? Enable
'postcopy' mode for them?

Thank you.
---
  - Prasad


