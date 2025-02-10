Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD2C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPRx-0006Xv-If; Mon, 10 Feb 2025 03:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRe-0006LI-HF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRc-00046M-VG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xxpfU/c7z9d/6ypMxL4FcLhkOjlzksbtn+mi07kcCo=;
 b=CTlnk6eVSveaJbCiHRCq6cwdgEpIbDrD9sC4YL4LWUoZbp6Pj/nCGPOh2T8ADs1HPrPIUq
 ympp/z+uxpqYgKw71Or4flNiZUdZzItQGEFzmm8r81xhBY9dfYNsWaPTSBPvzuqjkwjojH
 SGPYtyxYvlcsGVijI+0za0Gc9XWQDaQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-67ewBFQPM5ugh1PKxs2NKA-1; Mon, 10 Feb 2025 03:47:05 -0500
X-MC-Unique: 67ewBFQPM5ugh1PKxs2NKA-1
X-Mimecast-MFC-AGG-ID: 67ewBFQPM5ugh1PKxs2NKA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dcc9653caso596508f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177224; x=1739782024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xxpfU/c7z9d/6ypMxL4FcLhkOjlzksbtn+mi07kcCo=;
 b=uBJSZwYdMh/elLKPGlQ/Pl0o3wzlDhvnk15mM8VJF3u+z0MGzZvncPaCTFIViu2rzg
 MQLgMCs1Rx6ZN5zkhWIEFBJmGW/m97gO1qF9puinXFlX0dduE7w7gTfmkeVc5+KkjTLe
 2RH7kxSja+48PXi4KsSJd6IpUH0RoO+R8dhJbjEVgROmdM5hhKCysT1NWVepFOBRD/eb
 TdeNPLI+ClCiQryRCJ/ya7FfvossWDadMrXlrWF3SNM0SMBzRORXOGyhY9IRfxq/HLQX
 eYsjNLxgvONhIRFED8QPYSFNSclXkMFQWxuXu1kWvcUHdDw4L9/nMFrv0fll8LClcqnz
 umNw==
X-Gm-Message-State: AOJu0YycXHVDZWSOeweRImJ1Pxs6+ginkq+wwB+TVL/xqmeeavnB2NPc
 0YhHszepso4hXdLjbx57upAJvFTUp9D7SRSkrdBXEOCgFKQfopOqcZLQ/jzdxpOkFZfDE8Aawxo
 BQJk5QKlbpEerGnsEfM0IAjRaqff74bTZV1Ji3AEJ7XuyoAouPqo4H9KCn7zuZ1jgHgE0d3VPJC
 2u9kWoNxqFdOU7RGCjnzAuIxr3Vp5km6+3
X-Gm-Gg: ASbGncvbRaVikp//0RPKW1b2ptJ0XQcvLtsV9WyzvXbUhCwx4vCu/0mdRuYm5aUxJNV
 NqARDCshVxdC7p2zgRC98vUPlUnM7KgwR3zvQ4RFfr1YvY6AZ9QxRKJ+7TsJ3FRqLkREylkd8Oc
 Ksro9jQOcSj/TBefkRHc0nlAaXriZnsNwgqPZAY2olLaz4yrPwpoebIUpVwau3BJ1PiwAVfdIQ8
 gOjX/xxXcw1nV2jiPKSHg9X5UgqOgIPiC9vBT0O31ynsh67qk5kfnYKP8EmCuuFS6ByH2alb6Ve
 fVyEJvdwaZbr8AulrbEGGSSE5Nhc23pwLGG+zZS/Osy4qFZ1hVyLdnev9serahRGYA==
X-Received: by 2002:a5d:4748:0:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-38dc935a897mr7523369f8f.54.1739177224238; 
 Mon, 10 Feb 2025 00:47:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgOB7xEm1V5wNJQ3Zv93firtiq/tsaQHHEcpJeSZ2euPV1wlrR7d0KF7QhxhddxrvwuMA3eg==
X-Received: by 2002:a5d:4748:0:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-38dc935a897mr7523332f8f.54.1739177223801; 
 Mon, 10 Feb 2025 00:47:03 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dc5c8c37esm9933599f8f.2.2025.02.10.00.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:47:02 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v3 4/7] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
Date: Mon, 10 Feb 2025 09:46:45 +0100
Message-ID: <20250210084648.33798-5-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
ram_device regions"), we disallow direct access to RAM DEVICE regions.

This change implies that address_space_write_rom() and
cpu_memory_rw_debug() won't be able to write to RAM DEVICE regions. It
will also affect cpu_flush_icache_range(), but it's only used by
hw/core/loader.c after writing to ROM, so it is expected to not apply
here with RAM DEVICE.

This fixes direct access to these regions where we don't want direct
access. We'll extend cpu_memory_rw_debug() next to also be able to write to
these (and IO) regions.

This is a preparation for further changes.

Cc: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 67c9db9daa..7cfcc6cafa 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3137,8 +3137,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
         l = len;
         mr = address_space_translate(as, addr, &addr1, &l, true, attrs);
 
-        if (!(memory_region_is_ram(mr) ||
-              memory_region_is_romd(mr))) {
+        if (!memory_region_supports_direct_access(mr)) {
             l = memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-- 
2.48.1


