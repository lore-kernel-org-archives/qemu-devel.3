Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3464606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h6pM+NzE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pXA2dZNL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHhw-0006Sw-M7; Fri, 23 Oct 2026 12:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKHhg-0006EC-35
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKHhe-0000nj-Ek
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792771269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1e2EBxzNcduu5WbWRn0eGH2gSmzL8x3EdjldhXcqvI=;
 b=h6pM+NzE3sv+Dej6yM4FNgu7MeZU6+Plg353D/Nu1rwdtGlpIHttbnQe7XNt+rMPJp7tw+
 oKUuYnhQ6u17TFDRuroZqcUXAwQv1UGORtKQh5DhxZeRG1QANqQ+Vf/VUjl3zTYVf5YxxA
 2fdHJtoOLu+lncIOb8y9+gldSFQmS/o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-S7XEbbRwNgKO7FYF7MJl9A-1; Fri, 23 Oct 2026 12:01:07 -0400
X-MC-Unique: S7XEbbRwNgKO7FYF7MJl9A-1
X-Mimecast-MFC-AGG-ID: S7XEbbRwNgKO7FYF7MJl9A_1792771266
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so11935565ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792771266; cv=none;
 d=google.com; s=arc-20260327;
 b=fUIBArPRpf3uyRIwJ4prO5qKAFFM+yOhq69XgbJhp2derZsUpw+Rvgsw2sXKIBCXi0
 LsvBF7hganuk9OHQClvFlEzEGc3i1QLzskJX4zkSoM8ujenB9E33o8WuVcbuNdqz2cMr
 C6G9XqN6eiMEoKt5/1NhWCoiqKxZ7MKsmcabj1QHUVIyfBETci7Qy5XjkK7FvN+4kTt8
 nvU/bguhA2FHjrvH3lkaaYqrHxlBCoJ/CnvAjt5qAW5R6kkWS8OLAOubupcL143DdOI3
 Xda5n7F+W4atYJ9kUpXwj9i9Nnc9fdn9zu56JOnEReOaeHDg+PVePZW0YO7kh3vZhG3a
 24nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w1e2EBxzNcduu5WbWRn0eGH2gSmzL8x3EdjldhXcqvI=;
 fh=OZgGWj7T/TxR/n8+1M3XCEvKoEYfE0ZmFy+VR7YlzAo=;
 b=g5uUE53bnU6Za00NcgjvzhT6pgSZG9bUdANGlOkUaR0u+zAnq1NbO+KscWW9wtnAs2
 oKtvmX/g1WImiVA0qYpyJrvw2HWfaV0HIgHnk76c7J3YaSVHdSw/oqs5ZzMWf30S7Jdy
 MLhlUOO7Piq2dS1yp7ULFgvWwN6emuojLqoyKRckrjMHREe7lMBdK/LvMNSQD1pddYU1
 HGNvBoJ3Wuo+ipkC9RSQ3nwqN4lBpU5nrqsBCBLkWLrAX7+4jXk+pNouRq/rJUdjN8C8
 dhhBcOyy7kkQYllBZ2ws/iMwmgx5rhAspmiWBaUZrX6W48AmnjrTEfc1ElQaNPc29lcy
 9RNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792771266; x=1793376066; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w1e2EBxzNcduu5WbWRn0eGH2gSmzL8x3EdjldhXcqvI=;
 b=pXA2dZNLnMdS2bZT1TdHLh9xrRcg1KwWWtAwaUGZ9UlP20VbR+fzWxxzZtcBkPCY0u
 dd8BJiZFmYbMem2ByzNsvwY2/6i7Tx6C8BpNhFno1G51yQTmAX7PD5f4Kpmqe+PSS2S6
 WsD/eEmwfU+IsuCnnDSfekipGR/4JjcAnEu9QDLdDWp4nziM7yEfNIoijIhuOKhp0Czl
 KEhC3g4gASWEVMcGgpYo8i8yVhvj9oS/XCAL4ogIEnCKKe3i7/vGMhq5VfTkbVVqAQ6F
 VvVDjBuiSSnkD2j3ou9Uah4el5FyjyY8XptZIz0qIQh1CsqgztILt1NHDqDjlblI8N+n
 URMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771266; x=1793376066;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w1e2EBxzNcduu5WbWRn0eGH2gSmzL8x3EdjldhXcqvI=;
 b=o6j0WbdAf6hDhjGeq0yaNS7pefAwWEsTJombgi4q2GT8mO3Lfuz/xyLlcSZAhTXgJR
 rcRuHrcl+/Xzpnx+IXiuqtzXpIw7FoKMXUNDhVxerSM1U3BdKGRAGKrAhSq8rGRDh9s1
 +523ivBuPXMuQWEnRpDxhIPKk+J3Zm1n6Ds7LQteupsKPjW+Xp6Xa1uhwF56aJ9z1b6R
 toC66cKi+8RW0TiAZRy3/JwRBRNaCEwf709ivNjwtPjIAqtU1XSE+FMM5pu7YWNchXRg
 aqqmCYylKq+rYhsXBx9YetWe9M6hiamCSuPiQLx4jYvZ292PUYBayC26ME8087t82Wek
 EKYw==
X-Gm-Message-State: AFq9FYKiQb301frCEDaRba3IL3i1hTCx7WTRFB27rbGFfk4cYJoOIuGG
 EcieJ/cygls04YT5iMSIYu4jhsNBysnvra0j40OR9yjNz1jlWU2Wn8j4Wik+/K6zB2pdjUd4mdb
 86aocYrNY8OLtlAEeByB2aPKLYviQLBuEZkdXU4odNjOSAXLI6IgJ+RYp7xbe7e9wobKLPwpway
 9jlgau7EHb13ozpivoUcrXkTG2G+WlkNs=
X-Gm-Gg: AYBFou22s9mf58+L5N6bib8OPs9pofCTluLbK6gUEI5bu+Mc1qOoSytCk/INem9xsMA
 wgiGYuhofA7lm06AfVlCwny2fLogpO28kIyUHZIid1ns5E5AIYxWmS4dMWX8yu81kYg/Om+zDgt
 rH4NwOGBMwkaiFKQPBGwdBW/JWRuA0kyh9atJbAtAKqmHFQu6X0HnNUbE=
X-Received: by 2002:a17:903:2b05:b0:2e9:8510:6ae0 with SMTP id
 d9443c01a7336-2ea7d03f6b9mr24977715ad.44.1792771265672; 
 Fri, 23 Oct 2026 09:01:05 -0700 (PDT)
X-Received: by 2002:a17:903:2b05:b0:2e9:8510:6ae0 with SMTP id
 d9443c01a7336-2ea7d03f6b9mr24977225ad.44.1792771265095; Fri, 23 Oct 2026
 09:01:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 23 Oct 2026 18:00:53 +0200
X-Gm-Features: AclHuK9fSuAWcKniW9jc56wGn5Scm3JO8lV4Z0zzLq0TWmjG9qoYRPcCJiKk630
Message-ID: <CAGxU2F7nP2jOTiod1bu4Ao1XgNL7fVz_Dk2hnY32TMnCgpYT=w@mail.gmail.com>
Subject: Re: [PATCH 0/8] vhost-user: another try at supporting any POSIX system
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 15:48, Tim Pambor <timpambor@gmail.com> wrote:
>
> This series continues the work started by Stefano [1] to add support
> for any POSIX system to vhost-user.

Cool, thanks for doing this!

>
> Three patches from his original series were never applied due to failing
> tests [2]. I was able to reproduce these test failures on current master.

Oh, nice, I'm curious, how did you arrive at the fix?

>
> Patch 4 contains a fix for this problem. Patches 1-3 fix further issues I
> identified on macOS. Patches 5-7 are the three unmodified patches from
> Stefano's patch series. Patch 8 contains another bugfix I came across
> while testing.

Great, I'll review next week.

Thanks,
Stefano


