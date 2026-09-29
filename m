Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21522CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZu0-0000fP-BY; Tue, 29 Sep 2026 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBZtw-0000ct-RZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBZtv-00006F-9r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790696268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANtWg8ssZSvcEs0bR+iMkHkoanm7jn2HHVkKYP4Xp6Y=;
 b=d3iz4eyJv9vMDofXCYf20P5N6iUAbOp6Zjco7u6/HXVAYIPmYKxzXCrgIG/YRFwFttdT+w
 1RzQgu4unsTyqiagTYXTD0fTOMkP10YvwC6CWpyTYvn3iAhgJppaY9QqzK4kjtQnzCHdRx
 w5MJb2dGQHBoIu8DjOU6i2bGcdZYLDw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-q899D7uFNyKIj0c-fqyMTA-1; Tue, 29 Sep 2026 11:37:46 -0400
X-MC-Unique: q899D7uFNyKIj0c-fqyMTA-1
X-Mimecast-MFC-AGG-ID: q899D7uFNyKIj0c-fqyMTA_1790696266
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so1057098585a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790696266; x=1791301066; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ANtWg8ssZSvcEs0bR+iMkHkoanm7jn2HHVkKYP4Xp6Y=;
 b=RX9wICI6pqq47h+P+ADWk5i4XgBGylPliyHfx9V0TzEc5NAxzpWV5YCP5K58UVkCMP
 HQAM0HlkMcErqBYEpRKzFiJrAoCjYEivDTMzKQMwsaLsiUiZKEoMUqFpPtI24SKoC+Sn
 dAPM3JR/kbNIuallnp/v1h3Hy+3OlgWnHr69XAxxMmWM/KmAJKI5NPMAw7cNYa/uPlxB
 YsC1psys+F+LPJX333OQs0Kp0Z8KkoDPaGnpAYVFsSNqi2M0odSxivbRG120n7rhlAvh
 oyiWANDW/LGH/vNbzbvl63f98RBn66qBLw/gaih+itqbGN2IdazkATRxR9iKq+2b6eQM
 Lg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696266; x=1791301066;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ANtWg8ssZSvcEs0bR+iMkHkoanm7jn2HHVkKYP4Xp6Y=;
 b=Lw/Z4mGxE1TdN85hL/hIzu0ESxcT9k01736JfmoktT2X9UBAu1xJM1kVvaS2mLNCHk
 rDM2aBMihpi3VIK5qFr9osj8RUQGq5Y1Kt1pJdPdvGMuQW5Yj1S42qjg7zqD4SFnzW3o
 BRTwHKjrC1v2Gxm4NebeR3//9pmA/aqRWn5EV3bSjko+fBToGh9Pk7Pm7ex435pt2zG6
 HuysghwgkfvN9csh3XFIywuXZ4zBtZvcn7LoBXubBO8C5ooA9E/Z7bke7qeNNo4ZofNK
 eBJ/Ea95OhcZERiG154uSuPiLVsMWWOLXdMZxG3ET6E7TL7Wz3QMxU3BFbTsrF7unJvT
 FTpQ==
X-Gm-Message-State: AFuF++ml5XpEfLeYfpr4lS2D0Siovf98T7oLCqkL7u4w0USv78v0jXNU
 PfBiEzc+vhaLnC2RSl3pW5veL7AtfNb2ZPckW7QSYrcAbMWASSD2GC8PQeDefmDQ0FtiyUuz5Cf
 jzuh/Qoz64jzV54LIoIBa1wqe7zlgILXREFG0VwXoKJcvSGO2+RVpBuUu
X-Gm-Gg: AYBFou1p2J860IlqbiIdCGwBmoIBoS/I9juJda9iTii+Dfz9lKT2Hgh9JReEpE7796t
 u1jmVLqii0TVJp58Q8YgbEWMUCAYrFdz7eTkssezDWL3DIClaelOnQwSBfQ1eqL2wegE77y3bsT
 ynlC6EA5OLo3LK4qSHYlMxtI6m8TWOFEzFl4sdZCtiZCuAfumjEj7t1Xpjs3pAG1HNHPOZk7eCT
 NhuF0JxCB0CHzV8w4ZiKWDAw2jxf6cHczoGp+3GFId+QZLiR4QobAIH7SNOpXV41B6FeFCOfCTD
 aHOqvAP1bm9rBME8HUmz7vIdOfajirgVAY/FuRV30yB9nQisIymxlfrYc/BOCfp6sGaH6ls=
X-Received: by 2002:a05:620a:444c:b0:939:9edf:edb7 with SMTP id
 af79cd13be357-93c43cc7d46mr2763102985a.6.1790696265770; 
 Tue, 29 Sep 2026 08:37:45 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:939:9edf:edb7 with SMTP id
 af79cd13be357-93c43cc7d46mr2763097285a.6.1790696265222; 
 Tue, 29 Sep 2026 08:37:45 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813fee09sm416498985a.24.2026.09.29.08.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:37:44 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:37:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 den@openvz.org, sgarzare@redhat.com
Subject: Re: [PATCH v7 01/16] migration/cpr: forbid saving duplicate CprFds
 into hash table
Message-ID: <arvbRylSxww1824g@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-1-6ef9ef033c35@virtuozzo.com>
 <arp4-P14_JP_-ABU@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b4b8545c-18f4-47bf-9182-a326f8a9136e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4b8545c-18f4-47bf-9182-a326f8a9136e@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 29, 2026 at 04:28:19PM +0300, Andrey Drobyshev wrote:
> > But I do see the existance of cpr_resave_fd().  I confess I don't know why
> > it existed and didn't check.  That looks exactly like sometimes we can save
> > the same fd twice, if the 1st one is fd=-1.  Any quick answer?
> 
> AFAICT the sole purpose of cpr_resave_fd() is to be called from
> different sites with the same (name, id, fd), to make sure the key is
> registered in the table.  What it does:
> 
>   - no entry - save it into hash table;
>   - same FD already there - do nothing, table isn't updated;
>   - different FD present - abort as an internal error.
> 
> That means there's no case of injecting the same (name, id) twice into
> the hash table.  That is actually consistent with our patch here.
> 
> I'd leave the code as-is and only reword the comment, if that's fine
> with you.

The whole cpr_resave_fd() API is confusing, I still don't understand why we
need it: we should make sure the fd is always properly inserted, and only
once somehow.. but I agree it's not an issue for the current patch.

Said that, for this patch, IIUC we still should need something like this:

diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf3..d26656c5c1 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -173,14 +173,13 @@ int cpr_find_fd(const char *name, int id)
 void cpr_resave_fd(const char *name, int id, int fd)
 {
     CprFd *elem = find_fd(name, id);
-    int old_fd = elem ? elem->fd : -1;

-    if (old_fd < 0) {
+    if (!elem) {
         cpr_save_fd(name, id, fd);
-    } else if (old_fd != fd) {
+    } else if (elem->fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
-                     name, id, fd, old_fd);
+                     name, id, fd, elem->fd);
         g_assert_not_reached();
     }
 }

Otherwise at least from API level some user can inject one fd=-1 entry,
then resave fd with something else causing cpr_save_fd() done twice on the
same (name, id) index, triggering the new assert.

Thanks,

-- 
Peter Xu


