Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20129C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdto-0008Hp-EM; Tue, 16 Jul 2024 04:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdtj-00085W-6b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdth-0007GY-DE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dLkTbXp6uQiEncHXcl+SQMYVi5R4jpKIBhA7iA5eSf/0WlgKy0QGBZLCr2Y4sN56wmXm0H
 mEj1YRNM6f1SH+w/70SqXYCTstQZ3NMugP7SR80D4ODokpIkKPn/c21DDheYnFZMbxyYhj
 SaUNZ8nRd43L243J/VDiM4NkTdzOGUs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-zthZzZVsOdKKLa8RH1zmDg-1; Tue, 16 Jul 2024 04:50:54 -0400
X-MC-Unique: zthZzZVsOdKKLa8RH1zmDg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee8ceb0852so48626961fa.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119853; x=1721724653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qCGrT3MsObTbouNcTHWlwR2W8penqcBD34GpaveqcX/u45dbBdRuehSIMJUgDLgWye
 W+XxoCD8VR2Ms8xo82dddKKPgHm32u92ipZTY/u9v60BbkVBUiEt19YhIcMwkdw48L2+
 ZanIqKvdsIrHStpIxvAbaiemdQhwg+4blSEcrv72+3j0+pLxMgE4L/n+0OQvjohAoVEA
 RL1CBV0AoIBqqOrEG2tt/1D/s05xKaHQzLL/aQeEAKAaLtu1gZmt30WaJMUTFsnQXeUK
 x1PTohiN7Dm0J7BkyogtTQPWCAI3NFJqNCBtaWcFvXN5IrJu1pB6pVAlxA8lC1sgxUmN
 bttA==
X-Gm-Message-State: AOJu0YwGsbE22FFP4sqxuSLQ6sgNgDJneynY1k9KbXVppYY18okZEfQB
 SW1WjOF95LqZxqxV9GqIN/8VIt5fSoqNehdLvH1R38lH/1CsZI1czuV1RC5TMUHFzuw3hYwgfiJ
 +pPuIOih6RRcHCTXBsz2MADXHuu2QSzo6hcLpCktO3H1BhmU90BhK
X-Received: by 2002:a2e:958e:0:b0:2ec:56ce:d50e with SMTP id
 38308e7fff4ca-2eef4156c15mr10554711fa.3.1721119852930; 
 Tue, 16 Jul 2024 01:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9rI0mefjXTwyQBka2xRktEbijlLAcs+gkmda1I2ScCdvIoiUcDLJmIg9aN536gQNIW1JztQ==
X-Received: by 2002:a2e:958e:0:b0:2ec:56ce:d50e with SMTP id
 38308e7fff4ca-2eef4156c15mr10554581fa.3.1721119852515; 
 Tue, 16 Jul 2024 01:50:52 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e7751asm116290495e9.3.2024.07.16.01.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:50:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 qemu-stable@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH] scsi: fix regression and honor bootindex again for legacy
 drives
Date: Tue, 16 Jul 2024 10:50:34 +0200
Message-ID: <20240716085034.185829-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710152529.1737407-1-f.ebner@proxmox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


