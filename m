Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707E2CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCams-0004bx-RI; Fri, 02 Oct 2026 06:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCamW-0004U7-Md
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCamV-0006bX-2f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790937982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuktG/lNxiTxF+gnr0j8iS+0I2kNk62bZlFjQxEAjAY=;
 b=MlLfkv4oqxZ1zJ2ItUwoOdm3+YDlC2e1/siHDB6Fzl9MzQxadtzHNFFHWnYHCriR1G4YJM
 SUZnayrc35nS4pyiof601SjrSxWj0ZhfByMesE+rvaBjkPS79aFLJs7KAtouFVji52sey6
 YC38WGWMPl+xd0sxZQhnID8RBQqjIUU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-_wW23gmJMQWHOovQut4H7w-1; Fri,
 02 Oct 2026 06:46:18 -0400
X-MC-Unique: _wW23gmJMQWHOovQut4H7w-1
X-Mimecast-MFC-AGG-ID: _wW23gmJMQWHOovQut4H7w_1790937977
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B48ED196C42D; Fri,  2 Oct 2026 10:46:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 555941800345; Fri,  2 Oct 2026 10:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09AB021E6A04; Fri, 02 Oct 2026 12:46:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
In-Reply-To: <20260924135634.2626603-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 24 Sep 2026 14:56:34
 +0100")
References: <20260924135634.2626603-1-berrange@redhat.com>
Date: Fri, 02 Oct 2026 12:46:15 +0200
Message-ID: <87qzi82xe0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Recently QEMU has received a denial of service attack on
> its bug tracker in the form of 120 reports in 10 minutes,
> and now repeated by another reporter in the form of 50
> reports in the same day.
>
> Prior to switching security disclosures to the bug tracker,
> single reporters have submited 18, 22, and 114 bug reports.
>
> None of this is sustainable. It is an effective denial of
> service attack on the project maintainers' time. Every bug
> report is a TODO item added to someone's workload.
>
> It is time to put hard limits on how many bugs, discovered
> with assitance of automated tools, we are willing to accept
> in a givenm time frame.
>
> This patch proposal suggests
>
>  * No more than 5 bugs per week, per reporter
>  * No more than 10 bugs are permitted to be open at any
>    time, per reporter.
>
> This is explicitly scoped to bugs discovered with the assistance
> of automated tools. Bugs where a human puts in exclusively
> personal time / effort to discover a problem are not limited.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  contribute/report-a-bug.md | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index b506f9f..8fb7b0b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
>    triage of their output to validate all findings and reproducer
>    scenarios prior to submitting a bug report.
>=20=20
> +* QEMU policy forbids the bulk filing of large numbers of
> +  bug disclosures that were generated with automated tools
> +  (AI/LLM, static analysis, fuzers). Such actions are not

fuzzers

> +  a benefit to the project, placing an unsustainable burden
> +  on maintainers.

[...]


