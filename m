Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E4606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=Z8XpHE4t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWYMp-0007IB-Ec; Thu, 26 Nov 2026 07:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWYMl-0007Hs-Fz
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:14:19 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWYMi-00065a-5J
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795695243; bh=11a15RfnhwvnybTsvT7WuwtWFFwjbP+b7gO3Gi6aTzg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Z8XpHE4tFoagIKv1TnmJl6qJY1i9C2+e4EQrMaNNHFBS0il4Z8l3HktYihBDOYp9s
 KPTCvrjYKm7iAsW8VLwCGY7mBn+wtTtEgETu4bFSChuNFF1UWkjE47qa8BpAaugQuF
 iZavmPJsYudEvIJAZe8rGnsdJPFZOtn+Dkw7Ysb0=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id F285E2070E;
 Thu, 26 Nov 2026 13:14:02 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CAD921E6A04; Thu, 26 Nov 2026 13:14:12 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com,  peter.maydell@linaro.org,  berrange@redhat.com,
 eblake@redhat.com,  armbru@redhat.com,  alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb> (Peter Xu's
 message of "Tue, 24 Nov 2026 16:05:32 -0500")
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Thu, 26 Nov 2026 13:14:12 +0100
Message-ID: <87tsl3yeln.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 24, 2026 at 05:42:15PM +0100, Paolo Bonzini wrote:
>> +The QEMU community is a collaboration between humans, not AI agent
>> +fa=C3=A7ades. The following items MUST be written by humans:
>> +
>> +- cover letters and commit messages
>> +
>> +- responses to reviewer comments
>> +
>> +- issue descriptions or comments
>
> [Just a pure comment, so not a request to change anything at v6 to block =
the
>  pull at all]
>
> I think this is the part I raised the pure question in the upstream call
> today, on that we won't really be able to identify what is written by AI,
> and what is written by human.
>
> If we can't identify that in a realiable way, IMHO the policy here will be
> hard to carry out.

Yes, but that doesn't necessarily make it not useful.

We have many laws on the books that can be broken, with and without
intent, in ways that are notoriously hard to detect.  Tax fraud, for
instance.  We keep these laws anyway.  They serve as a clear statement
of what conduct we expect and demand.  We make some effort to catch
violations[*], but accept that we cannot catch them all.

Could this policy be useful in similar ways?  Not the punishment part
(there is none).  But a clear statement of what conduct we expect and
demand.  Something we can point to when we reject slop.


[*] At least in non-failing states.

