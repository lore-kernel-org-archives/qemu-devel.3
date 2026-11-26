Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5356606A69D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rSd25Xvu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgJ5-000769-MZ; Thu, 26 Nov 2026 15:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaynak.oguzhan0@gmail.com>)
 id 1xWdwh-0005Us-6P
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:11:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaynak.oguzhan0@gmail.com>)
 id 1xWdwf-0008Um-FH
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:11:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so19920115e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 10:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795716703; x=1796321503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aoNA/gvNQhojoQEu1P/+ej8PzYc3GgZR9QfqDec/jqk=;
 b=rSd25XvumJMH0HHENMs1H/X2RXLrTJuzWXeysV16+Yb9MqIUXxnyBpev8DRKyLG8OY
 los8saTnUx1gjapxW5NInd85tyJDb/OB3TgxTLvtnTR+H/cQ9uVPQD5vlHobmdpu53Tg
 JEU0vvOYaVBy3+DFR8oN7CbaZ+KlRKs6qhL3mPzra7O3/uEs1xU/yRlAo70ZrKHexe32
 9O+5zTRaDNekP2avdOvsEGFz4XMfKt7jiljCtpz7I6rKsv4rr6z3rJvPRoZX6E9Bht17
 E1aAYb6V/T/rwvbI+xSFVty4kaYPhk3Lxsud9gQ6d9GTrxLxN+DDXMr2x3Q6lZjGRhSn
 hO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795716703; x=1796321503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aoNA/gvNQhojoQEu1P/+ej8PzYc3GgZR9QfqDec/jqk=;
 b=Na51BifNbli9jI9W2rlF+w19G0U5Ho9ayKDednqt1krRO8DkpBGNh7boiywBV5qWTG
 dARaQq0sqBdjGmGlEXEWaNHCmOHzoisF0K5JflFudB91G/NfiY+UqhzN6HHF2My+zJpE
 YEgYBhOGW3uzr4/gr+osX87nb6Td9fjdxttSYv8WuunFqQLZoZhYvvqOjqpkLQSIvQj8
 4RqBBfBMLxTbbND592v8jNLW3r1g0cXWmFZrqQB0jYZhC1T8PfveY3VdAmflo4xr0QAS
 FLA1qGsb3rbYhUuyv2ruDaUvSZgy1SXlSaBhqItMvDejm6dssvXF5Z6FyLSO0GNNEkOQ
 n+jA==
X-Gm-Message-State: APuU4Z+8/bzeA8XeF0MR64PyHGJMjsxfbDv9JsooRNB6ftILp9W+MedC
 MvcGLUS4zQhwFPsm92Q4G7ExQg9reEto7Fr1GU7yFGbj4KETyMIEWDsO
X-Gm-Gg: AZFdTZfBgnfOc9tnFzb5As8gxV+6e9TyiRD0R9QrsWYMeE+ataxE72lPNy4QfrPhRbu
 1TA2MT28ogHBkNE+qZST0D2LB9uCXwd0mqUeE2qlbId/ArNjeeUIPBFR4fzYeBVulVrQrL3EZvm
 hhbM1zUXjt5HR9n61lNfhj4lERSCIvNnlSEpt8YigbwGj6vmNxpSZrCM7bXxMaAYMEycUC00y/R
 cNa1eDTtPJov4CwjJRz/ngfExXEga3M08fntW0eHggO+y4S8cnKPJmE4EeVSzHIlPQzTOc87To0
 3Hub4RE/1FX/gYhdg7U5HhjtEXe8wzDDAEQzj35lcK7c3y6CWKgLa/X91X/Su5dYty8sLS27DXL
 mcIBqK2BYgMsS80oLNcCzdOa8rTJEyP5M7u+Vw354asvdwXg1uT8vtJ2PvF/6S/8kgfikXOJo3I
 CaqTbV5Q35C2YSs3M2kHJzfCnbKxN2GwtlyTvMsVhk9WDDOqh+l9KiodsQd0wf/VhH8a8YUw0MP
 v6cRnrrAr+QAWCmo8tTX/mlhUgkElt1ApjrBxHHTL/KLtDD3anMDJWO2li1xY8QrTOSxJQnqZ94
 K+qh5wfQIrosmhTliPLCC6hZgZ+D+nnLVNG+Ynvr2byIZbPKt6i3OGiMBsWFgb4/2wHgOaDvqvj
 KTJpbnA1r7C63DovWqYxcfVJd7pbzqzPsIuQwYUALBDAKA4lC+Hot1N/d45L7Y1wu2NLQ2fKDr+
 U/5g7BFWv3owC4
X-Received: by 2002:a05:600c:154f:b0:4bb:6842:66ef with SMTP id
 5b1f17b1804b1-4bb8893a963mr424356425e9.30.1795716702843; 
 Thu, 26 Nov 2026 10:11:42 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm574373145e9.12.2026.11.26.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:11:42 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 0/8] vfio-user: live migration support
Date: Thu, 26 Nov 2026 21:10:21 +0300
Message-Id: <20261126181021.116571-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kaynak.oguzhan0@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Nov 2026 15:43:01 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hugo, all,

Related to this series: without it, vfio-user-pci currently has no
migration blocker at all. On QEMU 11.1.3 a VM with a vfio-user-pci
device (libvfio-user's gpio-pci-idio-16 sample, no migration callbacks)
migrates without error, -only-migratable does not reject the device,
and on the destination the device's BARs are no longer programmed.
vfio_user_pci_realize() never calls vfio_migration_realize() or adds a
blocker otherwise, and the class has no vmsd.

I filed it with a QMP reproducer here:

  https://gitlab.com/qemu-project/qemu/-/work_items/5002

As noted there, just calling vfio_migration_realize() in today's code
would hit the raw ioctl() on fd -1 (EBADF), which your patch 5/8
addresses. If 8/8 calls vfio_migration_realize() for vfio-user-pci,
servers that do not support migration would get the usual blocker
from it; could you confirm that is the intent?

Since the series is not merged yet: would an explicit blocker in
vfio_user_pci_realize() (vbasedev->migration_blocker plus
migrate_add_blocker()) be acceptable in the meantime, possibly for
stable, so that current releases don't silently lose device state?

I found this with the help of an AI coding assistant while working on a
vfio-user device server; the reproduction and the analysis in the issue
were checked by hand on 11.1.3. I'm not proposing any code.

Thanks,
Oguzhan

