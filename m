Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0513CE87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHLW-00019N-9v; Tue, 03 Feb 2026 09:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vnHLV-000194-4b
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:25:37 -0500
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vnHLS-00040d-Sx
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:25:36 -0500
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 685EF1520CCD;
 Tue, 03 Feb 2026 15:25:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1770128730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=vsU92RbtNXuYo1Z30VDe1YdfQ0oVBXsTTXhMQKwh2nU=;
 b=FhnGCZpQmTscX/TPezD+rkybEfoe+tddTTyk6fAMZHBDcqRjXD+6yzG+dGHswdYNy3dbK6
 dAfXCLtRjp6+mEA4CyWoo2h0s6cdzyUmWnB6rp2lV26Hk0WVaf+En3TVH552+NhKNWI2PE
 VZdDo7FK165wtVwy0l1bmKs1GPjs/434Aitd0ke2bIexmUNfYSD/3+pupfuk7ZM1EmMiMy
 4kyoWJgxKV4MSGvjKF0Adu1jI6HrcrsJBbzVdFkuVxUuLSx8gf6StxCVDuEwSbTInC2yh4
 hpge1Xu+y8zym9rNU1tB07bnujk14KZ6lE3aitcx2XymeJqcc0sMUI+4NOJiOw==
Content-Type: multipart/alternative;
 boundary="------------rNZ0YjKLqMmghUrjyvexC3nz"
Message-ID: <4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be>
Date: Tue, 3 Feb 2026 15:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org, f.ebner@proxmox.com, kwolf@redhat.com
Content-Language: en-US, en-GB, nl-BE
Cc: dionbosschieter@gmail.com
From: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: (in guest) disk corruption during snapshots
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------rNZ0YjKLqMmghUrjyvexC3nz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Since some months we were observing disk corruption within the VM when 
enabling backups (which triggers snapshots).
After a lot of troubleshooting, we were able to track down the commit 
that caused it:
https://gitlab.com/qemu-project/qemu/-/commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694

More info in the issue:
https://gitlab.com/qemu-project/qemu/-/issues/3273

Now this seems to be caused by a race between disabling the 
dirty_bitmaps and the tracking implemented in the mirror top layer.
Kevin shared me a possible solution:

diff --git a/block/mirror.c b/block/mirror.c
index b344182c747..f76e43f22c1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1122,6 +1122,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
       * accessing it.
       */
      mirror_top_opaque->job = s;
+    if (s->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
  
      assert(!s->dbi);
      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
@@ -2018,7 +2021,9 @@ static BlockJob *mirror_start_job(
       * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
       * mode.
       */
-    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
  
      bdrv_graph_wrlock_drained();
      ret = block_job_add_bdrv(&s->common, "source", bs, 0,


Running this for some hours already, and it seems to fix the issue.

Let's open up the discussion if this is the proper way to fix it, or if 
there are better alternatives :)

Thanks
Jean-Louis

--------------rNZ0YjKLqMmghUrjyvexC3nz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,<br>
      <br>
      Since some months we were observing disk corruption within the VM
      when enabling backups (which triggers snapshots).<br>
      After a lot of troubleshooting, we were able to track down the
      commit that caused it:<br>
<a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694">https://gitlab.com/qemu-project/qemu/-/commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694</a><br>
      <br>
      More info in the issue:<br>
      <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/issues/3273">https://gitlab.com/qemu-project/qemu/-/issues/3273</a></p>
    <p>Now this seems to be caused by a race between disabling the
      dirty_bitmaps and the tracking implemented in the mirror top
      layer.<br>
      Kevin shared me a possible solution:<br>
    </p>
    <pre
style="background-color: #f8f8f8; border: 1px solid #dddddd; border-radius: 4px; padding: 8px 12px; font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; white-space: pre-wrap; margin: 8px 0; background-color: #f8f8f8; border: 1px solid #dddddd; border-radius: 4px; padding: 8px 12px; font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; white-space: pre-wrap; margin: 8px 0">diff --git a/block/mirror.c b/block/mirror.c
index b344182c747..f76e43f22c1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1122,6 +1122,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
      * accessing it.
      */
     mirror_top_opaque-&gt;job = s;
+    if (s-&gt;copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s-&gt;dirty_bitmap);
+    }
 
     assert(!s-&gt;dbi);
     s-&gt;dbi = bdrv_dirty_iter_new(s-&gt;dirty_bitmap);
@@ -2018,7 +2021,9 @@ static BlockJob *mirror_start_job(
      * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
      * mode.
      */
-    bdrv_disable_dirty_bitmap(s-&gt;dirty_bitmap);
+    if (s-&gt;copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s-&gt;dirty_bitmap);
+    }
 
     bdrv_graph_wrlock_drained();
     ret = block_job_add_bdrv(&amp;s-&gt;common, "source", bs, 0,</pre>
    <p><br>
      Running this for some hours already, and it seems to fix the
      issue.<br>
      <br>
      Let's open up the discussion if this is the proper way to fix it,
      or if there are better alternatives :)<br>
      <br>
      Thanks<br>
      Jean-Louis</p>
  </body>
</html>

--------------rNZ0YjKLqMmghUrjyvexC3nz--

