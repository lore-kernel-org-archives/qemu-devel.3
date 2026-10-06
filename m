Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BD3CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBE-0008SI-RT; Wed, 07 Oct 2026 04:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEIgE-0006FM-QR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEIfz-0002oy-EZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791345009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GcSXn1JWwfUVcKwoZC9zkIXjPn4hrqNQUPSl4kf2AM=;
 b=Nk7o+IneHU0o3XL2piWkyQSRNCOnlefQ4qeusSE3c6OiA6JDCmBcLGPeh+/ZDHHWZaOLLB
 OG/vrqCCyetlt94GIGeGLo9xxyqbsIl52nhqa5QT34Yof9tC7hiUpTUcxBIkmycNYgwgY4
 SYGB6Bua2DP96VIbR0EVwWIzYGb3OgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-NAF5y2qlMryVGksDQge1YQ-1; Tue,
 06 Oct 2026 07:31:39 -0400
X-MC-Unique: NAF5y2qlMryVGksDQge1YQ-1
X-Mimecast-MFC-AGG-ID: NAF5y2qlMryVGksDQge1YQ_1791286298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14731193533A; Tue,  6 Oct 2026 11:31:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EB131956042; Tue,  6 Oct 2026 11:31:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8D3221E6A04; Tue, 06 Oct 2026 13:31:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 00/11] docs/qapi: revise and expand QAPI documentation spec
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:27 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 13:31:34 +0200
Message-ID: <874iezcbft.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> This patchset looks at expanding and clarifying the documentation for
> ... writing documentation. Primarily, the doc is being organized into
> subsections - one for each QAPI doc section. These sections are
> re-ordered to be documented in the same order as they are expected to
> appear in-usage.

While I appreciate the split into single-purpose patches, I still need
to review the entire doc update as a whole.

   Definition documentation
   ~~~~~~~~~~~~~~~~~~~~~~~~

   Definition documentation, if present, must immediately precede the
   definition it documents.

   When documentation is required (see pragma_ 'doc-required'), every
   definition must have documentation.

   Definition documentation starts with a description naming the
  -definition with an optional indented overview, a description of each
  -argument (for commands and events), member (for structs and unions),
  -branch (for alternates), or value (for enums), a description of each
  -feature (if any), and finally optional tagged sections.
  +definition with an optional indented overview (the :ref:`doc-intro`),
  +:ref:`descriptions <doc-descrip>` of each argument (for commands and
  +events), member (for structs and unions), branch (for alternates), or
  +value (for enums), :ref:`feature descriptions <doc-feat>` of each
  +feature (if any), and finally optional :ref:`tagged sections
  +<doc-tagged>`.

This needs work.  Copying from my review of PATCH 07...  The order of
tagged sections is left unspecified, which is fine now, but becomes a
gap when your "qapi: enforce section ordering" series lands.  "Details"
sections aren't mentioned at all.

Try a list?  Or do away with the overview entirely?  You do describe the
definition documentation contents in the required order below, which
could be enough.

  -Descriptions start with '\@name:'.  The description text must be
  -indented like this::
  +
  +.. _doc-intro:
  +
  +Intro
  +^^^^^
  +
  +The Intro section names the symbol being defined and is optionally
  +followed by an indented brief summary or overview of the definition.
  +
  +The intro section *may* consist of multiple indented paragraphs, but
  +is ideally a single summary line that does not repeat type
  +information or reference individual arguments/members/et al::

et al.

Perhaps "does not repeat type information and does not contain forward
references, say to command arguments".

  +
  +  ##
  +  # @query-block-jobs:
  +  #     Return information about long-running block device operations.
  +  #
  +
  +
  +.. _doc-descrip:
  +
  +Descriptions
  +^^^^^^^^^^^^

Would be nice to have a better term than "descriptions".  "Argument /
member / branch / value descriptions" is rather long.

  +
  +Descriptions start with '\@name:'.  These are used to document
  +arguments (for commands and events), members (for structs and unions),
  +branches (for alternates), or values (for enums).
  +
  +The description text must be indented like this::

    # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
    #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.

   .. FIXME The parser accepts these things in almost any order.

   .. FIXME union branches should be described, too.

   Extensions added after the definition was first released carry a
  -"(since x.y.z)" comment.
  +"(since x.y)" comment.

  -The feature descriptions must be preceded by a blank line and then a
  -line "Features:", like this::

  -  #
  -  # Features:
  -  #
  -  # @feature: Description text
  +.. _doc-tagged:
  +
  +Tagged sections
  +^^^^^^^^^^^^^^^

   A tagged section begins with a paragraph that starts with one of the
   following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
   the start of a new section.

   The second and subsequent lines of tagged sections must be indented
   like this::

    # TODO: Ut enim ad minim veniam, quis nostrud exercitation ullamco
    #     laboris nisi ut aliquip ex ea commodo consequat.
    #
    #     Duis aute irure dolor in reprehenderit in voluptate velit esse
    #     cillum dolore eu fugiat nulla pariatur.

This factors out the common syntax (good) at the price of breaking the
linear sequence of sections (not so good).  Hmm.

  -"Returns" and "Errors" sections are only valid for commands.  They
  -document the success and the error response, respectively.
  +
  +Returns
  +^^^^^^^
  +
  +"Returns" :ref:`doc-tagged` are only valid for commands.  They document =
the

This comes out as

    =E2=80=9CReturns=E2=80=9D Tagged sections are only valid for commands. =
They document the

"Tagged" should not be capitalized.

  +success response of the command. If there is some nuance to capture
  +with the return value, it may be documented as::
  +
  +  #
  +  # Returns: a list describing each virtual block device.  Filter nodes
  +  #     that were created implicitly are skipped over.
  +  #
  +
  +Long descriptions are written as a block, with additional lines indented.

Redundant with the common syntax under "Tagged sections".  We need to
make up our mind whether to factor out syntax or not.

  +
  +The type of the return value will be added to the documentation
  +automatically. If there is nothing relevant to add apart from type,
  +this section may be omitted.

Maybe do this first, and only then a suitable rephrasing of "If there is
some nuance ..."

  +
  +
  +Errors
  +^^^^^^
  +
  +"Errors" :ref:`doc-tagged` are only valid for commands.  They document
  +the error responses.

   "Errors" sections should be formatted as an rST list, each entry
   detailing a relevant error condition.  For example::

    # Errors:
    #     - If @device does not exist, DeviceNotFound
    #     - Any other error returns a GenericError.

Problematic example copied from block-commit.  Tidied up there in commit
b3bd7617dba.  Better steal something else.

Hmm, many existing Errors: sections don't mention the error class.  E.g.
nbd-server-add:

    # Errors:
    #     - if the server is not running
    #     - if an export with the same name already exists

Should we document this as acceptable?

  -A "Since: x.y.z" tagged section lists the release that introduced the
  -definition.

  -"TODO" sections are not rendered (they are for developers, not users of
  -QMP).  In other sections, the text is formatted, and rST markup can be
  -used.
  +.. _doc-feat:
  +
  +Feature Descriptions
  +^^^^^^^^^^^^^^^^^^^^
  +
  +Feature descriptions are a :ref:`doc-descrip` section that document feat=
ures
  +that apply to this definition.
  +
  +The feature descriptions must be preceded by a blank line and then a
  +line "Features:", like this::
  +
  +  #
  +  # Features:
  +  #
  +  # @feature: Description text

Perhaps something like

   Feature descriptions document the features that apply to this
   definition.  They start with a line "Features:" followed by one
   description per feature in the same syntax as argument / member /
   branch / value descriptions, like this::

  +
  +
  +Details
  +^^^^^^^
  +
  +Details sections are comprised of one or more paragraphs of rST
  +formatted text, but otherwise are not marked up with any QAPI-specific
  +syntax. In general, this text contains in-depth explanations of the
  +definition being documented and may include various rST admonitions
  +like ``.. seealso::``, ``.. note::``, etc. This is also the section
  +where QMP usage examples should be placed.

Is the section concept helpful here?

Internally, it's a single section unless split by TODO sections.
Whether and how it's split shouldn't affect the output at all.

Users don't care for all that.  For them, it's just paragraphs.

   QMP Examples can be added by using the ``.. qmp-example::`` directive.
   In its simplest form, this can be used to contain a single QMP code
   block which accepts standard JSON syntax with additional server
   directionality indicators (``->`` and ``<-``), and elisions.  An
   elision is commonly ``...``, but it can also be or a pair of ``...``
   with text in between.

   Optionally, a plaintext title may be provided by using the ``:title:``
   directive option.  If the title is omitted, the example title will
   default to "Example:".

   A simple QMP example::

     # .. qmp-example::
     #
     #     -> { "execute": "query-name" }
     #     <- { "return": { "name": "Fred" } }

   More complex or multi-step examples where exposition is needed before
   or between QMP code blocks can be created by using the ``:annotated:``
   directive option.  When using this option, nested QMP code blocks must
   be entered explicitly with rST's ``::`` syntax.

   For example::

     # .. qmp-example::
     #    :annotated:
     #    :title: A more complex demonstration
     #
     #    This is a more complex example that can use
     #    ``arbitrary rST syntax`` in its exposition::
     #
     #     -> { "execute": "query-block" }
     #     <- { "return": [
     #             {
     #               "device": "ide0-hd0",
     #               ...
     #             }
     #             ... more ...
     #          ] }
     #
     #    Above, lengthy output has been omitted for brevity.

   Highlighting in non-QMP languages can be accomplished by using the
   ``.. code-block:: lang`` directive, and non-highlighted text can be
   achieved by omitting the language argument.


  +Since
  +^^^^^
  +
  +A "Since: x.y" :ref:`doc-tagged` lists the release that introduced the
  +definition::
  +
  +  #
  +  # Since: 11.2
  +  #
  +
  +
  +TODO
  +^^^^
  +
  +"TODO" tagged sections are not rendered (they are for developers, not us=
ers of
  +QMP). They can appear anywhere after the introductory section::
  +
  +  #
  +  ## TODO: This is not rendered in the documentation.
  +  #
  +
  +
  +Putting it all together
  +^^^^^^^^^^^^^^^^^^^^^^^
  +
   Examples of complete definition documentation::

    ##
    # @BlockStats:
    #     Statistics of a virtual block device or a block backing device.
    #
    # @device: If the stats are for a virtual block device, the name
    #     corresponding to the virtual block device.
    #
    # @node-name: The node name of the device.  (Since 2.3)
    #
    # ... more members ...
    #
    # Since: 0.14
    ##
    { 'struct': 'BlockStats',
      'data': {'*device': 'str', '*node-name': 'str',
               ... more members ... } }

    ##
    # @query-blockstats:
    #     Query the @BlockStats for all virtual block devices.
    #
    # @query-nodes: If true, the command will query all the block nodes
    #     ... explain, explain ...
    #     (Since 2.3)
    #
    # Returns: A list of @BlockStats for each virtual block devices.
    #
    # Since: 0.14
    #
    # .. qmp-example::
    #
    #     -> { "execute": "query-blockstats" }
    #     <- {
    #          ...
    #        }
    ##
    { 'command': 'query-blockstats',
      'data': { '*query-nodes': 'bool' },
      'returns': ['BlockStats'] }


   Markup pitfalls
   ~~~~~~~~~~~~~~~


