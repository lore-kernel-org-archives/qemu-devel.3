Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D71606A33C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqFq9X5d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm41-0007SC-JV; Fri, 30 Oct 2026 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm3C-00079W-Dj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMm3B-0002V8-0t
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793364580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D59REQglJHUhfMS9UjyUNiClE7+U5OnUvwA1ylK839o=;
 b=NqFq9X5dFXAqgWfF+3odpi9PrBjPxrjbmS2xuSi7stXdKJZf+6bdTG4uLUfHUyRwypVt5k
 +wEVRn3os4iZ+Fjxbnzo9iXA0HbkgFXLOQd9wYfSO95Rc0RumjhtaRXlDHlFpEaCQ04KcR
 DJtWVGH3NjTMJuuQR24t7Vq+UgYuOfM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Yi1ATbRBMqix_Ri8aTUDpQ-1; Fri,
 30 Oct 2026 08:49:35 -0400
X-MC-Unique: Yi1ATbRBMqix_Ri8aTUDpQ-1
X-Mimecast-MFC-AGG-ID: Yi1ATbRBMqix_Ri8aTUDpQ_1793364574
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4D27195607E
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:49:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21ADE1956088; Fri, 30 Oct 2026 12:49:32 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 7/8] qemu-options: document -compat insecure-input
 parameter
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
In-Reply-To: <20261028133603.1893289-8-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-8-berrange@redhat.com>
Date: Fri, 30 Oct 2026 16:49:21 +0400
Message-Id: <179336456127.3884549.13325492780625275399.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=R+Fcx8zGe2QRFU8PLiWm+94nilfqsJK8+2h0eeaz18Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5JJTsfVbDXJeIkQAEaEr63adzBDmUKKFE5teS
 fKjMhq1JLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauSSUwAKCRDa6OEJdZac
 5bZ2D/0TA6Twfa//yqexNmGGdRkSWPXskiwBhW5NlQrPwSsyr1UKsMvBRs4sR3fjwUGjqjWQERf
 +pb3Ly5loyRNqClUWXYIc8Kw8Xb1erYr5AjScE5uAOXmMI+0ND36xjzT0ZCG4pk6ZEP7Yvv36oa
 5J/ZF+DxlP2mX/zab1OX2UiZb85YNyrA9bPiM/GEtk/Hx3vf/36xHy/lBfqaBKubrMaEhOYOcvQ
 J05EJOL0vprVncVpKhJf5xi31iHorm3+ydSAoGsMcpAm2GacEj4vgOzBYlVDCv6WoY4h8k69bq6
 B8uqFMF/83zztEKZVMba2z5cy13D20C1JaIndgETigGGsx2+9cfY0BS+6TPiZSW6AvXsYMudIaU
 RCFmbDgnr2cGUZ+K3ysBPgym6V1dN+3CctSq0w7tEAMfEmNF6VP/nRtaX5FAnTV8VvW5KNEQh7v
 ppZHo+abt1nnL+kVyJazorcS5GGxnPUc8i35mUjeei8wwG3sC2tuFGoghADLxqeMUvrV8IY+Rrq
 dthkaEFHNMaDxNaheKSipygXmb0QkSJH8a4rohoR17NwKCsRP8lp+k0/pDYo5ZlcC8C4mz/li+3
 aE9QJbq5isXzzrGFQD8UioeIooeEC9us0jTm+1cQiTpXpqLV5wNnxPqixN95L7DqdhFpjtTlZhn
 rV0flxUZvobzWTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This adds documentation for the previously added 'insecure-input'
> parameter to -compat, which controls policy for insecure
> configuration requests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261028133603.1893289-8-berrange@redhat.com>
> ---
>  qemu-options.hx | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 16d9c6c9072d..0487e74bb3e1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4696,7 +4696,9 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
>      "-compat [deprecated-input=accept|reject|crash|warn][,deprecated-output=accept|hide]\n"
>      "                Policy for handling deprecated management interfaces\n"
>      "-compat [unstable-input=accept|reject|crash|warn][,unstable-output=accept|hide]\n"
> -    "                Policy for handling unstable management interfaces\n",
> +    "                Policy for handling unstable management interfaces\n"
> +    "-compat [insecure-input=accept|reject|crash|warn]\n"
> +    "                Policy for handling requests for insecure configuration requests\n",

"Policy for handling insecure configuration requests"?

>      QEMU_ARCH_ALL)
>  SRST
>  ``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
> @@ -4734,6 +4736,24 @@ SRST
>          Suppress unstable command results and events
>  
>      Limitation: covers only syntactic aspects of QMP.
> +
> +``-compat [insecure-input=<input-policy>]

Missing closing ``

> +    Set policy for handling requests for insecure configuration
> +    requests:
> +
> +    ``insecure-input=accept`` (default)
> +        Accept insecure configurations requests silently

> +    ``insecure-input=warn``
> +        Accept insecure configuration requests with warning on stderr
> +    ``insecure-input=reject``
> +        Reject insecure configuration requests
> +    ``insecure-input=crash``
> +        Crash on insecure configuration requests
> +
> +    Limitation: an insecure configuration is one where QEMU has

docs/system/security.rst still states that insecure-input "accepts three
values" and lists only accept, warn and reject. Add missing 'crash'.

> +    not intended to provide a security boundary to protect against

does not intend

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


