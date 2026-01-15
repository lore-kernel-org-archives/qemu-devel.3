Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4F8D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLyy-0002vb-Gu; Thu, 15 Jan 2026 06:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgLyv-0002tG-7L
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgLys-00045F-Aq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768478253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OCALVC/3j6ktdBcTUNVWuK58dN4UBblPertRsER8cs=;
 b=NMebn14aRWcfYv1LooIRdHt5DzDjIF+/LhCEP60WtAQ6NPhkA6f3fN8EvWTYMPxlCTcY/4
 XvIMsfSSdhQRYzd2Pz99BkHE7ndAXEKRkrTCGQQoIQLoRSaIuCQPpvS91Gle1kKbgXQM6V
 maK/NXIccVFkxyG1M3e6alSV+CE7xI8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-gle9Yp3AOOK6yx3TgW2Pdw-1; Thu,
 15 Jan 2026 06:57:32 -0500
X-MC-Unique: gle9Yp3AOOK6yx3TgW2Pdw-1
X-Mimecast-MFC-AGG-ID: gle9Yp3AOOK6yx3TgW2Pdw_1768478251
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E61718007EB; Thu, 15 Jan 2026 11:57:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A6601801A45; Thu, 15 Jan 2026 11:57:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77EC221E692D; Thu, 15 Jan 2026 12:57:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: dave@treblig.org
Cc: berrange@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] hmp*hx: Move info docs
In-Reply-To: <20260115020423.722069-3-dave@treblig.org> (dave@treblig.org's
 message of "Thu, 15 Jan 2026 02:04:21 +0000")
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-3-dave@treblig.org>
Date: Thu, 15 Jan 2026 12:57:25 +0100
Message-ID: <875x93xf4q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> Move the docs for the info subcommand from the separate hx
> into the top level file next to the 'info' command itself.
> That makes every command in the top level file have a RST section.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Generated HTML changes slightly, diff appended.  Shows as vertical space
differences in Firefox.  Do we care?


--- bld-docs/docs.old/manual/system/monitor.html	2026-01-15 12:30:17.300968=
723 +0100
+++ bld-docs/docs/manual/system/monitor.html	2026-01-15 12:55:43.909694634 =
+0100
@@ -601,10 +601,11 @@ command.</p>
 </dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">xen-e=
vent-list</span></code></dt><dd><p>List event channels in the guest</p>
 </dd>
-</dl>
-<dl>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span></code> <em>subcommand</em></dt><dd><p>Show various information about=
 the system state.</p>
-<dl>
+</dd>
+</dl>
+<blockquote>
+<div><dl>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">version</span></code></dt><dd><p>Show the versio=
n of QEMU.</p>
 </dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">network</span></code></dt><dd><p>Show the networ=
k state.</p>
@@ -639,8 +640,6 @@ command.</p>
 </dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">jit</span></code></dt><dd><p>Show dynamic compil=
er info.</p>
 </dd>
-<dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">accel</span></code></dt><dd><p>Show accelerator =
statistics.</p>
-</dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">sync-profile</span> <span class=3D"pre">[-m|-n]<=
/span></code> [<em>max</em>]</dt><dd><p>Show synchronization profiling info=
, up to <em>max</em> entries (default: 10),
 sorted by total wait time.</p>
 <dl class=3D"simple">
@@ -653,6 +652,8 @@ sorted by total wait time.</p>
 the =E2=80=9CObject=E2=80=9D field shows=E2=80=94enclosed in brackets=E2=
=80=94the number of objects
 being coalesced.</p>
 </dd>
+<dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">accel</span></code></dt><dd><p>Show accelerator =
statistics.</p>
+</dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">kvm</span></code></dt><dd><p>Show KVM informatio=
n.</p>
 </dd>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">accelerators</span></code></dt><dd><p>Show which=
 accelerators are compiled into a QEMU binary, and what accelerator
@@ -765,8 +766,7 @@ enabled) memory in bytes.</p>
 <dt><code class=3D"docutils literal notranslate"><span class=3D"pre">info<=
/span> <span class=3D"pre">firmware-log</span></code></dt><dd><p>Show the f=
irmware (ovmf) debug log.</p>
 </dd>
 </dl>
-</dd>
-</dl>
+</div></blockquote>
 </section>
 <section id=3D"integer-expressions">
 <h2>Integer expressions<a class=3D"headerlink" href=3D"#integer-expression=
s" title=3D"Link to this heading">=EF=83=81</a></h2>


