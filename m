Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C44606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QNT+v22j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm3B-00078w-96; Fri, 30 Oct 2026 08:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm32-00077s-NS
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm31-0002UA-3C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793364569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS1Vs66HqtKSaov/RYo63zm40zce9WIeUJ0+0P8Gt70=;
 b=QNT+v22jE/w3tAxYLJyj2DYiqz5Z3u1b4u8pzlBRDS2Pk+6kDS7/1Sh/mlbDPvrys+SOKH
 6Fh9mXHYYYCCBft+LWbtYrpCfvFsSSgxzUgHkbCsrlAzXgr7rXYNPQYEKIBH1L43W5qOIH
 ii0t0S+3SiZeD1uckplCyC1pCzjm6D0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-8uVzZKDmPg28f8rkEjA35A-1; Fri,
 30 Oct 2026 08:49:27 -0400
X-MC-Unique: 8uVzZKDmPg28f8rkEjA35A-1
X-Mimecast-MFC-AGG-ID: 8uVzZKDmPg28f8rkEjA35A_1793364567
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA5C5180058F
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:49:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 075AA195608B; Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/8] qapi: add 'warn' option to CompatPolicyInput
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20261028133603.1893289-3-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-3-berrange@redhat.com>
Date: Fri, 30 Oct 2026 16:49:21 +0400
Message-Id: <179336456126.3884549.17845152643994856593.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OhqkZ1b3hiAUgc19nR5r2GVHtSRhUlQO+9cxGFN13YM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5JJS8xyw0Bd30HSfypWSgdD4lPJM6E1FN5XUx
 NPUIgv4qCOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauSSUgAKCRDa6OEJdZac
 5WrkD/wPNKOKcTWAYb+Sr5Eq80FTAzvc/DnGP0DwB1wBXO3d7bG30lQIKxmMliLDfpeMWg7neMz
 dg+A7gT5+0oLpSwueypkbMpWP+5XKyFZtNGnSBUKkY3nd7lCHBd9JNmajUFg1WfrsQ8aAOmLD+K
 snNc9G2utSuF1cOCxEdyWvbO8hUqeOlXEF592Zk0d/e1u6JIFrDBq//qQ1+7ZDxPlFylBi/q8iA
 IR/pzjatzjIfp2JM2+D6cnIi8Ouk8MjdDxlfM3hNuk8tLMgGubbx8zvtzLeA5HC+I13xuIaXktg
 VTtb3s3e+3Fn8mnDC9mB4rxUrOMUQp7DpSAoc5scNfm9q5JIC53FDtBM1m4nGIw+KkUduxXSanS
 78DwHXG/xIY0beBsl/thWxnSx9SzWMpR9SL8XdzHqaEB09AZ2YJb2SXadp8uI4/ibIoQx3vhLGQ
 EqnOHShu3/BR7JgrrGMqsd3QAHYpn1fT7qAO8m+3T6fS8hBHVJRWBNV9Y/qBMYarEewQ8aj5P5a
 4zMoRsPf6mXTiNXAyQQjtiMYmKdzAWuqf2A7vUm8kXjTXp4s/gp4GEBjt/eiM2u3hBwHWF2iF8/
 fFvJhvpZe2SGLSyDMTxyATDv0hD5scg4rJ7UJQ98f/PvNvY+e+VCFiCEaeGB3xNa8LSvUUhy3pa
 qSiwJ0pmjRLOn2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This prints a warning on stderr every time a policy violation
> is encountered, but accepts the input.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261028133603.1893289-3-berrange@redhat.com>
> ---
>  qapi/compat.json |  4 +++-
>  qapi/qapi-util.c |  4 ++++
>  qemu-options.hx  | 12 ++++++++----
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/compat.json b/qapi/compat.json
> index 0f90ea1f5241..dfa3fea05778 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -17,10 +17,12 @@
>  #
>  # @crash: abort() the process
>  #
> +# @warn: Accept with a warning printed to stderr (Since: 11.2)
> +#
>  # Since: 6.0
>  ##
>  { 'enum': 'CompatPolicyInput',
> -  'data': [ 'accept', 'reject', 'crash' ] }
> +  'data': [ 'accept', 'reject', 'crash', 'warn' ] }
>  
>  ##
>  # @CompatPolicyOutput:
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 93898f57a055..f81a171a5b16 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -28,6 +28,10 @@ static bool compat_policy_input_ok1(CompatPolicyInput policy,
>      switch (policy) {
>      case COMPAT_POLICY_INPUT_ACCEPT:
>          return true;
> +    case COMPAT_POLICY_INPUT_WARN:
> +        warn_report("%s %s %s disabled by policy",

rather: "Deprecated %s.. accepted by policy"?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


