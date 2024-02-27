Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A589C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rew4P-0005FF-E9; Tue, 27 Feb 2024 06:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rew4N-0005Ec-RA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rew4L-0000MR-82
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709034979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZT6nN0Dt7c8P0z0WjxnNRz2cJWnsqyLhgXnGzR93vLQ=;
 b=en6RqN6FlsST2nJ9yhVm08UsCOOwIq7fvBuvLjPOPJlU4mdMhGvsiNsqP6cU46Uh7tJoe6
 SRewIUMrSGDdn4CVNrbJfRNP+53rxPaaUNk0nKQHeFDdjAuWkURPfu4D+7TzdM5npinfJj
 Jx+wEjaJi0e5bpW3OQ91vh9NivSGZX0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-lV-yQZm6ND612-DidJ1Nww-1; Tue,
 27 Feb 2024 06:56:18 -0500
X-MC-Unique: lV-yQZm6ND612-DidJ1Nww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54CFF1C05AA3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:56:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 169E3492BC9
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:56:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DCAA21E6682; Tue, 27 Feb 2024 12:56:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	berrange@redhat.com
Subject: [PATCH 2/2] docs/devel/writing-monitor-commands: Minor improvements
Date: Tue, 27 Feb 2024 12:56:17 +0100
Message-ID: <20240227115617.237875-3-armbru@redhat.com>
In-Reply-To: <20240227115617.237875-1-armbru@redhat.com>
References: <20240227115617.237875-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avoid "JSON" when talking about the QAPI schema syntax.  Capitalize
QEMU.  Don't claim all HMP commands live in monitor/hmp-cmds.c (this
was never true).  Fix punctuation and drop inappropriate "the" here
and there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-monitor-commands.rst | 32 ++++++++++++-------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 047c6f42bb..d2045b66b3 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -115,8 +115,7 @@ the bottom::
  ##
  { 'command': 'hello-world' }
 
-The "command" keyword defines a new QMP command. It's an JSON object. All
-schema entries are JSON objects. The line above will instruct the QAPI to
+The "command" keyword defines a new QMP command. It instructs QAPI to
 generate any prototypes and the necessary code to marshal and unmarshal
 protocol data.
 
@@ -138,16 +137,16 @@ There are a few things to be noticed:
 3. It takes an "Error \*\*" argument. This is required. Later we will see how to
    return errors and take additional arguments. The Error argument should not
    be touched if the command doesn't return errors
-4. We won't add the function's prototype. That's automatically done by the QAPI
+4. We won't add the function's prototype. That's automatically done by QAPI
 5. Printing to the terminal is discouraged for QMP commands, we do it here
    because it's the easiest way to demonstrate a QMP command
 
-You're done. Now build qemu, run it as suggested in the "Testing" section,
+You're done. Now build QEMU, run it as suggested in the "Testing" section,
 and then type the following QMP command::
 
  { "execute": "hello-world" }
 
-Then check the terminal running qemu and look for the "Hello, world" string. If
+Then check the terminal running QEMU and look for the "Hello, world" string. If
 you don't see it then something went wrong.
 
 
@@ -201,7 +200,7 @@ There are two important details to be noticed:
 2. The C implementation signature must follow the schema's argument ordering,
    which is defined by the "data" member
 
-Time to test our new version of the "hello-world" command. Build qemu, run it as
+Time to test our new version of the "hello-world" command. Build QEMU, run it as
 described in the "Testing" section and then send two commands::
 
  { "execute": "hello-world" }
@@ -210,13 +209,13 @@ described in the "Testing" section and then send two commands::
      }
  }
 
- { "execute": "hello-world", "arguments": { "message": "We love qemu" } }
+ { "execute": "hello-world", "arguments": { "message": "We love QEMU" } }
  {
      "return": {
      }
  }
 
-You should see "Hello, world" and "We love qemu" in the terminal running qemu,
+You should see "Hello, world" and "We love QEMU" in the terminal running QEMU,
 if you don't see these strings, then something went wrong.
 
 
@@ -246,7 +245,7 @@ The first argument to the error_setg() function is the Error pointer
 to pointer, which is passed to all QMP functions. The next argument is a human
 description of the error, this is a free-form printf-like string.
 
-Let's test the example above. Build qemu, run it as defined in the "Testing"
+Let's test the example above. Build QEMU, run it as defined in the "Testing"
 section, and then issue the following command::
 
  { "execute": "hello-world", "arguments": { "message": "all you need is love" } }
@@ -279,9 +278,8 @@ Implementing the HMP command
 Now that the QMP command is in place, we can also make it available in the human
 monitor (HMP).
 
-With the introduction of the QAPI, HMP commands make QMP calls. Most of the
-time HMP commands are simple wrappers. All HMP commands implementation exist in
-the monitor/hmp-cmds.c file.
+With the introduction of QAPI, HMP commands make QMP calls. Most of the
+time HMP commands are simple wrappers.
 
 Here's the implementation of the "hello-world" HMP command::
 
@@ -332,17 +330,17 @@ To test this you have to open a user monitor and issue the "hello-world"
 command. It might be instructive to check the command's documentation with
 HMP's "help" command.
 
-Please, check the "-monitor" command-line option to know how to open a user
+Please check the "-monitor" command-line option to know how to open a user
 monitor.
 
 
 Writing more complex commands
 -----------------------------
 
-A QMP command is capable of returning any data the QAPI supports like integers,
+A QMP command is capable of returning any data QAPI supports like integers,
 strings, booleans, enumerations and user defined types.
 
-In this section we will focus on user defined types. Please, check the QAPI
+In this section we will focus on user defined types. Please check the QAPI
 documentation for information about the other types.
 
 
@@ -463,7 +461,7 @@ There are a number of things to be noticed:
    member, it comes with a 'has_bootindex' member that needs to be set
    by the implementation, as shown above
 
-Time to test the new command. Build qemu, run it as described in the "Testing"
+Time to test the new command. Build QEMU, run it as described in the "Testing"
 section and try this::
 
  { "execute": "query-option-rom" }
@@ -532,7 +530,7 @@ option-roms" follows::
    Show the option ROMs.
  ERST
 
-To test this, run qemu and type "info option-roms" in the user monitor.
+To test this, run QEMU and type "info option-roms" in the user monitor.
 
 
 Writing a debugging aid returning unstructured text
-- 
2.43.0


