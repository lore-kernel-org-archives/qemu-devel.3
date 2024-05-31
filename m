Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8DFC27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwk0-0007Xp-Ba; Fri, 31 May 2024 03:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwjz-0007XF-An
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwjx-00043K-V1
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CgXfs4folI1DapJVucqQUzTteuK5ZB4Qp4ndcDea/yU=;
 b=dS74kHmlhZu289pPV36LbDto/AiwY8aSAB9bOkU98DDo1MpHOPbaETevE/D+fQdNpaOcPA
 XohbYMDN10ir8KGzRUypKhtzTdsqbS08IxNdYBl0VAqmLCq4/2LoEbE7L1bKZ7EZidcn54
 0kcBI+Yzc7fhlMyuJfNWEbrFhhpHw8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Jr4iiE9PPZuNfXWDfBOXqA-1; Fri, 31 May 2024 03:31:48 -0400
X-MC-Unique: Jr4iiE9PPZuNfXWDfBOXqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212a3ddb6bso6875465e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717140707; x=1717745507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgXfs4folI1DapJVucqQUzTteuK5ZB4Qp4ndcDea/yU=;
 b=aHWwD6qNBONyTJBuGjtDiycIXEhcJsUzD3+CzR24ts1XgEWwGy44HqJiNe6Up7zoLX
 THww3T3KU11ltG3DkRiukoN3tH9jog05XXbQFX8ri8wt1uh575B8p0zb7/BmedP38KPn
 O9U3c7YRYfyMyMLCfkXwkM8D6gLlxgGzxHTsndQWWrRaf6f9ETwn5wLEzhY5rpk35l0U
 ajP+RuJjQAI0YFN+bX+qlchDEaSR8/+b0QhsSni1HRr/s046z0xRnA+NaBIMIHBPNsvo
 0WRBOJL4RSWqSR6QvPfoL6E7U2yvfTpnvOS3OBAPjFz1ZxPkqycPuzIJPpiVzeItPf/P
 DhSQ==
X-Gm-Message-State: AOJu0Yx0iJ+b26MwnDwC76cffJ9xCzwOUkkbCOdO7zbQgcnQNS0NGAhC
 wnuOrly+CC0+saHhJFzYp9H2fvr00G7O+An4n051F1l3dQfN+QCU9f12bTTPQGuk03lFYGM1kXj
 KaF2RXJSyyem51SxGGVZtt8sdQkEy0heVRivjYzIEqqnNTOpoPft83f7FPT7dqOgz1XygcuBaAt
 ZSO8HsoNfk/nuSC5bYoy0f0teqpvM=
X-Received: by 2002:a05:600c:c06:b0:421:21d2:abf5 with SMTP id
 5b1f17b1804b1-4212e0a534dmr9573365e9.31.1717140707462; 
 Fri, 31 May 2024 00:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeAjQPBKdObtlNEG42E+Fm5qoDnzzlZ5r0Ma4tD0Cce0JUTUCXgMASE2gOCGClDMrQObYgWd2vDky5te213mI=
X-Received: by 2002:a05:600c:c06:b0:421:21d2:abf5 with SMTP id
 5b1f17b1804b1-4212e0a534dmr9573145e9.31.1717140707094; Fri, 31 May 2024
 00:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240530074453.21780-1-npiggin@gmail.com>
 <20240530074453.21780-3-npiggin@gmail.com>
In-Reply-To: <20240530074453.21780-3-npiggin@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 31 May 2024 13:01:31 +0530
Message-ID: <CAE8KmOwn6BuFgid3wAHxHjLJK-qd5gpH3hwBaAHOtv9SgfH5Vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] tests/qtest/migration-test: Quieten ppc64 QEMU
 warnings
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 30 May 2024 at 13:17, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

* No commit log message?
---
   - Prasad


