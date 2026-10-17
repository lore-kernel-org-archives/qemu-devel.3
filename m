Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C7CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01l-0002C4-7X; Sat, 17 Oct 2026 04:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01U-0001xX-5m
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01S-0007Cn-H6
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vGLC08GgdrFKjqmuFAMPiySrklXfHzc5UdCUku8wZQ=;
 b=gGIhnP26W5fi4BPI5trA0Kb+v7Joea1NDm7RoSbCExDQckaxONDxjfbCWMFVD/mAQTUcT2
 y/rYgwzNM2Aj83zjij8sRkV7J2l5i63zl2ZpphTdn9QqFSdrr8s2kILm0keEDVBO2scgOC
 FtIqBsWVSHLigkMK1QTuUkReq0TryaM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-xb3HGP60OE-5707wRioE2Q-1; Sat,
 17 Oct 2026 08:44:03 +0000
X-MC-Unique: xb3HGP60OE-5707wRioE2Q-1
X-Mimecast-MFC-AGG-ID: xb3HGP60OE-5707wRioE2Q_1792226642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 631811955DD1; Sat, 17 Oct 2026 08:44:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A9721956087; Sat, 17 Oct 2026 08:44:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 19/23] target/riscv: implement get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-20-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-20-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656909.1619676.16368059821805536625.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZXBBSm/RlXumhiTEDJ2rKrvCmIMoRsrla9bnMR+299Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNE95ZfcGwOG7T/sQWruOTgwqoixDxG5b05
 s0xBus5G32JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5frQD/9AlxT0rHp3EMFMCVSAXpzmapKNzWYBggWgl26KWTI3E/Kz20u0xf/9+hnrgzblJM8mT1b
 ZdG2Xyoee1F2U2FMMtXTsHdVnJhdG8eIv8BsdPl8rplIWMHKbbjhP63l3sW+q/s0Bvlic6VRzay
 WNzmXGZtG581Nk4m/PlKH2xOtCtqBzaKckwjYtuMQkfEH/8mVDEnEgc7QKVyBA6L8At8srj78Ec
 PxYi8sjDQi2hxQU07aWU84oi3loWhS9Eo/ZD6biuxs9uk0vyRt2W+vWQ4Jn0rJIIniGevbKFHAz
 +dW+J7C83qsG0ipuXtXPVB8eE8avPlZ/PuPwJksCEy/mK9mjTig1LXVSR26fJSVigVNrTQlOlo/
 2YPeDQvn+oFYlkwqziGqHg2p7z8gAFGriW6I/C09t95gbZn83401PEVIQB61/tdoTBPgLDgspHI
 zHqTE0iUmYW1LEU/8HjwesAi4LmgLtfDppGXs0dlHzWV/MOzddfMOtbzXIWF7SrdFmFVJXR1OH0
 Oxv02B3w+ZwtAGo6CJ+I1eSM8pBU/h5TVvcuOAJOZGBOuw/AmqdY7VaZakuGy76/Bk1NnPO5xmn
 3bp2zSHzuJUw/iCjFcl3HKcFwYwZVJ8NC0PTHF4HfDZ6PPLQ8LEXB9L61Mc/VP2Gm77mR7vUx5G
 FKrVhzYncDRSN3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 16 Oct 2026 11:14:06 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


