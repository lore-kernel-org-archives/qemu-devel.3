Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61703D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wGX-0004IJ-0B; Mon, 04 Nov 2024 07:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7wGQ-0004Hx-55
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7wGN-0000xJ-Bk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730723573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aiKgVi0ECy9qvoROVcvWx369qhX2R9h2NtxcDg9nTEM=;
 b=JKHYL4ti4HDecZQ6edkAOaSwhYB/8kPRYyJbZ/EJ5OK3GTLLKpBMvj5zT+q5UaejUNFRzX
 akRl29+jkcUBbPKDinLYq8SGnVRqq8DU4xj6gHcOJnlKwjGbBB7hG4jUpkzq4LX/lRqxb6
 b1m19QwnROd5s5vPrarbsYgwCIlkavg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ZC8yCZbXOCmwv_4u0t25-g-1; Mon, 04 Nov 2024 07:32:52 -0500
X-MC-Unique: ZC8yCZbXOCmwv_4u0t25-g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539f7ed336bso2479240e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723570; x=1731328370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aiKgVi0ECy9qvoROVcvWx369qhX2R9h2NtxcDg9nTEM=;
 b=FylLnorxhfKPNf3neE7+1uvRew+Dk/p5RyAn5HrvcUIgNLgwnNi6kCw1KOCHGyBBiA
 q78fTMSZ5am1fiOAk8ZfQKRuCQzG9A3t9xgQmzgU4PAhp1SoLkt3tQlLn1veYny+1JC1
 z0r98aVIZ2JA9R5qcUMiYBsHBFaNlHQ8l21bj8jasAbofPymmDn9igLa5KMfRY+P46f8
 iXTWioxaj8FdgvcQ4t3U4Ilk+IwTV9qs33APngVoNJNohNI1mrQ2Sj7+w4zoadmPmJBj
 vx5+1YP9F/ULRdihP6+nt48jPKrRoOnHd8JGuMu1fYdrx5DEGSWwoBKEFw1r/Q2jEJmA
 L/UA==
X-Gm-Message-State: AOJu0YzQ71UDI+OaPyLfy41PxUJjqK63TuRYSo+C860oEvzGT1Px+6+d
 nyTpfaVBSmeEakmqA8S36MNNh4oeyEwrYmyGmolyRjxrKJV3I2KS+dtl/nscBP1J3i/BovBi9s4
 oSN/U74QDvkTHul5Qy+frfWxgF1kBePtqSGvf4tdNVLQd030Ph8or2SE3t6Ma0FKLtU6Lpsl+Mg
 vseb+UNTPiGG65sMCVidQL+rkyXfrtIxdA4sno4w==
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18450474e87.41.1730723570169; 
 Mon, 04 Nov 2024 04:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE6IqCZ/Jw3nD5a80OWKoVOJImOXErF0cCpg0l7YOypm/qHUKVmhsxNhV9NQDSSkef6ukOid4M0iv7kM4gFJY=
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18450444e87.41.1730723569708; Mon, 04 Nov 2024
 04:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
In-Reply-To: <ZyTnBwpOwXcHGGPJ@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Nov 2024 18:02:33 +0530
Message-ID: <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 1 Nov 2024 at 20:04, Peter Xu <peterx@redhat.com> wrote:
> As we discussed internally, we can't do this unconditionally.  We at least
> some compat properties.

* ie. we define a new compat property to check if postcopy sends a
magic value or not?

>  Or we need to see whether Fabiano's handshake can
> simplify this, because the handshake will also re-design the channel
> establishment protocol.

* May I know more about this handshake change? Is there a repository?
OR a page/document that describes what is being planned? Is it just
channel establishment change or there's more to it?

Thank you.
---
  - Prasad


