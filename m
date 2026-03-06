Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7112FCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ4a-000599-5K; Fri, 06 Mar 2026 12:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyZ4V-00058s-7c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyZ4R-0004ub-3F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772818477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UdmMq58TJaQQ0THEKXyT3Ga+qmrGCeydNatkV9xIxfg=;
 b=gexPKEIF/T0QUtXVj0DGacpNNdgajnoqQ0Utgr2m2lymxVP5a0yLNRYAocoGHVEDIQUJkH
 whWaEalEAcytcbYKrtxh73/jyhMt/MQ/2WqHwDnBdfjNcsycMR5SJJJCdxsBnhw4WuQK9c
 FGO32ktGatN6LWTGWkeumyFt8+sWEdg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-HjT03ExLPPGKaV0O0pauIQ-1; Fri, 06 Mar 2026 12:34:36 -0500
X-MC-Unique: HjT03ExLPPGKaV0O0pauIQ-1
X-Mimecast-MFC-AGG-ID: HjT03ExLPPGKaV0O0pauIQ_1772818476
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-506c0231e63so831958301cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772818476; x=1773423276; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UdmMq58TJaQQ0THEKXyT3Ga+qmrGCeydNatkV9xIxfg=;
 b=KOFpOYnIzGCHnJ4PsQ/gF2F+aokUD2XdABmDsBHjLA8HULVBu3LmMPD3eyEnzyLlkQ
 i/29yuj0LLDVK1xIW1wi5WGZxJu3o+ULVfnR0aG6rB9Lvp2YIUnMnC3kriSwQgtGNHlg
 kh0nYKrg1x4yUUN8NlkcN3oXV5FhrgpKF567ei05s8ySD2PDdQPnwQoO0j91urDxSmOJ
 x+wbqdRWBoKa2HE3IcFKYn3n3fgf7yyC9X2B7YivcNaCjV86gK90K6EY5f9a8Br4jXqt
 gxB8uxB2Z+JTN1N6rBI1jYH9C1QHGj0f5Zx2uDlcU4+43KLg9tvUCXlNvcHBPdurG7v1
 3uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818476; x=1773423276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdmMq58TJaQQ0THEKXyT3Ga+qmrGCeydNatkV9xIxfg=;
 b=M9JLw1TARwVoKZCL4HLr6Z0o81Ac8VLsP169/yYkVaXEJktQnxStddwooAtjOQPkpv
 7QX/2Z0yfpXXDEcRe2Nk2xjg9wQUlWZMkT2K86ohXMKscEAyzRw+lhwKqZBApM2NOpYb
 gK1b7gQIULuL8bgO6yJRGmNaVUfHzZxNj2etuV6v23UGssnzSWkJImpu1zp5+eiOju2F
 sp/xkBbz48knvvl2k3ECq97G4piSI9zTwYuQIXBbkrYOu9XFuJCydKp/ghwKTW07Ewnw
 v6j+XTD3CvrtZNMbU84q4mDUb5BY4ifNgCAuXFnDfqocOuEAcXboM5vtfmR8GTPJJ/UD
 6vcg==
X-Gm-Message-State: AOJu0Yz7d2W9/gWX58p6Jl8GvKWeuvzB8244Wp/8bBJdg37lqfSglgct
 eBo7rD1wYn/PMY4lvT6JzVumqNlmwwEQnUm3JP+YK95MU9k02FVIF5gIN9r883LcTb3pdU90H+v
 c90On6VUe1PCfgSwjiM9q2bu9DwLIEyd+9s9CK67qJvSGopVoiblCtgiK
X-Gm-Gg: ATEYQzywDjGKzn8WS5fUBj2+XtI5XTxwYW8Y6OznwdCOlLl7NGfy/fPVqAVpk+r3sm4
 W0ypL3j2Xxau1S6nQ1NOSAz/Bfdca5qWlmaqCVhCgO0/ogngNk+e/NEabTwRG7yD8pX9tIuOD/h
 hZwR4Q+pT/i2YTkyLD/PWyYOMHMkn7vdtfMN75oH0YARoxV1GWloPIrEnoWSiT7fKMJO+O7preh
 SIyC5e+jLMZEBnDMdLRS+f1Ty50I9Ap2g8QkQGbeKn7aYzcBb1l+72rrPT9kafMXz3R5Fh2UNlv
 bHFYeNm2Lgyrm8s/wxsw8iM6T1BV3II8q8KMGdPUQuU1QSeZQdOuydK8S9L0H1mrqKItHpUU0o/
 WVgG0yGox/xuizBbc9B/q3ffLsloPNrfbnGhzYf6lFR6aUOYWkMGwm67oAfASz3tVUQ56Db5/hQ
 EBRyZ8+Q==
X-Received: by 2002:ac8:5a96:0:b0:4b3:8ee:520c with SMTP id
 d75a77b69052e-508f4b17dc2mr33113481cf.19.1772818474159; 
 Fri, 06 Mar 2026 09:34:34 -0800 (PST)
X-Received: by 2002:ac8:5a96:0:b0:4b3:8ee:520c with SMTP id
 d75a77b69052e-508f4b17dc2mr33113041cf.19.1772818473577; 
 Fri, 06 Mar 2026 09:34:33 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f651149fsm17690551cf.2.2026.03.06.09.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 09:34:33 -0800 (PST)
Date: Fri, 6 Mar 2026 12:34:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, farosas@suse.de
Subject: Re: [PATCH v1 1/1] io: avoid false zerocopy missed accounting on
 empty flushes
Message-ID: <aasQKAlYOmnbqzIF@x1.local>
References: <20260306055121.3277731-1-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306055121.3277731-1-tejus.gk@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 06, 2026 at 05:51:17AM +0000, Tejus GK wrote:
> qio_channel_socket_flush could return 1 when no new zero-copy send
> completions were queued, which incorrectly inflated the
> dirty-sync-missed-zero-copy stat. Fix this by returning 0, when there's
> nothing to flush, similar to what qio_channel_socket_flush_internal
> does.
> 
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> ---
>  io/channel-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..6f647e471b 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -895,6 +895,10 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>      int ret;
>  
> +    if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
> +        return 0;
> +    }
> +
>      ret = qio_channel_socket_flush_internal(ioc, true, errp);
>      if (ret < 0) {
>          return ret;
> -- 
> 2.43.7
> 

This looks fine (weird to explicitly check this while the _internal check
it again), I have a major confusion on this zerocopy statistic counter.

Right now, as long as there's one successful zerocopy happened, the whole
batch (before a io_flush() collecting the result) will be marked "all IOs
are successfully zero-copied".

AFAIU, that may not always reflect the reality even if no fallback
reported, instead we do have finer granule results ready when flushing.

Instead of fixing this report based on an already inaccurate stats, shall
we make this stats more useful?  Say, report all fallback IOs happened?
Then if it return 0, it solidly says ZEROCOPY fallback never happened.

Something like this?

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a1ef3136ea..e3c8ad4320 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,12 +49,9 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    /* Record how many ZEROCOPY requested IOs fallbacked to copy */
+    ssize_t zero_copy_fallback;
     bool blocking;
-    /**
-     * This flag indicates whether any new data was successfully sent with
-     * zerocopy since the last qio_channel_socket_flush() call.
-     */
-    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437..12aecb327f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -1013,13 +1013,12 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
  *
  * If not implemented, acts as a no-op, and returns 0.
  *
- * Returns -1 if any error is found,
- *          1 if every send failed to use zero copy.
- *          0 otherwise.
+ * Returns -1 if any error is found, otherwise return a non-negative number
+ * of IO requests that got falled back to copy.
  */
 
-int qio_channel_flush(QIOChannel *ioc,
-                      Error **errp);
+ssize_t qio_channel_flush(QIOChannel *ioc,
+                          Error **errp);
 
 /**
  * qio_channel_get_peercred:
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..cb6a82324d 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -71,8 +71,8 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->zero_copy_fallback = 0;
     sioc->blocking = false;
-    sioc->new_zero_copy_sent_success = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -880,9 +880,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            sioc->new_zero_copy_sent_success = true;
+        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
+            sioc->zero_copy_fallback++;
         }
     }
 
@@ -900,12 +899,7 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         return ret;
     }
 
-    if (sioc->new_zero_copy_sent_success) {
-        sioc->new_zero_copy_sent_success = false;
-        return 0;
-    }
-
-    return 1;
+    return sioc->zero_copy_fallback;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
diff --git a/io/channel.c b/io/channel.c
index cc02d997a4..5e7c3a8968 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -572,8 +572,7 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
     return klass->io_seek(ioc, offset, whence, errp);
 }
 
-int qio_channel_flush(QIOChannel *ioc,
-                                Error **errp)
+ssize_t qio_channel_flush(QIOChannel *ioc, Error **errp)
 {
     QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688f..d0a4213f8d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -593,7 +593,7 @@ void multifd_send_shutdown(void)
 
 static int multifd_zero_copy_flush(QIOChannel *c)
 {
-    int ret;
+    ssize_t ret;
     Error *err = NULL;
 
     ret = qio_channel_flush(c, &err);
@@ -601,8 +601,10 @@ static int multifd_zero_copy_flush(QIOChannel *c)
         error_report_err(err);
         return -1;
     }
-    if (ret == 1) {
-        qatomic_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
+    if (mig_stats.dirty_sync_missed_zero_copy != (uint64_t)ret) {
+        /* Update statistics if more fallback detected */
+        qatomic_set(&mig_stats.dirty_sync_missed_zero_copy,
+                    (uint64_t)ret);
     }
 
     return ret;

-- 
Peter Xu


