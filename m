Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4222C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Dya-0008BS-6I; Thu, 03 Sep 2026 16:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2DyX-0008B5-Pk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2DyW-0005UY-B7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788467035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9WpAsEyMX60QmRkt1IUM/7ssHFgraRG3wipDklm4lE=;
 b=KNFmazoJ+PO9NVTHbnPui2nJkUA6ac6DehBMPD4+0OQ1tpLA34ARayGVnY7hBhknX4LIO1
 7JS867eWE1hHEqhmoE/qtUHG9MsCAyHUFSpYRgtLgX42BElpazs+D/DZ/qt8vF7Q0eR9TH
 8klNQpkB4wnUdp3tJe50AkFBHxhAaFE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7_cZxc6KOyaXL0aIMGnWvQ-1; Thu, 03 Sep 2026 16:23:54 -0400
X-MC-Unique: 7_cZxc6KOyaXL0aIMGnWvQ-1
X-Mimecast-MFC-AGG-ID: 7_cZxc6KOyaXL0aIMGnWvQ_1788467033
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90cc934fe9eso5197316d6.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788467033; x=1789071833; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c9WpAsEyMX60QmRkt1IUM/7ssHFgraRG3wipDklm4lE=;
 b=RCxomJOUbn62+OLIQOGynG022ys+lrDLnxy1+xaZ/Jzfnvp6VijuMPfD6j/ZKmLv6k
 re2YWb9PQk9prTq2DUvL8rgBYtAvpRiOkl441HMyAnWCL71GSoeZheKh1OIXNim+AUus
 zoH8ncZca/7ZlrWl1Gw0zR7kUKBe69+Z4ZykJdCoTjwVri4Oc9XGEnUCaslzcJd4iJmE
 vxZhHsmdO9FJ+ybg6vHPNtYgz1tJO82+tVmBX47oLjxYSY7x3VH7he4XjParvoeTvW2s
 kk1GtaRWNSbmr/6B2sLRCMYvZbOVfG1W0+GAbju421NcgCpiySzlGJ47/a8r2v/LvV1B
 AGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788467033; x=1789071833;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9WpAsEyMX60QmRkt1IUM/7ssHFgraRG3wipDklm4lE=;
 b=AJXwMUu8yaTPcewr468WdO6ASfeZMh/bX4oy+Cv819V4egpcpK4LwKxed1NqAWhXBr
 t2+RMAIUmwzCdttn0WitbWjKoJw4Wx+hdN7khwjo/u1eJu5bZjOGSVDntIp6e5Wxro/i
 Km4T1l06gffhSAmmC247wvr4cd5oqyc45XB4HzWN4vQhfYSCuort9auiV2buaVbd2/SP
 WBDaEWnwWar8IW7AtAd0vgXUK6ATIkpMYPrdctggxZZerIec7DZC0L6UpG2yFiDgOXLV
 TzF+S/AW8UcyWvNmCZF2Ih21kENdd7L1iAxyffZbjS16kSifOpOUoQ5T0/K8vjUR5wKo
 uRHg==
X-Gm-Message-State: AFuF++mN8/75M6oXo1Nqq2ER1gnVn6da1rh64E+miiiibffpt3gqzLEy
 tnpFkelpEKCKCTY7GvSe95957SRA7YWdNaWH7gBygSargX0kldTr5gR7OGComzttwRlM3gQ4JZ8
 A3mvejB93lzJ056DTk6GesO56EGRTFi3eK7RVtkzofvFKWU/sp/nxhfqp
X-Gm-Gg: AYBFou3oJKYKpR1u9qQe6IoDhJWSUXrpK/JgFvRwK8NhmbcRV94TtFS1Fwo8+qXZ0sC
 O3IEstdyvq/+p/p74jT9un6kRPSbkIjZy4m8pRP9QQMTj6dE6m9o/ZFSqnRQEjk852DG7jfscvP
 Whm6JPhC+tK0uTMMnt3JxhppEdskSKGN5T0r6xva2g2C2PYifS5pz2vfI8siEgPaknY+CGebErv
 LZ7Ol3W3NBExEh+Vogy2j1ndeWxvLbDqVGTuCLuAbH1jSD0AGK1sd0a5/5WqVPbGfui0cGbonQ4
 fft8Ar2w5nQ++YL6rrXswYjow6lduQWQgkTJXiArFLUrwXOFT8SbuEW0en5Yp/Ycvmp30rauoCd
 efB7TvwpYpBQhUYcVOS4Pq03JG0Nc90swvMw/cyOeXGJC2vD6LpUlTGQCmyo=
X-Received: by 2002:a05:6214:62d3:b0:90e:8356:9bd8 with SMTP id
 6a1803df08f44-9103ef16b49mr21656976d6.11.1788467033424; 
 Thu, 03 Sep 2026 13:23:53 -0700 (PDT)
X-Received: by 2002:a05:6214:62d3:b0:90e:8356:9bd8 with SMTP id
 6a1803df08f44-9103ef16b49mr21656426d6.11.1788467032833; 
 Thu, 03 Sep 2026 13:23:52 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406475f5sm2923656d6.9.2026.09.03.13.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:23:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:23:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 14/18] migration: Rewrite
 migrate_set_parameter_completion using QDict
Message-ID: <apnXV6GYMo2cXtFa@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 02, 2026 at 07:15:42PM -0300, Fabiano Rosas wrote:
> The migrate_set_parameter_completion function is the last user of the
> MigrationParameter enum. Write the code using an output visitor and
> QDict instead so we can remove the enum in a future patch.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index dff69650a0c..d0adda25090 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -791,14 +791,19 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
>  void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
>                                        const char *str)
>  {
> +    g_autoptr(MigrationParameters) params = g_new0(MigrationParameters, 1);
> +    g_autoptr(QDict) d = migrate_params_to_dict(params, NULL);

When I played with this branch a bit then I found set_parameter completion
broke, then I found indeed the prior test didn't add set_parameter
completion test.. can add one too.

Here IIUC d is empty dict.  One possible fix:

--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -787,19 +787,19 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
 void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
                                       const char *str)
 {
-    g_autoptr(MigrationParameters) params = g_new0(MigrationParameters, 1);                                                             
-    g_autoptr(QDict) d = migrate_params_to_dict(params, NULL);                                                                          
+    g_autoptr(QDict) d;                                                                                                                 
     const QDictEntry *e;
     size_t len;

+    /* Temporarily borrow the global parameters */                                                                                      
+    d = migrate_params_to_dict(&migrate_get_current()->parameters,                                                                      
+                               &error_abort);                                                                                           
     len = strlen(str);
     readline_set_completion_index(rs, len);
     if (nb_args == 2) {
         for (e = qdict_first(d); e; e = qdict_next(d, e)) {
             const char *key = qdict_entry_key(e);
-            if (!g_str_has_prefix(key, "has-")) {                                                                                       
-                readline_add_completion_of(rs, str, key);                                                                               
-            }                                                                                                                           
+            readline_add_completion_of(rs, str, key);                                                                                   
         }
     }
 }

> +    const QDictEntry *e;
>      size_t len;
>  
>      len = strlen(str);
>      readline_set_completion_index(rs, len);
>      if (nb_args == 2) {
> -        int i;
> -        for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
> -            readline_add_completion_of(rs, str, MigrationParameter_str(i));
> +        for (e = qdict_first(d); e; e = qdict_next(d, e)) {
> +            const char *key = qdict_entry_key(e);
> +            if (!g_str_has_prefix(key, "has-")) {
> +                readline_add_completion_of(rs, str, key);
> +            }
>          }
>      }
>  }
> -- 
> 2.53.0
> 

-- 
Peter Xu


