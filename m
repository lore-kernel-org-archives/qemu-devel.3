Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33730606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gMFRW7S3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCDB-00043S-Eh; Tue, 20 Oct 2026 11:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCDA-00042o-07
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCD7-0000pj-FE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKNriBPi/1OIex3Kna+6t9bH1RqJpbQrP6LejNaCXt8=;
 b=gMFRW7S3km5XyKvbbQSKPVOZidP+akqXnNJSOZYQvW8tLmnlgks5tN8uO9GVmilN8nwxBc
 ll4oSIqdD+yxYIgEbwd8wqnfZ8k8xifGaoD5O3ks47Nf6IdOteMJ7Lhguu0BtcmYIYWtkd
 OWhlamGEYQWvbZJIGMfU5zUZNc2hq7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-g0uTlCPWM26hbbi4Hf5GWA-1; Tue,
 20 Oct 2026 15:56:56 +0000
X-MC-Unique: g0uTlCPWM26hbbi4Hf5GWA-1
X-Mimecast-MFC-AGG-ID: g0uTlCPWM26hbbi4Hf5GWA_1792511815
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 068D01956065; Tue, 20 Oct 2026 15:56:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 120451800643; Tue, 20 Oct 2026 15:56:52 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 09/12] ui/gtk: forward gtk console size to vc chardev
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261012-console-resize-v10-9-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-9-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177299.3780647.3726437433731469020.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=461;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WE2T44L70atgE9wpH2fBK8bfsktyWifCv+I+Wn3UEVg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148gNfXI5vGKMv89h1+N+GMf9fdUtKk7o7cYb
 WGpu4+eE6eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5bu3D/9e5mBryn2alLdBdISYY8AwTe7lrVROtOs9TNZT6BnG7kxyspoG3kM6ZDP4arBEJhY/tsU
 yWpuK7Ex7SlvLhvDzRQH7fxPCiCGCbT3H6AUxDNsRzVpDQQVBjWHIab80tgFkmRldKJa+dPWirw
 PKdC05C/IBgCFrLLB7UhSi4i0YHNzdlNPXFyPsIKQMkyxCihuJeIU024dC4V6atvr+LnrT0YxYu
 oOID12Sz8mhaLYgj4Y+x7xSZo/L2qPVX+vHQhf0u/jiLJLLQXlM5ctuKWZ8DNj2VIFeVk5Vms5B
 O02g9TBhiDY77lzlFcewvIQXsqDMhxerRNb6Noudkb9dwWiYben6PmiyLC6PWuddGFAaUElXkOW
 kFxjL0Ks9SK411TmweWfDtY5TLjMvWpN7WlovZ9npEkHodpqDtPrnG7DY4R1Svd6lWmp7odFfVv
 CoOWk8XPzPTM8vUTFSc5E+AF9+7izcamzVnKqWyx2zNIYjc4O835yqCSTiRxdwDqpTwqZk0QfJL
 xQwOn3mrnqFQYnZ4EdjPVWhtLyH4rgqhI7jpSq/BQTFp7DjWno4Ftv1cImdnfA5cFHEXGS3W8DM
 M4shhZPzLia0OJLh8djoVBHraBf0bb1B7hpzrzZAKjNVJUONzni7D6emAf40kyye05ug62Ope/J
 s44w4RheD/DkFKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 16:05:08 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> Query the terminal size from the vte library when creating the console
> and every time it might change. Vte doesn't send any signal specifically
> for terminal size changes, so instead we register callbacks for
> size-allocate and char-size-changed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


