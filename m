Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8F6D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSIp-0002WY-M5; Thu, 15 Jan 2026 13:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgSIn-0002UD-4h
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:42:37 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgSIl-0003ES-2T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=uh1kbpDK70GHe/tid3R3AOVOgw+6STsOAyorSVzxloI=; b=V1pw7YkVRVhHuput
 zBBSIcKdVGEqyYbGtdPP8DFJyhdPKmXX6sdedXyL++O3tyjbneGH6ThTP9naA902ZwUi8d6mlxnTP
 BTBWLn1xkCGOKl9lf55p5eKQUKtFBknKgTYqg5u0Vkljr3Go94FrYH2AwbJatA3Ds7CUT1ur0hkFc
 K/6c2BkUY2jmqTjFurl2StSQp2uiAWlNqb1fuJckKvGXFhfBBS/0Pb/drC7DxDIs+QsSGpk+Ipph5
 T9Ai4UqBaNbxJJOFEyAo7Z86M89PAXwAbd8QWECW5Ixp/zZLNyb7/zmG97RBLP4yM4B+NGydUMjFr
 fk/TsE2viuFpD35slw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vgSIg-0000000F3Nm-3WC6;
 Thu, 15 Jan 2026 18:42:30 +0000
Date: Thu, 15 Jan 2026 18:42:30 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] hmp*hx: Move info docs
Message-ID: <aWk1FvYlhq6a1Sbm@gallifrey>
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-3-dave@treblig.org>
 <875x93xf4q.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x93xf4q.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 18:42:06 up 80 days, 18:18,  3 users,  load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Markus Armbruster (armbru@redhat.com) wrote:
> dave@treblig.org writes:
> 
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >
> > Move the docs for the info subcommand from the separate hx
> > into the top level file next to the 'info' command itself.
> > That makes every command in the top level file have a RST section.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> Generated HTML changes slightly, diff appended.  Shows as vertical space
> differences in Firefox.  Do we care?

It looked OK to me in Firefox, is there a bit that looks wrong/bad to you?

Dave

> 
> --- bld-docs/docs.old/manual/system/monitor.html	2026-01-15 12:30:17.300968723 +0100
> +++ bld-docs/docs/manual/system/monitor.html	2026-01-15 12:55:43.909694634 +0100
> @@ -601,10 +601,11 @@ command.</p>
>  </dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">xen-event-list</span></code></dt><dd><p>List event channels in the guest</p>
>  </dd>
> -</dl>
> -<dl>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span></code> <em>subcommand</em></dt><dd><p>Show various information about the system state.</p>
> -<dl>
> +</dd>
> +</dl>
> +<blockquote>
> +<div><dl>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">version</span></code></dt><dd><p>Show the version of QEMU.</p>
>  </dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">network</span></code></dt><dd><p>Show the network state.</p>
> @@ -639,8 +640,6 @@ command.</p>
>  </dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">jit</span></code></dt><dd><p>Show dynamic compiler info.</p>
>  </dd>
> -<dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">accel</span></code></dt><dd><p>Show accelerator statistics.</p>
> -</dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">sync-profile</span> <span class="pre">[-m|-n]</span></code> [<em>max</em>]</dt><dd><p>Show synchronization profiling info, up to <em>max</em> entries (default: 10),
>  sorted by total wait time.</p>
>  <dl class="simple">
> @@ -653,6 +652,8 @@ sorted by total wait time.</p>
>  the “Object” field shows—enclosed in brackets—the number of objects
>  being coalesced.</p>
>  </dd>
> +<dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">accel</span></code></dt><dd><p>Show accelerator statistics.</p>
> +</dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">kvm</span></code></dt><dd><p>Show KVM information.</p>
>  </dd>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">accelerators</span></code></dt><dd><p>Show which accelerators are compiled into a QEMU binary, and what accelerator
> @@ -765,8 +766,7 @@ enabled) memory in bytes.</p>
>  <dt><code class="docutils literal notranslate"><span class="pre">info</span> <span class="pre">firmware-log</span></code></dt><dd><p>Show the firmware (ovmf) debug log.</p>
>  </dd>
>  </dl>
> -</dd>
> -</dl>
> +</div></blockquote>
>  </section>
>  <section id="integer-expressions">
>  <h2>Integer expressions<a class="headerlink" href="#integer-expressions" title="Link to this heading"></a></h2>
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

