Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D17C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9oGU-00076c-Ep; Wed, 22 May 2024 11:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9oGR-00076J-3m
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9oGP-0001iz-Gu
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716393144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/dRuHk4hrxVVqLC/0UvxFQh+tso15+uvsK4/B574w4=;
 b=eO5HnoWp8t3t+xRIqE5vcaMiH7UWMYvGHp05BGP8QiMCeBFfMm0fglZc5G5K/G+ZN9B9HW
 eEk1Pgl6sQJqoPadyd8cX+zuW76723VELtGBwHQF2j/NQA9ye6QoYVHdGjdnIvzcvHV/Q9
 yP66iJliAZuynsAYUeN6iBG7+MLmJ5s=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-0KIv9ZgPMBWcXBP7W3Gfhw-1; Wed, 22 May 2024 11:52:22 -0400
X-MC-Unique: 0KIv9ZgPMBWcXBP7W3Gfhw-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-47f072daffdso1432729137.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 08:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393142; x=1716997942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/dRuHk4hrxVVqLC/0UvxFQh+tso15+uvsK4/B574w4=;
 b=MayeHs0DyRn7NYYnd3x1/qjnMnz5s+b/QTDOVeZUqFhoIXmqR88ycusk+wU7OLtxmc
 NWvvnFZbmG6EfC6g+n10j5ONapJ0wI8/T+OyXeqyRo3KuX5z/OeXnGnQYalgsBhGzHdg
 1rnDmXJYv02Ove55I4ZVOZ3AicormRHIcIu2rYjKtL4n3ATwhd1jtgFriSvwEBroBzt7
 kTtO9kG2DzYVLK8i8qk4QOBseyZCIfVbrPRXXaKJgtbuPtKsJ0lXhxnappQBuUAQBQzT
 hw/fkyPDBRKvnIFCZmP/tcqldTAte1tYd4WLNWjvFLTc9A8Y5reWn3JepEpFu5S5Slr6
 +zTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxJnXnnrgxNsX0lf3bbucmvLPuNi4QAZ3q/2ouA/2h+iPibww6RaFcyggd2qbKzYeUPw2mgk8l8kuhDVqywT3Rw4yKJYo=
X-Gm-Message-State: AOJu0Yz1IjROvLDDDiUiArEi5SrCbCmXrmUi8zSKlRpZrek/7svFL4vT
 OtGEaEH61T6EsY0dZf3LhmaPcWQvzmQbq1pBRkibcBEaAB+53CSYpfNP38Bl/u8iMEbKJY1iiwP
 LnHQ4NaCn+K72S63krf5TiBRHm9l3XskeVRD8TRtA6cVBRg4ht4rz
X-Received: by 2002:a05:6102:2848:b0:47b:b69b:8866 with SMTP id
 ada2fe7eead31-4890a16a3b3mr2436644137.3.1716393141866; 
 Wed, 22 May 2024 08:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUbZS5AkHil/Tp+g1Md9zOuV8tquFaD3eh5SEd2eBxYpPri3CXMdnRFueoz9TsaopLhyEZ+g==
X-Received: by 2002:a05:6102:2848:b0:47b:b69b:8866 with SMTP id
 ada2fe7eead31-4890a16a3b3mr2436614137.3.1716393141111; 
 Wed, 22 May 2024 08:52:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43f97a6c7dfsm19261021cf.27.2024.05.22.08.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 08:52:20 -0700 (PDT)
Date: Wed, 22 May 2024 11:52:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migration-test: Fix the check for a
 successful run of analyze-migration.py
Message-ID: <Zk4Usr2lwCuN-jMl@x1n>
References: <20240522092301.421883-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522092301.421883-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, May 22, 2024 at 11:23:01AM +0200, Thomas Huth wrote:
> If analyze-migration.py cannot be run or crashes, the error is currently
> ignored since the code only checks for nonzero values in case the child
> exited properly. For example, if you run the test with a non-existing
> Python interpreter, it still succeeds:
> 
>  $ PYTHON=wrongpython QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test
>  ...
>  # Running /x86_64/migration/analyze-script
>  # Using machine type: pc-q35-9.1
>  # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/src_serial -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1   -uuid 11111111-1111-1111-1111-111111111111  -accel qtest
>  # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-417639.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-417639.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-9.1, -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-XPLUN2/dest_serial -incoming tcp:127.0.0.1:0 -drive if=none,id=d0,file=/tmp/migration-test-XPLUN2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1     -accel qtest
>  **
>  ERROR:../../devel/qemu/tests/qtest/migration-test.c:1603:test_analyze_script: code should not be reached
>  migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
>  migration-test: ../../devel/qemu/tests/qtest/libqtest.c:240: qtest_wait_qemu: Assertion `pid == s->qemu_pid' failed.
>  ok 2 /x86_64/migration/analyze-script
>  ...
> 
> Let's better fail the test in case the child did not exit properly, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


