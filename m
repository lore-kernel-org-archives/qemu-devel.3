Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA7CC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevYF-0006sR-Dx; Thu, 24 Jul 2025 09:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevY2-0006g2-09
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevXz-0005r8-MN
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753361978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OVH9YZ+jc5As1n3IEEOLT78x8zZZtwbMUq05rR8eoLo=;
 b=StphQ0NHk9qpfFD91tldkbO5aJnXMd82BHi4jOhfez2JZNh0oKVxoAnyF0AVXEzHiRSIuE
 sgjBeLQs3DimmOJEttYt3hPJ/S8XCkqt1a1keAYYqF/Ewy0FGmdFLwrgrjaJ0GFOuGtbbv
 2Le6Z5Thi0fVrjx6Is8XUT/ybCXASQo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-4LF95m0AO0KmwehVGey6pg-1; Thu, 24 Jul 2025 08:59:37 -0400
X-MC-Unique: 4LF95m0AO0KmwehVGey6pg-1
X-Mimecast-MFC-AGG-ID: 4LF95m0AO0KmwehVGey6pg_1753361976
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4586cc8f9f2so2198665e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361975; x=1753966775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OVH9YZ+jc5As1n3IEEOLT78x8zZZtwbMUq05rR8eoLo=;
 b=LVX7M0x91kneiNa/gpkQEw4jlPW8KXclDxKLQGSNMz2iFREnI9Fosty0sEU+KJH/2A
 Lnx5R3KeEVmGyCU3WSIp29uk4v2tWINWzoHgaKpkCxINW5rfhbBwyPoFBgXW1ywRwRTL
 FeFnUjcTKiFuF7jwrCrXopan1Kzqlgkw87divuoeCd1xNdc4Y+3u/MLn4vbCg73OrJ8y
 9vYFGi5WK3wxWWMh/0cWq4tXrDv5OnRRQe0tnAU9eSwVsDOasXxZX8eKliR+XDwU4ToD
 IztTU1OdBkXW9vO8mChVAqipNDcxluRD5cumnLqd0yqB3sVpLDqTWGVXEdz2kVA7wE1Y
 vzzQ==
X-Gm-Message-State: AOJu0YzPCYj95Ma9kpbEtI7xLZlJLVC9fHrU8gJEopUyWBHpd2p5yZzM
 DSx9AtZ5HUT8mkde62edqA8eo9zrxq1xB/FbuzBhAeXRcIET93oPVMQQTqd5knEIzQXUJtrbt6T
 pz4Wptvcm9Mm0DWYKoaEJvTQW0J+nO441knBzuakSVGgTKFb5CpYggw/0kDvjwrRPjOmOGC2gVN
 YjEEl3zhrq2Qo8sRK8HTYJYIxU1LsuBmuU9sau6w==
X-Gm-Gg: ASbGncv26ySCy2pJmd7MmC3cuGecnLzigaDwnhbbaQm2du7mSNS11HFxOj74BgHUWPe
 MFwmt1QI4CJoj4iOkyB2d5s4vCRAi3aWZ51M9PFkr6NYTrRhc7BVlwIL2bVWI8DFZfak34i1rfX
 HJ2EpQSWSSkLIFUoNsqcOkgFvUC/WILNIzS4XKsK6RZfTZBUEUavyGVIadygq8zGZzUTEkB0/xD
 Jb9A/WMZwR/rUr8cl1d0F6Q7F1B8g3OmNGyMPJcLoRFQRV0s7ZOaqbkuhirM7FBOFlOiAH1kM8a
 Ugnb5BDX6brFy0w1CVCM/qX2gIxPy3jDaoWByepapvHIACKaV28UUvuzgXidPuEDRg8O0aOzoWW
 bqGFJX2AHGIILWR2xmReoww==
X-Received: by 2002:a05:600c:34c8:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-4586e52be2bmr28800915e9.6.1753361974854; 
 Thu, 24 Jul 2025 05:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK9QJHphKe3DIajBwPEE+j25xkFaAZimXyIxPw4rogIREMzFh1fxINvMnmvvnqbV+vAT+6Ng==
X-Received: by 2002:a05:600c:34c8:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-4586e52be2bmr28800645e9.6.1753361974412; 
 Thu, 24 Jul 2025 05:59:34 -0700 (PDT)
Received: from localhost
 (p200300cfd706376dff28b03aa15f3cdf.dip0.t-ipconnect.de.
 [2003:cf:d706:376d:ff28:b03a:a15f:3cdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fa5sm20047085e9.26.2025.07.24.05.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:59:33 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/2] Do not abort on log-start/stop errors
Date: Thu, 24 Jul 2025 14:59:26 +0200
Message-ID: <20250724125928.61045-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vhost_log_global_start() and vhost_log_global_stop() abort the whole
qemu process on error.  Not least because vhost devices are generally
outside of qemu (i.e. use a foreign code base), that is not great, as we
can basically be forced to abort because of bugs (or maybe even properly
behaving, just unexpectedly so) in other code bases.

In case of vhost_log_global_start(), the solution is simple: Ever since
commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
handler"), it can just return proper errors, so do that instead of
aborting.

In case of vhost_log_global_stop(), we cannot return errors; but we can
just ignore them.  In the worst case, some other process will keep
logging into shared memory we have already unmapped.  That's fine.


Hanna Czenczek (2):
  vhost: Do not abort on log-start error
  vhost: Do not abort on log-stop error

 hw/virtio/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.50.1


