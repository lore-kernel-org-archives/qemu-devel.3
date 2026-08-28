Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5C6C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x00ti-0001tr-I3; Fri, 28 Aug 2026 14:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x00th-0001tj-He
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 14:01:49 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x00tf-0002a9-Ns
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 14:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=hOmq/K2w8cpQ4+HHzxtRKdmuzpNsR6hqeP/7m6iu/Yo=; b=aXQoYAPZDxOR+08i
 QZM+92Hr4ka6+5Ted0U8EbhUW3XLUc+Yse7sn6FMNwCWWhQTpUiJ0dOugxoTOl3W7R6r4j7sx7jNv
 VDykaQdisex01F9T73YanSsggaYr8umWuWxIbOVxYU4e0L4gC7Ybrq2AWfwCL9eaVBsA4dRDOd6y/
 YH1swzrICVMDNbn5zBfqsVo4xLGZUA5GEHsOYV7b8nMkX0mk5I7FZXxheBWOmVwjYsQgcThSBOUZf
 27ms8WiM+s6UuI+8+ah5jSJ42EbfUbXyWwCUG6ac9VVRADxCC7yx3KKfgx8z75tBR1ww/Emp1CN1Q
 kJkLG9kOFbZhjdbWqA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x00ta-00000000pzI-2uax;
 Fri, 28 Aug 2026 18:01:42 +0000
Date: Fri, 28 Aug 2026 18:01:42 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, "Denis V. Lunev" <den@openvz.org>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/50] Make HMP optional (and later standalone)
Message-ID: <apHNBpl68IcHvlD6@gallifrey>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
 <e55988ca-43d0-41ec-8a3b-d839e8138461@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e55988ca-43d0-41ec-8a3b-d839e8138461@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.105+deb13-amd64 (x86_64)
X-Uptime: 18:01:11 up 2 days, 21:04, 2 users, load average: 0.08, 0.07, 0.01
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

* Philippe Mathieu-Daudé (philmd@oss.qualcomm.com) wrote:
> On 28/8/26 14:03, Marc-AndrÃ© Lureau wrote:
> > Hi,
> > 
> > This series makes HMP compile-time optional via --disable-hmp. The
> > resulting binary speaks only QMP - reducing the attack surface, binary
> > size and enforcing a separation between machine-readable interface and
> > interactive debugging console.
> > 
> > QMP offers almost all the functionality HMP could provide, so a separate
> > standalone "HMP-like" console could be implemented on top of it. The
> > rough list of missing commands (+complexity estimation) after this
> > series:
> 
> 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> > Changes in v5:
> > - renamed local variable hmp_mon -> hmp in patch for consistency
> > - renamed error_vprintf_mon/error_printf_mon -> error_vprintf_hmp/error_printf_hmp
> > - simplified default_monitor init with IS_ENABLED(CONFIG_HMP)
> > - added early NULL return in qemu_vprintf/qemu_vfprintf
> > - reworked !opts->has_mode path to use explicit error_setg() when HMP is disabled
> > - split device-introspect-test patch
> > - rebased, collected tags, all reviewed, ready-to-merge
> 
> Thanks for the final polishing. Everything LGTM!

Yeh better merge it before anything moves!
(Assume Marc-André is sending the pull).

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

