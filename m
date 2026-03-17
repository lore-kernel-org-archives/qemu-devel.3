Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CCBFD8769
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UYZ-0003l5-Oa; Tue, 17 Mar 2026 09:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crichez@pm.me>)
 id 1w2UYU-0003kn-L9; Tue, 17 Mar 2026 09:33:55 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crichez@pm.me>)
 id 1w2UYS-00063P-8D; Tue, 17 Mar 2026 09:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773754417; x=1774013617;
 bh=1xhhgeIBXKPFrSnKhC6zJwpYXfa1l5FyaWY1y36wj9E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=UpnmH9mr6t2rMLt4BxUZcWU5EuQRa2Ln9L+UdmJdQmbHuYUdLBh4mIwc9NB/6LfUf
 Vj9C8r9K3TZ9CYvOuPrdR0Xoltc3U7AYaklvaAPYg9DdKrGDeCk4RGp3Q0w9VhobHU
 UpCQDj7sJ+4EP1fZdL5HWbr8EF1CBHk8exYEEu4eqgzRWLNKkDx9/6l7wZyTA3hu1i
 kscbStxnN2s3oovKPczUmxqdh7UEYXypSSRHW9seoeHKOP7j8T+MIFZHmFEaI4siET
 5bOQS5+tD0UzGFPDTWYL7kwqJ1KsgDVX9wZorBBR4yE1byrIxE8ZxJLTLjSS2VjIFD
 HOqqEK7R+0xqg==
Date: Tue, 17 Mar 2026 13:33:33 +0000
To: Michael Tokarev <mjt@tls.msk.ru>
From: Christopher Richez <crichez@pm.me>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC] net/slirp: allow hostfwd socket paths with dashes
Message-ID: <LDF3Kn5e3KSxpz1TFKB-WC_CeVNvAHtN8FIyWxtsKo6SaMelBeuSVbA7sMg5bx0VsCapFjpDG5z7Iqg9-bB1zCIYOO7O2MzThgv5GGOaU7s=@pm.me>
In-Reply-To: <20260317083108.163043-1-mjt@tls.msk.ru>
References: <20260317083108.163043-1-mjt@tls.msk.ru>
Feedback-ID: 5960063:user:proton
X-Pm-Message-ID: 8ee55c3d1c70948c367efd84a8e3afff55af5d38
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45; envelope-from=crichez@pm.me;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is much neater than my patch for this, thank you for taking the time t=
o do it this way!

-------- Original Message --------
On Tuesday, 03/17/26 at 04:32 Michael Tokarev <mjt@tls.msk.ru> wrote:
The format of hostfwd parameter is:
  hostfwd=3Dhostpart-guestaddr:guestport
so a minus sign can not be part of the hostpart.
If hostpart specifies a unix socket path, this becomes problematic.

To solve this, look for the LAST minus/dash char in the string,
not first.

Unfortunately, [-guestaddr] is optional (defaults to 10.0.0.15),
so we still can't parse the thing in an uniform way.

Extend get_str_sep() to accept one more parameter, to indicate if
first or last separator is needed, and modify all callers to ask
for first separator.  Update slirp_hostfwd to search for the last
separator when parsing unix domain socket path.

Inspired-by: Christopher Palmer-Richez <crichez@pm.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/347
---
 net/slirp.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 04925f3318..804d430890 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -49,12 +49,18 @@
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"

-static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
+typedef enum {
+    SEP_FIRST,
+    SEP_LAST
+} sep_type;
+
+static int get_str_sep(char *buf, int buf_size, const char **pp, int sep,
+                       sep_type which)
 {
     const char *p, *p1;
     int len;
     p =3D *pp;
-    p1 =3D strchr(p, sep);
+    p1 =3D which =3D=3D SEP_FIRST ? strchr(p, sep) : strrchr(p, sep);
     if (!p1)
         return -1;
     len =3D p1 - p;
@@ -479,7 +485,7 @@ static int net_slirp_init(NetClientState *peer, const c=
har *model,
     }

     if (vnetwork) {
-        if (get_str_sep(buf, sizeof(buf), &vnetwork, '/') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &vnetwork, '/', SEP_FIRST) < 0) =
{
             if (!inet_aton(vnetwork, &net)) {
                 error_setg(errp, "Failed to parse netmask");
                 return -1;
@@ -760,7 +766,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdic=
t)
     }

     p =3D src_str;
-    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }

@@ -772,7 +778,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdic=
t)
         goto fail_syntax;
     }

-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
@@ -827,7 +833,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)
     socklen_t host_addr_size;

     p =3D redir_str;
-    if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (!p || get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         fail_reason =3D "No : separators";
         goto fail_syntax;
     }
@@ -848,7 +854,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)

 #if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
     if (is_unix) {
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_LAST) < 0) {
             fail_reason =3D "Missing - separator";
             goto fail_syntax;
         }
@@ -888,7 +894,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)
         host_addr.in.sin_family =3D AF_INET;
         host_addr.in.sin_addr.s_addr =3D INADDR_ANY;

-        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
             fail_reason =3D "Missing : separator";
             goto fail_syntax;
         }
@@ -898,7 +904,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)
             goto fail_syntax;
         }

-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_FIRST) < 0) {
             fail_reason =3D "Bad host port separator";
             goto fail_syntax;
         }
@@ -913,7 +919,7 @@ static int slirp_hostfwd(SlirpState *s, const char *red=
ir_str, Error **errp)
         host_addr_size =3D sizeof(host_addr.in);
     }

-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         fail_reason =3D "Missing guest address";
         goto fail_syntax;
     }
@@ -1125,19 +1131,19 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str, Error **errp)
     int port;

     p =3D config_str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (strcmp(buf, "tcp") && buf[0] !=3D '\0') {
         goto fail_syntax;
     }
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, ':', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     if (buf[0] !=3D '\0' && !inet_aton(buf, &server)) {
         goto fail_syntax;
     }
-    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+    if (get_str_sep(buf, sizeof(buf), &p, '-', SEP_FIRST) < 0) {
         goto fail_syntax;
     }
     port =3D strtol(buf, &end, 10);
--
2.47.3




