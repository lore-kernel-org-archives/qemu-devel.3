Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08181CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRYEX-0000b3-HE; Mon, 25 May 2026 12:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRYEV-0000aY-JK
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRYET-0007RL-IW
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779726767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=isXcrrT9lQmKtWK1qmg8jpI7HwGACBTn9FCRspXKWb8=;
 b=X0ATV/lVUFldGCJPga2Jh1Bai35Rvq5yq5jnG415gIOyr/b3mAdF6qj78JBuUTaElqKA4c
 m68A/eRADspWb7S2K7RIxhWhLdcloSXAUr9yEEuKk8pWGpk1PeRP3T6rQ04F+GPpqS7cIf
 x6ZTBtUzqN49XM/S11CCBBreS7dkouw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Jd-T8U8GPFqbNjeYGIAC_Q-1; Mon,
 25 May 2026 12:32:46 -0400
X-MC-Unique: Jd-T8U8GPFqbNjeYGIAC_Q-1
X-Mimecast-MFC-AGG-ID: Jd-T8U8GPFqbNjeYGIAC_Q_1779726765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F3A7195608A
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 16:32:45 +0000 (UTC)
Received: from [10.44.32.152] (unknown [10.44.32.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5E38300019F; Mon, 25 May 2026 16:32:43 +0000 (UTC)
Message-ID: <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
Date: Mon, 25 May 2026 18:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com
References: <20260524083329-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260524083329-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/24/26 14:42, Michael S. Tsirkin wrote:
> 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> 	content generators commonly available today is unclear.  The QEMU project is
> 	not willing or able to accept the legal risks of non-compliance.
> 
> But, since this was written, Red Hat's Richard Fontana and Chris Wright
> published this piece:
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> 
> Saying, in particular
> 	We understand this concern, but the DCO has never
> 	been interpreted to require that every line of a contribution must be
> 	the personal creative expression of the contributor or another human
> 	developer.
This is not the objection or the worry; rather the question is, what if 
the contribution is a creative expression of someone that could claim 
copyright in it.  In fact, looking at the Linux policy...

   Signed-off-by and Developer Certificate of Origin
   =================================================

   AI agents MUST NOT add Signed-off-by tags. Only humans can legally
   certify the Developer Certificate of Origin (DCO). The human submitter
   is responsible for:

   * Reviewing all AI-generated code
   * Ensuring compliance with licensing requirements
   * Adding their own Signed-off-by tag to certify the DCO
   * Taking full responsibility for the contribution

... the question is how humans can actually do the second step.  The 
piece you posted above says: "with disclosure and human attentiveness – 
and oversight – aided where possible by tools that check for code 
similarity, AI-assisted contributions can be entirely compatible with 
the spirit of the DCO".

This is not encouraging, in my opinion, because it leaves a lot of the 
mechanics undefined.  A while ago I suggested that in some scenarios 
this could actually be done[1][2]; another possible case is localized 
bugfixes (say, below 20 lines of code).  For more general contributions 
however, the role of maintainers is not clear.  Would we require to 
"check for code similarity"?  I sure don't want to open that can of worms.

> I propose adopting linux's rules instead:
> https://docs.kernel.org/process/coding-assistants.html

Replacing QEMU's policy with Linux's would be orthogonal to the topic of 
the DCO.  Maintainers would still have the option of rejecting 
AI-assisted patches if they don't believe they can apply their own sign-off.

Other projects have taken similar "no AI" policies for different 
reasons.  Zig has one because they believe AI code would make it harder 
to retain contributors[3][4]; Rust is working on one that is fairly 
restrictive[5] (discussion at [6]) and requires previous communications 
with reviewers about *any* generated PRs[7].  Personally I think QEMU's 
policy is fine but we should start introducing exceptions, possibly 
including large contributions with pre-authorization (but not 
pre-approval) from the maintainer.

Paolo

[1] 
https://lore.kernel.org/qemu-devel/20250925075630.352720-1-pbonzini@redhat.com
[2] 
https://lore.kernel.org/qemu-devel/20251008063546.376603-1-pbonzini@redhat.com/raw
[3] https://ziglang.org/code-of-conduct/
[4] 
https://ziggit.dev/t/bun-s-zig-fork-got-4x-faster-compilation-times/15183/19
[5] 
https://github.com/jyn514/rust-forge/blob/llm-policy/src/policies/llm-usage.md
[6] https://github.com/rust-lang/rust-forge/pull/1040
[7] 
https://github.com/jyn514/rust-forge/blob/llm-policy/src/policies/llm-usage.md#experiment-llm-created-code-changes


