Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E2CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 16:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLmGg-0002VU-DV; Mon, 24 Jun 2024 12:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xoykie@gmail.com>) id 1sLki4-0001yA-CQ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:30:20 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xoykie@gmail.com>) id 1sLki2-0005Ku-6U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:30:19 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-79bd2de2157so295544485a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719239416; x=1719844216; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VveAuMVcP+jyZpYtcft3KUnMYmigpS0dcqTVQs0sDuM=;
 b=J9Y3x1lU9bc9TrXg0NUGoDs+/pgsuF6msHcZj3MeCBbA6vinQNVNBYRnr5vYYbizPV
 YoGffB7VPAy7EOMlVi73RN6xWJwDa1V3Hh5SO3Vrfu52idjF2lOv5PkOnH9xdmixqAWf
 8GcUc9Oy8h8xN3P41EPwg04MGdV1IzTGr3CxxtPFSpdy/cvNn3DEPd2DfBmm4+SjFFdy
 Oi3OU+gr6Ny5UQL2GIBwNXI6RyNoNjf27K9D/HvBpXnWmSH5pAtwKzPvLJVuWd3BLLHh
 V6wqBzow462JK4QMDUI3CFMvC28xjdOVAmLv3EkB1YkpAsHI2NWqrlQ30z7l8r2r6iDs
 plaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719239416; x=1719844216;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VveAuMVcP+jyZpYtcft3KUnMYmigpS0dcqTVQs0sDuM=;
 b=OTDUYTtsX/BYwyCEytTwX0iTteijq0GN2knRZ5wyUEnlp++fPJj+nj/7I2ASzVTZbQ
 Wo1piIT7IGiGHt142gztuQ9S2j+tW+GZVv4l60/CDSja9zEd78sz+aQUc0mL9WnWKpUM
 /4Mmxw23zhd5m3YVH0tNZctJ2fQuOUeLzFlZEa1MaKdnUuDBnIpySI/HNko1xTsMSQFB
 /WKFl2eYxiHBBftGGCz7CwA0k18dQaNE/5in/VByayEczqMH0g+BcPwasAhSas1ggppq
 u8a8oLuw5YZXfnOxxxXXTFhxmsna5HBzhsyZITFp9aTSCCczQdObM+sV7dcQSNjlb6T3
 A/7Q==
X-Gm-Message-State: AOJu0YwgsEi1sXzBC77dLOJiAgNZunX+ySwIbUQjzz2qMMFxtlFIosjT
 mAB3OaJ+HLDoUps/0hQBMKfijN8hFaI9ZLIl/MRebGTG2O7vysGRLej+6zbudpp6/MATV1XkAxJ
 tUnwysbGvzKAbqmPQiwzFRsvWh4a7NmsrNzM=
X-Google-Smtp-Source: AGHT+IEFxsrt1ZLG1SSygZX9w+GILdBkKYn/5FVC2npmuw3cqtvDPg7ZC2ckgR4c/JFujFb/4OvGAyGfjVH6VL2saHY=
X-Received: by 2002:a05:622a:1491:b0:440:ec00:fff6 with SMTP id
 d75a77b69052e-444d9215b4cmr61561291cf.41.1719239416393; Mon, 24 Jun 2024
 07:30:16 -0700 (PDT)
MIME-Version: 1.0
From: Xoykie <xoykie@gmail.com>
Date: Mon, 24 Jun 2024 20:00:04 +0530
Message-ID: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
Subject: [Bug Report] Possible Missing Endianness Conversion
To: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, thuth@redhat.com, cohuck@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=xoykie@gmail.com; helo=mail-qk1-x742.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Jun 2024 12:10:09 -0400
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

The virtio packed virtqueue support patch[1] suggests converting
endianness by lines:

virtio_tswap16s(vdev, &e->off_wrap);
virtio_tswap16s(vdev, &e->flags);

Though both of these conversion statements aren't present in the
latest qemu code here[2]

Is this intentional?

[1]: https://mail.gnu.org/archive/html/qemu-block/2019-10/msg01492.html
[2]: https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L314

