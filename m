Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA632C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtIW-0004pC-Mv; Wed, 20 Mar 2024 06:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtIU-0004oy-S5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtIT-0005Wn-It
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cGFf3sq+aA+RcpEHzLLhgEAw2y27FTKauCeC8CcmOIwAlDh1OhNw5BG/Cyi2pqot4I20di
 P4sTNWn/mD7zflPN3A65AYuLOFjyceb9YsJ53sVxVXYirkm/kFf54chWK2lXCYqPpxTzz8
 ry/5G8HJsGMjdZBOaDSt0Qv45afOjsQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Zdh_9UokPF-0OKyUbFTLsQ-1; Wed, 20 Mar 2024 06:35:46 -0400
X-MC-Unique: Zdh_9UokPF-0OKyUbFTLsQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a46d55f5d64so139021166b.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930945; x=1711535745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=v+2/S/1l1h8Lf04onvUWXhWRqma0xcQ4n8sbKeGZ+CFpNOML5PzJNck7WtfMCIr2V0
 prQ5QEXZmouY/qXwYyqzCbmv0jTc06W3gbyTJjLy/k8m0fYFPFObEbKDXxMGUfS2F6W0
 8AyMgpsmAuCexUDcOtBYxE+Mg+Yu4ZSD9BhFoIiJ1OSMlZfmNN4+F2RZt+3c+B5xe6Ej
 ZqKqW+8LUsTrCC/kJxJBKMLEu7gPyVbkDlSs+fkXzg6mwAMxAAlworTYuoV4mmpUC+Sj
 MYzD82Si9y1xHvfQNvoJZs7r7kEKTkwjOBy3jq6s0Cxx+Gmvzwaif3dvFNdQ+LwkfISd
 CcBA==
X-Gm-Message-State: AOJu0YyrNe+2ZnKEEQP7rfEnr9v7yUqRougOz2Hj3OwoN8UpHvzE4DOv
 ahULHbEGKTNryoxnyZBYC78lf1CEiNA7PAKzPeXau3cs1HoIYDT2EjqQ/12Ce5Dgchg+VQfYGBo
 reyyAckcvQvdUHTUssl8GRHGEsLOUhbaKWd3Dh6lbl7xKz+eX/zKt
X-Received: by 2002:a17:906:2310:b0:a46:b028:7dc8 with SMTP id
 l16-20020a170906231000b00a46b0287dc8mr3964286eja.50.1710930945387; 
 Wed, 20 Mar 2024 03:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4EAwPZDJMfEhXNC0mpFlHEpuYmQ36SSj7qBQ6BfLcaPWQYcSv5eJYiz96PD+FeCUDKjDdeA==
X-Received: by 2002:a17:906:2310:b0:a46:b028:7dc8 with SMTP id
 l16-20020a170906231000b00a46b0287dc8mr3964275eja.50.1710930945105; 
 Wed, 20 Mar 2024 03:35:45 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 dk4-20020a170907940400b00a46ab207f68sm4713335ejc.134.2024.03.20.03.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:35:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: qemu-devel@nongnu.org, Chao Gao <chao.gao@intel.com>,
 antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Date: Wed, 20 Mar 2024 11:35:43 +0100
Message-ID: <20240320103543.1048775-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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


