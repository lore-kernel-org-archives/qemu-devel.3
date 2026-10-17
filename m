Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D0BCCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01V-0001zu-Dk; Sat, 17 Oct 2026 04:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01S-0001oU-14
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01Q-0007Cf-IV
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuJ7MQRr1gYXVTT4sKlqDoBWQ4dPlXkG9f/CPoyAuFw=;
 b=e8o2hgnJIYAvcjlF4VtrTSd9UGSPYplCuGUSx/zThvMWqUjI1cgNwDqEAX+OF1COxu0Iaq
 ve3CDmdqIYEuIDWe0gXW+DTc9xayeM+koGOTcuCf7HKW/ipq6HT4DW2qcqkjRTTxt6EjXj
 xOUtWksZvNFxxH8qnMKZUzC+nbz+hRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-YAhk7qsEMJ2uwhGHjsz5sg-1; Sat,
 17 Oct 2026 08:44:06 +0000
X-MC-Unique: YAhk7qsEMJ2uwhGHjsz5sg-1
X-Mimecast-MFC-AGG-ID: YAhk7qsEMJ2uwhGHjsz5sg_1792226645
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97FE5180049D; Sat, 17 Oct 2026 08:44:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A163D418; Sat, 17 Oct 2026 08:44:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 20/23] target/s390x: implement get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-21-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-21-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656910.1619676.15533449052639270423.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zihRpemSSAhzp+ALEaxlRe/j+ZyvooJJqCPpd4Ctq0s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNsgKIjIN5lSZ8fMyvtyyPEV+mU9pj5mJoo
 FZc3iiOQ1iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5dQDD/9ZI/CK3p8UuAsRLtRcEfxZ5+0iUhD12Ow5MzrJXdq6Bs5W5qBO2wkaLustdD/EIBMiGVB
 g9HrMAYMoifSzRT/rC4yQ46m1BvxC8Rmslipkel7PWZ2t04w9v8V5K/VawnHsrh9PDcRgFvJmYy
 1bHfokHeDyCJAYCXkM6sc6RUPih0JhNCAw3nENuE2/NphR/TSWZ6cacFSPzU1dpVwWBt03mYXLE
 b3+ky3dbA0141rGi89S5tEuf5r5qkjDsI9loEHQjrCayzVg0vjqBRE4F/V/mqemXGVYR/NTJE1U
 lYt/iXzpHrEsJfQrxF0+MUCTnWGzioFdf0OixusZ0E3ZYaYkOSjvWSuLxaxsdeo5q89iJZju0Ak
 nYFTX+YiOuK+eBU8330SaUn+Mp82P3XF1qdJabOEGzg8nmSPixc12sJLKSKtEriLeoi7PBzm/qW
 enAPlT7WWhKwp3OfnIV0kGSr6PjZDsWiSpFHQqCyqGiJgfYoAOWlxdh8hG/Si9W0wIcohAuD557
 wCcd41rgamY/lHJCLRevzVgvyCQh/mhbFli+Xrvzdob3raySiFGKr/K//AM9vk5JPDufKYtOlkS
 g72muWrr1L14k3XfeeJmt6PO4tTFD1zHoxDmJvxGkPyRzKxaWhBJyWkZ4ZGehPBun4TFRc8U55q
 L+0tDujWtaT3j6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 16 Oct 2026 11:14:07 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


