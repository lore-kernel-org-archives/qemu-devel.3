Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E719C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBTCx-0000lx-1j; Mon, 27 May 2024 01:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sBTCN-0000Wd-G6
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sBTCJ-0005VA-Cj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716788821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YMe8yPsFZZNhmxpyGaINXt+QLPl4uSUmrpd5iSr/OZ0=;
 b=OyoyX5EsidX+ipW5yF+kLjIMMDRFfbz+34FlpkUz6gOnghu9V1Ht4IeiXRXfIh7DIw2SDJ
 RoP7jU5KWG2JxwP5d4n5EQo1s5TqMVmI2jQTyAt9ea9DZl1hRkXWiqXWWwmFGG1vG9Ve1t
 BCPBpDD4w52m+PttzZiHMbYVOWQKKvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-CjrBf4n6Mxa0CvWKH8sAGA-1; Mon, 27 May 2024 01:46:59 -0400
X-MC-Unique: CjrBf4n6Mxa0CvWKH8sAGA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-358f9dffbedso536818f8f.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 22:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716788818; x=1717393618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YMe8yPsFZZNhmxpyGaINXt+QLPl4uSUmrpd5iSr/OZ0=;
 b=t0sGFvSJ2ImFhpe4iXrywhxWBDP8QVDrucw5VoW2rUex5oh1kwU2Rnxca8Kzoxi8r+
 ogZj4MZZvjMXeD6cnmNCVC5XmwJ7ne7/ZpdRdxXfIWb57/701qSh+TzKuO49KMG/Eon8
 /tuP3eC3cIH/IJZQwCunVG9zbeghRUHDs77zDPfoptBwAEj5ByuEVX0ny6SzLpTvq2t7
 YYET5sdk6u06C41XdIpjBiJ01I7/8Tp/3tfjt6PJmZGtZdcIv/Q7Guqd4kd21xih+n7t
 Tg32GNEbOOOq9E3W/b4IJvxQqGPuRhryxW32twfoOSgs5HK1IchfB2EzzsUeq6FGl2U4
 52Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHvEX7quBGphRb/boq+iWoVA+FdOqLKs3ojsxDwc8vcGIfrG3hfkbzVobDbDKufg7mIF156Q49fYaGfZ7JpmtkiGTr1Oo=
X-Gm-Message-State: AOJu0YyUm+mMpEbICgRa4ADk5a2CW9S0dVSxp0FElvxskV4xN7fj/wbj
 Hqux4FcAaIGjr6VOxUDtst4m3/wvBf3D+zyW3haf91iAuR6ea3/2RoqaS6Zw687jMPvMnLheZEl
 0OCnVhCkLWKLl9hhnr5wMImzlE19jh86wvFv6e5UbwAzS+BCROUKKfV9m+Ykub2fZmFpq9lS8WD
 DVwBvFsmiCaWoWVUygbe3vXb0kBIk=
X-Received: by 2002:a5d:5983:0:b0:359:b737:51e4 with SMTP id
 ffacd0b85a97d-359b73753dcmr962220f8f.2.1716788817908; 
 Sun, 26 May 2024 22:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFDk3mtytrZ9jeyU7UHU0Wp2AS2T9chUrSd27kPYeAiIn4SkOjW6ZQp7lJFxzZbWpivFOlxidrPJz8eCpIwDQ=
X-Received: by 2002:a5d:5983:0:b0:359:b737:51e4 with SMTP id
 ffacd0b85a97d-359b73753dcmr962206f8f.2.1716788817463; Sun, 26 May 2024
 22:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-3-npiggin@gmail.com>
In-Reply-To: <20240525131241.378473-3-npiggin@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 27 May 2024 11:16:41 +0530
Message-ID: <CAE8KmOwYPf_1rX_An0K5gncDAC7V5jvR735tEAomVJiVxOeyTg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] tests/qtest/migration-test: enable on s390x
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

On Sat, 25 May 2024 at 18:44, Nicholas Piggin <npiggin@gmail.com> wrote:
> s390x is more stable now. Enable it.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/migration-test.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 94d5057857..7987faaded 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3428,16 +3428,6 @@ int main(int argc, char **argv)
>      migration_test_add("/migration/analyze-script", test_analyze_script);
>  #endif
>
> -    /*
> -     * On s390x, the test seems to be touchy with TCG, perhaps due to race
> -     * conditions on dirty bits, so disable it there until the problems are
> -     * resolved.
> -     */

    -> https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg04774.html

* Above patch (not reviewed yet) adds comment about sporadic problems
on s390x, and this patch says s390x is stable now? It'll help to
mention in the commit log - what changed to make it stable in 1 day.

* IIUC, this and the ppc64 patch above enable 'migration-test' for
s390x and ppc64 platforms, when KVM is not available for them? ie.
When running s390x & ppc64 migration-tests with TCG on non s390x or
non-ppc64 machines, right? Maybe the commit message could say
something to the effect of - enable s390x and ppc64 'migration-test'
to run with TCG across platforms where KVM for s390x  OR  KVM for
ppc64 is not available.

> -    if (g_str_equal(arch, "s390x") && !has_kvm) {
> -        g_test_message("Skipping tests: s390x host with KVM is required");
> -        goto test_add_done;
> -    }
> -
>      if (is_x86) {
>          migration_test_add("/migration/precopy/unix/suspend/live",
>                             test_precopy_unix_suspend_live);
> @@ -3619,8 +3609,6 @@ int main(int argc, char **argv)
>                             test_vcpu_dirty_limit);
>      }
>
> -test_add_done:
> -
>      ret = g_test_run();
>
>      g_assert_cmpint(ret, ==, 0);
> --

* Otherwise, the change looks okay to enable 'migration-test' for
s390x with TCG IIUC.

Thank you.
---
  - Prasad


