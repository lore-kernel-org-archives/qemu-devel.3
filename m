Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F58C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Lg-0007C6-Ck; Mon, 19 Feb 2024 09:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc4Ld-0007Bh-7r
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc4La-0007gp-K5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708351816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0OEjzmaT0cPNDeDxM16/0mNZA65rIvcoUb4WFAiBh2Q=;
 b=Po9u7GXgZxivJMpIpS9VALu0DZUQCL48jQmdaaIUpU322j6FFO8bXZyt4iqu/OOBheVcuQ
 bUR29JNQfe8N8BXlAfimmTkGjince/N9WLiTEzNXmgFjgG5ps0eGHTIqnUE0eVNx2sN1yd
 qkNBcrCIO+ZyVyvWska0ji6gPVyl6sM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-xE8FKnKOM76--ovXmAB32A-1; Mon, 19 Feb 2024 09:10:15 -0500
X-MC-Unique: xE8FKnKOM76--ovXmAB32A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7874e6a5172so270716385a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708351814; x=1708956614;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OEjzmaT0cPNDeDxM16/0mNZA65rIvcoUb4WFAiBh2Q=;
 b=nyE6vUeJ1ytFZ3zSjD9gy0a1Naa6JTLN3+Zi6Q+V5gOC5IAfR+X2sNdpgzIPqFkuYw
 TljczYSF8icU0UnjQA7Hluu04x9Rv7E0marvL+R38HjkgzOrc1OQSC12SDE8xWKqSAUk
 K8E+RJSbeOAW+jbf/j07e7v1DSlyESuUZrSNVuwO4jT9OA0VC3A9S3mfXTEHpKzDYzHf
 pHqQ8ggQkPaiZnTCh3u4WkfyKA530HeereXUVgTyJI072X6i6KW83gLj6Ipx+35bAnFj
 u1j3VO2NxAx30t7hxvSuUYhZuMkNqeY18yedfOg+wjEEQs2b6OgyDZcMfqKDCiWzllqs
 x8cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOlKbBe8dV47YRqF4QoRpst2aD6wLDoOcdCR6/SAwMgIbXlfNuv8jS7POxyY8A5sHYbMKVEkcwAZ60bOe8ktV1+CK0Xdw=
X-Gm-Message-State: AOJu0Yy978ifKt9iq89utCIa3XJcOCbkbaRMYS+jabwWQQYFXpN+j3Ox
 fPjF+IG2UBqAn1r8Qe7VWjowLxUC95Pw9df/X/P0ESMbwCAq5Y8+tiPC8QWb4oWDJ4pd3Hi0531
 NMj7ofXFVy6PBGWR+0mFQfiHfjbMEfauWVNslfA44tlqq9eo4jEJ/
X-Received: by 2002:a05:620a:20ce:b0:787:3e53:a5a2 with SMTP id
 f14-20020a05620a20ce00b007873e53a5a2mr12374964qka.37.1708351814542; 
 Mon, 19 Feb 2024 06:10:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0wCsFP5V9ziqa7Ko1Y8CFUJ5W2QopOAWtaXMHA88vKQDz8khtESDQr/nO57fQtDJfk+wYRA==
X-Received: by 2002:a05:620a:20ce:b0:787:3e53:a5a2 with SMTP id
 f14-20020a05620a20ce00b007873e53a5a2mr12374939qka.37.1708351814255; 
 Mon, 19 Feb 2024 06:10:14 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 g17-20020a05620a13d100b007872aaa2aebsm2473514qkl.58.2024.02.19.06.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:10:13 -0800 (PST)
Message-ID: <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
Date: Mon, 19 Feb 2024 15:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency with
 TCG memory access
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20240219061731.232570-1-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240219061731.232570-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/02/2024 07.17, Nicholas Piggin wrote:
> The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
> aligned ranges forgot to bring the TCG TLB up to date after clearing
> some of the dirty memory bitmap bits. This can result in stores though
> the TCG TLB not setting the dirty memory bitmap and ultimately causes
> memory corruption / lost updates during migration from a TCG host.
> 
> Fix this by exporting an abstracted function to call when dirty bits
> have been cleared.
> 
> Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Sounds promising! ... but it doesn't seem to fix the migration-test qtest 
with s390x when it gets enabled again:

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3385,15 +3385,6 @@ int main(int argc, char **argv)
          return g_test_run();
      }

-    /*
-     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
-     * there until the problems are resolved
-     */
-    if (g_str_equal(arch, "s390x") && !has_kvm) {
-        g_test_message("Skipping test: s390x host with KVM is required");
-        return g_test_run();
-    }
-
      tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
      if (!tmpfs) {
          g_test_message("Can't create temporary directory in %s: %s",

I wonder whether there is more stuff like this necessary somewhere?

Did you try to re-enable tests/qtest/migration-test.c for ppc64 with TCG to 
see whether that works fine now?

  Thomas


