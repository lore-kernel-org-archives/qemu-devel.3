Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EE606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TMY4dKUW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCDA-000435-RN; Tue, 20 Oct 2026 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCD8-00042Y-Q4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCD7-0000pu-Es
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Elas3c0mQ8Dn+jiWEMua5maRCSU2Ywlu1y5iiASk3c=;
 b=TMY4dKUWl8jwhFHobA/sYQMv24deGEWYcQ3uklMmA4U6SH6Obwjd59lAFsABqqmiTyhuyB
 e9HmaFsjr8Cv6LY8XbOQAl6yFdPxCp3hoWWxqaQjHubVBmTjeQ8lliYV8dNp1g96aR8GoW
 HAO8TNo3UUCBCj0HLxke/qIwRt9H3eM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-Y5euT-wCMc6NiuR2jRqm2A-1; Tue,
 20 Oct 2026 11:57:00 -0400
X-MC-Unique: Y5euT-wCMc6NiuR2jRqm2A-1
X-Mimecast-MFC-AGG-ID: Y5euT-wCMc6NiuR2jRqm2A_1792511819
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E464A195BDCA; Tue, 20 Oct 2026 15:56:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD07D1956095; Tue, 20 Oct 2026 15:56:57 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 10/12] qmp: add chardev-window-size-changed command
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v10-10-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-10-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177299.3780647.4397762650872048992.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=439;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6/fVmD7IkFQfofMsXHbAnYuL1j/HEKYubXULyROJUdU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148gbMW+mPBwAMJbVWaFmjOQlpXjD8tuJVjYA
 T1H7ciKvYGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5QhjD/9hKeNP7s0PvQx5M4X639wcTQsJyaIdYL/vecyhlivugygKLbXmhvBMuUpITqt+lcO0w3n
 vCBL9I6SpybMKiiYYoNv/EJPPs0ZH0csYXJUn7BGGYne1i45Jc/9YFbuekM+hsTkqqIU/iNf7on
 sK4xx6UiVRxmPZAQcjaSFYOvFXzbXEQmqbF9w8Yv1wjGp0cemQd3k0F15voKXspqiEq60lsrdrJ
 V14fAl9rclqk3WFV0Oi0yFFtoFnDbAJnk/a8d5IVqHvmcQIDJZjPe/c/QAmZILu9jJNcf5mVcCG
 DZRnrZx/vvyEXFZGplW+XYnwD5rzuawTU8M9AfNwliKSy0t32y+u1HOcnd7X6hCC5C1OJNRcZsg
 dagLzMxHwQMM8vqszdTi6Cw7EI/GjlaqPjU3sM+n1QPpQOhqOjabX6/6F/QfBBRjSXLZpg97Dh4
 l80/LHOMjMsnUJYXdhEDAI1cTVZcE44AirH9zPwC4FBiZfcOoA3sORqoFxl05IIZ2f/Y5BgTj84
 TI1zwP/hiSS4ueW2Oe2AWZ4ET4jnmGDOTg24dV2TTBrFNvp1uvTA/G1j9hbzSHq0G8sWhiOqj1R
 AFy83f0c6wUfbB/ylzZyud6QXGcXW0b9/ESDvbFdSQRT1Hi6MSyPLEjogojD3V7K4ZrsWSgnoSd
 Y7/9NhcnqtAIiRw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Mon, 12 Oct 2026 16:05:09 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> The management software can use this command to notify QEMU about the
> size of the terminal connected to a chardev, QEMU can then forward this
> information to the guest if the chardev is connected to a virtio console
> device.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


