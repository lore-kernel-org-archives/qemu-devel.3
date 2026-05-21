Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B856ACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ37N-0001DW-4k; Thu, 21 May 2026 09:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ37J-0001Cd-7L
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ37E-0005o8-GM
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779368826;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhJ19rgBePFj/AJvHy/AzeKpFvpyvnPZ205XOne6nQ8=;
 b=e9sg/5LdXnq4xVe7tETjQKW5+7VamliueOgkvLbXNxBmbLhkVpVLiGawmIzpHFqrdPnZDT
 O/jNonLRG+qT8ZSz3xF/hmgdIrLF/+qsPhmsUvSLzol/vLVusF5Jm1YRVVUCIaL0ql/aYQ
 bHrtRjZsumKUq02O/vBEtY4qxU67HXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-GwvtBzuWM06w9Z9GejqFpg-1; Thu,
 21 May 2026 09:07:00 -0400
X-MC-Unique: GwvtBzuWM06w9Z9GejqFpg-1
X-Mimecast-MFC-AGG-ID: GwvtBzuWM06w9Z9GejqFpg_1779368819
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1EFE180056E; Thu, 21 May 2026 13:06:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 545D8300019F; Thu, 21 May 2026 13:06:56 +0000 (UTC)
Date: Thu, 21 May 2026 14:06:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
Message-ID: <ag8DbJqLzvTlJRIe@redhat.com>
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
 <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
 <ag3xwssG6KZecv0o@redhat.com>
 <20260520191235-mutt-send-email-mst@kernel.org>
 <CAA8xKjWoMYBPedC5RP96=TOe2MzDwtsmBHFW=0Bq170YNsR9DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8xKjWoMYBPedC5RP96=TOe2MzDwtsmBHFW=0Bq170YNsR9DQ@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 02:45:08PM +0200, Mauro Matteo Cascella wrote:
> On Thu, May 21, 2026 at 1:14 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > something I was unaware of previously, is that gitlab is a CNA:
> > https://about.gitlab.com/security/cve/
> >
> > so using gitlab issues means assigning CVE #s should be super easy.
> 
> Red Hat is a CNA too, QEMU CVEs are currently being reserved by Red Hat.
> 
> In fact, Red Hat is a root CNA:
> https://www.cve.org/Media/News/item/blog/2023/01/10/Why-Red-Hat-Became-Root
> 
> Projects like glibc, postgresql and curl now operate as independent
> CNAs under Red Hat, retaining complete end-to-end ownership over CVE
> assignment. Is it time for QEMU to follow suit?

Is there any guidance on the process & implications of taking that
route, specifically as an OSS project ?

I've found this:

  https://github.com/ossf/wg-vulnerability-disclosures/blob/main/docs/guides/becoming-a-cna-as-an-open-source-org-or-project.md

And there are obligations/requirements there which I would not be
very comfortable with agreeing to with my QEMU hat on.

 * CNA must provide a phone number for the primary POC.

I'm guessing the phone number is intended for someone/org to escalate
urgent issues ?

Related to this I see

 * CNA either should or must publish CVE Records within 24 hours
   of publication of a CVE ID.

and similarly in

  https://www.cve.org/ResourcesSupport/AllResources/CNARules#section_2_sub_cnas

   "3.2.2.2 The administrative POC MUST include both email
    addresses and phone numbers and MAY include additional
    contact methods."
    
   "3.2.2.5 The administrative POC MUST respond in a timely manner.
    Automated responses do not qualify as “a timely manner.”"

As a co-operative volunteer project, my view is that we do not owe
anyone a guranteed or timely response. Yes, many of us are employed
by vendors to work on QEMU, but our work in the upstream community
context is still on a best effort basis. 

If someone requires an urgent or guaranteed response, whether to a CVE
or any other kind of issue, then the obligation needs to fall on the
paid vendors who distribute QEMU rather than any individual upstream
maintainers.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


