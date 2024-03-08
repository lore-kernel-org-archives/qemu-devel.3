Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF81C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridDq-0000vI-8y; Fri, 08 Mar 2024 11:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackmanb@google.com>)
 id 1rid2Q-0004fL-7L
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:25:38 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackmanb@google.com>)
 id 1rid2O-0002FZ-Gb
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:25:37 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-428405a0205so327021cf.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709915135; x=1710519935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNKllj7mYvx/xxkLemA0fJHMcGlcVpU323BzoEH+uFQ=;
 b=zGreXe3vKN28mx2LptZilJUuXZRAHGcUPDAfn4PvWJKx40ZQJrdl/xjOCgIvcl2bBv
 wRNrOl2g6VlTw06HFekykIvVP9HCD9ofshqrsSBtlFN2bMHhB1LdxGvhqPEh9ktwZkSN
 KXHeWNPaTKsui+yRhmC9O7Ws/uquJkj4Dmwg58HOkcgO26wXtdNOV3KtAHJ7atulUzkV
 xL92LXF3/RECasdaZuiC9lNd1qDysSUUnf0oJ02E7PHD0NUyM7tTmwyNJIZ8tQUsC8iF
 2MWjHy/0taz+gOPsqwOzYg/wi0AxFGTB3y1+GJCKRzlPt8N26ZYTNBPeArjBsVkupi+c
 YwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709915135; x=1710519935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNKllj7mYvx/xxkLemA0fJHMcGlcVpU323BzoEH+uFQ=;
 b=iblOVwMEm7l6wbaPnQ3IDcjI6gwt/vAtuS7Hl95z5Q1Zios6hQP9wY5nLLpLs/GN3X
 TUXvfc8jS7JoqknlkmINfBGg2pnS/T2Q4L9YjoL2VHMS+dqF5ZOeph/lSi6gZ+kqOu6J
 a+axcL5AzuRbCB5l3k03mqNd4CmMLu+wSZLvzqdjvTqzxNY0sGki0IbuHioUEtjnPaCY
 Aw86jQ27SO2v21/GwqTV5K08lLvMB6Pp7pvF17Rb2cQP+J2uOs1RdyfMXHY1oEwKqqBm
 xuyGfoo/V6HakgteHd4WfMt9bZvXG5mZ+pmrhCZ+Vk0SNeYjMRwwB6DpVRsLiHUn1zXn
 ZVPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJRXH0uAHSX5dkuM+hX25fz1OYAVMOxWNTi0eXV2d21cke+26RMd/js+gqblSA1bOkco/uRh4bKyJ6jKWw6PlDw3gdPKo=
X-Gm-Message-State: AOJu0YzNMX8FDuDkmqt6kuhIw4io50kJ/RTR425Nrn1VzTF62rr1q1T5
 vxouhuEvw0OmaeZJH6y0pHZVFZvfa8Ozg9ySv13Z1yfBwv7sR9RKw6EWcwtLXPE0Y/qN0j5hQXs
 bVuQBba5Plx2Nifpu0t17kOiZ7Kp3MweC7eEe
X-Google-Smtp-Source: AGHT+IElQ3xjmycZ+6ORMpUoTkFmduy8rLaNpVKLnGA7x+Z+sC1aXJ1BEUZ5RKJmqqEgd0tD5BJWRtLMqwd9EMqbzds=
X-Received: by 2002:ac8:7d41:0:b0:42f:a3c:2d53 with SMTP id
 h1-20020ac87d41000000b0042f0a3c2d53mr675497qtb.20.1709915134720; Fri, 08 Mar
 2024 08:25:34 -0800 (PST)
MIME-Version: 1.0
References: <AQHacXBJeX10YUH0O0SiQBg1zQLaEw==>
 <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
In-Reply-To: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 8 Mar 2024 17:25:21 +0100
Message-ID: <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: "Gowans, James" <jgowans@amazon.com>
Cc: "seanjc@google.com" <seanjc@google.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Roy,
 Patrick" <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "Manwaring,
 Derek" <derekmn@amazon.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Kalyazin,
 Nikita" <kalyazin@amazon.co.uk>, 
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, 
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=jackmanb@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Mar 2024 11:37:23 -0500
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

Hi James

On Fri, 8 Mar 2024 at 16:50, Gowans, James <jgowans@amazon.com> wrote:
> Our goal is to more completely address the class of issues whose leak
> origin is categorized as "Mapped memory" [1].

Did you forget a link below? I'm interested in hearing about that
categorisation.

> ... what=E2=80=99s the best way to solve getting guest RAM out of
> the direct map?

It's perhaps a bigger hammer than you are looking for, but the
solution we're working on at Google is "Address Space Isolation" (ASI)
- the latest posting about that is [2].

The sense in which it's a bigger hammer is that it doesn't only
support removing guest memory from the direct map, but rather
arbitrary data from arbitrary kernel mappings.

[2] https://lore.kernel.org/linux-mm/CA+i-1C169s8pyqZDx+iSnFmftmGfssdQA29+p=
Ym-gqySAYWgpg@mail.gmail.com/

