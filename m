Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C668CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrXY-0003uo-0M; Thu, 07 May 2026 01:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXU-0003uJ-Aj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXS-0008Eg-JS
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778132684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkYT8AJCKe/BtrSvl49OoUVBpR09Ib8DOCTqPdFKQeE=;
 b=UBnrayK/ShipON9xlxougnb2/9ng5NwHh5bh5Eu5NDz/zy+oBhNLocik/ZOUSF0ZbCsM9c
 WpBE6n/RS/TcmVWe8WiRyXs5lyuFTrcSXuBf4zbCcgibR53ofwx6xRWWZrMEp+nq67vnkp
 33ekJ6/VCE/Is3y+hNb6OVbRlFeQbq8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-DfhDvglVOk-GRqeBkZgReA-1; Thu,
 07 May 2026 01:44:40 -0400
X-MC-Unique: DfhDvglVOk-GRqeBkZgReA-1
X-Mimecast-MFC-AGG-ID: DfhDvglVOk-GRqeBkZgReA_1778132679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B0CB180034A; Thu,  7 May 2026 05:44:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42CB219560A2; Thu,  7 May 2026 05:44:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] qapi/net: Some doc improvement and cleanup
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, lvivier@redhat.com, 
 sbrivio@redhat.com, samuel.thibault@ens-lyon.org, 
 marcandre.lureau@redhat.com
In-Reply-To: <20260506105421.2461117-1-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
Date: Thu, 07 May 2026 09:44:30 +0400
Message-Id: <177813267023.2413233.14054842879891768294.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=686;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O7IAiP5mJ8G9d8IwTJTaa+EMlY12BhaZGIyafevvuLg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/CbBdfNDVhnYyPGoseEY0aKMfMMkE8LSiFOfb
 avDb6LVIv6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafwmwQAKCRDa6OEJdZac
 5XmpEACdsAsq2XCcXZB2Z+/bAN+nf8/EzR0EvOuk0LVRz9HM+u8MLd/1tomvsTKEezJ+p3Ct7DH
 C0Hwng0cptYSUz67dNmPIC8SHJcOkFR49GX17JV5nJRlkas6yHdipy8exOrkZyrfU/x2E4Bpc74
 oms0hmJgMFaB4/zJzdWLnw3FowM5s3I98uVwivhcOfmmyZO8dThLwdhfWB5iwo/B+2fm/nO7vPH
 988vp48OPdhB+9fPxGmZzcvKRXTB3+pYRsvwvYM3d/k95F7cTv4EXzDE/Ux0MPJrOUgEugiAJUE
 bMGTaC0PANUyuiKfMrn8j4Te5chhnT090PzPSkJpTzerZVYBJRLbKmZTS0DTQObPXHR/yBSdBes
 GjtSjHZnOrJ3TggUgzRdSIcce6mUDRgX/wLN7oyFdApKBKeB05lX3BzQW4j2xo03Z66AbyQ3yqF
 Mb+2hDY94qIhOnAIk3gzCtb6CLvtDHUd4+IyXo/6ivuC5rsotcx2iBnKJTXBLbEPT8qN1/DM1YE
 bQWHQv1Yb7fzjg6pkOrSKgs7HeFGJE80rfCDYgHqYUgfoi0nuIgR+AhS47bUhykDsmxLaKSmAko
 rfceAkZBNkQyQxnpHwHhOKaNqkTsiNdarIAX/87tUkHRP/qISREEje0v5/2xKhyH0UORVPeCHTp
 ZNPo69zEnXpnSHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Wed, 06 May 2026 12:54:17 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> qapi/net: Some doc improvement and cleanup
> 
> This series replaces useless documentation by hopefully useful one.
> I'm not familiar with this stuff, though.  Please review critically.
> 
> Markus Armbruster (4):
>   qapi/net: Rename NetDevPasstOptions to NetdevPasstOptions
>   qapi/net: Wean passt off QAPI type String to improve documentation
>   qapi/net: Wean SLIRP off QAPI type String to improve documentation
>   qapi/net: Drop unused type String
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


