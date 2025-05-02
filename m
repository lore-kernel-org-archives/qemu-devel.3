Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3757AC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyxn-0004J9-GI; Fri, 02 May 2025 18:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAyxk-0004IY-Lp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:34:32 -0400
Received: from out-172.mta1.migadu.com ([95.215.58.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAyxf-0001oe-LI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:34:30 -0400
Message-ID: <4d53c6f7-b72d-40a2-a83b-ea11e69365e6@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1746225264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deLxp6ugf4UOYmbp3E6FwZWa0uI1eUwnP4Py4HK6kRo=;
 b=gGYlPilUOCvZL2g93gNbT4XfD6Sfl0iTfAjKFpLdXYwqpoilssDRkDPOLSAF3fOK+F7RS/
 +SEKGJZ+xjN7/96CLi9h2LhK2qgyT/b6Qv+9VF0/PwhqtWNcpo6DNA/f4Adj59ynpzsxre
 60TYzHicOSJRPTZzRvH2eG5YSjhteJk=
Date: Sat, 3 May 2025 00:34:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] rust: centralize config in workspace root
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250502212748.124953-1-git@zabka.it>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Stefan Zabka <git@zabka.it>
In-Reply-To: <20250502212748.124953-1-git@zabka.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.172; envelope-from=git@zabka.it;
 helo=out-172.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just realised that I forgot to CC Paolo and also that I didn't strictly 
enforce the tag order of name, version, authors and then alphabetically 
like I wanted to.

I hope this is still enough of an improvement over the status quo.

I also considered centralising the `publish = false` but as the hpet
crate didn't have it, I wasn't sure if I was introducing unintended 
behaviour.

I also just discovered 
[here](https://doc.rust-lang.org/cargo/reference/resolver.html#resolver-versions) 
that the resolver in the sub crates is ignored when a workspace resolver 
is set, so it would probably be more correct to just remove the entry 
entirely.

Please lmk whether that should be part of a v2 for this patch (series) 
or if I should create new separate series for that.

Best
Stefan

