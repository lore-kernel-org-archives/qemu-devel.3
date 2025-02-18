Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F28C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLmu-0000Ds-HG; Tue, 18 Feb 2025 06:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkLms-0000Cs-VZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkLmr-0007NL-0l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739878151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wA5Dr3SAIqSUJqZ/TzERixoJpvxFjCXN+UQvjfqh3DM=;
 b=FHKF/k6x1Jc18RZp01ed6jWw/jnEx9GipjTn9HQTUaBRl0hylb8JUZ4COFR/+F7uMuX+Hz
 yqp5y/pX4a9cyygqsrYO22UpuJj/plmjuiEfx2qtLlXyb9gmpCJBFoBrtjmSJuRsGhwbHK
 6fu7P73pAzxCJNCRPJNfzaFB+Asb6Kg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-ph7rpuYxPBe0gJkPhRIb6g-1; Tue,
 18 Feb 2025 06:29:08 -0500
X-MC-Unique: ph7rpuYxPBe0gJkPhRIb6g-1
X-Mimecast-MFC-AGG-ID: ph7rpuYxPBe0gJkPhRIb6g_1739878146
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 714F318EAB04; Tue, 18 Feb 2025 11:29:04 +0000 (UTC)
Received: from gezellig (unknown [10.44.34.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D0919560AB; Tue, 18 Feb 2025 11:28:50 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:58:45 +0530
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Ninad Palsule <ninad@linux.ibm.com>,
 sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Message-ID: <Z7Qnsm02w6gao_ui@gezellig>
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-3-kchamart@redhat.com>
 <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(Cc: Richard Henderson; context: "SME" and "RME" feature discussion
below.)

On Mon, Feb 17, 2025 at 06:43:01PM +0100, Eric Auger wrote:
> Hi Kashyap,

Hey,

> 
> On 2/17/25 5:37 PM, Kashyap Chamarthy wrote:

[...]

> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> > v2: address Marc Zyngier's comments:
> >     https://lists.gnu.org/archive/html/qemu-devel/2025-01/msg03451.html
> > ---

[...]

> > +Live migration and PAuth
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The level of PAuth support depends on which Arm architecture a given CPU
> > +supports (e.g. Armv8.3 vs. Armv8.6).  This gradation in PAuth support
> > +has implications for live migration.  For example, to be able to
> > +live-migrate from host-A (with Armv8.3) to host-B (with Arm v8.6):
> > +
> > +  - the source and destination hosts must "agree" on (a) the PAC
> > +    signature algorithm, and (b) all the sub-features of PAuth; or
> > +
> > +  - the alternative (and less desirable) option is to turn off PAuth
> > +    off on both source and destination — this is generally not
> > +    recommended, as PAuth is a security feature.
> > +
> > +TCG
> > +---
> >  
> > -TCG vCPU features are CPU features that are specific to TCG.
> > -Below is the list of TCG vCPU features and their descriptions.
> 
> The resulting header layout seems weird to me.
> Initially we had at top level (assuming ===):
> 
> KVM vCPU Features
> TCG vCPU Features
> SVE CPU Properties
> SME CPU Properties
> RME CPU Properties
> 
> and now
> 
> TCG vCPU Features has somehow disappeared giving the impression that
> there are none.

I did think about it :) That's why I wrote this in the cover-letter; not
sure if you noticed it:

    I replaced the "TCG vCPU Features" heading with "PAuth" because of
    this: before this change, the section says, it is about "CPU
    features that are specific to TCG".  But it has only PAuth-related
    parameters under it.  Since PAuth is relevant to both KVM and TCG, I
    moved them under a separate PAuth section, instead of duplicating
    it.

    But now we have a small inconsistency - there's a KVM-only CPU
    features section, but no TCG-only section.  I thought when there are
    more TCG-only CPU features, that section can be added back in.  Or I
    can add that back in, if anyone feels strongly about it.

> SME and RME and TCG only if am not wrong while PAUTH and SVE are both
> KVM and TCG

I didn't know that.  I read the docs a bit more closer about SME, RME,
and SVE, and did some quick `git-annotate` analysis:

  - "SME is not supported by KVM at this time" — this was added in
    commit e74c097638 (target/arm: Add cpu properties for SME,
    2022-06-20).

    If it is still accurate, then yes, SME looks to be TCG-only.

  - "The status of RME support with QEMU is experimental" — this was
    added in commit 57223a4c24 (docs/system/arm: Document FEAT_RME,
    2023-06-22).

    The phrase "with QEMU" doesn't quite decisively tell me whether it
    is experimental for TCG-only, or if it also applies for KVM.  Maybe
    Richard (in Cc) can tell us more.

  - SVE seems to be for both KVM and TCG, as the section "SVE CPU
    Property Dependencies and Constraints" talks about KVM.

  - PAuth is both KVM and TCG.

> Maybe we shall
> - rename KVM vCPU Features -> KVM only vCPU Features
> - Add a TCG only vCPU features including both SME and RME ones
> - introduce a top level KVM and TCG vCPU features with below:
> PAUTH, SVE, detailing potential different semantic for both KVM and TCG mode

Yeah, it can be done.  Would you be okay if I do it as a follow-up?  As
this a re-work of the entire doc with several features.

> Also while we are at it, we may use vCPU everywhere instead of CPU (SVE
> CPU Properties) and just skip CPU if it lays within the KVM and TCG vCPU
> Features

Yes, make sense.

[...]

-- 
/kashyap


