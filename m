Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3263C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkTp-0007fX-UK; Wed, 19 Aug 2026 13:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTl-0007ez-5B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTj-0005Tu-B0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MMottLM5FK8FLjVSc8zReA4ppJq69uKJJktmiNI1hc=;
 b=HRhv4jdj0/3hb4uCr8I113qpNkwCkPRD7SdBMtBOUvTEekoLxdsnXZ1Qfb531kstKoLxY9
 Rrj73bE7Mxa87WvDFsBhye6BMI7oQCjvJazsclCTo3OZQkCa5O69NIKlmAlZRVBgy3zRqc
 d3jbikM0oyeIOV4ZTYviNrDp2NRwRuk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-2kHZ6sF7Oc2Epgqm715E9Q-1; Wed,
 19 Aug 2026 13:53:29 -0400
X-MC-Unique: 2kHZ6sF7Oc2Epgqm715E9Q-1
X-Mimecast-MFC-AGG-ID: 2kHZ6sF7Oc2Epgqm715E9Q_1787162008
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E011D180049D; Wed, 19 Aug 2026 17:53:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BEEE26C; Wed, 19 Aug 2026 17:53:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 12/15] hw/acpi/pcihp.c: convert
 ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP to class props
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-13-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-13-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196334.2018258.8967303423780227738.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=480;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=w3+cAzy98bnLUN4mZCx8X3MMi5Daa5+ikKYZS8SmSFc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe1+/solv9t/nNxPmD6L+PkfctYiVcVTZZ2J9
 XT3OkS05eGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfgAKCRDa6OEJdZac
 5XoCD/4qKWqBDNS8kz/J3kz4xTOIjAm9Kj++2HElCUlB0ahVn2v4b82MI87okU84iiF1eJo4DOM
 MZH2WuAf+vd6VfO386m6xh1xpVp7yKXyPYUohhodmP4sklLjwGwoE2doBnXpzJsYm/Hf9s+ImRi
 4+EpmuLs2VOdSir/5YuQlshm9/Dih1KXVe5GVjVdszTUkc7IXge1ZGVwSGy+lwOyCHxmYBqHtLL
 OmSMI2jsLTTutLuyZ2IVRRrXY757aBFXDUCBkSRLvJP9Ab46fXtyCfwhEtDFxvGYJkpMP+DV//e
 TB1Z1C5mZEtKg63ZulzG0k69MjPJTU4zjZYiw2YeUYqY+kpmnIG7Mkp3v94aOkvsb5p32PB/a89
 q1DOhr+gSAr4RwHmRq/3QacOq99NPNWFpIGdPKIIUJ192wnDZcDkfbUirCyVMv5y8yLX9OGeTYK
 Pme6YgJUIcRHtlf1FEH0W7Y8zJQ4NOiqIKalBGM1ceVlBpsJJTnhU6W3EXL1PAH8ENEe3MNJ4yq
 MQwCNeFp6ueVdrnI+y8ngIaHW9D3wzmkW+Qu/lltb9DZNCmh74HopeyF1omvuM4Dm8iYuA5KVZh
 uT37lLrVGF1dlDQFxT5zg1c6PudIE/ipZpO/KqjggsG6DdsA1hM6QbVc9tvgwm6HtNsZ/pW1Ck5
 5RJ0m6zD9P0LAtg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 19 Aug 2026 14:35:51 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> Since the objects referenced by acpi_pcihp_init() do not inherit from a common
> class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
> to each referenced object and remove the object properties manually added in
> acpi_pcihp_init().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


