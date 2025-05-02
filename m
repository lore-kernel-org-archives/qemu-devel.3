Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EC0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvac-0006F9-2h; Fri, 02 May 2025 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAva3-0005X7-Ap
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:53 -0400
Received: from out-182.mta1.migadu.com ([95.215.58.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAva1-0005Vw-Ge
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:51 -0400
Message-ID: <d6b894fd-ed66-4c04-9ff4-732fdace6256@zabka.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1746212258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5q/9KK4Z2m60NyHEWzHCkn1aZQkgFeuGnkNPbEc7Ne8=;
 b=bzabfCO8zhpsqeZcA2co57tCftdQW0WAUDzDzWI3RVn9vIfBtJkiMdCei3b6m3RDhh0V5P
 tJUU+ewVGTfAlW7FxSQb9q1UQTiM0a6fSWG9zUWFL73ittaYex6vMjSrGUg9Xq0+qBwJcl
 htlleJC3tK+sNm6j6VBZI8O0CvTkUrg=
Date: Fri, 2 May 2025 20:57:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 8/9] rust: enable clippy::ptr_cast_constness
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-9-pbonzini@redhat.com>
Content-Language: de-DE, en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Stefan Zabka <git@zabka.it>
In-Reply-To: <20250502102323.104815-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.182; envelope-from=git@zabka.it;
 helo=out-182.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Unrelated to the actual change, but a drive-by observation:
If you want to keep the MSRV in sync across all workspace members, you 
could use workspace.package.rust-version to define it once and inherit 
it everywhere. (Same goes for edition, license, and resolver.)

https://doc.rust-lang.org/cargo/reference/workspaces.html#the-package-table

I'd like to provide a patch instead of just heckling, but I have a 
couple of questions:

1. Is this actually desired behaviour, or might you want different 
values for these fields?
2. Should I implement this against qemu-project/qemu master branch or is 
there a dedicated Rust tree?
3. Should I wait with that until your change is landed so we don't conflict?

Best
Stefan

