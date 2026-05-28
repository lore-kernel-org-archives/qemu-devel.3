Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0F4CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVEl-0000Q2-Py; Thu, 28 May 2026 03:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVEA-0000Dh-Na
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVE6-00069f-C3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779953536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ugL9KYdatHV7NKZfQFAhfhrl1KnZBbvAb6FA4E8O8Ng=;
 b=PUU34wtBrbRC3j+w09J8JSYT07FmOBlN6yIPS75lmqVw3MEraD69GlYMFszlz523VilLGm
 Tq8z2RLI6uVBen19ECmvpfdME5I30wWgT+cdBChjNTEG6q1GTnP52Bs4lktwzVc3PNnoCF
 OXiZ5XbAYgn2oI4qgWFs6qjbj0tu9ok=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-gEQ-Y2SxOaGpUC_noWKHeA-1; Thu,
 28 May 2026 03:32:12 -0400
X-MC-Unique: gEQ-Y2SxOaGpUC_noWKHeA-1
X-Mimecast-MFC-AGG-ID: gEQ-Y2SxOaGpUC_noWKHeA_1779953531
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FE2E18002E3; Thu, 28 May 2026 07:32:11 +0000 (UTC)
Received: from [10.44.32.217] (unknown [10.44.32.217])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA44176F; Thu, 28 May 2026 07:32:08 +0000 (UTC)
Message-ID: <17967e10-4681-466d-a8a6-ad1a3e6f8776@redhat.com>
Date: Thu, 28 May 2026 09:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
References: <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org> <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
 <CANCZdfp4OQEoOQk5v0B+n8GaOb1a=FiLjLy9jGG9G_AWY79xNA@mail.gmail.com>
 <CAKmqyKM8yQ7mDRv6anW-7QSjKcgwxj-RoVikJWV0xuT+CgJDFg@mail.gmail.com>
 <20260528010422-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260528010422-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/28/26 07:06, Michael S. Tsirkin wrote:
>> I could see someone reading the proposed wording and then sending one
>> 20 line patch, then another, then another, then another, then another,
>> then another and then more. All while only sending "small patches",
>> but the ability to generate a large number.
>>
>> It's not clear to me at least from the proposed wording that we should
>> discourage that.
> 
> Maybe we shouldn't? It's far from trivial to split up functionality even
> in 100 line self contained chunks, let alone 20. And reviewing
> such small patches is *easy*.

Bugfixes for something like TCG front-ends are usually well within 20 
lines, or even less:

     target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
  1 file changed, 10 insertions(+), 6 deletions(-)

     target/i386/tcg: fix typo in dpps/dppd instructions
  2 files changed, 4 insertions(+), 4 deletions(-)

     target/i386/tcg: fix a few instructions that do not support VEX.L=1
  1 file changed, 4 insertions(+), 4 deletions(-)

     target/i386/tcg: allow VEX in 16-bit protected mode
  1 file changed, 3 insertions(+), 7 deletions(-)

     target/i386/tcg: do not mark all SSE instructions as unaligned
  2 files changed, 9 insertions(+), 4 deletions(-)

     target/i386/tcg: do not leave non-arithmetic flags in CC_SRC after 
PUSHF
  1 file changed, 1 insertion(+), 2 deletions(-)

     target/i386/tcg: mark more instructions that are invalid in 64-bit mode
  1 file changed, 4 insertions(+), 4 deletions(-)

     target/i386/tcg: ignore V3 in 32-bit mode
  1 file changed, 1 insertion(+), 1 deletion(-)

     target/i386: Fix #GP error code for INT instructions
  1 file changed, 1 insertion(+), 1 deletion(-)

     target/i386/tcg: validate segment registers
  1 file changed, 6 insertions(+), 1 deletion(-)

     target/i386: Mark VPERMILPS as not valid with prefix 0
1 file changed, 1 insertion(+), 1 deletion(-)

     target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
  1 file changed, 2 insertions(+)

     target/i386: fix x86_64 pushw op
  1 file changed, 1 insertion(+), 1 deletion(-)

     target/i386: fix width of third operand of VINSERTx128
  1 file changed, 2 insertions(+), 2 deletions(-)

     target/i386: fix TB exit logic in gen_movl_seg() when writing to SS
  1 file changed, 5 insertions(+), 2 deletions(-)

And reviewing them is not necessarily easy if they touch weird corner 
cases of the architecture.  The code change might match the intention 
but you still need to check the manual.  Or on the contrary, the error 
is apparent but the fix may be obscure, as in commit 5a2faa0a0a's 
single-line change:

-        [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
+        [0x0e] = X86_OP_ENTRYr(PUSH,    E,d64),


These changes could still be welcome, but I suppose the maintainer would 
also prefer a heads-up about them.

Paolo


