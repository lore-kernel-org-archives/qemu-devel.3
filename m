Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D69D68B02
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZLk-0003SD-0r; Thu, 14 Nov 2024 07:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLh-0003Rb-LJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLg-0005Td-Bo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gVK73iDzW3OfJu9Jct9zCzImkudRQq4L5YHEvK6r2Jc=;
 b=QpzQAy68IeewGdGvVaCH8gsFSUYlMqvbZfX1zB0Egamb3082Y1F/gBR8PC1y0tPSa+nzQK
 0f+Q6nTJxAZhxuR1rGzvEerGV7bLnjJpjSFjZvSAkb9SDRlHqUmDC65+/3QxqBlY7FeHpg
 BMIGffNSY+WfFD/pgj6eFNz7Tz18D1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-broJPkLdMW6kOmA5Qw7cmA-1; Thu, 14 Nov 2024 07:53:22 -0500
X-MC-Unique: broJPkLdMW6kOmA5Qw7cmA-1
X-Mimecast-MFC-AGG-ID: broJPkLdMW6kOmA5Qw7cmA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-381d07c377cso470189f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588800; x=1732193600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVK73iDzW3OfJu9Jct9zCzImkudRQq4L5YHEvK6r2Jc=;
 b=ESEifhCBQ3xQ2soUmEQ4SYely97qRTAiKjIRxxWflha/Nk5o1bUA8N0faBCjPaLdEl
 ra31GnXK2XY5yeQa1PO4Gob8yjzjLNAQm2s8qRD8qjySe02sRHDI/7N8CvOMlAsmJ01S
 WPB92IhHHGSapBCecC0yDY1PMG1CXvRy1nv+eosY0vke25FqmiKAVULK5cYXMy4u1ad3
 eDiKDV0xauMj1WSVWukNE5g41dBZlIUAtyLNpzn1xNCOS5YO645nuOJbk4iyp3gN7NV5
 lCcmtPruho8XhaErX/3MHtfzCSt68EM6YVIhlNPGK9PIrqjtZOw3YzX/wD8CLXeJ+SYo
 051Q==
X-Gm-Message-State: AOJu0Yzb/Mb0ioV2VrpeufrG+9S1Sh7ISlSSM3BlnZWJVW8io6HD9SMi
 tk5peJh/H5Be/8SHHVDvdtsCqOsmVG4639o6eiXKCG9QuEBx79En0pV0q1m0soGJu6BatRtpyp3
 Wipbg/AY9B7NBOJlquiCBa23pSC/QoBjEQIylr6kut7/GvYtYHsn4szoIqX8f+s3Qn1GIBPEsKh
 JKwlepuoEgdTb8Lrd/Z+LxsfhO9ZfCnBdgccuhnHE=
X-Received: by 2002:a05:6000:184f:b0:382:10dc:594b with SMTP id
 ffacd0b85a97d-3821851e4f4mr2378743f8f.34.1731588800179; 
 Thu, 14 Nov 2024 04:53:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO12n6sjeIvWzbpEsVhCqdSV514ATwW1U1ljWIbUX00lbLcmbyFN+n5NDDP1QDSg/NZ9SZrw==
X-Received: by 2002:a05:6000:184f:b0:382:10dc:594b with SMTP id
 ffacd0b85a97d-3821851e4f4mr2378715f8f.34.1731588799774; 
 Thu, 14 Nov 2024 04:53:19 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae31083sm1390646f8f.103.2024.11.14.04.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 04:53:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/2] hda-codec: reuse the audio device on format change
Date: Thu, 14 Nov 2024 13:53:16 +0100
Message-ID: <20241114125318.1707590-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 6d03242a7e47815ed56687ecd13f683d8da3f2fe fixes a memory leak
by calling hda_close_stream() when performing audio setup.  However,
hda_close_stream() closes the audio device, which is a change in
behavior because AUD_open_*() tries to keep the current device
if it's already up and configured properly.

Paolo

Paolo Bonzini (2):
  Revert "hw/audio/hda: fix memory leak on audio setup"
  hw/audio/hda: fix memory leak on audio setup

 hw/audio/hda-codec.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

-- 
2.47.0


