Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB83CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjLN-000820-Ka; Mon, 07 Oct 2024 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLL-00081F-Hh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxjLJ-00072P-RO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728290628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1MheWRSfhSH8hsFx1mUVzIpObg6Qbt7Ef5EUrenlELE=;
 b=QrEaZVwWr1izpXAU3q6iPL+4jtt21ISOBpJPA92pyjFC7DoEDiszy1RgdhPiIbWONOdFbP
 E7Qc2eMMB2bUGl0sFBbEYqpRRTbwZl2eGnu0f77vAAAMe7+pTeSHd5XacQHG1t06d2q+/m
 tMcFVHmn+IUyzQr4HLwfUBna14n5wKE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Llh52h8YMtGGSC-RLjqnaQ-1; Mon, 07 Oct 2024 04:43:47 -0400
X-MC-Unique: Llh52h8YMtGGSC-RLjqnaQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c88e8d0a69so5722166a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 01:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728290625; x=1728895425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MheWRSfhSH8hsFx1mUVzIpObg6Qbt7Ef5EUrenlELE=;
 b=KnUrVHZiHM8B488BJcMM+yKgGZvJIf14TWGCX/Bpna9hGeCW20jncSQkgf7rxFBW1D
 CCIkCgHWAHMXXvOXK+bM6/gNfJhUK9e2x03nlWPPW1qm1nO5V94ApFj0Wwojx5VCqYjM
 ajQf8cGi0bjtvzuHeMjnZqGqSfNO0hEDcB0BogRVaKCPbKj4nHG6snrNudN92PBxrUh1
 8RVIAMKF2MsWjN9jEKFwroJsFUzI5p5pCfqmV2E2183JXHY2YqcMpfZOy0vyCoFRdpsZ
 QtTcFgfqxVFxeeZzbs0Z4zo2A+8BLv27MMJ/wmgwUDTRDu14O0Nmr4c71G2tG55ukZfL
 kYUQ==
X-Gm-Message-State: AOJu0YwOF7nU9bqAdJOX77yftLOYbYXZHuUrfAJRnP1BqQOwtHc40M40
 3y0sKawJKPtdNTeHpx14mN5C36yaQll+Gw4K6nQ41YxIVXAKOQ2t40SG9GLNI34lIw/3R3PCJjm
 ISCj9u9wJX+aMrpNpba0qEc7WkoydY8QsrkN2uI045nZ07YUhdajOjesNpFjvWqxRERpOTnY3KD
 zqiyl59Sxc5SowNtotI7HJ31WiJL2tQVl3GLugbBs=
X-Received: by 2002:a05:6402:2350:b0:5c8:8c16:3971 with SMTP id
 4fb4d7f45d1cf-5c8c0a8250amr17884563a12.16.1728290625407; 
 Mon, 07 Oct 2024 01:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKfvlsryUKGk9NK4feyxacGLusdnwePQlGid8riSoUlH1xEiKnyAyOZeGAsIAjORynsbZEA==
X-Received: by 2002:a05:6402:2350:b0:5c8:8c16:3971 with SMTP id
 4fb4d7f45d1cf-5c8c0a8250amr17884534a12.16.1728290624922; 
 Mon, 07 Oct 2024 01:43:44 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05bc56asm2918527a12.45.2024.10.07.01.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 01:43:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org, alex.bennee@linaro.org
Subject: [PATCH v2 0/2] meson: ensure we enable CMPXCHG128 on x86_64
Date: Mon,  7 Oct 2024 10:43:40 +0200
Message-ID: <20241007084342.1264048-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


Alex discovered that CMPXCHG128 was not enabled when building for
x86_64, resulting in slow execution for wide atomic instructions,
creating a huge contention when combined with a high number of cpus
(found while booting android aarch64 guest on x86_64 host).

The problem is that even though we enable -mcx16 option for x86_64, this
is not used when testing for CMPXCHG128. Thus, we silently turn it off.

x86_64 is the only architecture adding machine flags for now, so the
problem is limited to this host architecture.  However, the problem
is generic, so define a new variable for all the -m options, so that
they can be used for other such tests in the future.

Based-on: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
Supersedes: <20241004220123.978938-1-pierrick.bouvier@linaro.org>

Paolo Bonzini (2):
  meson: define qemu_isa_flags
  meson: ensure -mcx16 is passed when detecting ATOMIC128

 meson.build | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.46.1


