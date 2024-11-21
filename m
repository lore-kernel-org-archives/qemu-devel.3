Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025BD78779
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 14:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8Q8-0004Zq-Qu; Thu, 21 Nov 2024 09:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tE8Q6-0004ZO-8M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:44:34 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tE8Q4-0006lF-87
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=LxmymT7yrUWU0wcVAzsTPudB0JAefORGvPF76+OMCEc=; b=Az7UTiOMaXDiMKggTrAGXSeaO5
 aLa7PqIbsxouvV3PIvDt8L+RRCwaKqPX1mc/FX6jWv07pcoPSlJfGxh41k9LhPMhcIvJ1FsP1b8dt
 bM21yU302dEp7Y806lbSEoF8146IVO2HY+U/HdbJE3iMbR0EFI72gnOHLFDpHTS3vS8NQtI1HgKUJ
 gomrAMa1/JxAKaViEoKiDz2ahAGJKBPdapN4Kfj4gDIsdCQaM9QthoNT97RY9ZN4uEoc/122eMXeh
 jTtFxOzbmJ9qxpt5JWL4ZGSandPuZre94CYcDPh6T5Mah6l4/YTXKOa3lXMMYIm7fn6gnz7J7fCPi
 qxXi0osRf1MOEVkVxhk/E5IS1GzLZie7RPZvYDYrwhf+Ap4+Co7Y84+pxEYfzNF0eAvuiJPuA4GeX
 caJKDMy575yoRatKqsMEMeH892I/dAq/h+z4pdc9rHs1Y3pQFbfki93ucH8K2pw5In0wKbxOROdbB
 OsB9Mv9qr3l8yADrzfXGDx8IRT+O59gMRhtaOm+Q3yzhcqxXQKJ01UwC/JdFPOtWvaD+1pe0cx5nb
 MBsyD1/tBDrcxA8K0cHYT9Uk/ETDJdIC22D835CApVWPrIpyLn7g5alZCdCN9cJ0umKdmUGvTlTv6
 IfV+qOkxXcr9a21SRC7tDBH5lVSyU82QkLUV55Y4s=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Linus Heckemann <git@sphalerite.org>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: cleanup V9fsFidState
Date: Thu, 21 Nov 2024 15:44:26 +0100
Message-ID: <2245247.dxyzlAYDFa@silver>
In-Reply-To: <20241121120739.5f2a8c1d@bahia>
References: <E1tE4v2-0051EH-Ni@kylie.crudebyte.com>
 <20241121120739.5f2a8c1d@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thursday, November 21, 2024 12:07:39 PM CET Greg Kurz wrote:
> On Thu, 21 Nov 2024 11:52:48 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > Drop V9fsFidState's 'next' member, which is no longer used since:
> > 
> >   f5265c8f917e ('9pfs: use GHashTable for fid table')
> > 
> 
> Good catch !

Coincidence. I was reviewing & benchmarking this FID management code, because
sometimes hash maps are quite slow on iterating over all elements. So I made
a quick dual-container test with GHashTable for lookup of course, and while
using the old list container for 9p code parts that need to iterate over all
FIDs.

Fortunately it turned out though that iterating over all GHashTable elements
is even a tiny bit faster than iterating over the linked list, so GHashTable
is all we need, i.e. fast and simple code.

But ... I also learned that Linus' patch improved more than we expected.
Because just reverting these few lines:

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c7c433c06e..a5159ad766 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -330,6 +330,7 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t fid)
      * reclaim won't close the file descriptor
      */
     f->flags |= FID_REFERENCED;
+    QSIMPLEQ_INSERT_TAIL(&s->fid_list, f, next);
     g_hash_table_insert(s->fid_table, GINT_TO_POINTER(fid), f);
 
     v9fs_readdir_init(s->proto_version, &f->fs.dir);
@@ -420,6 +421,7 @@ static V9fsFidState *clunk_fid(V9fsState *s, int32_t fid)
     /* TODO: Use g_hash_table_steal_extended() instead? */
     fidp = g_hash_table_lookup(s->fid_table, GINT_TO_POINTER(fid));
     if (fidp) {
+        QSIMPLEQ_REMOVE(&s->fid_list, fidp, V9fsFidState, next);
         g_hash_table_remove(s->fid_table, GINT_TO_POINTER(fid));
         fidp->clunked = true;
         return fidp;
@@ -4246,6 +4248,7 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fmode = fse->fmode;
     s->ctx.dmode = fse->dmode;
 
+    QSIMPLEQ_INIT(&s->fid_list);
     s->fid_table = g_hash_table_new(NULL, NULL);
     qemu_co_rwlock_init(&s->rename_lock);
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index c92da2751a..177f4bab53 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -339,6 +339,7 @@ typedef struct {
 struct V9fsState {
     QLIST_HEAD(, V9fsPDU) free_list;
     QLIST_HEAD(, V9fsPDU) active_list;
+    QSIMPLEQ_HEAD(, V9fsFidState) fid_list;
     GHashTable *fid_table;
     FileOperations *ops;
     FsContext ctx;

Caused my test guest installation's performance to drop down to hell, i.e. I
could literally see and count the individual characters being updated on
guest's screen, that slow!

Which was a bit surprising first, because all it does is inserting and
removing elements to the old list. But then I realized, right, that's because
it was not a doubly linked list, but a simple linked list, so every
QSIMPLEQ_REMOVE() was actually traversing the list from head on.

So old and new conclusion: always start by checking your data structure types
first!

> Fixes: f5265c8f917e ('9pfs: use GHashTable for fid table')
> Reviewed-by: Greg Kurz <groug@kaod.org>

I'll add the fixes tag silently on my end.

Thanks!

/Christian



