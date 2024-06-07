Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749BDC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:40:03 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbdV-00064A-0L; Fri, 07 Jun 2024 11:36:13 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFbdT-00063o-R6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFbdP-00062S-Gi
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717774566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXvc5N8I22oS7Q9Eo5sFw5nJ7ODWchcLfw1pYvhnrTE=;
 b=RyZUt2NA2ZejLRQ4v95CVX3WiZx6VIbVLGIb2PhpS6lfnwxmGENSmUBKRY3vcv5ygaTcJ9
 aMxT6rl7Fgv7EPxKG/dqsgDv2HtCPaG4WBJYOQG4pG2FFhW/OOmm1p7s4jjGiSxrZcrpic
 E+Il9lhl0ghB6tyu8bnmW67d2QIfHrM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-fdwLvwJDMUea89WlwoKgdw-1; Fri, 07 Jun 2024 11:36:04 -0400
X-MC-Unique: fdwLvwJDMUea89WlwoKgdw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dca4a8f2dso1304094f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717774563; x=1718379363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXvc5N8I22oS7Q9Eo5sFw5nJ7ODWchcLfw1pYvhnrTE=;
 b=d5DPwBh6dZW+YCr+YuETv5nO0z8PofKk6Svd4534g41rdHCOB1cmUG/tmikHNVj0mY
 137Et5bifvRoZmWJ8U/j0yXURxjJffBFr/MYcumCv8vjf2JJpzXd+92zFWtnGdIsr1co
 A8UucFCxoLCsBNxAVS6gzpcPOyCI86oIfTpks26GXna6LDqCz3VZSpsAvmrQfGeNdg+N
 roSQ7RqG7AEb6y3IxQ2UFQpYH53g4huZ9/kleKNY9EDvYEbwq+i3lUs/VXb8WG9x+Dhm
 D3y0M9hBdmVTXDTiLzEXwKFvnXHRzHkTePP48Cqkntdz8xbDacgqz9ims+aQXM4ZAxWm
 sdNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUl8/sNNlp1KJ7htnANk3abiY0PWmd1eHdZUoNtgWego+zChBQ2/0NNp/W8fHPI7UDGMXIOzlg58ac9lH2oE0wksfC470=
X-Gm-Message-State: AOJu0Yw2qoSUUOpFm2786eT02FV68TziTPPYk/xyCJfKUHNZujHfbPFI
 kK6dhWE9e75Ok5WyWOQH7EBUQb45PZzhKtyDys0QMAnKNhjhYRtnVG0174q2i+rNBeJx1bAZrlL
 7yv38mBMC0KVHu+y5TT+L+ECKcZnhd6RJO1fOviVIrN472mkmLAYMvmJ62ZLX
X-Received: by 2002:a5d:5f53:0:b0:35e:7d2b:de73 with SMTP id
 ffacd0b85a97d-35efedf2870mr2820555f8f.52.1717774563069; 
 Fri, 07 Jun 2024 08:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3fc+FaoJjmng/J9TrLyxXWMLpFj05VaT/KaRvOseo8b6ONMtsBjkthc0DieCYNyAiT0mufg==
X-Received: by 2002:a5d:5f53:0:b0:35e:7d2b:de73 with SMTP id
 ffacd0b85a97d-35efedf2870mr2820542f8f.52.1717774562676; 
 Fri, 07 Jun 2024 08:36:02 -0700 (PDT)
Received: from avogadro.local ([151.64.122.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc6d75sm4227370f8f.110.2024.06.07.08.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 08:36:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] target/i386: fixes for OS/2 Warp
Date: Fri,  7 Jun 2024 17:35:43 +0200
Message-ID: <20240607153542.2750662-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Queued, thanks (with the op->unit assignment removed, to
answer your question).

Paolo


