Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBD606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfLRUvmI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd7P-00025M-35; Wed, 18 Nov 2026 05:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd7K-00024V-7V
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd7G-0000AS-Tb
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794998534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwMGLlkoPy5/H9nToIRP62B/A/PXg7PBaTWe9513jTg=;
 b=XfLRUvmI94WLtYGuyyGGmwMnVzxmXR6r82mER0dpk0KEt/JD5VO4I3N2RYCskhzXXyVOzY
 7QIRrEK7ZllG1lQoqDpkzj/BeJR8h9QnBE35dTs1cIz2kqITV7cIl/1IpE2EVmPmOLABIK
 aB8XLxa+ExtCyzQ/8I0mJbbxJUpHD7g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-cMvpppGjOf-wCw_y3mw6Qg-1; Wed,
 18 Nov 2026 10:42:12 +0000
X-MC-Unique: cMvpppGjOf-wCw_y3mw6Qg-1
X-Mimecast-MFC-AGG-ID: cMvpppGjOf-wCw_y3mw6Qg_1794998531
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93DAA1800372; Wed, 18 Nov 2026 10:42:11 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3472195B3C4; Wed, 18 Nov 2026 10:42:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/4] docs/devel: allow larger contributions with
 pre-arrangement
Date: Wed, 18 Nov 2026 11:41:50 +0100
Message-ID: <20261118104150.599535-5-pbonzini@redhat.com>
In-Reply-To: <20261118104150.599535-1-pbonzini@redhat.com>
References: <20261118104150.599535-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current policy does not include a path to formalize the submission
of a larger body of AI-assisted work.  In particular, contributors have
expressed the interest in using LLMs for new accelerators or for the
userspace side of new hypervisor features; and some past contributions
suspected to use AI still fall outside what the policy allows.

From the maintainer side, the policy does not handle well the submission
of multiple small patches; it encourages splitting the work into small
pieces, which hides the design context and does not allow maintainers
to delegate infrastructure improvements to contributors that are willing
(or could be required) to do them.

Constant streams of changes were forbidden in previous drafts, but since
pre-arrangement of large changes was dropped they were implicitly allowed,
except possibly when they end up being a code of conduct issue.  Therefore,
the policy as written risks being unbalanced and shifting the effort
from developers towards maintainers, which is the opposite of what it
wanted to achieve.

In order to avoid this, take inspiration from the Rust project's policy
and combine two ideas to make the policy both tighter (for example by
closing the gap for repeated, frequent posting of small bugfixes), and
more balanced towards maintainers.

One is to hold larger contributions to a higher standard, in the spirit
of using AI to work "better, not faster"; the other is to require
"pre-arrangement" for "changes that are originally created by an LLM".
AI lowers the cost of producing a patch but does nothing to lower the
cost of understanding and reviewing one; if anything it raises it, since a
reviewer can no longer assume that the submitter has reasoned through every
line.  Pre-arrangement has always been customary for major changes to QEMU
as it guides contributors towards an early relationship with maintainers;
it is particularly beneficial when contributors use LLMs because (possibly
via agent suggestion) it encourages human-to-human discussion, and
is therefore made a requirement.

A possible alternative includes exceptions initiated by the maintainer
only, for example upon seeing an opportunity for infrastructure work or
a constant stream of small changes from the same contributor.  I have
chosen to allow contributors to initiate the process as well, because
they were after all already encouraged to contact maintainers early.
Maintainers of course can still pre-arrange yak shaving just by asking
to do it.

A question raised in previous discussions is what to do with changes
affecting multiple subsystems.  It seems to me that the common cases
can be handled in the same way as non-LLM-based contributions or through
the existing buckets:

- if there is one main affected subsystem (for example, a new accelerator
  will only require small changes to QMP in order to expose it in
  AcceleratorInfo), the maintainer of other trees should treat it as
  "use of LLMs to help generating parts of a larger patch", i.e. as
  a separate bucket that does not require pre-arrangement;

- if there is a genuine split between multiple subsystems (for example,
  SCSI and USB, or an accelerator and an architecture), the agreement of
  both maintainers is required to proceed;

- for tree-wide changes, one maintainer will probably act as the steward
  and seek consensus from the project as a whole.

Because this is effectively a corollary of project customs and written
policies, it is not mentioned explicitly.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/llm-usage.rst | 37 +++++++++++++++++++++++++++----------
 AGENTS.md                |  9 +++++++--
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/docs/devel/llm-usage.rst b/docs/devel/llm-usage.rst
index 5f6d64de52f..dc6f36f1bd1 100644
--- a/docs/devel/llm-usage.rst
+++ b/docs/devel/llm-usage.rst
@@ -84,26 +84,41 @@ Use of generative AI can be classified in the following four buckets:
   not need disclosure.
 
 - small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
-  are allowed with disclosure.
+  are allowed with disclosure.  Splitting a submission in multiple parts
+  is **not** a valid way to bypass this rule; repeated, frequent posting
+  of such fixes must follow the rule for large contributions.
 
 - use of LLMs to help generating parts of a larger patch---test cases,
   adaptations of existing code, boilerplate code for a new API, a tool to
   help performing mechanical changes, etc.  These are generally allowed;
   disclosure is required for non-trivial, functional code changes.
 
-Large, heavily LLM-assisted contributions where LLMs write large parts
-of functional code are currently not allowed.
+- large, heavily LLM-assisted contributions where LLMs write large parts
+  of functional code.  These are only allowed if *pre-arranged*,
+  *high-quality* and *well-tested*.
 
-LLM-created contributions will be held to a higher standard of testing
-than human-created ones.  Maintainers have freedom to determine what
-constitutes "high quality"; in particular, because LLMs lower the cost
-of patch generation, there are no exceptions for "writing the tests seems
-hard".
+Pre-arrangement means that a maintainer must have communicated ahead of
+time, for example on `IRC or the QEMU mailing list <https://www.qemu.org/contribute/>`__,
+that they are willing to review an LLM-created contribution.  It ensures
+that maintainers have bandwidth for review before a contributor invests
+effort in creating a large change.
+
+.. note::
+    This is not a new concept in QEMU: maintainers have always encouraged
+    early alignment on mailing lists or IRC prior to major architecture
+    or subsystem refactoring.  The policy expands this custom to a
+    requirement for larger LLM-based contributions.
+
+Maintainers have freedom to determine what constitutes "high quality"
+and "well-tested" work.  Because LLMs lower the cost of patch generation,
+LLM-created contributions will be held to a higher standard than
+human-created ones.  There are no exceptions for "writing the tests seems
+hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
 
 Contributors who submit LLM-created contributions are required to
 apply the same judgment that would be applied to other code changes.
-They must invest substantial time reviewing the code and, when
-applicable, curating individual commits.
+They must invest substantial time reviewing the code, understanding
+the design in depth, and curating individual commits.
 
 The QEMU project explicitly forbids using LLMs to do "clean room"
 reimplementation of existing code whose license is not compatible
@@ -187,5 +202,7 @@ This policy was informed by:
 - `Recommendations When Using LLM-backed Generative AI Systems for
   FOSS Contributions <https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html>`__
 
+- `Rust project LLM Usage Policy <https://forge.rust-lang.org/policies/llm-usage.html>`__
+
 - `GStreamer AGENTS.md file <https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/d08375499c279/AGENTS.md>`__
 
diff --git a/AGENTS.md b/AGENTS.md
index 31a5c27f542..7c009c7e33c 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -108,11 +108,16 @@ solution:
 Background assistance such as review or explanation does not require disclosure.
 Read `docs/devel/llm-usage.rst` before generating code, tests, or documentation
 intended for contribution; committing agent-generated material; or advising on
-disclosure. It is not required for review, explanation, or other background
-assistance that produces no contribution content.
+disclosure or pre-arrangement. It is not required for review, explanation, or
+other background assistance that produces no contribution content.
 
 When agent-generated content is included in a contribution, remind the human
 to determine the appropriate disclosure under `docs/devel/llm-usage.rst`.
+In particular, contributions where you write large parts of the functional
+code may only be submitted if a maintainer has agreed **beforehand** to review
+them.  Tell the human about this as soon as the work looks likely to grow to
+that size, well before the patches are written.
+
 If you commit agent-generated material, include an `AI-used-for:` trailer
 before `Signed-off-by`. Do not omit it by folding the material into a larger
 commit.  The human may later make a different disclosure decision under
-- 
2.56.0


