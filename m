Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DB3CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkq4-0001cM-0z; Wed, 17 Jun 2026 03:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZkq1-0001bK-8E
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wZkpz-00021w-9B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781681845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvZHxb0RRRze4L1HG8IqbvtD0bxyGp/jAvytTFpX1zI=;
 b=dK22oVApI23gEfGprIwAslGqvaOtIiSzRFzl4maRMNRg2g6mIXDg8DEgF9BK9l+RIvy/lg
 qLVe/PT32jlOyBAwY42uYaMWpKepAUVfzknMTGaPlEIzFoxCnyMzL6v6svLeuwXXx21GUA
 OhFuGnQiGq2ALgOfhWqF8CteSk5PbVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-hsT37holNDKKFnVYGPfTHw-1; Wed,
 17 Jun 2026 03:37:24 -0400
X-MC-Unique: hsT37holNDKKFnVYGPfTHw-1
X-Mimecast-MFC-AGG-ID: hsT37holNDKKFnVYGPfTHw_1781681843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28AB018011C6; Wed, 17 Jun 2026 07:37:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C35811800367; Wed, 17 Jun 2026 07:37:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E25C180194A; Wed, 17 Jun 2026 09:37:20 +0200 (CEST)
Date: Wed, 17 Jun 2026 09:37:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH] igvm: Report error on missing parameter area in
 directive handlers
Message-ID: <ajJNtWjSAv4PZOTe@sirius.home.kraxel.org>
References: <20260610-igvm_error-v1-1-59d133a69f2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610-igvm_error-v1-1-59d133a69f2f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 10, 2026 at 11:44:21AM +0200, Luigi Leonardi wrote:
> Parameter areas are how an IGVM file tells QEMU to allocate buffers
> for runtime information the guest needs — VP count, memory map,
> MADT and so on. Usage directives reference a parameter area by index
> to tell QEMU where to write each piece of data. If the index doesn't
> match any declared parameter area, the data has nowhere to go and it
> should be treated as an error.
> 
> The directive handlers that look up a parameter area all return 0
> (success) when `qigvm_find_param_entry()` can't find it. Therefore,
> the load succeeds but the guest never gets the expected parameters.
> 
> Note that the IGVM library already validates parameter area indices
> when the file is loaded, so this path should only be reachable with
> a malformed file that bypassed library validation. See it as a form
> of defensive programming.
> 
> Report the error with error_setg() and return -1 instead.
> Also remove the warn_report() from `qigvm_find_param_entry()`
> to avoid double error reporting.
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  backends/igvm.c    | 17 ++++++++++++-----
>  target/i386/igvm.c |  4 +++-
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index c347d0c17e..2569c4a9f2 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -71,7 +71,6 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
>              return param_entry;
>          }
>      }
> -    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
>      return NULL;
>  }

When passing down errp to qigvm_find_param_entry() we can call
error_setg here instead duplicating it for each qigvm_find_param_entry
call.

take care,
  Gerd


