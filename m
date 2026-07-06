Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D39AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgolW-0004sP-Kz; Mon, 06 Jul 2026 15:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgolU-0004s7-JE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgolT-0003zz-57
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783365236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O6+r+XegtAOEtozhdCR/WgRtWLgBAryVVQO6RzocTI4=;
 b=HcAh3cpkbIYN7ZS8HrrTROgx7iLSLKmgOoiXjGsKmjMQvaISCclyJTy4RuG0CIAEH2dk+1
 NLoysGIANG/DlRJ5frlM/fmKzXP6nSje5Y0XO5uDI+XHevsCAN1ZCaeNR8oC6DgzPS6RfP
 7G3AgHf4dlke7VWapME4C4Xd0GiInbY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-EgfqX9naOgiEmCwZcT8oaA-1; Mon, 06 Jul 2026 15:13:55 -0400
X-MC-Unique: EgfqX9naOgiEmCwZcT8oaA-1
X-Mimecast-MFC-AGG-ID: EgfqX9naOgiEmCwZcT8oaA_1783365234
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso1531691cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783365234; x=1783970034; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O6+r+XegtAOEtozhdCR/WgRtWLgBAryVVQO6RzocTI4=;
 b=nISj6QwquADYFd5DFdJfMqOVYnoSkRD664gC2nch4872VFXqn3hR6mI6u/1ekDCFqd
 axsfraOQ90ChhNiMiUMdWgakBcHR36U7APCc6EoT0sJ9L49uXbDPE8v0QmGcJdZBNL9U
 LFIJLU3XjDbVtdS4il2FIyeJqeTt+xIbGbFYUskr3vXThIK0s1pjIqcocWC4EsGTRIvr
 KGzPfqgwwAltb6xDe9pOSUJmwCn/SRnWk5bTdjr8GSSs0LPhV8NdUjVB2PaOCFF+mhRX
 +WeFSSRn2E23fPR+pED17LEb//ectuyOu/Pa1Om4hdCrh7iwdlhGXvwxKOfV40bgQzP1
 NomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783365234; x=1783970034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6+r+XegtAOEtozhdCR/WgRtWLgBAryVVQO6RzocTI4=;
 b=pnQqjgNI867Ndpm8xyHppjTQEzLeUSTutbUD6RPgylH0qffPRi6LKZCtg2akw+7dfB
 nmX/mVo3wVdwhG/SZMfTeNpRggEMkPy9GfoMHNcGLafziRdjQhJXqT+EcT4ImOE9UJj6
 dPm9mf8VClZrrOQ3VOTNj/FuytMndPH2+Sh77qq0jw0iVspWCgiWdTIC4Tzu41aT2G3F
 m8f3gtDCCE9WDdaqQqqpl9MdTJY/eB7fQdLSyi9Jj6Y6S3BFEfpnnLPP/wBnqA7VCmw8
 /baByPTJOrjjyusgejeWsNC2fEg2JvMywr2P6J3EBdidEUbMXqE0vaheFgp5D3iz5FjT
 /SSA==
X-Gm-Message-State: AOJu0YwggD/115pHVc6IV/WZdj652rBgKQv/z4ucEI804Uj5zgRTPJNm
 rLI0ZU9j4ymObzyuE0v412bVUWmoxeAPzwqtOIMFXwCwyKUJq84J4wob9y3J1B9l6V++1dYs10f
 OqSug0a7i/sgT+T8jrHCX5TUxCPQQxIAVoWqpXPhcmu2mWsQd5uSbjyV9
X-Gm-Gg: AfdE7cn6VwPXIjVENQbb0dSyXq9f7MGm3aj+Zk3T8Hobv9g5tStp5KNt04lp8Da4nfr
 9+1Infenvpy/ek28OeuLgkPeGysVfhwATQJv0vorAJijNtT1qDkQgQxskTVYB5ZNwcdWBeL8u3M
 opU4l0vbJMPL9/GyeNp2qRbb4NxERG/rWdygSL5Pn+DnypZ+KXWPH76aJsmkgUHyEqHDbBlE4n3
 rJIlLveph6bEXJ4ECykIYZSAnYzOsxZhWkaO/5w6R9On8TCaU8TVTx+Pyhw9Rkzd7Sok1ktklbr
 JWDEgXKs7DgZbZVzxJh+/1fvhasVawsJIM002t60MZiRWDEmO37mnNuRhZ8YZk3dQ78Qa12NUxs
 HLSLXHZ9TFGVFbFt6jZIs97m9QFEieEb+qId3Zm1Sl1Ig/P/98vIqQ3q6LHY951mYknfeMQ==
X-Received: by 2002:ac8:5e49:0:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51c3c37f2ffmr196228331cf.40.1783365234189; 
 Mon, 06 Jul 2026 12:13:54 -0700 (PDT)
X-Received: by 2002:ac8:5e49:0:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51c3c37f2ffmr196227961cf.40.1783365233734; 
 Mon, 06 Jul 2026 12:13:53 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471813d25sm143850396d6.26.2026.07.06.12.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 12:13:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:13:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 2/7] migration: Propagate error in postcopy setup
 functions
Message-ID: <akv-auevvisxEJde@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-3-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-3-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 01:49:35PM +0530, Aadeshveer Singh wrote:
> Modernize error handling in postcopy_ram_incoming_setup() and
> postcopy_temp_pages_setup() by replacing error_reports and local error
> handling with standard Error propagation.
> 
> Replace use of strerror() on errno with error_setg_errno() for modular
> handling of errors and change return values to -1 on failure as no
> caller checks the actual return value.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


