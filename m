Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B49C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTc-0007aa-9l; Wed, 19 Aug 2026 13:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTa-0007aC-K6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTY-0005RK-S0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hz1753de5eTEDJh4HCdgAWSke5PUoYybj9jMU7q9HM=;
 b=XuDu2Y7gkoLYN1yPVoolw1udWjhbyzsRxWy5/rkX3vBkQlIHABbB1EC+BOTA5AvK3sinUv
 TJTxA5DT7fhlUL2mTnbIkt0VNfQLgeAIz4hxj+QWDcv3svvK9s1Qc5P/GIOs7aUxw7gcM7
 NfDt7iSUpRRbwxYCsTsHTMjLDkauymY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-b2DnmRgbNgagK-FrD5KQcQ-1; Wed,
 19 Aug 2026 13:53:15 -0400
X-MC-Unique: b2DnmRgbNgagK-FrD5KQcQ-1
X-Mimecast-MFC-AGG-ID: b2DnmRgbNgagK-FrD5KQcQ_1787161992
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5215518001E6; Wed, 19 Aug 2026 17:53:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACDB4195608A; Wed, 19 Aug 2026 17:53:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 08/15] hw/acpi/ich9.c: convert
 ACPI_PM_PROP_GPE0_BLK_LEN to a static class property
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-9-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-9-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196331.2018258.12531558944971234355.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=518;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=C09neJfzPX4aYsFGmCqbR3+A2ULNtA77z6eMguTXk34=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe19JiIyb+PF+eIbbOuzQG2jz6DdMuW1ogw2O
 uE39TxPWzmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfQAKCRDa6OEJdZac
 5fVfD/9FBfvWu2Wo9sSN2sINebwbKrv7aXn2yWWV1K75BQlU52RmZsO8VYSRxvfQBr8k0MnZc7W
 isXcXxXMsj41t7AyxBKdlNReYmfVL+xiI85/ObWyxgtx0o5OKTYFve55dSkKDGXaNarXyaVkE8h
 eb8ybzjofg1bh0DwFywRViD5WJ4jQ7BG/ugzdMh/LX7TFDXZThKVxXD5SztSlvFzJSF/XDdlPtk
 u/rab49i1oC8v8ixIazgZqe0JJgBzEULxD9D5duKCcp9jvrT4jtKGR6nXl/xFqbfTcjPxN4OlTL
 Dm5hGF7ngyA7dfk2o4QXitQkmDyAPx6jgKXbDUSBgz8QTdYtVmDLFMqMyjCXk8MTzN4ek5vu2fk
 UbbL9LYuAdNGpf6h9U3U66Yh7DRU1EdqMV3xJ3COkDrIhvSy0SbFftx5Rf4MyZGqStrH7bC6doF
 61XMsGiJZ55wYb3WDhg5u9ElX08GjHhKaMOvAnf8XQyn/bD6KpEuRnfFarRC+6rfUd0rNP8Egsz
 hr7iHHpxBRYRzorR27eVApcqAyu066RN6xZWvPoQp6MQvt+Ib2fkQuOc54dkdVckwJCwk4bEX9/
 ylZx/s9KP+7HfBj/mV9fpKtkdOmW/SJhohU9Ggqtw4M6rGI63nn18YFQcQjYAvWSJd8R1/SohnE
 WoKh7VIpW3geNTA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 19 Aug 2026 14:35:47 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> The ACPI_PM_PROP_GPE0_BLK_LEN property is assigned to a static variable and so
> can be converted to a static class property. Introduce
> ich9_pm_add_class_properties() to hold the ACPI_PM_PROP_GPE0_BLK_LEN property
> and soon all other class props after they have been converted from object props.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


