Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D475CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hax-0008K0-W0; Mon, 13 Oct 2025 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8Hao-0008Ip-Jx
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8Hah-00056D-UJ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760358227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcIm/mRfoQurwfIb9UdwXteTtCIGOYn3WMAjqMQ49ak=;
 b=Vtv8I8QDpjFsm1uGfKjmnUIWYioFrMdM6oY4vKLifBxYHS9XFzYF7PdUrbWO8mbCB/faGl
 qr31HOhwQLuKHHokCcIahdDxtLsdCPICQZfbXjE0/6szLc0eV1auf2SwGZOx9mN+eWefIL
 5o9XPV/SQUh2Ay/16epSsC4yTpyCX3c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-5hvyzuFjNyK-uZ_E_fMgAA-1; Mon,
 13 Oct 2025 08:23:46 -0400
X-MC-Unique: 5hvyzuFjNyK-uZ_E_fMgAA-1
X-Mimecast-MFC-AGG-ID: 5hvyzuFjNyK-uZ_E_fMgAA_1760358225
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70ACE1956086; Mon, 13 Oct 2025 12:23:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.195])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B65091800446; Mon, 13 Oct 2025 12:23:41 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:23:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, viktor.prutyanov@phystech.edu,
 hreitz@redhat.com, maochenxi@bosc.ac.cn, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Message-ID: <aOzvS-mjf8oeAiZo@redhat.com>
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009141026.4042021-2-rjones@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 09.10.2025 um 16:08 hat Richard W.M. Jones geschrieben:
> curl_easy_setopt takes a variable argument that depends on what
> CURLOPT you are setting.  Some require a long constant.  Passing a
> plain int constant is potentially wrong on some platforms.
> 
> With warnings enabled, multiple warnings like this were printed:
> 
> ../block/curl.c: In function ‘curl_init_state’:
> ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>   474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
>       |             ^
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

CURLOPT_VERBOSE takes a long, too.

It's hidden behind an #ifdef DEBUG_VERBOSE, so we won't see it in normal
builds, but would be nice to fix it, too.

Kevin


