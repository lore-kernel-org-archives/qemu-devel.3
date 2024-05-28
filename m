Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DDBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByxa-0002a1-Vh; Tue, 28 May 2024 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sByxZ-0002ZK-GI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sByxU-00051i-T7
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716910911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjXWuB8b1EOLCAUW+Njk6CnoXCunwpGGGxEagxLPC3Q=;
 b=OFtr5uyeHh+TEW8/P9gkX73/sTMSAG4PUiRwa59bm31PmOj838upoKLdgy4LKCm63UJiH2
 BteyAjlgklZDN+19K/iF9lyoSLpq795V1TzSIHdD/RtfM2OqNBuWjtbwWjagxe+GTBJosW
 dsO7ACFwAoeiws5s9bpHD4hZRqDOBe0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-P9YWyXz2MKG_JnkF-hTj2g-1; Tue,
 28 May 2024 11:41:47 -0400
X-MC-Unique: P9YWyXz2MKG_JnkF-hTj2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF1231C0512D;
 Tue, 28 May 2024 15:41:46 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBD2C15BB1;
 Tue, 28 May 2024 15:41:44 +0000 (UTC)
Date: Tue, 28 May 2024 17:41:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <ZlX7NxLNCKQkrX44@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516162230.937047-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 16.05.2024 um 18:22 hat Daniel P. Berrangé geschrieben:
> This patch kicks the hornet's nest of AI / LLM code generators.
> 
> With the increasing interest in code generators in recent times,
> it is inevitable that QEMU contributions will include AI generated
> code. Thus far we have remained silent on the matter. Given that
> everyone knows these tools exist, our current position has to be
> considered tacit acceptance of the use of AI generated code in QEMU.
> 
> The question for the project is whether that is a good position for
> QEMU to take or not ?
> 
> IANAL, but I like to think I'm reasonably proficient at understanding
> open source licensing. I am not inherantly against the use of AI tools,
> rather I am anti-risk. I also want to see OSS licenses respected and
> complied with.
> 
> AFAICT at its current state of (im)maturity the question of licensing
> of AI code generator output does not have a broadly accepted / settled
> legal position. This is an inherant bias/self-interest from the vendors
> promoting their usage, who tend to minimize/dismiss the legal questions.
> From my POV, this puts such tools in a position of elevated legal risk.
> 
> Given the fuzziness over the legal position of generated code from
> such tools, I don't consider it credible (today) for a contributor
> to assert compliance with the DCO terms (b) or (c) (which is a stated
> pre-requisite for QEMU accepting patches) when a patch includes (or is
> derived from) AI generated code.
> 
> By implication, I think that QEMU must (for now) explicitly decline
> to (knowingly) accept AI generated code.
> 
> Perhaps a few years down the line the legal uncertainty will have
> reduced and we can re-evaluate this policy.
> 
> Discuss...
> 
> Changes in v2:
> 
>  * Fix a huge number of typos in docs
>  * Clarify that maintainers should still add R-b where relevant, even
>    if they are already adding their own S-oB.
>  * Clarify situation when contributor re-starts previously abandoned
>    work from another contributor.
>  * Add info about Suggested-by tag
>  * Add new docs section dealing with the broad topic of "generated
>    files" (whether code generators or compilers)
>  * Simplify the section related to prohibition of AI generated files
>    and give further examples of tools considered covered
>  * Remove repeated references to "LLM" as a specific technology, just
>    use the broad "AI" term, except for one use of LLM as an example.
>  * Add note that the policy may evolve if the legal clarity improves
>  * Add note that exceptions can be requested on case-by-case basis
>    if contributor thinks they can demonstrate a credible copyright
>    and licensing status
> 
> Daniel P. Berrangé (3):
>   docs: introduce dedicated page about code provenance / sign-off
>   docs: define policy limiting the inclusion of generated files
>   docs: define policy forbidding use of AI code generators
> 
>  docs/devel/code-provenance.rst    | 315 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  19 +-
>  3 files changed, 318 insertions(+), 17 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


