Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6DAC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x681S-0001NM-OP; Mon, 14 Sep 2026 10:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x681D-0001Mr-KX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:50:53 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x6819-0005Uy-NM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=SgQ+Cn8SIo8AYpDzJTRx0Dl2rCmWdCo9vtmOVvtDSi0=; b=WB0OCvSMd7BQ2rB1
 T7UgYbig8rFWnUSOqvBSZfHgPq0iGaChNacywJtc8G+fL23MsxoTLqArK5CagH0xA4rrFSmbGzesf
 NK+LyKPyisZnsS7Oc9GZOjZ9AKEcRMCAV5ogz440Ouzc1fcQDlS9icGoDLjfMi9qnap3/zyCgcbhH
 QT/XQSUZaAgZ67vJGpQgqKNefGTL0g61ciFFawGNeb0clkBHM59UmjY1Qj6KonZcDewN7V11JcfVY
 I7V7klaOjOnsuzxCDjowftiLtarQfFgSHPaA63DQEKpnXHVEoWrFaUy+S60QztQumCuNKUhfqeqTI
 mNvY+5u+vigOjseFxA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x6817-00000000Rat-05m7;
 Mon, 14 Sep 2026 14:50:45 +0000
Date: Mon, 14 Sep 2026 14:50:44 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/18] tests/qtest/migration: Add a test for HMP
 completion
Message-ID: <aqgJxF3BYe0Nmqgu@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-11-farosas@suse.de>
 <aqcOjb1jV_UJlBwx@gallifrey> <87a4pjubyw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87a4pjubyw.fsf@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 14:49:29 up 2 days, 2:34, 2 users, load average: 0.06, 0.05, 0.01
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

* Fabiano Rosas (farosas@suse.de) wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Fabiano Rosas (farosas@suse.de) wrote:
> >> The following patches will touch HMP readline completion for migration
> >> parameters, add a test case.
> >> 
> >> The test puts the monitor on a chardev via socket and bypasses qtest
> >> facilities because it needs to emit raw codes to readline. It
> >> therefore requires a couple of new helpers to read/write to the
> >> monitor socket.
> >> 
> >> Usage:
> >> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/completion
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >
> >> +static void hmp_sock_read(int fd, char *buf, size_t buf_sz)
> >> +{
> >> +    char *p = buf;
> >> +    size_t sz = buf_sz - 1;
> >> +
> >> +    assert(fd >= 0);
> >> +    memset(buf, 0, buf_sz);
> >> +
> >> +    while (sz > 0) {
> >> +        ssize_t r = read(fd, p, sz);
> >> +        char *prompt;
> >> +
> >> +        if (!r) {
> >> +            break;
> >> +        } else if (r < 0) {
> >> +            if (errno == EINTR) {
> >> +                continue;
> >> +            }
> >> +            g_assert_not_reached();
> >> +        }
> >> +
> >> +        p += r;
> >> +        sz -= r;
> >> +
> >> +        prompt = strstr(buf, "(qemu) ");
> >> +        if (prompt) {
> >> +            *prompt = '\0';
> >
> > I'm a bit confused by what you want the output to look like after this,
> > are you assuming this is the end of the string you're reading so truncation
> > is OK?
> >
> 
> Yes, it's how I'm detecting the end of input. Here's a printf("%s|\n", buf)
> before the truncation:
> 
> 1) Read banner:                                                                                    
> 
> QEMU 11.1.50 monitor - type 'help' for more information
> (qemu) |

Oh right, that makes sense - please add a comment above the function something like
'read the output until we hit the next (qemu) prompt'

Dave

> 2) Write completion input 'migra\t'. Then read back:
> 
> migra
> migrate                 migrate_cancel          migrate_continue
> migrate_incoming        migrate_pause           migrate_recover
> migrate_set_capability  migrate_set_parameter   migrate_start_postcopy
> (qemu) |
> 
> 3) Write completion input 'info migra\t'. Then read back:
> 
> info migra
> migrate               migrate_capabilities  migrate_parameters
> (qemu) |
> 
> I think this is correct? Let me know if I missed something.
> 
> >> +            break;
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static int comp(const void *a, const void *b)
> >> +{
> >> +    return strcmp(*(const char **) a, *(const char **) b);
> >> +}
> >
> > Can you use qemu_pstrcmp0 there? (Maybe with g_ptr_array and g_ptr_array_sort is
> > what adds to some of the other questions below?)
> >
> 
> Good idea, specially the g_ptr_array. I'll update the code.
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

