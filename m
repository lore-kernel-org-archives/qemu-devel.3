Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BFFC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtPG-0001YG-Aq; Tue, 30 Jan 2024 14:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7af2922fdc4e6c7e46df+7464+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rUtPD-0001Xq-SH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:04:23 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7af2922fdc4e6c7e46df+7464+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rUtP7-00009a-LX
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=e/eQy+FGPkAXiPNreNmza+angjwwtJFW4FhCcIiyHXg=; b=Vsp0NmWkrXTeP8423IvAYrUo0N
 6iHjQDSgHjQRwduuLY/ECBbDTQNp2JqLlMX4d+HvYQ4ofIIBQN7OybnftzxYVvNsJn6X65ntFoHSq
 y1UCVDRQnP3+3z2rhfbtAHgGRV7bywS0SFBqMkD9ToNByrf0XVQsWp5TugOLsznmbtsiTq1B+6bZu
 W8C4M5Kt75GKL5pZ7XAd/T6ghnnPGMUbqAKhEJha0hJMfLF4QhXGo3mul6oGfT9fhR02YudFMBTtR
 /a9S1cn1DT8y1Vk/bFlz73i04POnkSRaYfvxHNnqxWKNLDXdhVjtpKh0q2qV/RMGRY8JldiP6nNEy
 JXImYasQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rUtP1-00000008Tjt-1rbY; Tue, 30 Jan 2024 19:04:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rUtOy-00000002rgA-0Tlx;
 Tue, 30 Jan 2024 19:04:08 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4] doc/sphinx/hxtool.py: add optional label argument to SRST
 directive
Date: Tue, 30 Jan 2024 19:01:43 +0000
Message-ID: <20240130190348.682912-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+7af2922fdc4e6c7e46df+7464+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

We can't just embed labels directly into files like qemu-options.hx which
are included from multiple top-level rST files, because Sphinx sees the
labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707

So add an optional argument to the SRST directive which causes a label
of the form '.. _DOCNAME-HXFILE-LABEL:' to be emitted, where 'DOCNAME'
is the name of the top level rST file, 'HXFILE' is the filename of the
.hx file, and 'LABEL' is the text provided within the 'SRST()' directive.
Using the DOCNAME of the top-level rST document means that it is unique
even when the .hx file is included from two different documents, as is
the case for qemu-options.hx

Now where the Xen PV documentation refers to the documentation for the
-initrd command line option, it can emit a link directly to it as
'<system/invocation-qemu-options-initrd>'.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
v4:
 • Wrap long lines to shut checkpatch up

v3:
 • Include DOCNAME in label
 • Drop emitrefs option which is no longer needed

v2:
 • Invoke parse_srst() unconditionally
 • Change emitted label to include basename of .hx file
 • Describe it in docs/devel/docs.rst


 docs/devel/docs.rst      | 12 ++++++++++--
 docs/sphinx/hxtool.py    | 16 ++++++++++++++++
 docs/system/i386/xen.rst |  3 ++-
 qemu-options.hx          |  2 +-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index 7da067905b..50ff0d67f8 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -30,6 +30,13 @@ nor the documentation output.
 
 ``SRST`` starts a reStructuredText section. Following lines
 are put into the documentation verbatim, and discarded from the C output.
+The alternative form ``SRST()`` is used to define a label which can be
+referenced from elsewhere in the rST documentation. The label will take
+the form ``<DOCNAME-HXFILE-LABEL>``, where ``DOCNAME`` is the name of the
+top level rST file, ``HXFILE`` is the filename of the .hx file without
+the ``.hx`` extension, and ``LABEL`` is the text provided within the
+``SRST()`` directive. For example,
+``<system/invocation-qemu-options-initrd>``.
 
 ``ERST`` ends the documentation section started with ``SRST``,
 and switches back to a C code section.
@@ -53,8 +60,9 @@ text, but in ``hmp-commands.hx`` the C code sections are elements
 of an array of structs of type ``HMPCommand`` which define the
 name, behaviour and help text for each monitor command.
 
-In the file ``qemu-options.hx``, do not try to define a
+In the file ``qemu-options.hx``, do not try to explicitly define a
 reStructuredText label within a documentation section. This file
 is included into two separate Sphinx documents, and some
 versions of Sphinx will complain about the duplicate label
-that results.
+that results. Use the ``SRST()`` directive documented above, to
+emit an unambiguous label.
diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 9f6b9d87dc..3729084a36 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -78,6 +78,14 @@ def parse_archheading(file, lnum, line):
         serror(file, lnum, "Invalid ARCHHEADING line")
     return match.group(1)
 
+def parse_srst(file, lnum, line):
+    """Handle an SRST directive"""
+    # The input should be either "SRST", or "SRST(label)".
+    match = re.match(r'SRST(\((.*?)\))?', line)
+    if match is None:
+        serror(file, lnum, "Invalid SRST line")
+    return match.group(2)
+
 class HxtoolDocDirective(Directive):
     """Extract rST fragments from the specified .hx file"""
     required_argument = 1
@@ -113,6 +121,14 @@ def run(self):
                         serror(hxfile, lnum, 'expected ERST, found SRST')
                     else:
                         state = HxState.RST
+                        label = parse_srst(hxfile, lnum, line)
+                        if label:
+                            rstlist.append("", hxfile, lnum - 1)
+                            # Build label as _DOCNAME-HXNAME-LABEL
+                            hx = os.path.splitext(os.path.basename(hxfile))[0]
+                            refline = ".. _" + env.docname + "-" + hx + \
+                                "-" + label + ":"
+                            rstlist.append(refline, hxfile, lnum - 1)
                 elif directive == 'ERST':
                     if state == HxState.CTEXT:
                         serror(hxfile, lnum, 'expected SRST, found ERST')
diff --git a/docs/system/i386/xen.rst b/docs/system/i386/xen.rst
index 81898768ba..46db5f34c1 100644
--- a/docs/system/i386/xen.rst
+++ b/docs/system/i386/xen.rst
@@ -132,7 +132,8 @@ The example above provides the guest kernel command line after a separator
 (" ``--`` ") on the Xen command line, and does not provide the guest kernel
 with an actual initramfs, which would need to listed as a second multiboot
 module. For more complicated alternatives, see the command line
-documentation for the ``-initrd`` option.
+:ref:`documentation <system/invocation-qemu-options-initrd>` for the
+``-initrd`` option.
 
 Host OS requirements
 --------------------
diff --git a/qemu-options.hx b/qemu-options.hx
index ced8284863..b3ff06b0b6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3994,7 +3994,7 @@ ERST
 
 DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
            "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH_ALL)
-SRST
+SRST(initrd)
 
 ``-initrd file``
     Use file as initial ram disk.
-- 
2.43.0


