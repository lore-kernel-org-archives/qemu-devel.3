Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B11EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqVj-0007s1-CZ; Thu, 27 Jun 2024 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVi-0007rf-0h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVg-0007Gx-6t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eCilUlbvUfqsePAXHuXTBbOPUoBRXscm+596pRVObqs=;
 b=JkGWNu3Y3+uefoogGlU3Ov9QUO6XatP7MoWq6QShGUeDw1c/RqC0tnqgykBHXq09xOivzU
 Xly2u3xzbWVChuPJ4cenax+qSYoB4rSD3dDTSbDWn4Q29oZhy6RHZd+GxipAr5NheNMfbU
 biE35liRPQq/IHvPFrkzju0wyU0NE0w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-X67vYs2TOdeqHegN67TILw-1; Thu, 27 Jun 2024 10:54:01 -0400
X-MC-Unique: X67vYs2TOdeqHegN67TILw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7194d0fd53so343089466b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500040; x=1720104840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eCilUlbvUfqsePAXHuXTBbOPUoBRXscm+596pRVObqs=;
 b=Yk20gKO6ORqvXmfuaXmatlVTWXEbOMIVtJPrZMI+8nAHaNvStOmVvIHbvqchnxMCzk
 VoLQAuc5J0q9QXWHFf3lOBsROBMzIASpa9tnTx1hM/KlOfb4x44nkDN/WOCzVVFPhV8K
 rhog8ZBmtRnE2UcStxtk6hh5Bo0DrEgUMY/mEtB2xHT9jQKpjsitFbPiI2LK074JkEHi
 pKfv814E+kwgqixl5ZpHN03ozMEXe1nrO482iUQ1lFmnXsA0P2hfBQp3XCsp2oiHqK7X
 kjNYAiX9mn5TryKC1tgCw+M4YTgYrOXnirN5+YU5aVOsMt8RfBwVHpxUQ9/CizuAiCS6
 A/kg==
X-Gm-Message-State: AOJu0Yw6OpqxkprHZGy7sxVYVLGwjV01uGybyj64QoNhc9ztgRpuWvLq
 sIOyg1BnSYsz/nkLVoUnVtDrGDOwUjWM7nYVBlXrSA7slSIlYJYmjDkD0oydLe2pG794A30L9nU
 RsLKzxcxwr8PLHoBThw2gIVl2/W6JDvewurofPkbX58aBDdkDS74cPY6E+QhZQvc71aMwMwM0jG
 ADJolDpVKpDg1dyK9Iiv4Cu/lLBRseQkBcROI8
X-Received: by 2002:a17:907:d92:b0:a72:9963:eb8e with SMTP id
 a640c23a62f3a-a729963ec80mr196286666b.28.1719500039844; 
 Thu, 27 Jun 2024 07:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8F3k80O7gPl/LblWmcT4g9Qlv+t8SdWnDddVXCIMlHJAtgNQGaA1OVB50Z1U9P55F8cF1mg==
X-Received: by 2002:a17:907:d92:b0:a72:9963:eb8e with SMTP id
 a640c23a62f3a-a729963ec80mr196285666b.28.1719500039447; 
 Thu, 27 Jun 2024 07:53:59 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d721070sm66824566b.89.2024.06.27.07.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:53:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 0/5] target/i386: SEV: fix compiler warnings on 32-bit hosts
Date: Thu, 27 Jun 2024 16:53:52 +0200
Message-ID: <20240627145357.1038664-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

While SEV in practice is unlikely to be used when compiling for 32-bit
environments (it is not even supported by 32-bit kernels), it is easier
and/or nicer to clean up the warts that block compilation, than to add
conditionals in the build system to limit it to 64-bit hosts.

Paolo

Paolo Bonzini (5):
  target/i386: SEV: rename sev_snp_guest->id_block
  target/i386: SEV: store pointer to decoded id_block in SevSnpGuest
  target/i386: SEV: rename sev_snp_guest->id_auth
  target/i386: SEV: store pointer to decoded id_auth in SevSnpGuest
  target/i386: SEV: fix format strings for 32-bit hosts

 target/i386/sev.c | 52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

-- 
2.45.2


