Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FDCC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnw1-0000d9-FN; Tue, 13 Aug 2024 05:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdnvs-00005m-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sdnvq-0007vU-6a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723541708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EgVkyAdWquwkke+02tUVxbHC0ymj0/mv6yiVdeTPL6fnOK6tBx+EnAFgzUUFIbC/qoc7eV
 T2STUc7ulsDAyFsG0IiUSrepU76aLu6VbRAl1AsRX2n5ikUHdnpgp+K4MeyrzF8B9r7+PS
 80/2iXfWUVB9k5TjYoFJF69z/T633L4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-gihwziS9NZadjlJg7nL8BA-1; Tue, 13 Aug 2024 05:35:06 -0400
X-MC-Unique: gihwziS9NZadjlJg7nL8BA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa7e86b5eso437547066b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723541705; x=1724146505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=vig02kIOOWrkDcJiagAjw8jumhCq4T95orMkA6hZUv5ouN8h4JykutlmNsku5k4NVO
 nkDi7p7gCa6KMHaBzhHYeh+s3tFxztY50DOm3h31eQnAJ0fvcW9h/ZNPAXRUc6jXSnCN
 +upiAJlkgwhwjv0eZOmFTWsJoBJqImA/HZAQVe8UGPMSX251EKPp4Sbx0B398mOe3DjB
 kD4h06xlBziVWoCqiO6Xapf7J+LZciVkpEmJAFoQrdVcgYYngXxLfmrIeRnrknyR5A1K
 cRrpWitA30U7x+2GPQSKvno3nKB+SCT8OcYKtqsEAKktM5SGakCNkTpyUt8bmXr1zl3R
 OG0Q==
X-Gm-Message-State: AOJu0Ywak8lrspJ7khppH8hJxKn5AH7bqIX5+gfJxFfpx202ZHQVS4Qg
 AgpwkA9VafU+MnAaPhkTt5I5Hs4SE1l/DzUgk2g5f50qDpkhnTUBIsNnKnRh5zrDW8uKJZUnZik
 2p5xfq5wiSy6J7LSKGxJHzTO+/5ee0d69Je+aC2zlWo9dBzuA9Uao
X-Received: by 2002:a17:906:6a25:b0:a7a:ab1a:2d64 with SMTP id
 a640c23a62f3a-a80ed2d473fmr229574266b.58.1723541704982; 
 Tue, 13 Aug 2024 02:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT2hcopeuyowGn+hKmecBbwSFLnPKyTRMme6cvf8eKlb+lZBdNe1A4Qt+8CuifYXzA4lAZRw==
X-Received: by 2002:a17:906:6a25:b0:a7a:ab1a:2d64 with SMTP id
 a640c23a62f3a-a80ed2d473fmr229571966b.58.1723541704562; 
 Tue, 13 Aug 2024 02:35:04 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f4cfcesm53367666b.2.2024.08.13.02.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:35:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH for-9.1 0/3] target/i386: Do not apply REX to MMX operands
Date: Tue, 13 Aug 2024 11:35:02 +0200
Message-ID: <20240813093502.32038-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812025844.58956-1-richard.henderson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


