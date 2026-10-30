Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0560A2612
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9A03jpi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm3Q-0007Aa-Ir; Fri, 30 Oct 2026 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm3B-00079S-LZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm3A-0002Uu-1S
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793364579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZECRCFScc31MnolJPB4YngeRdDNQ4PeV7nyf616DI38=;
 b=Z9A03jpirIyee7yFXGllVnee0dLxqY9XRZLlNYmb2bK7bQdwlkzX+f6Z5S0I2KydJB6Z50
 ECAMQgwC6iHeUB1+xpiSZ9ZnYYbVYUQFEMr6TmaNUdl+V5r13KDhPCAAF5dG2Eei54FXWQ
 QwWkz2P70oq29vTQuePWBDS+y5DZhqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-9CQwAK8SMPeDNg9X2KslUw-1; Fri,
 30 Oct 2026 08:49:38 -0400
X-MC-Unique: 9CQwAK8SMPeDNg9X2KslUw-1
X-Mimecast-MFC-AGG-ID: 9CQwAK8SMPeDNg9X2KslUw_1793364577
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2016F1955F04
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:49:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50F5626C; Fri, 30 Oct 2026 12:49:35 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 8/8] qapi: print a message before aborting for -compat
 violations
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20261028133603.1893289-9-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-9-berrange@redhat.com>
Date: Fri, 30 Oct 2026 16:49:21 +0400
Message-Id: <179336456127.3884549.4095013107698184645.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5agvl5GM2uTEU90FgxyMCQ2dJ8IeuikE4VRtOv6JU3Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5JJT0xxntFIVj27U8F5PM/48Jy9ham1q96OBg
 Ga20VU+7lOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauSSUwAKCRDa6OEJdZac
 5SaiD/93uaC5JCxLISsRmCSEeLUG2GlK9/V52I7blHls2t4CsoV4e/01/t1xd2USPOgt5EVw2Zn
 7ciTCRuzwMsnUou7SVhbrl9aIj+IDzZsC+foqrv2bfB3B0c7m//LaPcv67mzMDw1azPapDm1mqD
 KIr8se8zcynGl4OZDmfU/x2h4c2QvcH8mKrErkT/v8spMHjp0HSq20PKCb/F6p2YAGiqqS0exw0
 1yLi4YiBH8qHlHNdtvyuVhwFyJjHeTEVBAXxtGmbpREhNTEz9A1ihaPp4YaN9rtyczCrqLFP1Fv
 2icnp+Hw3pMOEhxQKYQH4SngzwGcdrB10j8KJ//C2ekw6+uvCj8PcFxMjaJgJZ0NOdWLQ8vzDlE
 vJ0hNi1VVV2W1+mqoDzV93nFq+TWwbp2mjV1ru5mLd+vqF1r2/jUSjpGj/P6z1jfPfjMdTYq/6S
 xf1S5/poWrU3BxTYFNL6EiXK7iO7oETeIKl9wu1bx1QRikHhmR0S09nyHHo5iaemsx0p7ACzE6N
 eVdWAdHPl9RUcXKXSWw4kRSGThjRCzakjH5mbRFiBWp2/HP8nY+jbi6Jwj5wt7Cn0SwBK3X2bn+
 vuQ3FXPAGG7DTV5fwJNVIdVBnpDMAd7jnzvZs5fHny5fsBhG/q/UaX2j/fk8C3pUlHfq+EXZjEJ
 T1ZqIeI0RmLA+vQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> When using the 'crash' policy with -compat options, QEMU will
> abort() on a policy violation. All the user sees is a core
> dump though and while the stack trace will ultimately show
> what the violation was, it can be hard to reverse engineer
> the cause when variables are optimized out. If the crash is
> within a CI system, it can be even harder to determine what
> the cause was as a core dump may not be available.
> 
> Printing a message when crashing is easier to diagnose when
> limited context is available.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261028133603.1893289-9-berrange@redhat.com>
> ---
>  qapi/qapi-util.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index c845cadbdf2f..1141813747b4 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -37,6 +37,9 @@ static bool compat_policy_input_ok1(CompatPolicyInput policy,
>                    adjective, kind, name);
>          return false;
>      case COMPAT_POLICY_INPUT_CRASH:
> +        error_report("%s %s %s disabled by policy, aborting",
> +                    adjective, kind, name);

miss-aligned

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


