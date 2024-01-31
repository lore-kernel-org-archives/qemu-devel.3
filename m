Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C4CC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Az-0007TN-1f; Wed, 31 Jan 2024 06:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rV9Au-0007Sc-No
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rV9At-0003YW-4j
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706702077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEG5iDPTloHFi6rsZH43saXsxbB8EpUTK7mlc4hoSzE=;
 b=hVdw9TkZ3H0sv5pWwpFBldEEN2+SdSASBP3wS7zebQj9PZtfEeTEmAylnbsDBBbNn5m1t0
 U8AD3vO1lPm0Dxh53gyI3vYpdiDh12zi5+QLc23RBJikCvWQOP88taIaIHc2HHY0klfCLO
 QrSvuiZUclHkTfm/Zq5HEb8ITdGEmXI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-HviO8ehnN2CcjjUtIVRp-g-1; Wed,
 31 Jan 2024 06:54:33 -0500
X-MC-Unique: HviO8ehnN2CcjjUtIVRp-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA173816B42;
 Wed, 31 Jan 2024 11:54:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47BB1107BD;
 Wed, 31 Jan 2024 11:54:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 18ABD1800DDC; Wed, 31 Jan 2024 12:54:32 +0100 (CET)
Date: Wed, 31 Jan 2024 12:54:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
Message-ID: <ulrgo3dqewvffg3okryrsnnwhsdbb4f7sga3agmszfyv4jte7t@fds5d2ww4xyf>
References: <20240131024906.3920-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131024906.3920-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 08:19:06AM +0530, Ani Sinha wrote:
 
> This error exists only with edk2. Seabios currently can boot a linux guest
> fine with 4096 vcpus. Since the lowest common denominator for a working VM for
> both edk2 and seabios is 1856 vcpus, bump up the value max_cpus to 1856 for q35
> machines versions 9 and newer. Q35 machines versions 8.2 and older continue
> to support 1024 maximum vcpus as before for compatibility reasons.

There is a high chance this limit will be gone soon.

https://github.com/kraxel/edk2/commit/7a03c17f0f4f4a9003d77db2660c8e087604b2f0

If 4096 works fine with seabios, I'd suggest to go with 4096 as limit.

take care,
  Gerd


