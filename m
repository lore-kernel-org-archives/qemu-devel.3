Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F95C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpNPx-0003KF-W3; Wed, 27 Mar 2024 03:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpNPv-0003Jm-Mu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpNPt-0008VL-SR
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711523383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vIzIzogi+A8S/XQGl9Pr07ygOeqr+JWEcuZxwvgp3GM=;
 b=dri+fTkcgOeqI1WjRAmiPYcM1TRfnS09cblEnabwgVoK5Z6iFHQygMOz1BGVAWMitK6h9V
 mZRg0P7CvzexIhZwM1KEE3kOBAEDAnctWs6ANI/rOQL9q9qXnjaD0fdnvWTj27MxpU2+Ch
 frc1xf6eWZ1gTgnRZZnJqRAzGa/26IQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-9CT_MDQOPEa49XOUrI44fQ-1; Wed,
 27 Mar 2024 03:09:41 -0400
X-MC-Unique: 9CT_MDQOPEa49XOUrI44fQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67D013C025D7;
 Wed, 27 Mar 2024 07:09:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F15DE200A384;
 Wed, 27 Mar 2024 07:09:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B880C18003BA; Wed, 27 Mar 2024 08:09:34 +0100 (CET)
Date: Wed, 27 Mar 2024 08:09:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, devel@lists.libvirt.org, richard.henderson@linaro.org, 
 mst@redhat.com, thuth@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <vyepknhyulwvmyypt74i7gvu4nqqqzhgdj2fxi66rgdnipi2co@ildhvlycqf2v>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 01:30:48PM +0000, Mark Cave-Ayland wrote:
> Heh I've actually been using isapc over the past couple of weeks to fire up
> some old programs in a Windows 3 VM :)

I'm wondering why these use cases can't simply use the 'pc' machine
type?

The early pci chipsets of the 90-ies have been designed in a
backward-compatible manner, with devices such as the IDE controller
being mapped to the standard ISA ioports.  So even an historic OS which
does not know what PCI is can run on that hardware, by simply talking to
devices using the standard ISA io ports ...

take care,
  Gerd


