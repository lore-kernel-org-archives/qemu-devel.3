Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF1CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENI6-0004vI-DX; Wed, 07 Oct 2026 04:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEJOA-0004Rv-24
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEJO6-00022b-CZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791347776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjUeXHsGJ17okHZ3na6dp3v+GdACzsj2sjRGphoZqy4=;
 b=Ey/2B7YVfAm1VgZZjhfsnWEqzOKSNIpbpO4TSPT0j/3SFts48izW6VX5cdISfLkbPbM3J8
 /Xh+OZvLhM3UkSbn4+WtXwiPh8O6LDFM1BJ4jJdboiBJeB37VKiE0lUJr++7QS/8KK9Ymq
 L7Mv4p44xBesv0Xf2rrIQL/rxGaT5eg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-GerKf0TFP4ykAKCwxk9_uA-1; Tue,
 06 Oct 2026 03:55:56 -0400
X-MC-Unique: GerKf0TFP4ykAKCwxk9_uA-1
X-Mimecast-MFC-AGG-ID: GerKf0TFP4ykAKCwxk9_uA_1791273355
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA3791800115; Tue,  6 Oct 2026 07:55:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B7119560AB; Tue,  6 Oct 2026 07:55:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C01C621E6A04; Tue, 06 Oct 2026 09:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 02/11] docs/qapi-code-gen: add "Putting it all together"
 subsection
In-Reply-To: <20261001172239.2825745-3-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:29 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
 <20261001172239.2825745-3-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 09:55:52 +0200
Message-ID: <87mrsrdzzr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Separate the specification portion of the documentation section from
> the holistic examples. Avoid naming the section "Examples" because it
> might be confused with the literal case of documenting how code
> examples should themselves be documented.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index f276a2bc9bc..0f66f012be1 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1089,6 +1089,9 @@ Highlighting in non-QMP languages can be accomplished by using the
>  achieved by omitting the language argument.
>  
>  
> +Putting it all together
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
>  Examples of complete definition documentation::
>  
>   ##

This adds another level of headings, level seven:

    Developer Information
        QEMU Build System
            How to use the QAPI code generator
                The QAPI schema language
                    Documentation comments
                        Definition documentation
                            Putting it all together

I'm not thrilled by this depth, to be honest.

Adding the heading makes next to no sense by itself.  However, you add
more headings next to it later in the series, and I believe that's why
you add this one now.  Recommend to mention this in your commit message.

The series' total change to the section structure:

    Introduction
    ============
    The QAPI schema language
    ========================
        Schema syntax
        -------------
        Built-in Types
        --------------
        Include directives
        ------------------
        Pragma directives
        -----------------
        Enumeration types
        -----------------
        Type references and array types
        -------------------------------
        Struct types
        ------------
        Union types
        -----------
        Alternate types
        ---------------
        Commands
        --------
        Events
        ------
        Features
        --------
            Special features
            ~~~~~~~~~~~~~~~~
        Naming rules and reserved names
        -------------------------------
        Downstream extensions
        ---------------------
        Configuring the schema
        ----------------------
        Documentation comments
        ----------------------
            Headings and subheadings
            ~~~~~~~~~~~~~~~~~~~~~~~~
            Documentation markup
            ~~~~~~~~~~~~~~~~~~~~
            Definition documentation
            ~~~~~~~~~~~~~~~~~~~~~~~~
   +            Intro
   +            ^^^^^
   +            Descriptions
   +            ^^^^^^^^^^^^
   +            Tagged sections
   +            ^^^^^^^^^^^^^^^
   +            Returns
   +            ^^^^^^^
   +            Errors
   +            ^^^^^^
   +            Feature Descriptions
   +            ^^^^^^^^^^^^^^^^^^^^
   +            Details
   +            ^^^^^^^
   +            Since
   +            ^^^^^
   +            TODO
   +            ^^^^
   +            Putting it all together
   +            ^^^^^^^^^^^^^^^^^^^^^^^
            Markup pitfalls
            ~~~~~~~~~~~~~~~
    Client JSON Protocol introspection
    ==================================
    Compatibility considerations
    ============================
    Code generation
    ===============
        Code generated for QAPI types
        -----------------------------
        Code generated for visiting QAPI types
        --------------------------------------
        Code generated for commands
        ---------------------------
        Code generated for events
        -------------------------
        Code generated for introspection
        --------------------------------

It's more deeply nested than I'd like, but to avoid that, we'd need a
more invasive restructuring.  Let's not go there now.


