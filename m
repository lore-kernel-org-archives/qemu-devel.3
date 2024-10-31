Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C443D74958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 12:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Uh7-0004oe-72; Thu, 31 Oct 2024 08:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t6Uh2-0004nr-Qz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t6Uh0-0002Ld-J7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730379264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nEZ7Ebb4KpSyNTow6eMbvILiK+xSILLOTIBFlrBQkxw=;
 b=dHfVC53jIWBuySKIP7Hl3S6K+ziZwSFOy6ENx/+4gkrhbC5h4Ic+2WLf43KPkeJp1UXt86
 /nlvz7ktjXgXEUN6p81BGfev+4jnd7dGpQxw4GMXWmomN3AgNFb5HCvAulbph2CASzGQX0
 gIELAxi3rm4bD6pIpf+fVds58bThOos=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-EPI1q_kwOZCsdEgGmRv12g-1; Thu,
 31 Oct 2024 08:54:19 -0400
X-MC-Unique: EPI1q_kwOZCsdEgGmRv12g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 826CD19560AA; Thu, 31 Oct 2024 12:54:12 +0000 (UTC)
Received: from pinwheel (unknown [10.39.194.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052201956086; Thu, 31 Oct 2024 12:54:09 +0000 (UTC)
Date: Thu, 31 Oct 2024 13:54:07 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, rust-vmm@lists.opendev.org,
 devel@lists.libvirt.org
Subject: [Call for Presentations] FOSDEM 2025: Virt & IaaS devroom
Message-ID: <ZyN97_nF4Vz0ten1@pinwheel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(Cross-posted to KVM, Rust-VMM, QEMU, and libvirt lists.)

Hi,

The CFP for the 'Virt & IaaS' (Infrastructure as a Service) 2025
"devroom" is out[+].

  - Where? — Brussels, Belgium
  - When?  — 02 Feb (Sunday) 2025
  - Talk submission deadline — 01 Dec 2024

    (The CFP submission on the FOSDEM list[+] says 08 Dec 2024 is the
    submission deadline in its intro paragraph.  But I clarified it with
    Piotr Kliczewski, the deddline is *01* Dec 2024 and _not_ 08th Dec;
    I updated it below.)

========================================================================
This devroom is a collaborative effort, and is organized by dedicated
folks from projects such as OpenStack, Xen Project, KubeVirt, QEMU, KVM,
and Foreman.  We invite everyone involved in these fields to submit your
proposals by December *1st* 2024. 

Important Dates
---------------

Submission deadline: 1st December 2024

Acceptance notifications: 10th December 2024

Final schedule announcement: 15th December 2024

Devroom: 2nd February 2025


About the Devroom
-----------------

The Virtualization & IaaS devroom will feature session topics such as open
source hypervisors or virtual machine managers such as Xen Project, KVM,
bhyve and VirtualBox as well as Infrastructure-as-a-Service projects such
as KubeVirt, Apache CloudStack, OpenStack, QEMU and OpenNebula.

This devroom will host presentations that focus on topics of shared
interest, such as KVM; libvirt; shared storage; virtualized networking;
cloud security; clustering and high availability; interfacing with multiple
hypervisors; hyperconverged deployments; and scaling across hundreds or
thousands of servers.

Presentations in this devroom will be aimed at developers working on these
platforms who are looking to collaborate and improve shared infrastructure
or solve common problems. We seek topics that encourage dialog between
projects and continued work post-FOSDEM.


Submit Your Proposal
--------------------

All submissions must be made via the Pretalx event planning site[1]. It is
a new submission system so you will need to create an account. If you
submitted proposals for FOSDEM in previous years, you won’t be able to use
your existing account.

During submission please make sure to select Virtualization and Cloud
infrastructure from the Track list. Please provide a meaningful abstract
and description of your proposed session.


Submission Guidelines
---------------------

We expect more proposals than we can possibly accept, so it is vitally
important that you submit your proposal on or before the deadline. Late
submissions are unlikely to be considered.

All presentation slots are 30 minutes, with 20 minutes planned for
presentations, and 10 minutes for Q&A.

All presentations will be recorded and made available under Creative
Commons licenses. In the Submission notes field, please indicate that you
agree that your presentation will be licensed under the CC-By-SA-4.0 or
CC-By-4.0 license and that you agree to have your presentation recorded.
For example:

"If my presentation is accepted for FOSDEM, I hereby agree to license all
recordings, slides, and other associated materials under the Creative
Commons Attribution Share-Alike 4.0 International License.

Sincerely,

<NAME>."

In the Submission notes field, please also confirm that if your talk is
accepted, you will be able to attend FOSDEM and deliver your presentation.
We will not consider proposals from prospective speakers who are unsure
whether they will be able to secure funds for travel and lodging to attend
FOSDEM. (Sadly, we are not able to offer travel funding for prospective
speakers.)


Code of Conduct
---------------

Following the release of the updated code of conduct for FOSDEM[3], we'd
like to remind all speakers and attendees that all of the presentations and
discussions in our devroom are held under the guidelines set in the CoC and
we expect attendees, speakers, and volunteers to follow the CoC at all
times.

If you submit a proposal and it is accepted, you will be required to
confirm that you accept the FOSDEM CoC. If you have any questions about the
CoC or wish to have one of the devroom organizers review your presentation
slides or any other content for CoC compliance, please email us and we will
do our best to assist you.

Questions?
----------

If you have any questions about this devroom, please send your questions to

our devroom mailing list. You can also subscribe to the list to receive

updates about important dates, session announcements, and to connect with

other attendees.

See you all at FOSDEM!

[1] https://fosdem.org/submit

[2] virtualization-devroom-manager at fosdem.org

[3] https://fosdem.org/2025/practical/conduct/
========================================================================

[+] https://lists.fosdem.org/pipermail/fosdem/2024q4/003574.html

-- 
/kashyap


