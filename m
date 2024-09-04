Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD25CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpVv-0003qr-Of; Wed, 04 Sep 2024 08:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpVq-0003Yg-TG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpVo-0003YC-3Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725454404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AK1E8+EAHW5gSDMY3Y5h55K+MH8zsmIWUodH1KF+X20b3AObMg53FN/CRbQGDeSLdix637
 IABOAoivFMEIBl01nkT9qRlhDH/kC6RBX+sDvjWwoKRmSy7Dn9g6kjW2ynAaUF/uEIaM3I
 G9akcbMqwDX0ZKd4wVGVbxfZqNgQy1k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-vKxlkvCvP4WQE7ilVCwUTg-1; Wed, 04 Sep 2024 08:53:23 -0400
X-MC-Unique: vKxlkvCvP4WQE7ilVCwUTg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so548845566b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725454402; x=1726059202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dpxpZge9zueNOnj0NfGeZdLcISlJsjZ8D5pi81ZkH1WJDX99pEm6LNcDwfmzUipqic
 0xTD2Bd86Wrr+yuipcB/1oFC8PTOIXO7xVEqeNx0JpOzSPBO9MSPT2837o7glnlYqAy3
 5y56Tlfg+ED4GEE4c5jeYDaO9A20qCguOVMVQAiTnfcS39tYisOAe4uXvTZw19Tb3nIq
 2R1G3ZYmtKRv0Nr2d/x3pO3KoijOVz7G8CsjfrKGBZ0sqAezFSXFOABmLKNe/hcf3POn
 O1PqI2eOxSc74KYP4YS0lZ/nzSUf1VYApYgV9IyTQZMS+V8EopxXEiQ5giyZCpkcsrs1
 Q6IQ==
X-Gm-Message-State: AOJu0YwkqU40yOdiKPnSCuoP5kPG3jtb821mVzWFUAeHodN3Lbsaw2q6
 WZp7TYNIAdjdMaC9s2P2oedNR6lRXfbfR4M0xXYudrx29fLxwzz0Qk4VQxhly7zubB3K7PY+7Ry
 wSQFa68f+8Sp2ynNtavUAkfimAVnUZUGk3ytVFr7ZYbZd7jznLwaR
X-Received: by 2002:a17:907:7ba8:b0:a86:a178:42da with SMTP id
 a640c23a62f3a-a8a32e7404emr343971066b.21.1725454401903; 
 Wed, 04 Sep 2024 05:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbKct+jlJjAEI8mzE8tQM3uX6RsaOkfskxiWNdxgE7gL+0bS4isM+g/piCwpOj/86CPDNxw==
X-Received: by 2002:a17:907:7ba8:b0:a86:a178:42da with SMTP id
 a640c23a62f3a-a8a32e7404emr343968666b.21.1725454401354; 
 Wed, 04 Sep 2024 05:53:21 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f62fsm806127766b.63.2024.09.04.05.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:53:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, jpoimboe@kernel.org,
 Babu Moger <babu.moger@amd.com>, Dario Faggioli <dfaggioli@suse.com>,
 Fabian Vogt <fvogt@suse.de>, Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH] target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to
 the guest
Date: Wed,  4 Sep 2024 14:53:19 +0200
Message-ID: <20240904125319.293854-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805202041.5936-1-farosas@suse.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


