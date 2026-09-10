Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F22C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fN0-0005uq-Ob; Thu, 10 Sep 2026 10:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4fMx-0005uc-Dp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4fMv-0002QB-6D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789048991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9RRPg656/ekFm/oV7YgZPH9EkFEQVRxNuPDJWp9dv4=;
 b=KUYUfaK6VW7K64cv/jNoob+q9HOkUQvi5eFkvU5qYYaJLHaJYS9fgvSBavcyPILqSgn4lJ
 aSoXCS10RjqufNSmBCSrCL4XUrQfqzqngy3GjSf0bytcOFP+TIZvdgqZsGSRaHUvBh0QmQ
 OogzaWDvmDUXyCPnAHUZtcoSU1x4JRE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-AH97x05hM8eBPk99SMfwcA-1; Thu, 10 Sep 2026 10:03:09 -0400
X-MC-Unique: AH97x05hM8eBPk99SMfwcA-1
X-Mimecast-MFC-AGG-ID: AH97x05hM8eBPk99SMfwcA_1789048989
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90ceabcd64aso143318556d6.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789048989; x=1789653789; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+9RRPg656/ekFm/oV7YgZPH9EkFEQVRxNuPDJWp9dv4=;
 b=SFdeiTqjWvN2Mme4rBZARgo67pgBN2LuVeDL0/pZzOxuMRmrE60NtVPc/Fteq3VXYT
 lO+fuQKZAzzAWM9wZYzKLYRRkzaKUEh4dnhnOi/bimm/rpm+00lpbgxosYFrHl7B9g+X
 k/kst9c+3FYU6pdkt7HrhkSfAndJ2hSvKKx5mRXRDkR2+VCK4MBBRtCf54FYokMbZjxG
 U4y3JMLkUdjNR75oPy7zyC5Hvxt7Cr0L0L1/E+6XNTlIybXFd2E8QQ89aN6HzQziP+WB
 abI4XWU0bwsIyEWUBQCjYbln7fAZeMfpRuh/Yff+/1QyVGcbExHA85EojvJzSCyYTuK/
 kxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789048989; x=1789653789;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+9RRPg656/ekFm/oV7YgZPH9EkFEQVRxNuPDJWp9dv4=;
 b=pZ2Z4wmyiTwyXCHvfnNgEJWOZJ+8li1JGEGS+ugruSt+0mS/V004N71e/7gOhFzJAc
 XLb0fb1TO8r5jRGTG51hFUR34HoruF+fxybjA7V5BkLVVmZ7gpDTA/ccK9iqh27Wn0fv
 Ncxi2isiw3FPLKCxORAPJ6T4ig9fTysNSh5jZU1dLDriByuF6Gdrh3TOePLpDCdhOzoo
 3GZp22Rze9cf5iPsvTg27qYuBzyQfXeZ5TptiKUd6sg9JH+eCJMYd8fzbn0wcGwp8tfe
 BsdTnnIF0rEeEB5GSD+eh2y1dzOQcIAHTh+g2xfIY5tDMY989saIyo6xzsBw40y3g7Al
 K7Fg==
X-Gm-Message-State: AFuF++n4pldTLddzC4LdWcnFF1wvY0qCsQ+nRrCZ0RtCpEkxeZr0Fk2h
 OhVTJzOn3IS99yOkyNJbOJ0zRkzXqpI7cuuqauQSdfes1FaCHgESETSkuDJb80tjbfhq7KbQEBK
 AmUvJbkCu2fvzc3KhIiW29WNXqHWYBlFR/7Oj5K8ea+X9NIgvdZ3r8tEL
X-Gm-Gg: AYBFou1qNOUoU6lc/RSvi9XRhLddDv+Z+JnlWIuo3yEZHW1j3JQUzgFn9e+fjKr6qBE
 Ebt1jdgkV9RQecHHDyQVaIq+yFFgq8N9q+KLBpgRbvTTqBDhN3FR7VX2RdqOovkBgxjfyR0FSxN
 7ySP2RRut8BMPBTF8xY9yuRYQXCweB2iKNoGnPzzM9CMr+H4WKYjxb2DCPHmHWU1xWSgrP+9HAV
 AkOvbNEEr6+6vUukt9tCLKRC69V+w7PMK2cybUaYc2JqpxWC2iiqmEAa2ZGH9Ikqcc9bwqT6LmK
 buT6rngZohz3EY3vvNtM1JQ5flBwx6aJu/cPfLwwD8h8xrw8l7anYnNGKetbKa1J0EQjPMwH
X-Received: by 2002:a05:6214:3305:b0:90e:98e7:4481 with SMTP id
 6a1803df08f44-9103f041c78mr498032366d6.29.1789048988454; 
 Thu, 10 Sep 2026 07:03:08 -0700 (PDT)
X-Received: by 2002:a05:6214:3305:b0:90e:98e7:4481 with SMTP id
 6a1803df08f44-9103f041c78mr498023756d6.29.1789048983188; 
 Thu, 10 Sep 2026 07:03:03 -0700 (PDT)
Received: from localhost ([2605:8d80:6d68:6319:5b60:41d6:dc84:a238])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693abbsm171197436d6.37.2026.09.10.07.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:03:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:02:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/18] tests/qtest/migration: Add a test for HMP
Message-ID: <aqK4kxs6GnM70rsM@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 09, 2026 at 06:44:59PM -0300, Fabiano Rosas wrote:
> The following patches will change how parameters are set and shown in
> HMP, add a test for it.
> 
> The test issues HMP migrate_set_parameters for each of the existing
> migration parameters and queries them back with the info command. A
> list is kept with the expected strings. A substring match function
> inspired by glib's g_str_match_string is implemented for this test so
> the test can produce a decent error output instead of just assert
> failure. E.g:
> 
>  # HMP output mismatch for entry at line 55:
>  # expected vs. found:
>  #
>  # max-bandwidth: 10356305952768 bytes/hour
>  # ---
>  # max-bandwidth: 10356305952768 bytes/second
> 
> (note that line 55 above is the source line where the test case for
> max-bandwith is, which helps find the failing test in the list)
> 
> Usage:
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/parameters
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I didn't read into details, but it's a nice good test case, let's ship it..

Acked-by: Peter Xu <peterx@redhat.com>

One thing to mention below, no need to change but maybe for future if that
makes sense..

> ---
>  tests/qtest/migration/misc-tests.c | 201 +++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
> 
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 4e0deb7f18..533cf3d55d 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -22,6 +22,203 @@
>  
>  static char *tmpfs;
>  
> +#ifdef CONFIG_HMP
> +static int test_case_line;
> +
> +#define TEST(i1, i2, e) { i1, i2, e , .line = __LINE__, }
> +#define SKIP(i1, i2, e) { i1, i2, e , .skip = true, }
> +#define BG_SNAP_MSG ("Error: Background-snapshot is not compatible with " \
> +                     "currently set capabilities")
> +
> +typedef struct HMPTestData {
> +    const char *input1;
> +    const char *input2;
> +    const char *output1;
> +    bool skip;
> +    int line;
> +} HMPTestData;
> +
> +/*
> + * .input1: string to be used as parameter name
> + * .input2: string to be used as parameter value
> + * .output1: expected output of migrate_set_parameters
> + * E.g:
> + * (qemu) migrate_set_parameters .input1 .input2
> + * .output1

This comment doesn't seem to be accurate, because the code seems to treat
success and failure cases differently based on the initial chars.

Since SKIP existed, we could also do SUCCESS() and FAIL() with another
bool, maybe.

-- 
Peter Xu


