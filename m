Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3097C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTWf-0007wN-TA; Tue, 03 Jun 2025 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMTWZ-0007uR-0A
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMTWP-0007z2-An
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4dyinYyyLk6ylJrvaMaa4KowcTn5iJ0eyTpa1Eq62g0=;
 b=blzvJ75tyvNb3rzhoLbzywFrvnDjfcnEMHF3KsILKjw/pXnh+3y13p3uRdkddsLVHbROXQ
 1kLikSJyl4JxQcFp8ZVCHKZxxb9hCzYAd6CJ8XuwldBxi7mL3sJjd/bbMvCSQt1w4NfKwt
 ntBevOywC6QXDppEiGjeq6vkIVBmdf4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-1Ozobu3AOfeQpys_Hda-2w-1; Tue,
 03 Jun 2025 11:25:43 -0400
X-MC-Unique: 1Ozobu3AOfeQpys_Hda-2w-1
X-Mimecast-MFC-AGG-ID: 1Ozobu3AOfeQpys_Hda-2w_1748964342
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98D511954238; Tue,  3 Jun 2025 15:25:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.62])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59366180035C; Tue,  3 Jun 2025 15:25:36 +0000 (UTC)
Date: Tue, 3 Jun 2025 17:25:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <aD8T7RSDofG0TNCK@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603142524.4043193-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 03.06.2025 um 16:25 hat Markus Armbruster geschrieben:
> More than a year ago, Daniel posted patches to put an AI policy in
> writing.  Reception was mostly positive.  A v2 to address feedback
> followed with some delay.  But no pull request.
> 
> I asked Daniel why, and he told me he was concerned it might go too
> far in its interpretation of the DCO requirements.  After a bit of
> discussion, I think Daniel's text is basically fine.  The policy it
> describes is simple and strict.  Relaxing policy is easier than
> tightening it.  I softened the phrasing slightly, addressed open
> review comments, and fixed a few minor things I found myself.
>
> [...]

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


