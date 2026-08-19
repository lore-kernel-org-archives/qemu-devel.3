Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C0FC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkU0-0007lr-Sf; Wed, 19 Aug 2026 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTw-0007kh-UJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTu-0005VL-MW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zllZyTxivIPqSM9j7X3JvpEcl/z9yq00iDtrm3VpxVs=;
 b=DyG5/Ma3eC7dGZc+4IWrQ4kc69zaDvA5jHvm/PmbKl0i4hweaSZnN2ZFtWbA/K1zqnbZj/
 4MjvOF24u0hbJW/e8OR9qeXOZRmKUN9DO57kUQPUrk5gYhZGYXHGuhMn7+oxvB9TZs4ARO
 mveLyWCAgfZEJ7lvCFtvztMgU7sWVSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-s8y3AUSMN8q22urO0OEIOA-1; Wed,
 19 Aug 2026 13:53:32 -0400
X-MC-Unique: s8y3AUSMN8q22urO0OEIOA-1
X-Mimecast-MFC-AGG-ID: s8y3AUSMN8q22urO0OEIOA_1787162011
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F38E195608F; Wed, 19 Aug 2026 17:53:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89E211956044; Wed, 19 Aug 2026 17:53:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 13/15] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-14-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-14-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196335.2018258.12249807268524137122.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=602;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qHGKIs4LhYh/pjCF9JSNGoOib9B/K0uiD54v/U0VQDo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe1+Cd+MPFBBux3hXeXMXvwQPP+FpyD2zjK2g
 bhLn2AYqquJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfgAKCRDa6OEJdZac
 5REbD/9YL2uOo2aKhzVWv2ABycGaFdgzM/oEbBn0ZpuawL3DQzAUTgtFMVhmMRVA9dCETLBbH6B
 o2dgf3+4J6OTVpUFqHiHhswXbObtqPQrFV41iVFGAyScrYov+0LoWZ5aBq4naQFpcbnDBbDgMxR
 ywxs3lOI97++PbSRB47BMcxEJ4ouHlnZ3FcUe8cOWQSn4Rganx09yn/n9UTLPO+rRS1M3U+z1rH
 28+iDeMWV8HxI0SYNL4ghHd4WjRJ/+4ymZPybKwEXGeOOafUnRAsN473iHU8E20xuuErtBmKv9u
 0FPF6ullBkyiLyAAKbxd1YrT7RzysXVj4/jGR/I8PHXgwbX9npkxwIIRj86BytbojIq9Bi2hKoB
 kCXPqH1J/P+SKYsalESnF0ZiWy632hePR7/pTjcX4ITXaWM6lNSr35jddXyrwMJ3cIsXef13uP8
 2iZqS5TUi8EVp+igkz5gmYuA1ZEF0B1jh+QU+fUWyN00aFxYxoqM3sccTPH/GZCub3N+1UW9NMv
 xHbEvD4XKRVAIPPQk5STDJcmUGTopI2RCqXsmkU3QIWNOBlzSPXZtFGF48m2XQDjIZ0vWdtNe0C
 JScTnW/qW4uvY2l9VMR3WjgTczq5RhxR7gOOC4gW/MABvZcFbPN25j3keD8Ibw4hZfYHjLaibP2
 LNybg88LnyYCvzQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 19 Aug 2026 14:35:52 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
> callers accordingly.
> 
> Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
> property to enable the relevant ACPI changes, set the type of the underlying
> variable to uint32_t with a default value of UINT32_MAX indicating that the
> property has not been set.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


