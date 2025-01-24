Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A7EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLtY-0004RX-UP; Fri, 24 Jan 2025 10:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbLtX-0004RK-6Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbLtV-00061M-Mi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737733613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Z8rqWgHVHOXm3tdLHuX1XKYEJ3QPuYrJlTQOr0sUMQ=;
 b=Yyg8z2r1IHZi9FHyyhduQOLEmhef9tmWIE5/oiB0G3Y/SvMC/lZwVa1btiahoJn6/NEpn0
 DPgLdUWn1twbr/zwIWvn1oiZCblx9mC4hat0Rvxb3GTES5MDs1ORnIHXVpCVFi6oFFiQYJ
 wYfggBo/67EB906j6MwCxsB+wJOWNZQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-953ivmf3N82Ml0iyq-1Oig-1; Fri, 24 Jan 2025 10:46:51 -0500
X-MC-Unique: 953ivmf3N82Ml0iyq-1Oig-1
X-Mimecast-MFC-AGG-ID: 953ivmf3N82Ml0iyq-1Oig
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7bcf4d3c1c1so323933785a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733610; x=1738338410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Z8rqWgHVHOXm3tdLHuX1XKYEJ3QPuYrJlTQOr0sUMQ=;
 b=w882BJl4YrL5xlYtYGEYM3J8llJThfsJOF0eEUFVQgWOV9I2xRKn4wmQkSFlG8qkos
 9CEu16kDwCCRs3NgDyfARaAZlC0oIHTqn+OD/BNvMImF3qUJiU17lrFnztBd+QvpUWun
 +1EyZHmsaXdIbb6xE2rVzEoIUhMDkvDH1L5QcTYOQThg79kSfJbA/S/z937+hZQ38ri5
 yMsE+XpxODAoCkXChPqqSyN+a536OeVFXRA1Cp8hDstLifzLCsmrusyaCnGK+mi3/vxg
 4aN4QKykajZElplv8hjkR4ff3KKKEVQrezBoAotQ+tY85akR3jxFFzO22x/5727khIe7
 W+rg==
X-Gm-Message-State: AOJu0Yzc/rajNBaQLEfgl+pIut7D1fbP4tjVVgO10Ra1abKgaKYXR3jH
 lRE5o0hm8DVU0gWCyijXS4ey4q6J0N5knyebf24luCOhNLAImu0jgY7npI61lraykHc11HO2D4N
 Sd197PoTgLi/HwtXIWFLeL1qWVFY3zYchFXnRlnUaGdf2tWycTIPM
X-Gm-Gg: ASbGncuU0a58QZG2oA4mxbcax8RJPzbv6a6C4ekIBe4XP+RpcqOlWz4S+0IHn/t9Xrx
 WOLwGvp883GT7KosKCL8RQBvzuo537L7H+AXuJrA/yEDMQQkb+wKM2PhXfSI7jmKtxuvug0XDny
 PCAYV5e1/syL6hnf6gKYuuuPem/rbGApB57Kx5g31n5cv4VwlqZe7rYj+f4uul4ewSZpLhsNszT
 UnGO7YnL0MlhGRfOLcanuLC90vDpcaeudN+3KEph0qEYdBirse2DIop7C0wzCgaTIt4+kTWFcdF
 nP94OQtdFGm7SSyJXUwcAyEh4U0Uu1k=
X-Received: by 2002:a05:620a:17aa:b0:7b6:c92e:2e6d with SMTP id
 af79cd13be357-7be63288b8dmr4126741385a.52.1737733115318; 
 Fri, 24 Jan 2025 07:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU63jVJlcMMd0itD6Gw+gz428lXpNOqJxgJiZx5fUxwvbISU0gfzbvS5oWz5730WrCA/6Iqw==
X-Received: by 2002:a05:620a:17aa:b0:7b6:c92e:2e6d with SMTP id
 af79cd13be357-7be63288b8dmr4126739485a.52.1737733115030; 
 Fri, 24 Jan 2025 07:38:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aef06a3sm104310885a.83.2025.01.24.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:38:34 -0800 (PST)
Date: Fri, 24 Jan 2025 10:38:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
Message-ID: <Z5Oz-Kz4rysFQ-n1@x1n>
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
 <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
 <Z5EYbBXkjTu98rHk@x1n>
 <CAE8KmOwvp=LJ+79t9VVsZqf4APqSYxqCQVmYSg_5QaVD4vzLWg@mail.gmail.com>
 <CAE8KmOywe888S-oCoO=4=oFsXuN=AfuuqvT27LGor-UTC78YoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOywe888S-oCoO=4=oFsXuN=AfuuqvT27LGor-UTC78YoQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 24, 2025 at 06:15:20PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Thu, 23 Jan 2025 at 16:39, Prasad Pandit <ppandit@redhat.com> wrote:
> > On Wed, 22 Jan 2025 at 21:40, Peter Xu <peterx@redhat.com> wrote:
> > > I believe many of the tests can be avoided, but still below is a list of
> > > minimum tests that I think might still be good to add:
> > >         # /x86_64/migration/postcopy/plain
> > >         # /x86_64/migration/postcopy/recovery/tls/psk
> > >         # /x86_64/migration/postcopy/preempt/plain
> > >         # /x86_64/migration/postcopy/preempt/recovery/tls/psk
> ---
> $ ../qtest/migration-test --tap -k -r
> '/x86_64/migration/multifd+postcopy' | grep -i 'slow test'
> # slow test /x86_64/migration/multifd+postcopy/plain executed in 1.28 secs
> # slow test /x86_64/migration/multifd+postcopy/recovery/tls/psk
> executed in 2.43 secs
> # slow test /x86_64/migration/multifd+postcopy/preempt/plain executed
> in 1.52 secs
> # slow test /x86_64/migration/multifd+postcopy/preempt/recovery/tls/psk
> executed in 3.32 secs
> ---
> * Postcopy tests are working well with setting 'multifd = true'.

Great.

> 
> > >         # /x86_64/migration/multifd/tcp/tls/psk/match
> > >         # /x86_64/migration/multifd/tcp/plain/zstd
> > >         # /x86_64/migration/multifd/tcp/plain/cancel
> 
> * Above precopy tests already enable (16) multifd channels and they
> seem to test scenarios like: resume after migrate_cancel() or precopy
> with compression (zstd). Enabling 'postcopy' here is not the same as
> setting 'postcopy=true'. Do we really need to redefine these tests for
> postcopy migration? Does compression (zstd/zlib etc.) OR
> migrate_cancle() work with 'postcopy' migration?

Since multifd doesn't work with postcopy phase, compression so far cannot
happen in postcopy phase but only in precopy phase.

So the tests I suggested was trying to make sure multifd major features (in
this case, tls, compression, and cancellation) work like before even if we
set postcopy-ram=on in the feature list, because after your changes merged,
people may start always set postcopy-ram=on for all cases.

OTOH, these test cases do not test anything that would happen in postcopy
phase, they should be covered by the postcopy tests you added above.

Thanks,

-- 
Peter Xu


