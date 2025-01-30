Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F4C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbto-0003AA-8N; Thu, 30 Jan 2025 16:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdbtg-000374-FY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdbte-0008AY-0E
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738271779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mn24DYiRtry/lSEVZQyMcVIU3zFn23RVbkqwvpCT+G8=;
 b=EwaOCCtvdzFkgsSqnlcMpfnZaqkewcLZexAexaoE2nOeY6pV6fDOTnzxUmLC+vtdgPmMBf
 DrXxGS7oJf7bXEs9TkqbIZzVI1sBVUIsoLyG6t33K2STgcwFC+B6fzreHkv6iFHQnukUob
 9f1Xp7blWLpzbzR7cbA0L63Kft+ajZM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-jWzs93JyPCuFqZO-1UUjoQ-1; Thu, 30 Jan 2025 16:16:17 -0500
X-MC-Unique: jWzs93JyPCuFqZO-1UUjoQ-1
X-Mimecast-MFC-AGG-ID: jWzs93JyPCuFqZO-1UUjoQ
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87efed6c4so17416526d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738271777; x=1738876577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn24DYiRtry/lSEVZQyMcVIU3zFn23RVbkqwvpCT+G8=;
 b=xPSoARBydRjGL6fXL9Rqirs4dp28Wf5nEtdCNqLj+0xMt+zCWy+pe3zPmGxZTOfDBa
 ctoEHRtp05MZ2ssAsY+HHUVp11iAWweB8cZwzsRtFpUOrrntqqHwoJQNpVWpVgfpxeOO
 vaGQAECljRVAU0l7rwYL+U0CbhNG/jZDtUfjkRzp+fPcu83KQG9y+H1bKaasnRPA77UA
 3r5oHg0IMc2OIW3vjzsYPUfGXwtUdQ/qovg/SDoyKczRBU3ROrkaZiXQujEAnSqLwczG
 9GWHE1nzzpjBExMY1qZZbvC5JwFrhCgokhrrlVRMcWla74tMCo5x8gWUdADSEdKHiWjG
 yYgw==
X-Gm-Message-State: AOJu0Yx3pg4CZgZDDLbzz4sUHcYnY3XyEo5zXMrOxOJgdgBxIOmmJybh
 9Tl85gpCw8zL7+NRmTNO2yvq4aA/JtNi/9dwlq5IKYWazJBFk498HRjQZaJA7HLi0egJTv0V+JD
 22b6IKGkhQvMmZphpysLM5KYxCG3xeOPnw1vFQ0fZl/CcpZ/FA9b+
X-Gm-Gg: ASbGncuFsNHHkMet7Tp16ln9dg/UnfibMy02okaIyYFAGzoQqMApPIrunCWskYMKZ72
 vp7+vYaySkYEW26Bxsmg6m2BFkzGzeCz3QR7WvbND2vuOaZorEDfoyGFZFKA4gefPgUh3OuiKl3
 hVAGOchcblX7dvU4xgpBto8EM0NR+aKCQ3JT5LgDopHVt9mq2RRFbyQNYZAifWuzF4+FvM5GZmb
 W4ikaHi4aJqIGDNFg5Pc8bFVAzeheiNf7sk3p/lxA3moH39rikJZEpL+4I0s9BSu1SRcoNZvsoB
 xP6A9uqSYmUaUr6F8bbzYcBMiRJvzpNE01alkcgjR04KtoiT
X-Received: by 2002:ad4:5bc4:0:b0:6d8:a730:110d with SMTP id
 6a1803df08f44-6e243aaf082mr107661836d6.0.1738271777242; 
 Thu, 30 Jan 2025 13:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn57zZuiOycnSgzOb9QbiTP7QVFWNb1Ao3T+wHSUpzLElYZHiJdu0iLLqGBYBCsl109IaFbw==
X-Received: by 2002:ad4:5bc4:0:b0:6d8:a730:110d with SMTP id
 6a1803df08f44-6e243aaf082mr107661636d6.0.1738271776986; 
 Thu, 30 Jan 2025 13:16:16 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922451sm10061166d6.79.2025.01.30.13.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 13:16:16 -0800 (PST)
Date: Thu, 30 Jan 2025 16:16:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] migration: Reduce migration-test time for non-KVM
 archs
Message-ID: <Z5vsHZZIut6T5KqQ@x1.local>
References: <20250130184012.5711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130184012.5711-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 30, 2025 at 03:40:10PM -0300, Fabiano Rosas wrote:
> Hi, continuing the work from the previous[1] series to reduce the time
> migration-test takes during make check, here's a couple of patches to
> create a smaller set of tests.
> 
> The change is that from now on, ./migration-test will only run a
> limited set of tests (~12), while the full set (64) requires that the
> --full flag is passed on. Only those calling the test manually need to
> care about this new flag.
> 
> For everyone else, qtest/meson.build will automatically add --full in
> case KVM is available for the target architecture. All other
> architectures run the small set.
> 
> The choice of tests for the small set has been arbitrarily made in
> patch 2. I expect that once we close in on a list of tests, new tests
> will only be added under the --full flag and the small set will be
> kept stable.
> 
> An unwritten but maybe obvious rule is that slow or flaky tests should
> not be added to the small set and once detected should be moved to the
> full set.
> 
> More details in patch 1.

Looks all good here, thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


